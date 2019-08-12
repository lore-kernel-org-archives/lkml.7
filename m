Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AFDC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB75D208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hS7Kx+wO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfHLMue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:50:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54771 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfHLMue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:50:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id p74so12053576wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nuL4TLbuiajteIBUcLht3A9vUK/cqgNo9Cf0dYF6/nc=;
        b=hS7Kx+wOvRPyPbK4skt43H1PfDxHj/p/cn434dg/BQt9yVt/ySb9q4VxmXqpbcQvqR
         GavtSTsLNe7rVhEjG9UPXpd0Q7ymkWVCgxHP386VObqiwHXgMFGPBTQr5lKcLnI5D10z
         IqGc1dLK1K9isXdUt/aZcrMcFzgt2z3Bru0+ZqQX6A6fzH3MhBHTaq05EXAHg9DhamBm
         eIjC+dOqRKSvw5FRqmqCJgzh3bZNJe4gc/YH9Gi0jmgpJouQ1nSXlc/7LBH/9FvJWrg1
         ckSYGMBCIFESxN1VyIveMVps/K52K7gnD9oUz2/vJfT3BzZmGTNHlrJZTauoo4NF+A0i
         Kuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nuL4TLbuiajteIBUcLht3A9vUK/cqgNo9Cf0dYF6/nc=;
        b=rvM/yx0dHhM//PLYWu4R9xOOW77NfeNIeONCnz5zvl1lSpsQ5yy0OuaEbz7RBk1LWI
         QN5iRfN3DoVqN+1UxGx9kICEO+Ew8HUYywT3KR0Z9eklIslZIO7JQY0bPm5roTBZRoYw
         b3W6MKRN3RDx+pHYgi+noQIV8peHT70HNIW3dlek+bkWfW1N9aYU25Lk8jVn6R/oBKpQ
         yyxXI3pEI29+Pu5dpRw8dTi5l7ubqO7XjovpnVCIfjXodrha8F81KA7lyqNFCGfbgFsY
         FY1C7q0lcTcRY2WLHe92PMB/Gp50dRzwLJ/AH25vMtyOFtnZTxiNfp4BsHyujeyAtGGD
         VzWQ==
X-Gm-Message-State: APjAAAW2bvA2sP7RP4TEmPKl6MkfjfZtsC+7OXYrj4C5hQ9DASXAzcXB
        YxqzGfnPssuwQ5gMzY5gTseBfw==
X-Google-Smtp-Source: APXvYqzz/wdsFPSBb7Iv51fpxD7mYrRzkV5Mt16VX8X+OU4vA0sD1wYsRjv5/wSlhihAoZqsMX27Aw==
X-Received: by 2002:a1c:7a02:: with SMTP id v2mr27485520wmc.159.1565614231714;
        Mon, 12 Aug 2019 05:50:31 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id e11sm13740504wrc.4.2019.08.12.05.50.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:50:31 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [RESEND PATCH v2 8/8] drm/bridge: dw-hdmi-i2s: add .get_eld support
Date:   Mon, 12 Aug 2019 14:50:16 +0200
Message-Id: <20190812125016.20169-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812120726.1528-9-jbrunet@baylibre.com>
References: <20190812120726.1528-9-jbrunet@baylibre.com>
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
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 11 +++++++++++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c           |  1 +
 3 files changed, 13 insertions(+)

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
index b8ece9c1ba2c..1d15cf9b6821 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 
 #include <drm/bridge/dw_hdmi.h>
+#include <drm/drm_crtc.h>
 
 #include <sound/hdmi-codec.h>
 
@@ -121,6 +122,15 @@ static void dw_hdmi_i2s_audio_shutdown(struct device *dev, void *data)
 	dw_hdmi_audio_disable(hdmi);
 }
 
+static int dw_hdmi_i2s_get_eld(struct device *dev, void *data, uint8_t *buf,
+			       size_t len)
+{
+	struct dw_hdmi_i2s_audio_data *audio = data;
+
+	memcpy(buf, audio->eld, min_t(size_t, MAX_ELD_BYTES, len));
+	return 0;
+}
+
 static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
 				  struct device_node *endpoint)
 {
@@ -144,6 +154,7 @@ static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
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

