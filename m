Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27BBC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A7420882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbfDBJFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:05:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDBJFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:05:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AEA038AE41;
        Tue,  2 Apr 2019 09:05:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B08F6155F;
        Tue,  2 Apr 2019 09:05:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id A3038A1E0; Tue,  2 Apr 2019 11:04:59 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/bochs: drop mode_config_initialized
Date:   Tue,  2 Apr 2019 11:04:58 +0200
Message-Id: <20190402090459.12126-2-kraxel@redhat.com>
In-Reply-To: <20190402090459.12126-1-kraxel@redhat.com>
References: <20190402090459.12126-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 02 Apr 2019 09:05:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs.h     | 1 -
 drivers/gpu/drm/bochs/bochs_kms.c | 8 ++------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index 03711394f1ed..a7f6723bebdd 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -73,7 +73,6 @@ struct bochs_device {
 	struct drm_crtc crtc;
 	struct drm_encoder encoder;
 	struct drm_connector connector;
-	bool mode_config_initialized;
 
 	/* ttm */
 	struct {
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 93cb27f93d39..485f9cf05e8b 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -267,7 +267,6 @@ const struct drm_mode_config_funcs bochs_mode_funcs = {
 int bochs_kms_init(struct bochs_device *bochs)
 {
 	drm_mode_config_init(bochs->dev);
-	bochs->mode_config_initialized = true;
 
 	bochs->dev->mode_config.max_width = 8192;
 	bochs->dev->mode_config.max_height = 8192;
@@ -292,9 +291,6 @@ int bochs_kms_init(struct bochs_device *bochs)
 
 void bochs_kms_fini(struct bochs_device *bochs)
 {
-	if (bochs->mode_config_initialized) {
-		drm_atomic_helper_shutdown(bochs->dev);
-		drm_mode_config_cleanup(bochs->dev);
-		bochs->mode_config_initialized = false;
-	}
+	drm_atomic_helper_shutdown(bochs->dev);
+	drm_mode_config_cleanup(bochs->dev);
 }
-- 
2.18.1

