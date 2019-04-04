Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A52CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F207320820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="E5iEIKYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbfDDLSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:18:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36181 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbfDDLRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:17:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id y13so3289809wrd.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 04:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+G25AdD9UpKYT+FRpEdmoxxTPv+X6Dc3Bb+5yQ5rUQI=;
        b=E5iEIKYSXouaY/d+tsB/s0MRtE3XExjw7NpnCw76gtdhv1qmhIx+POHVv7gQ4/CO9K
         zkteUnOKOplbTxRFZr/Pr43f+83IiBuNFxTA5KNQs0IzfH67OZo3X2QWadDDXqpHUmGo
         9jieA7004kk3qvwU++oh4lH5pfpCwHFDRCV3k6K5Krl0SPNSCaNHrbopj31kGmRNsdD9
         iONculrcr5Uxhyo4vzvSnBHMFdj19/Dm/+0xWqyegC4+CQfeu9UBlu9xT2N9cv0/ynG0
         YQj8iBCDcpiYCqLkRzZ+V0SrSOlpna2m34xMf+tCo6krou8+rlljMzb1OoQnU4UBLKTc
         Go7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+G25AdD9UpKYT+FRpEdmoxxTPv+X6Dc3Bb+5yQ5rUQI=;
        b=SymJ920AnnLpmRjFkv0p0okZ2Y3fpoqCSqJJH+GOFjjBWKN9zSpM9FIX+++5y1N5c+
         0+56+oRMBwqiRYYoubWc6PFqkD9BanJAHxYAkfUC2oM2cj3msYMQs1VFQbcgDjq3wmi9
         QieUIeJH4AUvYw2lYXYQbZXs7mDVDSo0XdcG2Ag16495d3szQY5Ko+syV75OAg2jRbvv
         FbZJZXt5NilL6gIuBp5QQ4YM3JD5M73RQcYMNVBuxTi7Ulz0wHASq3BMRTnraEnrciFG
         pp15BesLljkYMTpirqiuwuiwIqxTYNLqDZywuM6tO6FLl/ViNUtVEkMr2x/ipRbKNskR
         624A==
X-Gm-Message-State: APjAAAVYGAMKYtMpz9EaPEvlfTTpyDni1K5rmsNeKcC/T9puTzR1quy/
        tpPyyko/LGlGQP0vJm3Q/HYvRg==
X-Google-Smtp-Source: APXvYqwfqrMj9GRNNQ3QPnSD7zxnhyRZVlxbavi8YCKbEoOv6wJhmYFDfpL59xwEpJUadRzcm3Q6/g==
X-Received: by 2002:a5d:63c5:: with SMTP id c5mr3875543wrw.82.1554376667826;
        Thu, 04 Apr 2019 04:17:47 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id z23sm9024771wma.0.2019.04.04.04.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 04:17:47 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH 2/6] ASoC: meson: axg-fifo: add g12a support
Date:   Thu,  4 Apr 2019 13:17:29 +0200
Message-Id: <20190404111733.28705-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404111733.28705-1-jbrunet@baylibre.com>
References: <20190404111733.28705-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The g12a fifos gained the ability to set the initial address of the
pointer within the buffer, instead of defaulting to the buffer start
address.

It is not very useful to us (yet) but we need to put a copy the buffer
start address in the related register for the fifo to work properly on the
g12a SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-fifo.c | 34 +++++++++++++++++++++++++++++++---
 sound/soc/meson/axg-fifo.h |  2 ++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 75e5e480fda2..01c1c7db2510 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -19,7 +19,7 @@
  * This file implements the platform operations common to the playback and
  * capture frontend DAI. The logic behind this two types of fifo is very
  * similar but some difference exist.
- * These differences the respective DAI drivers
+ * These differences are handled in the respective DAI drivers
  */
 
 static struct snd_pcm_hardware axg_fifo_hw = {
@@ -133,6 +133,23 @@ static int axg_fifo_pcm_hw_params(struct snd_pcm_substream *ss,
 	return 0;
 }
 
+static int g12a_fifo_pcm_hw_params(struct snd_pcm_substream *ss,
+				   struct snd_pcm_hw_params *params)
+{
+	struct axg_fifo *fifo = axg_fifo_data(ss);
+	struct snd_pcm_runtime *runtime = ss->runtime;
+	int ret;
+
+	ret = axg_fifo_pcm_hw_params(ss, params);
+	if (ret)
+		return ret;
+
+	/* Set the initial memory address of the DMA */
+	regmap_write(fifo->map, FIFO_INIT_ADDR, runtime->dma_addr);
+
+	return 0;
+}
+
 static int axg_fifo_pcm_hw_free(struct snd_pcm_substream *ss)
 {
 	struct axg_fifo *fifo = axg_fifo_data(ss);
@@ -262,6 +279,17 @@ const struct snd_pcm_ops axg_fifo_pcm_ops = {
 };
 EXPORT_SYMBOL_GPL(axg_fifo_pcm_ops);
 
+const struct snd_pcm_ops g12a_fifo_pcm_ops = {
+	.open =		axg_fifo_pcm_open,
+	.close =        axg_fifo_pcm_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	g12a_fifo_pcm_hw_params,
+	.hw_free =      axg_fifo_pcm_hw_free,
+	.pointer =	axg_fifo_pcm_pointer,
+	.trigger =	axg_fifo_pcm_trigger,
+};
+EXPORT_SYMBOL_GPL(g12a_fifo_pcm_ops);
+
 int axg_fifo_pcm_new(struct snd_soc_pcm_runtime *rtd, unsigned int type)
 {
 	struct snd_card *card = rtd->card->snd_card;
@@ -278,7 +306,7 @@ static const struct regmap_config axg_fifo_regmap_cfg = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
-	.max_register	= FIFO_STATUS2,
+	.max_register	= FIFO_INIT_ADDR,
 };
 
 int axg_fifo_probe(struct platform_device *pdev)
@@ -339,6 +367,6 @@ int axg_fifo_probe(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(axg_fifo_probe);
 
-MODULE_DESCRIPTION("Amlogic AXG fifo driver");
+MODULE_DESCRIPTION("Amlogic AXG/G12A fifo driver");
 MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/meson/axg-fifo.h b/sound/soc/meson/axg-fifo.h
index d9f516cfbeda..5caf81241dfe 100644
--- a/sound/soc/meson/axg-fifo.h
+++ b/sound/soc/meson/axg-fifo.h
@@ -60,6 +60,7 @@ struct snd_soc_pcm_runtime;
 #define FIFO_STATUS1			0x14
 #define  STATUS1_INT_STS(x)		((x) << 0)
 #define FIFO_STATUS2			0x18
+#define FIFO_INIT_ADDR			0x24
 
 struct axg_fifo {
 	struct regmap *map;
@@ -74,6 +75,7 @@ struct axg_fifo_match_data {
 };
 
 extern const struct snd_pcm_ops axg_fifo_pcm_ops;
+extern const struct snd_pcm_ops g12a_fifo_pcm_ops;
 
 int axg_fifo_pcm_new(struct snd_soc_pcm_runtime *rtd, unsigned int type);
 int axg_fifo_probe(struct platform_device *pdev);
-- 
2.20.1

