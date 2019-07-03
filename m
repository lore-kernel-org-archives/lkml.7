Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70F9C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACED2085A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tDBaMZmC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfGCDsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 23:48:17 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:44157 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfGCDsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:48:16 -0400
Received: by mail-pf1-f202.google.com with SMTP id j22so630645pfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 20:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6QUXlArorwZcxjWmo4mNiRprQnbVHnQ2DF6JJMBq10c=;
        b=tDBaMZmCi+VWgR4cKkJAQjMg5qhJmYvGcU+MNX8OB2Eq3467Oeg3vojTI93cU52mMo
         dM4c3yM1ptcNcxOSMP1yOxiMMlVt3S0mHOmeVLfHNJXZlAzo6kgy0gw+gn//+kEk78F0
         PxMIFzOLV8U4t+YnoP3+4e9+K9woJhXS2GxMw38TITZ3OegAta5tnth3CWBQtFDYMDLR
         z8BeX2mjGtT+zvL5NCfjXnG56FJ+x2XfmK76bSUQruSYhCZRrjyx21S+ErbEq5NA/+2U
         ki04fCWIB/QhYWmYXY9conrEDwB6L/6mWX1VzkJhOY7uwcvT1AzmlkZS/WHAY/Or++D4
         f/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6QUXlArorwZcxjWmo4mNiRprQnbVHnQ2DF6JJMBq10c=;
        b=HOifV5AK3VE5BeMPwHFA+0Wq2kb4iaQRVIkAy+zQ4Ykx8EwZdiSYCQ3eMPYcmHaivZ
         1AOm/ssL+fyZzzOyLMnbWp2Yx48FvTCrnNowIHzNpt683xPQT6xxaji+VBNHwSlO9oXG
         kjM5R8IwfMe2EoAz2xeQKLZJxWBHxWVPvubpYMe1dosX6DMZAxhzmt3wp6pEprL9MPgN
         uYW/WIfTzzBcTk4zzB92FhX9Q5e7Tj9bXLFMrO/Ok8xoCRw3E96SQyQjVc4kJgvfuowL
         kp4gFuKSNF/2tecShZ2ZjC3gc/i829tzp/BxoHx8xocxA6ECG65E6CMBsuEjSMsmrqB6
         50dw==
X-Gm-Message-State: APjAAAUF+UL7AH91N0yo3uRRm6R3VaeiJiLRxk2UkaLMwd8Bkck1yqEJ
        UT6KSdzkWiQUmrDuvAwEIX4EfA0hDV8=
X-Google-Smtp-Source: APXvYqy/Dsvrkrcc1HvCOt9QEC41cRpx6MIJFe2zLsAK729pQuMJ9RsbSnR+n2DuE+oMzDMp83Ksoz+d9MA=
X-Received: by 2002:a63:62c3:: with SMTP id w186mr35649050pgb.64.1562125694969;
 Tue, 02 Jul 2019 20:48:14 -0700 (PDT)
Date:   Tue,  2 Jul 2019 20:48:12 -0700
Message-Id: <20190703034812.53002-1-walken@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] rbtree: sync up the tools/ copy of the code with the main one
From:   Michel Lespinasse <walken@google.com>
To:     akpm@linux-foundation.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Michel Lespinasse <walken@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I should probably have done this in the same commit that changed the
main rbtree code to avoid generating code twice for the cached rbtree
versions.

Not copying the reviewers of the previous change as tools/ is just another
copy of it. Copying LKML anyway because the additional noise
won't make as much of a difference there :)

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 tools/include/linux/rbtree.h           | 71 +++++++++++++++++---------
 tools/include/linux/rbtree_augmented.h | 31 +++++------
 tools/lib/rbtree.c                     | 37 ++------------
 3 files changed, 62 insertions(+), 77 deletions(-)

diff --git a/tools/include/linux/rbtree.h b/tools/include/linux/rbtree.h
index 8e9ed4786269..2d8f35f308ed 100644
--- a/tools/include/linux/rbtree.h
+++ b/tools/include/linux/rbtree.h
@@ -43,25 +43,9 @@ struct rb_root {
 	struct rb_node *rb_node;
 };
 
-/*
- * Leftmost-cached rbtrees.
- *
- * We do not cache the rightmost node based on footprint
- * size vs number of potential users that could benefit
- * from O(1) rb_last(). Just not worth it, users that want
- * this feature can always implement the logic explicitly.
- * Furthermore, users that want to cache both pointers may
- * find it a bit asymmetric, but that's ok.
- */
-struct rb_root_cached {
-	struct rb_root rb_root;
-	struct rb_node *rb_leftmost;
-};
-
 #define rb_parent(r)   ((struct rb_node *)((r)->__rb_parent_color & ~3))
 
 #define RB_ROOT	(struct rb_root) { NULL, }
-#define RB_ROOT_CACHED (struct rb_root_cached) { {NULL, }, NULL }
 #define	rb_entry(ptr, type, member) container_of(ptr, type, member)
 
 #define RB_EMPTY_ROOT(root)  (READ_ONCE((root)->rb_node) == NULL)
@@ -83,12 +67,6 @@ extern struct rb_node *rb_prev(const struct rb_node *);
 extern struct rb_node *rb_first(const struct rb_root *);
 extern struct rb_node *rb_last(const struct rb_root *);
 
-extern void rb_insert_color_cached(struct rb_node *,
-				   struct rb_root_cached *, bool);
-extern void rb_erase_cached(struct rb_node *node, struct rb_root_cached *);
-/* Same as rb_first(), but O(1) */
-#define rb_first_cached(root) (root)->rb_leftmost
-
 /* Postorder iteration - always visit the parent after its children */
 extern struct rb_node *rb_first_postorder(const struct rb_root *);
 extern struct rb_node *rb_next_postorder(const struct rb_node *);
@@ -96,8 +74,6 @@ extern struct rb_node *rb_next_postorder(const struct rb_node *);
 /* Fast replacement of a single node without remove/rebalance/add/rebalance */
 extern void rb_replace_node(struct rb_node *victim, struct rb_node *new,
 			    struct rb_root *root);
-extern void rb_replace_node_cached(struct rb_node *victim, struct rb_node *new,
-				   struct rb_root_cached *root);
 
 static inline void rb_link_node(struct rb_node *node, struct rb_node *parent,
 				struct rb_node **rb_link)
@@ -141,4 +117,51 @@ static inline void rb_erase_init(struct rb_node *n, struct rb_root *root)
 	rb_erase(n, root);
 	RB_CLEAR_NODE(n);
 }
+
+/*
+ * Leftmost-cached rbtrees.
+ *
+ * We do not cache the rightmost node based on footprint
+ * size vs number of potential users that could benefit
+ * from O(1) rb_last(). Just not worth it, users that want
+ * this feature can always implement the logic explicitly.
+ * Furthermore, users that want to cache both pointers may
+ * find it a bit asymmetric, but that's ok.
+ */
+struct rb_root_cached {
+	struct rb_root rb_root;
+	struct rb_node *rb_leftmost;
+};
+
+#define RB_ROOT_CACHED (struct rb_root_cached) { {NULL, }, NULL }
+
+/* Same as rb_first(), but O(1) */
+#define rb_first_cached(root) (root)->rb_leftmost
+
+static inline void rb_insert_color_cached(struct rb_node *node,
+					  struct rb_root_cached *root,
+					  bool leftmost)
+{
+	if (leftmost)
+		root->rb_leftmost = node;
+	rb_insert_color(node, &root->rb_root);
+}
+
+static inline void rb_erase_cached(struct rb_node *node,
+				   struct rb_root_cached *root)
+{
+	if (root->rb_leftmost == node)
+		root->rb_leftmost = rb_next(node);
+	rb_erase(node, &root->rb_root);
+}
+
+static inline void rb_replace_node_cached(struct rb_node *victim,
+					  struct rb_node *new,
+					  struct rb_root_cached *root)
+{
+	if (root->rb_leftmost == victim)
+		root->rb_leftmost = new;
+	rb_replace_node(victim, new, &root->rb_root);
+}
+
 #endif /* __TOOLS_LINUX_PERF_RBTREE_H */
diff --git a/tools/include/linux/rbtree_augmented.h b/tools/include/linux/rbtree_augmented.h
index d008e1404580..372a539314af 100644
--- a/tools/include/linux/rbtree_augmented.h
+++ b/tools/include/linux/rbtree_augmented.h
@@ -44,17 +44,16 @@ struct rb_augment_callbacks {
 	void (*rotate)(struct rb_node *old, struct rb_node *new);
 };
 
-extern void __rb_insert_augmented(struct rb_node *node,
-				  struct rb_root *root,
-				  bool newleft, struct rb_node **leftmost,
+extern void __rb_insert_augmented(struct rb_node *node, struct rb_root *root,
 	void (*augment_rotate)(struct rb_node *old, struct rb_node *new));
+
 /*
  * Fixup the rbtree and update the augmented information when rebalancing.
  *
  * On insertion, the user must update the augmented information on the path
  * leading to the inserted node, then call rb_link_node() as usual and
- * rb_augment_inserted() instead of the usual rb_insert_color() call.
- * If rb_augment_inserted() rebalances the rbtree, it will callback into
+ * rb_insert_augmented() instead of the usual rb_insert_color() call.
+ * If rb_insert_augmented() rebalances the rbtree, it will callback into
  * a user provided function to update the augmented information on the
  * affected subtrees.
  */
@@ -62,7 +61,7 @@ static inline void
 rb_insert_augmented(struct rb_node *node, struct rb_root *root,
 		    const struct rb_augment_callbacks *augment)
 {
-	__rb_insert_augmented(node, root, false, NULL, augment->rotate);
+	__rb_insert_augmented(node, root, augment->rotate);
 }
 
 static inline void
@@ -70,8 +69,9 @@ rb_insert_augmented_cached(struct rb_node *node,
 			   struct rb_root_cached *root, bool newleft,
 			   const struct rb_augment_callbacks *augment)
 {
-	__rb_insert_augmented(node, &root->rb_root,
-			      newleft, &root->rb_leftmost, augment->rotate);
+	if (newleft)
+		root->rb_leftmost = node;
+	rb_insert_augmented(node, &root->rb_root, augment);
 }
 
 #define RB_DECLARE_CALLBACKS(rbstatic, rbname, rbstruct, rbfield,	\
@@ -151,7 +151,6 @@ extern void __rb_erase_color(struct rb_node *parent, struct rb_root *root,
 
 static __always_inline struct rb_node *
 __rb_erase_augmented(struct rb_node *node, struct rb_root *root,
-		     struct rb_node **leftmost,
 		     const struct rb_augment_callbacks *augment)
 {
 	struct rb_node *child = node->rb_right;
@@ -159,9 +158,6 @@ __rb_erase_augmented(struct rb_node *node, struct rb_root *root,
 	struct rb_node *parent, *rebalance;
 	unsigned long pc;
 
-	if (leftmost && node == *leftmost)
-		*leftmost = rb_next(node);
-
 	if (!tmp) {
 		/*
 		 * Case 1: node to erase has no more than 1 child (easy!)
@@ -261,8 +257,7 @@ static __always_inline void
 rb_erase_augmented(struct rb_node *node, struct rb_root *root,
 		   const struct rb_augment_callbacks *augment)
 {
-	struct rb_node *rebalance = __rb_erase_augmented(node, root,
-							 NULL, augment);
+	struct rb_node *rebalance = __rb_erase_augmented(node, root, augment);
 	if (rebalance)
 		__rb_erase_color(rebalance, root, augment->rotate);
 }
@@ -271,11 +266,9 @@ static __always_inline void
 rb_erase_augmented_cached(struct rb_node *node, struct rb_root_cached *root,
 			  const struct rb_augment_callbacks *augment)
 {
-	struct rb_node *rebalance = __rb_erase_augmented(node, &root->rb_root,
-							 &root->rb_leftmost,
-							 augment);
-	if (rebalance)
-		__rb_erase_color(rebalance, &root->rb_root, augment->rotate);
+	if (root->rb_leftmost == node)
+		root->rb_leftmost = rb_next(node);
+	rb_erase_augmented(node, &root->rb_root, augment);
 }
 
 #endif /* _TOOLS_LINUX_RBTREE_AUGMENTED_H */
diff --git a/tools/lib/rbtree.c b/tools/lib/rbtree.c
index 904adb70a4f0..7b0969864ee4 100644
--- a/tools/lib/rbtree.c
+++ b/tools/lib/rbtree.c
@@ -95,14 +95,10 @@ __rb_rotate_set_parents(struct rb_node *old, struct rb_node *new,
 
 static __always_inline void
 __rb_insert(struct rb_node *node, struct rb_root *root,
-	    bool newleft, struct rb_node **leftmost,
 	    void (*augment_rotate)(struct rb_node *old, struct rb_node *new))
 {
 	struct rb_node *parent = rb_red_parent(node), *gparent, *tmp;
 
-	if (newleft)
-		*leftmost = node;
-
 	while (true) {
 		/*
 		 * Loop invariant: node is red.
@@ -448,34 +444,17 @@ static const struct rb_augment_callbacks dummy_callbacks = {
 
 void rb_insert_color(struct rb_node *node, struct rb_root *root)
 {
-	__rb_insert(node, root, false, NULL, dummy_rotate);
+	__rb_insert(node, root, dummy_rotate);
 }
 
 void rb_erase(struct rb_node *node, struct rb_root *root)
 {
 	struct rb_node *rebalance;
-	rebalance = __rb_erase_augmented(node, root,
-					 NULL, &dummy_callbacks);
+	rebalance = __rb_erase_augmented(node, root, &dummy_callbacks);
 	if (rebalance)
 		____rb_erase_color(rebalance, root, dummy_rotate);
 }
 
-void rb_insert_color_cached(struct rb_node *node,
-			    struct rb_root_cached *root, bool leftmost)
-{
-	__rb_insert(node, &root->rb_root, leftmost,
-		    &root->rb_leftmost, dummy_rotate);
-}
-
-void rb_erase_cached(struct rb_node *node, struct rb_root_cached *root)
-{
-	struct rb_node *rebalance;
-	rebalance = __rb_erase_augmented(node, &root->rb_root,
-					 &root->rb_leftmost, &dummy_callbacks);
-	if (rebalance)
-		____rb_erase_color(rebalance, &root->rb_root, dummy_rotate);
-}
-
 /*
  * Augmented rbtree manipulation functions.
  *
@@ -484,10 +463,9 @@ void rb_erase_cached(struct rb_node *node, struct rb_root_cached *root)
  */
 
 void __rb_insert_augmented(struct rb_node *node, struct rb_root *root,
-			   bool newleft, struct rb_node **leftmost,
 	void (*augment_rotate)(struct rb_node *old, struct rb_node *new))
 {
-	__rb_insert(node, root, newleft, leftmost, augment_rotate);
+	__rb_insert(node, root, augment_rotate);
 }
 
 /*
@@ -592,15 +570,6 @@ void rb_replace_node(struct rb_node *victim, struct rb_node *new,
 	__rb_change_child(victim, new, parent, root);
 }
 
-void rb_replace_node_cached(struct rb_node *victim, struct rb_node *new,
-			    struct rb_root_cached *root)
-{
-	rb_replace_node(victim, new, &root->rb_root);
-
-	if (root->rb_leftmost == victim)
-		root->rb_leftmost = new;
-}
-
 static struct rb_node *rb_left_deepest_node(const struct rb_node *node)
 {
 	for (;;) {
-- 
2.22.0.410.gd8fdbe21b5-goog

