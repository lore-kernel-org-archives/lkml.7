Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ED6C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 04:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0AA20896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 04:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NpIiYZAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390459AbfFKEEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 00:04:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39124 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728821AbfFKED6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 00:03:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id j2so6535865pfe.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 21:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ys0DSil+WvCMaDGevz2dSiLwFPZR4jwAs4InRe1vZNA=;
        b=NpIiYZAZ293e5siqen5Oz27pVJuQEiqx/skxzzgF9MmBRxj1DCy5igwLq3xQY5fLt4
         6ijSQMHl5nqD2CEkVoKO7bNwFt2FMABbPicsIoQ+6XGy1CrK43ONHRMIiygoP/GBi1Tx
         mpT3cNIEtjV+ei2btpQJ+tOS5TF+m8OjwvjZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ys0DSil+WvCMaDGevz2dSiLwFPZR4jwAs4InRe1vZNA=;
        b=Z4P9dbkxwBNJA/qKFjFDmVDevtGla6a8+14GBVmUsDFplMBFI2PjLmZIhbLCYW9rz5
         zaFuCHQH8ALe5rVm0VXweSpAWDvsoZZAY2rszYw0KQvSPGLyd6bx91/epxVOzMqnOG+3
         I4njrT8L6nhTJVqdJx5AQVSeOm6Luv13L1q1pRH/eAbyU9wiRiR0C9AtR3wt87TG4OXK
         cJ7i8n+ZHqH+w1iz5N/UV1eqpS8t18xuDJJcVheraC40RHxqqs614PRylUPoDPxzJvLl
         A15y44yHOZ14y6fzG9DMLLhCbK0WtqXYwk6+l/tpjENarxsuaWyHPxXqk7sE225c1NCU
         H7SQ==
X-Gm-Message-State: APjAAAW8vMfshVgD8rIRKBlsvyNElILkNw/wIjATJXJMwz2E551niWTw
        ThT6zCxrTrpJdlnQpzcrktHCMbi1FoQ=
X-Google-Smtp-Source: APXvYqztkWgDwmpShVmNY3JX/yoLvhlQG+pv1dg44RWOiGpLZ5kd7o3wLJ474CqYq7S74tPbVuKsCw==
X-Received: by 2002:aa7:825a:: with SMTP id e26mr79303252pfn.255.1560225837698;
        Mon, 10 Jun 2019 21:03:57 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id y133sm13301185pfb.28.2019.06.10.21.03.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 21:03:57 -0700 (PDT)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH 2/5] dt-bindings: display/panel: Expand rotation documentation
Date:   Mon, 10 Jun 2019 21:03:47 -0700
Message-Id: <20190611040350.90064-3-dbasehore@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190611040350.90064-1-dbasehore@chromium.org>
References: <20190611040350.90064-1-dbasehore@chromium.org>
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

