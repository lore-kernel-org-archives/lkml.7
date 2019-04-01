Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736B8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B8520856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfDAODL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:03:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbfDAODK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:03:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A013F308622E;
        Mon,  1 Apr 2019 14:03:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6692E60159;
        Mon,  1 Apr 2019 14:03:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 94027A1E4; Mon,  1 Apr 2019 16:03:06 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        QEMU'S CIRRUS DEVICE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] drm/cirrus: add missing drm_helper_force_disable_all() call.
Date:   Mon,  1 Apr 2019 16:03:06 +0200
Message-Id: <20190401140306.28063-4-kraxel@redhat.com>
In-Reply-To: <20190401140306.28063-1-kraxel@redhat.com>
References: <20190401140306.28063-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 01 Apr 2019 14:03:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/cirrus/cirrus_mode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/cirrus/cirrus_mode.c b/drivers/gpu/drm/cirrus/cirrus_mode.c
index 7f9bc32af685..32ce2c1040b4 100644
--- a/drivers/gpu/drm/cirrus/cirrus_mode.c
+++ b/drivers/gpu/drm/cirrus/cirrus_mode.c
@@ -615,6 +615,7 @@ void cirrus_modeset_fini(struct cirrus_device *cdev)
 	cirrus_fbdev_fini(cdev);
 
 	if (cdev->mode_info.mode_config_initialized) {
+		drm_helper_force_disable_all(cdev->dev);
 		drm_mode_config_cleanup(cdev->dev);
 		cdev->mode_info.mode_config_initialized = false;
 	}
-- 
2.18.1

