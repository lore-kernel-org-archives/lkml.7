Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FB0C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA72520880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="djq1XNNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbfHENl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:41:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50497 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbfHENlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:41:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so74808146wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 06:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x+WcHBmr4prRt0vIkSfM9PPUqwEgU3pvt4JgB//l4IQ=;
        b=djq1XNNCaa80etpmbt/t52jE3VOpu447E/HlXbMrdXc4UCAeGM1biJA8j1G/SxpTSI
         v+VzJq4HpD++RmUH3M6U3m+jS8S2emGkORh5sRBm2LnD9l6vrNZNF8aqU+4Z1nZXDBvZ
         uNvwfeYVTsBbHmQ94RdlN/ll9Xb00pD7PfEn9Ef/bE+ysLCoMdKRAtubd3m2ovyEq/qY
         IdB3WIu2s2PYsQ53POMt1Q7JvfrjWPiqZ6MrTYCRz+1WSPX/3JoDdnzghdJQLSskqINU
         eKFIJqbT0a7cN2Lngixg3wJqPQrhYfjyovnI9dvgYknO7XVgISZUhzYhvXawyv4IVOdA
         YzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x+WcHBmr4prRt0vIkSfM9PPUqwEgU3pvt4JgB//l4IQ=;
        b=JoEYxHfZKGxMnaiLrclcHZKJ6PzKs/899C3gXBpwPbDwaZrv0SKKwqH/F3JId63Tgn
         PmPPzbaazoQg70zicPG+BDECCx8+lPeEw1XJUBNCo05Pa3HuGmgnposYY81oueszsRIC
         m3TOdk0+zZodaBRKKKp0Dm+U2CqQaRSHly3T6qaIDfCni8NuYDcLn/vrpelvRcuGf3bB
         J7BLjMi8D4ZA87vzWoh7Tm0Y62tUMaa/2s8ieg1MdrOpkxoruMMhIE/relUxmyK7FBmD
         MedupwfO2Kb4HqDpuopKZAVPliwYuBISzn/p9EqzbWwmsBBa7dOh0n9eLkYAc4nna5XY
         7pTg==
X-Gm-Message-State: APjAAAUwe9OYlNvvAac0AZCm69UlFZxvJGYpucvoOsq/SFpRfdWGOK2d
        U7L92ombh6tmkhtmIvnAXsPEsw==
X-Google-Smtp-Source: APXvYqy/drVrAb85EbTmmCjdLZAL3PlrstNRykKo/mQZKHCMjPluiL7BXjLnhtg2pTt038NuwCvmCA==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr18887642wma.120.1565012474656;
        Mon, 05 Aug 2019 06:41:14 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id w7sm99040534wrn.11.2019.08.05.06.41.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 06:41:14 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 8/8] drm/bridge: dw-hdmi-i2s: add .get_eld support
Date:   Mon,  5 Aug 2019 15:41:02 +0200
Message-Id: <20190805134102.24173-9-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190805134102.24173-1-jbrunet@baylibre.com>
References: <20190805134102.24173-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the eld to the generic hdmi-codec driver.
This will let the driver enforce the maximum channel number and set the
channel allocation depending on the hdmi sink.

Cc: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h     |  1 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 10 ++++++++++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c           |  1 +
 3 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
index 63b5756f463b..cb07dc0da5a7 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
@@ -14,6 +14,7 @@ struct dw_hdmi_audio_data {
 
 struct dw_hdmi_i2s_audio_data {
 	struct dw_hdmi *hdmi;
+	u8 *eld;
 
 	void (*write)(struct dw_hdmi *hdmi, u8 val, int offset);
 	u8 (*read)(struct dw_hdmi *hdmi, int offset);
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
index b8ece9c1ba2c..14d499b344c0 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
@@ -121,6 +121,15 @@ static void dw_hdmi_i2s_audio_shutdown(struct device *dev, void *data)
 	dw_hdmi_audio_disable(hdmi);
 }
 
+static int dw_hdmi_i2s_get_eld(struct device *dev, void *data, uint8_t *buf,
+			       size_t len)
+{
+	struct dw_hdmi_i2s_audio_data *audio = data;
+
+	memcpy(buf, audio->eld, min(sizeof(audio->eld), len));
+	return 0;
+}
+
 static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
 				  struct device_node *endpoint)
 {
@@ -144,6 +153,7 @@ static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
 static struct hdmi_codec_ops dw_hdmi_i2s_ops = {
 	.hw_params	= dw_hdmi_i2s_hw_params,
 	.audio_shutdown	= dw_hdmi_i2s_audio_shutdown,
+	.get_eld	= dw_hdmi_i2s_get_eld,
 	.get_dai_id	= dw_hdmi_i2s_get_dai_id,
 };
 
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index bed4bb017afd..8df69c9dbfad 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2797,6 +2797,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
 		struct dw_hdmi_i2s_audio_data audio;
 
 		audio.hdmi	= hdmi;
+		audio.eld	= hdmi->connector.eld;
 		audio.write	= hdmi_writeb;
 		audio.read	= hdmi_readb;
 		hdmi->enable_audio = dw_hdmi_i2s_audio_enable;
-- 
2.21.0

