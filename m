Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E90FC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 00:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB802145D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 00:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X12Jn3AU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390784AbfFKAXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 20:23:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45418 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388749AbfFKAXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 20:23:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id w34so5875292pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 17:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ys0DSil+WvCMaDGevz2dSiLwFPZR4jwAs4InRe1vZNA=;
        b=X12Jn3AUd//JNQCTWSBR6eh9r650AWw9Xjg7KpO0V+0SA2HdJEsEae1jQkqDPHyQKe
         F9jkL7x/7/FbANfIR4mwRASAg6AXFvQesI26VoF7tgXODbVqSvH4TDWixSqzy/8t/2Oe
         o6kb4qUN0UwhrIOg/a3lFqtIXvRAqNQYOcNrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ys0DSil+WvCMaDGevz2dSiLwFPZR4jwAs4InRe1vZNA=;
        b=Mi4zEEp+XcUH3kwzqgTA5QiqNKbjZCdQ5JVsv3i4BMtklZlzrtbGHwObyppGB49nJj
         mcNZ7STt/ht19GkuDqLFrEdD//CACy0wWW1hFijYLZCJOZvBDSOwu89IJ05jceagk4Wy
         1AbT5xyRa026YXDYyn0g0HRlTk654VHfWa53vhP2cs5EDzc7BvHMckK4/GQGDfb3kBqP
         PAb0WsafqdKeDL4n18WGvH5GxZyA+1c6rwFHMb3GvdZZdEu3QNbtjQmNERUgU53YAYs/
         WcTeuqgJ0RG+s4b/Zc6ed2634OWIp/nnZ7z8il3+nF++Ud/EKIax9w3eEOtDcQQr5fCg
         y8vA==
X-Gm-Message-State: APjAAAX1b3l/6P1YeeWZP9Ui3NV5b+3p6VNsZMXtHfAr6clfWRPOud05
        IeoLYmeGpwk6C8EnX+E35MVuBYeYoBg=
X-Google-Smtp-Source: APXvYqxAc42hyNbAAjVSUHVWNoM3DB7fjZVsqMVi9qbCUz/7kQyXOOCdI5Fe02ZPTYUapCArvj8xLA==
X-Received: by 2002:a62:7552:: with SMTP id q79mr57521992pfc.71.1560212587343;
        Mon, 10 Jun 2019 17:23:07 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id t4sm540317pjq.19.2019.06.10.17.23.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 17:23:06 -0700 (PDT)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        thierry.reding@gmail.com, sam@ravnborg.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, ck.hu@mediatek.com, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH 2/5] dt-bindings: display/panel: Expand rotation documentation
Date:   Mon, 10 Jun 2019 17:22:53 -0700
Message-Id: <20190611002256.186969-3-dbasehore@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190611002256.186969-1-dbasehore@chromium.org>
References: <20190611002256.186969-1-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds to the rotation documentation to explain how drivers should
use the property and gives an example of the property in a devicetree
node.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 .../bindings/display/panel/panel.txt          | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel.txt b/Documentation/devicetree/bindings/display/panel/panel.txt
index e2e6867852b8..f35d62d933fc 100644
--- a/Documentation/devicetree/bindings/display/panel/panel.txt
+++ b/Documentation/devicetree/bindings/display/panel/panel.txt
@@ -2,3 +2,35 @@ Common display properties
 -------------------------
 
 - rotation:	Display rotation in degrees counter clockwise (0,90,180,270)
+
+Property read from the device tree using of of_drm_get_panel_orientation
+
+The panel driver may apply the rotation at the TCON level, which will
+make the panel look like it isn't rotated to the kernel and any other
+software.
+
+If not, a panel orientation property should be added through the SoC
+vendor DRM code using the drm_connector_init_panel_orientation_property
+function.
+
+Example:
+	panel: panel@0 {
+		compatible = "boe,himax8279d8p";
+		reg = <0>;
+		enable-gpios = <&pio 45 0>;
+		pp33-gpios = <&pio 35 0>;
+		pp18-gpios = <&pio 36 0>;
+		pinctrl-names = "default", "state_3300mv", "state_1800mv";
+		pinctrl-0 = <&panel_pins_default>;
+		pinctrl-1 = <&panel_pins_3300mv>;
+		pinctrl-2 = <&panel_pins_1800mv>;
+		backlight = <&backlight_lcd0>;
+		rotation = <180>;
+		status = "okay";
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&dsi_out>;
+			};
+		};
+	};
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

