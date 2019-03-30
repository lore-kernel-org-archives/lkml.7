Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C0AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 22:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA1D2183F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 22:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPbrw6wu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbfC3WVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 18:21:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34720 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730807AbfC3WVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 18:21:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id b3so2705061pfd.1;
        Sat, 30 Mar 2019 15:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FLY0phxzQU1i4FlbPl6wKkKUMzg4dAwUEH18HUOoj6Y=;
        b=YPbrw6wu1koKt7iKHF69XMTesSCLnEWXo3BeSSvQfN+tLPbk2OktXhjTYxO7EgbIml
         j+ax4dDSO3z/R9uJ1s3qEzpqUlZbjPxA+vRsM+J9PVBhXYkX9ua+PyFpK3NH62wtjZMX
         UdC+nnVQ7qtixLLpZvg5sCJofPeLArPwNE1+a5gSb08lK07qWnIvw5oLLP1BzJDqUsLE
         VQI2O9fjyCldt8Fn6qPCrGDlZg0QPyOYHHxoWkrjyODaG4eaYhO3OJdkB+MNG2yLWX/q
         DGVOIxmSD8QiShbGNxwoLBoe6qFcmIlBeEARywcHIbgmRSpv5oiRnRjtOYLdudq6hPSz
         A2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FLY0phxzQU1i4FlbPl6wKkKUMzg4dAwUEH18HUOoj6Y=;
        b=BVvllACOqe7tcZYxv1amYSSnjHUPotEHOVIX6gWpegeoScLbyh2v7dUAY3tzW45rGn
         mA5vbP6xUXFxdiVaYp1FXzLkHBnUUTKF+OU0Vb8a+3y5CLKYjfD0a2c+dI/9Ul+B5FCp
         INsh7B/bDtqhUAJuLMu3pVaNanGj9pRQDs1no60AlED/kLrTYHjXy9o41IMUuLFtIwU/
         U/z7SOgzfh01Z7N4kjHzxdrLmwCSovkSAPG8vpnhMWeTic9Caz17BL4RKn750rhJTEAN
         eqJ3l3P1v604waCtHsl5YWYrUNh/CIliTUcrzGbpSuu2W05eUh22f83GdW31PguTwEXa
         RDlg==
X-Gm-Message-State: APjAAAWYb6PS+v5JUoYzRu9fUXw42lOqjufn77jW0pRbhkpAFvbTH+Oc
        K8e/P/J7hS3zITC6j/sEr0M=
X-Google-Smtp-Source: APXvYqx6bvmV7XLOE8CF7vUs5xtbR9gNOlzc8ytAEySxUqYNxrH2JyeOUH9wXihb3kAdNLpII1jX1A==
X-Received: by 2002:a63:4542:: with SMTP id u2mr52503249pgk.291.1553984480136;
        Sat, 30 Mar 2019 15:21:20 -0700 (PDT)
Received: from nishad (p640014-ipngn8201hodogaya.kanagawa.ocn.ne.jp. [60.46.49.14])
        by smtp.gmail.com with ESMTPSA id v19sm11387668pfa.138.2019.03.30.15.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 15:21:19 -0700 (PDT)
Date:   Sun, 31 Mar 2019 03:51:09 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARCH: Use the correct style for SPDX License Identifier
Message-ID: <20190330222104.GA14173@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style
in the Hardware Architecture subsystem. For C header files
Documentation/process/license-rules.rst mandates C-like comments
(opposed to C source files where C++ style should be used)

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46
and making some manual changes.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h     | 2 +-
 arch/arm64/include/asm/pointer_auth.h             | 2 +-
 arch/arm64/include/asm/sdei.h                     | 2 +-
 arch/arm64/include/asm/vmap_stack.h               | 2 +-
 arch/nds32/include/asm/assembler.h                | 2 +-
 arch/nds32/include/asm/barrier.h                  | 2 +-
 arch/nds32/include/asm/bitfield.h                 | 2 +-
 arch/nds32/include/asm/cache.h                    | 2 +-
 arch/nds32/include/asm/cache_info.h               | 2 +-
 arch/nds32/include/asm/cacheflush.h               | 2 +-
 arch/nds32/include/asm/current.h                  | 2 +-
 arch/nds32/include/asm/delay.h                    | 2 +-
 arch/nds32/include/asm/elf.h                      | 2 +-
 arch/nds32/include/asm/fixmap.h                   | 2 +-
 arch/nds32/include/asm/futex.h                    | 2 +-
 arch/nds32/include/asm/highmem.h                  | 2 +-
 arch/nds32/include/asm/io.h                       | 2 +-
 arch/nds32/include/asm/irqflags.h                 | 2 +-
 arch/nds32/include/asm/l2_cache.h                 | 2 +-
 arch/nds32/include/asm/linkage.h                  | 2 +-
 arch/nds32/include/asm/memory.h                   | 2 +-
 arch/nds32/include/asm/mmu.h                      | 2 +-
 arch/nds32/include/asm/mmu_context.h              | 2 +-
 arch/nds32/include/asm/module.h                   | 2 +-
 arch/nds32/include/asm/nds32.h                    | 2 +-
 arch/nds32/include/asm/page.h                     | 2 +-
 arch/nds32/include/asm/pgalloc.h                  | 2 +-
 arch/nds32/include/asm/pgtable.h                  | 2 +-
 arch/nds32/include/asm/proc-fns.h                 | 2 +-
 arch/nds32/include/asm/processor.h                | 2 +-
 arch/nds32/include/asm/ptrace.h                   | 2 +-
 arch/nds32/include/asm/shmparam.h                 | 2 +-
 arch/nds32/include/asm/string.h                   | 2 +-
 arch/nds32/include/asm/swab.h                     | 2 +-
 arch/nds32/include/asm/syscall.h                  | 2 +-
 arch/nds32/include/asm/syscalls.h                 | 2 +-
 arch/nds32/include/asm/thread_info.h              | 2 +-
 arch/nds32/include/asm/tlb.h                      | 2 +-
 arch/nds32/include/asm/tlbflush.h                 | 2 +-
 arch/nds32/include/asm/uaccess.h                  | 2 +-
 arch/nds32/include/asm/unistd.h                   | 2 +-
 arch/nds32/include/asm/vdso.h                     | 2 +-
 arch/nds32/include/asm/vdso_datapage.h            | 2 +-
 arch/nds32/include/asm/vdso_timer_info.h          | 2 +-
 arch/nds32/include/uapi/asm/auxvec.h              | 2 +-
 arch/nds32/include/uapi/asm/byteorder.h           | 2 +-
 arch/nds32/include/uapi/asm/cachectl.h            | 2 +-
 arch/nds32/include/uapi/asm/param.h               | 2 +-
 arch/nds32/include/uapi/asm/ptrace.h              | 2 +-
 arch/nds32/include/uapi/asm/sigcontext.h          | 2 +-
 arch/nds32/include/uapi/asm/unistd.h              | 2 +-
 arch/powerpc/include/asm/pnv-ocxl.h               | 2 +-
 arch/sh/drivers/pci/pci-sh5.h                     | 4 ++--
 arch/sh/drivers/pci/pci-sh7751.h                  | 4 ++--
 arch/sh/drivers/pci/pci-sh7780.h                  | 4 ++--
 arch/sh/drivers/pci/pcie-sh7786.h                 | 4 ++--
 arch/sh/include/asm/addrspace.h                   | 4 ++--
 arch/sh/include/asm/bl_bit_64.h                   | 4 ++--
 arch/sh/include/asm/cache_insns_64.h              | 4 ++--
 arch/sh/include/asm/device.h                      | 4 ++--
 arch/sh/include/asm/dma-register.h                | 4 ++--
 arch/sh/include/asm/dma.h                         | 4 ++--
 arch/sh/include/asm/dwarf.h                       | 4 ++--
 arch/sh/include/asm/fixmap.h                      | 4 ++--
 arch/sh/include/asm/flat.h                        | 4 ++--
 arch/sh/include/asm/freq.h                        | 4 ++--
 arch/sh/include/asm/gpio.h                        | 4 ++--
 arch/sh/include/asm/machvec.h                     | 4 ++--
 arch/sh/include/asm/pgtable.h                     | 4 ++--
 arch/sh/include/asm/sfp-machine.h                 | 4 ++--
 arch/sh/include/asm/shmparam.h                    | 4 ++--
 arch/sh/include/asm/siu.h                         | 4 ++--
 arch/sh/include/asm/spinlock-cas.h                | 4 ++--
 arch/sh/include/asm/spinlock-llsc.h               | 4 ++--
 arch/sh/include/asm/spinlock.h                    | 4 ++--
 arch/sh/include/asm/switch_to.h                   | 4 ++--
 arch/sh/include/asm/switch_to_64.h                | 4 ++--
 arch/sh/include/asm/tlb_64.h                      | 4 ++--
 arch/sh/include/asm/traps_64.h                    | 4 ++--
 arch/sh/include/asm/watchdog.h                    | 4 ++--
 arch/sh/include/cpu-common/cpu/addrspace.h        | 4 ++--
 arch/sh/include/cpu-common/cpu/mmu_context.h      | 4 ++--
 arch/sh/include/cpu-common/cpu/pfc.h              | 4 ++--
 arch/sh/include/cpu-sh2/cpu/cache.h               | 4 ++--
 arch/sh/include/cpu-sh2/cpu/freq.h                | 4 ++--
 arch/sh/include/cpu-sh2/cpu/watchdog.h            | 4 ++--
 arch/sh/include/cpu-sh2a/cpu/cache.h              | 4 ++--
 arch/sh/include/cpu-sh2a/cpu/freq.h               | 4 ++--
 arch/sh/include/cpu-sh3/cpu/cache.h               | 4 ++--
 arch/sh/include/cpu-sh3/cpu/dma-register.h        | 4 ++--
 arch/sh/include/cpu-sh3/cpu/freq.h                | 4 ++--
 arch/sh/include/cpu-sh3/cpu/gpio.h                | 4 ++--
 arch/sh/include/cpu-sh3/cpu/mmu_context.h         | 4 ++--
 arch/sh/include/cpu-sh3/cpu/watchdog.h            | 4 ++--
 arch/sh/include/cpu-sh4/cpu/addrspace.h           | 4 ++--
 arch/sh/include/cpu-sh4/cpu/cache.h               | 4 ++--
 arch/sh/include/cpu-sh4/cpu/dma-register.h        | 4 ++--
 arch/sh/include/cpu-sh4/cpu/fpu.h                 | 4 ++--
 arch/sh/include/cpu-sh4/cpu/freq.h                | 4 ++--
 arch/sh/include/cpu-sh4/cpu/mmu_context.h         | 4 ++--
 arch/sh/include/cpu-sh4/cpu/sh7786.h              | 4 ++--
 arch/sh/include/cpu-sh4/cpu/sq.h                  | 4 ++--
 arch/sh/include/cpu-sh4/cpu/watchdog.h            | 4 ++--
 arch/sh/include/mach-common/mach/hp6xx.h          | 4 ++--
 arch/sh/include/mach-common/mach/magicpanelr2.h   | 4 ++--
 arch/sh/include/mach-common/mach/mangle-port.h    | 4 ++--
 arch/sh/include/mach-common/mach/microdev.h       | 4 ++--
 arch/sh/include/mach-common/mach/secureedge5410.h | 4 ++--
 arch/sh/include/mach-dreamcast/mach/dma.h         | 4 ++--
 arch/sh/include/mach-dreamcast/mach/pci.h         | 4 ++--
 arch/sh/include/mach-dreamcast/mach/sysasic.h     | 4 ++--
 arch/sh/include/mach-se/mach/se7721.h             | 4 ++--
 arch/x86/include/asm/cpu_entry_area.h             | 2 +-
 arch/x86/include/asm/pti.h                        | 2 +-
 arch/x86/kernel/process.h                         | 2 +-
 115 files changed, 175 insertions(+), 175 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h b/arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h
index 1b4cb0c55744..385c455a7c98 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h
+++ b/arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2018 MediaTek Inc.
  * Author: Zhiyong Tao <zhiyong.tao@mediatek.com>
diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
index 15d49515efdd..d328540cb85e 100644
--- a/arch/arm64/include/asm/pointer_auth.h
+++ b/arch/arm64/include/asm/pointer_auth.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_POINTER_AUTH_H
 #define __ASM_POINTER_AUTH_H
 
diff --git a/arch/arm64/include/asm/sdei.h b/arch/arm64/include/asm/sdei.h
index ffe47d766c25..63e0b92a5fbb 100644
--- a/arch/arm64/include/asm/sdei.h
+++ b/arch/arm64/include/asm/sdei.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2017 Arm Ltd.
 #ifndef __ASM_SDEI_H
 #define __ASM_SDEI_H
diff --git a/arch/arm64/include/asm/vmap_stack.h b/arch/arm64/include/asm/vmap_stack.h
index 0b5ec6e08c10..0a12115d9638 100644
--- a/arch/arm64/include/asm/vmap_stack.h
+++ b/arch/arm64/include/asm/vmap_stack.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2017 Arm Ltd.
 #ifndef __ASM_VMAP_STACK_H
 #define __ASM_VMAP_STACK_H
diff --git a/arch/nds32/include/asm/assembler.h b/arch/nds32/include/asm/assembler.h
index c3855782a541..5e7c56926049 100644
--- a/arch/nds32/include/asm/assembler.h
+++ b/arch/nds32/include/asm/assembler.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_ASSEMBLER_H__
diff --git a/arch/nds32/include/asm/barrier.h b/arch/nds32/include/asm/barrier.h
index faafc373ea6c..16413172fd50 100644
--- a/arch/nds32/include/asm/barrier.h
+++ b/arch/nds32/include/asm/barrier.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_ASM_BARRIER_H
diff --git a/arch/nds32/include/asm/bitfield.h b/arch/nds32/include/asm/bitfield.h
index 7414fcbbab4e..e75212c76b20 100644
--- a/arch/nds32/include/asm/bitfield.h
+++ b/arch/nds32/include/asm/bitfield.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_BITFIELD_H__
diff --git a/arch/nds32/include/asm/cache.h b/arch/nds32/include/asm/cache.h
index 347db4881c5f..fc3c41b59169 100644
--- a/arch/nds32/include/asm/cache.h
+++ b/arch/nds32/include/asm/cache.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_CACHE_H__
diff --git a/arch/nds32/include/asm/cache_info.h b/arch/nds32/include/asm/cache_info.h
index 38ec458ba543..e89d8078f3a6 100644
--- a/arch/nds32/include/asm/cache_info.h
+++ b/arch/nds32/include/asm/cache_info.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 struct cache_info {
diff --git a/arch/nds32/include/asm/cacheflush.h b/arch/nds32/include/asm/cacheflush.h
index 8b26198d51bb..d9ac7e6408ef 100644
--- a/arch/nds32/include/asm/cacheflush.h
+++ b/arch/nds32/include/asm/cacheflush.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_CACHEFLUSH_H__
diff --git a/arch/nds32/include/asm/current.h b/arch/nds32/include/asm/current.h
index b4dcd22b7bcb..65d30096142b 100644
--- a/arch/nds32/include/asm/current.h
+++ b/arch/nds32/include/asm/current.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASM_NDS32_CURRENT_H
diff --git a/arch/nds32/include/asm/delay.h b/arch/nds32/include/asm/delay.h
index 519ba97acb6e..56ea3894f8f8 100644
--- a/arch/nds32/include/asm/delay.h
+++ b/arch/nds32/include/asm/delay.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_DELAY_H__
diff --git a/arch/nds32/include/asm/elf.h b/arch/nds32/include/asm/elf.h
index 02250626b9f0..1c8e56d7013d 100644
--- a/arch/nds32/include/asm/elf.h
+++ b/arch/nds32/include/asm/elf.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASMNDS32_ELF_H
diff --git a/arch/nds32/include/asm/fixmap.h b/arch/nds32/include/asm/fixmap.h
index 0e60e153a71a..5a4bf11e5800 100644
--- a/arch/nds32/include/asm/fixmap.h
+++ b/arch/nds32/include/asm/fixmap.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_FIXMAP_H
diff --git a/arch/nds32/include/asm/futex.h b/arch/nds32/include/asm/futex.h
index baf178bf1d0b..5213c65c2e0b 100644
--- a/arch/nds32/include/asm/futex.h
+++ b/arch/nds32/include/asm/futex.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_FUTEX_H__
diff --git a/arch/nds32/include/asm/highmem.h b/arch/nds32/include/asm/highmem.h
index 425d546cb059..b3a82c97ded3 100644
--- a/arch/nds32/include/asm/highmem.h
+++ b/arch/nds32/include/asm/highmem.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASM_HIGHMEM_H
diff --git a/arch/nds32/include/asm/io.h b/arch/nds32/include/asm/io.h
index 71cd226d6863..7cbf76ec439d 100644
--- a/arch/nds32/include/asm/io.h
+++ b/arch/nds32/include/asm/io.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_IO_H
diff --git a/arch/nds32/include/asm/irqflags.h b/arch/nds32/include/asm/irqflags.h
index 2bfd00f8bc48..fb45ec46bb1b 100644
--- a/arch/nds32/include/asm/irqflags.h
+++ b/arch/nds32/include/asm/irqflags.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #include <asm/nds32.h>
diff --git a/arch/nds32/include/asm/l2_cache.h b/arch/nds32/include/asm/l2_cache.h
index 37dd5ef61de8..3ea48e19e6de 100644
--- a/arch/nds32/include/asm/l2_cache.h
+++ b/arch/nds32/include/asm/l2_cache.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef L2_CACHE_H
diff --git a/arch/nds32/include/asm/linkage.h b/arch/nds32/include/asm/linkage.h
index e708c8bdb926..a696469abb70 100644
--- a/arch/nds32/include/asm/linkage.h
+++ b/arch/nds32/include/asm/linkage.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_LINKAGE_H
diff --git a/arch/nds32/include/asm/memory.h b/arch/nds32/include/asm/memory.h
index 60efc726b56e..3f4b5eeb5be2 100644
--- a/arch/nds32/include/asm/memory.h
+++ b/arch/nds32/include/asm/memory.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_MEMORY_H
diff --git a/arch/nds32/include/asm/mmu.h b/arch/nds32/include/asm/mmu.h
index 88b9ee8c1064..89d63afee455 100644
--- a/arch/nds32/include/asm/mmu.h
+++ b/arch/nds32/include/asm/mmu.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_MMU_H
diff --git a/arch/nds32/include/asm/mmu_context.h b/arch/nds32/include/asm/mmu_context.h
index fd7d13cefccc..b8fd3d189fdc 100644
--- a/arch/nds32/include/asm/mmu_context.h
+++ b/arch/nds32/include/asm/mmu_context.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_MMU_CONTEXT_H
diff --git a/arch/nds32/include/asm/module.h b/arch/nds32/include/asm/module.h
index 16cf9c7237ad..a3a08e993c65 100644
--- a/arch/nds32/include/asm/module.h
+++ b/arch/nds32/include/asm/module.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASM_NDS32_MODULE_H
diff --git a/arch/nds32/include/asm/nds32.h b/arch/nds32/include/asm/nds32.h
index 68c38151c3e4..4994f6a9e0a0 100644
--- a/arch/nds32/include/asm/nds32.h
+++ b/arch/nds32/include/asm/nds32.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASM_NDS32_NDS32_H_
diff --git a/arch/nds32/include/asm/page.h b/arch/nds32/include/asm/page.h
index 947f0491c9a7..8feb1fa12f01 100644
--- a/arch/nds32/include/asm/page.h
+++ b/arch/nds32/include/asm/page.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * SPDX-License-Identifier: GPL-2.0
  * Copyright (C) 2005-2017 Andes Technology Corporation
  */
 
diff --git a/arch/nds32/include/asm/pgalloc.h b/arch/nds32/include/asm/pgalloc.h
index 3c5fee5b5759..3cbc749c79aa 100644
--- a/arch/nds32/include/asm/pgalloc.h
+++ b/arch/nds32/include/asm/pgalloc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASMNDS32_PGALLOC_H
diff --git a/arch/nds32/include/asm/pgtable.h b/arch/nds32/include/asm/pgtable.h
index ee59c1f9e4fc..c70cc56bec09 100644
--- a/arch/nds32/include/asm/pgtable.h
+++ b/arch/nds32/include/asm/pgtable.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASMNDS32_PGTABLE_H
diff --git a/arch/nds32/include/asm/proc-fns.h b/arch/nds32/include/asm/proc-fns.h
index bedc4f59e064..27c617fa77af 100644
--- a/arch/nds32/include/asm/proc-fns.h
+++ b/arch/nds32/include/asm/proc-fns.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_PROCFNS_H__
diff --git a/arch/nds32/include/asm/processor.h b/arch/nds32/include/asm/processor.h
index 72024f8bc129..b82369c7659d 100644
--- a/arch/nds32/include/asm/processor.h
+++ b/arch/nds32/include/asm/processor.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_PROCESSOR_H
diff --git a/arch/nds32/include/asm/ptrace.h b/arch/nds32/include/asm/ptrace.h
index c4538839055c..919ee223620c 100644
--- a/arch/nds32/include/asm/ptrace.h
+++ b/arch/nds32/include/asm/ptrace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_PTRACE_H
diff --git a/arch/nds32/include/asm/shmparam.h b/arch/nds32/include/asm/shmparam.h
index fd1cff64b68e..3aeee946973d 100644
--- a/arch/nds32/include/asm/shmparam.h
+++ b/arch/nds32/include/asm/shmparam.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASMNDS32_SHMPARAM_H
diff --git a/arch/nds32/include/asm/string.h b/arch/nds32/include/asm/string.h
index 179272caa540..cae8fe16de98 100644
--- a/arch/nds32/include/asm/string.h
+++ b/arch/nds32/include/asm/string.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_STRING_H
diff --git a/arch/nds32/include/asm/swab.h b/arch/nds32/include/asm/swab.h
index e01a755a37d2..362a466f2976 100644
--- a/arch/nds32/include/asm/swab.h
+++ b/arch/nds32/include/asm/swab.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_SWAB_H__
diff --git a/arch/nds32/include/asm/syscall.h b/arch/nds32/include/asm/syscall.h
index 7501e376a6b1..4efbea8324e7 100644
--- a/arch/nds32/include/asm/syscall.h
+++ b/arch/nds32/include/asm/syscall.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2008-2009 Red Hat, Inc.  All rights reserved.
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
diff --git a/arch/nds32/include/asm/syscalls.h b/arch/nds32/include/asm/syscalls.h
index da32101b455d..f3b16f602cb5 100644
--- a/arch/nds32/include/asm/syscalls.h
+++ b/arch/nds32/include/asm/syscalls.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_SYSCALLS_H
diff --git a/arch/nds32/include/asm/thread_info.h b/arch/nds32/include/asm/thread_info.h
index bff741ff337b..3734b1c1cf82 100644
--- a/arch/nds32/include/asm/thread_info.h
+++ b/arch/nds32/include/asm/thread_info.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_THREAD_INFO_H
diff --git a/arch/nds32/include/asm/tlb.h b/arch/nds32/include/asm/tlb.h
index b35ae5eae3ab..0c24cefaba81 100644
--- a/arch/nds32/include/asm/tlb.h
+++ b/arch/nds32/include/asm/tlb.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASMNDS32_TLB_H
diff --git a/arch/nds32/include/asm/tlbflush.h b/arch/nds32/include/asm/tlbflush.h
index 9b411f401903..62e63b891a4a 100644
--- a/arch/nds32/include/asm/tlbflush.h
+++ b/arch/nds32/include/asm/tlbflush.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASMNDS32_TLBFLUSH_H
diff --git a/arch/nds32/include/asm/uaccess.h b/arch/nds32/include/asm/uaccess.h
index 116598b47c4d..8916ad9f9f13 100644
--- a/arch/nds32/include/asm/uaccess.h
+++ b/arch/nds32/include/asm/uaccess.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASMANDES_UACCESS_H
diff --git a/arch/nds32/include/asm/unistd.h b/arch/nds32/include/asm/unistd.h
index b586a2862beb..bf5e2d440913 100644
--- a/arch/nds32/include/asm/unistd.h
+++ b/arch/nds32/include/asm/unistd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/nds32/include/asm/vdso.h b/arch/nds32/include/asm/vdso.h
index af2c6afc2469..89b113ffc3dc 100644
--- a/arch/nds32/include/asm/vdso.h
+++ b/arch/nds32/include/asm/vdso.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * SPDX-License-Identifier: GPL-2.0
  * Copyright (C) 2005-2017 Andes Technology Corporation
  */
 
diff --git a/arch/nds32/include/asm/vdso_datapage.h b/arch/nds32/include/asm/vdso_datapage.h
index 79db5a12ca5e..cd1dda3da0f9 100644
--- a/arch/nds32/include/asm/vdso_datapage.h
+++ b/arch/nds32/include/asm/vdso_datapage.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2012 ARM Limited
 // Copyright (C) 2005-2017 Andes Technology Corporation
 #ifndef __ASM_VDSO_DATAPAGE_H
diff --git a/arch/nds32/include/asm/vdso_timer_info.h b/arch/nds32/include/asm/vdso_timer_info.h
index 50ba117cff12..328439ce37db 100644
--- a/arch/nds32/include/asm/vdso_timer_info.h
+++ b/arch/nds32/include/asm/vdso_timer_info.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 extern struct timer_info_t timer_info;
diff --git a/arch/nds32/include/uapi/asm/auxvec.h b/arch/nds32/include/uapi/asm/auxvec.h
index 2d3213f5e595..b5d58ea8decb 100644
--- a/arch/nds32/include/uapi/asm/auxvec.h
+++ b/arch/nds32/include/uapi/asm/auxvec.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_AUXVEC_H
diff --git a/arch/nds32/include/uapi/asm/byteorder.h b/arch/nds32/include/uapi/asm/byteorder.h
index a23f6f3a2468..511e653c709d 100644
--- a/arch/nds32/include/uapi/asm/byteorder.h
+++ b/arch/nds32/include/uapi/asm/byteorder.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __NDS32_BYTEORDER_H__
diff --git a/arch/nds32/include/uapi/asm/cachectl.h b/arch/nds32/include/uapi/asm/cachectl.h
index 4cdca9b23974..73793662815c 100644
--- a/arch/nds32/include/uapi/asm/cachectl.h
+++ b/arch/nds32/include/uapi/asm/cachectl.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 1994, 1995, 1996 by Ralf Baechle
 // Copyright (C) 2005-2017 Andes Technology Corporation
 #ifndef	_ASM_CACHECTL
diff --git a/arch/nds32/include/uapi/asm/param.h b/arch/nds32/include/uapi/asm/param.h
index e3fb723ee362..2977534a6bd3 100644
--- a/arch/nds32/include/uapi/asm/param.h
+++ b/arch/nds32/include/uapi/asm/param.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __ASM_NDS32_PARAM_H
diff --git a/arch/nds32/include/uapi/asm/ptrace.h b/arch/nds32/include/uapi/asm/ptrace.h
index 358c99e399d0..1a6e01c00e6f 100644
--- a/arch/nds32/include/uapi/asm/ptrace.h
+++ b/arch/nds32/include/uapi/asm/ptrace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef __UAPI_ASM_NDS32_PTRACE_H
diff --git a/arch/nds32/include/uapi/asm/sigcontext.h b/arch/nds32/include/uapi/asm/sigcontext.h
index 58afc416473e..628ff6b75825 100644
--- a/arch/nds32/include/uapi/asm/sigcontext.h
+++ b/arch/nds32/include/uapi/asm/sigcontext.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #ifndef _ASMNDS32_SIGCONTEXT_H
diff --git a/arch/nds32/include/uapi/asm/unistd.h b/arch/nds32/include/uapi/asm/unistd.h
index 4ec8f543103f..c691735017ed 100644
--- a/arch/nds32/include/uapi/asm/unistd.h
+++ b/arch/nds32/include/uapi/asm/unistd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #define __ARCH_WANT_STAT64
diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
index 208b5503f4ed..7de82647e761 100644
--- a/arch/powerpc/include/asm/pnv-ocxl.h
+++ b/arch/powerpc/include/asm/pnv-ocxl.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 // Copyright 2017 IBM Corp.
 #ifndef _ASM_PNV_OCXL_H
 #define _ASM_PNV_OCXL_H
diff --git a/arch/sh/drivers/pci/pci-sh5.h b/arch/sh/drivers/pci/pci-sh5.h
index 91348af0ef6c..0d2c093fd984 100644
--- a/arch/sh/drivers/pci/pci-sh5.h
+++ b/arch/sh/drivers/pci/pci-sh5.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2001 David J. Mckay (david.mckay@st.com)
  *
  * Definitions for the SH5 PCI hardware.
diff --git a/arch/sh/drivers/pci/pci-sh7751.h b/arch/sh/drivers/pci/pci-sh7751.h
index d1951e50effc..9e23cf7113ac 100644
--- a/arch/sh/drivers/pci/pci-sh7751.h
+++ b/arch/sh/drivers/pci/pci-sh7751.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  *	Low-Level PCI Support for SH7751 targets
  *
  *  Dustin McIntire (dustin@sensoria.com) (c) 2001
diff --git a/arch/sh/drivers/pci/pci-sh7780.h b/arch/sh/drivers/pci/pci-sh7780.h
index e2ac770f8e35..7ba87b62e439 100644
--- a/arch/sh/drivers/pci/pci-sh7780.h
+++ b/arch/sh/drivers/pci/pci-sh7780.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  *	Low-Level PCI Support for SH7780 targets
  *
  *  Dustin McIntire (dustin@sensoria.com) (c) 2001
diff --git a/arch/sh/drivers/pci/pcie-sh7786.h b/arch/sh/drivers/pci/pcie-sh7786.h
index ffe383681a0b..c5e2221b6359 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.h
+++ b/arch/sh/drivers/pci/pcie-sh7786.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * SH7786 PCI-Express controller definitions.
  *
  * Copyright (C) 2008, 2009 Renesas Technology Corp.
diff --git a/arch/sh/include/asm/addrspace.h b/arch/sh/include/asm/addrspace.h
index 34bfbcddcce0..c663527cab7c 100644
--- a/arch/sh/include/asm/addrspace.h
+++ b/arch/sh/include/asm/addrspace.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 1999 by Kaz Kojima
  *
  * Defitions for the address spaces of the SH CPUs.
diff --git a/arch/sh/include/asm/bl_bit_64.h b/arch/sh/include/asm/bl_bit_64.h
index aac9780fe864..c6032f194f4c 100644
--- a/arch/sh/include/asm/bl_bit_64.h
+++ b/arch/sh/include/asm/bl_bit_64.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
diff --git a/arch/sh/include/asm/cache_insns_64.h b/arch/sh/include/asm/cache_insns_64.h
index ed682b987b0d..768f18aae612 100644
--- a/arch/sh/include/asm/cache_insns_64.h
+++ b/arch/sh/include/asm/cache_insns_64.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
diff --git a/arch/sh/include/asm/device.h b/arch/sh/include/asm/device.h
index 6f3e686a1c6f..75e0f44f8969 100644
--- a/arch/sh/include/asm/device.h
+++ b/arch/sh/include/asm/device.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Arch specific extensions to struct device
  */
 #ifndef __ASM_SH_DEVICE_H
diff --git a/arch/sh/include/asm/dma-register.h b/arch/sh/include/asm/dma-register.h
index 724dab912b71..96fed7b02b0f 100644
--- a/arch/sh/include/asm/dma-register.h
+++ b/arch/sh/include/asm/dma-register.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Common header for the legacy SH DMA driver and the new dmaengine driver
  *
  * extracted from arch/sh/include/asm/dma-sh.h:
diff --git a/arch/sh/include/asm/dma.h b/arch/sh/include/asm/dma.h
index 4d5a21a891c0..faa1b66b9397 100644
--- a/arch/sh/include/asm/dma.h
+++ b/arch/sh/include/asm/dma.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/dma.h
  *
  * Copyright (C) 2003, 2004  Paul Mundt
diff --git a/arch/sh/include/asm/dwarf.h b/arch/sh/include/asm/dwarf.h
index 571954474122..661d1b9f07d4 100644
--- a/arch/sh/include/asm/dwarf.h
+++ b/arch/sh/include/asm/dwarf.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2009 Matt Fleming <matt@console-pimps.org>
  */
 #ifndef __ASM_SH_DWARF_H
diff --git a/arch/sh/include/asm/fixmap.h b/arch/sh/include/asm/fixmap.h
index e30348c58073..15abcd96f4b2 100644
--- a/arch/sh/include/asm/fixmap.h
+++ b/arch/sh/include/asm/fixmap.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * fixmap.h: compile-time virtual memory allocation
  *
  * Copyright (C) 1998 Ingo Molnar
diff --git a/arch/sh/include/asm/flat.h b/arch/sh/include/asm/flat.h
index 843d458b8329..6adbdfda6951 100644
--- a/arch/sh/include/asm/flat.h
+++ b/arch/sh/include/asm/flat.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/flat.h
  *
  * uClinux flat-format executables
diff --git a/arch/sh/include/asm/freq.h b/arch/sh/include/asm/freq.h
index 18133bf83738..693183a63bfb 100644
--- a/arch/sh/include/asm/freq.h
+++ b/arch/sh/include/asm/freq.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * include/asm-sh/freq.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/asm/gpio.h b/arch/sh/include/asm/gpio.h
index 351918894e86..18319e97a5ec 100644
--- a/arch/sh/include/asm/gpio.h
+++ b/arch/sh/include/asm/gpio.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  *  include/asm-sh/gpio.h
  *
  * Generic GPIO API and pinmux table support for SuperH.
diff --git a/arch/sh/include/asm/machvec.h b/arch/sh/include/asm/machvec.h
index f7d05546beca..76c528b8df83 100644
--- a/arch/sh/include/asm/machvec.h
+++ b/arch/sh/include/asm/machvec.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/machvec.h
  *
  * Copyright 2000 Stuart Menefy (stuart.menefy@st.com)
diff --git a/arch/sh/include/asm/pgtable.h b/arch/sh/include/asm/pgtable.h
index 3587103afe59..daa593d9f81f 100644
--- a/arch/sh/include/asm/pgtable.h
+++ b/arch/sh/include/asm/pgtable.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * This file contains the functions and defines necessary to modify and
  * use the SuperH page table tree.
  *
diff --git a/arch/sh/include/asm/sfp-machine.h b/arch/sh/include/asm/sfp-machine.h
index cbc7cf8c97ce..77b40ceec36c 100644
--- a/arch/sh/include/asm/sfp-machine.h
+++ b/arch/sh/include/asm/sfp-machine.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * Machine-dependent software floating-point definitions.
    SuperH kernel version.
    Copyright (C) 1997,1998,1999 Free Software Foundation, Inc.
diff --git a/arch/sh/include/asm/shmparam.h b/arch/sh/include/asm/shmparam.h
index 6c580a644a78..4a83ec04128a 100644
--- a/arch/sh/include/asm/shmparam.h
+++ b/arch/sh/include/asm/shmparam.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/shmparam.h
  *
  * Copyright (C) 1999 Niibe Yutaka
diff --git a/arch/sh/include/asm/siu.h b/arch/sh/include/asm/siu.h
index 35e4839d381e..1af6844b1f00 100644
--- a/arch/sh/include/asm/siu.h
+++ b/arch/sh/include/asm/siu.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * platform header for the SIU ASoC driver
  *
  * Copyright (C) 2009-2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
diff --git a/arch/sh/include/asm/spinlock-cas.h b/arch/sh/include/asm/spinlock-cas.h
index 3d49985ebf41..c9ed7492dd5d 100644
--- a/arch/sh/include/asm/spinlock-cas.h
+++ b/arch/sh/include/asm/spinlock-cas.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/spinlock-cas.h
  *
  * Copyright (C) 2015 SEI
diff --git a/arch/sh/include/asm/spinlock-llsc.h b/arch/sh/include/asm/spinlock-llsc.h
index 786ee0fde3b0..5508c0d47091 100644
--- a/arch/sh/include/asm/spinlock-llsc.h
+++ b/arch/sh/include/asm/spinlock-llsc.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/spinlock-llsc.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/asm/spinlock.h b/arch/sh/include/asm/spinlock.h
index fa6801f63551..6cc36df2ddd3 100644
--- a/arch/sh/include/asm/spinlock.h
+++ b/arch/sh/include/asm/spinlock.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/spinlock.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/asm/switch_to.h b/arch/sh/include/asm/switch_to.h
index 9eec80ab5aa2..3fe65cf11319 100644
--- a/arch/sh/include/asm/switch_to.h
+++ b/arch/sh/include/asm/switch_to.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
diff --git a/arch/sh/include/asm/switch_to_64.h b/arch/sh/include/asm/switch_to_64.h
index 2dbf2311669f..87a08602f1c9 100644
--- a/arch/sh/include/asm/switch_to_64.h
+++ b/arch/sh/include/asm/switch_to_64.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
diff --git a/arch/sh/include/asm/tlb_64.h b/arch/sh/include/asm/tlb_64.h
index 59fa0a23dad7..dac46f8c5216 100644
--- a/arch/sh/include/asm/tlb_64.h
+++ b/arch/sh/include/asm/tlb_64.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/tlb_64.h
  *
  * Copyright (C) 2003  Paul Mundt
diff --git a/arch/sh/include/asm/traps_64.h b/arch/sh/include/asm/traps_64.h
index f28db6dfbe45..7e5e902d2278 100644
--- a/arch/sh/include/asm/traps_64.h
+++ b/arch/sh/include/asm/traps_64.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
diff --git a/arch/sh/include/asm/watchdog.h b/arch/sh/include/asm/watchdog.h
index cecd0fc507f9..6f64666186c2 100644
--- a/arch/sh/include/asm/watchdog.h
+++ b/arch/sh/include/asm/watchdog.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * include/asm-sh/watchdog.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/cpu-common/cpu/addrspace.h b/arch/sh/include/cpu-common/cpu/addrspace.h
index d8bf5d7d2fdf..2c0f54e68bb2 100644
--- a/arch/sh/include/cpu-common/cpu/addrspace.h
+++ b/arch/sh/include/cpu-common/cpu/addrspace.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Definitions for the address spaces of the SH-2 CPUs.
  *
  * Copyright (C) 2003  Paul Mundt
diff --git a/arch/sh/include/cpu-common/cpu/mmu_context.h b/arch/sh/include/cpu-common/cpu/mmu_context.h
index cef3a30dbf97..0f2602e1c963 100644
--- a/arch/sh/include/cpu-common/cpu/mmu_context.h
+++ b/arch/sh/include/cpu-common/cpu/mmu_context.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh2/mmu_context.h
  *
  * Copyright (C) 2003  Paul Mundt
diff --git a/arch/sh/include/cpu-common/cpu/pfc.h b/arch/sh/include/cpu-common/cpu/pfc.h
index 879d2c9da537..8ca16923cc40 100644
--- a/arch/sh/include/cpu-common/cpu/pfc.h
+++ b/arch/sh/include/cpu-common/cpu/pfc.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * SH Pin Function Control Initialization
  *
  * Copyright (C) 2012  Renesas Solutions Corp.
diff --git a/arch/sh/include/cpu-sh2/cpu/cache.h b/arch/sh/include/cpu-sh2/cpu/cache.h
index 070aa9f50d3f..9508876fede0 100644
--- a/arch/sh/include/cpu-sh2/cpu/cache.h
+++ b/arch/sh/include/cpu-sh2/cpu/cache.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh2/cache.h
  *
  * Copyright (C) 2003 Paul Mundt
diff --git a/arch/sh/include/cpu-sh2/cpu/freq.h b/arch/sh/include/cpu-sh2/cpu/freq.h
index fb2e5d2831bc..a598fba55059 100644
--- a/arch/sh/include/cpu-sh2/cpu/freq.h
+++ b/arch/sh/include/cpu-sh2/cpu/freq.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh2/freq.h
  *
  * Copyright (C) 2006  Yoshinori Sato
diff --git a/arch/sh/include/cpu-sh2/cpu/watchdog.h b/arch/sh/include/cpu-sh2/cpu/watchdog.h
index 141fe296d751..ef3941c3b726 100644
--- a/arch/sh/include/cpu-sh2/cpu/watchdog.h
+++ b/arch/sh/include/cpu-sh2/cpu/watchdog.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh2/watchdog.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/cpu-sh2a/cpu/cache.h b/arch/sh/include/cpu-sh2a/cpu/cache.h
index 06efb233eb35..259e4cbc4131 100644
--- a/arch/sh/include/cpu-sh2a/cpu/cache.h
+++ b/arch/sh/include/cpu-sh2a/cpu/cache.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh2a/cache.h
  *
  * Copyright (C) 2004 Paul Mundt
diff --git a/arch/sh/include/cpu-sh2a/cpu/freq.h b/arch/sh/include/cpu-sh2a/cpu/freq.h
index fb0813f47043..a637324e0f43 100644
--- a/arch/sh/include/cpu-sh2a/cpu/freq.h
+++ b/arch/sh/include/cpu-sh2a/cpu/freq.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh2a/freq.h
  *
  * Copyright (C) 2006  Yoshinori Sato
diff --git a/arch/sh/include/cpu-sh3/cpu/cache.h b/arch/sh/include/cpu-sh3/cpu/cache.h
index f57124826943..99f53e41e781 100644
--- a/arch/sh/include/cpu-sh3/cpu/cache.h
+++ b/arch/sh/include/cpu-sh3/cpu/cache.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh3/cache.h
  *
  * Copyright (C) 1999 Niibe Yutaka
diff --git a/arch/sh/include/cpu-sh3/cpu/dma-register.h b/arch/sh/include/cpu-sh3/cpu/dma-register.h
index c0f921fb4edc..efc3632756bf 100644
--- a/arch/sh/include/cpu-sh3/cpu/dma-register.h
+++ b/arch/sh/include/cpu-sh3/cpu/dma-register.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * SH3 CPU-specific DMA definitions, used by both DMA drivers
  *
  * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
diff --git a/arch/sh/include/cpu-sh3/cpu/freq.h b/arch/sh/include/cpu-sh3/cpu/freq.h
index 7290f02b7173..5968337d7e84 100644
--- a/arch/sh/include/cpu-sh3/cpu/freq.h
+++ b/arch/sh/include/cpu-sh3/cpu/freq.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh3/freq.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/cpu-sh3/cpu/gpio.h b/arch/sh/include/cpu-sh3/cpu/gpio.h
index aeb0588ace98..391d55f4b689 100644
--- a/arch/sh/include/cpu-sh3/cpu/gpio.h
+++ b/arch/sh/include/cpu-sh3/cpu/gpio.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  *  include/asm-sh/cpu-sh3/gpio.h
  *
  *  Copyright (C) 2007  Markus Brunner, Mark Jonas
diff --git a/arch/sh/include/cpu-sh3/cpu/mmu_context.h b/arch/sh/include/cpu-sh3/cpu/mmu_context.h
index ead9a6f72113..45a3ac26a6c5 100644
--- a/arch/sh/include/cpu-sh3/cpu/mmu_context.h
+++ b/arch/sh/include/cpu-sh3/cpu/mmu_context.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh3/mmu_context.h
  *
  * Copyright (C) 1999 Niibe Yutaka
diff --git a/arch/sh/include/cpu-sh3/cpu/watchdog.h b/arch/sh/include/cpu-sh3/cpu/watchdog.h
index 9d7e9d986809..406f770f956a 100644
--- a/arch/sh/include/cpu-sh3/cpu/watchdog.h
+++ b/arch/sh/include/cpu-sh3/cpu/watchdog.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh3/watchdog.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/cpu-sh4/cpu/addrspace.h b/arch/sh/include/cpu-sh4/cpu/addrspace.h
index f006c9489f5a..92a6e0348e70 100644
--- a/arch/sh/include/cpu-sh4/cpu/addrspace.h
+++ b/arch/sh/include/cpu-sh4/cpu/addrspace.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 1999 by Kaz Kojima
  *
  * Defitions for the address spaces of the SH-4 CPUs.
diff --git a/arch/sh/include/cpu-sh4/cpu/cache.h b/arch/sh/include/cpu-sh4/cpu/cache.h
index 72b4d13da127..a2a0f2739ce4 100644
--- a/arch/sh/include/cpu-sh4/cpu/cache.h
+++ b/arch/sh/include/cpu-sh4/cpu/cache.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh4/cache.h
  *
  * Copyright (C) 1999 Niibe Yutaka
diff --git a/arch/sh/include/cpu-sh4/cpu/dma-register.h b/arch/sh/include/cpu-sh4/cpu/dma-register.h
index 53f7ab990d88..4a284e70a757 100644
--- a/arch/sh/include/cpu-sh4/cpu/dma-register.h
+++ b/arch/sh/include/cpu-sh4/cpu/dma-register.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * SH4 CPU-specific DMA definitions, used by both DMA drivers
  *
  * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
diff --git a/arch/sh/include/cpu-sh4/cpu/fpu.h b/arch/sh/include/cpu-sh4/cpu/fpu.h
index 29f451bfef19..7722f23b6118 100644
--- a/arch/sh/include/cpu-sh4/cpu/fpu.h
+++ b/arch/sh/include/cpu-sh4/cpu/fpu.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * linux/arch/sh/kernel/cpu/sh4/sh4_fpu.h
  *
  * Copyright (C) 2006 STMicroelectronics Limited
diff --git a/arch/sh/include/cpu-sh4/cpu/freq.h b/arch/sh/include/cpu-sh4/cpu/freq.h
index 662f0f30e106..5d9cdaa0c4ba 100644
--- a/arch/sh/include/cpu-sh4/cpu/freq.h
+++ b/arch/sh/include/cpu-sh4/cpu/freq.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh4/freq.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/cpu-sh4/cpu/mmu_context.h b/arch/sh/include/cpu-sh4/cpu/mmu_context.h
index 421b56d5c595..df5335e9e80f 100644
--- a/arch/sh/include/cpu-sh4/cpu/mmu_context.h
+++ b/arch/sh/include/cpu-sh4/cpu/mmu_context.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh4/mmu_context.h
  *
  * Copyright (C) 1999 Niibe Yutaka
diff --git a/arch/sh/include/cpu-sh4/cpu/sh7786.h b/arch/sh/include/cpu-sh4/cpu/sh7786.h
index 8f9bfbf3cdb1..4af6e5a2cd97 100644
--- a/arch/sh/include/cpu-sh4/cpu/sh7786.h
+++ b/arch/sh/include/cpu-sh4/cpu/sh7786.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * SH7786 Pinmux
  *
  * Copyright (C) 2008, 2009  Renesas Solutions Corp.
diff --git a/arch/sh/include/cpu-sh4/cpu/sq.h b/arch/sh/include/cpu-sh4/cpu/sq.h
index 81966e41fc21..91f6b1022e5f 100644
--- a/arch/sh/include/cpu-sh4/cpu/sq.h
+++ b/arch/sh/include/cpu-sh4/cpu/sq.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh4/sq.h
  *
  * Copyright (C) 2001, 2002, 2003  Paul Mundt
diff --git a/arch/sh/include/cpu-sh4/cpu/watchdog.h b/arch/sh/include/cpu-sh4/cpu/watchdog.h
index fa7bcb398b8c..5190f7a8ed99 100644
--- a/arch/sh/include/cpu-sh4/cpu/watchdog.h
+++ b/arch/sh/include/cpu-sh4/cpu/watchdog.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh4/watchdog.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/mach-common/mach/hp6xx.h b/arch/sh/include/mach-common/mach/hp6xx.h
index 71241f0d02a1..10e8c4cf2247 100644
--- a/arch/sh/include/mach-common/mach/hp6xx.h
+++ b/arch/sh/include/mach-common/mach/hp6xx.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2003, 2004, 2005  Andriy Skulysh
  */
 #ifndef __ASM_SH_HP6XX_H
diff --git a/arch/sh/include/mach-common/mach/magicpanelr2.h b/arch/sh/include/mach-common/mach/magicpanelr2.h
index c2d218cea74b..ee8a76c4e21f 100644
--- a/arch/sh/include/mach-common/mach/magicpanelr2.h
+++ b/arch/sh/include/mach-common/mach/magicpanelr2.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  *  include/asm-sh/magicpanelr2.h
  *
  *  Copyright (C) 2007  Markus Brunner, Mark Jonas
diff --git a/arch/sh/include/mach-common/mach/mangle-port.h b/arch/sh/include/mach-common/mach/mangle-port.h
index dd5a761a52ee..3cca842fd1d2 100644
--- a/arch/sh/include/mach-common/mach/mangle-port.h
+++ b/arch/sh/include/mach-common/mach/mangle-port.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * SH version cribbed from the MIPS copy:
  *
  * Copyright (C) 2003, 2004 Ralf Baechle
diff --git a/arch/sh/include/mach-common/mach/microdev.h b/arch/sh/include/mach-common/mach/microdev.h
index 0e2f9ab11976..38c4120bf439 100644
--- a/arch/sh/include/mach-common/mach/microdev.h
+++ b/arch/sh/include/mach-common/mach/microdev.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * linux/include/asm-sh/microdev.h
  *
  * Copyright (C) 2003 Sean McGoogan (Sean.McGoogan@superh.com)
diff --git a/arch/sh/include/mach-common/mach/secureedge5410.h b/arch/sh/include/mach-common/mach/secureedge5410.h
index dfc68aa91003..d0be04b6cd38 100644
--- a/arch/sh/include/mach-common/mach/secureedge5410.h
+++ b/arch/sh/include/mach-common/mach/secureedge5410.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/snapgear.h
  *
  * Modified version of io_se.h for the snapgear-specific functions.
diff --git a/arch/sh/include/mach-dreamcast/mach/dma.h b/arch/sh/include/mach-dreamcast/mach/dma.h
index a773a763843a..40537ca3c110 100644
--- a/arch/sh/include/mach-dreamcast/mach/dma.h
+++ b/arch/sh/include/mach-dreamcast/mach/dma.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/dreamcast/dma.h
  *
  * Copyright (C) 2003 Paul Mundt
diff --git a/arch/sh/include/mach-dreamcast/mach/pci.h b/arch/sh/include/mach-dreamcast/mach/pci.h
index c037c1ec63a9..fec7f8aa9c5b 100644
--- a/arch/sh/include/mach-dreamcast/mach/pci.h
+++ b/arch/sh/include/mach-dreamcast/mach/pci.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/dreamcast/pci.h
  *
  * Copyright (C) 2001, 2002  M. R. Brown
diff --git a/arch/sh/include/mach-dreamcast/mach/sysasic.h b/arch/sh/include/mach-dreamcast/mach/sysasic.h
index ed69ce7f2030..03daca6ea92b 100644
--- a/arch/sh/include/mach-dreamcast/mach/sysasic.h
+++ b/arch/sh/include/mach-dreamcast/mach/sysasic.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/dreamcast/sysasic.h
  *
  * Definitions for the Dreamcast System ASIC and related peripherals.
diff --git a/arch/sh/include/mach-se/mach/se7721.h b/arch/sh/include/mach-se/mach/se7721.h
index 82226d40faf5..b1940b6f9649 100644
--- a/arch/sh/include/mach-se/mach/se7721.h
+++ b/arch/sh/include/mach-se/mach/se7721.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2008 Renesas Solutions Corp.
  *
  * Hitachi UL SolutionEngine 7721 Support.
diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 29c706415443..84006ca0f17a 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #ifndef _ASM_X86_CPU_ENTRY_AREA_H
 #define _ASM_X86_CPU_ENTRY_AREA_H
diff --git a/arch/x86/include/asm/pti.h b/arch/x86/include/asm/pti.h
index 5df09a0b80b8..07375b476c4f 100644
--- a/arch/x86/include/asm/pti.h
+++ b/arch/x86/include/asm/pti.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_X86_PTI_H
 #define _ASM_X86_PTI_H
 #ifndef __ASSEMBLY__
diff --git a/arch/x86/kernel/process.h b/arch/x86/kernel/process.h
index 320ab978fb1f..1d0797b2338a 100644
--- a/arch/x86/kernel/process.h
+++ b/arch/x86/kernel/process.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 //
 // Code shared between 32 and 64 bit
 
-- 
2.17.1

