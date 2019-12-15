Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1D3C47409
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 16:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F5B22B48
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 16:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576429176;
	bh=2HvYCOg9JIsgIj4BOPEnWKWDtaJsP2z/GYbgmDwmqNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uPmtgt+vkio4bsp/BvIO6j0471xuglGifnEhgTMKN+gZRvXiYDKQVPSES1PBZnOma
	 pGZyMrkXhWRC7E2fAhAKv3tH9FyqVTiKuLmuThnQZGYi2ily8tC7y/JLVdefWxK3S8
	 Pd2QvfcJK7pFurAByKbGlTACuAXSqutXCim8hBgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfLOQ7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 11:59:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:55122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfLOQ7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 11:59:32 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CB9E2467D;
        Sun, 15 Dec 2019 16:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576429171;
        bh=2HvYCOg9JIsgIj4BOPEnWKWDtaJsP2z/GYbgmDwmqNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R27jcToGRL+lsE9KhkS+b9kJsgcMxW/mcACduEJdBkspVYezS/MfYqQLFonqqJKc+
         y+aL2h9GYXGKSYag1paOupscaZJRze034RYmdZvkF/Agko/Io4jo02no3Q1TNXMWyg
         WHr5rxr13Afcq2OBDXZfCyAu6XmbCxcAzLB3lA2I=
Received: by wens.tw (Postfix, from userid 1000)
        id 47DAC5FD28; Mon, 16 Dec 2019 00:59:26 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 05/14] media: sun4i-csi: Deal with DRAM offset
Date:   Mon, 16 Dec 2019 00:59:15 +0800
Message-Id: <20191215165924.28314-6-wens@kernel.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191215165924.28314-1-wens@kernel.org>
References: <20191215165924.28314-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

On Allwinner SoCs, some high memory bandwidth devices do DMA directly
over the memory bus (called MBUS), instead of the system bus. These
devices include the CSI camera sensor interface, video (codec) engine,
display subsystem, etc.. The memory bus has a different addressing
scheme without the DRAM starting offset.

Deal with this using the "interconnects" property from the device tree,
or if that is not available, set dev->dma_pfn_offset to PHYS_PFN_OFFSET.

Fixes: 577bbf23b758 ("media: sunxi: Add A10 CSI driver")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../platform/sunxi/sun4i-csi/sun4i_csi.c      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
index f36dc6258900..b8b07c1de2a8 100644
--- a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
+++ b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -155,6 +156,27 @@ static int sun4i_csi_probe(struct platform_device *pdev)
 	subdev = &csi->subdev;
 	vdev = &csi->vdev;
 
+	/*
+	 * On Allwinner SoCs, some high memory bandwidth devices do DMA
+	 * directly over the memory bus (called MBUS), instead of the
+	 * system bus. The memory bus has a different addressing scheme
+	 * without the DRAM starting offset.
+	 *
+	 * In some cases this can be described by an interconnect in
+	 * the device tree. In other cases where the hardware is not
+	 * fully understood and the interconnect is left out of the
+	 * device tree, fall back to a default offset.
+	 */
+	if (of_find_property(csi->dev->of_node, "interconnects", NULL)) {
+		ret = of_dma_configure(csi->dev, csi->dev->of_node, true);
+		if (ret)
+			return ret;
+	} else {
+#ifdef PHYS_PFN_OFFSET
+		csi->dev->dma_pfn_offset = PHYS_PFN_OFFSET;
+#endif
+	}
+
 	csi->mdev.dev = csi->dev;
 	strscpy(csi->mdev.model, "Allwinner Video Capture Device",
 		sizeof(csi->mdev.model));
-- 
2.24.0

