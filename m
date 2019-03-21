Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAAEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E9A218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1qba68L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfCUAPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:15:21 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34274 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfCUAPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 20:15:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id a16so3578142edn.1;
        Wed, 20 Mar 2019 17:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dTKwYbQIva6CKsd1LUqtMQIO+qEhpGYGHu2q1dPaq70=;
        b=b1qba68LPQqge4WaX5gk+DHLFh3LQ1+Mdls/HgkiGjcz3gS80mjSoWz+TblknGRRuk
         HxsV74wMxRBp86o6U9ij4ARimqzBfF45UwfM285czn1X7fSmkGKIM+4y+lGCVtWHMjgY
         5IFzMhw2Q2vgwDn4h7ZhSxu7pxfqKRSYk/hlWDrh2uIqDdqbjVr/70KANjL3F9rsWPWN
         iStiv95aFgwB8hZ0L1gmv+UKq/9g92BYI1HLrQUl2tm+Zvpm69NHciAbNTuVk480pQT/
         Y4bGlX+j2duX021Q1Dw5HUmPCrK/i+8y8QO96ZRF01cQRtthYZLrZ5rCTmgPoJ9chi27
         J3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dTKwYbQIva6CKsd1LUqtMQIO+qEhpGYGHu2q1dPaq70=;
        b=Wedo5RYH9z/KKhqEm890tw2IRLmqvE7tbHKccFjZMW7FYu8MU+WWHwk6Xtk6xkcEFT
         VHdJ+8m7qPA7pi8AZWOWWXhPuGlS8VjHPN6am6IwYPCuETgKRzsoA11GmblUMGSIYYOc
         TrE2KIy6W5iEzOFN9qHtq7cL+vnKFgQy3i8GNcsL+rWSh8zE8qX+b9x6T9l3R52LieJ/
         6ynHMuTQFSqLsw9B40fAjGQ0nTedolf/kTeyNXjB9vhr7SNUkTci0wh20ji56jcDEirr
         OGrmPHdW0gWm1o75Zvou+vmzyZw06JETvf6s/5k7BbusuJrEqlTgv8QupR+RGYiDhbSb
         nHwA==
X-Gm-Message-State: APjAAAX/7g5rGMw71+pgUXHqy2M+piJZqTc3xoJ+djO9nKDr//duEuXs
        gcvooN33rf5qG8VIInshRo4=
X-Google-Smtp-Source: APXvYqyWPxWkyTSS6YFduEwaJMphTu0vutcRhPd/A4N9EvuqVA7Pz5Z5nA68aYy8aDIW0/h9slsUbw==
X-Received: by 2002:a17:906:2f15:: with SMTP id v21mr511410eji.157.1553127298436;
        Wed, 20 Mar 2019 17:14:58 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id j34sm1107660edb.30.2019.03.20.17.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 17:14:57 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/5] dt-bindings: display: rockchip: add document for rk3066 hdmi
Date:   Thu, 21 Mar 2019 01:14:39 +0100
Message-Id: <20190321001440.31057-5-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190321001440.31057-1-jbx6244@gmail.com>
References: <20190321001440.31057-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a binding that describes the HDMI controller for
rk3066.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../display/rockchip/rockchip,rk3066-hdmi.txt      | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.txt

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.txt
new file mode 100644
index 000000000..d1ad31bca
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.txt
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

