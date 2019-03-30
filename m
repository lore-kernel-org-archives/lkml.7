Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5752C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8519B218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNaChbFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbfC3J5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 05:57:00 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39370 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730646AbfC3J4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 05:56:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id p20so4076055eds.6;
        Sat, 30 Mar 2019 02:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dTKwYbQIva6CKsd1LUqtMQIO+qEhpGYGHu2q1dPaq70=;
        b=dNaChbFTEko2b/rb5zceB9+iH3wKrG9DBRY/VSOlAFL4GhoqdYmWX+umGG7jv1n+Jb
         dF3FeIPKpZXhgP9XxKGtl7CobQxhDaWbR9c3BqK+EyOQ8n3WYFAE2Jzc6X+bd2enYw1t
         XFPOBsUlln603b57/qoJNcElFiedaLPxoYs62XTidwf+FMWi4lHZzVBHyhtBv7VAc9zD
         PYfpCyqwedAEdzZc4pul7lL3qANitHli2AxRVnSAsXmAC/L30Q5pszWOMA9kedrTNHH/
         HXAtgkiMi4L7NUeNlbGwH5Qlhg0fcuQDDCjT4IV6DA7sN5dnRl8X226GTRXE51s3+xu5
         rghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dTKwYbQIva6CKsd1LUqtMQIO+qEhpGYGHu2q1dPaq70=;
        b=hAP00yMei+g8+wSZWFmuOkh0fovrLKilaiwVA0/bqbfg6i1kHLu+XvJVv19/1vynJY
         CREVn2SkO2qPyOjio8aP/F73uKEXf/G8NfIG2dF9XjWdH1WOUW/xaH9VisFvdQl2fN+9
         MN/oxnNA8UIREFIt8ETa1H9s6xUMEZArVKeK2pVtdxqI6dSjIxWSfi6QamxPvLu20ApG
         y2NWW0bg/yhbFVPDjFzPz3516GTU003Up05PYUv7HOwZwFDO1aoi+oW9tV+tpi0VruWP
         D6PzNB0RRShrZcteO1o6p2kyveNe8w3L9O02HW88ZHRLUJbR3ADXn4QlW1XmttOrFwLO
         Zh/A==
X-Gm-Message-State: APjAAAXgLo7fXq7MiiZCn+dqWySF0IcWSRjZFmXbWExRfgIOAJ/VhytL
        +2tO+DLDk2qQpdIu8LBQ3JBF+LUS
X-Google-Smtp-Source: APXvYqzswvMjdZjFFPPqq608dPRiAsVfU/BZ4MNDtnWjGQRDA6YBzGektCKkFiU3o/pv5IAKYbp2tg==
X-Received: by 2002:a17:906:c7c2:: with SMTP id dc2mr28733856ejb.182.1553939813418;
        Sat, 30 Mar 2019 02:56:53 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b34sm1087921edd.24.2019.03.30.02.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 02:56:53 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/4] dt-bindings: display: rockchip: add document for rk3066 hdmi
Date:   Sat, 30 Mar 2019 10:56:39 +0100
Message-Id: <20190330095639.14626-5-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190330095639.14626-1-jbx6244@gmail.com>
References: <20190330095639.14626-1-jbx6244@gmail.com>
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

