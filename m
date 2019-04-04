Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C786DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D5521738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VRqVwD9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbfDDLRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:17:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42249 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729538AbfDDLRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:17:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so3247047wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 04:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a6/aPiwJImd9Yf/1x3AIYjuPQVGbfZJWmEdQdmDDJF0=;
        b=VRqVwD9nClMKS7AuQzKp0WArnEbQFPjoNZHdzPHpfZZFO3L5+kIU6oPiGjOJr0lKeb
         vxncXZ34Mh2qYMBw9qnh1seFFNZh5zdfJFbG6jtiY0BTRAYqB7EbNNdp/+dgiiF7ABZt
         3bJXYGNOZ7d8wELHUF0zkGbqbe4eLl9v8IvdUl+wNVnEDxvzXFmXFy+MWVWJ2sbB4XBq
         p/qv/uowgNqb7SdhODjUgEH3YKhZOKIztwG7aj3y3cnUMX31ZbUgzTCl3v9716OE3Vih
         kcq+ZoXh1o6ODfwBwygNiiJA93GYOoroln1K0BQuFvr28UTdCN0/03P+M/lTThByjkfd
         wV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a6/aPiwJImd9Yf/1x3AIYjuPQVGbfZJWmEdQdmDDJF0=;
        b=F8Zt50t6f4j0Qfep94Or+jUy0uVftGjWsZ97BixfNgFF8bMlLg0b/vVwK5H5Wq4dzx
         rN1wU7t5q5UviJjrS0kkiFKRNI3bzYwq425BRMB0uwsd1uI2bV95wYXngk7/NipFt4ve
         dVyPD1S/DkWQMP4GGYWmATqy+o5BNIV9SX2zF5CKVy6mGn2c1pT7ghSpQxfBPFPanF2l
         249yCSm8FekbooiTJWlhPC1MUSNJuW9dkDjfM53PJOrg0vm1sYlN/htHhWDHS8oGVtLT
         8I5/aEx62dBQui8of9l0hZyEeoEWJoHM7M4TgUHXV9JiZRR0uR5bvn/XfqZmPbGOUE2G
         M7gg==
X-Gm-Message-State: APjAAAUWC0TPSgLsK8xZUS8tK3SsK6sH2/hg+XuiRr2q5xxD1UACxaAE
        TZKphY9rjSGHTDkWynFAuvNGTA==
X-Google-Smtp-Source: APXvYqyxYyIWaab5D/nHFIJDQ2z89oQ+IwLtJIlddCZXih0YR7wgWU6Hal97JQ1RGzmAuCtTO11KCw==
X-Received: by 2002:a5d:684e:: with SMTP id o14mr3974350wrw.138.1554376669312;
        Thu, 04 Apr 2019 04:17:49 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id z23sm9024771wma.0.2019.04.04.04.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 04:17:48 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH 3/6] ASoC: meson: axg-toddr: add g12a support
Date:   Thu,  4 Apr 2019 13:17:30 +0200
Message-Id: <20190404111733.28705-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404111733.28705-1-jbrunet@baylibre.com>
References: <20190404111733.28705-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the g12a SoC fifo can set the fifo initial start address, we must
make sure to actually reset the write pointer to this address when
starting a capture.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-toddr.c | 53 +++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/sound/soc/meson/axg-toddr.c b/sound/soc/meson/axg-toddr.c
index 0e9ca3882ae5..4f63e434fad4 100644
--- a/sound/soc/meson/axg-toddr.c
+++ b/sound/soc/meson/axg-toddr.c
@@ -24,6 +24,7 @@
 #define CTRL0_TODDR_MSB_POS(x)		((x) << 8)
 #define CTRL0_TODDR_LSB_POS_MASK	GENMASK(7, 3)
 #define CTRL0_TODDR_LSB_POS(x)		((x) << 3)
+#define CTRL1_TODDR_FORCE_FINISH	BIT(25)
 
 #define TODDR_MSB_POS	31
 
@@ -33,6 +34,22 @@ static int axg_toddr_pcm_new(struct snd_soc_pcm_runtime *rtd,
 	return axg_fifo_pcm_new(rtd, SNDRV_PCM_STREAM_CAPTURE);
 }
 
+static int g12a_toddr_dai_prepare(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *dai)
+{
+	struct axg_fifo *fifo = snd_soc_dai_get_drvdata(dai);
+
+	/* Reset the write pointer to the FIFO_INIT_ADDR */
+	regmap_update_bits(fifo->map, FIFO_CTRL1,
+			   CTRL1_TODDR_FORCE_FINISH, 0);
+	regmap_update_bits(fifo->map, FIFO_CTRL1,
+			   CTRL1_TODDR_FORCE_FINISH, CTRL1_TODDR_FORCE_FINISH);
+	regmap_update_bits(fifo->map, FIFO_CTRL1,
+			   CTRL1_TODDR_FORCE_FINISH, 0);
+
+	return 0;
+}
+
 static int axg_toddr_dai_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params,
 				   struct snd_soc_dai *dai)
@@ -172,10 +189,46 @@ static const struct axg_fifo_match_data axg_toddr_match_data = {
 	.dai_drv	= &axg_toddr_dai_drv
 };
 
+static const struct snd_soc_dai_ops g12a_toddr_ops = {
+	.prepare	= g12a_toddr_dai_prepare,
+	.hw_params	= axg_toddr_dai_hw_params,
+	.startup	= axg_toddr_dai_startup,
+	.shutdown	= axg_toddr_dai_shutdown,
+};
+
+static struct snd_soc_dai_driver g12a_toddr_dai_drv = {
+	.name = "TODDR",
+	.capture = {
+		.stream_name	= "Capture",
+		.channels_min	= 1,
+		.channels_max	= AXG_FIFO_CH_MAX,
+		.rates		= AXG_FIFO_RATES,
+		.formats	= AXG_FIFO_FORMATS,
+	},
+	.ops		= &g12a_toddr_ops,
+	.pcm_new	= axg_toddr_pcm_new,
+};
+
+static const struct snd_soc_component_driver g12a_toddr_component_drv = {
+	.dapm_widgets		= axg_toddr_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(axg_toddr_dapm_widgets),
+	.dapm_routes		= axg_toddr_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(axg_toddr_dapm_routes),
+	.ops			= &g12a_fifo_pcm_ops
+};
+
+static const struct axg_fifo_match_data g12a_toddr_match_data = {
+	.component_drv	= &g12a_toddr_component_drv,
+	.dai_drv	= &g12a_toddr_dai_drv
+};
+
 static const struct of_device_id axg_toddr_of_match[] = {
 	{
 		.compatible = "amlogic,axg-toddr",
 		.data = &axg_toddr_match_data,
+	}, {
+		.compatible = "amlogic,g12a-toddr",
+		.data = &g12a_toddr_match_data,
 	}, {}
 };
 MODULE_DEVICE_TABLE(of, axg_toddr_of_match);
-- 
2.20.1

