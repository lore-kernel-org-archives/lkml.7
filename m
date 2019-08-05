Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4836C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB942087B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="o9lEr+Sk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfHENlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:41:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53341 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfHENlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:41:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so74813053wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 06:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GncMVDz5Vd7/NEmfnXs9hYV3ld42S/SQ0pl+I46T4l8=;
        b=o9lEr+Skep04ad2BOwbVmN36Q5i0vAAvaall6aKeayBrBMJfcswlnOFmDDkEyHqQvz
         l6r6b5ma5Uw8b97m/7ZdXjYphKsrWHAUoFElJMElt217BZVGYEeVFpBkrywXBYBmgd8e
         LRVFIRSCpBzGhiJubWPADBLwMBClmqU4YEgVS6nU5tjNFdfT62fkfU654GJ66Ag0ZNx9
         pbvJ6dfHI0YEmy8RC+gxOa/BDRkSa9K9AIQf0W4tEZwmcyDboR8Aj0mknHwOr5mXBBsY
         QSGmdro7WtQgXW5fDZdvzazaYQjg5h3dgprYSG8hZpH3J7DkCkOYvIX366+tCyK6L2Qu
         tSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GncMVDz5Vd7/NEmfnXs9hYV3ld42S/SQ0pl+I46T4l8=;
        b=rYZzhtxikGc6pP7AjPnbc2afCpxcxGpOFWfC50gLb54WrZQg8+a4W5ibx7PDWcsyXO
         ngG+nLlf2e4wz0z+7RWiEB2JxPVbd8ErHQxUSvktdhJ+i5jLuLRIUmFQAbTX4SDd/8NO
         FojPnCBgOKpwXyEkYP5ed8RCehCzkCOP3LzUmL2GsYMKvbNsyXbtVUpcIWFdp3nFQIl6
         hOSN/IOXjN7r8EK1OE31p0o16ZedgK76ptBkMqnyUYJSQnB5ygOOeDJm0yAFZBimvkjU
         3lK9QvaQKPB3omAtt2BH6ry/bsUWjjgYNyDJIgvSTdAxa7fm/wWzGnSnNewV7ZPWYnhj
         RfOQ==
X-Gm-Message-State: APjAAAVT+GSW8CzNa+4Ows0lK0pEG/e9oWx0URTaGE8hcEHcEhdv/x8W
        UkwWlGibBI+ZRPFnC6jV86RWzw==
X-Google-Smtp-Source: APXvYqwcSww8Y0uffTimxqmSNt9Jd/RKdAMe2bp2vn9qOiDZl//WDAehUdAAkviXn9l9223SKA46fA==
X-Received: by 2002:a1c:e710:: with SMTP id e16mr19446088wmh.38.1565012468451;
        Mon, 05 Aug 2019 06:41:08 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id w7sm99040534wrn.11.2019.08.05.06.41.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 06:41:07 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 2/8] drm/bridge: dw-hdmi: move audio channel setup out of ahb
Date:   Mon,  5 Aug 2019 15:40:56 +0200
Message-Id: <20190805134102.24173-3-jbrunet@baylibre.com>
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

Part of the channel count setup done in dw-hdmi ahb should
actually be done whatever the interface providing the data.

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

