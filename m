Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD30C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4543621479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OlLRjGyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388712AbfETNiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:38:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34265 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730555AbfETNiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:38:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id f8so8259139wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RpTG3YqbycVwvduhkvFP3UiUhyHPdqI1e6sTfcjn1Gc=;
        b=OlLRjGyRcvQIUG7tTn6GR1dQLGDeBIwQKVejCwIx8Fyt8+C+RokYrA071pNFZSodGB
         29QqZi0fyspsOlPLX1n7dF+li//GwdYGtWaD1MVaw/HFPiflRJL2FDUVeiJx2W3B3GXK
         bvyFi9zoFyf+vHXwXVM8goC/UGdY8q8QTyJqe5d+vnaTn3z29p+XfvzPGlY9+sdefT6t
         NuJRkvDsp3a+ogTRzHArof9TCbGODUfomXkQGbOZGZz4Q8g4ZUwzrKw6/x2Ws1QSM5yJ
         ZQTgQCzpTL/sYmQlKKQBAvK1sLqxCxkg7gMr0uQ/sFSJRcVYJh3tXeZnZg1FIPVKE0YF
         v/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RpTG3YqbycVwvduhkvFP3UiUhyHPdqI1e6sTfcjn1Gc=;
        b=C+E0Z7PsHdLL6ntV2kHGA2ovCTmMZIhVZDhIZSxLqVt/TZRNxhfG07keUj0vmipKcY
         RbrZ3GfVdjvZ0dU6pyTHm1ZmMFR+WP1SXAaud9kmvtgg2JCbEL4dLMABFtF0XyXK+LJs
         A41nhqOpgKFYB66JBKnUEECjTOsSIpe0kvS3F7SvCJGIM53F0gNvdtdxUPvI60jgkPG7
         1YVI+xP3iNxRcHlMSzXPYaZOSLo+lBXQvC+Z+NEgf7ObfQK67wDyIM72goLTeVkVwlC+
         s3pemk0tZu3JWoeqp+U0w1a7mXRqWQl86M8jrqxky4ddt3dplv960zgaDyzAfqae3eru
         t6Eg==
X-Gm-Message-State: APjAAAV/xlNDNe1KBPYjHIm9uPrPEv/9EqbqMSmMuODGgCwUMJypJRCf
        iJxg0n3z3OcOezGuLoelNfHLYA==
X-Google-Smtp-Source: APXvYqxonM/GOKU79P5eVOsqtwE35oRw5SktT2gEcdfcQ90Tlqo32JmglhRL7ss2QzUAHCMRfW8wlg==
X-Received: by 2002:adf:e408:: with SMTP id g8mr13689365wrm.143.1558359478875;
        Mon, 20 May 2019 06:37:58 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t19sm12167059wmi.42.2019.05.20.06.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 06:37:58 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com
Cc:     jonas@kwiboo.se, hverkuil@xs4all.nl,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, jernej.skrabec@siol.net,
        heiko@sntech.de, maxime.ripard@bootlin.com, hjc@rock-chips.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] drm/bridge: add encoder support to specify bridge input format
Date:   Mon, 20 May 2019 15:37:50 +0200
Message-Id: <20190520133753.23871-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520133753.23871-1-narmstrong@baylibre.com>
References: <20190520133753.23871-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new format_set() callback to the bridge ops permitting
the encoder to specify the new input format and encoding.

This allows supporting the very specific HDMI2.0 YUV420 output mode
when the bridge cannot convert from RGB or YUV444 to YUV420.

In this case, the encode must downsample before the bridge and must
specify the bridge the new input bus format differs.

This will also help supporting the YUV420 mode where the bridge cannot
downsample, and also support 10bit, 12bit and 16bit output modes
when the bridge cannot convert between different bit depths.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/drm_bridge.c | 35 +++++++++++++++++++++++++++++++++++
 include/drm/drm_bridge.h     | 19 +++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 138b2711d389..33be74a977f7 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -307,6 +307,41 @@ void drm_bridge_mode_set(struct drm_bridge *bridge,
 }
 EXPORT_SYMBOL(drm_bridge_mode_set);
 
+/**
+ * drm_bridge_format_set - setup with proposed input format and encoding for
+ *			   all bridges in the encoder chain
+ * @bridge: bridge control structure
+ * @input_bus_format: proposed input bus format for the bridge
+ * @input_encoding: proposed input encoding for this bridge
+ *
+ * Calls &drm_bridge_funcs.format_set op for all the bridges in the
+ * encoder chain, starting from the first bridge to the last.
+ *
+ * Note: the bridge passed should be the one closest to the encoder
+ *
+ * RETURNS:
+ * true on success, false if one of the bridge cannot handle the format
+ */
+bool drm_bridge_format_set(struct drm_bridge *bridge,
+			   const u32 input_bus_format,
+			   const u32 input_encoding)
+{
+	bool ret = true;
+
+	if (!bridge)
+		return true;
+
+	if (bridge->funcs->format_set)
+		ret = bridge->funcs->format_set(bridge, input_bus_format,
+						input_encoding);
+	if (!ret)
+		return ret;
+
+	return drm_bridge_format_set(bridge->next, input_bus_format,
+				     input_encoding);
+}
+EXPORT_SYMBOL(drm_bridge_format_set);
+
 /**
  * drm_bridge_pre_enable - prepares for enabling all
  *			   bridges in the encoder chain
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index d4428913a4e1..7a79e61b7825 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -198,6 +198,22 @@ struct drm_bridge_funcs {
 	void (*mode_set)(struct drm_bridge *bridge,
 			 const struct drm_display_mode *mode,
 			 const struct drm_display_mode *adjusted_mode);
+
+	/**
+	 * @format_set:
+	 *
+	 * This callback should configure the bridge for the given input bus
+	 * format and encoding. It is called after the @format_set callback
+	 * for the preceding element in the display pipeline has been called
+	 * already. If the bridge is the first element then this would be
+	 * &drm_encoder_helper_funcs.format_set. The display pipe (i.e.
+	 * clocks and timing signals) is off when this function is called.
+	 *
+	 * @returns: true in success, false is a bridge refuses the format
+	 */
+	bool (*format_set)(struct drm_bridge *bridge,
+			   const u32 input_bus_format,
+			   const u32 input_encoding);
 	/**
 	 * @pre_enable:
 	 *
@@ -311,6 +327,9 @@ void drm_bridge_post_disable(struct drm_bridge *bridge);
 void drm_bridge_mode_set(struct drm_bridge *bridge,
 			 const struct drm_display_mode *mode,
 			 const struct drm_display_mode *adjusted_mode);
+bool drm_bridge_format_set(struct drm_bridge *bridge,
+			   const u32 input_bus_format,
+			   const u32 input_encoding);
 void drm_bridge_pre_enable(struct drm_bridge *bridge);
 void drm_bridge_enable(struct drm_bridge *bridge);
 
-- 
2.21.0

