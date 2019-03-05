Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEE7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E96E218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfCPDxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 23:53:30 -0400
Received: from ol.sdf.org ([205.166.94.20]:60200 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfCPDx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 23:53:29 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2G3pIg1023876
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Sat, 16 Mar 2019 03:51:18 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2G3pIBa014404;
        Sat, 16 Mar 2019 03:51:18 GMT
Message-Id: <f63c410e0ff76009c9b58e01027e751ff7fdb749.1552704199.git.lkml@sdf.org>
In-Reply-To: <cover.1552704199.git.lkml@sdf.org>
References: <cover.1552704199.git.lkml@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Tue, 5 Mar 2019 03:06:44 +0000
Subject: [PATCH v2 4/5] lib/list_sort: Simplify and remove MAX_LIST_LENGTH_BITS
To:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     George Spelvin <lkml@sdf.org>, Andrey Abramov <st5pub@yandex.ru>,
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
* Document the actual return value requirements on the (*cmp)()
  function; some callers are already using this feature.

x86-64 code size 1086 -> 739 bytes (-347)

(Yes, I see checkpatch complaining about no space after comma in
"__attribute__((nonnull(2,3,4,5)))".  Checkpatch is wrong.)

Signed-off-by: George Spelvin <lkml@sdf.org>
Acked-by: Andrey Abramov <st5pub@yandex.ru>
Feedback-from: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Feedback-from: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Feedback-from: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/linux/list_sort.h |   1 +
 lib/list_sort.c           | 169 ++++++++++++++++++++++++--------------
 2 files changed, 109 insertions(+), 61 deletions(-)

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
index 85759928215b..fc807dd60a51 100644
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
@@ -91,55 +113,80 @@ static void merge_and_restore_back_links(void *priv,
  * @head: the list to sort
  * @cmp: the elements comparison function
  *
- * This function implements "merge sort", which has O(nlog(n))
- * complexity.
+ * This function implements a bottom-up merge sort, which has O(nlog(n))
+ * complexity.  We use depth-first order to take advantage of cacheing.
+ * (E.g. when we get to the fourth element, we immediately merge the
+ * first two 2-element lists.)
  *
- * The comparison function @cmp must return a negative value if @a
- * should sort before @b, and a positive value if @a should sort after
- * @b. If @a and @b are equivalent, and their original relative
- * ordering is to be preserved, @cmp must return 0.
+ * The comparison funtion @cmp must return > 0 if @a should sort after
+ * @b ("@a > @b" if you want an ascending sort), and <= 0 if @a should
+ * sort before @b *or* their original order should be preserved.  It is
+ * always called with the element that came first in the input in @a,
+ * and list_sort is a stable sort, so it is not necessary to distinguish
+ * the @a < @b and @a == @b cases.
+ *
+ * This is compatible with two styles of @cmp function:
+ * - The traditional style which returns <0 / =0 / >0, or
+ * - Returning a boolean 0/1.
+ * The latter offers a chance to save a few cycles in the comparison
+ * (which is used by e.g. plug_ctx_cmp() in block/blk-mq.c).
+ *
+ * A good way to write a multi-word comparison is
+ *	if (a->high != b->high)
+ *		return a->high > b->high;
+ *	if (a->middle != b->middle)
+ *		return a->middle > b->middle;
+ *	return a->low > b->low;
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
+	 * - Each of the sorted sublists is power-of-two in size,
+	 *   corresponding to bits set in "count".
+	 * - Sublists are sorted by size and age, smallest & newest at front.
+	 */
+	do {
+		size_t bits;
 		struct list_head *cur = list;
+
+		/* Extract the head of "list" as a single-element list "cur" */
 		list = list->next;
 		cur->next = NULL;
 
-		for (lev = 0; part[lev]; lev++) {
-			cur = merge(priv, cmp, part[lev], cur);
-			part[lev] = NULL;
+		/* Do merges corresponding to set lsbits in count */
+		for (bits = count; bits & 1; bits >>= 1) {
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

