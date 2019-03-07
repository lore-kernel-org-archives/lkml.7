Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E98C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB1A20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfCGQ6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:58:52 -0500
Received: from mailoutvs44.siol.net ([185.57.226.235]:46033 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726161AbfCGQ6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:58:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 747195237CE;
        Thu,  7 Mar 2019 17:58:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ll3xQKAlnVGF; Thu,  7 Mar 2019 17:58:44 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id D13345237E2;
        Thu,  7 Mar 2019 17:58:44 +0100 (CET)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 794D15237CE;
        Thu,  7 Mar 2019 17:58:42 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        jernej.skrabec@siol.net
Subject: [PATCH 3/6] dmaengine: sun6i: Add a quirk for setting DRQ fields
Date:   Thu,  7 Mar 2019 17:58:26 +0100
Message-Id: <20190307165829.9086-4-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190307165829.9086-1-jernej.skrabec@siol.net>
References: <20190307165829.9086-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H6 DMA has more than 32 possible DRQs. That means that current maximum
of 31 DRQs is not enough anymore.

Add a quirk which will set source and destination DRQ number.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/dma/sun6i-dma.c | 48 ++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 761555080325..9dd23b76d841 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -68,15 +68,15 @@
 #define DMA_CHAN_LLI_ADDR	0x08
=20
 #define DMA_CHAN_CUR_CFG	0x0c
-#define DMA_CHAN_MAX_DRQ		0x1f
-#define DMA_CHAN_CFG_SRC_DRQ(x)		((x) & DMA_CHAN_MAX_DRQ)
+#define DMA_CHAN_MAX_DRQ_A31		0x1f
+#define DMA_CHAN_CFG_SRC_DRQ_A31(x)	((x) & DMA_CHAN_MAX_DRQ_A31)
 #define DMA_CHAN_CFG_SRC_IO_MODE	BIT(5)
 #define DMA_CHAN_CFG_SRC_LINEAR_MODE	(0 << 5)
 #define DMA_CHAN_CFG_SRC_BURST_A31(x)	(((x) & 0x3) << 7)
 #define DMA_CHAN_CFG_SRC_BURST_H3(x)	(((x) & 0x3) << 6)
 #define DMA_CHAN_CFG_SRC_WIDTH(x)	(((x) & 0x3) << 9)
=20
-#define DMA_CHAN_CFG_DST_DRQ(x)		(DMA_CHAN_CFG_SRC_DRQ(x) << 16)
+#define DMA_CHAN_CFG_DST_DRQ_A31(x)	(DMA_CHAN_CFG_SRC_DRQ_A31(x) << 16)
 #define DMA_CHAN_CFG_DST_IO_MODE	(DMA_CHAN_CFG_SRC_IO_MODE << 16)
 #define DMA_CHAN_CFG_DST_LINEAR_MODE	(DMA_CHAN_CFG_SRC_LINEAR_MODE << 16=
)
 #define DMA_CHAN_CFG_DST_BURST_A31(x)	(DMA_CHAN_CFG_SRC_BURST_A31(x) << =
16)
@@ -125,6 +125,7 @@ struct sun6i_dma_config {
 	 */
 	void (*clock_autogate_enable)(struct sun6i_dma_dev *);
 	void (*set_burst_length)(u32 *p_cfg, s8 src_burst, s8 dst_burst);
+	void (*set_drq)(u32 *p_cfg, s8 src_drq, s8 dst_drq);
 	u32 src_burst_lengths;
 	u32 dst_burst_lengths;
 	u32 src_addr_widths;
@@ -311,6 +312,12 @@ static void sun6i_set_burst_length_h3(u32 *p_cfg, s8=
 src_burst, s8 dst_burst)
 		  DMA_CHAN_CFG_DST_BURST_H3(dst_burst);
 }
=20
+static void sun6i_set_drq_a31(u32 *p_cfg, s8 src_drq, s8 dst_drq)
+{
+	*p_cfg |=3D DMA_CHAN_CFG_SRC_DRQ_A31(src_drq) |
+		  DMA_CHAN_CFG_DST_DRQ_A31(dst_drq);
+}
+
 static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
 {
 	struct sun6i_desc *txd =3D pchan->desc;
@@ -634,14 +641,13 @@ static struct dma_async_tx_descriptor *sun6i_dma_pr=
ep_dma_memcpy(
=20
 	burst =3D convert_burst(8);
 	width =3D convert_buswidth(DMA_SLAVE_BUSWIDTH_4_BYTES);
-	v_lli->cfg =3D DMA_CHAN_CFG_SRC_DRQ(DRQ_SDRAM) |
-		DMA_CHAN_CFG_DST_DRQ(DRQ_SDRAM) |
-		DMA_CHAN_CFG_DST_LINEAR_MODE |
+	v_lli->cfg =3D DMA_CHAN_CFG_DST_LINEAR_MODE |
 		DMA_CHAN_CFG_SRC_LINEAR_MODE |
 		DMA_CHAN_CFG_SRC_WIDTH(width) |
 		DMA_CHAN_CFG_DST_WIDTH(width);
=20
 	sdev->cfg->set_burst_length(&v_lli->cfg, burst, burst);
+	sdev->cfg->set_drq(&v_lli->cfg, DRQ_SDRAM, DRQ_SDRAM);
=20
 	sun6i_dma_lli_add(NULL, v_lli, p_lli, txd);
=20
@@ -695,9 +701,8 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep=
_slave_sg(
 			v_lli->dst =3D sconfig->dst_addr;
 			v_lli->cfg =3D lli_cfg |
 				DMA_CHAN_CFG_DST_IO_MODE |
-				DMA_CHAN_CFG_SRC_LINEAR_MODE |
-				DMA_CHAN_CFG_SRC_DRQ(DRQ_SDRAM) |
-				DMA_CHAN_CFG_DST_DRQ(vchan->port);
+				DMA_CHAN_CFG_SRC_LINEAR_MODE;
+			sdev->cfg->set_drq(&v_lli->cfg, DRQ_SDRAM, vchan->port);
=20
 			dev_dbg(chan2dev(chan),
 				"%s; chan: %d, dest: %pad, src: %pad, len: %u. flags: 0x%08lx\n",
@@ -710,9 +715,8 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep=
_slave_sg(
 			v_lli->dst =3D sg_dma_address(sg);
 			v_lli->cfg =3D lli_cfg |
 				DMA_CHAN_CFG_DST_LINEAR_MODE |
-				DMA_CHAN_CFG_SRC_IO_MODE |
-				DMA_CHAN_CFG_DST_DRQ(DRQ_SDRAM) |
-				DMA_CHAN_CFG_SRC_DRQ(vchan->port);
+				DMA_CHAN_CFG_SRC_IO_MODE;
+			sdev->cfg->set_drq(&v_lli->cfg, vchan->port, DRQ_SDRAM);
=20
 			dev_dbg(chan2dev(chan),
 				"%s; chan: %d, dest: %pad, src: %pad, len: %u. flags: 0x%08lx\n",
@@ -780,17 +784,15 @@ static struct dma_async_tx_descriptor *sun6i_dma_pr=
ep_dma_cyclic(
 			v_lli->dst =3D sconfig->dst_addr;
 			v_lli->cfg =3D lli_cfg |
 				DMA_CHAN_CFG_DST_IO_MODE |
-				DMA_CHAN_CFG_SRC_LINEAR_MODE |
-				DMA_CHAN_CFG_SRC_DRQ(DRQ_SDRAM) |
-				DMA_CHAN_CFG_DST_DRQ(vchan->port);
+				DMA_CHAN_CFG_SRC_LINEAR_MODE;
+			sdev->cfg->set_drq(&v_lli->cfg, DRQ_SDRAM, vchan->port);
 		} else {
 			v_lli->src =3D sconfig->src_addr;
 			v_lli->dst =3D buf_addr + period_len * i;
 			v_lli->cfg =3D lli_cfg |
 				DMA_CHAN_CFG_DST_LINEAR_MODE |
-				DMA_CHAN_CFG_SRC_IO_MODE |
-				DMA_CHAN_CFG_DST_DRQ(DRQ_SDRAM) |
-				DMA_CHAN_CFG_SRC_DRQ(vchan->port);
+				DMA_CHAN_CFG_SRC_IO_MODE;
+			sdev->cfg->set_drq(&v_lli->cfg, vchan->port, DRQ_SDRAM);
 		}
=20
 		prev =3D sun6i_dma_lli_add(prev, v_lli, p_lli, txd);
@@ -1055,6 +1057,7 @@ static struct sun6i_dma_config sun6i_a31_dma_cfg =3D=
 {
 	.nr_max_requests =3D 30,
 	.nr_max_vchans   =3D 53,
 	.set_burst_length =3D sun6i_set_burst_length_a31,
+	.set_drq          =3D sun6i_set_drq_a31,
 	.src_burst_lengths =3D BIT(1) | BIT(8),
 	.dst_burst_lengths =3D BIT(1) | BIT(8),
 	.src_addr_widths   =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1076,6 +1079,7 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg =3D=
 {
 	.nr_max_vchans   =3D 37,
 	.clock_autogate_enable =3D sun6i_enable_clock_autogate_a23,
 	.set_burst_length =3D sun6i_set_burst_length_a31,
+	.set_drq          =3D sun6i_set_drq_a31,
 	.src_burst_lengths =3D BIT(1) | BIT(8),
 	.dst_burst_lengths =3D BIT(1) | BIT(8),
 	.src_addr_widths   =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1092,6 +1096,7 @@ static struct sun6i_dma_config sun8i_a83t_dma_cfg =3D=
 {
 	.nr_max_vchans   =3D 39,
 	.clock_autogate_enable =3D sun6i_enable_clock_autogate_a23,
 	.set_burst_length =3D sun6i_set_burst_length_a31,
+	.set_drq          =3D sun6i_set_drq_a31,
 	.src_burst_lengths =3D BIT(1) | BIT(8),
 	.dst_burst_lengths =3D BIT(1) | BIT(8),
 	.src_addr_widths   =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1115,6 +1120,7 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg =3D=
 {
 	.nr_max_vchans   =3D 34,
 	.clock_autogate_enable =3D sun6i_enable_clock_autogate_h3,
 	.set_burst_length =3D sun6i_set_burst_length_h3,
+	.set_drq          =3D sun6i_set_drq_a31,
 	.src_burst_lengths =3D BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.dst_burst_lengths =3D BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.src_addr_widths   =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1134,6 +1140,7 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg =3D=
 {
 static struct sun6i_dma_config sun50i_a64_dma_cfg =3D {
 	.clock_autogate_enable =3D sun6i_enable_clock_autogate_h3,
 	.set_burst_length =3D sun6i_set_burst_length_h3,
+	.set_drq          =3D sun6i_set_drq_a31,
 	.src_burst_lengths =3D BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.dst_burst_lengths =3D BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.src_addr_widths   =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1157,6 +1164,7 @@ static struct sun6i_dma_config sun8i_v3s_dma_cfg =3D=
 {
 	.nr_max_vchans   =3D 24,
 	.clock_autogate_enable =3D sun6i_enable_clock_autogate_a23,
 	.set_burst_length =3D sun6i_set_burst_length_a31,
+	.set_drq          =3D sun6i_set_drq_a31,
 	.src_burst_lengths =3D BIT(1) | BIT(8),
 	.dst_burst_lengths =3D BIT(1) | BIT(8),
 	.src_addr_widths   =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1272,8 +1280,8 @@ static int sun6i_dma_probe(struct platform_device *=
pdev)
 	ret =3D of_property_read_u32(np, "dma-requests", &sdc->max_request);
 	if (ret && !sdc->max_request) {
 		dev_info(&pdev->dev, "Missing dma-requests, using %u.\n",
-			 DMA_CHAN_MAX_DRQ);
-		sdc->max_request =3D DMA_CHAN_MAX_DRQ;
+			 DMA_CHAN_MAX_DRQ_A31);
+		sdc->max_request =3D DMA_CHAN_MAX_DRQ_A31;
 	}
=20
 	/*
--=20
2.21.0

