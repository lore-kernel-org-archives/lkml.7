Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63E4C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1EE217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MMbn8v2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390790AbfEXKnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:43:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45000 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390578AbfEXKno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:43:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so4845385pgp.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 03:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qNTSCPsOEC2W2+GNT7l2VKFB0+zY6ZYUs+njP7ZZryY=;
        b=MMbn8v2Zd2qsn/V/zb6Mt7MtfVlWEps+yV995UvWXL1qqyAQ3BZmYedcZmufHrmzso
         pmn/HjUvKsI28wdzVni96j2suAg2VF2NOyBYHDWkoag8/K6d/bRvl3k9S3+JbubG81qG
         C/PJWR2X8Czf3xVJnt9ALXMpfquiiK0chagBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qNTSCPsOEC2W2+GNT7l2VKFB0+zY6ZYUs+njP7ZZryY=;
        b=PpwXGL/pXxAn372y4wf6DKNSLKzdWGunsxRajfe/UnaqwPEQfsJhu3LG4QFNcpKuCK
         MqOsiI3L5shL1t6pMMTe3iE4uX/AcrSvz0WEtK7z+03bLBWg6JGyMmhFxXqj+g5wVpjH
         PIUfr9Yv1bNVsrw/dVO0rpJvsLAObU0Ygm9b15wAdXf38SkjLe/L0yemNFYsUUHq++/e
         1kaPTb+N+EgtxYN2vCGwIQrTqidrQYzIjmyfQqBCiMGtVHtpUStYRVO9ZDg6bgAnuL+F
         iJ7wA/eZGT25bq2ohs72579wnec3M1EeruqR6KKoE09Yk2k8EgOiGL9m6762RZIf19RY
         A7EQ==
X-Gm-Message-State: APjAAAWH/pNHtLzk0318OHANDM0LPFblwlIPfg96wbf2EEe0hb3aGaFt
        Vo3yCRKSFd3/na4GX/NTJIlkZA==
X-Google-Smtp-Source: APXvYqwKcohDIPUT5/aEC255pUPB2TXqU3TOva/kNXfG24c8fTCD7t9u2h8RQ7FYuSxfiGAGamTVqQ==
X-Received: by 2002:a62:5653:: with SMTP id k80mr110389226pfb.144.1558694623629;
        Fri, 24 May 2019 03:43:43 -0700 (PDT)
Received: from localhost.localdomain ([183.82.227.60])
        by smtp.gmail.com with ESMTPSA id h11sm2303416pfn.170.2019.05.24.03.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 03:43:43 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 4/6] dt-bindings: display: bridge: Add ICN6211 MIPI-DSI to RGB converter bridge
Date:   Fri, 24 May 2019 16:13:15 +0530
Message-Id: <20190524104317.20287-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190524104317.20287-1-jagan@amarulasolutions.com>
References: <20190524104317.20287-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ICN6211 is MIPI-DSI/RGB converter bridge from chipone.
It has a flexible configuration of MIPI DSI signal input
and produce RGB565, RGB666, RGB888 output format.

Add dt-bingings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../display/bridge/chipone,icn6211.txt        | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt
new file mode 100644
index 000000000000..53a9848ef8b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt
@@ -0,0 +1,78 @@
+Chipone ICN6211 MIPI-DSI to RGB Converter Bridge
+
+ICN6211 is MIPI-DSI/RGB converter bridge from chipone.
+It has a flexible configuration of MIPI DSI signal input
+and produce RGB565, RGB666, RGB888 output format.
+
+Required properties for RGB:
+- compatible: must be "chipone,icn6211"
+- reg: the virtual channel number of a DSI peripheral
+- reset-gpios: a GPIO phandle for the reset pin
+
+The device node can contain following 'port' child nodes,
+according to the OF graph bindings defined in [1]:
+  0: DSI Input, not required, if the bridge is DSI controlled
+  1: RGB Output, mandatory
+
+[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
+
+Example:
+
+	panel {
+		compatible = "bananapi,s070wv20-ct16", "simple-panel";
+		enable-gpios = <&pio 1 7 GPIO_ACTIVE_HIGH>; /* LCD-PWR-EN: PB7 */
+		backlight = <&backlight>;
+
+		port {
+			panel_out_bridge: endpoint {
+				remote-endpoint = <&bridge_out_panel>;
+			};
+		};
+	};
+
+&dsi {
+	vcc-dsi-supply = <&reg_dcdc1>;		/* VCC-DSI */
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dsi_out: port@0 {
+			reg = <0>;
+
+			dsi_out_bridge: endpoint {
+				remote-endpoint = <&bridge_out_dsi>;
+			};
+		};
+	};
+
+	bridge@0 {
+		compatible = "chipone,icn6211";
+		reg = <0>;
+		reset-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* LCD-RST: PL5 */
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			bridge_in: port@0 {
+				reg = <0>;
+
+				bridge_out_dsi: endpoint {
+					remote-endpoint = <&dsi_out_bridge>;
+				};
+			};
+
+			bridge_out: port@1 {
+				reg = <1>;
+
+				bridge_out_panel: endpoint {
+					remote-endpoint = <&panel_out_bridge>;
+				};
+			};
+		};
+	};
+};
-- 
2.18.0.321.gffc6fa0e3

