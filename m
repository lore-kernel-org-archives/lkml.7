Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A92C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C0E21773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oi+vNi0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfC2Kmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:42:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53705 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbfC2Kms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:42:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id q16so1996285wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 03:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qVVZM+F4bg9NburQNjeHoxpSPD/FS5oVjjumPmHKkFw=;
        b=oi+vNi0JHgy+MUNw6O7ROBazXPwy92e57mnf/YfCFF1H3aecRoAJ0zdwFUoyOTrHfH
         irzEzzn2o3el3fmhiIQia6H55YbYPuAb26HpSUMRhqZcTKZscMov+PUgOFr9R6q7CRto
         MgGeBX9xvXOfUo8ToK3rEneAEXXo9E+TarBNhFcOAwn7MPIKTiMpId7usnrA6UF5YUoS
         S8UzVGCuqjKz+5GJuUTU5ypsVCDMip/pIxgnC45QVBz4jZk8HTDZSmyzbuYq5h6icxgP
         cJrdSw7WHu7NUYToKggnKZjUqj2Ts0vbvsBAhg6H3hVUGNlb67RFYeiG/sngW19xDI69
         Sajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qVVZM+F4bg9NburQNjeHoxpSPD/FS5oVjjumPmHKkFw=;
        b=mCQ7Epgg388zU34L5yCBqzfYrKLfY3vS2h6z+XsIXIut7bICNlSOyExN8s7tUCKA3K
         rikZpr8RJFjGw8mi/DOcVzdZKFsYqxWzeplY1J1KnjqT3NOMO8BfDKQ/AqRpCk7DbQlw
         7+bmgIqkv/HHFJSoCxH3kfIaldpboxXWC6UgHkSoricgjsdq5lQSRAPLQJjyRDLQtEDt
         OINKxxk9IBP7MvveSlC/lm26AUcV6njGj1oREOOnLsPR78oa7FLsLr9qtHkCSUdPA1E0
         YQlKrpwaDu0hIR/FYkMQKyJtHyeg5u+psAYKUyqmsVHb811NJOeRsV4lMZ5GQieMsITb
         LSaQ==
X-Gm-Message-State: APjAAAVkXBgMtiJJvHpZ9H6Y3Y3OguH4u/eCUTeCuO/JXN8Acl7Ucn7k
        YKkLlLb/ht+V1HG3k+dCLOaJiQ==
X-Google-Smtp-Source: APXvYqwOpYWG7/gxs6bSfdwHPwUiRszaTTdlpJxrzPKo79MbNEMLNsDIrRkg2I781r4ymOVU+vKVmQ==
X-Received: by 2002:a1c:f204:: with SMTP id s4mr3198480wmc.51.1553856165258;
        Fri, 29 Mar 2019 03:42:45 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o15sm1632826wrj.59.2019.03.29.03.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Mar 2019 03:42:44 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, jernej.skrabec@siol.net,
        heiko@sntech.de, maxime.ripard@bootlin.com, hjc@rock-chips.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/5] drm/bridge: add encoder support to specify bridge input format
Date:   Fri, 29 Mar 2019 11:42:37 +0100
Message-Id: <20190329104240.29585-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190329104240.29585-1-narmstrong@baylibre.com>
References: <20190329104240.29585-1-narmstrong@baylibre.com>
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
index 138b2711d389..b2ce2d3d070e 100644
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
+	if (ret)
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
index 9da8c93f7976..223253b15763 100644
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
@@ -312,6 +328,9 @@ void drm_bridge_post_disable(struct drm_bridge *bridge);
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

