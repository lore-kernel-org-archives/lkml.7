Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B928C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263BD2064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfCGQ64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:58:56 -0500
Received: from mailoutvs54.siol.net ([185.57.226.245]:46111 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726269AbfCGQ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:58:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id F154D5237E2;
        Thu,  7 Mar 2019 17:58:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tFNNt1AedaiO; Thu,  7 Mar 2019 17:58:49 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 8BCA85237FB;
        Thu,  7 Mar 2019 17:58:49 +0100 (CET)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 3A45E5237FA;
        Thu,  7 Mar 2019 17:58:47 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        jernej.skrabec@siol.net
Subject: [PATCH 5/6] dmaengine: sun6i: Add support for H6 DMA
Date:   Thu,  7 Mar 2019 17:58:28 +0100
Message-Id: <20190307165829.9086-6-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190307165829.9086-1-jernej.skrabec@siol.net>
References: <20190307165829.9086-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H6 DMA has more than 32 supported DRQs, which means that configuration
register is slightly rearranged. It also needs additional clock to be
enabled.

Add support for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/dma/sun6i-dma.c | 44 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 6a37f8bb39b1..eceedd139651 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -69,14 +69,19 @@
=20
 #define DMA_CHAN_CUR_CFG	0x0c
 #define DMA_CHAN_MAX_DRQ_A31		0x1f
+#define DMA_CHAN_MAX_DRQ_H6		0x3f
 #define DMA_CHAN_CFG_SRC_DRQ_A31(x)	((x) & DMA_CHAN_MAX_DRQ_A31)
+#define DMA_CHAN_CFG_SRC_DRQ_H6(x)	((x) & DMA_CHAN_MAX_DRQ_H6)
 #define DMA_CHAN_CFG_SRC_MODE_A31(x)	(((x) & 0x1) << 5)
+#define DMA_CHAN_CFG_SRC_MODE_H6(x)	(((x) & 0x1) << 8)
 #define DMA_CHAN_CFG_SRC_BURST_A31(x)	(((x) & 0x3) << 7)
 #define DMA_CHAN_CFG_SRC_BURST_H3(x)	(((x) & 0x3) << 6)
 #define DMA_CHAN_CFG_SRC_WIDTH(x)	(((x) & 0x3) << 9)
=20
 #define DMA_CHAN_CFG_DST_DRQ_A31(x)	(DMA_CHAN_CFG_SRC_DRQ_A31(x) << 16)
+#define DMA_CHAN_CFG_DST_DRQ_H6(x)	(DMA_CHAN_CFG_SRC_DRQ_H6(x) << 16)
 #define DMA_CHAN_CFG_DST_MODE_A31(x)	(DMA_CHAN_CFG_SRC_MODE_A31(x) << 16=
)
+#define DMA_CHAN_CFG_DST_MODE_H6(x)	(DMA_CHAN_CFG_SRC_MODE_H6(x) << 16)
 #define DMA_CHAN_CFG_DST_BURST_A31(x)	(DMA_CHAN_CFG_SRC_BURST_A31(x) << =
16)
 #define DMA_CHAN_CFG_DST_BURST_H3(x)	(DMA_CHAN_CFG_SRC_BURST_H3(x) << 16=
)
 #define DMA_CHAN_CFG_DST_WIDTH(x)	(DMA_CHAN_CFG_SRC_WIDTH(x) << 16)
@@ -319,12 +324,24 @@ static void sun6i_set_drq_a31(u32 *p_cfg, s8 src_dr=
q, s8 dst_drq)
 		  DMA_CHAN_CFG_DST_DRQ_A31(dst_drq);
 }
=20
+static void sun6i_set_drq_h6(u32 *p_cfg, s8 src_drq, s8 dst_drq)
+{
+	*p_cfg |=3D DMA_CHAN_CFG_SRC_DRQ_H6(src_drq) |
+		  DMA_CHAN_CFG_DST_DRQ_H6(dst_drq);
+}
+
 static void sun6i_set_mode_a31(u32 *p_cfg, s8 src_mode, s8 dst_mode)
 {
 	*p_cfg |=3D DMA_CHAN_CFG_SRC_MODE_A31(src_mode) |
 		  DMA_CHAN_CFG_DST_MODE_A31(dst_mode);
 }
=20
+static void sun6i_set_mode_h6(u32 *p_cfg, s8 src_mode, s8 dst_mode)
+{
+	*p_cfg |=3D DMA_CHAN_CFG_SRC_MODE_H6(src_mode) |
+		  DMA_CHAN_CFG_DST_MODE_H6(dst_mode);
+}
+
 static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
 {
 	struct sun6i_desc *txd =3D pchan->desc;
@@ -1160,6 +1177,28 @@ static struct sun6i_dma_config sun50i_a64_dma_cfg =
=3D {
 			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
 };
=20
+/*
+ * The H6 binding uses the number of dma channels from the
+ * device tree node.
+ */
+static struct sun6i_dma_config sun50i_h6_dma_cfg =3D {
+	.clock_autogate_enable =3D sun6i_enable_clock_autogate_h3,
+	.set_burst_length =3D sun6i_set_burst_length_h3,
+	.set_drq          =3D sun6i_set_drq_h6,
+	.set_mode         =3D sun6i_set_mode_h6,
+	.src_burst_lengths =3D BIT(1) | BIT(4) | BIT(8) | BIT(16),
+	.dst_burst_lengths =3D BIT(1) | BIT(4) | BIT(8) | BIT(16),
+	.src_addr_widths   =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
+			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
+	.dst_addr_widths   =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
+			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
+	.mbus_clk =3D true,
+};
+
 /*
  * The V3s have only 8 physical channels, a maximum DRQ port id of 23,
  * and a total of 24 usable source and destination endpoints.
@@ -1190,6 +1229,7 @@ static const struct of_device_id sun6i_dma_match[] =
=3D {
 	{ .compatible =3D "allwinner,sun8i-h3-dma", .data =3D &sun8i_h3_dma_cfg=
 },
 	{ .compatible =3D "allwinner,sun8i-v3s-dma", .data =3D &sun8i_v3s_dma_c=
fg },
 	{ .compatible =3D "allwinner,sun50i-a64-dma", .data =3D &sun50i_a64_dma=
_cfg },
+	{ .compatible =3D "allwinner,sun50i-h6-dma", .data =3D &sun50i_h6_dma_c=
fg },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun6i_dma_match);
@@ -1288,8 +1328,8 @@ static int sun6i_dma_probe(struct platform_device *=
pdev)
 	ret =3D of_property_read_u32(np, "dma-requests", &sdc->max_request);
 	if (ret && !sdc->max_request) {
 		dev_info(&pdev->dev, "Missing dma-requests, using %u.\n",
-			 DMA_CHAN_MAX_DRQ_A31);
-		sdc->max_request =3D DMA_CHAN_MAX_DRQ_A31;
+			 DMA_CHAN_MAX_DRQ_H6);
+		sdc->max_request =3D DMA_CHAN_MAX_DRQ_H6;
 	}
=20
 	/*
--=20
2.21.0

