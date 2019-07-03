Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C68C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 04:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E489821871
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 04:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dfDrYfXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfGCECK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 00:02:10 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:46527 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCECH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 00:02:07 -0400
Received: by mail-ot1-f73.google.com with SMTP id m16so603199otq.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 21:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WDsHmNGWuqrAS4+FRpWsgeaMLhOo2SWwVBu97IvOfUM=;
        b=dfDrYfXAQPlWOq1lxBT6k0BuqHQrN3BPBCz4kkBIui57GU9Eaq8d3jix9H1Ld+vusl
         zD9GT+BFSyykRYjnxXQzNBs5SC3NQVxH8EfH2OGrGKwQpshI5vZXx8ay/Dcie27ZVCv1
         xamZWGDi8zobBm6CYBZhLEW54qu2REEFlnFGspcYps7jANjCbDUnS1t05IVjE8yCpQMy
         Iq8YQ5E/xdDD4w4Qi1voyYBn8R/NMt/n4UuoseaqalvEwb3hWWTkuZcnvDh7WSubB/Ed
         1u5iMc5FusoFBvmU2fDULhsCS+EIGkuVlc9grA3N6dgD9p/0q/M4vmKFv7nNzphSXqwC
         /82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WDsHmNGWuqrAS4+FRpWsgeaMLhOo2SWwVBu97IvOfUM=;
        b=LRZZw0rTKg0VUAz4tyeQQODBHGLdgF1KBWkUyEFBPtXRSJHur906yen//HOiMvjFks
         KCIVW4eTj5FlhS3Qpvf40SkTpeNIhYb3qGwTIyxRJD/GCgDRnxZWrICJCJKoS8xrxnAL
         HbCi+AP3su417kXQk8vhWJEi/MT1rMi9l5vp/zCwQee0PJrek9kfWILELUZjb67IUuq/
         A+GlUWnmYzJV1qteMP4smZERUwFzeUCMl7HA6WAoIFeoILkHSTUaTWyXnkSVjQuEarRG
         f5jwNOkqTmuE+3KyiV8BnIpJ/lKVsCU7eCW5lRdgyZ5YRhIwYoDnnqsoiozB6OGCmf5S
         ATUQ==
X-Gm-Message-State: APjAAAXwh6jGluJ9dfXHJOkSWieZ4ogN1vDMpGjaJmn4S6ZfH7YCbf30
        RRcWJsiA0+XrzYfUs94F+Fh7Ae2S5y4=
X-Google-Smtp-Source: APXvYqzGUbtTaGIflmhtBdF9TDRbX4UsECPE1+WhXawQ7cSI8p+GY7DqeDHcvq8/wo8jkmp4q/SFm5Ieiu0=
X-Received: by 2002:aca:d80a:: with SMTP id p10mr5283157oig.105.1562126526458;
 Tue, 02 Jul 2019 21:02:06 -0700 (PDT)
Date:   Tue,  2 Jul 2019 21:01:56 -0700
In-Reply-To: <20190703040156.56953-1-walken@google.com>
Message-Id: <20190703040156.56953-4-walken@google.com>
Mime-Version: 1.0
References: <20190703040156.56953-1-walken@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3 3/3] augmented rbtree: rework the RB_DECLARE_CALLBACKS
 macro definition
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

Change the definition of the RBCOMPUTE function. The propagate
callback repeatedly calls RBCOMPUTE as it moves from leaf to root.
it wants to stop recomputing once the augmented subtree information
doesn't change. This was previously checked using the == operator,
but that only works when the augmented subtree information is a
scalar field. This commit modifies the RBCOMPUTE function so that
it now sets the augmented subtree information instead of returning it,
and returns a boolean value indicating if the propagate callback
should stop.

The motivation for this change is that I want to introduce augmented rbtree
uses where the augmented data for the subtree is a struct instead of a scalar.

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 include/linux/rbtree_augmented.h       | 24 ++++++++++++------------
 tools/include/linux/rbtree_augmented.h | 24 ++++++++++++------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/linux/rbtree_augmented.h b/include/linux/rbtree_augmented.h
index c5379d762fa9..b5e1c248d991 100644
--- a/include/linux/rbtree_augmented.h
+++ b/include/linux/rbtree_augmented.h
@@ -79,22 +79,19 @@ rb_insert_augmented_cached(struct rb_node *node,
  * RBNAME:      name of the rb_augment_callbacks structure
  * RBSTRUCT:    struct type of the tree nodes
  * RBFIELD:     name of struct rb_node field within RBSTRUCT
- * RBTYPE:      type of the RBAUGMENTED field
- * RBAUGMENTED: name of RBTYPE field within RBSTRUCT holding data for subtree
+ * RBAUGMENTED: name of field within RBSTRUCT holding data for subtree
  * RBCOMPUTE:   name of function that recomputes the RBAUGMENTED data
  */
 
-#define RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME, RBSTRUCT, RBFIELD,	\
-			     RBTYPE, RBAUGMENTED, RBCOMPUTE)		\
+#define RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME,				\
+			     RBSTRUCT, RBFIELD, RBAUGMENTED, RBCOMPUTE)	\
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
@@ -134,7 +131,7 @@ RBSTATIC const struct rb_augment_callbacks RBNAME = {			\
 
 #define RB_DECLARE_CALLBACKS_MAX(RBSTATIC, RBNAME, RBSTRUCT, RBFIELD,	      \
 				 RBTYPE, RBAUGMENTED, RBCOMPUTE)	      \
-static inline RBTYPE RBNAME ## _compute_max(RBSTRUCT *node)		      \
+static inline bool RBNAME ## _compute_max(RBSTRUCT *node, bool exit)	      \
 {									      \
 	RBSTRUCT *child;						      \
 	RBTYPE max = RBCOMPUTE(node);					      \
@@ -148,10 +145,13 @@ static inline RBTYPE RBNAME ## _compute_max(RBSTRUCT *node)		      \
 		if (child->RBAUGMENTED > max)				      \
 			max = child->RBAUGMENTED;			      \
 	}								      \
-	return max;							      \
+	if (exit && node->RBAUGMENTED == max)				      \
+		return true;						      \
+	node->RBAUGMENTED = max;					      \
+	return false;							      \
 }									      \
-RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME, RBSTRUCT, RBFIELD,		      \
-		     RBTYPE, RBAUGMENTED, RBNAME ## _compute_max)
+RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME,					      \
+		     RBSTRUCT, RBFIELD, RBAUGMENTED, RBNAME ## _compute_max)
 
 
 #define	RB_RED		0
diff --git a/tools/include/linux/rbtree_augmented.h b/tools/include/linux/rbtree_augmented.h
index 10a2f3f8c801..6e21487fe33d 100644
--- a/tools/include/linux/rbtree_augmented.h
+++ b/tools/include/linux/rbtree_augmented.h
@@ -81,22 +81,19 @@ rb_insert_augmented_cached(struct rb_node *node,
  * RBNAME:      name of the rb_augment_callbacks structure
  * RBSTRUCT:    struct type of the tree nodes
  * RBFIELD:     name of struct rb_node field within RBSTRUCT
- * RBTYPE:      type of the RBAUGMENTED field
- * RBAUGMENTED: name of RBTYPE field within RBSTRUCT holding data for subtree
+ * RBAUGMENTED: name of field within RBSTRUCT holding data for subtree
  * RBCOMPUTE:   name of function that recomputes the RBAUGMENTED data
  */
 
-#define RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME, RBSTRUCT, RBFIELD,	\
-			     RBTYPE, RBAUGMENTED, RBCOMPUTE)		\
+#define RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME,				\
+			     RBSTRUCT, RBFIELD, RBAUGMENTED, RBCOMPUTE)	\
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
@@ -113,7 +110,7 @@ RBNAME ## _rotate(struct rb_node *rb_old, struct rb_node *rb_new)	\
 	RBSTRUCT *old = rb_entry(rb_old, RBSTRUCT, RBFIELD);		\
 	RBSTRUCT *new = rb_entry(rb_new, RBSTRUCT, RBFIELD);		\
 	new->RBAUGMENTED = old->RBAUGMENTED;				\
-	old->RBAUGMENTED = RBCOMPUTE(old);				\
+	RBCOMPUTE(old, false);						\
 }									\
 RBSTATIC const struct rb_augment_callbacks RBNAME = {			\
 	.propagate = RBNAME ## _propagate,				\
@@ -136,7 +133,7 @@ RBSTATIC const struct rb_augment_callbacks RBNAME = {			\
 
 #define RB_DECLARE_CALLBACKS_MAX(RBSTATIC, RBNAME, RBSTRUCT, RBFIELD,	      \
 				 RBTYPE, RBAUGMENTED, RBCOMPUTE)	      \
-static inline RBTYPE RBNAME ## _compute_max(RBSTRUCT *node)		      \
+static inline bool RBNAME ## _compute_max(RBSTRUCT *node, bool exit)	      \
 {									      \
 	RBSTRUCT *child;						      \
 	RBTYPE max = RBCOMPUTE(node);					      \
@@ -150,10 +147,13 @@ static inline RBTYPE RBNAME ## _compute_max(RBSTRUCT *node)		      \
 		if (child->RBAUGMENTED > max)				      \
 			max = child->RBAUGMENTED;			      \
 	}								      \
-	return max;							      \
+	if (exit && node->RBAUGMENTED == max)				      \
+		return true;						      \
+	node->RBAUGMENTED = max;					      \
+	return false;							      \
 }									      \
-RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME, RBSTRUCT, RBFIELD,		      \
-		     RBTYPE, RBAUGMENTED, RBNAME ## _compute_max)
+RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME,					      \
+		     RBSTRUCT, RBFIELD, RBAUGMENTED, RBNAME ## _compute_max)
 
 
 #define	RB_RED		0
-- 
2.22.0.410.gd8fdbe21b5-goog

