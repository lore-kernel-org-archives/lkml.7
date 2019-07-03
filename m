Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61BDC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 04:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F17121721
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 04:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ADj3VWtl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfGCECQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 00:02:16 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:53866 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCECC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 00:02:02 -0400
Received: by mail-pg1-f201.google.com with SMTP id u4so748101pgb.20
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 21:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+Bz9EK5nXnCLx3MyMoxYoR0icGFjWu9nXmNokal9mQM=;
        b=ADj3VWtlBGJk4u5ja3UlOVOUmIjGfBzRceZgHd/JjkItmsL9/IvBWO8SH+vctlhEk4
         y0Czn5yxio8Pej1EY2pnnCDEOM4qIdwiwa42NoBg7rUITtuhKvv59CkMeZhq+Cu9lqke
         7/We+NoLCObmzpy4kLqiXY37wH8bB9z9apxSfHrhEOUi3wSDZ6O7G7/h8/YGDkqffy0E
         vTKU/mLGyqoKN5r07okLNUFNFig2aorpTHLrLtIfPR841tdvuEBcQvetc4tH44yDXPe+
         LGS1yLh0tGEJe+HLLgEtNniKY2TOjxEkmIRcl+NMI2AaOtMdDGAEtbNOefurcKfku4SL
         7Syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+Bz9EK5nXnCLx3MyMoxYoR0icGFjWu9nXmNokal9mQM=;
        b=NuZrs+bvPjmxm+8IneZS7ekRVVApgWvAKcxlUh0+MVP3gCrjtzVMAB0qqZr5ytrY/V
         BLWP3+JVFqRvHbmvU44PZWI59OaRGSIMjv7iNYPcqMXEhlo3D2oX1LGymcCFUP8a4wCY
         TsFiWiL65iyyUHNF63alIZ6HFh8fRZl17KRMPAtBPlLv647AUD75aZS2UgJNIOmj5WXW
         uhQSX6eOKUf2SZk/ic9mX0s1EvFOo2mIsXk0X3v1WhqUFzOeMRGI8Ic/ZxbMvwusbqfw
         JqwScqgBu2zNn3XzezCQVaFEf3dzunsfn7ReShM5xzpPMO4BTu+0sCu+Qd/DnCJ1qi3G
         P07A==
X-Gm-Message-State: APjAAAVjtXAbdB03w+LPt6iAxMlvM7cVJGF+7E+NuRiDnkl1Y5iY3DCk
        7vsfDrFe6P8Xe4bK7FNL2uWjyA2kV9c=
X-Google-Smtp-Source: APXvYqyvL3tIUNaaMFnL51aAcMnDwF12vdjuZZRdl9romMMrEcJCalpohkrbZ8zEgN7qtjZFCQg3IzQQSfk=
X-Received: by 2002:a63:1b5c:: with SMTP id b28mr3590819pgm.101.1562126521287;
 Tue, 02 Jul 2019 21:02:01 -0700 (PDT)
Date:   Tue,  2 Jul 2019 21:01:54 -0700
In-Reply-To: <20190703040156.56953-1-walken@google.com>
Message-Id: <20190703040156.56953-2-walken@google.com>
Mime-Version: 1.0
References: <20190703040156.56953-1-walken@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3 1/3] augmented rbtree: add comments for RB_DECLARE_CALLBACKS
 macro
From:   Michel Lespinasse <walken@google.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Michel Lespinasse <walken@google.com>,
        Davidlohr Bueso <dbueso@suse.de>
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
Acked-by: Davidlohr Bueso <dbueso@suse.de>
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
index 372a539314af..f46c1bf91f64 100644
--- a/tools/include/linux/rbtree_augmented.h
+++ b/tools/include/linux/rbtree_augmented.h
@@ -74,39 +74,51 @@ rb_insert_augmented_cached(struct rb_node *node,
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
 
 
-- 
2.22.0.410.gd8fdbe21b5-goog

