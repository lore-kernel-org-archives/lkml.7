Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC9DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6059420700
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554104868;
	bh=r0M67wPQxgfcZNzsim3qcD337JPgXpk+jE6spV+IMJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1laLMmFXeVu14yR1swMFoa58MWPD2xmKM8SXZJoO2siZcUNHN8onPesb6JBCVmCdU
	 ogBgfc6DtoZZGbmAsqMmiQKVFyszh2d64Wx/v49j8b7TzP+aBXKG/pfqskwg4h5ABL
	 RICJJ0rIKG+kJDZah15KX28cPr0dymUelMxLhKVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbfDAHrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:47:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44439 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731769AbfDAHrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:47:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id i2so4312603pgj.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 00:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iqmyy0frGc7sVDuV1g+OXCIxMaTZ6r2+cyJVIwUF4BQ=;
        b=ofkWJAOs4CkUExVBHou6lKMTgrjBuH/H+hX3gAZC556UzSStvvm2ptPl7NV697OElA
         B9wM0flqMXv1GhUaPVuGApAIe4kuPMVouh/c7URFB9LGAF+jzzL7YG2suoKqFzNOGV+x
         xgW9OEZMY5YAB1Ou8PUlODRt0Emjd6UiwDHsxvVLLWLjGe0/I1wtQlHnle9AwZxfB3vW
         uA5FeFdt1e8qlli+Hp0EYvNz4s70xFsYgpU4v9w6qaaR/fkIiAag64skKsg6gYGvB/Dg
         4Ytv8OPEVpqIjc7jY9HBFTydduEUvTpgfSiB/E5yYZCrcVHKWPYcf5DvPPJkf3vB6QEn
         idfA==
X-Gm-Message-State: APjAAAUyUMtYAIToX+jppfUAX9AyheMiN4m9GhzvhgqpbJMCRAMLSoT0
        tS8XpI7tignPSDuXjXyDrt33AvmwaQ==
X-Google-Smtp-Source: APXvYqz7MENmRRrkE03JASOKsXJ+6kkupc/Jn18X9B+MoC48eypHb0NDW9ByNJ8QQvRVSH1sjg+FXQ==
X-Received: by 2002:a63:cc0a:: with SMTP id x10mr46904845pgf.179.1554104865837;
        Mon, 01 Apr 2019 00:47:45 -0700 (PDT)
Received: from xps15.imgcgcw.net ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id o5sm33428950pfa.135.2019.04.01.00.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 00:47:45 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lyude Paul <lyude@redhat.com>, Eric Anholt <eric@anholt.net>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 2/3] drm: Add a drm_gem_objects_lookup helper
Date:   Mon,  1 Apr 2019 02:47:29 -0500
Message-Id: <20190401074730.12241-3-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190401074730.12241-1-robh@kernel.org>
References: <20190401074730.12241-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the single handle drm_gem_object_lookup(),
drm_gem_objects_lookup() takes an array of handles and returns an array
of GEM objects.

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/gpu/drm/drm_gem.c | 46 +++++++++++++++++++++++++++++++--------
 include/drm/drm_gem.h     |  2 ++
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 388b3742e562..5c9bff45e5e1 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -663,6 +663,42 @@ void drm_gem_put_pages(struct drm_gem_object *obj, struct page **pages,
 }
 EXPORT_SYMBOL(drm_gem_put_pages);
 
+/**
+ * drm_gem_objects_lookup - look up GEM objects from an array of handles
+ * @filp: DRM file private date
+ * @handle: pointer to array of userspace handle
+ * @count: size of handle array
+ * @objs: pointer to array of drm_gem_object pointers
+ *
+ * Returns:
+ *
+ * @objs filled in with GEM object pointers. -ENOENT is returned on a lookup
+ * failure. 0 is returned on success.
+ */
+int drm_gem_objects_lookup(struct drm_file *filp, u32 *handle, int count,
+			   struct drm_gem_object **objs)
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
+EXPORT_SYMBOL(drm_gem_objects_lookup);
+
 /**
  * drm_gem_object_lookup - look up a GEM object from its handle
  * @filp: DRM file private date
@@ -678,15 +714,7 @@ drm_gem_object_lookup(struct drm_file *filp, u32 handle)
 {
 	struct drm_gem_object *obj;
 
-	spin_lock(&filp->table_lock);
-
-	/* Check if we currently have a reference on the object */
-	obj = idr_find(&filp->object_idr, handle);
-	if (obj)
-		drm_gem_object_get(obj);
-
-	spin_unlock(&filp->table_lock);
-
+	drm_gem_objects_lookup(filp, &handle, 1, &obj);
 	return obj;
 }
 EXPORT_SYMBOL(drm_gem_object_lookup);
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 2955aaab3dca..5404225e0194 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -381,6 +381,8 @@ struct page **drm_gem_get_pages(struct drm_gem_object *obj);
 void drm_gem_put_pages(struct drm_gem_object *obj, struct page **pages,
 		bool dirty, bool accessed);
 
+int drm_gem_objects_lookup(struct drm_file *filp, u32 *handle, int count,
+			   struct drm_gem_object **objs);
 struct drm_gem_object *drm_gem_object_lookup(struct drm_file *filp, u32 handle);
 long drm_gem_reservation_object_wait(struct drm_file *filep, u32 handle,
 				    bool wait_all, unsigned long timeout);
-- 
2.19.1

