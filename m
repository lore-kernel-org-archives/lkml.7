Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56BFC0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 18:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C692085A
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 18:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUL8J4xo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfHKSq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 14:46:29 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46394 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfHKSq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 14:46:29 -0400
Received: by mail-lj1-f195.google.com with SMTP id h13so970239ljc.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 11:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aELALDrW+i7a5BlA42yQNpA9Z5Hpp50rNx+gjusAsXA=;
        b=FUL8J4xo9QZASNM+Q7L0aom2WHHhWfOxknUEy5OCnQtrPp5he5ltWr2I5kKtWCn0Dl
         vZbzkU09dMuu+vgVh23QERoxSS+hfSt2FN6Y2994xh7u6J8+VHjPpUITALSYyZvWmB73
         TYQY33HI0vOk7xIJWLgaQDxCD5+TqTMyWSUPC1zcMfRlmn/bvMwfAnoUzJkXYiv6rDtx
         mGeIAmngp97FIufCmJpDAHRfvAbNghmzxq27XVb9nV3yLsJu7SfyAlzgY4rkLxRZS+tg
         jZTxrzZoDvZvyyjXnwqUOdtOVKOxac4FmC26rS5Hi+MKICsgyCVoJSP8QbC+FQwgeZnY
         PrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aELALDrW+i7a5BlA42yQNpA9Z5Hpp50rNx+gjusAsXA=;
        b=k75ClGXExb9suzs7wGX014K/vtu8p26oWZRxvsu/Yj+X8YpsxOxOAEAQizOuT+CHSJ
         AELXVlzCgj901T68tuSOefPsobVvh5SpviRl5z8+io2icglqCdM8XwFmzjBAtGGhGjsK
         sKASB3Md4m9QAjRwqPxDYhzpKXIh64ccw/2db1L+q33fFs3mXhkPKI3du0Q6XcaAwUTZ
         0jrNgDeuzxBa/xUVmJNdvSb9Vpm1LpFGeY+GUXD6AveU+UPtHhQielu5TSlhm0y4yQQd
         DbLHz9i4yF0+Xca90+xWSHQJ7/IapEbfzAZspSwCoLroRre3IL5ktKIlmBf7BROYJP34
         FRcg==
X-Gm-Message-State: APjAAAUZgAiQcHDYCQ/M+WgkuUOZXTAvcLluQcU/zsCOIW5Vt+ZqrPCo
        ImOXovezC+TytG4MAWaIbxI=
X-Google-Smtp-Source: APXvYqzV7uvQZkB42sv9VY5S2uvnnjKPAkIogU2XzLdf03r5HvBHjMVJe7p/oDRn2InPXImKzId+4A==
X-Received: by 2002:a2e:9f02:: with SMTP id u2mr1933631ljk.4.1565549186050;
        Sun, 11 Aug 2019 11:46:26 -0700 (PDT)
Received: from localhost.localdomain ([37.212.199.11])
        by smtp.gmail.com with ESMTPSA id t66sm1536425lje.66.2019.08.11.11.46.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 11:46:25 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/2] augmented rbtree: use max3() in the *_compute_max() function
Date:   Sun, 11 Aug 2019 20:46:12 +0200
Message-Id: <20190811184613.20463-2-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190811184613.20463-1-urezki@gmail.com>
References: <20190811184613.20463-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently there was introduced RB_DECLARE_CALLBACKS_MAX template.
One of the callback, to be more specific *_compute_max(), calculates
a maximum scalar value of node against its left/right sub-tree.

To simplify the code and improve readability we can switch and
make use of max3() macro that makes the code more transparent.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rbtree_augmented.h       | 40 +++++++++++++++++-----------------
 tools/include/linux/rbtree_augmented.h | 40 +++++++++++++++++-----------------
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/include/linux/rbtree_augmented.h b/include/linux/rbtree_augmented.h
index fdd421b8d9ae..fb29d6627646 100644
--- a/include/linux/rbtree_augmented.h
+++ b/include/linux/rbtree_augmented.h
@@ -119,26 +119,26 @@ RBSTATIC const struct rb_augment_callbacks RBNAME = {			\
 
 #define RB_DECLARE_CALLBACKS_MAX(RBSTATIC, RBNAME, RBSTRUCT, RBFIELD,	      \
 				 RBTYPE, RBAUGMENTED, RBCOMPUTE)	      \
-static inline bool RBNAME ## _compute_max(RBSTRUCT *node, bool exit)	      \
-{									      \
-	RBSTRUCT *child;						      \
-	RBTYPE max = RBCOMPUTE(node);					      \
-	if (node->RBFIELD.rb_left) {					      \
-		child = rb_entry(node->RBFIELD.rb_left, RBSTRUCT, RBFIELD);   \
-		if (child->RBAUGMENTED > max)				      \
-			max = child->RBAUGMENTED;			      \
-	}								      \
-	if (node->RBFIELD.rb_right) {					      \
-		child = rb_entry(node->RBFIELD.rb_right, RBSTRUCT, RBFIELD);  \
-		if (child->RBAUGMENTED > max)				      \
-			max = child->RBAUGMENTED;			      \
-	}								      \
-	if (exit && node->RBAUGMENTED == max)				      \
-		return true;						      \
-	node->RBAUGMENTED = max;					      \
-	return false;							      \
-}									      \
-RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME,					      \
+static inline RBTYPE RBNAME ## _get_max(struct rb_node *node)		    \
+{									    \
+	RBSTRUCT *tmp;							    \
+									    \
+	tmp = rb_entry_safe(node, RBSTRUCT, RBFIELD);			    \
+	return tmp ? tmp->RBAUGMENTED : 0;				    \
+}									    \
+									    \
+static inline bool RBNAME ## _compute_max(RBSTRUCT *node, bool exit)	    \
+{									    \
+	RBTYPE max = max3(RBCOMPUTE(node),				    \
+		RBNAME ## _get_max(node->RBFIELD.rb_left),		    \
+		RBNAME ## _get_max(node->RBFIELD.rb_right));		    \
+									    \
+	if (exit && node->RBAUGMENTED == max)				    \
+		return true;						    \
+	node->RBAUGMENTED = max;					    \
+	return false;							    \
+}									    \
+RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME,					    \
 		     RBSTRUCT, RBFIELD, RBAUGMENTED, RBNAME ## _compute_max)
 
 
diff --git a/tools/include/linux/rbtree_augmented.h b/tools/include/linux/rbtree_augmented.h
index 381aa948610d..3b8284479e98 100644
--- a/tools/include/linux/rbtree_augmented.h
+++ b/tools/include/linux/rbtree_augmented.h
@@ -121,26 +121,26 @@ RBSTATIC const struct rb_augment_callbacks RBNAME = {			\
 
 #define RB_DECLARE_CALLBACKS_MAX(RBSTATIC, RBNAME, RBSTRUCT, RBFIELD,	      \
 				 RBTYPE, RBAUGMENTED, RBCOMPUTE)	      \
-static inline bool RBNAME ## _compute_max(RBSTRUCT *node, bool exit)	      \
-{									      \
-	RBSTRUCT *child;						      \
-	RBTYPE max = RBCOMPUTE(node);					      \
-	if (node->RBFIELD.rb_left) {					      \
-		child = rb_entry(node->RBFIELD.rb_left, RBSTRUCT, RBFIELD);   \
-		if (child->RBAUGMENTED > max)				      \
-			max = child->RBAUGMENTED;			      \
-	}								      \
-	if (node->RBFIELD.rb_right) {					      \
-		child = rb_entry(node->RBFIELD.rb_right, RBSTRUCT, RBFIELD);  \
-		if (child->RBAUGMENTED > max)				      \
-			max = child->RBAUGMENTED;			      \
-	}								      \
-	if (exit && node->RBAUGMENTED == max)				      \
-		return true;						      \
-	node->RBAUGMENTED = max;					      \
-	return false;							      \
-}									      \
-RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME,					      \
+static inline RBTYPE RBNAME ## _get_max(struct rb_node *node)		    \
+{									    \
+	RBSTRUCT *tmp;							    \
+									    \
+	tmp = rb_entry_safe(node, RBSTRUCT, RBFIELD);			    \
+	return tmp ? tmp->RBAUGMENTED : 0;				    \
+}									    \
+									    \
+static inline bool RBNAME ## _compute_max(RBSTRUCT *node, bool exit)	    \
+{									    \
+	RBTYPE max = max3(RBCOMPUTE(node),				    \
+		RBNAME ## _get_max(node->RBFIELD.rb_left),		    \
+		RBNAME ## _get_max(node->RBFIELD.rb_right));		    \
+									    \
+	if (exit && node->RBAUGMENTED == max)				    \
+		return true;						    \
+	node->RBAUGMENTED = max;					    \
+	return false;							    \
+}									    \
+RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME,					    \
 		     RBSTRUCT, RBFIELD, RBAUGMENTED, RBNAME ## _compute_max)
 
 
-- 
2.11.0

