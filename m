Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F82C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 04:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A384F21721
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 04:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lm65aLNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfGCECG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 00:02:06 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:50070 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCECF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 00:02:05 -0400
Received: by mail-pf1-f202.google.com with SMTP id 145so644087pfw.16
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 21:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1D8suTB0ieZh3KQhSmn2+eP8UXLRi5ZfSBvMbsHVYoY=;
        b=lm65aLNEBfaw0OJ4HccecE0g6t2Qjb6LBwDOra6t8DvGIA4iucwwz7GBjTJbGEbhe3
         Zme4N4Baf9rHGLTSqbQh2MKmVRq0UAyhScI88S54KaHrw15x57/pqdpqMoJ/lbrVJxEL
         ekZLyeQI/nLQwk7mZKrgDZPrmHsXklVn6hpc0ajgZ6wohMUIR+JQ4lqYL3GHC4TMJOS3
         NVX2H7l79PoaAizFXbthuUd+oN4A5fkY1pxUX5I5ggt7z7eFsaITP312zxO6ucHL7VVS
         LZMA9gKHiIG4qZJkB7sKOOJVC42d3RSu/qR+PyjygwZhzJ6LP3hQGAin24qKpR03N/kK
         fOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1D8suTB0ieZh3KQhSmn2+eP8UXLRi5ZfSBvMbsHVYoY=;
        b=LbWljf8IRwlf6lv5NBuxLwY5hpaxsdkbkgyXWR3KSZm2qO3tnkD209HJ1sR+21bSiT
         EN0dr++V+aQYyb7EbRuTNTVtjhEJpxc+kT5DNlZTT8UIThBxvyidS4vNIEbxX7Nm9wOl
         9z9w6TvyIH5pgh0IfYcAREZrK/BE9qR+r+djOEpWFsGr1jMMAP+ILpjWJbSahOr4b1U6
         TVw8MGEUSD19k3qz4gNZ27jsouawlZsmVJ8oSUCXVzQisojX6aBKPGPBs4e7OojmdY85
         6mzc430ZFntPman6ujf0ICeE1McMmwLzY/MpyQe1rodTzmejJBwWe4K6nBYqYFMKBEum
         t7zQ==
X-Gm-Message-State: APjAAAVLcmExuIwlSZOlVMLKtfQPrrTNRDadCj+rpwquVUxMIf3Opa1b
        lgXENrtDObiQQ08YYwRs1c+dqscw/9s=
X-Google-Smtp-Source: APXvYqz0nY0b5B2OX6NxdFERfdHZfrbwK07d6yk0OLmQwFrkvcFHVY5TSI8+HgHGaOtEgSlHEQRxpBAWHvs=
X-Received: by 2002:a63:6a81:: with SMTP id f123mr13023112pgc.348.1562126524054;
 Tue, 02 Jul 2019 21:02:04 -0700 (PDT)
Date:   Tue,  2 Jul 2019 21:01:55 -0700
In-Reply-To: <20190703040156.56953-1-walken@google.com>
Message-Id: <20190703040156.56953-3-walken@google.com>
Mime-Version: 1.0
References: <20190703040156.56953-1-walken@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3 2/3] augmented rbtree: add new RB_DECLARE_CALLBACKS_MAX macro
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

Add RB_DECLARE_CALLBACKS_MAX, which generates augmented rbtree callbacks
for the case where the augmented value is a scalar whose definition
follows a max(f(node)) pattern. This actually covers all present uses
of RB_DECLARE_CALLBACKS, and saves some (source) code duplication in the
various RBCOMPUTE function definitions.

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 arch/x86/mm/pat_rbtree.c               | 19 +++-----------
 drivers/block/drbd/drbd_interval.c     | 29 +++------------------
 include/linux/interval_tree_generic.h  | 22 ++--------------
 include/linux/rbtree_augmented.h       | 36 +++++++++++++++++++++++++-
 lib/rbtree_test.c                      | 22 +++-------------
 mm/mmap.c                              | 29 +++++++++++++--------
 tools/include/linux/rbtree_augmented.h | 36 +++++++++++++++++++++++++-
 7 files changed, 99 insertions(+), 94 deletions(-)

diff --git a/arch/x86/mm/pat_rbtree.c b/arch/x86/mm/pat_rbtree.c
index fa16036fa592..65ebe4b88f7c 100644
--- a/arch/x86/mm/pat_rbtree.c
+++ b/arch/x86/mm/pat_rbtree.c
@@ -54,23 +54,10 @@ static u64 get_subtree_max_end(struct rb_node *node)
 	return ret;
 }
 
-static u64 compute_subtree_max_end(struct memtype *data)
-{
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
+#define NODE_END(node) ((node)->end)
 
-RB_DECLARE_CALLBACKS(static, memtype_rb_augment_cb, struct memtype, rb,
-		     u64, subtree_max_end, compute_subtree_max_end)
+RB_DECLARE_CALLBACKS_MAX(static, memtype_rb_augment_cb,
+			 struct memtype, rb, u64, subtree_max_end, NODE_END)
 
 /* Find the first (lowest start addr) overlapping range from rb tree */
 static struct memtype *memtype_rb_lowest_match(struct rb_root *root,
diff --git a/drivers/block/drbd/drbd_interval.c b/drivers/block/drbd/drbd_interval.c
index c58986556161..651bd0236a99 100644
--- a/drivers/block/drbd/drbd_interval.c
+++ b/drivers/block/drbd/drbd_interval.c
@@ -13,33 +13,10 @@ sector_t interval_end(struct rb_node *node)
 	return this->end;
 }
 
-/**
- * compute_subtree_last  -  compute end of @node
- *
- * The end of an interval is the highest (start + (size >> 9)) value of this
- * node and of its children.  Called for @node and its parents whenever the end
- * may have changed.
- */
-static inline sector_t
-compute_subtree_last(struct drbd_interval *node)
-{
-	sector_t max = node->sector + (node->size >> 9);
-
-	if (node->rb.rb_left) {
-		sector_t left = interval_end(node->rb.rb_left);
-		if (left > max)
-			max = left;
-	}
-	if (node->rb.rb_right) {
-		sector_t right = interval_end(node->rb.rb_right);
-		if (right > max)
-			max = right;
-	}
-	return max;
-}
+#define NODE_END(node) ((node)->sector + ((node)->size >> 9))
 
-RB_DECLARE_CALLBACKS(static, augment_callbacks, struct drbd_interval, rb,
-		     sector_t, end, compute_subtree_last);
+RB_DECLARE_CALLBACKS_MAX(static, augment_callbacks,
+			 struct drbd_interval, rb, sector_t, end, NODE_END);
 
 /**
  * drbd_insert_interval  -  insert a new interval into a tree
diff --git a/include/linux/interval_tree_generic.h b/include/linux/interval_tree_generic.h
index 1f97ce26cccc..205218a941e1 100644
--- a/include/linux/interval_tree_generic.h
+++ b/include/linux/interval_tree_generic.h
@@ -42,26 +42,8 @@
 									      \
 /* Callbacks for augmented rbtree insert and remove */			      \
 									      \
-static inline ITTYPE ITPREFIX ## _compute_subtree_last(ITSTRUCT *node)	      \
-{									      \
-	ITTYPE max = ITLAST(node), subtree_last;			      \
-	if (node->ITRB.rb_left) {					      \
-		subtree_last = rb_entry(node->ITRB.rb_left,		      \
-					ITSTRUCT, ITRB)->ITSUBTREE;	      \
-		if (max < subtree_last)					      \
-			max = subtree_last;				      \
-	}								      \
-	if (node->ITRB.rb_right) {					      \
-		subtree_last = rb_entry(node->ITRB.rb_right,		      \
-					ITSTRUCT, ITRB)->ITSUBTREE;	      \
-		if (max < subtree_last)					      \
-			max = subtree_last;				      \
-	}								      \
-	return max;							      \
-}									      \
-									      \
-RB_DECLARE_CALLBACKS(static, ITPREFIX ## _augment, ITSTRUCT, ITRB,	      \
-		     ITTYPE, ITSUBTREE, ITPREFIX ## _compute_subtree_last)    \
+RB_DECLARE_CALLBACKS_MAX(static, ITPREFIX ## _augment,			      \
+			 ITSTRUCT, ITRB, ITTYPE, ITSUBTREE, ITLAST)	      \
 									      \
 /* Insert / remove interval nodes from the tree */			      \
 									      \
diff --git a/include/linux/rbtree_augmented.h b/include/linux/rbtree_augmented.h
index 5923495276e0..c5379d762fa9 100644
--- a/include/linux/rbtree_augmented.h
+++ b/include/linux/rbtree_augmented.h
@@ -73,7 +73,7 @@ rb_insert_augmented_cached(struct rb_node *node,
 }
 
 /*
- * Template for declaring augmented rbtree callbacks
+ * Template for declaring augmented rbtree callbacks (generic case)
  *
  * RBSTATIC:    'static' or empty
  * RBNAME:      name of the rb_augment_callbacks structure
@@ -119,6 +119,40 @@ RBSTATIC const struct rb_augment_callbacks RBNAME = {			\
 	.rotate = RBNAME ## _rotate					\
 };
 
+/*
+ * Template for declaring augmented rbtree callbacks,
+ * computing RBAUGMENTED scalar as max(RBCOMPUTE(node)) for all subtree nodes.
+ *
+ * RBSTATIC:    'static' or empty
+ * RBNAME:      name of the rb_augment_callbacks structure
+ * RBSTRUCT:    struct type of the tree nodes
+ * RBFIELD:     name of struct rb_node field within RBSTRUCT
+ * RBTYPE:      type of the RBAUGMENTED field
+ * RBAUGMENTED: name of RBTYPE field within RBSTRUCT holding data for subtree
+ * RBCOMPUTE:   name of function that returns the per-node RBTYPE scalar
+ */
+
+#define RB_DECLARE_CALLBACKS_MAX(RBSTATIC, RBNAME, RBSTRUCT, RBFIELD,	      \
+				 RBTYPE, RBAUGMENTED, RBCOMPUTE)	      \
+static inline RBTYPE RBNAME ## _compute_max(RBSTRUCT *node)		      \
+{									      \
+	RBSTRUCT *child;						      \
+	RBTYPE max = RBCOMPUTE(node);					      \
+	if (node->RBFIELD.rb_left) {					      \
+		child = rb_entry(node->RBFIELD.rb_left, RBSTRUCT, RBFIELD);   \
+		if (child->RBAUGMENTED > max)				      \
+			max = child->RBAUGMENTED;			      \
+	}								      \
+	if (node->RBFIELD.rb_right) {					      \
+		child = rb_entry(node->RBFIELD.rb_right, RBSTRUCT, RBFIELD);  \
+		if (child->RBAUGMENTED > max)				      \
+			max = child->RBAUGMENTED;			      \
+	}								      \
+	return max;							      \
+}									      \
+RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME, RBSTRUCT, RBFIELD,		      \
+		     RBTYPE, RBAUGMENTED, RBNAME ## _compute_max)
+
 
 #define	RB_RED		0
 #define	RB_BLACK	1
diff --git a/lib/rbtree_test.c b/lib/rbtree_test.c
index b7055b2a07d3..2631bcaada41 100644
--- a/lib/rbtree_test.c
+++ b/lib/rbtree_test.c
@@ -76,26 +76,10 @@ static inline void erase_cached(struct test_node *node, struct rb_root_cached *r
 }
 
 
-static inline u32 augment_recompute(struct test_node *node)
-{
-	u32 max = node->val, child_augmented;
-	if (node->rb.rb_left) {
-		child_augmented = rb_entry(node->rb.rb_left, struct test_node,
-					   rb)->augmented;
-		if (max < child_augmented)
-			max = child_augmented;
-	}
-	if (node->rb.rb_right) {
-		child_augmented = rb_entry(node->rb.rb_right, struct test_node,
-					   rb)->augmented;
-		if (max < child_augmented)
-			max = child_augmented;
-	}
-	return max;
-}
+#define NODE_VAL(node) ((node)->val)
 
-RB_DECLARE_CALLBACKS(static, augment_callbacks, struct test_node, rb,
-		     u32, augmented, augment_recompute)
+RB_DECLARE_CALLBACKS_MAX(static, augment_callbacks,
+			 struct test_node, rb, u32, augmented, NODE_VAL)
 
 static void insert_augmented(struct test_node *node,
 			     struct rb_root_cached *root)
diff --git a/mm/mmap.c b/mm/mmap.c
index bd7b9f293b39..39ce2acf4ec3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -288,9 +288,9 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	return retval;
 }
 
-static long vma_compute_subtree_gap(struct vm_area_struct *vma)
+static inline unsigned long vma_compute_gap(struct vm_area_struct *vma)
 {
-	unsigned long max, prev_end, subtree_gap;
+	unsigned long gap, prev_end;
 
 	/*
 	 * Note: in the rare case of a VM_GROWSDOWN above a VM_GROWSUP, we
@@ -298,14 +298,21 @@ static long vma_compute_subtree_gap(struct vm_area_struct *vma)
 	 * an unmapped area; whereas when expanding we only require one.
 	 * That's a little inconsistent, but keeps the code here simpler.
 	 */
-	max = vm_start_gap(vma);
+	gap = vm_start_gap(vma);
 	if (vma->vm_prev) {
 		prev_end = vm_end_gap(vma->vm_prev);
-		if (max > prev_end)
-			max -= prev_end;
+		if (gap > prev_end)
+			gap -= prev_end;
 		else
-			max = 0;
+			gap = 0;
 	}
+	return gap;
+}
+
+#ifdef CONFIG_DEBUG_VM_RB
+static unsigned long vma_compute_subtree_gap(struct vm_area_struct *vma)
+{
+	unsigned long max = vma_compute_gap(vma), subtree_gap;
 	if (vma->vm_rb.rb_left) {
 		subtree_gap = rb_entry(vma->vm_rb.rb_left,
 				struct vm_area_struct, vm_rb)->rb_subtree_gap;
@@ -321,7 +328,6 @@ static long vma_compute_subtree_gap(struct vm_area_struct *vma)
 	return max;
 }
 
-#ifdef CONFIG_DEBUG_VM_RB
 static int browse_rb(struct mm_struct *mm)
 {
 	struct rb_root *root = &mm->mm_rb;
@@ -427,8 +433,9 @@ static void validate_mm(struct mm_struct *mm)
 #define validate_mm(mm) do { } while (0)
 #endif
 
-RB_DECLARE_CALLBACKS(static, vma_gap_callbacks, struct vm_area_struct, vm_rb,
-		     unsigned long, rb_subtree_gap, vma_compute_subtree_gap)
+RB_DECLARE_CALLBACKS_MAX(static, vma_gap_callbacks,
+			 struct vm_area_struct, vm_rb,
+			 unsigned long, rb_subtree_gap, vma_compute_gap)
 
 /*
  * Update augmented rbtree rb_subtree_gap values after vma->vm_start or
@@ -438,8 +445,8 @@ RB_DECLARE_CALLBACKS(static, vma_gap_callbacks, struct vm_area_struct, vm_rb,
 static void vma_gap_update(struct vm_area_struct *vma)
 {
 	/*
-	 * As it turns out, RB_DECLARE_CALLBACKS() already created a callback
-	 * function that does exactly what we want.
+	 * As it turns out, RB_DECLARE_CALLBACKS_MAX() already created
+	 * a callback function that does exactly what we want.
 	 */
 	vma_gap_callbacks_propagate(&vma->vm_rb, NULL);
 }
diff --git a/tools/include/linux/rbtree_augmented.h b/tools/include/linux/rbtree_augmented.h
index f46c1bf91f64..10a2f3f8c801 100644
--- a/tools/include/linux/rbtree_augmented.h
+++ b/tools/include/linux/rbtree_augmented.h
@@ -75,7 +75,7 @@ rb_insert_augmented_cached(struct rb_node *node,
 }
 
 /*
- * Template for declaring augmented rbtree callbacks
+ * Template for declaring augmented rbtree callbacks (generic case)
  *
  * RBSTATIC:    'static' or empty
  * RBNAME:      name of the rb_augment_callbacks structure
@@ -121,6 +121,40 @@ RBSTATIC const struct rb_augment_callbacks RBNAME = {			\
 	.rotate = RBNAME ## _rotate					\
 };
 
+/*
+ * Template for declaring augmented rbtree callbacks,
+ * computing RBAUGMENTED scalar as max(RBCOMPUTE(node)) for all subtree nodes.
+ *
+ * RBSTATIC:    'static' or empty
+ * RBNAME:      name of the rb_augment_callbacks structure
+ * RBSTRUCT:    struct type of the tree nodes
+ * RBFIELD:     name of struct rb_node field within RBSTRUCT
+ * RBTYPE:      type of the RBAUGMENTED field
+ * RBAUGMENTED: name of RBTYPE field within RBSTRUCT holding data for subtree
+ * RBCOMPUTE:   name of function that returns the per-node RBTYPE scalar
+ */
+
+#define RB_DECLARE_CALLBACKS_MAX(RBSTATIC, RBNAME, RBSTRUCT, RBFIELD,	      \
+				 RBTYPE, RBAUGMENTED, RBCOMPUTE)	      \
+static inline RBTYPE RBNAME ## _compute_max(RBSTRUCT *node)		      \
+{									      \
+	RBSTRUCT *child;						      \
+	RBTYPE max = RBCOMPUTE(node);					      \
+	if (node->RBFIELD.rb_left) {					      \
+		child = rb_entry(node->RBFIELD.rb_left, RBSTRUCT, RBFIELD);   \
+		if (child->RBAUGMENTED > max)				      \
+			max = child->RBAUGMENTED;			      \
+	}								      \
+	if (node->RBFIELD.rb_right) {					      \
+		child = rb_entry(node->RBFIELD.rb_right, RBSTRUCT, RBFIELD);  \
+		if (child->RBAUGMENTED > max)				      \
+			max = child->RBAUGMENTED;			      \
+	}								      \
+	return max;							      \
+}									      \
+RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME, RBSTRUCT, RBFIELD,		      \
+		     RBTYPE, RBAUGMENTED, RBNAME ## _compute_max)
+
 
 #define	RB_RED		0
 #define	RB_BLACK	1
-- 
2.22.0.410.gd8fdbe21b5-goog

