Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B4EC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB2D2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mEG+Kk+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406045AbfFKRWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:22:14 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:58254 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405821AbfFKRWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:22:14 -0400
Received: from mailhost.synopsys.com (unknown [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B9498C016F;
        Tue, 11 Jun 2019 17:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1560273733; bh=0vOMGLO1nb4/1qQXTnpKwZ5ss3VewMScaHY/JKElpRU=;
        h=From:To:Cc:Subject:Date:From;
        b=mEG+Kk+MU17YGXVVNiMP3HavxsIygpQwFuDgaPF+bHbluiugCJ2D5Lkt2ZBC/a1VI
         bvvSqdTRwWuVbzoXESWnEJFYLswnqFnbtAEWIlrYI6Lj3u9hygj2hSQEm4TbCI0owS
         8pXg1m1FIasnnAzp7MB4zTylHtWBBOYe/MMNLEa+EiN9/V5vN8i8se3hAQO6oKjmqV
         1MBohj45Ky1pn1VzpuYrVSAUFuLti88i1VK4epQIeMFit7S/2PWEPflOPWZsfxDCYT
         XzO+bvShRqhgABG5Rpgs4O9X4cyAhVF/Btm5YBc/9k48TL5eoI1xGOlQbjVh9mgGJB
         rbuSCx9xXR6PA==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.8.58])
        by mailhost.synopsys.com (Postfix) with ESMTP id 97909A022E;
        Tue, 11 Jun 2019 17:22:08 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     dri-devel@lists.freedesktop.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] drm/arcpgu: rework encoder search
Date:   Tue, 11 Jun 2019 20:21:59 +0300
Message-Id: <20190611172159.24048-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using non-standard "encoder-slave" property to find
encoder let's find it by associated endpoint.

While I'm on it add corresponding log message if we don't find
any encoder and we assume that we use virtual LCD on the
simulation platform.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 drivers/gpu/drm/arc/arcpgu_drv.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arc/arcpgu_drv.c b/drivers/gpu/drm/arc/arcpgu_drv.c
index c9f78397d345..d08b9977f021 100644
--- a/drivers/gpu/drm/arc/arcpgu_drv.c
+++ b/drivers/gpu/drm/arc/arcpgu_drv.c
@@ -23,6 +23,7 @@
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_of.h>
 #include <drm/drm_probe_helper.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
@@ -54,7 +55,7 @@ static int arcpgu_load(struct drm_device *drm)
 {
 	struct platform_device *pdev = to_platform_device(drm->dev);
 	struct arcpgu_drm_private *arcpgu;
-	struct device_node *encoder_node;
+	struct device_node *encoder_node = NULL, *endpoint_node = NULL;
 	struct resource *res;
 	int ret;
 
@@ -89,14 +90,23 @@ static int arcpgu_load(struct drm_device *drm)
 	if (arc_pgu_setup_crtc(drm) < 0)
 		return -ENODEV;
 
-	/* find the encoder node and initialize it */
-	encoder_node = of_parse_phandle(drm->dev->of_node, "encoder-slave", 0);
+	/*
+	 * There is only one output port inside each device. It is linked with
+	 * encoder endpoint.
+	 */
+	endpoint_node = of_graph_get_next_endpoint(pdev->dev.of_node, NULL);
+	if (endpoint_node) {
+		encoder_node = of_graph_get_remote_port_parent(endpoint_node);
+		of_node_put(endpoint_node);
+	}
+
 	if (encoder_node) {
 		ret = arcpgu_drm_hdmi_init(drm, encoder_node);
 		of_node_put(encoder_node);
 		if (ret < 0)
 			return ret;
 	} else {
+		dev_info(drm->dev, "no encoder found. Assumed virtual LCD on simulation platform\n");
 		ret = arcpgu_drm_sim_init(drm, NULL);
 		if (ret < 0)
 			return ret;
-- 
2.21.0

