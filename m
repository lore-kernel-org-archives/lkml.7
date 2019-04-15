Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EB1C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F4A20818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356559;
	bh=ibY6WkuhGQkKiebGRWtUBTmZTIFsUKAv6W4GPhM0jIU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=u9lvO72pIE3krBhVNLL1PYQakAQD0pEnRvxxCU4xHkDAomjZG9fxl8gbZ4lc3Sd5K
	 kFSl74WNN04THXmVz+uTE+HQA7KnA4xPx5yGWLl8ldflCSWed83cNrDbvIXqNX+a4w
	 dFwKPmyJYWErX1LBXgAf7xERKl+U4DzVG1JH1JlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfDOT3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:29:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbfDOTCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:02:36 -0400
Received: from localhost.localdomain (unknown [194.230.158.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A99DE218FC;
        Mon, 15 Apr 2019 19:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354955;
        bh=ibY6WkuhGQkKiebGRWtUBTmZTIFsUKAv6W4GPhM0jIU=;
        h=From:To:Cc:Subject:Date:From;
        b=1/4LxXebJOmN+bmqY0Xg9Y2MOW8VWC3AoU1ITPtJKmnGBVI/oa5yhpIrOCQP2vHli
         1Y7W1WFT1ULUrEISEXkbkgQ5xn9xEkRAQ5e0c1PN2Du/PcWyIOjY7hVR4yV4gr7iJW
         iI/KS/b9BXsGa9vPefXnul+XAWDXFGq0Sm9bYACI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [RFT] ARM: dts: s5pv210: Fix camera clock provider for Goni board
Date:   Mon, 15 Apr 2019 21:02:22 +0200
Message-Id: <20190415190222.9665-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The camera driver (according also to bindings) registers a clock
provider if clock-output-names property is present and later the sensors
use registered clocks.

The DTS for S5Pv210 Goni board was incorrectly adding a child node with
clock output cells but without clock-output-names property.  Although
the DTS was compiling (with "/soc/camera/clock-controller: missing or
empty reg/ranges property" warning), the clock provider was not
registered.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested.
---
 arch/arm/boot/dts/s5pv210-goni.dts | 2 +-
 arch/arm/boot/dts/s5pv210.dtsi     | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-goni.dts b/arch/arm/boot/dts/s5pv210-goni.dts
index eb6d1926c0d6..fbbd93707404 100644
--- a/arch/arm/boot/dts/s5pv210-goni.dts
+++ b/arch/arm/boot/dts/s5pv210-goni.dts
@@ -376,7 +376,7 @@
 		vdd_core-supply = <&ldo14_reg>;
 
 		clock-frequency = <16000000>;
-		clocks = <&clock_cam 0>;
+		clocks = <&camera 0>;
 		clock-names = "mclk";
 		nreset-gpios = <&gpb 2 0>;
 		nstby-gpios = <&gpb 0 0>;
diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index a44d5eb56bed..2ad642f51fd9 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -585,12 +585,10 @@
 			clock-names = "sclk_cam0", "sclk_cam1";
 			#address-cells = <1>;
 			#size-cells = <1>;
+			#clock-cells = <1>;
+			clock-output-names = "cam_a_clkout", "cam_b_clkout";
 			ranges;
 
-			clock_cam: clock-controller {
-				#clock-cells = <1>;
-			};
-
 			csis0: csis@fa600000 {
 				compatible = "samsung,s5pv210-csis";
 				reg = <0xfa600000 0x4000>;
-- 
2.17.1

