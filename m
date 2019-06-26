Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CF0C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555D72086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfFZG4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:56:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfFZGz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:55:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE765C057F2E;
        Wed, 26 Jun 2019 06:55:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7AAE05D71B;
        Wed, 26 Jun 2019 06:55:52 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 9B8E016E19; Wed, 26 Jun 2019 08:55:51 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/vram: store dumb bo dimensions.
Date:   Wed, 26 Jun 2019 08:55:50 +0200
Message-Id: <20190626065551.12956-2-kraxel@redhat.com>
In-Reply-To: <20190626065551.12956-1-kraxel@redhat.com>
References: <20190626065551.12956-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 26 Jun 2019 06:55:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store width and height of the bo.  Needed in case userspace
sets up a framebuffer with fb->width != bo->width..

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_vram_helper.h     | 1 +
 drivers/gpu/drm/drm_gem_vram_helper.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index 1a0ea18e7a74..3692dba167df 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -39,6 +39,7 @@ struct drm_gem_vram_object {
 	struct drm_gem_object gem;
 	struct ttm_buffer_object bo;
 	struct ttm_bo_kmap_obj kmap;
+	unsigned int width, height;
 
 	/* Supported placements are %TTM_PL_VRAM and %TTM_PL_SYSTEM */
 	struct ttm_placement placement;
diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 4de782ca26b2..c02bf7694117 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -377,6 +377,8 @@ int drm_gem_vram_fill_create_dumb(struct drm_file *file,
 	gbo = drm_gem_vram_create(dev, bdev, size, pg_align, interruptible);
 	if (IS_ERR(gbo))
 		return PTR_ERR(gbo);
+	gbo->width = args->width;
+	gbo->height = args->height;
 
 	ret = drm_gem_handle_create(file, &gbo->gem, &handle);
 	if (ret)
-- 
2.18.1

