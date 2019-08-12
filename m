Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AD0C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E74214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rDwjvizq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfHLMIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:08:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55271 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbfHLMHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:07:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so11928122wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+7rNGhftPAm98gxQzspW2Bl38AWTm/sVwK1bJUwi+9s=;
        b=rDwjvizqSw6Jz6AkOORykYkiAVItW36h9yIqrSC6nXnNDmDCRZtcTAJJCA4PBosGnH
         udRGdq/OsG7HCT1oFBaXuW0dQ6f9+s4m2z+tnI96mdsZGFqBYABurZMO8EQtvQgJOsWG
         ZuPZy9FPI8wgr5HIADP9ult6InbBe4KL1ExExYGEU96fwU9dimdR6xtIHI9XAhqE3YvC
         fSlYBsOBJdwSPg5xqueM2fiMOQD/huROetdJhaDMeb5qjgGVvpTUq98oh0/ytyf5dl9C
         +i2+2g+Mu+TW0YXap8l1FGYxX7g7ietxEAmQtKO9SlSKPgGROCnAuQQKJm1wJBCUncWw
         UN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+7rNGhftPAm98gxQzspW2Bl38AWTm/sVwK1bJUwi+9s=;
        b=HXWVdbc9bujtDdr585o7KBbGnyiyEJAXmewi61VwINw4Awo+a/TtwMazChjFDfXY1y
         6GB/yAnU+AKaPh3dXQrAgwO6lbwDPT5alu4Fw1QoyYPVtYZuC1s5Gd71wxmG1o8A791U
         9D3tBdMKz572mIPT3qckJ7AynzzqRvr+WF/ZM3MtytRgm8R2IQk7ZC4R3eibBATblQSI
         FCPCb1M4eZjbwmIptUjoRwR5zoFUoWymxITZu2X1MVDFWqcb9aFIflTlBeRBWn/4rQLG
         CaXMueJ6AdxmPte/x1txYZVWZPdop3foeQIwhgnC1JwdkTJX6xtHt/H2ZafWie0dqRlS
         OOBA==
X-Gm-Message-State: APjAAAWE+ri+C9Cpt2ed4oRvy0JvITUQAHNI3nywHAsyrZkBZeqzRRD3
        EI0JMEJBbZjPXsFho9AuOg7YQw==
X-Google-Smtp-Source: APXvYqzfPZVz7gWpdlttsi/wKeTKZdYi6SBdhAvNGLWGXbHVP91D0/y3OiVgUj4sWE1/dLgWfQri7w==
X-Received: by 2002:a1c:1f41:: with SMTP id f62mr28067454wmf.176.1565611655458;
        Mon, 12 Aug 2019 05:07:35 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j9sm1883415wrx.66.2019.08.12.05.07.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:07:35 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 6/8] drm/bridge: dw-hdmi-i2s: reset audio fifo before applying new params
Date:   Mon, 12 Aug 2019 14:07:24 +0200
Message-Id: <20190812120726.1528-7-jbrunet@baylibre.com>
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

When changing the audio hw params, reset the audio fifo to make sure
any old remaining data is flushed.

The databook mentions that such reset should be followed by a reset of
the i2s block to make sure the samples stay aligned

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 6 ++++--
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.h           | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
index 0864dee8d180..41bee0099578 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
@@ -49,6 +49,10 @@ static int dw_hdmi_i2s_hw_params(struct device *dev, void *data,
 		return -EINVAL;
 	}
 
+	/* Reset the FIFOs before applying new params */
+	hdmi_write(audio, HDMI_AUD_CONF0_SW_RESET, HDMI_AUD_CONF0);
+	hdmi_write(audio, (u8)~HDMI_MC_SWRSTZ_I2SSWRST_REQ, HDMI_MC_SWRSTZ);
+
 	inputclkfs	= HDMI_AUD_INPUTCLKFS_64FS;
 	conf0		= HDMI_AUD_CONF0_I2S_ALL_ENABLE;
 
@@ -102,8 +106,6 @@ static void dw_hdmi_i2s_audio_shutdown(struct device *dev, void *data)
 	struct dw_hdmi *hdmi = audio->hdmi;
 
 	dw_hdmi_audio_disable(hdmi);
-
-	hdmi_write(audio, HDMI_AUD_CONF0_SW_RESET, HDMI_AUD_CONF0);
 }
 
 static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
index 091d7c28aa17..a272fa393ae6 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
@@ -940,6 +940,7 @@ enum {
 	HDMI_MC_CLKDIS_PIXELCLK_DISABLE = 0x1,
 
 /* MC_SWRSTZ field values */
+	HDMI_MC_SWRSTZ_I2SSWRST_REQ = 0x08,
 	HDMI_MC_SWRSTZ_TMDSSWRST_REQ = 0x02,
 
 /* MC_FLOWCTRL field values */
-- 
2.21.0

