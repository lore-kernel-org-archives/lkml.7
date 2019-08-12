Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CC9C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00833208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aOQF4iSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfHLMHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:07:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35125 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbfHLMHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:07:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id k2so18495761wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f27o2oE+oJHz4miX1Hf8EQ6LoL/TmaOJvKtMiSXbELE=;
        b=aOQF4iSEbmZZ5KY0hvPeBd8BItPqgtiP29FyURV+eKXNUeVijOxMVfVCNA5pEXVaji
         K05N5EAuVNZVkbw5HIZWo9Izbd+BKrdQneWJUE6mR8E+bFCl+BOy+iXJdUoH//looyMM
         i6Cd2+/WCQrlwCpG+k0SFfRmr5S5ndy2CL20JE4IcoCQ+HoOQ1dxHJ/Xz9zcpiee+ahQ
         UfLEAmK4UaIPrcB9cSrXtFILshBuSU1EESYiJu2DnqMEZBKC1EkoPtR6qYMeG7GqJFWZ
         LG4qrbnPerpCH8mP2DWE16gQQZT8R85kXCoRm6Ncr4Z/OVzVjb+ds4OvOnBsstAWEezE
         W5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f27o2oE+oJHz4miX1Hf8EQ6LoL/TmaOJvKtMiSXbELE=;
        b=JILJgXuKKa7dyeRPRVg41DJW7fj7r6uGriXNVqToTfpwAPYEwK8Vor+G3E81vKYDpG
         ei3/Cy53Qala6DOQwyQGa4kpFBUZR2o+RkoiLXzngP85aehIvzMt1JY7z2l8js6pAUpU
         yBW1nAE6F4xmfBJWDwb6YnkIT1u5Z7nDhkMNaD5lb5PSQj7TCqd720PzxuPH2H9vfiNK
         3ovpnSJITUnhy2lqiW1wTBGZxK3dF+KAhsaPBTO1FqMvvebHxpPJfvaz1mtFtUQGcllj
         fJ2krDAaPaNVHJ3toTbERrOBVAdYY1fyoy5/u0JzmHJAOIxwEn0PYu9o9CzvqlGR1rl2
         AzaA==
X-Gm-Message-State: APjAAAXL7XxyyfpeyDKZXPdSvU/x5sBlOmUozBecdGpMUn8wAI0KVjsu
        JPzjrzFVkFL+6K5Gb6uxZDgsVw==
X-Google-Smtp-Source: APXvYqwQMpGaWCUJTwGWrRgVVpAUR9EHakWwjQhtB4VAuAtKJl/x804rET/ORPE8DjACKRip0STzcw==
X-Received: by 2002:adf:a1de:: with SMTP id v30mr5234110wrv.138.1565611651778;
        Mon, 12 Aug 2019 05:07:31 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j9sm1883415wrx.66.2019.08.12.05.07.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:07:31 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/8] drm/bridge: dw-hdmi: move audio channel setup out of ahb
Date:   Mon, 12 Aug 2019 14:07:20 +0200
Message-Id: <20190812120726.1528-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812120726.1528-1-jbrunet@baylibre.com>
References: <20190812120726.1528-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Part of the channel count setup done in dw-hdmi ahb should
actually be done whatever the interface providing the data.

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Let's move it to dw-hdmi driver instead.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../drm/bridge/synopsys/dw-hdmi-ahb-audio.c   | 20 +++---------
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     | 32 +++++++++++++++++++
 include/drm/bridge/dw_hdmi.h                  |  2 ++
 3 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
index a494186ae6ce..2b7539701b42 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
@@ -63,10 +63,6 @@ enum {
 	HDMI_REVISION_ID = 0x0001,
 	HDMI_IH_AHBDMAAUD_STAT0 = 0x0109,
 	HDMI_IH_MUTE_AHBDMAAUD_STAT0 = 0x0189,
-	HDMI_FC_AUDICONF2 = 0x1027,
-	HDMI_FC_AUDSCONF = 0x1063,
-	HDMI_FC_AUDSCONF_LAYOUT1 = 1 << 0,
-	HDMI_FC_AUDSCONF_LAYOUT0 = 0 << 0,
 	HDMI_AHB_DMA_CONF0 = 0x3600,
 	HDMI_AHB_DMA_START = 0x3601,
 	HDMI_AHB_DMA_STOP = 0x3602,
@@ -403,7 +399,7 @@ static int dw_hdmi_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_dw_hdmi *dw = substream->private_data;
-	u8 threshold, conf0, conf1, layout, ca;
+	u8 threshold, conf0, conf1, ca;
 
 	/* Setup as per 3.0.5 FSL 4.1.0 BSP */
 	switch (dw->revision) {
@@ -434,20 +430,12 @@ static int dw_hdmi_prepare(struct snd_pcm_substream *substream)
 	conf1 = default_hdmi_channel_config[runtime->channels - 2].conf1;
 	ca = default_hdmi_channel_config[runtime->channels - 2].ca;
 
-	/*
-	 * For >2 channel PCM audio, we need to select layout 1
-	 * and set an appropriate channel map.
-	 */
-	if (runtime->channels > 2)
-		layout = HDMI_FC_AUDSCONF_LAYOUT1;
-	else
-		layout = HDMI_FC_AUDSCONF_LAYOUT0;
-
 	writeb_relaxed(threshold, dw->data.base + HDMI_AHB_DMA_THRSLD);
 	writeb_relaxed(conf0, dw->data.base + HDMI_AHB_DMA_CONF0);
 	writeb_relaxed(conf1, dw->data.base + HDMI_AHB_DMA_CONF1);
-	writeb_relaxed(layout, dw->data.base + HDMI_FC_AUDSCONF);
-	writeb_relaxed(ca, dw->data.base + HDMI_FC_AUDICONF2);
+
+	dw_hdmi_set_channel_count(dw->data.hdmi, runtime->channels);
+	dw_hdmi_set_channel_allocation(dw->data.hdmi, ca);
 
 	switch (runtime->format) {
 	case SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE:
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 218a7b2308f7..be6d6819bef4 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -645,6 +645,38 @@ void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate)
 }
 EXPORT_SYMBOL_GPL(dw_hdmi_set_sample_rate);
 
+void dw_hdmi_set_channel_count(struct dw_hdmi *hdmi, unsigned int cnt)
+{
+	u8 layout;
+
+	mutex_lock(&hdmi->audio_mutex);
+
+	/*
+	 * For >2 channel PCM audio, we need to select layout 1
+	 * and set an appropriate channel map.
+	 */
+	if (cnt > 2)
+		layout = HDMI_FC_AUDSCONF_AUD_PACKET_LAYOUT_LAYOUT1;
+	else
+		layout = HDMI_FC_AUDSCONF_AUD_PACKET_LAYOUT_LAYOUT0;
+
+	hdmi_modb(hdmi, layout, HDMI_FC_AUDSCONF_AUD_PACKET_LAYOUT_MASK,
+		  HDMI_FC_AUDSCONF);
+
+	mutex_unlock(&hdmi->audio_mutex);
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_set_channel_count);
+
+void dw_hdmi_set_channel_allocation(struct dw_hdmi *hdmi, unsigned int ca)
+{
+	mutex_lock(&hdmi->audio_mutex);
+
+	hdmi_writeb(hdmi, ca, HDMI_FC_AUDICONF2);
+
+	mutex_unlock(&hdmi->audio_mutex);
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_set_channel_allocation);
+
 static void hdmi_enable_audio_clk(struct dw_hdmi *hdmi, bool enable)
 {
 	if (enable)
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index c402364aec0d..cf528c289857 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -155,6 +155,8 @@ void dw_hdmi_resume(struct dw_hdmi *hdmi);
 void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense);
 
 void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
+void dw_hdmi_set_channel_count(struct dw_hdmi *hdmi, unsigned int cnt);
+void dw_hdmi_set_channel_allocation(struct dw_hdmi *hdmi, unsigned int ca);
 void dw_hdmi_audio_enable(struct dw_hdmi *hdmi);
 void dw_hdmi_audio_disable(struct dw_hdmi *hdmi);
 void dw_hdmi_set_high_tmds_clock_ratio(struct dw_hdmi *hdmi);
-- 
2.21.0

