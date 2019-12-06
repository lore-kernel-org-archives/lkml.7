Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8EDC2D0BF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 02:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FC42077B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 02:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Q9/De5yx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfLFCtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 21:49:02 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15934 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfLFCtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 21:49:02 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de9c18c0000>; Thu, 05 Dec 2019 18:48:44 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 05 Dec 2019 18:49:00 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 05 Dec 2019 18:49:00 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Dec
 2019 02:49:00 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Dec
 2019 02:49:00 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 6 Dec 2019 02:48:59 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.163.171]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5de9c19a0000>; Thu, 05 Dec 2019 18:48:59 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <tglx@linutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <allison@lohutok.net>, <pdeschrijver@nvidia.com>,
        <pgaikwad@nvidia.com>, <mturquette@baylibre.com>,
        <horms+renesas@verge.net.au>, <Jisheng.Zhang@synaptics.com>,
        <krzk@kernel.org>, <arnd@arndb.de>, <spujar@nvidia.com>,
        <josephl@nvidia.com>, <vidyas@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <alexios.zavras@intel.com>, <alsa-devel@alsa-project.org>
Subject: [PATCH v3 01/15] dt-bindings: soc: tegra-pmc: Add Tegra PMC clock bindings
Date:   Thu, 5 Dec 2019 18:48:41 -0800
Message-ID: <1575600535-26877-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575600524; bh=x1pr6sgyfaOabztcrcNVrPuJufF6ICFod7I86nzimHc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Q9/De5yxZu/cBzNKRe2HJIG6KdEWZBXHGBGsC1NHObJgz2P/ReowrMY0p4Qw7UjZZ
         sf/0+1967CowJk7EkaWPiHQ9McKP62PONz/9oZe9PUlK3I/OSM3ENmEDKcrfC/OKXK
         CJ5tje0n/cVvF/mSsZ5Me1OBVt4Y4I5fGpWkVgRhwP7ODnmkVBUoSBAdSwez5ra2wk
         vdJmrUYiMpKH2HPx/os92EcCzKkuUXGL7m64l9P9eph1P68LhgviWObxuOzaLW+ITt
         nNeqa+e34BlqKJMIHqTCQbWzzHfSrnxmojEdl9bsYC4As4PGMD8JwIhOO1by9J3YdI
         7JeyVB7cAOigg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra PMC has clk_out_1, clk_out_2, clk_out_3 clocks and each of
these clocks has mux and a gate as a part of PMC controller.

This patch documents PMC clock bindings and adds a header defining
Tegra PMC clock ids.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 45 +++++++++++++++++++++-
 include/dt-bindings/soc/tegra-pmc.h                | 18 +++++++++
 2 files changed, 62 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/soc/tegra-pmc.h

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
index cb12f33a247f..cd895423ccfd 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
@@ -21,6 +21,10 @@ Required properties:
 - clock-names : Must include the following entries:
   "pclk" (The Tegra clock of that name),
   "clk32k_in" (The 32KHz clock input to Tegra).
+- #clock-cells : Should be 1 for Tegra30 and higher.
+  In clock consumers, this cell represents the PMC clock ID.
+  The assignments may be found in header file
+  <dt-bindings/soc/tegra-pmc.h>.
 
 Optional properties:
 - nvidia,invert-interrupt : If present, inverts the PMU interrupt signal.
@@ -80,11 +84,12 @@ Optional nodes:
 Example:
 
 / SoC dts including file
-pmc@7000f400 {
+pmc: pmc@7000f400 {
 	compatible = "nvidia,tegra20-pmc";
 	reg = <0x7000e400 0x400>;
 	clocks = <&tegra_car 110>, <&clk32k_in>;
 	clock-names = "pclk", "clk32k_in";
+	#clock-cells = <1>;
 	nvidia,invert-interrupt;
 	nvidia,suspend-mode = <1>;
 	nvidia,cpu-pwr-good-time = <2000>;
@@ -171,6 +176,7 @@ Example:
 		reg = <0x0 0x7000e400 0x0 0x400>;
 		clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
 		clock-names = "pclk", "clk32k_in";
+		#clock-cells = <1>;
 
 		powergates {
 			pd_audio: aud {
@@ -260,6 +266,7 @@ Pad configuration state example:
 		reg = <0x0 0x7000e400 0x0 0x400>;
 		clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
 		clock-names = "pclk", "clk32k_in";
+		#clock-cells = <1>;
 
 		...
 
@@ -298,3 +305,39 @@ Pinctrl client example:
 		pinctrl-1 = <&hdmi_on>;
 		pinctrl-names = "hdmi-on", "hdmi-off";
 	};
+
+== Clock Control ==
+
+Tegra PMC has 3 clocks clk_1, clk_2 and clk_3. Each of these clocks has
+source selection and enable/disable gate.
+Parent/source for these clocks can be either of clk_m, clk_m_div2, clk_m_div4,
+or extern clock from Tegra CAR module.
+
+Clock configuration example:
+	pmc: pmc@7000e400 {
+		compatible = "nvidia,tegra210-pmc";
+		reg = <0x0 0x7000e400 0x0 0x400>;
+		clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
+		clock-names = "pclk", "clk32k_in";
+		#clock-cells = <1>;
+	};
+
+Clock consumer example:
+	host1x@50000000 {
+		...
+		vi@54080000 {
+			...
+			assigned-clocks = <&pmc TEGRA_PMC_CLK_OUT_3_MUX>;
+			assigned-clock-parents = <&tegra_car TEGRA210_CLK_EXTERN3>;
+		};
+		...
+	};
+	...
+	i2c@7000c500 {
+		cam_sensor {
+			...
+			clocks = <&pmc TEGRA_PMC_CLK_OUT_3>;
+			clock-names = "mclk";
+			...
+		};
+	};
diff --git a/include/dt-bindings/soc/tegra-pmc.h b/include/dt-bindings/soc/tegra-pmc.h
new file mode 100644
index 000000000000..705ee8083070
--- /dev/null
+++ b/include/dt-bindings/soc/tegra-pmc.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2019-2020, NVIDIA CORPORATION.  All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_SOC_TEGRA_PMC_H
+#define _DT_BINDINGS_SOC_TEGRA_PMC_H
+
+#define TEGRA_PMC_CLK_OUT_1_MUX		0
+#define TEGRA_PMC_CLK_OUT_1		1
+#define TEGRA_PMC_CLK_OUT_2_MUX		2
+#define TEGRA_PMC_CLK_OUT_2		3
+#define TEGRA_PMC_CLK_OUT_3_MUX		4
+#define TEGRA_PMC_CLK_OUT_3		5
+
+#define TEGRA_PMC_CLK_MAX		6
+
+#endif	/* _DT_BINDINGS_SOC_TEGRA_PMC_H */
-- 
2.7.4

