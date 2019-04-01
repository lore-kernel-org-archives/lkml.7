Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7F6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B255820883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXvvL2AX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfDAKlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:41:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50540 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfDAKlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:41:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id z11so9916577wmi.0;
        Mon, 01 Apr 2019 03:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qtOljbgD60w4rDQWGk6iiVe3bNFL+0B2Nck7DSRFzv8=;
        b=KXvvL2AXca1Saofs84AZ9Lw326SyoDUvLhdLtXcQpT64chKjLYRflEnwt8uishMFag
         bf8fY0rWij4f+3OnB+hX2nWc9Tr29sprhEZqcHhILpDgsnbwrG5UowLNyKhRolQUq3b8
         oKBGYO5JULYD862+IkSCBfH40P09QFZQ+h6XFIBXI7YpBenTCYYbHDw5xSgwKVP+ZKC7
         owZnXRAvAqPbuubCtnGidYzdUWP2nIJCMQD26EzcwQZEp+vUR8z0Ci75HYLSkh3y8rJF
         sokkGzP5fCslrKL8aI1Nh4l15sxyJ/cQ21AmlXsNUm8EbN/tFtNx12WZWywa6RkGNTWQ
         WT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qtOljbgD60w4rDQWGk6iiVe3bNFL+0B2Nck7DSRFzv8=;
        b=tQJrGmPYvnOKcCxbVRBRhVnPWPpkIcJSiXvFKCX3CFeIdRX6x/x8PWNSXsL6yp9qMZ
         GWhIkUNkSpBJB+pYMCRLLePkm/CWYJ8huUIYe/6JVJ8avvlriQ6Qk97Hrs6qX3uY+Whm
         I+ZpZiaUbudIK0lyH6ZFDmXcNyryN5k3gNaRbdMzL/R6GOXJxilnr2e2Or2nVnPJ9QIE
         kSeuP1r88e0/p7AWScNkXOZWg4JD743VFzvjPJMBjF5/ot06AeMxEVDVzLA6bxTsZFJr
         PZK2kBQXOiFRKHMJgj1Ab5RyHSCLBqa6GpzXQcxr+fWvbo7b7lFiGcQWzrtBX6ZbocB8
         KmmA==
X-Gm-Message-State: APjAAAX3u7GLdd3DX4K25JTXxkvi6pXblCLNPEilt6cC6H7tzw0H/okw
        +gATlu/2Z/nTpBVBr9q8WL0=
X-Google-Smtp-Source: APXvYqzRSbhYAmI1LQJBCIefp68E1uT0FZzGncTjvXpH/sALM1896xUwKq9jua8K7dmv52tzY6kSFQ==
X-Received: by 2002:a1c:e70b:: with SMTP id e11mr11317019wmh.17.1554115259338;
        Mon, 01 Apr 2019 03:40:59 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id l12sm11264446wrt.31.2019.04.01.03.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:40:58 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] arm64: tegra: Enable XUSB on P2771
Date:   Mon,  1 Apr 2019 12:40:49 +0200
Message-Id: <20190401104050.31355-6-thierry.reding@gmail.com>
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

Enable the relevant pads for XUSB support on P2771-0000 and hook up the
USB supply voltage regulators to the ports.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../boot/dts/nvidia/tegra186-p2771-0000.dts   | 115 ++++++++++++++++++
 .../arm64/boot/dts/nvidia/tegra186-p3310.dtsi |  19 ++-
 2 files changed, 130 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
index 31457f32e4d0..75ee6cf1e1b4 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -58,6 +58,93 @@
 		status = "okay";
 	};
 
+	padctl@3520000 {
+		status = "okay";
+
+		avdd-pll-erefeut-supply = <&vdd_1v8_pll>;
+		avdd-usb-supply = <&vdd_3v3_sys>;
+		dvdd-pex-supply = <&vdd_pex>;
+		dvdd-pex-pll-supply = <&vdd_pex>;
+		hvdd-pex-supply = <&vdd_1v8>;
+		hvdd-pex-pll-supply = <&vdd_1v8>;
+		vclamp-usb-supply = <&vdd_1v8>;
+		vddio-hsic-supply = <&gnd>;
+
+		pads {
+			usb2 {
+				status = "okay";
+
+				lanes {
+					usb2-0 {
+						nvidia,function = "xusb";
+						status = "okay";
+					};
+
+					usb2-1 {
+						nvidia,function = "xusb";
+						status = "okay";
+					};
+
+					usb2-2 {
+						nvidia,function = "xusb";
+						status = "okay";
+					};
+				};
+			};
+
+			usb3 {
+				status = "okay";
+
+				lanes {
+					usb3-0 {
+						nvidia,function = "xusb";
+						status = "okay";
+					};
+
+					usb3-1 {
+						nvidia,function = "xusb";
+						status = "okay";
+					};
+
+					usb3-2 {
+						nvidia,function = "xusb";
+						status = "okay";
+					};
+				};
+			};
+		};
+
+		ports {
+			usb2-0 {
+				status = "okay";
+				mode = "otg";
+
+				vbus-supply = <&vdd_usb0>;
+			};
+
+			usb2-1 {
+				status = "okay";
+				mode = "host";
+
+				vbus-supply = <&vdd_usb1>;
+			};
+
+			usb3-0 {
+				nvidia,usb2-companion = <1>;
+				status = "okay";
+			};
+		};
+	};
+
+	usb@3530000 {
+		status = "okay";
+
+		phys = <&{/padctl@3520000/pads/usb2/lanes/usb2-0}>,
+		       <&{/padctl@3520000/pads/usb2/lanes/usb2-1}>,
+		       <&{/padctl@3520000/pads/usb3/lanes/usb3-0}>;
+		phy-names = "usb2-0", "usb2-1", "usb3-0";
+	};
+
 	pcie@10003000 {
 		status = "okay";
 
@@ -182,5 +269,33 @@
 
 			vin-supply = <&vdd_5v0_sys>;
 		};
+
+		vdd_usb0: regulator@102 {
+			compatible = "regulator-fixed";
+			reg = <102>;
+
+			regulator-name = "VDD_USB0";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+
+			gpio = <&gpio TEGRA_MAIN_GPIO(L, 4) GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+
+			vin-supply = <&vdd_5v0_sys>;
+		};
+
+		vdd_usb1: regulator@103 {
+			compatible = "regulator-fixed";
+			reg = <103>;
+
+			regulator-name = "VDD_USB1";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+
+			gpio = <&gpio TEGRA_MAIN_GPIO(L, 5) GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+
+			vin-supply = <&vdd_5v0_sys>;
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
index 89a2da46efae..952062f0b9a9 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
@@ -291,7 +291,7 @@
 						regulator-boot-on;
 					};
 
-					ldo0 {
+					vdd_1v8_pll: ldo0 {
 						regulator-name = "VDD_1V8_AP_PLL";
 						regulator-min-microvolt = <1800000>;
 						regulator-max-microvolt = <1800000>;
@@ -360,10 +360,21 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		vdd_5v0_sys: regulator@0 {
+		gnd: regulator@0 {
 			compatible = "regulator-fixed";
 			reg = <0>;
 
+			regulator-name = "GND";
+			regulator-min-microvolt = <0>;
+			regulator-max-microvolt = <0>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		vdd_5v0_sys: regulator@1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+
 			regulator-name = "VDD_5V0_SYS";
 			regulator-min-microvolt = <5000000>;
 			regulator-max-microvolt = <5000000>;
@@ -371,9 +382,9 @@
 			regulator-boot-on;
 		};
 
-		vdd_1v8_ap: regulator@1 {
+		vdd_1v8_ap: regulator@2 {
 			compatible = "regulator-fixed";
-			reg = <1>;
+			reg = <2>;
 
 			regulator-name = "VDD_1V8_AP";
 			regulator-min-microvolt = <1800000>;
-- 
2.21.0

