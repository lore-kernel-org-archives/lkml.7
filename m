Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38E2C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 03:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A6820851
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 03:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfCIDVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 22:21:48 -0500
Received: from mx.sdf.org ([205.166.94.20]:51593 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbfCIDVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 22:21:45 -0500
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Mar 2019 22:20:48 EST
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x293D1fK029968
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Sat, 9 Mar 2019 03:13:01 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x293D0hP029314;
        Sat, 9 Mar 2019 03:13:00 GMT
Message-Id: <dd447448384883bd42c41f0de6a83430b6435dc1.1552097842.git.lkml@sdf.org>
In-Reply-To: <cover.1552097842.git.lkml@sdf.org>
References: <cover.1552097842.git.lkml@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Tue, 5 Mar 2019 03:06:44 +0000
Subject: [PATCH 4/5] lib/list_sort: Simplify and remove MAX_LIST_LENGTH_BITS
To:     linux-kernel@vger.kernel.org
Cc:     George Spelvin <lkml@sdf.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Abramov <st5pub@yandex.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Don Mullis <don.mullis@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than a fixed-size array of pending sorted runs, use the ->prev
links to keep track of things.  This reduces stack usage, eliminates
some ugly overflow handling, and reduces the code size.

Also:
* merge() no longer needs to handle NULL inputs, so simplify.
* The same applies to merge_and_restore_back_links(), which is renamed
  to the less ponderous merge_final().  (It's a static helper function,
  so we don't need a super-descriptive name; comments will do.)

x86-64 code size 1086 -> 740 bytes (-346)

(Yes, I see checkpatch complaining about no space after comma in
"__attribute__((nonnull(2,3,4,5)))".  Checkpatch is wrong.)

Signed-off-by: George Spelvin <lkml@sdf.org>
---
 include/linux/list_sort.h |   1 +
 lib/list_sort.c           | 152 ++++++++++++++++++++++++--------------
 2 files changed, 96 insertions(+), 57 deletions(-)

diff --git a/include/linux/list_sort.h b/include/linux/list_sort.h
index ba79956e848d..20f178c24e9d 100644
--- a/include/linux/list_sort.h
+++ b/include/linux/list_sort.h
@@ -6,6 +6,7 @@
 
 struct list_head;
 
+__attribute__((nonnull(2,3)))
 void list_sort(void *priv, struct list_head *head,
 	       int (*cmp)(void *priv, struct list_head *a,
 			  struct list_head *b));
diff --git a/lib/list_sort.c b/lib/list_sort.c
index 85759928215b..e4819ef0426b 100644
--- a/lib/list_sort.c
+++ b/lib/list_sort.c
@@ -7,33 +7,47 @@
 #include <linux/list_sort.h>
 #include <linux/list.h>
 
-#define MAX_LIST_LENGTH_BITS 20
+/*
+ * By declaring the compare function with the __pure attribute, we give
+ * the compiler more opportunity to optimize.  Ideally, we'd use this in
+ * the prototype of list_sort(), but that would involve a lot of churn
+ * at all call sites, so just cast the function pointer passed in.
+ */
+typedef int __pure __attribute__((nonnull(2,3))) (*cmp_func)(void *,
+		struct list_head const *, struct list_head const *);
 
 /*
  * Returns a list organized in an intermediate format suited
  * to chaining of merge() calls: null-terminated, no reserved or
  * sentinel head node, "prev" links not maintained.
  */
-static struct list_head *merge(void *priv,
-				int (*cmp)(void *priv, struct list_head *a,
-					struct list_head *b),
+__attribute__((nonnull(2,3,4)))
+static struct list_head *merge(void *priv, cmp_func cmp,
 				struct list_head *a, struct list_head *b)
 {
-	struct list_head head, *tail = &head;
+	struct list_head *head, **tail = &head;
 
-	while (a && b) {
+	for (;;) {
 		/* if equal, take 'a' -- important for sort stability */
-		if ((*cmp)(priv, a, b) <= 0) {
-			tail->next = a;
+		if (cmp(priv, a, b) <= 0) {
+			*tail = a;
+			tail = &a->next;
 			a = a->next;
+			if (!a) {
+				*tail = b;
+				break;
+			}
 		} else {
-			tail->next = b;
+			*tail = b;
+			tail = &b->next;
 			b = b->next;
+			if (!b) {
+				*tail = a;
+				break;
+			}
 		}
-		tail = tail->next;
 	}
-	tail->next = a?:b;
-	return head.next;
+	return head;
 }
 
 /*
@@ -43,44 +57,52 @@ static struct list_head *merge(void *priv,
  * prev-link restoration pass, or maintaining the prev links
  * throughout.
  */
-static void merge_and_restore_back_links(void *priv,
-				int (*cmp)(void *priv, struct list_head *a,
-					struct list_head *b),
-				struct list_head *head,
-				struct list_head *a, struct list_head *b)
+__attribute__((nonnull(2,3,4,5)))
+static void merge_final(void *priv, cmp_func cmp, struct list_head *head,
+			struct list_head *a, struct list_head *b)
 {
 	struct list_head *tail = head;
 	u8 count = 0;
 
-	while (a && b) {
+	for (;;) {
 		/* if equal, take 'a' -- important for sort stability */
-		if ((*cmp)(priv, a, b) <= 0) {
+		if (cmp(priv, a, b) <= 0) {
 			tail->next = a;
 			a->prev = tail;
+			tail = a;
 			a = a->next;
+			if (!a)
+				break;
 		} else {
 			tail->next = b;
 			b->prev = tail;
+			tail = b;
 			b = b->next;
+			if (!b) {
+				b = a;
+				break;
+			}
 		}
-		tail = tail->next;
 	}
-	tail->next = a ? : b;
 
+	/* Finish linking remainder of list b on to tail */
+	tail->next = b;
 	do {
 		/*
-		 * In worst cases this loop may run many iterations.
+		 * If the merge is highly unbalanced (e.g. the input is
+		 * already sorted), this loop may run many iterations.
 		 * Continue callbacks to the client even though no
 		 * element comparison is needed, so the client's cmp()
 		 * routine can invoke cond_resched() periodically.
 		 */
-		if (unlikely(!(++count)))
-			(*cmp)(priv, tail->next, tail->next);
-
-		tail->next->prev = tail;
-		tail = tail->next;
-	} while (tail->next);
+		if (unlikely(!++count))
+			cmp(priv, b, b);
+		b->prev = tail;
+		tail = b;
+		b = b->next;
+	} while (b);
 
+	/* And the final links to make a circular doubly-linked list */
 	tail->next = head;
 	head->prev = tail;
 }
@@ -91,55 +113,71 @@ static void merge_and_restore_back_links(void *priv,
  * @head: the list to sort
  * @cmp: the elements comparison function
  *
- * This function implements "merge sort", which has O(nlog(n))
- * complexity.
+ * This function implements a bottom-up merge sort, which has O(nlog(n))
+ * complexity.  We use depth-first order to take advantage of cacheing.
+ * (I.e. when we get to the fourth element, we immediately merge the
+ * first two 2-element lists.)
  *
  * The comparison function @cmp must return a negative value if @a
  * should sort before @b, and a positive value if @a should sort after
  * @b. If @a and @b are equivalent, and their original relative
  * ordering is to be preserved, @cmp must return 0.
+ *
+ * (Actually, it is always called with @a being the element which was
+ * originally first, so it is not necessary to to distinguish the @a < @b
+ * and @a == @b cases; the return value may be a simple boolean.  But if
+ * you ever *use* this freedom, be sure to update this comment to document
+ * that code now depends on preserving this property!)
  */
+__attribute__((nonnull(2,3)))
 void list_sort(void *priv, struct list_head *head,
 		int (*cmp)(void *priv, struct list_head *a,
 			struct list_head *b))
 {
-	struct list_head *part[MAX_LIST_LENGTH_BITS+1]; /* sorted partial lists
-						-- last slot is a sentinel */
-	int lev;  /* index into part[] */
-	int max_lev = 0;
-	struct list_head *list;
+	struct list_head *list = head->next, *pending = NULL;
+	size_t count = 0;	/* Count of pending */
 
-	if (list_empty(head))
+	if (list == head->prev)	/* Zero or one elements */
 		return;
 
-	memset(part, 0, sizeof(part));
-
+	/* Convert to a null-terminated singly-linked list. */
 	head->prev->next = NULL;
-	list = head->next;
 
-	while (list) {
+	/*
+	 * Data structure invariants:
+	 * - All lists are singly linked and null-terminated; prev
+	 *   pointers are not maintained.
+	 * - pending is a prev-linked "list of lists" of sorted
+	 *   sublists awaiting further merging.
+	 * - Sublists are sorted by size and age, smallest & newest at front.
+	 * - All of the sorted sublists are power-of-two in size,
+	 *   corresponding to bits set in "count".
+	 */
+	do {
+		size_t bit;
 		struct list_head *cur = list;
+
+		/* Extract the head of "list" as a single-element list "cur" */
 		list = list->next;
 		cur->next = NULL;
 
-		for (lev = 0; part[lev]; lev++) {
-			cur = merge(priv, cmp, part[lev], cur);
-			part[lev] = NULL;
+		/* Do merges corresponding to set lsbits in count */
+		for (bit = 1; count & bit; bit <<= 1) {
+			cur = merge(priv, (cmp_func)cmp, pending, cur);
+			pending = pending->prev;  /* Untouched by merge() */
 		}
-		if (lev > max_lev) {
-			if (unlikely(lev >= ARRAY_SIZE(part)-1)) {
-				printk_once(KERN_DEBUG "list too long for efficiency\n");
-				lev--;
-			}
-			max_lev = lev;
-		}
-		part[lev] = cur;
+		/* And place the result at the head of "pending" */
+		cur->prev = pending;
+		pending = cur;
+		count++;
+	} while (list->next);
+
+	/* Now merge together last element with all pending lists */
+	while (pending->prev) {
+		list = merge(priv, (cmp_func)cmp, pending, list);
+		pending = pending->prev;
 	}
-
-	for (lev = 0; lev < max_lev; lev++)
-		if (part[lev])
-			list = merge(priv, cmp, part[lev], list);
-
-	merge_and_restore_back_links(priv, cmp, head, part[max_lev], list);
+	/* The final merge, rebuilding prev links */
+	merge_final(priv, (cmp_func)cmp, head, pending, list);
 }
 EXPORT_SYMBOL(list_sort);
-- 
2.20.1

