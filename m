Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066D7C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F7425D71
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRrvNk6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfFCRrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:47:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39428 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729091AbfFCRrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:47:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id a10so13833254ljf.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 10:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UmXLhP5CJRrYV/5kmZm3yYVzKnOFlBpoufzcvuG2Euo=;
        b=tRrvNk6MFq/My4QxrLzqARQ0X1xkdCvmj8lkNgEnodNP7Gf3AFQedvHDN8fyOYXFJM
         BjfZ5XKO5THgjPjipBepg7PsO6r+ZStwGCbDK+jDtOBj9cCljJ3xsQUvSr41KeIPLbuw
         lqpSRQm5Ibjn1gy8cNTJKadutrT57tIKtQepI+iPMF7YIPMOTec4YlEadeHM7FMfruif
         0xYMMaMmIK7PRhP/9UflbGqIaVv/htspVrOfI5E+juoUoXWdWwXfMQbCm29HAdn6rcqn
         hETDjMFmrvQmogX/UDjjW0IEB05Wh+TBuIBU2G98qonbhezWK8UmqMnINB879nL/JJlk
         S0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UmXLhP5CJRrYV/5kmZm3yYVzKnOFlBpoufzcvuG2Euo=;
        b=isrQH/byC8+brJfUZFH9w1anZjpzTP1vjgVsgUwbD4b2iL3Z0rHJGY1G7zUWBhJoIa
         slq8z1OwD+gLP+b3/JAG3MEc6YUBz4rhDoc7DiqCpXOjW1cpmP9wxufGMTesl8Z2LAoc
         nDouWUUXVyn6uicI0s0Jur+C4yzjinQyYtygo9IeMI3GhzwOiNihH0l8dfUwf9NkEwq3
         N6VyHlh7BVhMbc6TrMLKhj3C4WxROMvRN8hDNzEZrCrZXGMr/82/JMaNUFo0pkVHa7jM
         iVOQW/HwUtpF4YpmhQyp2DZqTHbHhDHW03imXzvRQC46dCDoD9wOSSp2xJUUONEtel+t
         mHRw==
X-Gm-Message-State: APjAAAVIxo2JdNXsNp10wCcayFHwLBIjjiMrMhJC00RKFXSbCEGwSyv7
        i45Ccqg63FOwFelgtG2vuTw=
X-Google-Smtp-Source: APXvYqxRcqPyv/G7uNPKQjW1747BjlGIhlaYcNVX/PqzipfY8FB6b8yvpMVVbeosO930GIJ+VYxDlA==
X-Received: by 2002:a2e:6313:: with SMTP id x19mr5272697ljb.25.1559584065657;
        Mon, 03 Jun 2019 10:47:45 -0700 (PDT)
Received: from localhost.localdomain ([188.150.253.81])
        by smtp.gmail.com with ESMTPSA id n7sm2803532lfi.68.2019.06.03.10.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 10:47:45 -0700 (PDT)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v4 8/9] ASoc: sun4i-i2s: Add 20, 24 and 32 bit support
Date:   Mon,  3 Jun 2019 19:47:34 +0200
Message-Id: <20190603174735.21002-9-codekipper@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603174735.21002-1-codekipper@gmail.com>
References: <20190603174735.21002-1-codekipper@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Extend the functionality of the driver to include support of 20 and
24 bits per sample for the earlier SoCs.

Newer SoCs can also handle 32bit samples.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 3549a87ed9e9..351b8021173b 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -428,6 +428,11 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	case 16:
 		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		break;
+	case 20:
+	case 24:
+	case 32:
+		width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
 	default:
 		dev_err(dai->dev, "Unsupported physical sample width: %d\n",
 			params_physical_width(params));
@@ -440,7 +445,18 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 		sr = 0;
 		wss = 0;
 		break;
-
+	case 20:
+		sr = 1;
+		wss = 1;
+		break;
+	case 24:
+		sr = 2;
+		wss = 2;
+		break;
+	case 32:
+		sr = 4;
+		wss = 4;
+		break;
 	default:
 		dev_err(dai->dev, "Unsupported sample width: %d\n",
 			params_width(params));
@@ -722,6 +738,13 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+#define SUN4I_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+			 SNDRV_PCM_FMTBIT_S20_LE | \
+			 SNDRV_PCM_FMTBIT_S24_LE)
+
+#define SUN8I_FORMATS	(SUN4I_FORMATS | \
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
 static struct snd_soc_dai_driver sun4i_i2s_dai = {
 	.probe = sun4i_i2s_dai_probe,
 	.capture = {
@@ -729,14 +752,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_192000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		.formats = SUN4I_FORMATS,
 	},
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_192000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		.formats = SUN4I_FORMATS,
 	},
 	.ops = &sun4i_i2s_dai_ops,
 	.symmetric_rates = 1,
@@ -1161,6 +1184,11 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		goto err_pm_disable;
 	}
 
+	if (i2s->variant->is_h3_i2s_based) {
+		soc_dai->playback.formats = SUN8I_FORMATS;
+		soc_dai->capture.formats = SUN8I_FORMATS;
+	}
+
 	if (!of_property_read_u32(pdev->dev.of_node,
 				  "allwinner,playback-channels", &val)) {
 		if (val >= 2 && val <= 8)
-- 
2.21.0

