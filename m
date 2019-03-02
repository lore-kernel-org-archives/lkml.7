Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADF0C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 10:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29EB220836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 10:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tYrSBWMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfCBKld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 05:41:33 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40587 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfCBKlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 05:41:32 -0500
Received: by mail-ed1-f65.google.com with SMTP id 10so427992eds.7;
        Sat, 02 Mar 2019 02:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WgnfejoohWcdh8LAG9lSSLEUXDC2hzIwdSjwLa5g5iI=;
        b=tYrSBWMv9+Fa+PnaHaPKYmQixFWT8FiTyvkmA7d9FH1G3+LBNsIPH6Q9LNEyebLWim
         PjZWG74lnlniN8TCzxtALi6cG82TBs+oAVa3CJGGsCZKOJi8auc01EXoTUGTCmPLStNz
         aC/CtkCzORFLVa3OEcAIOgJlaX9cotlPDl6DlhMI4/ipNGGMEsjWeiZnRj5ASqvfqHYV
         FcTVhzXWRjTAaCq4lPDxKvDgwj3HGNQCihpF754gRwdASxNX0DowpCPTvX2UM+oRM018
         k+Ho0m4goQIEO6EnoW6msx58hrC0gD7u5Qg1osnHGcPO/gKJK4IQJ3912nbmA8MGQX0I
         8qEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WgnfejoohWcdh8LAG9lSSLEUXDC2hzIwdSjwLa5g5iI=;
        b=L55XaPc3+rHgQnO82pFUcXQXHEVFHu4rq7LoUOzA0x3XuS8IaWHMm3j6hqSE8PCvtH
         aYrAdthAYqR2t/eNcXQT3B19JGtom6675EkCgsg4f+o/HzovvA3Nu9xOOOumpZ+2Aj0Q
         HN9KPbAflhE5NDa1+7Q6qHIotF6xM0+dIxu19OKxiSVHSZIXgnNKI56s6/k74QbwCnon
         PLnImzf5GN8SMtilRlg4hAb2v7LjmYqupHzg3EizHy49YzNQ2maQVcDCnBYNeOIrWh98
         QWS4NQ/wGUjiJ6rlj4HG+f4fSq6ezw3pY25KZj0KiOFpN2uGieSUKAKW/fFu1TWY6jfJ
         6Y1Q==
X-Gm-Message-State: APjAAAUsfFAzhFAfZtBKyu6sa9abBW3cU+qEy1OhFgvTDPVsby9CwUuK
        GxgFVmszMABt2yICKaBMYaU=
X-Google-Smtp-Source: APXvYqxfvN2XVMA+JGudiRVoh5xytUnclWTTtqkF9ZxCsZctCF93bFplk7MGU1735mqMdOqyY8tdmQ==
X-Received: by 2002:a50:e8cc:: with SMTP id l12mr7417882edn.125.1551523290507;
        Sat, 02 Mar 2019 02:41:30 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 36sm247711edz.58.2019.03.02.02.41.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 02:41:30 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] ARM: dts: rockchip: add rk3066 hdmi nodes
Date:   Sat,  2 Mar 2019 11:41:14 +0100
Message-Id: <20190302104116.1535-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190302104116.1535-1-jbx6244@gmail.com>
References: <20190302104116.1535-1-jbx6244@gmail.com>
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

