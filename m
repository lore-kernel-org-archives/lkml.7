Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561EDC32753
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E1221721
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="daHHObEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfHLMHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:07:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52118 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbfHLMHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:07:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so11932588wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nyk3iRwUiWOF3HR8AgEI8oTD0AAO9L4Qd9ulSVgUQuc=;
        b=daHHObEVwiPB5m8eB3TinS4M9hhoYOX7OGD3cCnIcEdu8mEBbC2sxvbHgwNQgNQaGl
         e+ADZVLpFJLcl5mKHLragQdiafg85cuqpCUuGO05kZO+gqWvdMosoWdf76Lir6wDtR+G
         wnM/evLYE5mIEGNMDuMjreFZbxAt2EM/BzD4bWna14viPvYztIKdPE8Jjk2RtbvecAiH
         +vTiUF5wWddKT/m+Wal8DQpROpSVRSZ7RWDQLYKJ0cneQ7GBQEZGV/d/J3AAidyIBRzk
         kxtw4nWL8qMqRra9ftu6k3t/ezDcKlv0PBbJUX4418BaYieMPY6X3fasAC7Y3ddZnMCg
         N1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nyk3iRwUiWOF3HR8AgEI8oTD0AAO9L4Qd9ulSVgUQuc=;
        b=Zn/gY2F6O+JKMZr8qPLEDhVWcjHy8stxiZ0lU+y7tfx4SUYUa+hFTxQNAjheNcLDkA
         R3b2sOQhUnEtLm4xgbOBsBeO43J0sd8NMOVoauvVOURvI59RsG5gN2ITbAZ1G7VSBh6t
         N8Nq3h6scvIPXkJBFq4LRlTYyRTsPsXAfxY1Myu0oTSveupbtW4/FKgsSf0EZOzHIVx9
         caqQhaS4UHVcbf9o1G1pQsHmqsEpLQJj2/EdyVoDh1CZy1TW9aw6XjSaXrXTSFSP8iCA
         xpGLDL92oUehw+Hon3zods/YdNKwCjCiH3v333HVRQHEaBnbBG4UZk3ZgZazwI4f+Zga
         2LOA==
X-Gm-Message-State: APjAAAWu7GJbmfvbnThfkjjYD5sdJaE5Cmh6ONEKIj5C3Ez9CjS3ed2i
        OjJvHji/ub9iyL2nToOOdoYFoQ==
X-Google-Smtp-Source: APXvYqwZVxC6uqEmw1OcoTKuej0fydwIHFvl7lI/fxWxv8zWW97aQe6c/fxAXhNOvT0IR2pM7GDSRA==
X-Received: by 2002:a1c:6641:: with SMTP id a62mr26440820wmc.175.1565611656356;
        Mon, 12 Aug 2019 05:07:36 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j9sm1883415wrx.66.2019.08.12.05.07.35
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
Subject: [PATCH v2 7/8] drm/bridge: dw-hdmi-i2s: enable only the required i2s lanes
Date:   Mon, 12 Aug 2019 14:07:25 +0200
Message-Id: <20190812120726.1528-8-jbrunet@baylibre.com>
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

Enable the i2s lanes depending on the number of channel in the stream

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c   | 15 ++++++++++++++-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.h         |  6 +++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
index 41bee0099578..b8ece9c1ba2c 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
@@ -54,7 +54,20 @@ static int dw_hdmi_i2s_hw_params(struct device *dev, void *data,
 	hdmi_write(audio, (u8)~HDMI_MC_SWRSTZ_I2SSWRST_REQ, HDMI_MC_SWRSTZ);
 
 	inputclkfs	= HDMI_AUD_INPUTCLKFS_64FS;
-	conf0		= HDMI_AUD_CONF0_I2S_ALL_ENABLE;
+	conf0		= (HDMI_AUD_CONF0_I2S_SELECT | HDMI_AUD_CONF0_I2S_EN0);
+
+	/* Enable the required i2s lanes */
+	switch (hparms->channels) {
+	case 7 ... 8:
+		conf0 |= HDMI_AUD_CONF0_I2S_EN3;
+		/* Fall-thru */
+	case 5 ... 6:
+		conf0 |= HDMI_AUD_CONF0_I2S_EN2;
+		/* Fall-thru */
+	case 3 ... 4:
+		conf0 |= HDMI_AUD_CONF0_I2S_EN1;
+		/* Fall-thru */
+	}
 
 	switch (hparms->sample_width) {
 	case 16:
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
index a272fa393ae6..6988f12d89d9 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
@@ -865,7 +865,11 @@ enum {
 
 /* AUD_CONF0 field values */
 	HDMI_AUD_CONF0_SW_RESET = 0x80,
-	HDMI_AUD_CONF0_I2S_ALL_ENABLE = 0x2F,
+	HDMI_AUD_CONF0_I2S_SELECT = 0x20,
+	HDMI_AUD_CONF0_I2S_EN3 = 0x08,
+	HDMI_AUD_CONF0_I2S_EN2 = 0x04,
+	HDMI_AUD_CONF0_I2S_EN1 = 0x02,
+	HDMI_AUD_CONF0_I2S_EN0 = 0x01,
 
 /* AUD_CONF1 field values */
 	HDMI_AUD_CONF1_MODE_I2S = 0x00,
-- 
2.21.0

