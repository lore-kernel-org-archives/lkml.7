Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157B4C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15B620855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FKy5BGl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbfDDLR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:17:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37716 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729563AbfDDLRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:17:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so3290052wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 04:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3bu8sSj/St5z5A/eP0AMpKjvggaQ9cr9OipT1kkMzPs=;
        b=FKy5BGl6KmArpPlYrypEgU7w+7gaLQQFn61H0Cr8I7SW9dY9s0GUCsG67V7nxmikkv
         sGbyt7pq78VPDPtWYF+wf9aid5MKGm2Fi9tDyDf9hgYaLHrnD3PDUJAQT8NDSJHh/Zed
         EIdpVfue+bdWrRnFX1cvbF6F0J2WXSd3oCHVt9HFBCfh7N5rGrVRFvcfgBlD60toQIj7
         NuJsCv9tg95+pE1qeiF25UrAyX2mBgCGGJKC6w2aYxFH555Horzz9AR1ERp3hT1TVMm5
         jP2GXsKIz4350NiTihc/aUQnPkWPtJYTl9LSt8LIevOscFyOoYqSjfnuGkc6Kpwbz/Lv
         XVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3bu8sSj/St5z5A/eP0AMpKjvggaQ9cr9OipT1kkMzPs=;
        b=AEL0KHwpwdwgif7xuR1dTiDL1Sty7X1FtkkWn9S528n5IHdiY2E0DZe1Br9TgqRKgV
         SqCstDClE3+m1b986mDcZNcb1cvurNNYtM5OmD+zFaxtF3d1Jb3THt2JfMNN3c1JkS9g
         qe3qQLvLAbo0ZvK3GIXNaB2y0H2Gi+ZI9hiWT3whfll131rDHziWFKQszk/j691Lrb1E
         qZPva6BejPClaYuCDSApNy1W7DeNfxSvS8/YEhUMr3Fkamb3wUgFlBYvJ8O2Mb8pM0Cb
         u5l287xs/49YLi6AM2x5SKQRxjTDkNGpLJ5LqAO884H+3km2liyatzIEwz0XpFp535kL
         zZbg==
X-Gm-Message-State: APjAAAVMTRZFs4M8TkVDeIBGF/9vMWAEedmD4zF2NsVt9BDLlY/ioEfS
        tCpa4F59T9xfFgZVEBydaHchcA==
X-Google-Smtp-Source: APXvYqxKQNqcDsBC3ZPMQAra7s/cBMV/W+962KTIaqXV1vVIfB5fm6uKWWJPfbBw2pmhvexpnPG0kw==
X-Received: by 2002:adf:eaca:: with SMTP id o10mr3819260wrn.273.1554376670916;
        Thu, 04 Apr 2019 04:17:50 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id z23sm9024771wma.0.2019.04.04.04.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 04:17:50 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH 4/6] ASoC: meson: axg-frddr: add g12a support
Date:   Thu,  4 Apr 2019 13:17:31 +0200
Message-Id: <20190404111733.28705-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404111733.28705-1-jbrunet@baylibre.com>
References: <20190404111733.28705-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the axg, frddr could only be connected to 1 downstream element, so the
playback was possible on 1 interface only at a time.

On the g12a, the frddr may connect and wait for the request of up to 3
downstream elements. With this, it possible for single playback to be
played on several interfaces at the same time.

Like the toddr fifo, the g12a frddr also need to take care of resetting
the read pointer to the initial fifo address when preparing a playback.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-frddr.c | 143 +++++++++++++++++++++++++++++++++++-
 1 file changed, 140 insertions(+), 3 deletions(-)

diff --git a/sound/soc/meson/axg-frddr.c b/sound/soc/meson/axg-frddr.c
index a6f6f6a2eca8..2b8807737b2b 100644
--- a/sound/soc/meson/axg-frddr.c
+++ b/sound/soc/meson/axg-frddr.c
@@ -3,7 +3,9 @@
 // Copyright (c) 2018 BayLibre, SAS.
 // Author: Jerome Brunet <jbrunet@baylibre.com>
 
-/* This driver implements the frontend playback DAI of AXG based SoCs */
+/*
+ * This driver implements the frontend playback DAI of AXG and G12A based SoCs
+ */
 
 #include <linux/clk.h>
 #include <linux/regmap.h>
@@ -14,7 +16,29 @@
 
 #include "axg-fifo.h"
 
-#define CTRL0_FRDDR_PP_MODE	BIT(30)
+#define CTRL0_FRDDR_PP_MODE		BIT(30)
+#define CTRL0_SEL1_EN_SHIFT		3
+#define CTRL0_SEL2_SHIFT		4
+#define CTRL0_SEL2_EN_SHIFT		7
+#define CTRL0_SEL3_SHIFT		8
+#define CTRL0_SEL3_EN_SHIFT		11
+#define CTRL1_FRDDR_FORCE_FINISH	BIT(12)
+
+static int g12a_frddr_dai_prepare(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *dai)
+{
+	struct axg_fifo *fifo = snd_soc_dai_get_drvdata(dai);
+
+	/* Reset the read pointer to the FIFO_INIT_ADDR */
+	regmap_update_bits(fifo->map, FIFO_CTRL1,
+			   CTRL1_FRDDR_FORCE_FINISH, 0);
+	regmap_update_bits(fifo->map, FIFO_CTRL1,
+			   CTRL1_FRDDR_FORCE_FINISH, CTRL1_FRDDR_FORCE_FINISH);
+	regmap_update_bits(fifo->map, FIFO_CTRL1,
+			   CTRL1_FRDDR_FORCE_FINISH, 0);
+
+	return 0;
+}
 
 static int axg_frddr_dai_startup(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
@@ -119,10 +143,123 @@ static const struct axg_fifo_match_data axg_frddr_match_data = {
 	.dai_drv	= &axg_frddr_dai_drv
 };
 
+static const struct snd_soc_dai_ops g12a_frddr_ops = {
+	.prepare	= g12a_frddr_dai_prepare,
+	.startup	= axg_frddr_dai_startup,
+	.shutdown	= axg_frddr_dai_shutdown,
+};
+
+static struct snd_soc_dai_driver g12a_frddr_dai_drv = {
+	.name = "FRDDR",
+	.playback = {
+		.stream_name	= "Playback",
+		.channels_min	= 1,
+		.channels_max	= AXG_FIFO_CH_MAX,
+		.rates		= AXG_FIFO_RATES,
+		.formats	= AXG_FIFO_FORMATS,
+	},
+	.ops		= &g12a_frddr_ops,
+	.pcm_new	= axg_frddr_pcm_new,
+};
+
+static const char * const g12a_frddr_sel_texts[] = {
+	"OUT 0", "OUT 1", "OUT 2", "OUT 3", "OUT 4",
+};
+
+static SOC_ENUM_SINGLE_DECL(g12a_frddr_sel1_enum, FIFO_CTRL0, CTRL0_SEL_SHIFT,
+			    g12a_frddr_sel_texts);
+static SOC_ENUM_SINGLE_DECL(g12a_frddr_sel2_enum, FIFO_CTRL0, CTRL0_SEL2_SHIFT,
+			    g12a_frddr_sel_texts);
+static SOC_ENUM_SINGLE_DECL(g12a_frddr_sel3_enum, FIFO_CTRL0, CTRL0_SEL3_SHIFT,
+			    g12a_frddr_sel_texts);
+
+static const struct snd_kcontrol_new g12a_frddr_out1_demux =
+	SOC_DAPM_ENUM("Output Src 1", g12a_frddr_sel1_enum);
+static const struct snd_kcontrol_new g12a_frddr_out2_demux =
+	SOC_DAPM_ENUM("Output Src 2", g12a_frddr_sel2_enum);
+static const struct snd_kcontrol_new g12a_frddr_out3_demux =
+	SOC_DAPM_ENUM("Output Src 3", g12a_frddr_sel3_enum);
+
+static const struct snd_kcontrol_new g12a_frddr_out1_enable =
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", FIFO_CTRL0,
+				    CTRL0_SEL1_EN_SHIFT, 1, 0);
+static const struct snd_kcontrol_new g12a_frddr_out2_enable =
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", FIFO_CTRL0,
+				    CTRL0_SEL2_EN_SHIFT, 1, 0);
+static const struct snd_kcontrol_new g12a_frddr_out3_enable =
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", FIFO_CTRL0,
+				    CTRL0_SEL3_EN_SHIFT, 1, 0);
+
+static const struct snd_soc_dapm_widget g12a_frddr_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_OUT("SRC 1", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SRC 2", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SRC 3", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_SWITCH("SRC 1 EN", SND_SOC_NOPM, 0, 0,
+			    &g12a_frddr_out1_enable),
+	SND_SOC_DAPM_SWITCH("SRC 2 EN", SND_SOC_NOPM, 0, 0,
+			    &g12a_frddr_out2_enable),
+	SND_SOC_DAPM_SWITCH("SRC 3 EN", SND_SOC_NOPM, 0, 0,
+			    &g12a_frddr_out3_enable),
+	SND_SOC_DAPM_DEMUX("SINK 1 SEL", SND_SOC_NOPM, 0, 0,
+			   &g12a_frddr_out1_demux),
+	SND_SOC_DAPM_DEMUX("SINK 2 SEL", SND_SOC_NOPM, 0, 0,
+			   &g12a_frddr_out2_demux),
+	SND_SOC_DAPM_DEMUX("SINK 3 SEL", SND_SOC_NOPM, 0, 0,
+			   &g12a_frddr_out3_demux),
+	SND_SOC_DAPM_AIF_OUT("OUT 0", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 1", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 2", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 3", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 4", NULL, 0, SND_SOC_NOPM, 0, 0),
+};
+
+static const struct snd_soc_dapm_route g12a_frddr_dapm_routes[] = {
+	{ "SRC 1", NULL, "Playback" },
+	{ "SRC 2", NULL, "Playback" },
+	{ "SRC 3", NULL, "Playback" },
+	{ "SRC 1 EN", "Switch", "SRC 1" },
+	{ "SRC 2 EN", "Switch", "SRC 2" },
+	{ "SRC 3 EN", "Switch", "SRC 3" },
+	{ "SINK 1 SEL", NULL, "SRC 1 EN" },
+	{ "SINK 2 SEL", NULL, "SRC 2 EN" },
+	{ "SINK 3 SEL", NULL, "SRC 3 EN" },
+	{ "OUT 0", "OUT 0", "SINK 1 SEL" },
+	{ "OUT 1", "OUT 1", "SINK 1 SEL" },
+	{ "OUT 2", "OUT 2", "SINK 1 SEL" },
+	{ "OUT 3", "OUT 3", "SINK 1 SEL" },
+	{ "OUT 4", "OUT 4", "SINK 1 SEL" },
+	{ "OUT 0", "OUT 0", "SINK 2 SEL" },
+	{ "OUT 1", "OUT 1", "SINK 2 SEL" },
+	{ "OUT 2", "OUT 2", "SINK 2 SEL" },
+	{ "OUT 3", "OUT 3", "SINK 2 SEL" },
+	{ "OUT 4", "OUT 4", "SINK 2 SEL" },
+	{ "OUT 0", "OUT 0", "SINK 3 SEL" },
+	{ "OUT 1", "OUT 1", "SINK 3 SEL" },
+	{ "OUT 2", "OUT 2", "SINK 3 SEL" },
+	{ "OUT 3", "OUT 3", "SINK 3 SEL" },
+	{ "OUT 4", "OUT 4", "SINK 3 SEL" },
+};
+
+static const struct snd_soc_component_driver g12a_frddr_component_drv = {
+	.dapm_widgets		= g12a_frddr_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(g12a_frddr_dapm_widgets),
+	.dapm_routes		= g12a_frddr_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(g12a_frddr_dapm_routes),
+	.ops			= &g12a_fifo_pcm_ops
+};
+
+static const struct axg_fifo_match_data g12a_frddr_match_data = {
+	.component_drv	= &g12a_frddr_component_drv,
+	.dai_drv	= &g12a_frddr_dai_drv
+};
+
 static const struct of_device_id axg_frddr_of_match[] = {
 	{
 		.compatible = "amlogic,axg-frddr",
 		.data = &axg_frddr_match_data,
+	}, {
+		.compatible = "amlogic,g12a-frddr",
+		.data = &g12a_frddr_match_data,
 	}, {}
 };
 MODULE_DEVICE_TABLE(of, axg_frddr_of_match);
@@ -136,6 +273,6 @@ static struct platform_driver axg_frddr_pdrv = {
 };
 module_platform_driver(axg_frddr_pdrv);
 
-MODULE_DESCRIPTION("Amlogic AXG playback fifo driver");
+MODULE_DESCRIPTION("Amlogic AXG/G12A playback fifo driver");
 MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1

