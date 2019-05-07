Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AE2C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12E62053B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jm+TvJfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfEGNHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:07:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34495 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGNH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:07:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck18so8184749plb.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 06:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zVEShq2r+HH1dqUKjsY/tIvQnR4fC4lx62sAnv2cszQ=;
        b=jm+TvJfNFt6JoZDpIcsdQYCpeFYqOblkOGI08ywsGy57x+8/bmkSF4Jiva803NbPKE
         s7m5WLd6gfL1+tbGQjSyYmf3uBgqOudNS4xmd/KNNKzha6oI95GWuIDU4syC1mQ+66W8
         lrUJaarBqXPhwdumssK7oXfiCQKiWLW3S0Kas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zVEShq2r+HH1dqUKjsY/tIvQnR4fC4lx62sAnv2cszQ=;
        b=tPuuT10xrjGrkYcAemq2W+NHhaPjNMigjmpluOhkDKCxtPKE7XYUXsjW1cXvanjzEY
         2XsO7HceslC3gL3Cy6qTdf/h+eQizCzEWU0x4ejKmbLLk9kvwZQk2xyZDdlKc/zekY/q
         8UYjchBI3+bHGL99eft2i0S2NU7h3NxotXGxARQulJppfX71nm8bMNgUPdXlqRaqiKss
         0UREOeFgfboT+OUJNFXFzzNUyeO8s50lvvrkCz7/Isu/UzieZDJMpNANLPTRT9GMCgIc
         3d1HdOqTv7crCaq7EBy8aM7yeBFj5w8BkoHdovPCScaNi3+FUNtpUnnfUuia5kML1xu6
         d1sQ==
X-Gm-Message-State: APjAAAWvrlR2ShBW8x4zFyKJSoI7mUTCZtRA9kbVUs5CPuPlHlIlXIyN
        Uw3ZXQHzLq7IPYjyg6/gyaGeHg==
X-Google-Smtp-Source: APXvYqxTNLStKgWqhFuYnzLAEpQKZaTXrhsWJy7MmuW5PcblTQp6f4JovNxg5jyNfUeBBZ2VP2/bHQ==
X-Received: by 2002:a17:902:2a:: with SMTP id 39mr39639547pla.64.1557234449180;
        Tue, 07 May 2019 06:07:29 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:3682:cdb6:452:ecda:bdfa:452e])
        by smtp.gmail.com with ESMTPSA id w190sm21889823pfb.101.2019.05.07.06.07.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 06:07:28 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/3] dt-bindings: display: Document FriendlyELEC HD702E LCD panel
Date:   Tue,  7 May 2019 18:37:06 +0530
Message-Id: <20190507130708.11255-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HD702E lcd is FriendlyELEC developed eDP LCD panel with 800x1280
resolution. It has built in Goodix, GT9271 captive touchscreen
with backlight adjustable via PWM.

Add dt-bindings documentation for it.
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- separate binding patch from driver
- Add simple-panel compatible as fallback
- Add text info about simple-panel bindings

 .../display/panel/friendlyarm,hd702e.txt      | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.txt

diff --git a/Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.txt b/Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.txt
new file mode 100644
index 000000000000..6c9156fc3478
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.txt
@@ -0,0 +1,32 @@
+FriendlyELEC HD702E 800x1280 LCD panel
+
+HD702E lcd is FriendlyELEC developed eDP LCD panel with 800x1280
+resolution. It has built in Goodix, GT9271 captive touchscreen
+with backlight adjustable via PWM.
+
+Required properties:
+- compatible: should be "friendlyarm,hd702e"
+- power-supply: regulator to provide the supply voltage
+
+Optional properties:
+- backlight: phandle of the backlight device attached to the panel
+
+Optional nodes:
+- Video port for LCD panel input.
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
+
+Example:
+
+	panel {
+		compatible ="friendlyarm,hd702e", "simple-panel";
+		backlight = <&backlight>;
+		power-supply = <&vcc3v3_sys>;
+
+		port {
+			panel_in_edp: endpoint {
+				remote-endpoint = <&edp_out_panel>;
+			};
+		};
+	};
-- 
2.18.0.321.gffc6fa0e3

