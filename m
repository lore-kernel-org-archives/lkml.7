Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6B0C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4312021743
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1g9KtaZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfFMPYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:24:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53785 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731684AbfFMMMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 08:12:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so9948150wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 05:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dxPAopxGigXChNe4VdO4Ubt5YTdhDcINUQzBTzEvzKk=;
        b=1g9KtaZe/+oTpytYwjZO6yBksvr6Iq1cGRxviJuU4NBlxHLTidBtC8fZ57YYsFdFl+
         xtC/aJBuwSN8BisYBx12l/oSJCZy7DIfRqBrq+rpXCGdLCHTxhXFvTmCBtsk8MkI0aAH
         6cChkYFKuHDiK7vinsQXX8B77oajTNHf6lWZJtc6spSEy9LQwmt38ohVGTwWglgjLY4J
         TI3fiUKEsldOjiU9UYzkJmmmskIlq62uhE+mgxWk7wo5ewSljqAyBDENmsZDwvEarMf1
         Mm0rEg0jEZtrwu7KfJ3heI5gmwlBnVyzf4HJO+Q7c9n41FDukqeJvEKo0oefEd/bXC1n
         Yvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dxPAopxGigXChNe4VdO4Ubt5YTdhDcINUQzBTzEvzKk=;
        b=a5LfHpdJcmhOT5Tq7alJ99FvHJNt37ClFVrrKySRlRBILi0tr42fhrYY1CMok6Mzsz
         tcWk2xdELQAr9P3rmJ3txrgc2sVtOQ9trOfwDj+nj7arIYdlWevaqvuqe5fEj/cCbZ6c
         rOSQfRfk85q593En9VGDfN3PTfcvdXf57bDkCHxiQIQrUW5pNC77UFRQ5aGFvZv6SF47
         BpR+uux7hVy1j32Q/hasNsoUrXllxZu7NVABqHZOZgjkO+yslDvwmGS7Wd/Qn4M21Xed
         eSDn5aTLSmxjSLb63BK/KvYo2Bs0iZWsK3BYyxysP9GTBR3pwv27U/F/MlCHSZMbhJ+M
         fH+A==
X-Gm-Message-State: APjAAAU/iceTEojtRpZQydy8zkf7nyTdDJsG6oSuJN8oPvkLPctWLYsH
        XtfWBNZcdwBiFWidPH1jh8BVHQ==
X-Google-Smtp-Source: APXvYqxnPKLSaS0xc8+5oGeF/I6OTATx59AZvwhfSt3I2nQvb+XqlMcdxs+3C8O2o5Llg/zX03VARw==
X-Received: by 2002:a7b:c344:: with SMTP id l4mr3450592wmj.25.1560427931387;
        Thu, 13 Jun 2019 05:12:11 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f6sm2974532wrw.68.2019.06.13.05.12.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 05:12:10 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm: dw-hdmi-i2s: support more i2s format
Date:   Thu, 13 Jun 2019 14:12:07 +0200
Message-Id: <20190613121207.12185-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dw-hdmi-i2s supports more formats than just regular i2s.
Add support for left justified, right justified and dsp modes
A and B.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 Tested on the Amlogic arm64 meson-g12a-sei510 with i2s, left_j, dsp_a
 and dsp_b. right_j is not supported by this platform.

 .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   | 26 ++++++++++++++++---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.h     |  6 +++--
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
index 5cbb71a866d5..2b624cff541d 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
@@ -44,9 +44,8 @@ static int dw_hdmi_i2s_hw_params(struct device *dev, void *data,
 	u8 inputclkfs = 0;
 
 	/* it cares I2S only */
-	if ((fmt->fmt != HDMI_I2S) ||
-	    (fmt->bit_clk_master | fmt->frame_clk_master)) {
-		dev_err(dev, "unsupported format/settings\n");
+	if (fmt->bit_clk_master | fmt->frame_clk_master) {
+		dev_err(dev, "unsupported clock settings\n");
 		return -EINVAL;
 	}
 
@@ -63,6 +62,27 @@ static int dw_hdmi_i2s_hw_params(struct device *dev, void *data,
 		break;
 	}
 
+	switch (fmt->fmt) {
+	case HDMI_I2S:
+		conf1 |= HDMI_AUD_CONF1_MODE_I2S;
+		break;
+	case HDMI_RIGHT_J:
+		conf1 |= HDMI_AUD_CONF1_MODE_RIGHT_J;
+		break;
+	case HDMI_LEFT_J:
+		conf1 |= HDMI_AUD_CONF1_MODE_LEFT_J;
+		break;
+	case HDMI_DSP_A:
+		conf1 |= HDMI_AUD_CONF1_MODE_BURST_1;
+		break;
+	case HDMI_DSP_B:
+		conf1 |= HDMI_AUD_CONF1_MODE_BURST_2;
+		break;
+	default:
+		dev_err(dev, "unsupported format\n");
+		return -EINVAL;
+	}
+
 	dw_hdmi_set_sample_rate(hdmi, hparms->sample_rate);
 
 	hdmi_write(audio, inputclkfs, HDMI_AUD_INPUTCLKFS);
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
index 4e3ec09d3ca4..091d7c28aa17 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
@@ -869,8 +869,10 @@ enum {
 
 /* AUD_CONF1 field values */
 	HDMI_AUD_CONF1_MODE_I2S = 0x00,
-	HDMI_AUD_CONF1_MODE_RIGHT_J = 0x02,
-	HDMI_AUD_CONF1_MODE_LEFT_J = 0x04,
+	HDMI_AUD_CONF1_MODE_RIGHT_J = 0x20,
+	HDMI_AUD_CONF1_MODE_LEFT_J = 0x40,
+	HDMI_AUD_CONF1_MODE_BURST_1 = 0x60,
+	HDMI_AUD_CONF1_MODE_BURST_2 = 0x80,
 	HDMI_AUD_CONF1_WIDTH_16 = 0x10,
 	HDMI_AUD_CONF1_WIDTH_24 = 0x18,
 
-- 
2.20.1

