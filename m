Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795D2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423D1218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5/8Bqk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfCUAPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:15:01 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40511 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbfCUAO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 20:14:58 -0400
Received: by mail-ed1-f65.google.com with SMTP id h22so3565216edw.7;
        Wed, 20 Mar 2019 17:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WgnfejoohWcdh8LAG9lSSLEUXDC2hzIwdSjwLa5g5iI=;
        b=X5/8Bqk0R2CuS7lKySOQguWH2ZW9uuQQNvxSmQ2s+TwtTmosA/ynjQICjSySkFSg+T
         aBKlaCe0zotysRKOtmNZgUpSHcSg+EKVRGktMAAxcePl0ZisI41djsChJRygzi28Flmt
         hCYfUtMVqmkGN6qvlOBZnziwR381BH53hcsRP1BNhQ8hTzF8RD2uK5bqfHXVCvYOtlf6
         B8YZJj7XNjnaPc6mxSkYgYDgZe4xvfQOap+b5t6yJExncrInWBUXBLw+HyHZvZM5kEA5
         dm0nRtCptUcWk/3an/hcSXCRWlWenoweNaSpGlC4L9BRPrRS0ZwpE9PMsBjBxrBMMlXb
         VWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WgnfejoohWcdh8LAG9lSSLEUXDC2hzIwdSjwLa5g5iI=;
        b=ASUhTLvx5xyMEmWryj+FDnoPsEezmlZB3T+BYqRJfvgzBvd9uNDQESsQgrpmCXQgtd
         FiXfOtnYDV5MU5g/jGUqCVEUkYhYgXTF+cHIyaH6nq6N+Leu+uq3zT1u0WS5XIni+UYH
         E005gcMvH6HjsxoTVmrFBB6N4jAyn1YNzpitnjFvZt8StPQcZAJKVcUVOQMcXej3VcpJ
         QV8gpDfBTkNC0fcIXlpmPHaT4ZrUFetowz5Db9x1r7YwSjbmo0Rd37AUnPIA8h1yxZjv
         k46DYedmTe3wLxCtAL9v0TCUHXnUAcVf7Zy5pJgFa9SHn+G9xt5oqM6JlY/GSqJH/adv
         FTzQ==
X-Gm-Message-State: APjAAAVzJbnugLWG0XiXx3ANqMj8b71QmQrDcP4xgm0ZSk9bFjtjiO1D
        4bN4P3JITYgXcfErWtmO8I4=
X-Google-Smtp-Source: APXvYqwcFQYlDPfG8eljpron08J42gxy7am2u5pvLHFSAyHWMSbnrvJY2Yo6GPjwJTM8SEiaX5u1xw==
X-Received: by 2002:a17:906:4bc8:: with SMTP id x8mr517764ejv.114.1553127296772;
        Wed, 20 Mar 2019 17:14:56 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id j34sm1107660edb.30.2019.03.20.17.14.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 17:14:56 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/5] ARM: dts: rockchip: add rk3066 hdmi nodes
Date:   Thu, 21 Mar 2019 01:14:37 +0100
Message-Id: <20190321001440.31057-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190321001440.31057-1-jbx6244@gmail.com>
References: <20190321001440.31057-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Yang <zhengyang@rock-chips.com>

This patch adds the hdmi nodes to rk3066.

Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 653127a37..9c43b985a 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -80,6 +80,10 @@
 		vop0_out: port {
 			#address-cells = <1>;
 			#size-cells = <0>;
+			vop0_out_hdmi: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&hdmi_in_vop0>;
+			};
 		};
 	};
 
@@ -101,6 +105,44 @@
 		vop1_out: port {
 			#address-cells = <1>;
 			#size-cells = <0>;
+			vop1_out_hdmi: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&hdmi_in_vop1>;
+			};
+		};
+	};
+
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
+		status = "disabled";
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
+			};
 		};
 	};
 
@@ -415,6 +457,16 @@
 			};
 		};
 
+		hdmi {
+			hdmi_hpd: hdmi-hpd {
+				rockchip,pins = <0 RK_PA0 1 &pcfg_pull_default>;
+			};
+			hdmii2c_xfer: hdmii2c-xfer {
+				rockchip,pins = <0 RK_PA1 1 &pcfg_pull_none>,
+						<0 RK_PA2 1 &pcfg_pull_none>;
+			};
+		};
+
 		pwm0 {
 			pwm0_out: pwm0-out {
 				rockchip,pins = <RK_GPIO0 3 RK_FUNC_1 &pcfg_pull_none>;
-- 
2.11.0

