Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5277EC00319
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 10:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2062120836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 10:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeWD2o4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfCBKlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 05:41:36 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36693 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCBKle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 05:41:34 -0500
Received: by mail-ed1-f65.google.com with SMTP id g9so437090eds.3;
        Sat, 02 Mar 2019 02:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k0IZOdvLCkGg4A1rG/jT9gs59rhyTgC9sJn60ktdxwY=;
        b=jeWD2o4AGv6UjXZu6suNlyvpGFu4DPSJLzkF+l1PO+5S0Z8Ahe2OWd+wDuhH9+nMKd
         4WK3JqUhKZXEBiBHFvf+2eEzQFVbllTyD5DycWRyG/NZVih3wd9OTYNVSZNix9/4gBc5
         P9mdV+ilJtTOuXBbbbzlAAZkeZVyE3Hr76MnXheWTebRgvYUU2hOCoVhk6HrVah6GEyw
         bU9j0ywGi9bLo+kYpBmrGaCGWv1WKCywSKXRMYc7XCOvAahnL+CSOWlLKoS9xXlR2QPt
         BdIMota+sZxDnHuve9NIsciWCi6RId4QqeNcgr8PFCTNdSA4XhZwODYvb3CV5Cb5+4sE
         N7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k0IZOdvLCkGg4A1rG/jT9gs59rhyTgC9sJn60ktdxwY=;
        b=QV4pyTIjbfdpER5xcpDi4iyfDL+kaaPiCoazfYZXA5JdDB8GgkxzmSRn2WEElKkyIa
         kqD9Rpwh/6SxvsUQBRdUMCNO3Ray88hIjV9Yge8PCY7HbVCQRj1BXRNXU2ttX2cKNOXt
         p36SwjVM5vbiTCO+HzdVl9CgbbJ0j7M8tmWEEceNQTIl3e1c9tfE92E6oSRZCBjMzKBa
         HI872FWCpTj3tDF9Ro4yYEPe1SK+GFCeAr5HHS1/B09O6euymlfCmh3+VbxFcdfr8XsV
         fombxcx6gZAPMCakzr2KNOaj/BETCYXU/IM7qVaD1HGGGfRoeBtoj9t29xxvsTbePso/
         FMcQ==
X-Gm-Message-State: APjAAAWKmZGgb3i+Y7yZdcvKy/EdsLwgcTXQYwXkPhLvyhDJkNMTDED5
        DJUc/fqmxM6dsB5tW4dDv0c=
X-Google-Smtp-Source: APXvYqw6XTc5iltKzPZx2VMtZk7EH2Y/w3RFaiZcnnKw4gQHBYmygOvHy7pGsXpYeJncxfOah/S/Fg==
X-Received: by 2002:a50:b482:: with SMTP id w2mr7817144edd.41.1551523292114;
        Sat, 02 Mar 2019 02:41:32 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 36sm247711edz.58.2019.03.02.02.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 02:41:31 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] dt-bindings: display: rockchip: add document for rk3066 hdmi
Date:   Sat,  2 Mar 2019 11:41:16 +0100
Message-Id: <20190302104116.1535-5-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190302104116.1535-1-jbx6244@gmail.com>
References: <20190302104116.1535-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a binding that describes the HDMI controller for
rk3066.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/display/rockchip/rk3066-hdmi.txt      | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rk3066-hdmi.txt

diff --git a/Documentation/devicetree/bindings/display/rockchip/rk3066-hdmi.txt b/Documentation/devicetree/bindings/display/rockchip/rk3066-hdmi.txt
new file mode 100644
index 000000000..d1ad31bca
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/rockchip/rk3066-hdmi.txt
@@ -0,0 +1,72 @@
+Rockchip specific extensions for rk3066 HDMI
+============================================
+
+Required properties:
+- compatible:
+	"rockchip,rk3066-hdmi";
+- reg:
+	Physical base address and length of the controller's registers.
+- clocks, clock-names:
+	Phandle to HDMI controller clock, name should be "hclk".
+- interrupts:
+	HDMI interrupt number.
+- power-domains:
+	Phandle to the RK3066_PD_VIO power domain.
+- rockchip,grf:
+	This soc uses GRF regs to switch the HDMI TX input between vop0 and vop1.
+- ports:
+	Contains one port node with two endpoints, numbered 0 and 1,
+	connected respectively to vop0 and vop1.
+	Contains one port node with one endpoint
+	connected to a hdmi-connector node.
+- pinctrl-0, pinctrl-name:
+	Switch the iomux for the HPD/I2C pins to HDMI function.
+
+Example:
+	hdmi: hdmi@10116000 {
+		compatible = "rockchip,rk3066-hdmi";
+		reg = <0x10116000 0x2000>;
+		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HDMI>;
+		clock-names = "hclk";
+		power-domains = <&power RK3066_PD_VIO>;
+		rockchip,grf = <&grf>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmii2c_xfer>, <&hdmi_hpd>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			hdmi_in: port@0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				hdmi_in_vop0: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&vop0_out_hdmi>;
+				};
+				hdmi_in_vop1: endpoint@1 {
+					reg = <1>;
+					remote-endpoint = <&vop1_out_hdmi>;
+				};
+			};
+			hdmi_out: port@1 {
+				reg = <1>;
+				hdmi_out_con: endpoint {
+					remote-endpoint = <&hdmi_con_in>;
+				};
+			};
+		};
+	};
+
+&pinctrl {
+		hdmi {
+			hdmi_hpd: hdmi-hpd {
+				rockchip,pins = <0 RK_PA0 1 &pcfg_pull_default>;
+			};
+			hdmii2c_xfer: hdmii2c-xfer {
+				rockchip,pins = <0 RK_PA1 1 &pcfg_pull_none>,
+						<0 RK_PA2 1 &pcfg_pull_none>;
+			};
+		};
+};
-- 
2.11.0

