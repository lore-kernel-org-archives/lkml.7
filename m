Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0862C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C37B2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfDJHrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:47:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbfDJHrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:47:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F6A5313D976;
        Wed, 10 Apr 2019 07:47:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-65.ams2.redhat.com [10.36.116.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93B54104C421;
        Wed, 10 Apr 2019 07:47:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id CD2A416E31; Wed, 10 Apr 2019 09:47:12 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm: add DRM_PRIME_CAP_LOCAL
Date:   Wed, 10 Apr 2019 09:47:12 +0200
Message-Id: <20190410074712.5649-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 10 Apr 2019 07:47:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers (for example qxl) support neither import nor export of
dma-bufs.  But you can still use dma-bufs to pass buffer references
from one process to another; drm_gem_prime_import() will figure the
dma-buf came from the same driver and just takes a reference in that
case instead of doing a full export/import.

Right now there is no way for userspace to figure it can do this.  Add
the new prime capability DRM_PRIME_CAP_LOCAL to indicate that.  Set the
bit for every driver which has the DRIVER_PRIME feature bit set.

Cc: Dave Airlie <airlied@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/uapi/drm/drm.h      | 1 +
 drivers/gpu/drm/drm_ioctl.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index 236b01a1fabf..b6157d48dc1a 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -632,6 +632,7 @@ struct drm_gem_open {
 #define DRM_CAP_PRIME			0x5
 #define  DRM_PRIME_CAP_IMPORT		0x1
 #define  DRM_PRIME_CAP_EXPORT		0x2
+#define  DRM_PRIME_CAP_LOCAL		0x4
 #define DRM_CAP_TIMESTAMP_MONOTONIC	0x6
 #define DRM_CAP_ASYNC_PAGE_FLIP		0x7
 /*
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index d337f161909c..00599758783b 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -241,6 +241,8 @@ static int drm_getcap(struct drm_device *dev, void *data, struct drm_file *file_
 	case DRM_CAP_PRIME:
 		req->value |= dev->driver->prime_fd_to_handle ? DRM_PRIME_CAP_IMPORT : 0;
 		req->value |= dev->driver->prime_handle_to_fd ? DRM_PRIME_CAP_EXPORT : 0;
+		req->value |= (dev->driver->driver_features & DRIVER_PRIME)
+			? DRM_PRIME_CAP_LOCAL : 0;
 		return 0;
 	case DRM_CAP_SYNCOBJ:
 		req->value = drm_core_check_feature(dev, DRIVER_SYNCOBJ);
-- 
2.18.1

