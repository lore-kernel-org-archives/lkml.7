Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36938C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0C1222CE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573227300;
	bh=zN3rpR9wQehYQ/IBV1VV1sl0YioG8ZqhL8nEdmNUJzI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=URVCSbtPCfZmEfwFvrC6qKazYzEMvhG8KXxir9YIhBsIiqZATgkJmdno/GHvT83wr
	 aMaKP7qodOC21F99Q89CKH6DRXtSPvfwmoHdXUxbVBT0oIl3nYE9g/4E0Ied2UtNvM
	 g+VIRyKheWAQC6mFm2cnsbBb3rWD4KyfJZg6KQuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfKHPe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:34:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:43952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfKHPe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:34:58 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26D3C21882;
        Fri,  8 Nov 2019 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573227297;
        bh=zN3rpR9wQehYQ/IBV1VV1sl0YioG8ZqhL8nEdmNUJzI=;
        h=From:To:Cc:Subject:Date:From;
        b=j31GgUY6npbSns0Lp5k0+nk597AYvETm92OAnsVM80BmSDDq/Wis/5qT56ttURWDV
         1uXWbY7AUUQKTXQYiHq3rvZoOL7Qo8tQ7jBLqVlB6evQhOapgA9k8bc3fiwmIi9/rv
         yFpZdui1H7yv5rkhsYAUron/xLU0NWjVjqUogFDk=
From:   Will Deacon <will@kernel.org>
To:     amd-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Nicolas Waisman <nico@semmle.com>
Subject: [PATCH v2] drm/radeon: Handle workqueue allocation failure
Date:   Fri,  8 Nov 2019 15:34:46 +0000
Message-Id: <20191108153446.21244-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the highly unlikely event that we fail to allocate the "radeon-crtc"
workqueue, we should bail cleanly rather than blindly marching on with a
NULL pointer installed for the 'flip_queue' field of the 'radeon_crtc'
structure.

This was reported previously by Nicolas, but I don't think his fix was
correct.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Michel Dänzer <michel@daenzer.net>
Reported-by: Nicolas Waisman <nico@semmle.com>
Link: https://lore.kernel.org/lkml/CADJ_3a8WFrs5NouXNqS5WYe7rebFP+_A5CheeqAyD_p7DFJJcg@mail.gmail.com/
Signed-off-by: Will Deacon <will@kernel.org>
---

v2: Add failure path to radeon_modeset_init(). Compile-tested only.

 drivers/gpu/drm/radeon/radeon_display.c | 29 +++++++++++++++++++------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index e81b01f8db90..177acee06620 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -668,21 +668,29 @@ static const struct drm_crtc_funcs radeon_crtc_funcs = {
 	.page_flip_target = radeon_crtc_page_flip_target,
 };
 
-static void radeon_crtc_init(struct drm_device *dev, int index)
+static int radeon_crtc_init(struct drm_device *dev, int index)
 {
 	struct radeon_device *rdev = dev->dev_private;
 	struct radeon_crtc *radeon_crtc;
+	struct workqueue_struct *wq;
 	int i;
 
 	radeon_crtc = kzalloc(sizeof(struct radeon_crtc) + (RADEONFB_CONN_LIMIT * sizeof(struct drm_connector *)), GFP_KERNEL);
 	if (radeon_crtc == NULL)
-		return;
+		return -ENOMEM;
+
+	wq = alloc_workqueue("radeon-crtc", WQ_HIGHPRI, 0);
+	if (unlikely(!wq)) {
+		kfree(radeon_crtc);
+		return - ENOMEM;
+	}
 
 	drm_crtc_init(dev, &radeon_crtc->base, &radeon_crtc_funcs);
 
 	drm_mode_crtc_set_gamma_size(&radeon_crtc->base, 256);
 	radeon_crtc->crtc_id = index;
-	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc", WQ_HIGHPRI, 0);
+	radeon_crtc->flip_queue = wq;
+
 	rdev->mode_info.crtcs[index] = radeon_crtc;
 
 	if (rdev->family >= CHIP_BONAIRE) {
@@ -711,6 +719,8 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 		radeon_atombios_init_crtc(dev, radeon_crtc);
 	else
 		radeon_legacy_init_crtc(dev, radeon_crtc);
+
+	return 0;
 }
 
 static const char *encoder_names[38] = {
@@ -1602,9 +1612,8 @@ int radeon_modeset_init(struct radeon_device *rdev)
 	rdev->ddev->mode_config.fb_base = rdev->mc.aper_base;
 
 	ret = radeon_modeset_create_props(rdev);
-	if (ret) {
-		return ret;
-	}
+	if (ret)
+		goto err_drm_mode_config_cleanup;
 
 	/* init i2c buses */
 	radeon_i2c_init(rdev);
@@ -1617,7 +1626,9 @@ int radeon_modeset_init(struct radeon_device *rdev)
 
 	/* allocate crtcs */
 	for (i = 0; i < rdev->num_crtc; i++) {
-		radeon_crtc_init(rdev->ddev, i);
+		ret = radeon_crtc_init(rdev->ddev, i);
+		if (ret)
+			goto err_drm_mode_config_cleanup;
 	}
 
 	/* okay we should have all the bios connectors */
@@ -1645,6 +1656,10 @@ int radeon_modeset_init(struct radeon_device *rdev)
 	ret = radeon_pm_late_init(rdev);
 
 	return 0;
+
+err_drm_mode_config_cleanup:
+	drm_mode_config_cleanup(rdev->ddev);
+	return ret;
 }
 
 void radeon_modeset_fini(struct radeon_device *rdev)
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

