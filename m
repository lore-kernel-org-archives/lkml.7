Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61D5C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D792064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfCGQ67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:58:59 -0500
Received: from mailoutvs7.siol.net ([185.57.226.198]:46069 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726546AbfCGQ6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:58:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id BA7C75237FE;
        Thu,  7 Mar 2019 17:58:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id TKsQaxYHtEMU; Thu,  7 Mar 2019 17:58:47 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 330195237EB;
        Thu,  7 Mar 2019 17:58:47 +0100 (CET)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id D51605237E3;
        Thu,  7 Mar 2019 17:58:44 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        jernej.skrabec@siol.net
Subject: [PATCH 4/6] dmaengine: sun6i: Add a quirk for setting mode fields
Date:   Thu,  7 Mar 2019 17:58:27 +0100
Message-Id: <20190307165829.9086-5-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190307165829.9086-1-jernej.skrabec@siol.net>
References: <20190307165829.9086-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H6 DMA has mode fields in different position than any other currently
supported DMA controller.

Add a quirk for that.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/dma/sun6i-dma.c | 46 ++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 9dd23b76d841..6a37f8bb39b1 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -70,15 +70,13 @@
 #define DMA_CHAN_CUR_CFG	0x0c
 #define DMA_CHAN_MAX_DRQ_A31		0x1f
 #define DMA_CHAN_CFG_SRC_DRQ_A31(x)	((x) & DMA_CHAN_MAX_DRQ_A31)
-#define DMA_CHAN_CFG_SRC_IO_MODE	BIT(5)
-#define DMA_CHAN_CFG_SRC_LINEAR_MODE	(0 << 5)
+#define DMA_CHAN_CFG_SRC_MODE_A31(x)	(((x) & 0x1) << 5)
 #define DMA_CHAN_CFG_SRC_BURST_A31(x)	(((x) & 0x3) << 7)
 #define DMA_CHAN_CFG_SRC_BURST_H3(x)	(((x) & 0x3) << 6)
 #define DMA_CHAN_CFG_SRC_WIDTH(x)	(((x) & 0x3) << 9)
=20
 #define DMA_CHAN_CFG_DST_DRQ_A31(x)	(DMA_CHAN_CFG_SRC_DRQ_A31(x) << 16)
-#define DMA_CHAN_CFG_DST_IO_MODE	(DMA_CHAN_CFG_SRC_IO_MODE << 16)
-#define DMA_CHAN_CFG_DST_LINEAR_MODE	(DMA_CHAN_CFG_SRC_LINEAR_MODE << 16=
)
+#define DMA_CHAN_CFG_DST_MODE_A31(x)	(DMA_CHAN_CFG_SRC_MODE_A31(x) << 16=
)
 #define DMA_CHAN_CFG_DST_BURST_A31(x)	(DMA_CHAN_CFG_SRC_BURST_A31(x) << =
16)
 #define DMA_CHAN_CFG_DST_BURST_H3(x)	(DMA_CHAN_CFG_SRC_BURST_H3(x) << 16=
)
 #define DMA_CHAN_CFG_DST_WIDTH(x)	(DMA_CHAN_CFG_SRC_WIDTH(x) << 16)
@@ -98,6 +96,8 @@
 #define LLI_LAST_ITEM	0xfffff800
 #define NORMAL_WAIT	8
 #define DRQ_SDRAM	1
+#define LINEAR_MODE     0
+#define IO_MODE         1
=20
 /* forward declaration */
 struct sun6i_dma_dev;
@@ -126,6 +126,7 @@ struct sun6i_dma_config {
 	void (*clock_autogate_enable)(struct sun6i_dma_dev *);
 	void (*set_burst_length)(u32 *p_cfg, s8 src_burst, s8 dst_burst);
 	void (*set_drq)(u32 *p_cfg, s8 src_drq, s8 dst_drq);
+	void (*set_mode)(u32 *p_cfg, s8 src_mode, s8 dst_mode);
 	u32 src_burst_lengths;
 	u32 dst_burst_lengths;
 	u32 src_addr_widths;
@@ -318,6 +319,12 @@ static void sun6i_set_drq_a31(u32 *p_cfg, s8 src_drq=
, s8 dst_drq)
 		  DMA_CHAN_CFG_DST_DRQ_A31(dst_drq);
 }
=20
+static void sun6i_set_mode_a31(u32 *p_cfg, s8 src_mode, s8 dst_mode)
+{
+	*p_cfg |=3D DMA_CHAN_CFG_SRC_MODE_A31(src_mode) |
+		  DMA_CHAN_CFG_DST_MODE_A31(dst_mode);
+}
+
 static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
 {
 	struct sun6i_desc *txd =3D pchan->desc;
@@ -641,13 +648,12 @@ static struct dma_async_tx_descriptor *sun6i_dma_pr=
ep_dma_memcpy(
=20
 	burst =3D convert_burst(8);
 	width =3D convert_buswidth(DMA_SLAVE_BUSWIDTH_4_BYTES);
-	v_lli->cfg =3D DMA_CHAN_CFG_DST_LINEAR_MODE |
-		DMA_CHAN_CFG_SRC_LINEAR_MODE |
-		DMA_CHAN_CFG_SRC_WIDTH(width) |
+	v_lli->cfg =3D DMA_CHAN_CFG_SRC_WIDTH(width) |
 		DMA_CHAN_CFG_DST_WIDTH(width);
=20
 	sdev->cfg->set_burst_length(&v_lli->cfg, burst, burst);
 	sdev->cfg->set_drq(&v_lli->cfg, DRQ_SDRAM, DRQ_SDRAM);
+	sdev->cfg->set_mode(&v_lli->cfg, LINEAR_MODE, LINEAR_MODE);
=20
 	sun6i_dma_lli_add(NULL, v_lli, p_lli, txd);
=20
@@ -699,10 +705,9 @@ static struct dma_async_tx_descriptor *sun6i_dma_pre=
p_slave_sg(
 		if (dir =3D=3D DMA_MEM_TO_DEV) {
 			v_lli->src =3D sg_dma_address(sg);
 			v_lli->dst =3D sconfig->dst_addr;
-			v_lli->cfg =3D lli_cfg |
-				DMA_CHAN_CFG_DST_IO_MODE |
-				DMA_CHAN_CFG_SRC_LINEAR_MODE;
+			v_lli->cfg =3D lli_cfg;
 			sdev->cfg->set_drq(&v_lli->cfg, DRQ_SDRAM, vchan->port);
+			sdev->cfg->set_mode(&v_lli->cfg, LINEAR_MODE, IO_MODE);
=20
 			dev_dbg(chan2dev(chan),
 				"%s; chan: %d, dest: %pad, src: %pad, len: %u. flags: 0x%08lx\n",
@@ -713,10 +718,9 @@ static struct dma_async_tx_descriptor *sun6i_dma_pre=
p_slave_sg(
 		} else {
 			v_lli->src =3D sconfig->src_addr;
 			v_lli->dst =3D sg_dma_address(sg);
-			v_lli->cfg =3D lli_cfg |
-				DMA_CHAN_CFG_DST_LINEAR_MODE |
-				DMA_CHAN_CFG_SRC_IO_MODE;
+			v_lli->cfg =3D lli_cfg;
 			sdev->cfg->set_drq(&v_lli->cfg, vchan->port, DRQ_SDRAM);
+			sdev->cfg->set_mode(&v_lli->cfg, IO_MODE, LINEAR_MODE);
=20
 			dev_dbg(chan2dev(chan),
 				"%s; chan: %d, dest: %pad, src: %pad, len: %u. flags: 0x%08lx\n",
@@ -782,17 +786,15 @@ static struct dma_async_tx_descriptor *sun6i_dma_pr=
ep_dma_cyclic(
 		if (dir =3D=3D DMA_MEM_TO_DEV) {
 			v_lli->src =3D buf_addr + period_len * i;
 			v_lli->dst =3D sconfig->dst_addr;
-			v_lli->cfg =3D lli_cfg |
-				DMA_CHAN_CFG_DST_IO_MODE |
-				DMA_CHAN_CFG_SRC_LINEAR_MODE;
+			v_lli->cfg =3D lli_cfg;
 			sdev->cfg->set_drq(&v_lli->cfg, DRQ_SDRAM, vchan->port);
+			sdev->cfg->set_mode(&v_lli->cfg, LINEAR_MODE, IO_MODE);
 		} else {
 			v_lli->src =3D sconfig->src_addr;
 			v_lli->dst =3D buf_addr + period_len * i;
-			v_lli->cfg =3D lli_cfg |
-				DMA_CHAN_CFG_DST_LINEAR_MODE |
-				DMA_CHAN_CFG_SRC_IO_MODE;
+			v_lli->cfg =3D lli_cfg;
 			sdev->cfg->set_drq(&v_lli->cfg, vchan->port, DRQ_SDRAM);
+			sdev->cfg->set_mode(&v_lli->cfg, IO_MODE, LINEAR_MODE);
 		}
=20
 		prev =3D sun6i_dma_lli_add(prev, v_lli, p_lli, txd);
@@ -1058,6 +1060,7 @@ static struct sun6i_dma_config sun6i_a31_dma_cfg =3D=
 {
 	.nr_max_vchans   =3D 53,
 	.set_burst_length =3D sun6i_set_burst_length_a31,
 	.set_drq          =3D sun6i_set_drq_a31,
+	.set_mode         =3D sun6i_set_mode_a31,
 	.src_burst_lengths =3D BIT(1) | BIT(8),
 	.dst_burst_lengths =3D BIT(1) | BIT(8),
 	.src_addr_widths   =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1080,6 +1083,7 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg =3D=
 {
 	.clock_autogate_enable =3D sun6i_enable_clock_autogate_a23,
 	.set_burst_length =3D sun6i_set_burst_length_a31,
 	.set_drq          =3D sun6i_set_drq_a31,
+	.set_mode         =3D sun6i_set_mode_a31,
 	.src_burst_lengths =3D BIT(1) | BIT(8),
 	.dst_burst_lengths =3D BIT(1) | BIT(8),
 	.src_addr_widths   =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1097,6 +1101,7 @@ static struct sun6i_dma_config sun8i_a83t_dma_cfg =3D=
 {
 	.clock_autogate_enable =3D sun6i_enable_clock_autogate_a23,
 	.set_burst_length =3D sun6i_set_burst_length_a31,
 	.set_drq          =3D sun6i_set_drq_a31,
+	.set_mode         =3D sun6i_set_mode_a31,
 	.src_burst_lengths =3D BIT(1) | BIT(8),
 	.dst_burst_lengths =3D BIT(1) | BIT(8),
 	.src_addr_widths   =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1121,6 +1126,7 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg =3D=
 {
 	.clock_autogate_enable =3D sun6i_enable_clock_autogate_h3,
 	.set_burst_length =3D sun6i_set_burst_length_h3,
 	.set_drq          =3D sun6i_set_drq_a31,
+	.set_mode         =3D sun6i_set_mode_a31,
 	.src_burst_lengths =3D BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.dst_burst_lengths =3D BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.src_addr_widths   =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1141,6 +1147,7 @@ static struct sun6i_dma_config sun50i_a64_dma_cfg =3D=
 {
 	.clock_autogate_enable =3D sun6i_enable_clock_autogate_h3,
 	.set_burst_length =3D sun6i_set_burst_length_h3,
 	.set_drq          =3D sun6i_set_drq_a31,
+	.set_mode         =3D sun6i_set_mode_a31,
 	.src_burst_lengths =3D BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.dst_burst_lengths =3D BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.src_addr_widths   =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1165,6 +1172,7 @@ static struct sun6i_dma_config sun8i_v3s_dma_cfg =3D=
 {
 	.clock_autogate_enable =3D sun6i_enable_clock_autogate_a23,
 	.set_burst_length =3D sun6i_set_burst_length_a31,
 	.set_drq          =3D sun6i_set_drq_a31,
+	.set_mode         =3D sun6i_set_mode_a31,
 	.src_burst_lengths =3D BIT(1) | BIT(8),
 	.dst_burst_lengths =3D BIT(1) | BIT(8),
 	.src_addr_widths   =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
--=20
2.21.0

