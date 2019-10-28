Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D954ECA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FE121835
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="KbPLKdZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731757AbfJ1VnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 17:43:18 -0400
Received: from vps.xff.cz ([195.181.215.36]:49932 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730592AbfJ1VnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1572298996; bh=fyyQI3ItgxBYKXPEf2uaXYMvRSi0utH9LPQLNQj2NLA=;
        h=From:To:Cc:Subject:Date:From;
        b=KbPLKdZFai12AyFY45X80z5E+QhMa46RXM0QVHLZUZlaNqwF63nvs1lAM2jvRpNcn
         QVxdtaUXAgGe2Q1k6XKnqdq2KMbsbwd+oyh3MfMCrTl5ykVgM8svGUdAeX8LFecO37
         8Vuq2LIvNlMXEGP8iQMDW16fZgDZ1tMyBIfPHZyw=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com
Cc:     Ondrej Jirman <megous@megous.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR ALLWINNER
        A10),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm: sun4i: Add support for suspending the display driver
Date:   Mon, 28 Oct 2019 22:43:13 +0100
Message-Id: <20191028214313.3463732-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shut down the display engine during suspend.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index a5757b11b730..c519d7cfcf43 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -346,6 +346,27 @@ static int sun4i_drv_add_endpoints(struct device *dev,
 	return count;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int sun4i_drv_drm_sys_suspend(struct device *dev)
+{
+        struct drm_device *drm = dev_get_drvdata(dev);
+
+        return drm_mode_config_helper_suspend(drm);
+}
+
+static int sun4i_drv_drm_sys_resume(struct device *dev)
+{
+        struct drm_device *drm = dev_get_drvdata(dev);
+
+        return drm_mode_config_helper_resume(drm);
+}
+#endif
+
+static const struct dev_pm_ops sun4i_drv_drm_pm_ops = {
+        SET_SYSTEM_SLEEP_PM_OPS(sun4i_drv_drm_sys_suspend,
+                                sun4i_drv_drm_sys_resume)
+};
+
 static int sun4i_drv_probe(struct platform_device *pdev)
 {
 	struct component_match *match = NULL;
@@ -418,6 +439,7 @@ static struct platform_driver sun4i_drv_platform_driver = {
 	.driver		= {
 		.name		= "sun4i-drm",
 		.of_match_table	= sun4i_drv_of_table,
+		.pm = &sun4i_drv_drm_pm_ops,
 	},
 };
 module_platform_driver(sun4i_drv_platform_driver);
-- 
2.23.0

