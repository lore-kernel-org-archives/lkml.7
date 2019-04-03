Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37402C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93792075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfDCQD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:03:58 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:50972 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfDCQD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:03:56 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 500ECD032EF1EDFB10ED;
        Thu,  4 Apr 2019 00:03:54 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x33G3Zqf028733;
        Thu, 4 Apr 2019 00:03:35 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019040400040190-7533736 ;
          Thu, 4 Apr 2019 00:04:01 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Subject: [PATCH 7/7] drm/tegra: fix possible object reference leak
Date:   Thu, 4 Apr 2019 00:04:15 +0800
Message-Id: <1554307455-40361-8-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554307455-40361-1-git-send-email-wen.yang99@zte.com.cn>
References: <1554307455-40361-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-04-04 00:04:01,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-04-04 00:03:27,
        Serialize complete at 2019-04-04 00:03:27
X-MAIL: mse01.zte.com.cn x33G3Zqf028733
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to  of_get_child_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/gpu/drm/tegra/rgb.c:225:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 223, but without a corresponding object release within this function.
./drivers/gpu/drm/tegra/rgb.c:229:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 223, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-tegra@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/tegra/output.c | 2 ++
 drivers/gpu/drm/tegra/rgb.c    | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/output.c
index 9c2b9da..78553d7 100644
--- a/drivers/gpu/drm/tegra/output.c
+++ b/drivers/gpu/drm/tegra/output.c
@@ -193,6 +193,8 @@ void tegra_output_remove(struct tegra_output *output)
 
 	if (output->ddc)
 		put_device(&output->ddc->dev);
+	if (output->of_node)
+		of_node_put(output->of_node);
 }
 
 int tegra_output_init(struct drm_device *drm, struct tegra_output *output)
diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
index 28a78d3..ad683a2 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -221,12 +221,16 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
 	int err;
 
 	np = of_get_child_by_name(dc->dev->of_node, "rgb");
-	if (!np || !of_device_is_available(np))
+	if (!np || !of_device_is_available(np)) {
+		of_node_put(np);
 		return -ENODEV;
+	}
 
 	rgb = devm_kzalloc(dc->dev, sizeof(*rgb), GFP_KERNEL);
-	if (!rgb)
+	if (!rgb) {
+		of_node_put(np);
 		return -ENOMEM;
+	}
 
 	rgb->output.dev = dc->dev;
 	rgb->output.of_node = np;
-- 
2.9.5

