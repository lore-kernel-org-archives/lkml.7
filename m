Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A69C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 22:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFDB2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 22:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfHMWqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 18:46:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:50712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbfHMWqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 18:46:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A362FAD18;
        Tue, 13 Aug 2019 22:46:33 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     walken@google.com, peterz@infradead.org, akpm@linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/3] x86,mm/pat: Use generic interval trees
Date:   Tue, 13 Aug 2019 15:46:18 -0700
Message-Id: <20190813224620.31005-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190813224620.31005-1-dave@stgolabs.net>
References: <20190813224620.31005-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With some considerations, the custom pat_rbtree implementation can be
simplified to use most of the generic interval_tree machinery.

o The tree inorder traversal can slightly differ when there are key
('start') collisions in the tree due to one going left and another right.
This, however, only affects the output of debugfs' pat_memtype_list file.

o The border cases for overlapping differ -- interval trees are closed,
while memtype intervals are open. We need to maintain semantics such
that conflict detection and getting the lowest match does not change.

o Erasing logic must remain untouched as well.

In order for the types to remain u64, the 'memtype_interval' calls are
introduced, as opposed to simply using struct interval_tree.

Pat tree might potentially also benefit by the fast overlap detection
for the insertion case when looking up the first overlapping node in
the tree; albeit not as far as my testing as shown, due to the use case.

Finally, I've tested this on various servers, via sanity warnings, running
side by side with the current version and so far see no differences in the
returned pointer node when doing memtype_rb_lowest_match() lookups.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 arch/x86/mm/pat_rbtree.c | 167 +++++++++++++++--------------------------------
 1 file changed, 54 insertions(+), 113 deletions(-)

diff --git a/arch/x86/mm/pat_rbtree.c b/arch/x86/mm/pat_rbtree.c
index fa16036fa592..1be4d1856a9b 100644
--- a/arch/x86/mm/pat_rbtree.c
+++ b/arch/x86/mm/pat_rbtree.c
@@ -12,7 +12,7 @@
 #include <linux/seq_file.h>
 #include <linux/debugfs.h>
 #include <linux/kernel.h>
-#include <linux/rbtree_augmented.h>
+#include <linux/interval_tree_generic.h>
 #include <linux/sched.h>
 #include <linux/gfp.h>
 
@@ -34,68 +34,41 @@
  * memtype_lock protects the rbtree.
  */
 
-static struct rb_root memtype_rbroot = RB_ROOT;
+static struct rb_root_cached memtype_rbroot = RB_ROOT_CACHED;
+
+#define START(node) ((node)->start)
+#define END(node)  ((node)->end)
+INTERVAL_TREE_DEFINE(struct memtype, rb, u64, subtree_max_end,
+		     START, END, static, memtype_interval)
 
 static int is_node_overlap(struct memtype *node, u64 start, u64 end)
 {
-	if (node->start >= end || node->end <= start)
+	/*
+	 * Unlike generic interval trees, the memtype nodes are ]a, b[
+	 * therefore we need to adjust the ranges accordingly. Missing
+	 * an overlap can lead to incorrectly detecting conflicts,
+	 * for example.
+	 */
+	if (node->start + 1 >= end || node->end - 1 <= start)
 		return 0;
 
 	return 1;
 }
 
-static u64 get_subtree_max_end(struct rb_node *node)
-{
-	u64 ret = 0;
-	if (node) {
-		struct memtype *data = rb_entry(node, struct memtype, rb);
-		ret = data->subtree_max_end;
-	}
-	return ret;
-}
-
-static u64 compute_subtree_max_end(struct memtype *data)
+static struct memtype *memtype_rb_lowest_match(struct rb_root_cached *root,
+						u64 start, u64 end)
 {
-	u64 max_end = data->end, child_max_end;
-
-	child_max_end = get_subtree_max_end(data->rb.rb_right);
-	if (child_max_end > max_end)
-		max_end = child_max_end;
-
-	child_max_end = get_subtree_max_end(data->rb.rb_left);
-	if (child_max_end > max_end)
-		max_end = child_max_end;
-
-	return max_end;
-}
-
-RB_DECLARE_CALLBACKS(static, memtype_rb_augment_cb, struct memtype, rb,
-		     u64, subtree_max_end, compute_subtree_max_end)
-
-/* Find the first (lowest start addr) overlapping range from rb tree */
-static struct memtype *memtype_rb_lowest_match(struct rb_root *root,
-				u64 start, u64 end)
-{
-	struct rb_node *node = root->rb_node;
-	struct memtype *last_lower = NULL;
+	struct memtype *node;
 
+	node = memtype_interval_iter_first(root, start, end);
 	while (node) {
-		struct memtype *data = rb_entry(node, struct memtype, rb);
-
-		if (get_subtree_max_end(node->rb_left) > start) {
-			/* Lowest overlap if any must be on left side */
-			node = node->rb_left;
-		} else if (is_node_overlap(data, start, end)) {
-			last_lower = data;
-			break;
-		} else if (start >= data->start) {
-			/* Lowest overlap if any must be on right side */
-			node = node->rb_right;
-		} else {
-			break;
-		}
+		if (is_node_overlap(node, start, end))
+			return node;
+
+		node = memtype_interval_iter_next(node, start, end);
 	}
-	return last_lower; /* Returns NULL if there is no overlap */
+
+	return NULL;
 }
 
 enum {
@@ -103,15 +76,14 @@ enum {
 	MEMTYPE_END_MATCH	= 1
 };
 
-static struct memtype *memtype_rb_match(struct rb_root *root,
-				u64 start, u64 end, int match_type)
+static struct memtype *memtype_rb_match(struct rb_root_cached *root,
+					u64 start, u64 end, int match_type)
 {
 	struct memtype *match;
 
 	match = memtype_rb_lowest_match(root, start, end);
-	while (match != NULL && match->start < end) {
-		struct rb_node *node;
 
+	while (match != NULL && match->start < end) {
 		if ((match_type == MEMTYPE_EXACT_MATCH) &&
 		    (match->start == start) && (match->end == end))
 			return match;
@@ -120,26 +92,21 @@ static struct memtype *memtype_rb_match(struct rb_root *root,
 		    (match->start < start) && (match->end == end))
 			return match;
 
-		node = rb_next(&match->rb);
-		if (node)
-			match = rb_entry(node, struct memtype, rb);
-		else
-			match = NULL;
+	        match = memtype_interval_iter_next(match, start, end);
 	}
 
 	return NULL; /* Returns NULL if there is no match */
 }
 
-static int memtype_rb_check_conflict(struct rb_root *root,
-				u64 start, u64 end,
-				enum page_cache_mode reqtype,
-				enum page_cache_mode *newtype)
+static int memtype_rb_check_conflict(struct rb_root_cached *root,
+				      u64 start, u64 end,
+				      enum page_cache_mode reqtype,
+				      enum page_cache_mode *newtype)
 {
-	struct rb_node *node;
 	struct memtype *match;
 	enum page_cache_mode found_type = reqtype;
 
-	match = memtype_rb_lowest_match(&memtype_rbroot, start, end);
+	match = memtype_rb_lowest_match(root, start, end);
 	if (match == NULL)
 		goto success;
 
@@ -149,10 +116,8 @@ static int memtype_rb_check_conflict(struct rb_root *root,
 	dprintk("Overlap at 0x%Lx-0x%Lx\n", match->start, match->end);
 	found_type = match->type;
 
-	node = rb_next(&match->rb);
-	while (node) {
-		match = rb_entry(node, struct memtype, rb);
-
+        match = memtype_interval_iter_next(match, start, end);
+	while (match) {
 		if (match->start >= end) /* Checked all possible matches */
 			goto success;
 
@@ -161,7 +126,7 @@ static int memtype_rb_check_conflict(struct rb_root *root,
 			goto failure;
 		}
 
-		node = rb_next(&match->rb);
+	        match = memtype_interval_iter_next(match, start, end);
 	}
 success:
 	if (newtype)
@@ -176,43 +141,21 @@ static int memtype_rb_check_conflict(struct rb_root *root,
 	return -EBUSY;
 }
 
-static void memtype_rb_insert(struct rb_root *root, struct memtype *newdata)
-{
-	struct rb_node **node = &(root->rb_node);
-	struct rb_node *parent = NULL;
-
-	while (*node) {
-		struct memtype *data = rb_entry(*node, struct memtype, rb);
-
-		parent = *node;
-		if (data->subtree_max_end < newdata->end)
-			data->subtree_max_end = newdata->end;
-		if (newdata->start <= data->start)
-			node = &((*node)->rb_left);
-		else if (newdata->start > data->start)
-			node = &((*node)->rb_right);
-	}
-
-	newdata->subtree_max_end = newdata->end;
-	rb_link_node(&newdata->rb, parent, node);
-	rb_insert_augmented(&newdata->rb, root, &memtype_rb_augment_cb);
-}
-
 int rbt_memtype_check_insert(struct memtype *new,
 			     enum page_cache_mode *ret_type)
 {
-	int err = 0;
+	int err;
 
-	err = memtype_rb_check_conflict(&memtype_rbroot, new->start, new->end,
-						new->type, ret_type);
+	err =  memtype_rb_check_conflict(&memtype_rbroot,
+					 new->start, new->end,
+					 new->type, ret_type);
+	if (err)
+		return err;
 
-	if (!err) {
-		if (ret_type)
-			new->type = *ret_type;
+	if (ret_type)
+		new->type = *ret_type;
 
-		new->subtree_max_end = new->end;
-		memtype_rb_insert(&memtype_rbroot, new);
-	}
+	memtype_interval_insert(new, &memtype_rbroot);
 	return err;
 }
 
@@ -238,15 +181,13 @@ struct memtype *rbt_memtype_erase(u64 start, u64 end)
 
 	if (data->start == start) {
 		/* munmap: erase this node */
-		rb_erase_augmented(&data->rb, &memtype_rbroot,
-					&memtype_rb_augment_cb);
+		memtype_interval_remove(data, &memtype_rbroot);
 	} else {
 		/* mremap: update the end value of this node */
-		rb_erase_augmented(&data->rb, &memtype_rbroot,
-					&memtype_rb_augment_cb);
+		memtype_interval_remove(data, &memtype_rbroot);
 		data->end = start;
-		data->subtree_max_end = data->end;
-		memtype_rb_insert(&memtype_rbroot, data);
+		memtype_interval_insert(data, &memtype_rbroot);
+
 		return NULL;
 	}
 
@@ -261,21 +202,21 @@ struct memtype *rbt_memtype_lookup(u64 addr)
 #if defined(CONFIG_DEBUG_FS)
 int rbt_memtype_copy_nth_element(struct memtype *out, loff_t pos)
 {
-	struct rb_node *node;
+	struct memtype *node;
 	int i = 1;
 
-	node = rb_first(&memtype_rbroot);
+	node = memtype_interval_iter_first(&memtype_rbroot, 0, ULONG_MAX);
 	while (node && pos != i) {
-		node = rb_next(node);
+		node = memtype_interval_iter_next(node, 0, ULONG_MAX);
 		i++;
 	}
 
 	if (node) { /* pos == i */
-		struct memtype *this = rb_entry(node, struct memtype, rb);
-		*out = *this;
+		*out = *node;
 		return 0;
 	} else {
 		return 1;
 	}
 }
+
 #endif
-- 
2.16.4

