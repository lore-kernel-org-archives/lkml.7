Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF62CC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86308253D0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559190303;
	bh=GZUqsTk4DRyMhsW1KtZI2tC5X5LSHWq2AHH1vJ4K+oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v20hXtKIw+Y0aOWjPCYBZBJy0COL8dGigYkHIMh483OF/qtmBLEeo2Z8YcOx+J0Z1
	 9Z7nurDfMcz14bVZrYI3urKh5+EI0s3lmlWk1vS/eesTqp7w2iYwmNNq8JLYDQFvPc
	 xYEN3ur2t4o1ohCfs0Vxik7DKMqyn+UaFRRBOIRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733012AbfE3EZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:25:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729993AbfE3DOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:14:48 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D05424557;
        Thu, 30 May 2019 03:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186087;
        bh=GZUqsTk4DRyMhsW1KtZI2tC5X5LSHWq2AHH1vJ4K+oM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LnbXVTSaKnOD1zJn5CSxnOZD4LdwVB2rZQNk6hWfGUQH29NVPO4r3Nb3tSHEDLmP4
         cpEbOCNLjF8jgZlJBGe9JqxnP82JEVq99B/GIHTdwrsz518ALBxIY7FQLQJhrbu681
         BOo/x2T9tXrbvr+0dAnBatwUvg9zY8vMfbUyWGWA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        dri-devel@lists.freedesktop.org ("open list:DRM DRIVERS"),
        Eric Anholt <eric@anholt.net>, Sasha Levin <sashal@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 5.0 215/346] drm/pl111: fix possible object reference leak
Date:   Wed, 29 May 2019 20:04:48 -0700
Message-Id: <20190530030551.988267471@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
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



