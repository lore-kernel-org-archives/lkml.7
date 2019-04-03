Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B8BC10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD00D206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfDCQDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:03:53 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:50882 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfDCQDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:03:53 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 149B52EFD05E1E357149;
        Thu,  4 Apr 2019 00:03:49 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x33G3YG3028683;
        Thu, 4 Apr 2019 00:03:34 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019040400040063-7533734 ;
          Thu, 4 Apr 2019 00:04:00 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS)
Subject: [PATCH 5/7] drm/pl111: fix possible object reference leak
Date:   Thu, 4 Apr 2019 00:04:13 +0800
Message-Id: <1554307455-40361-6-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554307455-40361-1-git-send-email-wen.yang99@zte.com.cn>
References: <1554307455-40361-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-04-04 00:04:00,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-04-04 00:03:26,
        Serialize complete at 2019-04-04 00:03:26
X-MAIL: mse01.zte.com.cn x33G3YG3028683
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_find_matching_node_and_match returns a node pointer with
refcount incremented thus it must be explicitly decremented after the
last usage.

Detected by coccinelle with the following warnings:
drivers/gpu/drm/pl111/pl111_versatile.c:333:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 317, but without a corresponding object release within this function.
drivers/gpu/drm/pl111/pl111_versatile.c:340:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 317, but without a corresponding object release within this function.
drivers/gpu/drm/pl111/pl111_versatile.c:346:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 317, but without a corresponding object release within this function.
drivers/gpu/drm/pl111/pl111_versatile.c:354:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 317, but without a corresponding object release within this function.
drivers/gpu/drm/pl111/pl111_versatile.c:395:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 317, but without a corresponding object release within this function.
drivers/gpu/drm/pl111/pl111_versatile.c:402:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 317, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Eric Anholt <eric@anholt.net> (supporter:DRM DRIVER FOR ARM PL111 CLCD)
Cc: David Airlie <airlied@linux.ie> (maintainer:DRM DRIVERS)
Cc: Daniel Vetter <daniel@ffwll.ch> (maintainer:DRM DRIVERS)
Cc: dri-devel@lists.freedesktop.org (open list:DRM DRIVERS)
Cc: linux-kernel@vger.kernel.org (open list)
---
 drivers/gpu/drm/pl111/pl111_versatile.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/pl111/pl111_versatile.c b/drivers/gpu/drm/pl111/pl111_versatile.c
index b9baefd..1c318ad 100644
--- a/drivers/gpu/drm/pl111/pl111_versatile.c
+++ b/drivers/gpu/drm/pl111/pl111_versatile.c
@@ -330,6 +330,7 @@ int pl111_versatile_init(struct device *dev, struct pl111_drm_dev_private *priv)
 		ret = vexpress_muxfpga_init();
 		if (ret) {
 			dev_err(dev, "unable to initialize muxfpga driver\n");
+			of_node_put(np);
 			return ret;
 		}
 
@@ -337,17 +338,20 @@ int pl111_versatile_init(struct device *dev, struct pl111_drm_dev_private *priv)
 		pdev = of_find_device_by_node(np);
 		if (!pdev) {
 			dev_err(dev, "can't find the sysreg device, deferring\n");
+			of_node_put(np);
 			return -EPROBE_DEFER;
 		}
 		map = dev_get_drvdata(&pdev->dev);
 		if (!map) {
 			dev_err(dev, "sysreg has not yet probed\n");
 			platform_device_put(pdev);
+			of_node_put(np);
 			return -EPROBE_DEFER;
 		}
 	} else {
 		map = syscon_node_to_regmap(np);
 	}
+	of_node_put(np);
 
 	if (IS_ERR(map)) {
 		dev_err(dev, "no Versatile syscon regmap\n");
-- 
2.9.5

