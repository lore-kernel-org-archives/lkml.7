Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9CBC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27F1214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NNOrlaFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfHENlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:41:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41125 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729437AbfHENlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:41:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so81242799wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 06:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ey1PsfmA4wlAavqiJpE2shxdYitiWZIgciri4C4xXGA=;
        b=NNOrlaFbC6G9Tou31NekV1Ouhhn/xSj9Bsy90P1UEbm9ZP4Ce+OUczmhiGXI1ortyf
         2+rUNATxBIW1waSope2cT9bIGUYin4pyBuxmnAHJfu6Vjv5a2XuaMSLVfG3efjSrQMvL
         X+3Pi9ZFuqSeRI1KjrdTuTuEU7uVgp1WkeHlEjloWwne4xg3mV0ntH30tYf0c0H+kT79
         PTNP2fCK79k7vGVZ5DLBrnkGQ51nMN/pqEpOkFJAa6odkJFZey9yrmS56oooI7KhcrpO
         EgafSUEQpDbkkZkIXzJBd2wOsG/3Hwx2wFOw5DwpDWZRjOuMuA4jfAB8FFpHUaKb66L3
         Wmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ey1PsfmA4wlAavqiJpE2shxdYitiWZIgciri4C4xXGA=;
        b=FmGXmMC2eSoZ2o5JPLx0ervXep+q40Q1RLYgRGxegcU8q/2G0y4O0ofn+Vr4D+t1JP
         pVGtQWMwBC3UOiM6TARfzjEbGEOTiyix5FOlASDCOijQ3W4V1d4/27o8SYZjn5Fn7lEK
         v8cYRljGAJLL6NI0gN+ieHcqSBbgyi8FtrxFhWV7fxAxp9IUhGyYTmfhVpauaB7R+/JJ
         tmXvhZMQViCRwOwDu9suPTIzP4B7/VSUIlGNEP4pkmWlTEzIsBd4WRWwb4gvHQ1duFko
         TchdDps2XQxZCqxr53Qmj1trrqgZ836wp238gxOP9PI2UkLA6qnQWchvxIhWJei4oHPk
         rSdA==
X-Gm-Message-State: APjAAAVUD34aE1IDaoIMyzS1rw3p8+dl8lh+nKku8yxeqqdsmnso0/0r
        9Ds3eXwkYJ1Nn4nhmUVYQtrZuw==
X-Google-Smtp-Source: APXvYqzQEmYNNKdpwB70iG2hSugrGTyqUNs6qvvdcYTcpEwkg8EPnq7u5XMWR9ACmgixbvAgeKBGug==
X-Received: by 2002:a5d:514f:: with SMTP id u15mr16161947wrt.183.1565012473623;
        Mon, 05 Aug 2019 06:41:13 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id w7sm99040534wrn.11.2019.08.05.06.41.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 06:41:13 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 7/8] drm/bridge: dw-hdmi-i2s: enable only the required i2s lanes
Date:   Mon,  5 Aug 2019 15:41:01 +0200
Message-Id: <20190805134102.24173-8-jbrunet@baylibre.com>
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

Enable the i2s lanes depending on the number of channel in the stream

Cc: Jonas Karlman <jonas@kwiboo.se>
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

