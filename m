Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6448CC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230BF20828
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ndg19qz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfGBH6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:58:30 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:42849 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfGBH62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:58:28 -0400
Received: by mail-qk1-f201.google.com with SMTP id 199so10678611qkj.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MyCFuQq5ko67YX6Si/pQPaVDnP1YRV1u/+lUs0zjNfE=;
        b=Ndg19qz8VhjZjzxLnqutLwbZMf0Xunjz5lWQUgh6S6LYlQZFJ9UgqD7VA/GSy6OXE2
         OjIuu+Gnkj8GG2wCBYxhBFvCrn78efiLS5/3aoOmobA805a0tyqsUlj9qHDPyPLQhdxd
         JfM5iLGWhkPNrZSFOgMxTwU+8MkrJKHTBTJZSlWlr+aNg4NorIruCeT4LGL9TN8zKV7z
         9OzIq0K2l8IZo9wdlNaRHQFFzTGjRlKrSLoPrZP6eSR0JZ5UBV4jXs5qT4I3nTyBLmsT
         0pCRNBLyqmhTur/Vxgw8BcI/6Cje61FYIPUDRakGxt770pDk/jJHQDymC/Nnm7x+O0O/
         92vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MyCFuQq5ko67YX6Si/pQPaVDnP1YRV1u/+lUs0zjNfE=;
        b=ZzUrmRPm93Lq5mn03pl+gsB6VGDRTvurj6SvFSJ/26qUQ/2WoFyQLBySsY2zV7Gbaq
         wSMRsrQyYK0KGWocMFbIKPqGQ+fQrqmx01yB6ve5oTZNAEVFHv3tEWYQVn1oprKJHhT+
         XNXPpNVzaWtsQ4y6hPjaQSUFrDp+hNp8tfQoyQi2VNy76R123W9B51GUtAQXfXbg355W
         FuMaEnYFu7yTEC+n+VjQy7yaNHloc7FezuZnzGdf7rTjUYyBJmzllQBhkYQ+Noj3FZd4
         CwZ9YHuPfPNa9HyE7XpxZ6A3KkEH/yb4MZ3bbWQRUiopTc2GQxGHkjQtCCINtWMeOUN3
         x9kg==
X-Gm-Message-State: APjAAAUM9jAQ3V6l8gU51X8/tPPy6ODHTHaotUN/8/8dR6fm45wnuWXN
        E0738Co26z+fji11nmJPge4sEfwPKWk=
X-Google-Smtp-Source: APXvYqxUyY82cuvQ2oVIe96oK0XbtOVtx3yZ1vy8CRBTMnnLo6pIQOJUoMLJB2NSozQinJ+7VGsxSeHRjDo=
X-Received: by 2002:ac8:21f2:: with SMTP id 47mr24066467qtz.38.1562054306875;
 Tue, 02 Jul 2019 00:58:26 -0700 (PDT)
Date:   Tue,  2 Jul 2019 00:58:17 -0700
In-Reply-To: <20190702075819.34787-1-walken@google.com>
Message-Id: <20190702075819.34787-2-walken@google.com>
Mime-Version: 1.0
References: <20190702075819.34787-1-walken@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2 1/3] augmented rbtree: add comments for RB_DECLARE_CALLBACKS
 macro
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

Add a short comment summarizing the arguments to RB_DECLARE_CALLBACKS.
The arguments are also now capitalized. This copies the style of the
INTERVAL_TREE_DEFINE macro.

No functional changes in this commit, only comments and capitalization.

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 include/linux/rbtree_augmented.h       | 54 ++++++++++++++++----------
 tools/include/linux/rbtree_augmented.h | 54 ++++++++++++++++----------
 2 files changed, 66 insertions(+), 42 deletions(-)

diff --git a/include/linux/rbtree_augmented.h b/include/linux/rbtree_augmented.h
index f1ed3fc80bbb..5923495276e0 100644
--- a/include/linux/rbtree_augmented.h
+++ b/include/linux/rbtree_augmented.h
@@ -72,39 +72,51 @@ rb_insert_augmented_cached(struct rb_node *node,
 	rb_insert_augmented(node, &root->rb_root, augment);
 }
 
-#define RB_DECLARE_CALLBACKS(rbstatic, rbname, rbstruct, rbfield,	\
-			     rbtype, rbaugmented, rbcompute)		\
+/*
+ * Template for declaring augmented rbtree callbacks
+ *
+ * RBSTATIC:    'static' or empty
+ * RBNAME:      name of the rb_augment_callbacks structure
+ * RBSTRUCT:    struct type of the tree nodes
+ * RBFIELD:     name of struct rb_node field within RBSTRUCT
+ * RBTYPE:      type of the RBAUGMENTED field
+ * RBAUGMENTED: name of RBTYPE field within RBSTRUCT holding data for subtree
+ * RBCOMPUTE:   name of function that recomputes the RBAUGMENTED data
+ */
+
+#define RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME, RBSTRUCT, RBFIELD,	\
+			     RBTYPE, RBAUGMENTED, RBCOMPUTE)		\
 static inline void							\
-rbname ## _propagate(struct rb_node *rb, struct rb_node *stop)		\
+RBNAME ## _propagate(struct rb_node *rb, struct rb_node *stop)		\
 {									\
 	while (rb != stop) {						\
-		rbstruct *node = rb_entry(rb, rbstruct, rbfield);	\
-		rbtype augmented = rbcompute(node);			\
-		if (node->rbaugmented == augmented)			\
+		RBSTRUCT *node = rb_entry(rb, RBSTRUCT, RBFIELD);	\
+		RBTYPE augmented = RBCOMPUTE(node);			\
+		if (node->RBAUGMENTED == augmented)			\
 			break;						\
-		node->rbaugmented = augmented;				\
-		rb = rb_parent(&node->rbfield);				\
+		node->RBAUGMENTED = augmented;				\
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
+	old->RBAUGMENTED = RBCOMPUTE(old);				\
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
 
 
diff --git a/tools/include/linux/rbtree_augmented.h b/tools/include/linux/rbtree_augmented.h
index d008e1404580..ca25818714d3 100644
--- a/tools/include/linux/rbtree_augmented.h
+++ b/tools/include/linux/rbtree_augmented.h
@@ -74,39 +74,51 @@ rb_insert_augmented_cached(struct rb_node *node,
 			      newleft, &root->rb_leftmost, augment->rotate);
 }
 
-#define RB_DECLARE_CALLBACKS(rbstatic, rbname, rbstruct, rbfield,	\
-			     rbtype, rbaugmented, rbcompute)		\
+/*
+ * Template for declaring augmented rbtree callbacks
+ *
+ * RBSTATIC:    'static' or empty
+ * RBNAME:      name of the rb_augment_callbacks structure
+ * RBSTRUCT:    struct type of the tree nodes
+ * RBFIELD:     name of struct rb_node field within RBSTRUCT
+ * RBTYPE:      type of the RBAUGMENTED field
+ * RBAUGMENTED: name of RBTYPE field within RBSTRUCT holding data for subtree
+ * RBCOMPUTE:   name of function that recomputes the RBAUGMENTED data
+ */
+
+#define RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME, RBSTRUCT, RBFIELD,	\
+			     RBTYPE, RBAUGMENTED, RBCOMPUTE)		\
 static inline void							\
-rbname ## _propagate(struct rb_node *rb, struct rb_node *stop)		\
+RBNAME ## _propagate(struct rb_node *rb, struct rb_node *stop)		\
 {									\
 	while (rb != stop) {						\
-		rbstruct *node = rb_entry(rb, rbstruct, rbfield);	\
-		rbtype augmented = rbcompute(node);			\
-		if (node->rbaugmented == augmented)			\
+		RBSTRUCT *node = rb_entry(rb, RBSTRUCT, RBFIELD);	\
+		RBTYPE augmented = RBCOMPUTE(node);			\
+		if (node->RBAUGMENTED == augmented)			\
 			break;						\
-		node->rbaugmented = augmented;				\
-		rb = rb_parent(&node->rbfield);				\
+		node->RBAUGMENTED = augmented;				\
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
+	old->RBAUGMENTED = RBCOMPUTE(old);				\
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

