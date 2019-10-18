Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA21CA9EB3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8312F21897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HPGmM9E1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503940AbfJRAUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:20:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39518 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503895AbfJRAUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:20:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so4278746wrj.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GWhC+phGxk4cJHdVi7LihKAUgiJg2uxQnJKT5r5d7UQ=;
        b=HPGmM9E1W83HgllFgk9pMxwjTYsbQzRckZu/VM7VC6LPNi3RBrdhW9K14HGxL475w1
         d0kQDj9AIH8llEjBFu7TFoOAshhxYE4kNT1ChG4+rGoOzGTv0wJLd7p36TSfhj8aDL+c
         /LOXysFNnyYWAGvIRUmU03yEpJzLEK3fka2jYJUOCxrXby2XDCz+xCWjn2pbJtxKdR7i
         BFLd9g8hwRRxbfwgABRAxB2pBvvLfZXddf828UpwkihvSpHjUxBrMUHeCmjwznUuDu/E
         /DNMBlvdTWff29L98NL+8nrhAdM/Kn6YgZcJ/iX7jRij8f4q4UbvQoSaLotW0wW71Onw
         xqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GWhC+phGxk4cJHdVi7LihKAUgiJg2uxQnJKT5r5d7UQ=;
        b=AjPpf10qw96UzQekJpjXjDiDfQJvgvFs6KUD7vcSKryahMzHvicq5auWIxiTJvEeuc
         l6uzY3zY+YwYJ+UihLz/3MC9RqEco8wgtZIyl7nLm+E15VrLQzbOKlrOlS3LUrS19Okm
         eyWkVFjM8A2a00kBt5qQ53L9q+I83lZ1FQkmMgLllOWlV6E4vOUAjnEZtY97XFWYJ0TR
         VtPlngQkSWZp858E1xAbLJ7fS95YqHhpRx4jPitTX0FyFVTxG0jbGeSj0BoPMp7eAxqT
         W2jj3URuiFRTob1JZIv6JG1/IPEAwRJkGjweC4EqLcEjxJO01HnTTppUP8xKgp+Q8Tet
         64Og==
X-Gm-Message-State: APjAAAUjQto5KwjuCFMY+7yh5Aquff9Pt6eV1ab+QTzx3DwR9OvGhCRF
        aGBXViqYljhQ8tkq/NVPNfwuyA==
X-Google-Smtp-Source: APXvYqybeC8LSQnjicpCNQ8RT3mFa3CNGEJdoMQYNaY4Zxg6lBhzZLJJ1+8IBmV+nqcQqJ8s/WD1Lg==
X-Received: by 2002:adf:f145:: with SMTP id y5mr5032576wro.330.1571358010901;
        Thu, 17 Oct 2019 17:20:10 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id z189sm4851248wmc.25.2019.10.17.17.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 17:20:10 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh@kernel.org, broonie@kernel.org, linus.walleij@linaro.org,
        lee.jones@linaro.org
Cc:     vinod.koul@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        linux-gpio@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 11/11] ASoC: qcom: sdm845: add support to DB845c and Lenovo Yoga
Date:   Fri, 18 Oct 2019 01:18:49 +0100
Message-Id: <20191018001849.27205-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191018001849.27205-1-srinivas.kandagatla@linaro.org>
References: <20191018001849.27205-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to Lenovo Yoga c630 compatible strings
and related setup to the sound machine driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/sdm845.c | 71 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 28f3cef696e6..1ed570c19628 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -24,6 +24,9 @@
 #define RIGHT_SPK_TDM_TX_MASK   0xC0
 #define SPK_TDM_RX_MASK         0x03
 #define NUM_TDM_SLOTS           8
+#define SLIM_MAX_TX_PORTS 16
+#define SLIM_MAX_RX_PORTS 16
+#define WCD934X_DEFAULT_MCLK_RATE	9600000
 
 struct sdm845_snd_data {
 	struct snd_soc_jack jack;
@@ -36,6 +39,39 @@ struct sdm845_snd_data {
 
 static unsigned int tdm_slot_offset[8] = {0, 4, 8, 12, 16, 20, 24, 28};
 
+static int sdm845_slim_snd_hw_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai_link *dai_link = rtd->dai_link;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	u32 rx_ch[SLIM_MAX_RX_PORTS], tx_ch[SLIM_MAX_TX_PORTS];
+	u32 rx_ch_cnt = 0, tx_ch_cnt = 0;
+	int ret = 0, i;
+
+	for (i = 0 ; i < dai_link->num_codecs; i++) {
+		ret = snd_soc_dai_get_channel_map(rtd->codec_dais[i],
+				&tx_ch_cnt, tx_ch, &rx_ch_cnt, rx_ch);
+
+		if (ret != 0 && ret != -ENOTSUPP) {
+			pr_err("failed to get codec chan map, err:%d\n", ret);
+			return ret;
+		} else if (ret == -ENOTSUPP) {
+			/* Ignore unsupported */
+			continue;
+		}
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			ret = snd_soc_dai_set_channel_map(cpu_dai, 0, NULL,
+							  rx_ch_cnt, rx_ch);
+		else
+			ret = snd_soc_dai_set_channel_map(cpu_dai, tx_ch_cnt,
+							  tx_ch, 0, NULL);
+	}
+
+	return 0;
+}
+
 static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params)
 {
@@ -151,6 +187,9 @@ static int sdm845_snd_hw_params(struct snd_pcm_substream *substream,
 	case QUATERNARY_TDM_TX_0:
 		ret = sdm845_tdm_snd_hw_params(substream, params);
 		break;
+	case SLIMBUS_0_RX...SLIMBUS_6_TX:
+		ret = sdm845_slim_snd_hw_params(substream, params);
+		break;
 	default:
 		pr_err("%s: invalid dai id 0x%x\n", __func__, cpu_dai->id);
 		break;
@@ -173,7 +212,20 @@ static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct sdm845_snd_data *pdata = snd_soc_card_get_drvdata(card);
 	struct snd_jack *jack;
-	int rval;
+	struct snd_soc_dai_link *dai_link = rtd->dai_link;
+	/*
+	 * Codec SLIMBUS configuration
+	 * RX1, RX2, RX3, RX4, RX5, RX6, RX7, RX8, RX9, RX10, RX11, RX12, RX13
+	 * TX1, TX2, TX3, TX4, TX5, TX6, TX7, TX8, TX9, TX10, TX11, TX12, TX13
+	 * TX14, TX15, TX16
+	 */
+	unsigned int rx_ch[SLIM_MAX_RX_PORTS] = {144, 145, 146, 147, 148, 149,
+					150, 151, 152, 153, 154, 155, 156};
+	unsigned int tx_ch[SLIM_MAX_TX_PORTS] = {128, 129, 130, 131, 132, 133,
+					    134, 135, 136, 137, 138, 139,
+					    140, 141, 142, 143};
+	int rval, i;
+
 
 	if (!pdata->jack_setup) {
 		rval = snd_soc_card_jack_new(card, "Headset Jack",
@@ -211,6 +263,21 @@ static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
 			return rval;
 		}
 		break;
+	case SLIMBUS_0_RX...SLIMBUS_6_TX:
+		for (i = 0 ; i < dai_link->num_codecs; i++) {
+			rval = snd_soc_dai_set_channel_map(rtd->codec_dais[i],
+							  ARRAY_SIZE(tx_ch),
+							  tx_ch,
+							  ARRAY_SIZE(rx_ch),
+							  rx_ch);
+			if (rval != 0 && rval != -ENOTSUPP)
+				return rval;
+
+			snd_soc_dai_set_sysclk(rtd->codec_dais[i], 0,
+					       WCD934X_DEFAULT_MCLK_RATE,
+					       SNDRV_PCM_STREAM_PLAYBACK);
+		}
+		break;
 	default:
 		break;
 	}
@@ -451,6 +518,8 @@ static int sdm845_snd_platform_remove(struct platform_device *pdev)
 
 static const struct of_device_id sdm845_snd_device_id[]  = {
 	{ .compatible = "qcom,sdm845-sndcard" },
+	{ .compatible = "qcom,db845c-sndcard" },
+	{ .compatible = "lenovo,yoga-c630-sndcard" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sdm845_snd_device_id);
-- 
2.21.0

