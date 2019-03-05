Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C9AC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 03:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B19020851
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 03:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sdf.org header.i=@sdf.org header.b="kTvq0LyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfCIDVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 22:21:53 -0500
Received: from mx.sdf.org ([205.166.94.20]:51593 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbfCIDVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 22:21:46 -0500
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Mar 2019 22:20:48 EST
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x293DDMO006159
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Sat, 9 Mar 2019 03:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdf.org; s=default;
        t=1552101200; bh=BnqYVy1Fc9QRgQX5l4bXmtklwkiHadBdY0IeVWDDvCk=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc;
        b=kTvq0LyPbnF+UG/u2pS2IOJgADi2qP+V7GSgXbrrE9oAEzcMPxlKF7jC37CA6rphF
         RZhL26S+vzPnBlyzGJA25GVdjqO9nyUL1wkAkwfvwzg7pOFwRK/y4BWSnyIJ223dY3
         n6whwxiAqcastcEd8+0R8R2znwPewaVJhejsDrM4=
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x293DDhO011919;
        Sat, 9 Mar 2019 03:13:13 GMT
Message-Id: <b36187f091acc1b3a8fc1fc3e9dbb6eca56231a9.1552097842.git.lkml@sdf.org>
In-Reply-To: <cover.1552097842.git.lkml@sdf.org>
References: <cover.1552097842.git.lkml@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Tue, 5 Mar 2019 05:58:46 +0000
Subject: [PATCH 5/5] lib/list_sort: Optimize number of calls to comparison
 function
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

CONFIG_RETPOLINE has severely degraded indirect function call
performance, so it's worth putting some effort into reducing
the number of times cmp() is called.

This patch avoids badly unbalanced merges on unlucky input sizes.
It slightly increases the code size, but saves an average of 0.2*n
calls to cmp().

x86-64 code size 740 -> 820 bytes (+80)

Unfortunately, there's not a lot of low-hanging fruit in a merge sort;
it already performs only n*log2(n) - K*n + O(1) compares.  The leading
coefficient is already the lowest theoretically possible (log2(n!)
corresponds to K=1.4427), so we're fighting over the linear term, and
the best mergesort can do is K=1.2645, achieved when n is a power of 2.

The differences between mergesort variants appear when n is *not*
a power of 2; K is a function of the fractional part of log2(n).
Top-down mergesort does best of all, achieving a minimum K=1.2408, and
an average (over all sizes) K=1.248.  However, that requires knowing the
number of entries to be sorted ahead of time, and making a full pass
over the input to count it conflicts with a second performance goal,
which is cache blocking.

Obviously, we have to read the entire list into L1 cache at some point,
and performance is best if it fits.  But if it doesn't fit, each full
pass over the input causes a cache miss per element, which is undesirable.

While textbooks explain bottom-up mergesort as a succession of merging
passes, practical implementations do merging in depth-first order:
as soon as two lists of the same size are available, they are merged.
This allows as many merge passes as possible to fit into L1; only the
final few merges force cache misses.

This cache-friendly depth-first merge order depends on us merging the
beginning of the input as much as possible before we've even seen the
end of the input (and thus know its size).

The simple eager merge pattern causes bad performance when n is just
over a power of 2.  If n=1028, the final merge is between 1024- and
4-element lists, which is wasteful of comparisons.  (This is actually
worse on average than n=1025, because a 1204:1 merge will, on average,
end after 512 compares, while 1024:4 will walk 4/5 of the list.)

Because of this, bottom-up mergesort achieves K < 0.5 for such sizes,
and has an average (over all sizes) K of around 1.  (My experiments
show K=1.01, while theory predicts K=0.965.)

There are "worst-case optimal" variants of bottom-up mergesort which
avoid this bad performance, but the algorithms given in the literature,
such as queue-mergesort and boustrodephonic mergesort, depend on the
breadth-first multi-pass structure that we are trying to avoid.

This implementation is as eager as possible while ensuring that all merge
passes are at worst 1:2 unbalanced.  This achieves the same average
K=1.207 as queue-mergesort, which is 0.2*n better then bottom-up, and
only 0.04*n behind top-down mergesort.

Specifically, it merges two lists of size 2^k as soon as it is known
that there are 2^k additional inputs following.  This ensures that the
final uneven merges triggered by reaching the end of the input will be
at worst 2:1.  This will avoid cache misses as long as 3*2^k elements
fit into the cache.

(I confess to being more than a little bit proud of how clean this
code turned out.  It took a lot of thinking, but the resultant inner
loop is very simple and efficient.)

Refs:
  Bottom-up Mergesort: A Detailed Analysis
  Wolfgang Panny, Helmut Prodinger
  Algorithmica 14(4):340--354, October 1995
  https://doi.org/10.1007/BF01294131
  https://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.6.5260

  The cost distribution of queue-mergesort, optimal mergesorts, and
  power-of-two rules
  Wei-Mei Chen, Hsien-Kuei Hwang, Gen-Huey Chen
  Journal of Algorithms 30(2); Pages 423--448, February 1999
  https://doi.org/10.1006/jagm.1998.0986
  https://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.4.5380

  Queue-Mergesort
  Mordecai J. Golin, Robert Sedgewick
  Information Processing Letters, 48(5):253--259, 10 December 1993
  https://doi.org/10.1016/0020-0190(93)90088-q
  https://sci-hub.tw/10.1016/0020-0190(93)90088-Q

Signed-off-by: George Spelvin <lkml@sdf.org>
---
 lib/list_sort.c | 111 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 88 insertions(+), 23 deletions(-)

diff --git a/lib/list_sort.c b/lib/list_sort.c
index e4819ef0426b..06df9b283c40 100644
--- a/lib/list_sort.c
+++ b/lib/list_sort.c
@@ -113,11 +113,6 @@ static void merge_final(void *priv, cmp_func cmp, struct list_head *head,
  * @head: the list to sort
  * @cmp: the elements comparison function
  *
- * This function implements a bottom-up merge sort, which has O(nlog(n))
- * complexity.  We use depth-first order to take advantage of cacheing.
- * (I.e. when we get to the fourth element, we immediately merge the
- * first two 2-element lists.)
- *
  * The comparison function @cmp must return a negative value if @a
  * should sort before @b, and a positive value if @a should sort after
  * @b. If @a and @b are equivalent, and their original relative
@@ -128,6 +123,57 @@ static void merge_final(void *priv, cmp_func cmp, struct list_head *head,
  * and @a == @b cases; the return value may be a simple boolean.  But if
  * you ever *use* this freedom, be sure to update this comment to document
  * that code now depends on preserving this property!)
+ *
+ * This mergesort is as eager as possible while always performing at least
+ * 2:1 balanced merges.  Given two pending sublists of size 2^k, they are
+ * merged to a size-2^(k+1) list as soon as we have 2^k following elements.
+ *
+ * Thus, it will avoid cache thrashing as long as 3*2^k elements can
+ * fit into the cache.  Not quite as good as a fully-eager bottom-up
+ * mergesort, but it does use 0.2*n fewer comparisons, so is faster in
+ * the common case that everything fits into L1.
+ *
+ *
+ * The merging is controlled by "count", the number of elements in the
+ * pending lists.  This is beautiully simple code, but rather subtle.
+ *
+ * Each time we increment "count", we set one bit (bit k) and clear
+ * bits k-1 .. 0.  Each time this happens (except the very first time
+ * for each bit, when count increments to 2^k), we merge two lists of
+ * size 2^k into one list of size 2^(k+1).
+ *
+ * This merge happens exactly when the count reaches an odd multiple of
+ * 2^k, which is when we have 2^k elements pending in smaller lists,
+ * so it's safe to merge away two lists of size 2^k.
+ *
+ * After this happens twice, we have created two lists of size 2^(k+1),
+ * which will be merged into a list of size 2^(k+2) before we create
+ * a third list of size 2^(k+1), so there are never more than two pending.
+ *
+ * The number of pending lists of size 2^k is determined by the
+ * state of bit k of "count" plus two extra pieces of information:
+ * - The state of bit k-1 (when k == 0, consider bit -1 always set), and
+ * - Whether the higher-order bits are zero or non-zero (i.e.
+ *   is count >= 2^(k+1)).
+ * There are six states we distinguish.  "x" represents some arbitrary
+ * bits, and "y" represents some arbitrary non-zero bits:
+ * 0:  00x: 0 pending of size 2^k;           x pending of sizes < 2^k
+ * 1:  01x: 0 pending of size 2^k; 2^(k-1) + x pending of sizes < 2^k
+ * 2: x10x: 0 pending of size 2^k; 2^k     + x pending of sizes < 2^k
+ * 3: x11x: 1 pending of size 2^k; 2^(k-1) + x pending of sizes < 2^k
+ * 4: y00x: 1 pending of size 2^k; 2^k     + x pending of sizes < 2^k
+ * 5: y01x: 2 pending of size 2^k; 2^(k-1) + x pending of sizes < 2^k
+ * (merge and loop back to state 2)
+ *
+ * Note in particular that just before incrementing from state 5 to
+ * state 2, all lower-order bits are 11 (state 3) so there is one list
+ * of each smaller size.
+ *
+ * When we reach the end of the input, we merge all the pending
+ * lists, from smallest to largest.  If you work through cases 2 to
+ * 5 above, you can see that the number of elements we merge with a list
+ * of size 2^k varies from 2^(k-1) (cases 3 and 5 when x == 0) to
+ * 2^(k+1) - 1 (second merge of case 5 when x == 2^(k-1) - 1).
  */
 __attribute__((nonnull(2,3)))
 void list_sort(void *priv, struct list_head *head,
@@ -150,32 +196,51 @@ void list_sort(void *priv, struct list_head *head,
 	 * - pending is a prev-linked "list of lists" of sorted
 	 *   sublists awaiting further merging.
 	 * - Sublists are sorted by size and age, smallest & newest at front.
-	 * - All of the sorted sublists are power-of-two in size,
-	 *   corresponding to bits set in "count".
+	 * - All of the sorted sublists are power-of-two in size.
+	 * - There are zero to two sublists of each size.
+	 * - A pair of pending sublists are merged as soon as the number
+	 *   of following pending elements equals their size.  That ensures
+	 *   each later final merge will be at worst 2:1.
+	 * - Each round consists of:
+	 *   - Merging the two sublists selected by the highest bit
+	 *     which flips when count is inremented, and
+	 *   - Adding an element from the input as a size-1 sublist.
 	 */
 	do {
 		size_t bit;
-		struct list_head *cur = list;
+		struct list_head **tail = &pending;
 
-		/* Extract the head of "list" as a single-element list "cur" */
-		list = list->next;
-		cur->next = NULL;
+		/* Find the least-significant clear bit in count */
+		for (bit = 1; count & bit; bit <<= 1)
+			tail = &(*tail)->prev;
+		/* Do the indicated merge */
+		if (likely(count > bit)) {
+			struct list_head *a = *tail, *b = a->prev;
 
-		/* Do merges corresponding to set lsbits in count */
-		for (bit = 1; count & bit; bit <<= 1) {
-			cur = merge(priv, (cmp_func)cmp, pending, cur);
-			pending = pending->prev;  /* Untouched by merge() */
+			a = merge(priv, (cmp_func)cmp, a, b);
+			/* Install the result in place of the lists */
+			a->prev = b->prev;
+			*tail = a;
 		}
-		/* And place the result at the head of "pending" */
-		cur->prev = pending;
-		pending = cur;
-		count++;
-	} while (list->next);
 
-	/* Now merge together last element with all pending lists */
-	while (pending->prev) {
+		/* Move one element from input list to pending */
+		list->prev = pending;
+		pending = list;
+		list = list->next;
+		pending->next = NULL;
+		count++;
+	} while (list);
+
+	/* End of input; merge together all the pending lists. */
+	list = pending;
+	pending = pending->prev;
+	for (;;) {
+		struct list_head *next = pending->prev;
+
+		if (!next)
+			break;
 		list = merge(priv, (cmp_func)cmp, pending, list);
-		pending = pending->prev;
+		pending = next;
 	}
 	/* The final merge, rebuilding prev links */
 	merge_final(priv, (cmp_func)cmp, head, pending, list);
-- 
2.20.1

