Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51619CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 18:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B8221906
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 18:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbfJVSze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 14:55:34 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:34787 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfJVSze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 14:55:34 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 710263C0579;
        Tue, 22 Oct 2019 20:55:32 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Vq_DkLNWpUpD; Tue, 22 Oct 2019 20:55:27 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 354CC3C009D;
        Tue, 22 Oct 2019 20:55:27 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 22 Oct
 2019 20:55:26 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Jiada Wang <jiada_wang@mentor.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Timo Wischer <twischer@de.adit-jv.com>
Subject: [PATCH] ASoC: rsnd: dma: set bus width to data width for monaural data
Date:   Tue, 22 Oct 2019 20:55:18 +0200
Message-ID: <20191022185518.12838-1-erosca@de.adit-jv.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiada Wang <jiada_wang@mentor.com>

According to R-Car3 HW manual 40.3.3 (Data Format on Audio Local Bus),
in case of monaural data writing or reading through Audio-DMAC,
it's always in Left Justified format, so both src and dst
DMA Bus width should be equal to physical data width.

Therefore set src and dst's DMA bus width to:
 - [monaural case] data width
 - [non-monaural case] 32bits (as prior applying the patch)

Cc: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Cc: Timo Wischer <twischer@de.adit-jv.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
 sound/soc/sh/rcar/dma.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 28f65eba2bb4..95aa26d62e4f 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -165,14 +165,40 @@ static int rsnd_dmaen_start(struct rsnd_mod *mod,
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct dma_async_tx_descriptor *desc;
 	struct dma_slave_config cfg = {};
+	enum dma_slave_buswidth buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	int is_play = rsnd_io_is_play(io);
 	int ret;
 
+	/*
+	 * in case of monaural data writing or reading through Audio-DMAC
+	 * data is always in Left Justified format, so both src and dst
+	 * DMA Bus width need to be set equal to physical data width.
+	 */
+	if (rsnd_runtime_channel_original(io) == 1) {
+		struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+		int bits = snd_pcm_format_physical_width(runtime->format);
+
+		switch (bits) {
+		case 8:
+			buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
+			break;
+		case 16:
+			buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
+			break;
+		case 32:
+			buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
+			break;
+		default:
+			dev_err(dev, "invalid format width %d\n", bits);
+			return -EINVAL;
+		}
+	}
+
 	cfg.direction	= is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
 	cfg.src_addr	= dma->src_addr;
 	cfg.dst_addr	= dma->dst_addr;
-	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.src_addr_width = buswidth;
+	cfg.dst_addr_width = buswidth;
 
 	dev_dbg(dev, "%s %pad -> %pad\n",
 		rsnd_mod_name(mod),
-- 
2.23.0

