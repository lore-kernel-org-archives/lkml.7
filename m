Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E9EC43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 17:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CAF22B48
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 17:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576429219;
	bh=YiZkGwkK67xjKvh04OG2iNzUX1jhnitIyudLUFuCRas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kxfE0w5jwirJLA+AzMlAuY/8QLXkKtY8SkoJTsdIQZuRnr6CF/MFAkJ0Ski2gZ1gk
	 Bc9EIyvTvLdDF7XEnFeu2wOgtcmAArcObyxoSuVosXiazruI71PcVxNZhGVRH9gpKd
	 MwEVsNaVYFcC587pCtLMOJfsVeA1v8hiNkmuQr4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfLOQ7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 11:59:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:54988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbfLOQ7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 11:59:30 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D472224686;
        Sun, 15 Dec 2019 16:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576429170;
        bh=YiZkGwkK67xjKvh04OG2iNzUX1jhnitIyudLUFuCRas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2qlgAGADNndp5PkpCyzmH5tNeE7ulCCZUZkYrmoWcmcckE1Wso4CrFtsoe3I8oGZP
         ZNHOFwmac4zmMoRG3gtuQegrM6CF6zYu/34/FSIdhKlG6dD0HUzm0xPJz0T+i9ijyM
         oyisXQLNtZHdEJ+rJH05YPBTANwfMebPkUO5K09k=
Received: by wens.tw (Postfix, from userid 1000)
        id 433D25FD5D; Mon, 16 Dec 2019 00:59:26 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 04/14] media: sun4i-csi: Fix [HV]sync polarity handling
Date:   Mon, 16 Dec 2019 00:59:14 +0800
Message-Id: <20191215165924.28314-5-wens@kernel.org>
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

The Allwinner camera sensor interface has a different definition of
[HV]sync. While the timing diagram uses the names HSYNC and VSYNC,
the note following the diagram and register names use HREF and VREF.
Combined they imply the hardware uses either [HV]REF or inverted
[HV]SYNC. There are also registers to set horizontal skip lengths
in pixels and vertical skip lengths in lines, also known as back
porches.

Fix the polarity handling by using the opposite polarity flag for
the checks. Also rename `[hv]sync_pol` to `[hv]ref_pol` to better
match the hardware register description.

Fixes: 577bbf23b758 ("media: sunxi: Add A10 CSI driver")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../media/platform/sunxi/sun4i-csi/sun4i_csi.h |  4 ++--
 .../media/platform/sunxi/sun4i-csi/sun4i_dma.c | 18 +++++++++++++-----
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.h b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.h
index 001c8bde006c..88d39b3554c4 100644
--- a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.h
+++ b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.h
@@ -22,8 +22,8 @@
 #define CSI_CFG_INPUT_FMT(fmt)			((fmt) << 20)
 #define CSI_CFG_OUTPUT_FMT(fmt)			((fmt) << 16)
 #define CSI_CFG_YUV_DATA_SEQ(seq)		((seq) << 8)
-#define CSI_CFG_VSYNC_POL(pol)			((pol) << 2)
-#define CSI_CFG_HSYNC_POL(pol)			((pol) << 1)
+#define CSI_CFG_VREF_POL(pol)			((pol) << 2)
+#define CSI_CFG_HREF_POL(pol)			((pol) << 1)
 #define CSI_CFG_PCLK_POL(pol)			((pol) << 0)
 
 #define CSI_CPT_CTRL_REG		0x08
diff --git a/drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c b/drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c
index 8b567d0f019b..78fa1c535ac6 100644
--- a/drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c
+++ b/drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c
@@ -228,7 +228,7 @@ static int sun4i_csi_start_streaming(struct vb2_queue *vq, unsigned int count)
 	struct sun4i_csi *csi = vb2_get_drv_priv(vq);
 	struct v4l2_fwnode_bus_parallel *bus = &csi->bus;
 	const struct sun4i_csi_format *csi_fmt;
-	unsigned long hsync_pol, pclk_pol, vsync_pol;
+	unsigned long href_pol, pclk_pol, vref_pol;
 	unsigned long flags;
 	unsigned int i;
 	int ret;
@@ -278,13 +278,21 @@ static int sun4i_csi_start_streaming(struct vb2_queue *vq, unsigned int count)
 	writel(CSI_WIN_CTRL_H_ACTIVE(csi->fmt.height),
 	       csi->regs + CSI_WIN_CTRL_H_REG);
 
-	hsync_pol = !!(bus->flags & V4L2_MBUS_HSYNC_ACTIVE_HIGH);
-	vsync_pol = !!(bus->flags & V4L2_MBUS_VSYNC_ACTIVE_HIGH);
+	/*
+	 * This hardware uses [HV]REF instead of [HV]SYNC. Based on the
+	 * provided timing diagrams in the manual, positive polarity
+	 * equals active high [HV]REF.
+	 *
+	 * When the back porch is 0, [HV]REF is more or less equivalent
+	 * to [HV]SYNC inverted.
+	 */
+	href_pol = !!(bus->flags & V4L2_MBUS_HSYNC_ACTIVE_LOW);
+	vref_pol = !!(bus->flags & V4L2_MBUS_VSYNC_ACTIVE_LOW);
 	pclk_pol = !!(bus->flags & V4L2_MBUS_PCLK_SAMPLE_RISING);
 	writel(CSI_CFG_INPUT_FMT(csi_fmt->input) |
 	       CSI_CFG_OUTPUT_FMT(csi_fmt->output) |
-	       CSI_CFG_VSYNC_POL(vsync_pol) |
-	       CSI_CFG_HSYNC_POL(hsync_pol) |
+	       CSI_CFG_VREF_POL(vref_pol) |
+	       CSI_CFG_HREF_POL(href_pol) |
 	       CSI_CFG_PCLK_POL(pclk_pol),
 	       csi->regs + CSI_CFG_REG);
 
-- 
2.24.0

