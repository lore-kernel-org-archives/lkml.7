Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BACC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF84425B95
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191576;
	bh=GZUqsTk4DRyMhsW1KtZI2tC5X5LSHWq2AHH1vJ4K+oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rgoh8BC6tYJ10xS5XxsEBuaVR+/M3lNxvDCXG+ARlMQ9KqF2MQKFyfU2krS6KQsQ8
	 l0BiQ+uM/NHj+KLcY4arQmq4/PP94I9dgrKbZzwm1ZRdqRUSgSyNPJtCwv5c1T3Jf4
	 Q8jEfErwQ9BhGKALxuvnZ6U/Oqqo9fEMr+8umOrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388828AbfE3EqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:46:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728657AbfE3DLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:11:44 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FA98244C4;
        Thu, 30 May 2019 03:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185904;
        bh=GZUqsTk4DRyMhsW1KtZI2tC5X5LSHWq2AHH1vJ4K+oM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XDq+ijSknErqK8+23pyCh04VQSURpX2Y8oEBR29tsWEgjAEcTnAsFIIU4xktW93cM
         p8niY5HmFqVrr5grz7vP/zZwlcQEOOnDeGKgGL3Cox0nDNMx4qRLrdbnpLs4aPq6ns
         JvUPcii+CCvnYlZ1bNbMDaN49vptAZ2z8bRSR1ds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        dri-devel@lists.freedesktop.org ("open list:DRM DRIVERS"),
        Eric Anholt <eric@anholt.net>, Sasha Levin <sashal@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 5.1 239/405] drm/pl111: fix possible object reference leak
Date:   Wed, 29 May 2019 20:03:57 -0700
Message-Id: <20190530030553.101349333@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit bc29d3a69d4c1bd1a103e8b3c1ed81b807c1870b ]

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
Signed-off-by: Eric Anholt <eric@anholt.net>
Link: https://patchwork.freedesktop.org/patch/msgid/1554307455-40361-6-git-send-email-wen.yang99@zte.com.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/pl111/pl111_versatile.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/pl111/pl111_versatile.c b/drivers/gpu/drm/pl111/pl111_versatile.c
index b9baefdba38a1..1c318ad32a8cd 100644
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
2.20.1



