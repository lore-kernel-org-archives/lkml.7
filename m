Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE9FC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F01D20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrIv6U2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfCFWll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:41:41 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38638 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfCFWla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:41:30 -0500
Received: by mail-ed1-f67.google.com with SMTP id h58so11803487edb.5;
        Wed, 06 Mar 2019 14:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lYw/rfpnmdx5PH54T9Dya+xirh/mbWltaop30jtIhxc=;
        b=BrIv6U2U3tq4P/QFhr3m+VGM/e62k41EH3dT5i520PqOf01CtztW+EgmZjnWNvag8q
         a8qSLoxDOcTV+ujRW1/FY3EPGiz7ZQN6QInVgf6IOLkvwXs8SIFgzMlYLULkkOB9tkdv
         FhdpFIQRhqdd824LhxkZWl1buIUcNpZt7QQoCNQbkUY8mnR2e0jb+UGYMTp5A7yXw5dX
         F1Fg+Uq/WMwahhpLdOE15BaBi+tXWJbXoHknYnjh/xLw+YAvsIc1hAb5kUBLBzgABflt
         KR3FYL47t7bN0irto1EreuC0HL4VRRrVwWdcd8YnqcQ3Bg8XDz+lycUURd5hkkWDKlcm
         4XwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lYw/rfpnmdx5PH54T9Dya+xirh/mbWltaop30jtIhxc=;
        b=qrV9z4w8ErresiqXSYLr+GISc8zhMLGSur3Pu0KS2W3cVL/VbXVoiNteWYs9a23DjY
         pPMpyqSrgIqjyUjvntwYMKNwYVSqJdcr8l3fATrhS98LCuAJ/SrcVZWx0y13CKQzL4va
         +qKUd0J1dKIgb8/N064PHnDSV23gZMnVI7YoV7Hf9hL6fCs09hBZrtIyndFczwydxAsP
         YaJmsVWpIAW0e6ENM6Dg4T7tZKgrk/F2qlX1nUh7EoE94RL5W6cEBlcJMGuZ6sxuKw+V
         LWCVjJ0aERF+C3apo9eMgGJYf1+9w9kq1qE0tLz2rdKcMMnFq592EdkXH9ay8YQqSfyJ
         kkrw==
X-Gm-Message-State: APjAAAUsw/NBYPNlGraNyagheE/sy3qwSh8pUDqG4amyNQyNdFiJBv4I
        5tSB5j/BW3uVKwyd9ypXny8=
X-Google-Smtp-Source: APXvYqxLvSYhPEHTA1aLKT+CtV1kNLINP0BIHrCRXxvBT24Sfu9VPvwxXvQvOzq4Fazi9pQl7vc10g==
X-Received: by 2002:a17:906:49c3:: with SMTP id w3mr5600623ejv.148.1551912088257;
        Wed, 06 Mar 2019 14:41:28 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 36sm801356edz.58.2019.03.06.14.41.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 14:41:27 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] dt-bindings: display: rockchip: add document for rk3066 hdmi
Date:   Wed,  6 Mar 2019 23:41:13 +0100
Message-Id: <20190306224113.24853-5-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190306224113.24853-1-jbx6244@gmail.com>
References: <20190306224113.24853-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a binding that describes the HDMI controller for
rk3066.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
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

