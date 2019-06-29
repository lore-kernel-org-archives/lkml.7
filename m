Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97561C5B578
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 00:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659A3208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 00:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pDQD2H0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfF2AuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 20:50:20 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:55829 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfF2AuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 20:50:19 -0400
Received: by mail-ua1-f74.google.com with SMTP id 64so923808uam.22
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 17:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Nha5lfnrOS5Se7DNjDLYfq8FbEpebjgrO20KMpsQvdM=;
        b=pDQD2H0CFsLhBO6cgZ/HIGgk+O1vxy9N/65RlCWqja8A6j+pt/Hw8tZgMTadqxK3rC
         IhasLfQixi/5P/OFLESVlIjC9EHdkSqBydZXJQ+x5eheSuNLpBFoNCNvzW1uDgVZibq+
         SO/CLovGoNJP6amSWdAWNJXvVobr6h2N+QJxz9oE4tvJahwh4+W+irYSVZu3KZQILRGd
         e8kJLtPPQNmoDIQrRxSencXAhEqecI/S53hG900bpQ9h1leLnxj+DhbaOTipVtcUtqRD
         niZUYzRtx7KM+Ynjd7RvOW11hTvdBDorGL42kmDh5o8oS4FjPckIKT3ZqXvi2pt0pkV7
         7U/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Nha5lfnrOS5Se7DNjDLYfq8FbEpebjgrO20KMpsQvdM=;
        b=iBCh+HTq3YTHxD19MCutirAgWCpnHSkvWTcl4RK3hS9upmv44W5cO4uRO7NU5PSLG5
         sbldTeInZu1vxWYDMZv/2mAuPwRJFziofTyhtC9sJhmLY4l0XrdY8ol/eeJQ/TruS6/u
         ZPUemU2Uo7zDtXr8XZVZzxLCu75iu9vIdCXg3NW6qpICPHLhA44Xk0Vd46DbCs/Q1ykb
         KKWEJf74Mt2AkrFd+hwseDdMn6COLgFfEvEhcLQMCxpir2zAWErfUz4AP4UbRLTPsXVe
         31UUnSy5R5FdDPCHV4xgpDIv9zVhWiguVsfEEsZIv1Y+rKWVAX1BsxilM+QmfkzRlDHx
         Jgpg==
X-Gm-Message-State: APjAAAXZEXjjj1afF4unbefUZ43QKRurNedQXIRmIpyGP4rW7KyvsJm/
        BiJZ/P93rV09EYD6g+TQ5Ba89ZwS7FY=
X-Google-Smtp-Source: APXvYqzFurex7QG7i11dShZ+u3OuIRM+1GMdlUNUmX7U7IQuk6Be6/rI/qz533tCxgc7Sb3fPdMiYX7E95c=
X-Received: by 2002:a67:e9ca:: with SMTP id q10mr8242048vso.105.1561769416841;
 Fri, 28 Jun 2019 17:50:16 -0700 (PDT)
Date:   Fri, 28 Jun 2019 17:49:52 -0700
In-Reply-To: <20190629004952.6611-1-walken@google.com>
Message-Id: <20190629004952.6611-3-walken@google.com>
Mime-Version: 1.0
References: <20190629004952.6611-1-walken@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH 2/2] augmented rbtree: rework the RB_DECLARE_CALLBACKS macro definition
From:   Michel Lespinasse <walken@google.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michel Lespinasse <walken@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Change the definition of the RBCOMPUTE function. The propagate
  callback repeatedly calls RBCOMPUTE as it moves from leaf to root.
  it wants to stop recomputing once the augmented subtree information
  doesn't change. This was previously checked using the == operator,
  but that only works when the augmented subtree information is a
  scalar field. This commit modifies the RBCOMPUTE function so that
  it now sets the augmented subtree information instead of returning it,
  and returns a boolean value indicating if the propagate callback
  should stop.

- Reorder the RB_DECLARE_CALLBACKS macro arguments, following the
  style of the INTERVAL_TREE_DEFINE macro, so that RBSTATIC and RBNAME
  are passed last.

The generated code should not change when the RBCOMPUTE function is inlined,
which is the typical / intended case.

The motivation for this change is that I want to introduce augmented rbtree
uses where the augmented data for the subtree is a struct instead of a scalar.

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 arch/x86/mm/pat_rbtree.c               | 11 ++++--
 drivers/block/drbd/drbd_interval.c     | 13 ++++---
 include/linux/interval_tree_generic.h  | 13 +++++--
 include/linux/rbtree_augmented.h       | 17 ++++-----
 lib/rbtree_test.c                      | 11 ++++--
 mm/mmap.c                              | 26 ++++++++-----
 tools/include/linux/rbtree_augmented.h | 51 +++++++++++++++-----------
 7 files changed, 84 insertions(+), 58 deletions(-)

diff --git a/arch/x86/mm/pat_rbtree.c b/arch/x86/mm/pat_rbtree.c
index fa16036fa592..f1701f6e3c49 100644
--- a/arch/x86/mm/pat_rbtree.c
+++ b/arch/x86/mm/pat_rbtree.c
@@ -54,7 +54,7 @@ static u64 get_subtree_max_end(struct rb_node *node)
 	return ret;
 }
 
-static u64 compute_subtree_max_end(struct memtype *data)
+static inline bool compute_subtree_max_end(struct memtype *data, bool exit)
 {
 	u64 max_end = data->end, child_max_end;
 
@@ -66,11 +66,14 @@ static u64 compute_subtree_max_end(struct memtype *data)
 	if (child_max_end > max_end)
 		max_end = child_max_end;
 
-	return max_end;
+	if (exit && data->subtree_max_end == max_end)
+		return true;
+	data->subtree_max_end = max_end;
+	return false;
 }
 
-RB_DECLARE_CALLBACKS(static, memtype_rb_augment_cb, struct memtype, rb,
-		     u64, subtree_max_end, compute_subtree_max_end)
+RB_DECLARE_CALLBACKS(struct memtype, rb, subtree_max_end,
+		     compute_subtree_max_end, static, memtype_rb_augment_cb)
 
 /* Find the first (lowest start addr) overlapping range from rb tree */
 static struct memtype *memtype_rb_lowest_match(struct rb_root *root,
diff --git a/drivers/block/drbd/drbd_interval.c b/drivers/block/drbd/drbd_interval.c
index c58986556161..6decee82a797 100644
--- a/drivers/block/drbd/drbd_interval.c
+++ b/drivers/block/drbd/drbd_interval.c
@@ -20,8 +20,8 @@ sector_t interval_end(struct rb_node *node)
  * node and of its children.  Called for @node and its parents whenever the end
  * may have changed.
  */
-static inline sector_t
-compute_subtree_last(struct drbd_interval *node)
+static inline bool
+compute_subtree_last(struct drbd_interval *node, bool exit)
 {
 	sector_t max = node->sector + (node->size >> 9);
 
@@ -35,11 +35,14 @@ compute_subtree_last(struct drbd_interval *node)
 		if (right > max)
 			max = right;
 	}
-	return max;
+	if (exit && node->end == max)
+		return true;
+	node->end = max;
+	return false;
 }
 
-RB_DECLARE_CALLBACKS(static, augment_callbacks, struct drbd_interval, rb,
-		     sector_t, end, compute_subtree_last);
+RB_DECLARE_CALLBACKS(struct drbd_interval, rb, end, compute_subtree_last,
+		     static, augment_callbacks);
 
 /**
  * drbd_insert_interval  -  insert a new interval into a tree
diff --git a/include/linux/interval_tree_generic.h b/include/linux/interval_tree_generic.h
index 1f97ce26cccc..c54ce9ea152d 100644
--- a/include/linux/interval_tree_generic.h
+++ b/include/linux/interval_tree_generic.h
@@ -42,7 +42,8 @@
 									      \
 /* Callbacks for augmented rbtree insert and remove */			      \
 									      \
-static inline ITTYPE ITPREFIX ## _compute_subtree_last(ITSTRUCT *node)	      \
+static inline bool ITPREFIX ## _compute_subtree_last(ITSTRUCT *node,	      \
+						     bool exit)		      \
 {									      \
 	ITTYPE max = ITLAST(node), subtree_last;			      \
 	if (node->ITRB.rb_left) {					      \
@@ -57,11 +58,15 @@ static inline ITTYPE ITPREFIX ## _compute_subtree_last(ITSTRUCT *node)	      \
 		if (max < subtree_last)					      \
 			max = subtree_last;				      \
 	}								      \
-	return max;							      \
+	if (exit && node->ITSUBTREE == max)				      \
+		return true;						      \
+	node->ITSUBTREE = max;						      \
+	return false;							      \
 }									      \
 									      \
-RB_DECLARE_CALLBACKS(static, ITPREFIX ## _augment, ITSTRUCT, ITRB,	      \
-		     ITTYPE, ITSUBTREE, ITPREFIX ## _compute_subtree_last)    \
+RB_DECLARE_CALLBACKS(ITSTRUCT, ITRB, ITSUBTREE,				      \
+		     ITPREFIX ## _compute_subtree_last,			      \
+		     static, ITPREFIX ## _augment)			      \
 									      \
 /* Insert / remove interval nodes from the tree */			      \
 									      \
diff --git a/include/linux/rbtree_augmented.h b/include/linux/rbtree_augmented.h
index 5923495276e0..a490ba61a1d0 100644
--- a/include/linux/rbtree_augmented.h
+++ b/include/linux/rbtree_augmented.h
@@ -75,26 +75,23 @@ rb_insert_augmented_cached(struct rb_node *node,
 /*
  * Template for declaring augmented rbtree callbacks
  *
- * RBSTATIC:    'static' or empty
- * RBNAME:      name of the rb_augment_callbacks structure
  * RBSTRUCT:    struct type of the tree nodes
  * RBFIELD:     name of struct rb_node field within RBSTRUCT
- * RBTYPE:      type of the RBAUGMENTED field
- * RBAUGMENTED: name of RBTYPE field within RBSTRUCT holding data for subtree
+ * RBAUGMENTED: name of field within RBSTRUCT holding data for subtree
  * RBCOMPUTE:   name of function that recomputes the RBAUGMENTED data
+ * RBSTATIC:    'static' or empty
+ * RBNAME:      name of the rb_augment_callbacks structure
  */
 
-#define RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME, RBSTRUCT, RBFIELD,	\
-			     RBTYPE, RBAUGMENTED, RBCOMPUTE)		\
+#define RB_DECLARE_CALLBACKS(RBSTRUCT, RBFIELD, RBAUGMENTED, RBCOMPUTE,	\
+			     RBSTATIC, RBNAME)				\
 static inline void							\
 RBNAME ## _propagate(struct rb_node *rb, struct rb_node *stop)		\
 {									\
 	while (rb != stop) {						\
 		RBSTRUCT *node = rb_entry(rb, RBSTRUCT, RBFIELD);	\
-		RBTYPE augmented = RBCOMPUTE(node);			\
-		if (node->RBAUGMENTED == augmented)			\
+		if (RBCOMPUTE(node, true))				\
 			break;						\
-		node->RBAUGMENTED = augmented;				\
 		rb = rb_parent(&node->RBFIELD);				\
 	}								\
 }									\
@@ -111,7 +108,7 @@ RBNAME ## _rotate(struct rb_node *rb_old, struct rb_node *rb_new)	\
 	RBSTRUCT *old = rb_entry(rb_old, RBSTRUCT, RBFIELD);		\
 	RBSTRUCT *new = rb_entry(rb_new, RBSTRUCT, RBFIELD);		\
 	new->RBAUGMENTED = old->RBAUGMENTED;				\
-	old->RBAUGMENTED = RBCOMPUTE(old);				\
+	RBCOMPUTE(old, false);						\
 }									\
 RBSTATIC const struct rb_augment_callbacks RBNAME = {			\
 	.propagate = RBNAME ## _propagate,				\
diff --git a/lib/rbtree_test.c b/lib/rbtree_test.c
index b7055b2a07d3..759cce3d6763 100644
--- a/lib/rbtree_test.c
+++ b/lib/rbtree_test.c
@@ -76,7 +76,7 @@ static inline void erase_cached(struct test_node *node, struct rb_root_cached *r
 }
 
 
-static inline u32 augment_recompute(struct test_node *node)
+static inline bool augment_recompute(struct test_node *node, bool exit)
 {
 	u32 max = node->val, child_augmented;
 	if (node->rb.rb_left) {
@@ -91,11 +91,14 @@ static inline u32 augment_recompute(struct test_node *node)
 		if (max < child_augmented)
 			max = child_augmented;
 	}
-	return max;
+	if (exit && node->augmented == max)
+		return true;
+	node->augmented = max;
+	return false;
 }
 
-RB_DECLARE_CALLBACKS(static, augment_callbacks, struct test_node, rb,
-		     u32, augmented, augment_recompute)
+RB_DECLARE_CALLBACKS(struct test_node, rb, augmented, augment_recompute,
+		     static, augment_callbacks)
 
 static void insert_augmented(struct test_node *node,
 			     struct rb_root_cached *root)
diff --git a/mm/mmap.c b/mm/mmap.c
index bd7b9f293b39..f55a0e92c9b6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -288,7 +288,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	return retval;
 }
 
-static long vma_compute_subtree_gap(struct vm_area_struct *vma)
+static bool vma_compute_subtree_gap(struct vm_area_struct *vma, bool exit)
 {
 	unsigned long max, prev_end, subtree_gap;
 
@@ -318,7 +318,10 @@ static long vma_compute_subtree_gap(struct vm_area_struct *vma)
 		if (subtree_gap > max)
 			max = subtree_gap;
 	}
-	return max;
+	if (exit && vma->rb_subtree_gap == max)
+		return true;
+	vma->rb_subtree_gap = max;
+	return false;
 }
 
 #ifdef CONFIG_DEBUG_VM_RB
@@ -330,6 +333,7 @@ static int browse_rb(struct mm_struct *mm)
 	unsigned long prev = 0, pend = 0;
 
 	for (nd = rb_first(root); nd; nd = rb_next(nd)) {
+		unsigned long gap;
 		struct vm_area_struct *vma;
 		vma = rb_entry(nd, struct vm_area_struct, vm_rb);
 		if (vma->vm_start < prev) {
@@ -348,10 +352,10 @@ static int browse_rb(struct mm_struct *mm)
 			bug = 1;
 		}
 		spin_lock(&mm->page_table_lock);
-		if (vma->rb_subtree_gap != vma_compute_subtree_gap(vma)) {
+		gap = vma->rb_subtree_gap;
+		if (!vma_compute_subtree_gap(vma, true)) {
 			pr_emerg("free gap %lx, correct %lx\n",
-			       vma->rb_subtree_gap,
-			       vma_compute_subtree_gap(vma));
+				gap, vma->rb_subtree_gap);
 			bug = 1;
 		}
 		spin_unlock(&mm->page_table_lock);
@@ -375,11 +379,13 @@ static void validate_mm_rb(struct rb_root *root, struct vm_area_struct *ignore)
 	struct rb_node *nd;
 
 	for (nd = rb_first(root); nd; nd = rb_next(nd)) {
+		unsigned long gap;
 		struct vm_area_struct *vma;
 		vma = rb_entry(nd, struct vm_area_struct, vm_rb);
-		VM_BUG_ON_VMA(vma != ignore &&
-			vma->rb_subtree_gap != vma_compute_subtree_gap(vma),
-			vma);
+		if (vma == ignore)
+			continue;
+		gap = vma->rb_subtree_gap;
+		VM_BUG_ON_VMA(!vma_compute_subtree_gap(vma, true), vma);
 	}
 }
 
@@ -427,8 +433,8 @@ static void validate_mm(struct mm_struct *mm)
 #define validate_mm(mm) do { } while (0)
 #endif
 
-RB_DECLARE_CALLBACKS(static, vma_gap_callbacks, struct vm_area_struct, vm_rb,
-		     unsigned long, rb_subtree_gap, vma_compute_subtree_gap)
+RB_DECLARE_CALLBACKS(struct vm_area_struct, vm_rb, rb_subtree_gap,
+		     vma_compute_subtree_gap, static, vma_gap_callbacks)
 
 /*
  * Update augmented rbtree rb_subtree_gap values after vma->vm_start or
diff --git a/tools/include/linux/rbtree_augmented.h b/tools/include/linux/rbtree_augmented.h
index d008e1404580..ec60d1509efc 100644
--- a/tools/include/linux/rbtree_augmented.h
+++ b/tools/include/linux/rbtree_augmented.h
@@ -74,39 +74,48 @@ rb_insert_augmented_cached(struct rb_node *node,
 			      newleft, &root->rb_leftmost, augment->rotate);
 }
 
-#define RB_DECLARE_CALLBACKS(rbstatic, rbname, rbstruct, rbfield,	\
-			     rbtype, rbaugmented, rbcompute)		\
+/*
+ * Template for declaring augmented rbtree callbacks
+ *
+ * RBSTRUCT:    struct type of the tree nodes
+ * RBFIELD:     name of struct rb_node field within RBSTRUCT
+ * RBAUGMENTED: name of field within RBSTRUCT holding data for subtree
+ * RBCOMPUTE:   name of function that recomputes the RBAUGMENTED data
+ * RBSTATIC:    'static' or empty
+ * RBNAME:      name of the rb_augment_callbacks structure
+ */
+
+#define RB_DECLARE_CALLBACKS(RBSTRUCT, RBFIELD, RBAUGMENTED, RBCOMPUTE,	\
+			     RBSTATIC, RBNAME)				\
 static inline void							\
-rbname ## _propagate(struct rb_node *rb, struct rb_node *stop)		\
+RBNAME ## _propagate(struct rb_node *rb, struct rb_node *stop)		\
 {									\
 	while (rb != stop) {						\
-		rbstruct *node = rb_entry(rb, rbstruct, rbfield);	\
-		rbtype augmented = rbcompute(node);			\
-		if (node->rbaugmented == augmented)			\
+		RBSTRUCT *node = rb_entry(rb, RBSTRUCT, RBFIELD);	\
+		if (RBCOMPUTE(node, true))				\
 			break;						\
-		node->rbaugmented = augmented;				\
-		rb = rb_parent(&node->rbfield);				\
+		rb = rb_parent(&node->RBFIELD);				\
 	}								\
 }									\
 static inline void							\
-rbname ## _copy(struct rb_node *rb_old, struct rb_node *rb_new)		\
+RBNAME ## _copy(struct rb_node *rb_old, struct rb_node *rb_new)		\
 {									\
-	rbstruct *old = rb_entry(rb_old, rbstruct, rbfield);		\
-	rbstruct *new = rb_entry(rb_new, rbstruct, rbfield);		\
-	new->rbaugmented = old->rbaugmented;				\
+	RBSTRUCT *old = rb_entry(rb_old, RBSTRUCT, RBFIELD);		\
+	RBSTRUCT *new = rb_entry(rb_new, RBSTRUCT, RBFIELD);		\
+	new->RBAUGMENTED = old->RBAUGMENTED;				\
 }									\
 static void								\
-rbname ## _rotate(struct rb_node *rb_old, struct rb_node *rb_new)	\
+RBNAME ## _rotate(struct rb_node *rb_old, struct rb_node *rb_new)	\
 {									\
-	rbstruct *old = rb_entry(rb_old, rbstruct, rbfield);		\
-	rbstruct *new = rb_entry(rb_new, rbstruct, rbfield);		\
-	new->rbaugmented = old->rbaugmented;				\
-	old->rbaugmented = rbcompute(old);				\
+	RBSTRUCT *old = rb_entry(rb_old, RBSTRUCT, RBFIELD);		\
+	RBSTRUCT *new = rb_entry(rb_new, RBSTRUCT, RBFIELD);		\
+	new->RBAUGMENTED = old->RBAUGMENTED;				\
+	RBCOMPUTE(old, false);						\
 }									\
-rbstatic const struct rb_augment_callbacks rbname = {			\
-	.propagate = rbname ## _propagate,				\
-	.copy = rbname ## _copy,					\
-	.rotate = rbname ## _rotate					\
+RBSTATIC const struct rb_augment_callbacks RBNAME = {			\
+	.propagate = RBNAME ## _propagate,				\
+	.copy = RBNAME ## _copy,					\
+	.rotate = RBNAME ## _rotate					\
 };
 
 
-- 
2.22.0.410.gd8fdbe21b5-goog
