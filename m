Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB84C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B79620870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390103AbfIESa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 14:30:29 -0400
Received: from smtprelay0053.hostedemail.com ([216.40.44.53]:32910 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728258AbfIESa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 14:30:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id A0B22180295BF;
        Thu,  5 Sep 2019 18:30:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wine72_20cb3d518fc49
X-Filterd-Recvd-Size: 15587
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Thu,  5 Sep 2019 18:30:25 +0000 (UTC)
Message-ID: <f85fe45879469ba53d3ae91475b4502546de501e.camel@perches.com>
Subject: [PATCH] arm: dts and dtsi: Cleanup 'SPDX-License-Identifier:' uses
From:   Joe Perches <joe@perches.com>
To:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-spdx@vger.kernel.org, devicetree <devicetree@vger.kernel.org>
Date:   Thu, 05 Sep 2019 11:30:24 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the typical form and location for SPDX-License-Identifier:

Done with command line and perl script:

$ git grep -n 'SPDX-License-Identifier: ' -- '*.dtsi' '*.dts' | \
  grep -v ':1:' | perl move_spdx.pl 
$ cat move_spdx.pl
while (<>) {
    /^([^:]+):([^:]+):(.*)/;
    my ($file, $line, $spdx) = ($1, $2, $3);
    $spdx =~ s/^\s*\/?\*\s*//;
    $spdx =~ s/\s*\*\/\s*$//;
    $spdx = "// $spdx";
    open(FH, '<', $file) or die $!;
    my @lines = <FH>;
    close FH;
    open(FH, '>', $file) or die $!;
    print FH "$spdx\n";
    my $count = 0;
    foreach (@lines) {
	$count++;
	next if ($count == $line);
	next if ($count == $line - 1 && $_ =~ /^\s*\*\s*$/);
	next if ($count == $line + 1 && $_ =~ /^\s*\*\s*$/);
	print FH "$_";
    }
    close FH;
}

And some typing for a few files with multiple spaces.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm/boot/dts/am335x-osd3358-sm-red.dts                    | 2 +-
 arch/arm/boot/dts/am335x-pdu001.dts                            | 3 +--
 arch/arm/boot/dts/aspeed-bmc-microsoft-olympus.dts             | 2 +-
 arch/arm/boot/dts/bcm953012hr.dts                              | 3 +--
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts                  | 3 +--
 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts             | 3 +--
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts        | 3 +--
 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts           | 3 +--
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts | 3 +--
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts             | 2 +-
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts                    | 3 +--
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi                      | 3 +--
 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts       | 3 +--
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts                   | 3 +--
 arch/arm64/boot/dts/mediatek/mt7622.dtsi                       | 3 +--
 arch/arm64/boot/dts/realtek/rtd1295-mele-v9.dts                | 3 +--
 arch/arm64/boot/dts/realtek/rtd1295-probox2-ava.dts            | 3 +--
 arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts              | 3 +--
 arch/arm64/boot/dts/realtek/rtd1295.dtsi                       | 3 +--
 arch/arm64/boot/dts/realtek/rtd129x.dtsi                       | 3 +--
 arch/arm64/boot/dts/sprd/sc2731.dtsi                           | 3 +--
 arch/arm64/boot/dts/sprd/sc9860.dtsi                           | 3 +--
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts                      | 3 +--
 arch/arm64/boot/dts/sprd/whale2.dtsi                           | 3 +--
 arch/arm64/boot/dts/zte/zx296718-pcbox.dts                     | 3 +--
 25 files changed, 25 insertions(+), 47 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-osd3358-sm-red.dts b/arch/arm/boot/dts/am335x-osd3358-sm-red.dts
index f47cc9fea253..2d50ac4a8960 100644
--- a/arch/arm/boot/dts/am335x-osd3358-sm-red.dts
+++ b/arch/arm/boot/dts/am335x-osd3358-sm-red.dts
@@ -1,4 +1,4 @@
-//SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2018 Octavo Systems LLC - http://www.octavosystems.com/
  *
  * This program is free software; you can redistribute it and/or modify
diff --git a/arch/arm/boot/dts/am335x-pdu001.dts b/arch/arm/boot/dts/am335x-pdu001.dts
index 3141255f72c2..869d0257d9f8 100644
--- a/arch/arm/boot/dts/am335x-pdu001.dts
+++ b/arch/arm/boot/dts/am335x-pdu001.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * pdu001.dts
  *
@@ -6,8 +7,6 @@
  * Copyright (C) 2018 EETS GmbH - http://www.eets.ch/
  *
  * Copyright (C) 2011, Texas Instruments, Incorporated - http://www.ti.com/
- *
- * SPDX-License-Identifier:  GPL-2.0+
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/aspeed-bmc-microsoft-olympus.dts b/arch/arm/boot/dts/aspeed-bmc-microsoft-olympus.dts
index 73319917cb74..f8f9f71b878c 100644
--- a/arch/arm/boot/dts/aspeed-bmc-microsoft-olympus.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-microsoft-olympus.dts
@@ -1,4 +1,4 @@
-//SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+
 
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/bcm953012hr.dts b/arch/arm/boot/dts/bcm953012hr.dts
index 9140be7ec053..6dee6974d4a0 100644
--- a/arch/arm/boot/dts/bcm953012hr.dts
+++ b/arch/arm/boot/dts/bcm953012hr.dts
@@ -1,6 +1,5 @@
+// SPDX-License-Identifier: BSD-3-Clause
 /*
- *  SPDX-License-Identifier: BSD-3-Clause
- *
  *  Copyright(c) 2017 Broadcom
  *
  *  Redistribution and use in source and binary forms, with or without
diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index 2b760f90f38c..fcc20e6d405c 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright 2017-2018 Sean Wang <sean.wang@mediatek.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
index a8b2f0f1c11d..50f2fb30d2d4 100644
--- a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (C) 2017 Chen-Yu Tsai <wens@csie.org>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
index 72d6961dc312..2ca36580436c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
@@ -1,6 +1,5 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
- *
  * Copyright (c) 2018 ARM Ltd.
  */
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index 1069e7012c9c..af44cd0e9b8e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Copyright (C) Harald Geyer <harald@ccbib.org>
  * based on sun50i-a64-olinuxino.dts by Jagan Teki <jteki@openedev.com>
- *
- * SPDX-License-Identifier: (GPL-2.0 OR MIT)
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
index db6ea7b58999..a56ac6a28df0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR X11)
 /*
  * Copyright (C) 2016 ARM Ltd.
  * Copyright (C) 2018 Hauke Mehrtens <hauke@hauke-m.de>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR X11)
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
index 7814a9e8eb08..f5ff8571eb13 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier:     GPL-2.0
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2019, Intel Corporation
  */
diff --git a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
index 2b91daf5c1a6..4a55f3a71c12 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Copyright (c) 2017 MediaTek Inc.
  * Author: YT Shen <yt.shen@mediatek.com>
- *
- * SPDX-License-Identifier: (GPL-2.0 OR MIT)
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 43307bad3f0d..96777f0373ec 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Copyright (c) 2017 MediaTek Inc.
  * Author: YT Shen <yt.shen@mediatek.com>
- *
- * SPDX-License-Identifier: (GPL-2.0 OR MIT)
  */
 
 #include <dt-bindings/clock/mt2712-clk.h>
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index 83e10591e0e5..0cab2bd5e79f 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Copyright (c) 2018 MediaTek Inc.
  * Author: Ryder Lee <ryder.lee@mediatek.com>
- *
- * SPDX-License-Identifier: (GPL-2.0 OR MIT)
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index 3f783348c66a..b13ab8b3411f 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Copyright (c) 2017 MediaTek Inc.
  * Author: Ming Huang <ming.huang@mediatek.com>
  *	   Sean Wang <sean.wang@mediatek.com>
- *
- * SPDX-License-Identifier: (GPL-2.0 OR MIT)
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index dac51e98204c..4ed2e231f693 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Copyright (c) 2017 MediaTek Inc.
  * Author: Ming Huang <ming.huang@mediatek.com>
  *	   Sean Wang <sean.wang@mediatek.com>
- *
- * SPDX-License-Identifier: (GPL-2.0 OR MIT)
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
diff --git a/arch/arm64/boot/dts/realtek/rtd1295-mele-v9.dts b/arch/arm64/boot/dts/realtek/rtd1295-mele-v9.dts
index bd584e99fff9..88687591ac83 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295-mele-v9.dts
+++ b/arch/arm64/boot/dts/realtek/rtd1295-mele-v9.dts
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (c) 2017 Andreas Färber
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/realtek/rtd1295-probox2-ava.dts b/arch/arm64/boot/dts/realtek/rtd1295-probox2-ava.dts
index 8e2b0e75298a..4e917d4f880f 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295-probox2-ava.dts
+++ b/arch/arm64/boot/dts/realtek/rtd1295-probox2-ava.dts
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (c) 2017 Andreas Färber
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts b/arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
index da19faab29d5..8b52c907f9bf 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
+++ b/arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (c) 2016-2017 Andreas Färber
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
index 41d7858da826..0c413e710930 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Realtek RTD1295 SoC
  *
  * Copyright (c) 2016-2017 Andreas Färber
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 #include "rtd129x.dtsi"
diff --git a/arch/arm64/boot/dts/realtek/rtd129x.dtsi b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
index b9cb92466fc7..ea109855718b 100644
--- a/arch/arm64/boot/dts/realtek/rtd129x.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Realtek RTD1293/RTD1295/RTD1296 SoC
  *
  * Copyright (c) 2016-2017 Andreas Färber
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 /memreserve/	0x0000000000000000 0x0000000000030000;
diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index e15409f55f43..fc4e2b1e160e 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Spreadtrum SC2731 PMIC dts file
  *
  * Copyright (C) 2018, Spreadtrum Communications Inc.
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 &adi_bus {
diff --git a/arch/arm64/boot/dts/sprd/sc9860.dtsi b/arch/arm64/boot/dts/sprd/sc9860.dtsi
index e27eb3ed1d47..9dad0cefafc0 100644
--- a/arch/arm64/boot/dts/sprd/sc9860.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9860.dtsi
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Spreadtrum SC9860 SoC
  *
  * Copyright (C) 2016, Spreadtrum Communications Inc.
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
diff --git a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
index 6b95fd94cee3..4423acd0c9c0 100644
--- a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
+++ b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Spreadtrum SP9860g board
  *
  * Copyright (C) 2017, Spreadtrum Communications Inc.
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index 79b9591c37aa..b6e1378e2297 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Spreadtrum Whale2 platform peripherals
  *
  * Copyright (C) 2016, Spreadtrum Communications Inc.
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 #include <dt-bindings/clock/sprd,sc9860-clk.h>
diff --git a/arch/arm64/boot/dts/zte/zx296718-pcbox.dts b/arch/arm64/boot/dts/zte/zx296718-pcbox.dts
index e02509f7082b..8fd6cf518a2f 100644
--- a/arch/arm64/boot/dts/zte/zx296718-pcbox.dts
+++ b/arch/arm64/boot/dts/zte/zx296718-pcbox.dts
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (C) 2017 Sanechips Technology Co., Ltd.
  * Copyright 2017 Linaro Ltd.
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 /dts-v1/;


