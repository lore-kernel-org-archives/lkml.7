Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB39AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B88620883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hStaL1nx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfDAKlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:41:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33504 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfDAKlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:41:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id z6so15195045wmi.0;
        Mon, 01 Apr 2019 03:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=81AiQ9vJV3H3L7/Zx78hl4rSbFofhbhEAQ46xWedx2U=;
        b=hStaL1nxAqvElLFCIKUNqWRF6dCD5MKgfZrbim9MA06whbe+UFmsd4UNZ3YtcKm1HT
         mK3Z/v5/ThJX6cBUamcHQF6aBfXo7+06ueQ0wHl8dWFB1XEbSP3FQldZNWDX3F71zK2J
         2RKssVtHLDoluDk744pLUt3ssQxw+AVOT9x0EJrnsiigVRsCFmHrlukecmfVzL0KEHYW
         m4aqF3PONM069zBgRgcDpx9shPNZvaAu3j9Tn593rZVE8V0zWH/qSF9arTObi8MBljsN
         6a5ht3wCNB+AqXeUJ5VxS7qoaO0gTA/ErZWP7JHWqt33jCOy+HzgJKgnL2gEmRpztCxf
         LgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=81AiQ9vJV3H3L7/Zx78hl4rSbFofhbhEAQ46xWedx2U=;
        b=lFluKVZEqUVX1EXalV5GQvYj6qS0Xs/agVOtItsYdat8b4xxJWeR1ApG3oWYLvaaC9
         V/8UcJRmmYd3nQk0s5uClSYHbs0y3EUhOsBta+3Nqj/ZKXVtIX1JbNPuPXs0X4iAQB7p
         gkAvRxGMLBWKHp/LS2BoYLbKLsyoXeOnr8V30Z4CY2hw5gSge65r6b+IH9wEc6hvzJHg
         bOA1vvM0NtLDAusR/b6jPYK9pGOJi9oryzTzG4Tvm4BibediO1FpYdPFi/rqnYE6I/DE
         tS+5d6T1WyipJjA4aTJulyCYeOm6GZfi6y1ROHBrNw89zHZ61T3a9M+V8b2LlmCWWako
         y/5g==
X-Gm-Message-State: APjAAAUL3KjFSEkJKe7mRs5G1Via8LX10STzEcYJp3M4fBJXRdNh1xM/
        yq4PTHirE6oU7kVXsC3dR3w=
X-Google-Smtp-Source: APXvYqyNBRz15CS6+CeqQJqQSNgcssaPVLehw8ubiEStZ70XZpIaQZBqLv8xP7R852Q/nY8tuGJDHw==
X-Received: by 2002:a7b:cc91:: with SMTP id p17mr12023330wma.38.1554115257864;
        Mon, 01 Apr 2019 03:40:57 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id a126sm10079160wmh.4.2019.04.01.03.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:40:57 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v2 4/6] arm64: tegra: Add XUSB and pad controller on Tegra186
Date:   Mon,  1 Apr 2019 12:40:48 +0200
Message-Id: <20190401104050.31355-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401104050.31355-1-thierry.reding@gmail.com>
References: <20190401104050.31355-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Adds the XUSB pad and XUSB controllers on Tegra186.

Reviewed-by: JC Kuo <jckuo@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 135 +++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 97aeb946ed5e..c444b6fa304c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -340,6 +340,141 @@
 		status = "disabled";
 	};
 
+	padctl: padctl@3520000 {
+		compatible = "nvidia,tegra186-xusb-padctl";
+		reg = <0x0 0x03520000 0x0 0x1000>,
+		      <0x0 0x03540000 0x0 0x1000>;
+		reg-names = "padctl", "ao";
+
+		resets = <&bpmp TEGRA186_RESET_XUSB_PADCTL>;
+		reset-names = "padctl";
+
+		status = "disabled";
+
+		pads {
+			usb2 {
+				clocks = <&bpmp TEGRA186_CLK_USB2_TRK>;
+				clock-names = "trk";
+				status = "disabled";
+
+				lanes {
+					usb2-0 {
+						status = "disabled";
+						#phy-cells = <0>;
+					};
+
+					usb2-1 {
+						status = "disabled";
+						#phy-cells = <0>;
+					};
+
+					usb2-2 {
+						status = "disabled";
+						#phy-cells = <0>;
+					};
+				};
+			};
+
+			hsic {
+				clocks = <&bpmp TEGRA186_CLK_HSIC_TRK>;
+				clock-names = "trk";
+				status = "disabled";
+
+				lanes {
+					hsic-0 {
+						status = "disabled";
+						#phy-cells = <0>;
+					};
+				};
+			};
+
+			usb3 {
+				status = "disabled";
+
+				lanes {
+					usb3-0 {
+						status = "disabled";
+						#phy-cells = <0>;
+					};
+
+					usb3-1 {
+						status = "disabled";
+						#phy-cells = <0>;
+					};
+
+					usb3-2 {
+						status = "disabled";
+						#phy-cells = <0>;
+					};
+				};
+			};
+		};
+
+		ports {
+			usb2-0 {
+				status = "disabled";
+			};
+
+			usb2-1 {
+				status = "disabled";
+			};
+
+			usb2-2 {
+				status = "disabled";
+			};
+
+			hsic-0 {
+				status = "disabled";
+			};
+
+			usb3-0 {
+				status = "disabled";
+			};
+
+			usb3-1 {
+				status = "disabled";
+			};
+
+			usb3-2 {
+				status = "disabled";
+			};
+		};
+	};
+
+	usb@3530000 {
+		compatible = "nvidia,tegra186-xusb";
+		reg = <0x0 0x03530000 0x0 0x8000>,
+		      <0x0 0x03538000 0x0 0x1000>;
+		reg-names = "hcd", "fpci";
+
+		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+
+		clocks = <&bpmp TEGRA186_CLK_XUSB_HOST>,
+			 <&bpmp TEGRA186_CLK_XUSB_FALCON>,
+			 <&bpmp TEGRA186_CLK_XUSB_SS>,
+			 <&bpmp TEGRA186_CLK_XUSB_CORE_SS>,
+			 <&bpmp TEGRA186_CLK_CLK_M>,
+			 <&bpmp TEGRA186_CLK_XUSB_FS>,
+			 <&bpmp TEGRA186_CLK_PLLU>,
+			 <&bpmp TEGRA186_CLK_CLK_M>,
+			 <&bpmp TEGRA186_CLK_PLLE>;
+		clock-names = "xusb_host", "xusb_falcon_src", "xusb_ss",
+			      "xusb_ss_src", "xusb_hs_src", "xusb_fs_src",
+			      "pll_u_480m", "clk_m", "pll_e";
+
+		power-domains = <&bpmp TEGRA186_POWER_DOMAIN_XUSBC>,
+				<&bpmp TEGRA186_POWER_DOMAIN_XUSBA>;
+		power-domain-names = "xusb_host", "xusb_ss";
+		nvidia,xusb-padctl = <&padctl>;
+
+		status = "disabled";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
 	fuse@3820000 {
 		compatible = "nvidia,tegra186-efuse";
 		reg = <0x0 0x03820000 0x0 0x10000>;
-- 
2.21.0

