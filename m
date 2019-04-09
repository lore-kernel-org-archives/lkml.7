Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39CDC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B4D2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554843286;
	bh=oR6ZjBvnK0XuGFoe3SHw78t0Uci5NgEaPo1MdabY55w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZOsA+6rSaYv1NdEZQyW9ClGER+7iknACdm1Bzj/DtZ2AlPy9egR91TDs5ph9kMZpF
	 BoWDDW4A0sFwQo030KPPxlv3Bis+cYoZt36blT5S6cOwOMCszhDPKe/VxQbr83boqb
	 s2xQc5fohTnlVDcEbrXljK4Lv0K1gYwyfzzPWaP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfDIUyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:54:45 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41278 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfDIUyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 16:54:32 -0400
Received: by mail-oi1-f194.google.com with SMTP id v7so14807669oie.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 13:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZmRuFlM08g2DvXWoccIjmnRAB0mfVQU1sbM2/zfQB84=;
        b=rrGBfOMawM5TzRpo1xZ29kKm8ciMJk/EuExC1yfhPG/7ut8nThPq/RdDSVI4r0NvrF
         gSK4pGY5S+5jw3PyA9+WDeJD3GTyGk9lZSHO4RFUEY/CXisyPyzBIKz0+8vVPvlekYUx
         /4sIwzNs5dY0mIQoYrxb4mFULJ6DCrb6BCkaCADOufB/N3pnj0fKlrdZkNGVbrlBYVOp
         gEfDCCtEGos/zJgcbsC9y/gX52CA5hBKRM/vtVRvTQ4eLte7kjyUa0zV2eKSamS1bOXm
         6sfCYHuWTx450CruZo00ofrnEeJqNLCaJcNN+HJOCbSbB7xCgn7tJwAwa7rlg7A02Bos
         nw+A==
X-Gm-Message-State: APjAAAXAKQ+HjgExQgTkwEnm+44oizTIHJQT5y9/mYH88/uiBZ5015ym
        po27PALFU6tB+TuJSX4FeA==
X-Google-Smtp-Source: APXvYqzcRSsc545BWdc49hHN8ThVWJVtcqUr4s/JRGNku/UL4k0Yir2qUMimDsavbXIprbiYjCTB/w==
X-Received: by 2002:aca:3746:: with SMTP id e67mr220414oia.37.1554843271211;
        Tue, 09 Apr 2019 13:54:31 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id o66sm6472175oig.11.2019.04.09.13.54.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Apr 2019 13:54:30 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: [PATCH v3 2/3] drm: Add a drm_gem_objects_lookup helper
Date:   Tue,  9 Apr 2019 15:54:26 -0500
Message-Id: <20190409205427.6943-3-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190409205427.6943-1-robh@kernel.org>
References: <20190409205427.6943-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the single handle drm_gem_object_lookup(),
drm_gem_objects_lookup() takes an array of handles and returns an array
of GEM objects.

v2:
- Take the userspace pointer directly and allocate the array.
- Expand the function documentation.

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/gpu/drm/drm_gem.c | 93 ++++++++++++++++++++++++++++++++++-----
 include/drm/drm_gem.h     |  2 +
 2 files changed, 85 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 388b3742e562..faa2718e85e8 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -663,6 +663,85 @@ void drm_gem_put_pages(struct drm_gem_object *obj, struct page **pages,
 }
 EXPORT_SYMBOL(drm_gem_put_pages);

+static int objects_lookup(struct drm_file *filp, u32 *handle, int count,
+			  struct drm_gem_object **objs)
+{
+	int i, ret = 0;
+	struct drm_gem_object *obj;
+
+	spin_lock(&filp->table_lock);
+
+	for (i = 0; i < count; i++) {
+		/* Check if we currently have a reference on the object */
+		obj = idr_find(&filp->object_idr, handle[i]);
+		if (!obj) {
+			ret = -ENOENT;
+			break;
+		}
+		drm_gem_object_get(obj);
+		objs[i] = obj;
+	}
+	spin_unlock(&filp->table_lock);
+
+	return ret;
+}
+
+/**
+ * drm_gem_objects_lookup - look up GEM objects from an array of handles
+ * @filp: DRM file private date
+ * @bo_handles: user pointer to array of userspace handle
+ * @count: size of handle array
+ * @objs_out: returned pointer to array of drm_gem_object pointers
+ *
+ * Takes an array of userspace handles and returns a newly allocated array of
+ * GEM objects.
+ *
+ * For a single handle lookup, use drm_gem_object_lookup().
+ *
+ * Returns:
+ *
+ * @objs filled in with GEM object pointers. Returned GEM objects need to be
+ * released with drm_gem_object_put(). -ENOENT is returned on a lookup
+ * failure. 0 is returned on success.
+ *
+ */
+int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
+			   int count, struct drm_gem_object ***objs_out)
+{
+	int ret;
+	u32 *handles;
+	struct drm_gem_object **objs;
+
+	if (!count)
+		return 0;
+
+	objs = kvmalloc_array(count, sizeof(struct drm_gem_object *),
+			     GFP_KERNEL | __GFP_ZERO);
+	if (!objs)
+		return -ENOMEM;
+
+	handles = kvmalloc_array(count, sizeof(u32), GFP_KERNEL);
+	if (!handles) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (copy_from_user(handles, bo_handles, count * sizeof(u32))) {
+		ret = -EFAULT;
+		DRM_DEBUG("Failed to copy in GEM handles\n");
+		goto out;
+	}
+
+	ret = objects_lookup(filp, handles, count, objs);
+	*objs_out = objs;
+
+out:
+	kvfree(handles);
+	return ret;
+
+}
+EXPORT_SYMBOL(drm_gem_objects_lookup);
+
 /**
  * drm_gem_object_lookup - look up a GEM object from its handle
  * @filp: DRM file private date
@@ -672,21 +751,15 @@ EXPORT_SYMBOL(drm_gem_put_pages);
  *
  * A reference to the object named by the handle if such exists on @filp, NULL
  * otherwise.
+ *
+ * If looking up an array of handles, use drm_gem_objects_lookup().
  */
 struct drm_gem_object *
 drm_gem_object_lookup(struct drm_file *filp, u32 handle)
 {
-	struct drm_gem_object *obj;
-
-	spin_lock(&filp->table_lock);
-
-	/* Check if we currently have a reference on the object */
-	obj = idr_find(&filp->object_idr, handle);
-	if (obj)
-		drm_gem_object_get(obj);
-
-	spin_unlock(&filp->table_lock);
+	struct drm_gem_object *obj = NULL;

+	objects_lookup(filp, &handle, 1, &obj);
 	return obj;
 }
 EXPORT_SYMBOL(drm_gem_object_lookup);
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 2955aaab3dca..5ee85c9eaa9d 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -381,6 +381,8 @@ struct page **drm_gem_get_pages(struct drm_gem_object *obj);
 void drm_gem_put_pages(struct drm_gem_object *obj, struct page **pages,
 		bool dirty, bool accessed);

+int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
+			   int count, struct drm_gem_object ***objs_out);
 struct drm_gem_object *drm_gem_object_lookup(struct drm_file *filp, u32 handle);
 long drm_gem_reservation_object_wait(struct drm_file *filep, u32 handle,
 				    bool wait_all, unsigned long timeout);
--
2.19.1
