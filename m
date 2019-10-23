Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71561C47E49
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F21121920
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ifjdMT8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391732AbfJWMoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:44:30 -0400
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:52098 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391702AbfJWMo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:44:29 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 67507C08D9;
        Wed, 23 Oct 2019 12:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571834666; bh=Frqr7w7GDPgthgvUpcqVNHSNkXwkZ9Lc9JiRO3ZT544=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ifjdMT8plRZN+b7D6GoFz/9fAVr7abVwPmUexxXtJkPjiR4aLaFC6lWmgtxemoeZC
         LCHOQyDHWJ/K3uoe0tFNA8C/PYPu+a/iBtJsNvlsuPX5OgrxNDYGJDtmoHJxJ8Q6QX
         yvzh3gMFJpVKMuHuud05gUCXr0+AGLySWVYBRzWPbkdFaKCA+EYMkYU8YQjFl2fWkO
         uqQNM/UQZjONvu2a1SNGodt4oiKRV84XP/STmxKzBk3gVwPjkFPwA9nLteInV6aDET
         +gQzVwL8GrBHximNDFJP7XIWsrfiDB5lRUIt/t6ZXviWjvMudx2z2TMJydmdjWWxMO
         9c+iNUQF5Sg6g==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.73])
        by mailhost.synopsys.com (Postfix) with ESMTP id C8EFAA005D;
        Wed, 23 Oct 2019 12:44:24 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 6/8] ARC: merge HAPS-HS with nSIM-HS configs
Date:   Wed, 23 Oct 2019 15:44:15 +0300
Message-Id: <20191023124417.5770-7-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191023124417.5770-1-Eugeniy.Paltsev@synopsys.com>
References: <20191023124417.5770-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from nSIM 2019.06 is possible to use DW UART
instead of ARC UART. That allows us to merge
"nsim_hs" with "haps_hs" and "nsim_hs_smp" with "haps_hs_smp"
with minor changes which were done in previous commits.

We eliminate nsim_hs_defconfig and nsim_hs_smp_defconfig
and leave haps_hs_defconfig and haps_hs_smp_defconfig
which can be used on HAPS / nSIM / ZEBU / QEMU platforms
without additional changes in Linux kernel.

For nSIM we should now use UART property values
"-prop=nsim_mem-dev=uart0,kind=dwuart,base=0xf0000000"
instead of previously used
"-prop=nsim_mem-dev=uart0,base=0xc0fc1000"
"use_connect" and "irq" values of UART property remains untouched.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/Makefile                      |  2 +-
 arch/arc/boot/dts/nsim_hs.dts          | 67 --------------------------
 arch/arc/boot/dts/nsim_hs_idu.dts      | 65 -------------------------
 arch/arc/configs/nsim_hs_defconfig     | 56 ---------------------
 arch/arc/configs/nsim_hs_smp_defconfig | 54 ---------------------
 arch/arc/plat-sim/platform.c           |  1 -
 6 files changed, 1 insertion(+), 244 deletions(-)
 delete mode 100644 arch/arc/boot/dts/nsim_hs.dts
 delete mode 100644 arch/arc/boot/dts/nsim_hs_idu.dts
 delete mode 100644 arch/arc/configs/nsim_hs_defconfig
 delete mode 100644 arch/arc/configs/nsim_hs_smp_defconfig

diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index f1c44cccf8d6..20e9ab6cc521 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -3,7 +3,7 @@
 # Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
 #
 
-KBUILD_DEFCONFIG := nsim_hs_defconfig
+KBUILD_DEFCONFIG := haps_hs_smp_defconfig
 
 ifeq ($(CROSS_COMPILE),)
 CROSS_COMPILE := $(call cc-cross-prefix, arc-linux- arceb-linux-)
diff --git a/arch/arc/boot/dts/nsim_hs.dts b/arch/arc/boot/dts/nsim_hs.dts
deleted file mode 100644
index 851798a5f4e3..000000000000
--- a/arch/arc/boot/dts/nsim_hs.dts
+++ /dev/null
@@ -1,67 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2014-15 Synopsys, Inc. (www.synopsys.com)
- */
-/dts-v1/;
-
-/include/ "skeleton_hs.dtsi"
-
-/ {
-	model = "snps,nsim_hs";
-	compatible = "snps,nsim_hs";
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&core_intc>;
-
-	memory {
-		device_type = "memory";
-		/* CONFIG_LINUX_RAM_BASE needs to match low mem start */
-		reg = <0x0 0x80000000 0x0 0x20000000	/* 512 MB low mem */
-		       0x1 0x00000000 0x0 0x40000000>;	/* 1 GB highmem */
-	};
-
-	chosen {
-		bootargs = "earlycon=arc_uart,mmio32,0xc0fc1000,115200n8 console=ttyARC0,115200n8 print-fatal-signals=1";
-	};
-
-	aliases {
-		serial0 = &arcuart0;
-	};
-
-	fpga {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		/* only perip space at end of low mem accessible
-			 bus addr,   parent bus addr, size */
-		ranges = <0x80000000 0x0 0x80000000 0x80000000>;
-
-		core_clk: core_clk {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <80000000>;
-		};
-
-		core_intc: core-interrupt-controller {
-			compatible = "snps,archs-intc";
-			interrupt-controller;
-			#interrupt-cells = <1>;
-		};
-
-		arcuart0: serial@c0fc1000 {
-			compatible = "snps,arc-uart";
-			reg = <0xc0fc1000 0x100>;
-			interrupts = <24>;
-			clock-frequency = <80000000>;
-			current-speed = <115200>;
-			status = "okay";
-		};
-
-		arcpct0: pct {
-			compatible = "snps,archs-pct";
-			#interrupt-cells = <1>;
-			interrupts = <20>;
-		};
-	};
-};
diff --git a/arch/arc/boot/dts/nsim_hs_idu.dts b/arch/arc/boot/dts/nsim_hs_idu.dts
deleted file mode 100644
index 6c559a0bd1f5..000000000000
--- a/arch/arc/boot/dts/nsim_hs_idu.dts
+++ /dev/null
@@ -1,65 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2014-15 Synopsys, Inc. (www.synopsys.com)
- */
-/dts-v1/;
-
-/include/ "skeleton_hs_idu.dtsi"
-
-/ {
-	model = "snps,nsim_hs-smp";
-	compatible = "snps,nsim_hs";
-	interrupt-parent = <&core_intc>;
-
-	chosen {
-		bootargs = "earlycon=arc_uart,mmio32,0xc0fc1000,115200n8 console=ttyARC0,115200n8 print-fatal-signals=1";
-	};
-
-	aliases {
-		serial0 = &arcuart0;
-	};
-
-	fpga {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		/* child and parent address space 1:1 mapped */
-		ranges;
-
-		core_clk: core_clk {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <80000000>;
-		};
-
-		core_intc: core-interrupt-controller {
-			compatible = "snps,archs-intc";
-			interrupt-controller;
-			#interrupt-cells = <1>;
-		};
-
-		idu_intc: idu-interrupt-controller {
-			compatible = "snps,archs-idu-intc";
-			interrupt-controller;
-			interrupt-parent = <&core_intc>;
-			#interrupt-cells = <1>;
-		};
-
-		arcuart0: serial@c0fc1000 {
-			compatible = "snps,arc-uart";
-			reg = <0xc0fc1000 0x100>;
-			interrupt-parent = <&idu_intc>;
-			interrupts = <0>;
-			clock-frequency = <80000000>;
-			current-speed = <115200>;
-			status = "okay";
-		};
-
-		arcpct0: pct {
-			compatible = "snps,archs-pct";
-			#interrupt-cells = <1>;
-			interrupts = <20>;
-		};
-	};
-};
diff --git a/arch/arc/configs/nsim_hs_defconfig b/arch/arc/configs/nsim_hs_defconfig
deleted file mode 100644
index 60ad81769565..000000000000
--- a/arch/arc/configs/nsim_hs_defconfig
+++ /dev/null
@@ -1,56 +0,0 @@
-# CONFIG_LOCALVERSION_AUTO is not set
-# CONFIG_SWAP is not set
-CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
-# CONFIG_CROSS_MEMORY_ATTACH is not set
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_PREEMPT=y
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_NAMESPACES=y
-# CONFIG_UTS_NS is not set
-# CONFIG_PID_NS is not set
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
-CONFIG_KALLSYMS_ALL=y
-CONFIG_EMBEDDED=y
-CONFIG_PERF_EVENTS=y
-# CONFIG_SLUB_DEBUG is not set
-# CONFIG_COMPAT_BRK is not set
-CONFIG_ARC_BUILTIN_DTB_NAME="nsim_hs"
-CONFIG_KPROBES=y
-CONFIG_MODULES=y
-CONFIG_MODULE_FORCE_LOAD=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-# CONFIG_COMPACTION is not set
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_UNIX_DIAG=y
-CONFIG_NET_KEY=y
-CONFIG_INET=y
-# CONFIG_IPV6 is not set
-CONFIG_DEVTMPFS=y
-# CONFIG_STANDALONE is not set
-# CONFIG_PREVENT_FIRMWARE_BUILD is not set
-# CONFIG_BLK_DEV is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-# CONFIG_LEGACY_PTYS is not set
-CONFIG_SERIAL_ARC=y
-CONFIG_SERIAL_ARC_CONSOLE=y
-# CONFIG_HW_RANDOM is not set
-# CONFIG_HWMON is not set
-# CONFIG_HID is not set
-# CONFIG_USB_SUPPORT is not set
-# CONFIG_IOMMU_SUPPORT is not set
-CONFIG_EXT2_FS=y
-CONFIG_EXT2_FS_XATTR=y
-CONFIG_TMPFS=y
-# CONFIG_MISC_FILESYSTEMS is not set
-CONFIG_NFS_FS=y
-# CONFIG_ENABLE_MUST_CHECK is not set
-# CONFIG_DEBUG_PREEMPT is not set
diff --git a/arch/arc/configs/nsim_hs_smp_defconfig b/arch/arc/configs/nsim_hs_smp_defconfig
deleted file mode 100644
index c7a29adfc147..000000000000
--- a/arch/arc/configs/nsim_hs_smp_defconfig
+++ /dev/null
@@ -1,54 +0,0 @@
-# CONFIG_LOCALVERSION_AUTO is not set
-# CONFIG_SWAP is not set
-# CONFIG_CROSS_MEMORY_ATTACH is not set
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_PREEMPT=y
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_NAMESPACES=y
-# CONFIG_UTS_NS is not set
-# CONFIG_PID_NS is not set
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
-CONFIG_KALLSYMS_ALL=y
-CONFIG_EMBEDDED=y
-CONFIG_PERF_EVENTS=y
-# CONFIG_SLUB_DEBUG is not set
-# CONFIG_COMPAT_BRK is not set
-CONFIG_SMP=y
-CONFIG_ARC_BUILTIN_DTB_NAME="nsim_hs_idu"
-CONFIG_KPROBES=y
-CONFIG_MODULES=y
-CONFIG_MODULE_FORCE_LOAD=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-# CONFIG_COMPACTION is not set
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_UNIX_DIAG=y
-CONFIG_NET_KEY=y
-CONFIG_INET=y
-# CONFIG_IPV6 is not set
-CONFIG_DEVTMPFS=y
-# CONFIG_STANDALONE is not set
-# CONFIG_PREVENT_FIRMWARE_BUILD is not set
-# CONFIG_BLK_DEV is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-# CONFIG_LEGACY_PTYS is not set
-CONFIG_SERIAL_ARC=y
-CONFIG_SERIAL_ARC_CONSOLE=y
-# CONFIG_HW_RANDOM is not set
-# CONFIG_HWMON is not set
-# CONFIG_HID is not set
-# CONFIG_USB_SUPPORT is not set
-# CONFIG_IOMMU_SUPPORT is not set
-CONFIG_EXT2_FS=y
-CONFIG_EXT2_FS_XATTR=y
-CONFIG_TMPFS=y
-# CONFIG_MISC_FILESYSTEMS is not set
-CONFIG_NFS_FS=y
-# CONFIG_ENABLE_MUST_CHECK is not set
diff --git a/arch/arc/plat-sim/platform.c b/arch/arc/plat-sim/platform.c
index 3765dedcd319..2bde2a6e336a 100644
--- a/arch/arc/plat-sim/platform.c
+++ b/arch/arc/plat-sim/platform.c
@@ -21,7 +21,6 @@ static const char *simulation_compat[] __initconst = {
 	"snps,nsim",
 	"snps,nsimosci",
 #else
-	"snps,nsim_hs",
 	"snps,nsimosci_hs",
 	"snps,zebu_hs",
 #endif
-- 
2.21.0

