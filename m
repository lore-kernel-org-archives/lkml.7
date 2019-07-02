Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBC6C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3962183F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iaj8cDiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfGBH6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:58:34 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:55066 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfGBH6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:58:32 -0400
Received: by mail-pf1-f201.google.com with SMTP id c17so10411340pfb.21
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LIwtDnjBihXXGc0lnqU+ntqrJI81QQ5/J+WaYscOEsc=;
        b=iaj8cDiPcqJw9MKRhPBTTDf4L7oj0EAwsKPvOFsjQyD54v7IffqNj/mUCrSVo0RM1R
         xVX6A7SxMjwjcO9Zl0S780e5dZig07n/EJ6xcPGjPotM+ZUVG9TzmTP8jAFmxgdipjSr
         zDs7W7gN2G0nPCo02sbac1Ft/CFZG8yJoVS1OEtWv0lsOvJwsBntFCGRMQHHKWwl6GYq
         mMoSeGa+hhXEYPM1tHI+ntLcLwFHcWV/J1kuLkEcmRE6lgrlnEUsAj2+tRZTm7+bN6ji
         9ZmcvZR5WvOIgMDhNIqHpKHBoKaOSnr+TovllXBPoI7uSe8h27HK1LWjpLHjoY1guKOr
         HYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LIwtDnjBihXXGc0lnqU+ntqrJI81QQ5/J+WaYscOEsc=;
        b=SrReVMkrHHfYr1O3zaf7Pl1pZg9b6GNjS75aV5rdrF4b6iYrslLn+mXPmdaWOEDYt/
         65J5dWde+hHDlR0Pe+GH/vI25XrPxRXTMD7U2uYZ3CInDm8Nk4IOT2tzSMpU0Z6Z1DAy
         dYJ/J7tTnBiYkTkhsYsmCtrrKokKwIa1+z7F1L8lnSx2nbUJE6SbiSGlaxl0h96nHIg0
         HlrcMbZYHZmixaElfJC+wXsQBK+Jn8VIHnjGPxUKCRyUojMIGDSt/adq3SskzdfcA5JD
         eabWuAXYsC0te8NKz682M4gNSudny70WQelv84WMzYLIsTIKpnX14727dXQRIAFmpKuY
         6YQQ==
X-Gm-Message-State: APjAAAXg2x5d7u6D/j9OBLbnHFFAzpMfH/2UZODHJlJFxAsVGM7xELqc
        8EZNwehU/FzFBJLDNEiv0NHjpqyQjkA=
X-Google-Smtp-Source: APXvYqwgcn3e9xpRWPtf+OugsIbSrK4taLVp9UneSvpMkXzjsVJgjRIpqQxPyfjZrTsJ/Ai5gsBXL9TcMz4=
X-Received: by 2002:a65:4489:: with SMTP id l9mr11694176pgq.207.1562054311611;
 Tue, 02 Jul 2019 00:58:31 -0700 (PDT)
Date:   Tue,  2 Jul 2019 00:58:19 -0700
In-Reply-To: <20190702075819.34787-1-walken@google.com>
Message-Id: <20190702075819.34787-4-walken@google.com>
Mime-Version: 1.0
References: <20190702075819.34787-1-walken@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2 3/3] augmented rbtree: rework the RB_DECLARE_CALLBACKS
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

The motivation for this change is that I want to introduce augmented rbtree
uses where the augmented data for the subtree is a struct instead of a scalar.

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 include/linux/rbtree_augmented.h       | 28 +++++++++++++-------------
 tools/include/linux/rbtree_augmented.h | 28 +++++++++++++-------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/include/linux/rbtree_augmented.h b/include/linux/rbtree_augmented.h
index a471702c01e7..f8780a67ec04 100644
--- a/include/linux/rbtree_augmented.h
+++ b/include/linux/rbtree_augmented.h
@@ -75,26 +75,23 @@ rb_insert_augmented_cached(struct rb_node *node,
 /*
  * Template for declaring augmented rbtree callbacks (generic case)
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
@@ -134,7 +131,7 @@ RBSTATIC const struct rb_augment_callbacks RBNAME = {			\
 
 #define RB_DECLARE_CALLBACKS_MAX(RBSTRUCT, RBFIELD, RBTYPE, RBAUGMENTED,      \
 			     RBCOMPUTE, RBSTATIC, RBNAME)		      \
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
+RB_DECLARE_CALLBACKS(RBSTRUCT, RBFIELD, RBAUGMENTED, RBNAME ## _compute_max,  \
+		     RBSTATIC, RBNAME)
 
 
 #define	RB_RED		0
diff --git a/tools/include/linux/rbtree_augmented.h b/tools/include/linux/rbtree_augmented.h
index 4db1dcaf90b2..b5845898c2d8 100644
--- a/tools/include/linux/rbtree_augmented.h
+++ b/tools/include/linux/rbtree_augmented.h
@@ -77,26 +77,23 @@ rb_insert_augmented_cached(struct rb_node *node,
 /*
  * Template for declaring augmented rbtree callbacks (generic case)
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
 
 #define RB_DECLARE_CALLBACKS_MAX(RBSTRUCT, RBFIELD, RBTYPE, RBAUGMENTED,      \
 			     RBCOMPUTE, RBSTATIC, RBNAME)		      \
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
+RB_DECLARE_CALLBACKS(RBSTRUCT, RBFIELD, RBAUGMENTED, RBNAME ## _compute_max,  \
+		     RBSTATIC, RBNAME)
 
 
 #define	RB_RED		0
-- 
2.22.0.410.gd8fdbe21b5-goog

