Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5814CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26781214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411298;
	bh=oBVxyplbpNGBpkHVYOSmrQHPNMTnXex4q15trDiGZdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XaKPe4FfWZbJStgL6zXauglolDI1HWJJ7+0VlizLSD4ZefsM2r5Bvt54qfdxGhc3F
	 bCjMdwmtSdbG0rMAyx+lO7bOy+A/QCf/pAR9McJSs7Vlqrn7/cJrYYIRfCNz5JYn/S
	 QO/yf2hDygKwX595v6HP91RAAyakAEgFqca+qlOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfCLRVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:21:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729988AbfCLRSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:18:14 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB61B21741;
        Tue, 12 Mar 2019 17:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411093;
        bh=oBVxyplbpNGBpkHVYOSmrQHPNMTnXex4q15trDiGZdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eQNcv3Ks4J3fJS4rwTkEEVNDv1zmaqRCuVMW2RhqKoLjs0S7gquXVvaL0VDaU1Iuj
         5Tku23or6sShvT7jH4BSNPZSei5MgjDX13x11wrUvFVZFumZMltB/El7X+kYjDo0D+
         wU3zknR0Q/RK6RT0H0S9QsX3YJRwf/dTxTV+vNTI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH 4.9 93/96] ARM: dts: exynos: Do not ignore real-world fuse values for thermal zone 0 on Exynos5420
Date:   Tue, 12 Mar 2019 10:10:51 -0700
Message-Id: <20190312171041.472851052@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzk@kernel.org>

commit 28928a3ce142b2e4e5a7a0f067cefb41a3d2c3f9 upstream.

In Odroid XU3 Lite board, the temperature levels reported for thermal
zone 0 were weird. In warm room:
	/sys/class/thermal/thermal_zone0/temp:32000
	/sys/class/thermal/thermal_zone1/temp:51000
	/sys/class/thermal/thermal_zone2/temp:55000
	/sys/class/thermal/thermal_zone3/temp:54000
	/sys/class/thermal/thermal_zone4/temp:51000

Sometimes after booting the value was even equal to ambient temperature
which is highly unlikely to be a real temperature of sensor in SoC.

The thermal sensor's calibration (trimming) is based on fused values.
In case of the board above, the fused values are: 35, 52, 43, 58 and 43
(corresponding to each TMU device).  However driver defined a minimum value
for fused data as 40 and for smaller values it was using a hard-coded 55
instead.  This lead to mapping data from sensor to wrong temperatures
for thermal zone 0.

Various vendor 3.10 trees (Hardkernel's based on Samsung LSI, Artik 10)
do not impose any limits on fused values.  Since we do not have any
knowledge about these limits, use 0 as a minimum accepted fused value.
This should essentially allow accepting any reasonable fused value thus
behaving like vendor driver.

The exynos5420-tmu-sensor-conf.dtsi is copied directly from existing
exynos4412 with one change - the samsung,tmu_min_efuse_value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Eduardo Valentin <edubezval@gmail.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
Reviewed-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Anand Moon <linux.amoon@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi |   25 ++++++++++++++++++++++
 arch/arm/boot/dts/exynos5420.dtsi                 |   10 ++++----
 2 files changed, 30 insertions(+), 5 deletions(-)

--- /dev/null
+++ b/arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
@@ -0,0 +1,25 @@
+/*
+ * Device tree sources for Exynos5420 TMU sensor configuration
+ *
+ * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
+ * Copyright (c) 2017 Krzysztof Kozlowski <krzk@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <dt-bindings/thermal/thermal_exynos.h>
+
+#thermal-sensor-cells = <0>;
+samsung,tmu_gain = <8>;
+samsung,tmu_reference_voltage = <16>;
+samsung,tmu_noise_cancel_mode = <4>;
+samsung,tmu_efuse_value = <55>;
+samsung,tmu_min_efuse_value = <0>;
+samsung,tmu_max_efuse_value = <100>;
+samsung,tmu_first_point_trim = <25>;
+samsung,tmu_second_point_trim = <85>;
+samsung,tmu_default_temp_offset = <50>;
+samsung,tmu_cal_type = <TYPE_ONE_POINT_TRIMMING>;
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -694,7 +694,7 @@
 			interrupts = <0 65 0>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#include "exynos5420-tmu-sensor-conf.dtsi"
 		};
 
 		tmu_cpu1: tmu@10064000 {
@@ -703,7 +703,7 @@
 			interrupts = <0 183 0>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#include "exynos5420-tmu-sensor-conf.dtsi"
 		};
 
 		tmu_cpu2: tmu@10068000 {
@@ -712,7 +712,7 @@
 			interrupts = <0 184 0>;
 			clocks = <&clock CLK_TMU>, <&clock CLK_TMU>;
 			clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#include "exynos5420-tmu-sensor-conf.dtsi"
 		};
 
 		tmu_cpu3: tmu@1006c000 {
@@ -721,7 +721,7 @@
 			interrupts = <0 185 0>;
 			clocks = <&clock CLK_TMU>, <&clock CLK_TMU_GPU>;
 			clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#include "exynos5420-tmu-sensor-conf.dtsi"
 		};
 
 		tmu_gpu: tmu@100a0000 {
@@ -730,7 +730,7 @@
 			interrupts = <0 215 0>;
 			clocks = <&clock CLK_TMU_GPU>, <&clock CLK_TMU>;
 			clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#include "exynos5420-tmu-sensor-conf.dtsi"
 		};
 
 		sysmmu_g2dr: sysmmu@0x10A60000 {


