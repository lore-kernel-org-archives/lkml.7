Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492E6C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99B12070D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WLNlNLw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfF1EuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 00:50:13 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:45435 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfF1EuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 00:50:12 -0400
Received: by mail-pg1-f201.google.com with SMTP id n7so2547309pgr.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 21:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sLX9VVsQBCWvknvNFJcb8fxk1ANcgxuFWdDelisBpZc=;
        b=WLNlNLw1F8uo9H1ahTQ3X634CkoPt4PN5PzRhEf4iLlnQMP/O65xplV7rYwbTj3j5Q
         96PVEj64cEQiReOkeAtlrD/YtReHBDmcVzL7++cCDoGcBNlt2qbTkzp9YGclH9byzL8a
         rRVuaFbf7ZbdrI842cM1zIoqIgqrTagnvWjwKFdxi8J6PquJh6153Sm4nizQT1iBGgsp
         MW6nSTeBLOWSk1mIA742fXa/uJP8DZx7++k+VObVcKE0Tm6U+98O7I6KrDc2eXnQfCgh
         e67iDTLkHLE31x0n9kmDYNUWzBxvL/tVDEax4d/gYmUqqKO4GBT7q+jQK2HX0mVorrqC
         I+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sLX9VVsQBCWvknvNFJcb8fxk1ANcgxuFWdDelisBpZc=;
        b=cMATd1p4cRYDTGvsOR32HAhxVh7MVtpCn8zvRJaoNWQcUpgCSEOLVXTTj1rDYFqiGA
         FMb8RfFOWw9YtG3wGu0/9kbn3izaaNgpv1gvze79y+1Qc/g2LCEqhKFeWYISZVLIqgor
         ehO6ZPIiqooZvgQD5CxlMp1Y/sfb/qNDaS/5Ajz5zmI7dtAvc4QfGkXUo8PDb+evsdrY
         evJ5uxllUVCoRzgr9iv/8bU8uY6T4kZFTx7MnoyfIz2TRYWx4xF815HF8vi8/zVNC7XQ
         y59T14GuLHQS09cyWnDsSYuQftj4aiXYWaKdExQ7SnDEwXXTSnpv9G3Ja/BouCJtyWOm
         6UvQ==
X-Gm-Message-State: APjAAAVUgckl6pN8bQl4pWC/dP3aSrc3TzAw8+99Hvt8WUdwK3Mk0vQE
        NSsog6cr/+HkIDaKa5+ICVvRCfWxuHU=
X-Google-Smtp-Source: APXvYqw9fB1deyi9XPBDcazGfhn5+M95DSwcb1+JhYoZK0QP5eRONgZUXHDNSu+pRs7VMjfpkzZFht0Of0o=
X-Received: by 2002:a65:42c6:: with SMTP id l6mr7060297pgp.442.1561697411305;
 Thu, 27 Jun 2019 21:50:11 -0700 (PDT)
Date:   Thu, 27 Jun 2019 21:50:08 -0700
Message-Id: <20190628045008.39926-1-walken@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] rbtree: avoid generating code twice for the cached versions
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

As was already noted in rbtree.h, the logic to cache rb_first (or rb_last)
can easily be implemented externally to the core rbtree api.

Change the implementation to do just that. Previously the update of
rb_leftmost was wired deeper into the implemntation, but there were
some disadvantages to that - mostly, lib/rbtree.c had separate
instantiations for rb_insert_color() vs rb_insert_color_cached(), as well
as rb_erase() vs rb_erase_cached(), which were doing exactly the same
thing save for the rb_leftmost update at the start of either function.

Change-Id: I0cb62be774fc0138b81188e6ae81d5f1da64578d
Signed-off-by: Michel Lespinasse <walken@google.com>
---
 include/linux/rbtree.h           | 70 +++++++++++++++++++++-----------
 include/linux/rbtree_augmented.h | 27 +++++-------
 lib/rbtree.c                     | 40 ++----------------
 3 files changed, 59 insertions(+), 78 deletions(-)

diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index fcbeed4053ef..9e8d41a90072 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -44,25 +44,9 @@ struct rb_root {
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
@@ -84,12 +68,6 @@ extern struct rb_node *rb_prev(const struct rb_node *);
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
@@ -99,8 +77,6 @@ extern void rb_replace_node(struct rb_node *victim, struct rb_node *new,
 			    struct rb_root *root);
 extern void rb_replace_node_rcu(struct rb_node *victim, struct rb_node *new,
 				struct rb_root *root);
-extern void rb_replace_node_cached(struct rb_node *victim, struct rb_node *new,
-				   struct rb_root_cached *root);
 
 static inline void rb_link_node(struct rb_node *node, struct rb_node *parent,
 				struct rb_node **rb_link)
@@ -148,4 +124,50 @@ static inline void rb_link_node_rcu(struct rb_node *node, struct rb_node *parent
 			typeof(*pos), field); 1; }); \
 	     pos = n)
 
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
+        if (root->rb_leftmost == node)
+                root->rb_leftmost = rb_next(node);
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
 #endif	/* _LINUX_RBTREE_H */
diff --git a/include/linux/rbtree_augmented.h b/include/linux/rbtree_augmented.h
index 9510c677ac70..f1ed3fc80bbb 100644
--- a/include/linux/rbtree_augmented.h
+++ b/include/linux/rbtree_augmented.h
@@ -42,10 +42,9 @@ struct rb_augment_callbacks {
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
@@ -60,7 +59,7 @@ static inline void
 rb_insert_augmented(struct rb_node *node, struct rb_root *root,
 		    const struct rb_augment_callbacks *augment)
 {
-	__rb_insert_augmented(node, root, false, NULL, augment->rotate);
+	__rb_insert_augmented(node, root, augment->rotate);
 }
 
 static inline void
@@ -68,8 +67,9 @@ rb_insert_augmented_cached(struct rb_node *node,
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
@@ -162,7 +162,6 @@ extern void __rb_erase_color(struct rb_node *parent, struct rb_root *root,
 
 static __always_inline struct rb_node *
 __rb_erase_augmented(struct rb_node *node, struct rb_root *root,
-		     struct rb_node **leftmost,
 		     const struct rb_augment_callbacks *augment)
 {
 	struct rb_node *child = node->rb_right;
@@ -170,9 +169,6 @@ __rb_erase_augmented(struct rb_node *node, struct rb_root *root,
 	struct rb_node *parent, *rebalance;
 	unsigned long pc;
 
-	if (leftmost && node == *leftmost)
-		*leftmost = rb_next(node);
-
 	if (!tmp) {
 		/*
 		 * Case 1: node to erase has no more than 1 child (easy!)
@@ -272,8 +268,7 @@ static __always_inline void
 rb_erase_augmented(struct rb_node *node, struct rb_root *root,
 		   const struct rb_augment_callbacks *augment)
 {
-	struct rb_node *rebalance = __rb_erase_augmented(node, root,
-							 NULL, augment);
+	struct rb_node *rebalance = __rb_erase_augmented(node, root, augment);
 	if (rebalance)
 		__rb_erase_color(rebalance, root, augment->rotate);
 }
@@ -282,11 +277,9 @@ static __always_inline void
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
 
 #endif	/* _LINUX_RBTREE_AUGMENTED_H */
diff --git a/lib/rbtree.c b/lib/rbtree.c
index d3ff682fd4b8..432e9c540178 100644
--- a/lib/rbtree.c
+++ b/lib/rbtree.c
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
@@ -449,38 +445,19 @@ static const struct rb_augment_callbacks dummy_callbacks = {
 
 void rb_insert_color(struct rb_node *node, struct rb_root *root)
 {
-	__rb_insert(node, root, false, NULL, dummy_rotate);
+	__rb_insert(node, root, dummy_rotate);
 }
 EXPORT_SYMBOL(rb_insert_color);
 
 void rb_erase(struct rb_node *node, struct rb_root *root)
 {
 	struct rb_node *rebalance;
-	rebalance = __rb_erase_augmented(node, root,
-					 NULL, &dummy_callbacks);
+	rebalance = __rb_erase_augmented(node, root, &dummy_callbacks);
 	if (rebalance)
 		____rb_erase_color(rebalance, root, dummy_rotate);
 }
 EXPORT_SYMBOL(rb_erase);
 
-void rb_insert_color_cached(struct rb_node *node,
-			    struct rb_root_cached *root, bool leftmost)
-{
-	__rb_insert(node, &root->rb_root, leftmost,
-		    &root->rb_leftmost, dummy_rotate);
-}
-EXPORT_SYMBOL(rb_insert_color_cached);
-
-void rb_erase_cached(struct rb_node *node, struct rb_root_cached *root)
-{
-	struct rb_node *rebalance;
-	rebalance = __rb_erase_augmented(node, &root->rb_root,
-					 &root->rb_leftmost, &dummy_callbacks);
-	if (rebalance)
-		____rb_erase_color(rebalance, &root->rb_root, dummy_rotate);
-}
-EXPORT_SYMBOL(rb_erase_cached);
-
 /*
  * Augmented rbtree manipulation functions.
  *
@@ -489,10 +466,9 @@ EXPORT_SYMBOL(rb_erase_cached);
  */
 
 void __rb_insert_augmented(struct rb_node *node, struct rb_root *root,
-			   bool newleft, struct rb_node **leftmost,
 	void (*augment_rotate)(struct rb_node *old, struct rb_node *new))
 {
-	__rb_insert(node, root, newleft, leftmost, augment_rotate);
+	__rb_insert(node, root, augment_rotate);
 }
 EXPORT_SYMBOL(__rb_insert_augmented);
 
@@ -603,16 +579,6 @@ void rb_replace_node(struct rb_node *victim, struct rb_node *new,
 }
 EXPORT_SYMBOL(rb_replace_node);
 
-void rb_replace_node_cached(struct rb_node *victim, struct rb_node *new,
-			    struct rb_root_cached *root)
-{
-	rb_replace_node(victim, new, &root->rb_root);
-
-	if (root->rb_leftmost == victim)
-		root->rb_leftmost = new;
-}
-EXPORT_SYMBOL(rb_replace_node_cached);
-
 void rb_replace_node_rcu(struct rb_node *victim, struct rb_node *new,
 			 struct rb_root *root)
 {
-- 
2.22.0.410.gd8fdbe21b5-goog

