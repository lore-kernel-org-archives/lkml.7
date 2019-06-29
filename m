Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61159C5B579
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 00:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CA82133F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 00:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RfPGmPm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfF2AuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 20:50:15 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:35274 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfF2AuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 20:50:15 -0400
Received: by mail-pg1-f201.google.com with SMTP id c18so3995170pgk.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 17:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lE7fL0x1FNghn+bhk+nj9woVohLBsXETXTWYnVgbFbw=;
        b=RfPGmPm4uehLlXLdGmuwKKatJoqT9vD1KZ9kycT9aIGknLJbO01oAwh83b7JhbQ80v
         h+vSIzheZ35RAdu6YhCTeIgOBceRc2BmQe5Gcog9WviNSLFULztxMR5l53+tWkh/kqgs
         mZMhkBeXMVPRo/z5s25Vzep6G3wU9wE0k+2d+gG/4N7J9omzUhohmBaO4zpd0O0HoPZB
         jTlJwgdtGx0E3tADUvYuETxe7XgjIIj6axVsdcflGjPxYVP/YlFIB1R4iNeRo8W0DdS7
         B0BjAd5hBFJWytQZoaXGQVOC7ZEmkj3NMh4TemAFlbMdn5ZNf7QNWHoq6iutfpcqhKVn
         YRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lE7fL0x1FNghn+bhk+nj9woVohLBsXETXTWYnVgbFbw=;
        b=TbY+R+XgnFtZZEull3BZf7negNMz2o0jQASrs6wda3LazMExfmb+aj+a1uqYL0BF2t
         Z1EH9bop4MLuXjP4K9kZ/NVqZv6qFYCTB6XdB00HLkSEsof95pzXzRNqD6GCqXZJrPj9
         FriMN3cvKMVBjDL912PyraIjTqeatorF5uy8iIw80FMjH6k3TzEJFj0ob3u4GJ4ksXCf
         wll9Dm3i5h2Z8Rl85OIPdVVRGQff+NZrt9VIXeP+K5I6275C+SUC03+dyNVgwtBoYAXG
         V7xBeBI26ED3JOyMZ9DlUpVZx0k11hs1G+hzoSpGaMsmXrOaswNhbMaqK28Jk5+LXE38
         oxoQ==
X-Gm-Message-State: APjAAAWXkRUgxilgO6oi0R+kQO0OmTeoLSe1BXaIC4RpjCgepv37OGlx
        daz/vB2JPQdLGdoo/EZrLcztNPLbqyk=
X-Google-Smtp-Source: APXvYqxJohzzHHwP/v21I1wIPR+Ksh52Bj8yllFtt29Yvl9b3SDmBvA328RdGuJJCN2uhQZ4hVezl7trWAo=
X-Received: by 2002:a63:2cd1:: with SMTP id s200mr11992224pgs.439.1561769414192;
 Fri, 28 Jun 2019 17:50:14 -0700 (PDT)
Date:   Fri, 28 Jun 2019 17:49:51 -0700
In-Reply-To: <20190629004952.6611-1-walken@google.com>
Message-Id: <20190629004952.6611-2-walken@google.com>
Mime-Version: 1.0
References: <20190629004952.6611-1-walken@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH 1/2] augmented rbtree: add comments for RB_DECLARE_CALLBACKS macro
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
 include/linux/rbtree_augmented.h | 54 +++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 21 deletions(-)

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
 
 
-- 
2.22.0.410.gd8fdbe21b5-goog
