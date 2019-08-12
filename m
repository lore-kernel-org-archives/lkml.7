Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A0DC32750
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0252D20651
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Or3uQR6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbfHLMHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:07:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41347 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfHLMHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:07:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id j16so2073622wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ceoz58HJhiw+4Z6q1/xd/gAe7VVmzCvD6fU8sO+lm5o=;
        b=Or3uQR6QO71RP1JieY4+QIypkqR1ZLSwxIsThtNzg2pwMJw3ABCgPudYblpSyj9V9U
         Ur910YS8Rv83kYjvTFn8d8JSeGMX0uL0dP2qioI7DJ2HB81GTaYS0I7ia+Pm4V0WNunt
         9Cep9ntP0tfqwN+EqG8JABr2Up4KQM/Fb2AsNgOkuPhktdjG+hCt6PJSr98UMiBlKvy5
         3ibft6dtlkFlG2OgeL12AMKbPtVlpitDZfN0XFZIOZlkjRLFplktrwwat9WpWDFv4tqp
         s0pWWckNeTbPaB2h0XABYkbZFQhwX2jPQI5Hcv34lLxlKWju91BJM3kA19oGZXZImzxQ
         Nd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ceoz58HJhiw+4Z6q1/xd/gAe7VVmzCvD6fU8sO+lm5o=;
        b=juVtlE4FLqLA6JNz+JBG3x09YZ3Vu8H4MRhWcdFtKXOwqtDaeonQNz9KlFsr08+BYn
         E6cBcRuOGoxbWZRZM8JxKdtMfuD+LnNTyBO6B9WboSg/OpQAsvIOtYuiTfSK00W980Ef
         LTSQtdg0FnriF9HKkEuubXlRHG9lCPAANDtEh+R3BF92olHdj2IdXU8gIATMp5qLbdo8
         MiEL4I0Kw92BjIZxzV8JiqUTmpHzp2p92/oDNQgtzGP83kgXNlEjn65PqqZsHBMfhTQ4
         FQ5llmOkrO8uecES6ciBj862l0DIsK0NNA9vDZ/7u2P7DJRM/wdQfDim6BRWaPHKSsy0
         hYzw==
X-Gm-Message-State: APjAAAWJJmpYby1YWYZX0TnaCSSPJj0gcZPT2kTPyCLMTLfQH+al7r/t
        Oob5aourx2u33HztYx0VIP1eQ/qS1kc=
X-Google-Smtp-Source: APXvYqy32yxW6ITSLrDXLyZ6668kqusWzhq85fvzCQmJeabhxKDQLSSVz4Wz9i/mCgPzAFNi0NpyqA==
X-Received: by 2002:adf:f705:: with SMTP id r5mr16743424wrp.342.1565611650885;
        Mon, 12 Aug 2019 05:07:30 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j9sm1883415wrx.66.2019.08.12.05.07.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:07:30 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/8] drm/bridge: dw-hdmi-i2s: support more i2s format
Date:   Mon, 12 Aug 2019 14:07:19 +0200
Message-Id: <20190812120726.1528-2-jbrunet@baylibre.com>
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

The dw-hdmi-i2s supports more formats than just regular i2s.
Add support for left justified, right justified and dsp modes
A and B.

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
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
2.21.0

