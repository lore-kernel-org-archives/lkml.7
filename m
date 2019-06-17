Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F08C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72722080A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVGF2NKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfFQWQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:16:51 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:38232 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfFQWQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:16:50 -0400
Received: by mail-pl1-f177.google.com with SMTP id f97so4765332plb.5;
        Mon, 17 Jun 2019 15:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RPNj7ShabpMoFkMl8hXYCQ7Om75Kbzpx9KYyRLhZGG8=;
        b=DVGF2NKBlE04Yj2Nxv1vDt5w2mixVbF3kAxDrAWcPNbQ4cLiOxa3MBkvZi0bCCPwqj
         BONS/lOiWgXPd235YxEUL8obNhUqsnY+A/zJNLonOwZ3IoYOksG1BV5KPMskiQrVaAmy
         oJ3lU7zDoBpTZp9nMJTODniB53HmQ1K5NytM0v01EvyWj3lzsO8SE8lV8cUovBeMENtt
         /8Gt/QKHtNzAvip20rhkF2XkfWVKjjaFyqp/CkcD3UKc6vgdJPzjXFkIRsQMHXr8ETil
         F+wVkhKl3LIPz/RBzRgutsj7Gr1xQNXDsd28GdJTzutysda0vyBLuVB45DT12QovtHDl
         QdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RPNj7ShabpMoFkMl8hXYCQ7Om75Kbzpx9KYyRLhZGG8=;
        b=CtSVHhGulo0u4br3M20KxoecmjnEQckXssViZ1/J4XNUQ5wtxLGVcyb7BaLkZP2lPq
         hH8UH+xx0PP263nMJxCrVTMllhh8EOcN2Sjw86jjnFRJ2rKf51cJrQYay+aDLYei08en
         x3yFoY3lwIQVn2jwR5TWXWy0QIAOOsNruMcFloyOpXGvO2zpTWRYsfzuLszuVdFYrs9v
         UzSQn/UOvLxQ71k8j/1kvOiTu6DgPIpVjxtfCom0ZyWGQC30dCZ8HTfXC9Y3nnHukdUk
         5NhqxVNISkMOFMdhXVI1bKALfcseaGy9XKuMQOIBOc2Mb4hrkwIY75WgsdYfztDq8W7x
         cH0w==
X-Gm-Message-State: APjAAAUona71BLX7BqlfILGEXzWxwBUdSul2Mj1B0GpRAAGz3NBQfw9E
        hAhY080b6qJawgBRdgXJiWIld4Q4xV4=
X-Google-Smtp-Source: APXvYqz/gKAwbHUzFU1vea3F3sPxdXUfv/oq0nZ509+gBNUW7dnCQuqHzgpJ7PKdgQ4iUCvqmi6Qgw==
X-Received: by 2002:a17:902:aa95:: with SMTP id d21mr3436765plr.185.1560809809699;
        Mon, 17 Jun 2019 15:16:49 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id f3sm254444pjo.31.2019.06.17.15.16.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 15:16:49 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     thierry.reding@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: tegra: Add INA3221 channel info for Jetson TX2
Date:   Mon, 17 Jun 2019 15:16:59 -0700
Message-Id: <20190617221659.25366-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are four INA3221 chips on the Jetson TX2 (p3310 + p2771).
And each INA3221 chip has three input channels to monitor power.

So this patch adds these 12 channels to the DT of Jetson TX2, by
following the DT binding of INA3221 and official documents from
https://developer.nvidia.com/embedded/downloads

tegra186-p3310:
https://developer.nvidia.com/embedded/dlc/jetson-tx2-series-modules-oem-product-design-guide

tegra186-p2771-0000:
http://developer.nvidia.com/embedded/dlc/jetson-tx1-tx2-developer-kit-carrier-board-spec-20180618

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 .../boot/dts/nvidia/tegra186-p2771-0000.dts   | 40 +++++++++++++++++++
 .../arm64/boot/dts/nvidia/tegra186-p3310.dtsi | 40 +++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
index ab6648c72ad5..9df4782c90f3 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -14,11 +14,51 @@
 		power-monitor@42 {
 			compatible = "ti,ina3221";
 			reg = <0x42>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			channel@0 {
+				reg = <0x0>;
+				label = "VDD_MUX";
+				shunt-resistor-micro-ohms = <20000>;
+			};
+
+			channel@1 {
+				reg = <0x1>;
+				label = "VDD_5V0_IO_SYS";
+				shunt-resistor-micro-ohms = <5000>;
+			};
+
+			channel@2 {
+				reg = <0x2>;
+				label = "VDD_3V3_SYS";
+				shunt-resistor-micro-ohms = <10000>;
+			};
 		};
 
 		power-monitor@43 {
 			compatible = "ti,ina3221";
 			reg = <0x43>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			channel@0 {
+				reg = <0x0>;
+				label = "VDD_3V3_IO_SLP";
+				shunt-resistor-micro-ohms = <10000>;
+			};
+
+			channel@1 {
+				reg = <0x1>;
+				label = "VDD_1V8_IO";
+				shunt-resistor-micro-ohms = <10000>;
+			};
+
+			channel@2 {
+				reg = <0x2>;
+				label = "VDD_M2_IN";
+				shunt-resistor-micro-ohms = <10000>;
+			};
 		};
 
 		exp1: gpio@74 {
diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
index 4bbee83d9943..5e18acf5cfad 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
@@ -67,11 +67,51 @@
 		power-monitor@40 {
 			compatible = "ti,ina3221";
 			reg = <0x40>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			channel@0 {
+				reg = <0x0>;
+				label = "VDD_SYS_GPU";
+				shunt-resistor-micro-ohms = <10000>;
+			};
+
+			channel@1 {
+				reg = <0x1>;
+				label = "VDD_SYS_SOC";
+				shunt-resistor-micro-ohms = <10000>;
+			};
+
+			channel@2 {
+				reg = <0x2>;
+				label = "VDD_3V8_WIFI";
+				shunt-resistor-micro-ohms = <10000>;
+			};
 		};
 
 		power-monitor@41 {
 			compatible = "ti,ina3221";
 			reg = <0x41>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			channel@0 {
+				reg = <0x0>;
+				label = "VDD_IN";
+				shunt-resistor-micro-ohms = <5000>;
+			};
+
+			channel@1 {
+				reg = <0x1>;
+				label = "VDD_SYS_CPU";
+				shunt-resistor-micro-ohms = <10000>;
+			};
+
+			channel@2 {
+				reg = <0x2>;
+				label = "VDD_5V0_DDR";
+				shunt-resistor-micro-ohms = <10000>;
+			};
 		};
 	};
 
-- 
2.17.1

