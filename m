Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFC7C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 16:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEF420718
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 16:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="tHqA6coZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfKQQJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 11:09:38 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39211 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfKQQJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 11:09:37 -0500
Received: by mail-io1-f66.google.com with SMTP id k1so15938502ioj.6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 08:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZYFZzVolQGXDRRhvmqGFSl2s9aRxmhWlwGW6axEadDY=;
        b=tHqA6coZGaKNYl4wpP/GrN8rOdb77VKQS+5R0FsCOA+60G2NHGZOYxq2py1QIq/Q9Z
         mYj5NiZMnwFuWAQ7MhdROb+KMOcXY33rAIONxRXVijsKuizaMJT6Un7zgo5OzPblCnFV
         lIHJvPtqAhXGxjOxhmN0mBelPxRR5fypyp/Q1mMLRaP/8NNhgjm3RlKYtpMnf871aP46
         JpkplOcTCectMCM5LZ+m1cCGnhvzoJrwHa3QMfPyxnRmRTKEyekI0zG7BPxdHW6I9tBf
         k7AarUWC63w857ryF416RpNKzNaUL6hToDS3W3TRQ8ZKRcegVCzS+fhmLQjZuKIZcfb/
         PaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZYFZzVolQGXDRRhvmqGFSl2s9aRxmhWlwGW6axEadDY=;
        b=e5cy+cBEAt0fYqO7w3X90xXrWn0pUpgRe1DJLogIwyZVX0ncpqDdctdPMV9Eo1KUFH
         Il8kjMnQ4bsl6QMEU2J4q4ysiI9uX2+XMKmVTodH984ntM2xT21Si3PIOVOutYCGE5cn
         8kEPLrfl8WEElYBi2K5OxOUZ7j4hAhUY3Afm766RE22tc3tiRPWd6I4fsheYuzHhMLUG
         VEr5uToyfKVX6lK/aXPq19qO7WM7eJ/Sh/wmQVH0+S3+H/zxuPycTQz3BkmfS6iG9hWy
         ZgTr+0L1YeKWkiPhaZ2oZNujkzRDH143kntsmQy4kYF+exfxt7VRi4l2/am+1NR+IDVf
         /HiA==
X-Gm-Message-State: APjAAAXHBEpFmt2AgTgTXl/6/gEygfNOlsgGhoiNK/OdR6Wp1OWV+jGF
        JF9WZrGavvMICF/R+5qTs8xtCKwb9Vlz6i6wXGqERA==
X-Google-Smtp-Source: APXvYqyf4FgXXGDC5ZqRd4t9PAxaHbhP1WWOc4LAyT/HiGqrWd+qRgIorIQv/FvhSAXZD80l+94g6LpzzfapadE1RiY=
X-Received: by 2002:a02:a38f:: with SMTP id y15mr9648169jak.101.1574006974600;
 Sun, 17 Nov 2019 08:09:34 -0800 (PST)
MIME-Version: 1.0
References: <20191113071836.21041-1-hch@lst.de> <20191113071836.21041-2-hch@lst.de>
In-Reply-To: <20191113071836.21041-2-hch@lst.de>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Sun, 17 Nov 2019 11:09:23 -0500
Message-ID: <CAPoiz9zL2JO79q5BkN-yPnqVXCK_Y08AeUZ5bK9BpXheqRu38w@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: Remove the calgary IOMMU driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     Muli Ben-Yehuda <mulix@mulix.org>, x86@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 2:18 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The calgary IOMMU was only used on high-end IBM systems in the early
> x86_64 age and has no known users left.  Remove it to avoid having to
> touch it for pending changes to the DMA API.

I think you should also remove
arch/x86/include/asm/rio.h
As the only user I could find of that file was the Calgary driver (and
the only real different between this patch and the one I had queued).

Acked-by: Jon Mason <jdmason@kudzu.us>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  MAINTAINERS                       |   10 -
>  arch/x86/Kconfig                  |   30 -
>  arch/x86/configs/x86_64_defconfig |    1 -
>  arch/x86/include/asm/calgary.h    |   57 --
>  arch/x86/include/asm/pci_64.h     |   14 -
>  arch/x86/include/asm/tce.h        |   35 -
>  arch/x86/kernel/Makefile          |    1 -
>  arch/x86/kernel/pci-calgary_64.c  | 1586 -----------------------------
>  arch/x86/kernel/pci-dma.c         |    6 -
>  arch/x86/kernel/tce_64.c          |  177 ----
>  10 files changed, 1917 deletions(-)
>  delete mode 100644 arch/x86/include/asm/calgary.h
>  delete mode 100644 arch/x86/include/asm/tce.h
>  delete mode 100644 arch/x86/kernel/pci-calgary_64.c
>  delete mode 100644 arch/x86/kernel/tce_64.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eb19fad370d7..778e8dee3e9d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3627,16 +3627,6 @@ L:       cake@lists.bufferbloat.net (moderated for non-subscribers)
>  S:     Maintained
>  F:     net/sched/sch_cake.c
>
> -CALGARY x86-64 IOMMU
> -M:     Muli Ben-Yehuda <mulix@mulix.org>
> -M:     Jon Mason <jdmason@kudzu.us>
> -L:     iommu@lists.linux-foundation.org
> -S:     Maintained
> -F:     arch/x86/kernel/pci-calgary_64.c
> -F:     arch/x86/kernel/tce_64.c
> -F:     arch/x86/include/asm/calgary.h
> -F:     arch/x86/include/asm/tce.h
> -
>  CAN NETWORK DRIVERS
>  M:     Wolfgang Grandegger <wg@grandegger.com>
>  M:     Marc Kleine-Budde <mkl@pengutronix.de>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index d6e1faa28c58..4d27bdc85bf2 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -932,36 +932,6 @@ config GART_IOMMU
>
>           If unsure, say Y.
>
> -config CALGARY_IOMMU
> -       bool "IBM Calgary IOMMU support"
> -       select IOMMU_HELPER
> -       select SWIOTLB
> -       depends on X86_64 && PCI
> -       ---help---
> -         Support for hardware IOMMUs in IBM's xSeries x366 and x460
> -         systems. Needed to run systems with more than 3GB of memory
> -         properly with 32-bit PCI devices that do not support DAC
> -         (Double Address Cycle). Calgary also supports bus level
> -         isolation, where all DMAs pass through the IOMMU.  This
> -         prevents them from going anywhere except their intended
> -         destination. This catches hard-to-find kernel bugs and
> -         mis-behaving drivers and devices that do not use the DMA-API
> -         properly to set up their DMA buffers.  The IOMMU can be
> -         turned off at boot time with the iommu=off parameter.
> -         Normally the kernel will make the right choice by itself.
> -         If unsure, say Y.
> -
> -config CALGARY_IOMMU_ENABLED_BY_DEFAULT
> -       def_bool y
> -       prompt "Should Calgary be enabled by default?"
> -       depends on CALGARY_IOMMU
> -       ---help---
> -         Should Calgary be enabled by default? if you choose 'y', Calgary
> -         will be used (if it exists). If you choose 'n', Calgary will not be
> -         used even if it exists. If you choose 'n' and would like to use
> -         Calgary anyway, pass 'iommu=calgary' on the kernel command line.
> -         If unsure, say Y.
> -
>  config MAXSMP
>         bool "Enable Maximum number of SMP Processors and NUMA Nodes"
>         depends on X86_64 && SMP && DEBUG_KERNEL
> diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
> index d0a5ffeae8df..0b9654c7a05c 100644
> --- a/arch/x86/configs/x86_64_defconfig
> +++ b/arch/x86/configs/x86_64_defconfig
> @@ -25,7 +25,6 @@ CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
>  CONFIG_MODULE_FORCE_UNLOAD=y
>  CONFIG_SMP=y
> -CONFIG_CALGARY_IOMMU=y
>  CONFIG_NR_CPUS=64
>  CONFIG_SCHED_SMT=y
>  CONFIG_PREEMPT_VOLUNTARY=y
> diff --git a/arch/x86/include/asm/calgary.h b/arch/x86/include/asm/calgary.h
> deleted file mode 100644
> index facd374a1bf7..000000000000
> --- a/arch/x86/include/asm/calgary.h
> +++ /dev/null
> @@ -1,57 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * Derived from include/asm-powerpc/iommu.h
> - *
> - * Copyright IBM Corporation, 2006-2007
> - *
> - * Author: Jon Mason <jdmason@us.ibm.com>
> - * Author: Muli Ben-Yehuda <muli@il.ibm.com>
> - */
> -
> -#ifndef _ASM_X86_CALGARY_H
> -#define _ASM_X86_CALGARY_H
> -
> -#include <linux/spinlock.h>
> -#include <linux/device.h>
> -#include <linux/dma-mapping.h>
> -#include <linux/timer.h>
> -#include <asm/types.h>
> -
> -struct iommu_table {
> -       const struct cal_chipset_ops *chip_ops; /* chipset specific funcs */
> -       unsigned long  it_base;      /* mapped address of tce table */
> -       unsigned long  it_hint;      /* Hint for next alloc */
> -       unsigned long *it_map;       /* A simple allocation bitmap for now */
> -       void __iomem  *bbar;         /* Bridge BAR */
> -       u64            tar_val;      /* Table Address Register */
> -       struct timer_list watchdog_timer;
> -       spinlock_t     it_lock;      /* Protects it_map */
> -       unsigned int   it_size;      /* Size of iommu table in entries */
> -       unsigned char  it_busno;     /* Bus number this table belongs to */
> -};
> -
> -struct cal_chipset_ops {
> -       void (*handle_quirks)(struct iommu_table *tbl, struct pci_dev *dev);
> -       void (*tce_cache_blast)(struct iommu_table *tbl);
> -       void (*dump_error_regs)(struct iommu_table *tbl);
> -};
> -
> -#define TCE_TABLE_SIZE_UNSPECIFIED     ~0
> -#define TCE_TABLE_SIZE_64K             0
> -#define TCE_TABLE_SIZE_128K            1
> -#define TCE_TABLE_SIZE_256K            2
> -#define TCE_TABLE_SIZE_512K            3
> -#define TCE_TABLE_SIZE_1M              4
> -#define TCE_TABLE_SIZE_2M              5
> -#define TCE_TABLE_SIZE_4M              6
> -#define TCE_TABLE_SIZE_8M              7
> -
> -extern int use_calgary;
> -
> -#ifdef CONFIG_CALGARY_IOMMU
> -extern int detect_calgary(void);
> -#else
> -static inline int detect_calgary(void) { return -ENODEV; }
> -#endif
> -
> -#endif /* _ASM_X86_CALGARY_H */
> diff --git a/arch/x86/include/asm/pci_64.h b/arch/x86/include/asm/pci_64.h
> index f5411de0ae11..4e1aef506aa5 100644
> --- a/arch/x86/include/asm/pci_64.h
> +++ b/arch/x86/include/asm/pci_64.h
> @@ -4,20 +4,6 @@
>
>  #ifdef __KERNEL__
>
> -#ifdef CONFIG_CALGARY_IOMMU
> -static inline void *pci_iommu(struct pci_bus *bus)
> -{
> -       struct pci_sysdata *sd = bus->sysdata;
> -       return sd->iommu;
> -}
> -
> -static inline void set_pci_iommu(struct pci_bus *bus, void *val)
> -{
> -       struct pci_sysdata *sd = bus->sysdata;
> -       sd->iommu = val;
> -}
> -#endif /* CONFIG_CALGARY_IOMMU */
> -
>  extern int (*pci_config_read)(int seg, int bus, int dev, int fn,
>                               int reg, int len, u32 *value);
>  extern int (*pci_config_write)(int seg, int bus, int dev, int fn,
> diff --git a/arch/x86/include/asm/tce.h b/arch/x86/include/asm/tce.h
> deleted file mode 100644
> index 6ed2deacf1d0..000000000000
> --- a/arch/x86/include/asm/tce.h
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * This file is derived from asm-powerpc/tce.h.
> - *
> - * Copyright (C) IBM Corporation, 2006
> - *
> - * Author: Muli Ben-Yehuda <muli@il.ibm.com>
> - * Author: Jon Mason <jdmason@us.ibm.com>
> - */
> -
> -#ifndef _ASM_X86_TCE_H
> -#define _ASM_X86_TCE_H
> -
> -extern unsigned int specified_table_size;
> -struct iommu_table;
> -
> -#define TCE_ENTRY_SIZE   8   /* in bytes */
> -
> -#define TCE_READ_SHIFT   0
> -#define TCE_WRITE_SHIFT  1
> -#define TCE_HUBID_SHIFT  2   /* unused */
> -#define TCE_RSVD_SHIFT   8   /* unused */
> -#define TCE_RPN_SHIFT    12
> -#define TCE_UNUSED_SHIFT 48  /* unused */
> -
> -#define TCE_RPN_MASK     0x0000fffffffff000ULL
> -
> -extern void tce_build(struct iommu_table *tbl, unsigned long index,
> -                     unsigned int npages, unsigned long uaddr, int direction);
> -extern void tce_free(struct iommu_table *tbl, long index, unsigned int npages);
> -extern void * __init alloc_tce_table(void);
> -extern void __init free_tce_table(void *tbl);
> -extern int __init build_tce_table(struct pci_dev *dev, void __iomem *bbar);
> -
> -#endif /* _ASM_X86_TCE_H */
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 3578ad248bc9..1167a46e2a30 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -146,7 +146,6 @@ ifeq ($(CONFIG_X86_64),y)
>         obj-$(CONFIG_AUDIT)             += audit_64.o
>
>         obj-$(CONFIG_GART_IOMMU)        += amd_gart_64.o aperture_64.o
> -       obj-$(CONFIG_CALGARY_IOMMU)     += pci-calgary_64.o tce_64.o
>
>         obj-$(CONFIG_MMCONF_FAM10H)     += mmconf-fam10h_64.o
>         obj-y                           += vsmp_64.o
> diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-calgary_64.c
> deleted file mode 100644
> index 23fdec030c37..000000000000
> --- a/arch/x86/kernel/pci-calgary_64.c
> +++ /dev/null
> @@ -1,1586 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Derived from arch/powerpc/kernel/iommu.c
> - *
> - * Copyright IBM Corporation, 2006-2007
> - * Copyright (C) 2006  Jon Mason <jdmason@kudzu.us>
> - *
> - * Author: Jon Mason <jdmason@kudzu.us>
> - * Author: Muli Ben-Yehuda <muli@il.ibm.com>
> -
> - */
> -
> -#define pr_fmt(fmt) "Calgary: " fmt
> -
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/types.h>
> -#include <linux/slab.h>
> -#include <linux/mm.h>
> -#include <linux/spinlock.h>
> -#include <linux/string.h>
> -#include <linux/crash_dump.h>
> -#include <linux/dma-mapping.h>
> -#include <linux/dma-direct.h>
> -#include <linux/bitmap.h>
> -#include <linux/pci_ids.h>
> -#include <linux/pci.h>
> -#include <linux/delay.h>
> -#include <linux/scatterlist.h>
> -#include <linux/iommu-helper.h>
> -
> -#include <asm/iommu.h>
> -#include <asm/calgary.h>
> -#include <asm/tce.h>
> -#include <asm/pci-direct.h>
> -#include <asm/dma.h>
> -#include <asm/rio.h>
> -#include <asm/bios_ebda.h>
> -#include <asm/x86_init.h>
> -#include <asm/iommu_table.h>
> -
> -#ifdef CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT
> -int use_calgary __read_mostly = 1;
> -#else
> -int use_calgary __read_mostly = 0;
> -#endif /* CONFIG_CALGARY_DEFAULT_ENABLED */
> -
> -#define PCI_DEVICE_ID_IBM_CALGARY 0x02a1
> -#define PCI_DEVICE_ID_IBM_CALIOC2 0x0308
> -
> -/* register offsets inside the host bridge space */
> -#define CALGARY_CONFIG_REG     0x0108
> -#define PHB_CSR_OFFSET         0x0110 /* Channel Status */
> -#define PHB_PLSSR_OFFSET       0x0120
> -#define PHB_CONFIG_RW_OFFSET   0x0160
> -#define PHB_IOBASE_BAR_LOW     0x0170
> -#define PHB_IOBASE_BAR_HIGH    0x0180
> -#define PHB_MEM_1_LOW          0x0190
> -#define PHB_MEM_1_HIGH         0x01A0
> -#define PHB_IO_ADDR_SIZE       0x01B0
> -#define PHB_MEM_1_SIZE         0x01C0
> -#define PHB_MEM_ST_OFFSET      0x01D0
> -#define PHB_AER_OFFSET         0x0200
> -#define PHB_CONFIG_0_HIGH      0x0220
> -#define PHB_CONFIG_0_LOW       0x0230
> -#define PHB_CONFIG_0_END       0x0240
> -#define PHB_MEM_2_LOW          0x02B0
> -#define PHB_MEM_2_HIGH         0x02C0
> -#define PHB_MEM_2_SIZE_HIGH    0x02D0
> -#define PHB_MEM_2_SIZE_LOW     0x02E0
> -#define PHB_DOSHOLE_OFFSET     0x08E0
> -
> -/* CalIOC2 specific */
> -#define PHB_SAVIOR_L2          0x0DB0
> -#define PHB_PAGE_MIG_CTRL      0x0DA8
> -#define PHB_PAGE_MIG_DEBUG     0x0DA0
> -#define PHB_ROOT_COMPLEX_STATUS 0x0CB0
> -
> -/* PHB_CONFIG_RW */
> -#define PHB_TCE_ENABLE         0x20000000
> -#define PHB_SLOT_DISABLE       0x1C000000
> -#define PHB_DAC_DISABLE                0x01000000
> -#define PHB_MEM2_ENABLE                0x00400000
> -#define PHB_MCSR_ENABLE                0x00100000
> -/* TAR (Table Address Register) */
> -#define TAR_SW_BITS            0x0000ffffffff800fUL
> -#define TAR_VALID              0x0000000000000008UL
> -/* CSR (Channel/DMA Status Register) */
> -#define CSR_AGENT_MASK         0xffe0ffff
> -/* CCR (Calgary Configuration Register) */
> -#define CCR_2SEC_TIMEOUT       0x000000000000000EUL
> -/* PMCR/PMDR (Page Migration Control/Debug Registers */
> -#define PMR_SOFTSTOP           0x80000000
> -#define PMR_SOFTSTOPFAULT      0x40000000
> -#define PMR_HARDSTOP           0x20000000
> -
> -/*
> - * The maximum PHB bus number.
> - * x3950M2 (rare): 8 chassis, 48 PHBs per chassis = 384
> - * x3950M2: 4 chassis, 48 PHBs per chassis        = 192
> - * x3950 (PCIE): 8 chassis, 32 PHBs per chassis   = 256
> - * x3950 (PCIX): 8 chassis, 16 PHBs per chassis   = 128
> - */
> -#define MAX_PHB_BUS_NUM                256
> -
> -#define PHBS_PER_CALGARY         4
> -
> -/* register offsets in Calgary's internal register space */
> -static const unsigned long tar_offsets[] = {
> -       0x0580 /* TAR0 */,
> -       0x0588 /* TAR1 */,
> -       0x0590 /* TAR2 */,
> -       0x0598 /* TAR3 */
> -};
> -
> -static const unsigned long split_queue_offsets[] = {
> -       0x4870 /* SPLIT QUEUE 0 */,
> -       0x5870 /* SPLIT QUEUE 1 */,
> -       0x6870 /* SPLIT QUEUE 2 */,
> -       0x7870 /* SPLIT QUEUE 3 */
> -};
> -
> -static const unsigned long phb_offsets[] = {
> -       0x8000 /* PHB0 */,
> -       0x9000 /* PHB1 */,
> -       0xA000 /* PHB2 */,
> -       0xB000 /* PHB3 */
> -};
> -
> -/* PHB debug registers */
> -
> -static const unsigned long phb_debug_offsets[] = {
> -       0x4000  /* PHB 0 DEBUG */,
> -       0x5000  /* PHB 1 DEBUG */,
> -       0x6000  /* PHB 2 DEBUG */,
> -       0x7000  /* PHB 3 DEBUG */
> -};
> -
> -/*
> - * STUFF register for each debug PHB,
> - * byte 1 = start bus number, byte 2 = end bus number
> - */
> -
> -#define PHB_DEBUG_STUFF_OFFSET 0x0020
> -
> -unsigned int specified_table_size = TCE_TABLE_SIZE_UNSPECIFIED;
> -static int translate_empty_slots __read_mostly = 0;
> -static int calgary_detected __read_mostly = 0;
> -
> -static struct rio_table_hdr    *rio_table_hdr __initdata;
> -static struct scal_detail      *scal_devs[MAX_NUMNODES] __initdata;
> -static struct rio_detail       *rio_devs[MAX_NUMNODES * 4] __initdata;
> -
> -struct calgary_bus_info {
> -       void *tce_space;
> -       unsigned char translation_disabled;
> -       signed char phbid;
> -       void __iomem *bbar;
> -};
> -
> -static void calgary_handle_quirks(struct iommu_table *tbl, struct pci_dev *dev);
> -static void calgary_tce_cache_blast(struct iommu_table *tbl);
> -static void calgary_dump_error_regs(struct iommu_table *tbl);
> -static void calioc2_handle_quirks(struct iommu_table *tbl, struct pci_dev *dev);
> -static void calioc2_tce_cache_blast(struct iommu_table *tbl);
> -static void calioc2_dump_error_regs(struct iommu_table *tbl);
> -static void calgary_init_bitmap_from_tce_table(struct iommu_table *tbl);
> -static void get_tce_space_from_tar(void);
> -
> -static const struct cal_chipset_ops calgary_chip_ops = {
> -       .handle_quirks = calgary_handle_quirks,
> -       .tce_cache_blast = calgary_tce_cache_blast,
> -       .dump_error_regs = calgary_dump_error_regs
> -};
> -
> -static const struct cal_chipset_ops calioc2_chip_ops = {
> -       .handle_quirks = calioc2_handle_quirks,
> -       .tce_cache_blast = calioc2_tce_cache_blast,
> -       .dump_error_regs = calioc2_dump_error_regs
> -};
> -
> -static struct calgary_bus_info bus_info[MAX_PHB_BUS_NUM] = { { NULL, 0, 0 }, };
> -
> -static inline int translation_enabled(struct iommu_table *tbl)
> -{
> -       /* only PHBs with translation enabled have an IOMMU table */
> -       return (tbl != NULL);
> -}
> -
> -static void iommu_range_reserve(struct iommu_table *tbl,
> -       unsigned long start_addr, unsigned int npages)
> -{
> -       unsigned long index;
> -       unsigned long end;
> -       unsigned long flags;
> -
> -       index = start_addr >> PAGE_SHIFT;
> -
> -       /* bail out if we're asked to reserve a region we don't cover */
> -       if (index >= tbl->it_size)
> -               return;
> -
> -       end = index + npages;
> -       if (end > tbl->it_size) /* don't go off the table */
> -               end = tbl->it_size;
> -
> -       spin_lock_irqsave(&tbl->it_lock, flags);
> -
> -       bitmap_set(tbl->it_map, index, npages);
> -
> -       spin_unlock_irqrestore(&tbl->it_lock, flags);
> -}
> -
> -static unsigned long iommu_range_alloc(struct device *dev,
> -                                      struct iommu_table *tbl,
> -                                      unsigned int npages)
> -{
> -       unsigned long flags;
> -       unsigned long offset;
> -       unsigned long boundary_size;
> -
> -       boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
> -                             PAGE_SIZE) >> PAGE_SHIFT;
> -
> -       BUG_ON(npages == 0);
> -
> -       spin_lock_irqsave(&tbl->it_lock, flags);
> -
> -       offset = iommu_area_alloc(tbl->it_map, tbl->it_size, tbl->it_hint,
> -                                 npages, 0, boundary_size, 0);
> -       if (offset == ~0UL) {
> -               tbl->chip_ops->tce_cache_blast(tbl);
> -
> -               offset = iommu_area_alloc(tbl->it_map, tbl->it_size, 0,
> -                                         npages, 0, boundary_size, 0);
> -               if (offset == ~0UL) {
> -                       pr_warn("IOMMU full\n");
> -                       spin_unlock_irqrestore(&tbl->it_lock, flags);
> -                       if (panic_on_overflow)
> -                               panic("Calgary: fix the allocator.\n");
> -                       else
> -                               return DMA_MAPPING_ERROR;
> -               }
> -       }
> -
> -       tbl->it_hint = offset + npages;
> -       BUG_ON(tbl->it_hint > tbl->it_size);
> -
> -       spin_unlock_irqrestore(&tbl->it_lock, flags);
> -
> -       return offset;
> -}
> -
> -static dma_addr_t iommu_alloc(struct device *dev, struct iommu_table *tbl,
> -                             void *vaddr, unsigned int npages, int direction)
> -{
> -       unsigned long entry;
> -       dma_addr_t ret;
> -
> -       entry = iommu_range_alloc(dev, tbl, npages);
> -       if (unlikely(entry == DMA_MAPPING_ERROR)) {
> -               pr_warn("failed to allocate %u pages in iommu %p\n",
> -                       npages, tbl);
> -               return DMA_MAPPING_ERROR;
> -       }
> -
> -       /* set the return dma address */
> -       ret = (entry << PAGE_SHIFT) | ((unsigned long)vaddr & ~PAGE_MASK);
> -
> -       /* put the TCEs in the HW table */
> -       tce_build(tbl, entry, npages, (unsigned long)vaddr & PAGE_MASK,
> -                 direction);
> -       return ret;
> -}
> -
> -static void iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr,
> -       unsigned int npages)
> -{
> -       unsigned long entry;
> -       unsigned long flags;
> -
> -       /* were we called with bad_dma_address? */
> -       if (unlikely(dma_addr == DMA_MAPPING_ERROR)) {
> -               WARN(1, KERN_ERR "Calgary: driver tried unmapping bad DMA "
> -                      "address 0x%Lx\n", dma_addr);
> -               return;
> -       }
> -
> -       entry = dma_addr >> PAGE_SHIFT;
> -
> -       BUG_ON(entry + npages > tbl->it_size);
> -
> -       tce_free(tbl, entry, npages);
> -
> -       spin_lock_irqsave(&tbl->it_lock, flags);
> -
> -       bitmap_clear(tbl->it_map, entry, npages);
> -
> -       spin_unlock_irqrestore(&tbl->it_lock, flags);
> -}
> -
> -static inline struct iommu_table *find_iommu_table(struct device *dev)
> -{
> -       struct pci_dev *pdev;
> -       struct pci_bus *pbus;
> -       struct iommu_table *tbl;
> -
> -       pdev = to_pci_dev(dev);
> -
> -       /* search up the device tree for an iommu */
> -       pbus = pdev->bus;
> -       do {
> -               tbl = pci_iommu(pbus);
> -               if (tbl && tbl->it_busno == pbus->number)
> -                       break;
> -               tbl = NULL;
> -               pbus = pbus->parent;
> -       } while (pbus);
> -
> -       BUG_ON(tbl && (tbl->it_busno != pbus->number));
> -
> -       return tbl;
> -}
> -
> -static void calgary_unmap_sg(struct device *dev, struct scatterlist *sglist,
> -                            int nelems,enum dma_data_direction dir,
> -                            unsigned long attrs)
> -{
> -       struct iommu_table *tbl = find_iommu_table(dev);
> -       struct scatterlist *s;
> -       int i;
> -
> -       if (!translation_enabled(tbl))
> -               return;
> -
> -       for_each_sg(sglist, s, nelems, i) {
> -               unsigned int npages;
> -               dma_addr_t dma = s->dma_address;
> -               unsigned int dmalen = s->dma_length;
> -
> -               if (dmalen == 0)
> -                       break;
> -
> -               npages = iommu_num_pages(dma, dmalen, PAGE_SIZE);
> -               iommu_free(tbl, dma, npages);
> -       }
> -}
> -
> -static int calgary_map_sg(struct device *dev, struct scatterlist *sg,
> -                         int nelems, enum dma_data_direction dir,
> -                         unsigned long attrs)
> -{
> -       struct iommu_table *tbl = find_iommu_table(dev);
> -       struct scatterlist *s;
> -       unsigned long vaddr;
> -       unsigned int npages;
> -       unsigned long entry;
> -       int i;
> -
> -       for_each_sg(sg, s, nelems, i) {
> -               BUG_ON(!sg_page(s));
> -
> -               vaddr = (unsigned long) sg_virt(s);
> -               npages = iommu_num_pages(vaddr, s->length, PAGE_SIZE);
> -
> -               entry = iommu_range_alloc(dev, tbl, npages);
> -               if (entry == DMA_MAPPING_ERROR) {
> -                       /* makes sure unmap knows to stop */
> -                       s->dma_length = 0;
> -                       goto error;
> -               }
> -
> -               s->dma_address = (entry << PAGE_SHIFT) | s->offset;
> -
> -               /* insert into HW table */
> -               tce_build(tbl, entry, npages, vaddr & PAGE_MASK, dir);
> -
> -               s->dma_length = s->length;
> -       }
> -
> -       return nelems;
> -error:
> -       calgary_unmap_sg(dev, sg, nelems, dir, 0);
> -       for_each_sg(sg, s, nelems, i) {
> -               sg->dma_address = DMA_MAPPING_ERROR;
> -               sg->dma_length = 0;
> -       }
> -       return 0;
> -}
> -
> -static dma_addr_t calgary_map_page(struct device *dev, struct page *page,
> -                                  unsigned long offset, size_t size,
> -                                  enum dma_data_direction dir,
> -                                  unsigned long attrs)
> -{
> -       void *vaddr = page_address(page) + offset;
> -       unsigned long uaddr;
> -       unsigned int npages;
> -       struct iommu_table *tbl = find_iommu_table(dev);
> -
> -       uaddr = (unsigned long)vaddr;
> -       npages = iommu_num_pages(uaddr, size, PAGE_SIZE);
> -
> -       return iommu_alloc(dev, tbl, vaddr, npages, dir);
> -}
> -
> -static void calgary_unmap_page(struct device *dev, dma_addr_t dma_addr,
> -                              size_t size, enum dma_data_direction dir,
> -                              unsigned long attrs)
> -{
> -       struct iommu_table *tbl = find_iommu_table(dev);
> -       unsigned int npages;
> -
> -       npages = iommu_num_pages(dma_addr, size, PAGE_SIZE);
> -       iommu_free(tbl, dma_addr, npages);
> -}
> -
> -static void* calgary_alloc_coherent(struct device *dev, size_t size,
> -       dma_addr_t *dma_handle, gfp_t flag, unsigned long attrs)
> -{
> -       void *ret = NULL;
> -       dma_addr_t mapping;
> -       unsigned int npages, order;
> -       struct iommu_table *tbl = find_iommu_table(dev);
> -
> -       size = PAGE_ALIGN(size); /* size rounded up to full pages */
> -       npages = size >> PAGE_SHIFT;
> -       order = get_order(size);
> -
> -       /* alloc enough pages (and possibly more) */
> -       ret = (void *)__get_free_pages(flag, order);
> -       if (!ret)
> -               goto error;
> -       memset(ret, 0, size);
> -
> -       /* set up tces to cover the allocated range */
> -       mapping = iommu_alloc(dev, tbl, ret, npages, DMA_BIDIRECTIONAL);
> -       if (mapping == DMA_MAPPING_ERROR)
> -               goto free;
> -       *dma_handle = mapping;
> -       return ret;
> -free:
> -       free_pages((unsigned long)ret, get_order(size));
> -       ret = NULL;
> -error:
> -       return ret;
> -}
> -
> -static void calgary_free_coherent(struct device *dev, size_t size,
> -                                 void *vaddr, dma_addr_t dma_handle,
> -                                 unsigned long attrs)
> -{
> -       unsigned int npages;
> -       struct iommu_table *tbl = find_iommu_table(dev);
> -
> -       size = PAGE_ALIGN(size);
> -       npages = size >> PAGE_SHIFT;
> -
> -       iommu_free(tbl, dma_handle, npages);
> -       free_pages((unsigned long)vaddr, get_order(size));
> -}
> -
> -static const struct dma_map_ops calgary_dma_ops = {
> -       .alloc = calgary_alloc_coherent,
> -       .free = calgary_free_coherent,
> -       .map_sg = calgary_map_sg,
> -       .unmap_sg = calgary_unmap_sg,
> -       .map_page = calgary_map_page,
> -       .unmap_page = calgary_unmap_page,
> -       .dma_supported = dma_direct_supported,
> -       .mmap = dma_common_mmap,
> -       .get_sgtable = dma_common_get_sgtable,
> -};
> -
> -static inline void __iomem * busno_to_bbar(unsigned char num)
> -{
> -       return bus_info[num].bbar;
> -}
> -
> -static inline int busno_to_phbid(unsigned char num)
> -{
> -       return bus_info[num].phbid;
> -}
> -
> -static inline unsigned long split_queue_offset(unsigned char num)
> -{
> -       size_t idx = busno_to_phbid(num);
> -
> -       return split_queue_offsets[idx];
> -}
> -
> -static inline unsigned long tar_offset(unsigned char num)
> -{
> -       size_t idx = busno_to_phbid(num);
> -
> -       return tar_offsets[idx];
> -}
> -
> -static inline unsigned long phb_offset(unsigned char num)
> -{
> -       size_t idx = busno_to_phbid(num);
> -
> -       return phb_offsets[idx];
> -}
> -
> -static inline void __iomem* calgary_reg(void __iomem *bar, unsigned long offset)
> -{
> -       unsigned long target = ((unsigned long)bar) | offset;
> -       return (void __iomem*)target;
> -}
> -
> -static inline int is_calioc2(unsigned short device)
> -{
> -       return (device == PCI_DEVICE_ID_IBM_CALIOC2);
> -}
> -
> -static inline int is_calgary(unsigned short device)
> -{
> -       return (device == PCI_DEVICE_ID_IBM_CALGARY);
> -}
> -
> -static inline int is_cal_pci_dev(unsigned short device)
> -{
> -       return (is_calgary(device) || is_calioc2(device));
> -}
> -
> -static void calgary_tce_cache_blast(struct iommu_table *tbl)
> -{
> -       u64 val;
> -       u32 aer;
> -       int i = 0;
> -       void __iomem *bbar = tbl->bbar;
> -       void __iomem *target;
> -
> -       /* disable arbitration on the bus */
> -       target = calgary_reg(bbar, phb_offset(tbl->it_busno) | PHB_AER_OFFSET);
> -       aer = readl(target);
> -       writel(0, target);
> -
> -       /* read plssr to ensure it got there */
> -       target = calgary_reg(bbar, phb_offset(tbl->it_busno) | PHB_PLSSR_OFFSET);
> -       val = readl(target);
> -
> -       /* poll split queues until all DMA activity is done */
> -       target = calgary_reg(bbar, split_queue_offset(tbl->it_busno));
> -       do {
> -               val = readq(target);
> -               i++;
> -       } while ((val & 0xff) != 0xff && i < 100);
> -       if (i == 100)
> -               pr_warn("PCI bus not quiesced, continuing anyway\n");
> -
> -       /* invalidate TCE cache */
> -       target = calgary_reg(bbar, tar_offset(tbl->it_busno));
> -       writeq(tbl->tar_val, target);
> -
> -       /* enable arbitration */
> -       target = calgary_reg(bbar, phb_offset(tbl->it_busno) | PHB_AER_OFFSET);
> -       writel(aer, target);
> -       (void)readl(target); /* flush */
> -}
> -
> -static void calioc2_tce_cache_blast(struct iommu_table *tbl)
> -{
> -       void __iomem *bbar = tbl->bbar;
> -       void __iomem *target;
> -       u64 val64;
> -       u32 val;
> -       int i = 0;
> -       int count = 1;
> -       unsigned char bus = tbl->it_busno;
> -
> -begin:
> -       printk(KERN_DEBUG "Calgary: CalIOC2 bus 0x%x entering tce cache blast "
> -              "sequence - count %d\n", bus, count);
> -
> -       /* 1. using the Page Migration Control reg set SoftStop */
> -       target = calgary_reg(bbar, phb_offset(bus) | PHB_PAGE_MIG_CTRL);
> -       val = be32_to_cpu(readl(target));
> -       printk(KERN_DEBUG "1a. read 0x%x [LE] from %p\n", val, target);
> -       val |= PMR_SOFTSTOP;
> -       printk(KERN_DEBUG "1b. writing 0x%x [LE] to %p\n", val, target);
> -       writel(cpu_to_be32(val), target);
> -
> -       /* 2. poll split queues until all DMA activity is done */
> -       printk(KERN_DEBUG "2a. starting to poll split queues\n");
> -       target = calgary_reg(bbar, split_queue_offset(bus));
> -       do {
> -               val64 = readq(target);
> -               i++;
> -       } while ((val64 & 0xff) != 0xff && i < 100);
> -       if (i == 100)
> -               pr_warn("CalIOC2: PCI bus not quiesced, continuing anyway\n");
> -
> -       /* 3. poll Page Migration DEBUG for SoftStopFault */
> -       target = calgary_reg(bbar, phb_offset(bus) | PHB_PAGE_MIG_DEBUG);
> -       val = be32_to_cpu(readl(target));
> -       printk(KERN_DEBUG "3. read 0x%x [LE] from %p\n", val, target);
> -
> -       /* 4. if SoftStopFault - goto (1) */
> -       if (val & PMR_SOFTSTOPFAULT) {
> -               if (++count < 100)
> -                       goto begin;
> -               else {
> -                       pr_warn("CalIOC2: too many SoftStopFaults, aborting TCE cache flush sequence!\n");
> -                       return; /* pray for the best */
> -               }
> -       }
> -
> -       /* 5. Slam into HardStop by reading PHB_PAGE_MIG_CTRL */
> -       target = calgary_reg(bbar, phb_offset(bus) | PHB_PAGE_MIG_CTRL);
> -       printk(KERN_DEBUG "5a. slamming into HardStop by reading %p\n", target);
> -       val = be32_to_cpu(readl(target));
> -       printk(KERN_DEBUG "5b. read 0x%x [LE] from %p\n", val, target);
> -       target = calgary_reg(bbar, phb_offset(bus) | PHB_PAGE_MIG_DEBUG);
> -       val = be32_to_cpu(readl(target));
> -       printk(KERN_DEBUG "5c. read 0x%x [LE] from %p (debug)\n", val, target);
> -
> -       /* 6. invalidate TCE cache */
> -       printk(KERN_DEBUG "6. invalidating TCE cache\n");
> -       target = calgary_reg(bbar, tar_offset(bus));
> -       writeq(tbl->tar_val, target);
> -
> -       /* 7. Re-read PMCR */
> -       printk(KERN_DEBUG "7a. Re-reading PMCR\n");
> -       target = calgary_reg(bbar, phb_offset(bus) | PHB_PAGE_MIG_CTRL);
> -       val = be32_to_cpu(readl(target));
> -       printk(KERN_DEBUG "7b. read 0x%x [LE] from %p\n", val, target);
> -
> -       /* 8. Remove HardStop */
> -       printk(KERN_DEBUG "8a. removing HardStop from PMCR\n");
> -       target = calgary_reg(bbar, phb_offset(bus) | PHB_PAGE_MIG_CTRL);
> -       val = 0;
> -       printk(KERN_DEBUG "8b. writing 0x%x [LE] to %p\n", val, target);
> -       writel(cpu_to_be32(val), target);
> -       val = be32_to_cpu(readl(target));
> -       printk(KERN_DEBUG "8c. read 0x%x [LE] from %p\n", val, target);
> -}
> -
> -static void __init calgary_reserve_mem_region(struct pci_dev *dev, u64 start,
> -       u64 limit)
> -{
> -       unsigned int numpages;
> -
> -       limit = limit | 0xfffff;
> -       limit++;
> -
> -       numpages = ((limit - start) >> PAGE_SHIFT);
> -       iommu_range_reserve(pci_iommu(dev->bus), start, numpages);
> -}
> -
> -static void __init calgary_reserve_peripheral_mem_1(struct pci_dev *dev)
> -{
> -       void __iomem *target;
> -       u64 low, high, sizelow;
> -       u64 start, limit;
> -       struct iommu_table *tbl = pci_iommu(dev->bus);
> -       unsigned char busnum = dev->bus->number;
> -       void __iomem *bbar = tbl->bbar;
> -
> -       /* peripheral MEM_1 region */
> -       target = calgary_reg(bbar, phb_offset(busnum) | PHB_MEM_1_LOW);
> -       low = be32_to_cpu(readl(target));
> -       target = calgary_reg(bbar, phb_offset(busnum) | PHB_MEM_1_HIGH);
> -       high = be32_to_cpu(readl(target));
> -       target = calgary_reg(bbar, phb_offset(busnum) | PHB_MEM_1_SIZE);
> -       sizelow = be32_to_cpu(readl(target));
> -
> -       start = (high << 32) | low;
> -       limit = sizelow;
> -
> -       calgary_reserve_mem_region(dev, start, limit);
> -}
> -
> -static void __init calgary_reserve_peripheral_mem_2(struct pci_dev *dev)
> -{
> -       void __iomem *target;
> -       u32 val32;
> -       u64 low, high, sizelow, sizehigh;
> -       u64 start, limit;
> -       struct iommu_table *tbl = pci_iommu(dev->bus);
> -       unsigned char busnum = dev->bus->number;
> -       void __iomem *bbar = tbl->bbar;
> -
> -       /* is it enabled? */
> -       target = calgary_reg(bbar, phb_offset(busnum) | PHB_CONFIG_RW_OFFSET);
> -       val32 = be32_to_cpu(readl(target));
> -       if (!(val32 & PHB_MEM2_ENABLE))
> -               return;
> -
> -       target = calgary_reg(bbar, phb_offset(busnum) | PHB_MEM_2_LOW);
> -       low = be32_to_cpu(readl(target));
> -       target = calgary_reg(bbar, phb_offset(busnum) | PHB_MEM_2_HIGH);
> -       high = be32_to_cpu(readl(target));
> -       target = calgary_reg(bbar, phb_offset(busnum) | PHB_MEM_2_SIZE_LOW);
> -       sizelow = be32_to_cpu(readl(target));
> -       target = calgary_reg(bbar, phb_offset(busnum) | PHB_MEM_2_SIZE_HIGH);
> -       sizehigh = be32_to_cpu(readl(target));
> -
> -       start = (high << 32) | low;
> -       limit = (sizehigh << 32) | sizelow;
> -
> -       calgary_reserve_mem_region(dev, start, limit);
> -}
> -
> -/*
> - * some regions of the IO address space do not get translated, so we
> - * must not give devices IO addresses in those regions. The regions
> - * are the 640KB-1MB region and the two PCI peripheral memory holes.
> - * Reserve all of them in the IOMMU bitmap to avoid giving them out
> - * later.
> - */
> -static void __init calgary_reserve_regions(struct pci_dev *dev)
> -{
> -       unsigned int npages;
> -       u64 start;
> -       struct iommu_table *tbl = pci_iommu(dev->bus);
> -
> -       /* avoid the BIOS/VGA first 640KB-1MB region */
> -       /* for CalIOC2 - avoid the entire first MB */
> -       if (is_calgary(dev->device)) {
> -               start = (640 * 1024);
> -               npages = ((1024 - 640) * 1024) >> PAGE_SHIFT;
> -       } else { /* calioc2 */
> -               start = 0;
> -               npages = (1 * 1024 * 1024) >> PAGE_SHIFT;
> -       }
> -       iommu_range_reserve(tbl, start, npages);
> -
> -       /* reserve the two PCI peripheral memory regions in IO space */
> -       calgary_reserve_peripheral_mem_1(dev);
> -       calgary_reserve_peripheral_mem_2(dev);
> -}
> -
> -static int __init calgary_setup_tar(struct pci_dev *dev, void __iomem *bbar)
> -{
> -       u64 val64;
> -       u64 table_phys;
> -       void __iomem *target;
> -       int ret;
> -       struct iommu_table *tbl;
> -
> -       /* build TCE tables for each PHB */
> -       ret = build_tce_table(dev, bbar);
> -       if (ret)
> -               return ret;
> -
> -       tbl = pci_iommu(dev->bus);
> -       tbl->it_base = (unsigned long)bus_info[dev->bus->number].tce_space;
> -
> -       if (is_kdump_kernel())
> -               calgary_init_bitmap_from_tce_table(tbl);
> -       else
> -               tce_free(tbl, 0, tbl->it_size);
> -
> -       if (is_calgary(dev->device))
> -               tbl->chip_ops = &calgary_chip_ops;
> -       else if (is_calioc2(dev->device))
> -               tbl->chip_ops = &calioc2_chip_ops;
> -       else
> -               BUG();
> -
> -       calgary_reserve_regions(dev);
> -
> -       /* set TARs for each PHB */
> -       target = calgary_reg(bbar, tar_offset(dev->bus->number));
> -       val64 = be64_to_cpu(readq(target));
> -
> -       /* zero out all TAR bits under sw control */
> -       val64 &= ~TAR_SW_BITS;
> -       table_phys = (u64)__pa(tbl->it_base);
> -
> -       val64 |= table_phys;
> -
> -       BUG_ON(specified_table_size > TCE_TABLE_SIZE_8M);
> -       val64 |= (u64) specified_table_size;
> -
> -       tbl->tar_val = cpu_to_be64(val64);
> -
> -       writeq(tbl->tar_val, target);
> -       readq(target); /* flush */
> -
> -       return 0;
> -}
> -
> -static void __init calgary_free_bus(struct pci_dev *dev)
> -{
> -       u64 val64;
> -       struct iommu_table *tbl = pci_iommu(dev->bus);
> -       void __iomem *target;
> -       unsigned int bitmapsz;
> -
> -       target = calgary_reg(tbl->bbar, tar_offset(dev->bus->number));
> -       val64 = be64_to_cpu(readq(target));
> -       val64 &= ~TAR_SW_BITS;
> -       writeq(cpu_to_be64(val64), target);
> -       readq(target); /* flush */
> -
> -       bitmapsz = tbl->it_size / BITS_PER_BYTE;
> -       free_pages((unsigned long)tbl->it_map, get_order(bitmapsz));
> -       tbl->it_map = NULL;
> -
> -       kfree(tbl);
> -
> -       set_pci_iommu(dev->bus, NULL);
> -
> -       /* Can't free bootmem allocated memory after system is up :-( */
> -       bus_info[dev->bus->number].tce_space = NULL;
> -}
> -
> -static void calgary_dump_error_regs(struct iommu_table *tbl)
> -{
> -       void __iomem *bbar = tbl->bbar;
> -       void __iomem *target;
> -       u32 csr, plssr;
> -
> -       target = calgary_reg(bbar, phb_offset(tbl->it_busno) | PHB_CSR_OFFSET);
> -       csr = be32_to_cpu(readl(target));
> -
> -       target = calgary_reg(bbar, phb_offset(tbl->it_busno) | PHB_PLSSR_OFFSET);
> -       plssr = be32_to_cpu(readl(target));
> -
> -       /* If no error, the agent ID in the CSR is not valid */
> -       pr_emerg("DMA error on Calgary PHB 0x%x, 0x%08x@CSR 0x%08x@PLSSR\n",
> -                tbl->it_busno, csr, plssr);
> -}
> -
> -static void calioc2_dump_error_regs(struct iommu_table *tbl)
> -{
> -       void __iomem *bbar = tbl->bbar;
> -       u32 csr, csmr, plssr, mck, rcstat;
> -       void __iomem *target;
> -       unsigned long phboff = phb_offset(tbl->it_busno);
> -       unsigned long erroff;
> -       u32 errregs[7];
> -       int i;
> -
> -       /* dump CSR */
> -       target = calgary_reg(bbar, phboff | PHB_CSR_OFFSET);
> -       csr = be32_to_cpu(readl(target));
> -       /* dump PLSSR */
> -       target = calgary_reg(bbar, phboff | PHB_PLSSR_OFFSET);
> -       plssr = be32_to_cpu(readl(target));
> -       /* dump CSMR */
> -       target = calgary_reg(bbar, phboff | 0x290);
> -       csmr = be32_to_cpu(readl(target));
> -       /* dump mck */
> -       target = calgary_reg(bbar, phboff | 0x800);
> -       mck = be32_to_cpu(readl(target));
> -
> -       pr_emerg("DMA error on CalIOC2 PHB 0x%x\n", tbl->it_busno);
> -
> -       pr_emerg("0x%08x@CSR 0x%08x@PLSSR 0x%08x@CSMR 0x%08x@MCK\n",
> -                csr, plssr, csmr, mck);
> -
> -       /* dump rest of error regs */
> -       pr_emerg("");
> -       for (i = 0; i < ARRAY_SIZE(errregs); i++) {
> -               /* err regs are at 0x810 - 0x870 */
> -               erroff = (0x810 + (i * 0x10));
> -               target = calgary_reg(bbar, phboff | erroff);
> -               errregs[i] = be32_to_cpu(readl(target));
> -               pr_cont("0x%08x@0x%lx ", errregs[i], erroff);
> -       }
> -       pr_cont("\n");
> -
> -       /* root complex status */
> -       target = calgary_reg(bbar, phboff | PHB_ROOT_COMPLEX_STATUS);
> -       rcstat = be32_to_cpu(readl(target));
> -       printk(KERN_EMERG "Calgary: 0x%08x@0x%x\n", rcstat,
> -              PHB_ROOT_COMPLEX_STATUS);
> -}
> -
> -static void calgary_watchdog(struct timer_list *t)
> -{
> -       struct iommu_table *tbl = from_timer(tbl, t, watchdog_timer);
> -       void __iomem *bbar = tbl->bbar;
> -       u32 val32;
> -       void __iomem *target;
> -
> -       target = calgary_reg(bbar, phb_offset(tbl->it_busno) | PHB_CSR_OFFSET);
> -       val32 = be32_to_cpu(readl(target));
> -
> -       /* If no error, the agent ID in the CSR is not valid */
> -       if (val32 & CSR_AGENT_MASK) {
> -               tbl->chip_ops->dump_error_regs(tbl);
> -
> -               /* reset error */
> -               writel(0, target);
> -
> -               /* Disable bus that caused the error */
> -               target = calgary_reg(bbar, phb_offset(tbl->it_busno) |
> -                                    PHB_CONFIG_RW_OFFSET);
> -               val32 = be32_to_cpu(readl(target));
> -               val32 |= PHB_SLOT_DISABLE;
> -               writel(cpu_to_be32(val32), target);
> -               readl(target); /* flush */
> -       } else {
> -               /* Reset the timer */
> -               mod_timer(&tbl->watchdog_timer, jiffies + 2 * HZ);
> -       }
> -}
> -
> -static void __init calgary_set_split_completion_timeout(void __iomem *bbar,
> -       unsigned char busnum, unsigned long timeout)
> -{
> -       u64 val64;
> -       void __iomem *target;
> -       unsigned int phb_shift = ~0; /* silence gcc */
> -       u64 mask;
> -
> -       switch (busno_to_phbid(busnum)) {
> -       case 0: phb_shift = (63 - 19);
> -               break;
> -       case 1: phb_shift = (63 - 23);
> -               break;
> -       case 2: phb_shift = (63 - 27);
> -               break;
> -       case 3: phb_shift = (63 - 35);
> -               break;
> -       default:
> -               BUG_ON(busno_to_phbid(busnum));
> -       }
> -
> -       target = calgary_reg(bbar, CALGARY_CONFIG_REG);
> -       val64 = be64_to_cpu(readq(target));
> -
> -       /* zero out this PHB's timer bits */
> -       mask = ~(0xFUL << phb_shift);
> -       val64 &= mask;
> -       val64 |= (timeout << phb_shift);
> -       writeq(cpu_to_be64(val64), target);
> -       readq(target); /* flush */
> -}
> -
> -static void __init calioc2_handle_quirks(struct iommu_table *tbl, struct pci_dev *dev)
> -{
> -       unsigned char busnum = dev->bus->number;
> -       void __iomem *bbar = tbl->bbar;
> -       void __iomem *target;
> -       u32 val;
> -
> -       /*
> -        * CalIOC2 designers recommend setting bit 8 in 0xnDB0 to 1
> -        */
> -       target = calgary_reg(bbar, phb_offset(busnum) | PHB_SAVIOR_L2);
> -       val = cpu_to_be32(readl(target));
> -       val |= 0x00800000;
> -       writel(cpu_to_be32(val), target);
> -}
> -
> -static void __init calgary_handle_quirks(struct iommu_table *tbl, struct pci_dev *dev)
> -{
> -       unsigned char busnum = dev->bus->number;
> -
> -       /*
> -        * Give split completion a longer timeout on bus 1 for aic94xx
> -        * http://bugzilla.kernel.org/show_bug.cgi?id=7180
> -        */
> -       if (is_calgary(dev->device) && (busnum == 1))
> -               calgary_set_split_completion_timeout(tbl->bbar, busnum,
> -                                                    CCR_2SEC_TIMEOUT);
> -}
> -
> -static void __init calgary_enable_translation(struct pci_dev *dev)
> -{
> -       u32 val32;
> -       unsigned char busnum;
> -       void __iomem *target;
> -       void __iomem *bbar;
> -       struct iommu_table *tbl;
> -
> -       busnum = dev->bus->number;
> -       tbl = pci_iommu(dev->bus);
> -       bbar = tbl->bbar;
> -
> -       /* enable TCE in PHB Config Register */
> -       target = calgary_reg(bbar, phb_offset(busnum) | PHB_CONFIG_RW_OFFSET);
> -       val32 = be32_to_cpu(readl(target));
> -       val32 |= PHB_TCE_ENABLE | PHB_DAC_DISABLE | PHB_MCSR_ENABLE;
> -
> -       printk(KERN_INFO "Calgary: enabling translation on %s PHB %#x\n",
> -              (dev->device == PCI_DEVICE_ID_IBM_CALGARY) ?
> -              "Calgary" : "CalIOC2", busnum);
> -       printk(KERN_INFO "Calgary: errant DMAs will now be prevented on this "
> -              "bus.\n");
> -
> -       writel(cpu_to_be32(val32), target);
> -       readl(target); /* flush */
> -
> -       timer_setup(&tbl->watchdog_timer, calgary_watchdog, 0);
> -       mod_timer(&tbl->watchdog_timer, jiffies);
> -}
> -
> -static void __init calgary_disable_translation(struct pci_dev *dev)
> -{
> -       u32 val32;
> -       unsigned char busnum;
> -       void __iomem *target;
> -       void __iomem *bbar;
> -       struct iommu_table *tbl;
> -
> -       busnum = dev->bus->number;
> -       tbl = pci_iommu(dev->bus);
> -       bbar = tbl->bbar;
> -
> -       /* disable TCE in PHB Config Register */
> -       target = calgary_reg(bbar, phb_offset(busnum) | PHB_CONFIG_RW_OFFSET);
> -       val32 = be32_to_cpu(readl(target));
> -       val32 &= ~(PHB_TCE_ENABLE | PHB_DAC_DISABLE | PHB_MCSR_ENABLE);
> -
> -       printk(KERN_INFO "Calgary: disabling translation on PHB %#x!\n", busnum);
> -       writel(cpu_to_be32(val32), target);
> -       readl(target); /* flush */
> -
> -       del_timer_sync(&tbl->watchdog_timer);
> -}
> -
> -static void __init calgary_init_one_nontraslated(struct pci_dev *dev)
> -{
> -       pci_dev_get(dev);
> -       set_pci_iommu(dev->bus, NULL);
> -
> -       /* is the device behind a bridge? */
> -       if (dev->bus->parent)
> -               dev->bus->parent->self = dev;
> -       else
> -               dev->bus->self = dev;
> -}
> -
> -static int __init calgary_init_one(struct pci_dev *dev)
> -{
> -       void __iomem *bbar;
> -       struct iommu_table *tbl;
> -       int ret;
> -
> -       bbar = busno_to_bbar(dev->bus->number);
> -       ret = calgary_setup_tar(dev, bbar);
> -       if (ret)
> -               goto done;
> -
> -       pci_dev_get(dev);
> -
> -       if (dev->bus->parent) {
> -               if (dev->bus->parent->self)
> -                       printk(KERN_WARNING "Calgary: IEEEE, dev %p has "
> -                              "bus->parent->self!\n", dev);
> -               dev->bus->parent->self = dev;
> -       } else
> -               dev->bus->self = dev;
> -
> -       tbl = pci_iommu(dev->bus);
> -       tbl->chip_ops->handle_quirks(tbl, dev);
> -
> -       calgary_enable_translation(dev);
> -
> -       return 0;
> -
> -done:
> -       return ret;
> -}
> -
> -static int __init calgary_locate_bbars(void)
> -{
> -       int ret;
> -       int rioidx, phb, bus;
> -       void __iomem *bbar;
> -       void __iomem *target;
> -       unsigned long offset;
> -       u8 start_bus, end_bus;
> -       u32 val;
> -
> -       ret = -ENODATA;
> -       for (rioidx = 0; rioidx < rio_table_hdr->num_rio_dev; rioidx++) {
> -               struct rio_detail *rio = rio_devs[rioidx];
> -
> -               if ((rio->type != COMPAT_CALGARY) && (rio->type != ALT_CALGARY))
> -                       continue;
> -
> -               /* map entire 1MB of Calgary config space */
> -               bbar = ioremap_nocache(rio->BBAR, 1024 * 1024);
> -               if (!bbar)
> -                       goto error;
> -
> -               for (phb = 0; phb < PHBS_PER_CALGARY; phb++) {
> -                       offset = phb_debug_offsets[phb] | PHB_DEBUG_STUFF_OFFSET;
> -                       target = calgary_reg(bbar, offset);
> -
> -                       val = be32_to_cpu(readl(target));
> -
> -                       start_bus = (u8)((val & 0x00FF0000) >> 16);
> -                       end_bus = (u8)((val & 0x0000FF00) >> 8);
> -
> -                       if (end_bus) {
> -                               for (bus = start_bus; bus <= end_bus; bus++) {
> -                                       bus_info[bus].bbar = bbar;
> -                                       bus_info[bus].phbid = phb;
> -                               }
> -                       } else {
> -                               bus_info[start_bus].bbar = bbar;
> -                               bus_info[start_bus].phbid = phb;
> -                       }
> -               }
> -       }
> -
> -       return 0;
> -
> -error:
> -       /* scan bus_info and iounmap any bbars we previously ioremap'd */
> -       for (bus = 0; bus < ARRAY_SIZE(bus_info); bus++)
> -               if (bus_info[bus].bbar)
> -                       iounmap(bus_info[bus].bbar);
> -
> -       return ret;
> -}
> -
> -static int __init calgary_init(void)
> -{
> -       int ret;
> -       struct pci_dev *dev = NULL;
> -       struct calgary_bus_info *info;
> -
> -       ret = calgary_locate_bbars();
> -       if (ret)
> -               return ret;
> -
> -       /* Purely for kdump kernel case */
> -       if (is_kdump_kernel())
> -               get_tce_space_from_tar();
> -
> -       do {
> -               dev = pci_get_device(PCI_VENDOR_ID_IBM, PCI_ANY_ID, dev);
> -               if (!dev)
> -                       break;
> -               if (!is_cal_pci_dev(dev->device))
> -                       continue;
> -
> -               info = &bus_info[dev->bus->number];
> -               if (info->translation_disabled) {
> -                       calgary_init_one_nontraslated(dev);
> -                       continue;
> -               }
> -
> -               if (!info->tce_space && !translate_empty_slots)
> -                       continue;
> -
> -               ret = calgary_init_one(dev);
> -               if (ret)
> -                       goto error;
> -       } while (1);
> -
> -       dev = NULL;
> -       for_each_pci_dev(dev) {
> -               struct iommu_table *tbl;
> -
> -               tbl = find_iommu_table(&dev->dev);
> -
> -               if (translation_enabled(tbl))
> -                       dev->dev.dma_ops = &calgary_dma_ops;
> -       }
> -
> -       return ret;
> -
> -error:
> -       do {
> -               dev = pci_get_device(PCI_VENDOR_ID_IBM, PCI_ANY_ID, dev);
> -               if (!dev)
> -                       break;
> -               if (!is_cal_pci_dev(dev->device))
> -                       continue;
> -
> -               info = &bus_info[dev->bus->number];
> -               if (info->translation_disabled) {
> -                       pci_dev_put(dev);
> -                       continue;
> -               }
> -               if (!info->tce_space && !translate_empty_slots)
> -                       continue;
> -
> -               calgary_disable_translation(dev);
> -               calgary_free_bus(dev);
> -               pci_dev_put(dev); /* Undo calgary_init_one()'s pci_dev_get() */
> -               dev->dev.dma_ops = NULL;
> -       } while (1);
> -
> -       return ret;
> -}
> -
> -static inline int __init determine_tce_table_size(void)
> -{
> -       int ret;
> -
> -       if (specified_table_size != TCE_TABLE_SIZE_UNSPECIFIED)
> -               return specified_table_size;
> -
> -       if (is_kdump_kernel() && saved_max_pfn) {
> -               /*
> -                * Table sizes are from 0 to 7 (TCE_TABLE_SIZE_64K to
> -                * TCE_TABLE_SIZE_8M). Table size 0 has 8K entries and each
> -                * larger table size has twice as many entries, so shift the
> -                * max ram address by 13 to divide by 8K and then look at the
> -                * order of the result to choose between 0-7.
> -                */
> -               ret = get_order((saved_max_pfn * PAGE_SIZE) >> 13);
> -               if (ret > TCE_TABLE_SIZE_8M)
> -                       ret = TCE_TABLE_SIZE_8M;
> -       } else {
> -               /*
> -                * Use 8M by default (suggested by Muli) if it's not
> -                * kdump kernel and saved_max_pfn isn't set.
> -                */
> -               ret = TCE_TABLE_SIZE_8M;
> -       }
> -
> -       return ret;
> -}
> -
> -static int __init build_detail_arrays(void)
> -{
> -       unsigned long ptr;
> -       unsigned numnodes, i;
> -       int scal_detail_size, rio_detail_size;
> -
> -       numnodes = rio_table_hdr->num_scal_dev;
> -       if (numnodes > MAX_NUMNODES){
> -               printk(KERN_WARNING
> -                       "Calgary: MAX_NUMNODES too low! Defined as %d, "
> -                       "but system has %d nodes.\n",
> -                       MAX_NUMNODES, numnodes);
> -               return -ENODEV;
> -       }
> -
> -       switch (rio_table_hdr->version){
> -       case 2:
> -               scal_detail_size = 11;
> -               rio_detail_size = 13;
> -               break;
> -       case 3:
> -               scal_detail_size = 12;
> -               rio_detail_size = 15;
> -               break;
> -       default:
> -               printk(KERN_WARNING
> -                      "Calgary: Invalid Rio Grande Table Version: %d\n",
> -                      rio_table_hdr->version);
> -               return -EPROTO;
> -       }
> -
> -       ptr = ((unsigned long)rio_table_hdr) + 3;
> -       for (i = 0; i < numnodes; i++, ptr += scal_detail_size)
> -               scal_devs[i] = (struct scal_detail *)ptr;
> -
> -       for (i = 0; i < rio_table_hdr->num_rio_dev;
> -                   i++, ptr += rio_detail_size)
> -               rio_devs[i] = (struct rio_detail *)ptr;
> -
> -       return 0;
> -}
> -
> -static int __init calgary_bus_has_devices(int bus, unsigned short pci_dev)
> -{
> -       int dev;
> -       u32 val;
> -
> -       if (pci_dev == PCI_DEVICE_ID_IBM_CALIOC2) {
> -               /*
> -                * FIXME: properly scan for devices across the
> -                * PCI-to-PCI bridge on every CalIOC2 port.
> -                */
> -               return 1;
> -       }
> -
> -       for (dev = 1; dev < 8; dev++) {
> -               val = read_pci_config(bus, dev, 0, 0);
> -               if (val != 0xffffffff)
> -                       break;
> -       }
> -       return (val != 0xffffffff);
> -}
> -
> -/*
> - * calgary_init_bitmap_from_tce_table():
> - * Function for kdump case. In the second/kdump kernel initialize
> - * the bitmap based on the tce table entries obtained from first kernel
> - */
> -static void calgary_init_bitmap_from_tce_table(struct iommu_table *tbl)
> -{
> -       u64 *tp;
> -       unsigned int index;
> -       tp = ((u64 *)tbl->it_base);
> -       for (index = 0 ; index < tbl->it_size; index++) {
> -               if (*tp != 0x0)
> -                       set_bit(index, tbl->it_map);
> -               tp++;
> -       }
> -}
> -
> -/*
> - * get_tce_space_from_tar():
> - * Function for kdump case. Get the tce tables from first kernel
> - * by reading the contents of the base address register of calgary iommu
> - */
> -static void __init get_tce_space_from_tar(void)
> -{
> -       int bus;
> -       void __iomem *target;
> -       unsigned long tce_space;
> -
> -       for (bus = 0; bus < MAX_PHB_BUS_NUM; bus++) {
> -               struct calgary_bus_info *info = &bus_info[bus];
> -               unsigned short pci_device;
> -               u32 val;
> -
> -               val = read_pci_config(bus, 0, 0, 0);
> -               pci_device = (val & 0xFFFF0000) >> 16;
> -
> -               if (!is_cal_pci_dev(pci_device))
> -                       continue;
> -               if (info->translation_disabled)
> -                       continue;
> -
> -               if (calgary_bus_has_devices(bus, pci_device) ||
> -                                               translate_empty_slots) {
> -                       target = calgary_reg(bus_info[bus].bbar,
> -                                               tar_offset(bus));
> -                       tce_space = be64_to_cpu(readq(target));
> -                       tce_space = tce_space & TAR_SW_BITS;
> -
> -                       tce_space = tce_space & (~specified_table_size);
> -                       info->tce_space = (u64 *)__va(tce_space);
> -               }
> -       }
> -       return;
> -}
> -
> -static int __init calgary_iommu_init(void)
> -{
> -       int ret;
> -
> -       /* ok, we're trying to use Calgary - let's roll */
> -       printk(KERN_INFO "PCI-DMA: Using Calgary IOMMU\n");
> -
> -       ret = calgary_init();
> -       if (ret) {
> -               printk(KERN_ERR "PCI-DMA: Calgary init failed %d, "
> -                      "falling back to no_iommu\n", ret);
> -               return ret;
> -       }
> -
> -       return 0;
> -}
> -
> -int __init detect_calgary(void)
> -{
> -       int bus;
> -       void *tbl;
> -       int calgary_found = 0;
> -       unsigned long ptr;
> -       unsigned int offset, prev_offset;
> -       int ret;
> -
> -       /*
> -        * if the user specified iommu=off or iommu=soft or we found
> -        * another HW IOMMU already, bail out.
> -        */
> -       if (no_iommu || iommu_detected)
> -               return -ENODEV;
> -
> -       if (!use_calgary)
> -               return -ENODEV;
> -
> -       if (!early_pci_allowed())
> -               return -ENODEV;
> -
> -       printk(KERN_DEBUG "Calgary: detecting Calgary via BIOS EBDA area\n");
> -
> -       ptr = (unsigned long)phys_to_virt(get_bios_ebda());
> -
> -       rio_table_hdr = NULL;
> -       prev_offset = 0;
> -       offset = 0x180;
> -       /*
> -        * The next offset is stored in the 1st word.
> -        * Only parse up until the offset increases:
> -        */
> -       while (offset > prev_offset) {
> -               /* The block id is stored in the 2nd word */
> -               if (*((unsigned short *)(ptr + offset + 2)) == 0x4752){
> -                       /* set the pointer past the offset & block id */
> -                       rio_table_hdr = (struct rio_table_hdr *)(ptr + offset + 4);
> -                       break;
> -               }
> -               prev_offset = offset;
> -               offset = *((unsigned short *)(ptr + offset));
> -       }
> -       if (!rio_table_hdr) {
> -               printk(KERN_DEBUG "Calgary: Unable to locate Rio Grande table "
> -                      "in EBDA - bailing!\n");
> -               return -ENODEV;
> -       }
> -
> -       ret = build_detail_arrays();
> -       if (ret) {
> -               printk(KERN_DEBUG "Calgary: build_detail_arrays ret %d\n", ret);
> -               return -ENOMEM;
> -       }
> -
> -       specified_table_size = determine_tce_table_size();
> -
> -       for (bus = 0; bus < MAX_PHB_BUS_NUM; bus++) {
> -               struct calgary_bus_info *info = &bus_info[bus];
> -               unsigned short pci_device;
> -               u32 val;
> -
> -               val = read_pci_config(bus, 0, 0, 0);
> -               pci_device = (val & 0xFFFF0000) >> 16;
> -
> -               if (!is_cal_pci_dev(pci_device))
> -                       continue;
> -
> -               if (info->translation_disabled)
> -                       continue;
> -
> -               if (calgary_bus_has_devices(bus, pci_device) ||
> -                   translate_empty_slots) {
> -                       /*
> -                        * If it is kdump kernel, find and use tce tables
> -                        * from first kernel, else allocate tce tables here
> -                        */
> -                       if (!is_kdump_kernel()) {
> -                               tbl = alloc_tce_table();
> -                               if (!tbl)
> -                                       goto cleanup;
> -                               info->tce_space = tbl;
> -                       }
> -                       calgary_found = 1;
> -               }
> -       }
> -
> -       printk(KERN_DEBUG "Calgary: finished detection, Calgary %s\n",
> -              calgary_found ? "found" : "not found");
> -
> -       if (calgary_found) {
> -               iommu_detected = 1;
> -               calgary_detected = 1;
> -               printk(KERN_INFO "PCI-DMA: Calgary IOMMU detected.\n");
> -               printk(KERN_INFO "PCI-DMA: Calgary TCE table spec is %d\n",
> -                      specified_table_size);
> -
> -               x86_init.iommu.iommu_init = calgary_iommu_init;
> -       }
> -       return calgary_found;
> -
> -cleanup:
> -       for (--bus; bus >= 0; --bus) {
> -               struct calgary_bus_info *info = &bus_info[bus];
> -
> -               if (info->tce_space)
> -                       free_tce_table(info->tce_space);
> -       }
> -       return -ENOMEM;
> -}
> -
> -static int __init calgary_parse_options(char *p)
> -{
> -       unsigned int bridge;
> -       unsigned long val;
> -       size_t len;
> -       ssize_t ret;
> -
> -       while (*p) {
> -               if (!strncmp(p, "64k", 3))
> -                       specified_table_size = TCE_TABLE_SIZE_64K;
> -               else if (!strncmp(p, "128k", 4))
> -                       specified_table_size = TCE_TABLE_SIZE_128K;
> -               else if (!strncmp(p, "256k", 4))
> -                       specified_table_size = TCE_TABLE_SIZE_256K;
> -               else if (!strncmp(p, "512k", 4))
> -                       specified_table_size = TCE_TABLE_SIZE_512K;
> -               else if (!strncmp(p, "1M", 2))
> -                       specified_table_size = TCE_TABLE_SIZE_1M;
> -               else if (!strncmp(p, "2M", 2))
> -                       specified_table_size = TCE_TABLE_SIZE_2M;
> -               else if (!strncmp(p, "4M", 2))
> -                       specified_table_size = TCE_TABLE_SIZE_4M;
> -               else if (!strncmp(p, "8M", 2))
> -                       specified_table_size = TCE_TABLE_SIZE_8M;
> -
> -               len = strlen("translate_empty_slots");
> -               if (!strncmp(p, "translate_empty_slots", len))
> -                       translate_empty_slots = 1;
> -
> -               len = strlen("disable");
> -               if (!strncmp(p, "disable", len)) {
> -                       p += len;
> -                       if (*p == '=')
> -                               ++p;
> -                       if (*p == '\0')
> -                               break;
> -                       ret = kstrtoul(p, 0, &val);
> -                       if (ret)
> -                               break;
> -
> -                       bridge = val;
> -                       if (bridge < MAX_PHB_BUS_NUM) {
> -                               printk(KERN_INFO "Calgary: disabling "
> -                                      "translation for PHB %#x\n", bridge);
> -                               bus_info[bridge].translation_disabled = 1;
> -                       }
> -               }
> -
> -               p = strpbrk(p, ",");
> -               if (!p)
> -                       break;
> -
> -               p++; /* skip ',' */
> -       }
> -       return 1;
> -}
> -__setup("calgary=", calgary_parse_options);
> -
> -static void __init calgary_fixup_one_tce_space(struct pci_dev *dev)
> -{
> -       struct iommu_table *tbl;
> -       unsigned int npages;
> -       int i;
> -
> -       tbl = pci_iommu(dev->bus);
> -
> -       for (i = 0; i < 4; i++) {
> -               struct resource *r = &dev->resource[PCI_BRIDGE_RESOURCES + i];
> -
> -               /* Don't give out TCEs that map MEM resources */
> -               if (!(r->flags & IORESOURCE_MEM))
> -                       continue;
> -
> -               /* 0-based? we reserve the whole 1st MB anyway */
> -               if (!r->start)
> -                       continue;
> -
> -               /* cover the whole region */
> -               npages = resource_size(r) >> PAGE_SHIFT;
> -               npages++;
> -
> -               iommu_range_reserve(tbl, r->start, npages);
> -       }
> -}
> -
> -static int __init calgary_fixup_tce_spaces(void)
> -{
> -       struct pci_dev *dev = NULL;
> -       struct calgary_bus_info *info;
> -
> -       if (no_iommu || swiotlb || !calgary_detected)
> -               return -ENODEV;
> -
> -       printk(KERN_DEBUG "Calgary: fixing up tce spaces\n");
> -
> -       do {
> -               dev = pci_get_device(PCI_VENDOR_ID_IBM, PCI_ANY_ID, dev);
> -               if (!dev)
> -                       break;
> -               if (!is_cal_pci_dev(dev->device))
> -                       continue;
> -
> -               info = &bus_info[dev->bus->number];
> -               if (info->translation_disabled)
> -                       continue;
> -
> -               if (!info->tce_space)
> -                       continue;
> -
> -               calgary_fixup_one_tce_space(dev);
> -
> -       } while (1);
> -
> -       return 0;
> -}
> -
> -/*
> - * We need to be call after pcibios_assign_resources (fs_initcall level)
> - * and before device_initcall.
> - */
> -rootfs_initcall(calgary_fixup_tce_spaces);
> -
> -IOMMU_INIT_POST(detect_calgary);
> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index fa4352dce491..57de2ebff7e2 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -12,7 +12,6 @@
>  #include <asm/dma.h>
>  #include <asm/iommu.h>
>  #include <asm/gart.h>
> -#include <asm/calgary.h>
>  #include <asm/x86_init.h>
>  #include <asm/iommu_table.h>
>
> @@ -112,11 +111,6 @@ static __init int iommu_setup(char *p)
>
>                 gart_parse_options(p);
>
> -#ifdef CONFIG_CALGARY_IOMMU
> -               if (!strncmp(p, "calgary", 7))
> -                       use_calgary = 1;
> -#endif /* CONFIG_CALGARY_IOMMU */
> -
>                 p += strcspn(p, ",");
>                 if (*p == ',')
>                         ++p;
> diff --git a/arch/x86/kernel/tce_64.c b/arch/x86/kernel/tce_64.c
> deleted file mode 100644
> index 6384be751eff..000000000000
> --- a/arch/x86/kernel/tce_64.c
> +++ /dev/null
> @@ -1,177 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * This file manages the translation entries for the IBM Calgary IOMMU.
> - *
> - * Derived from arch/powerpc/platforms/pseries/iommu.c
> - *
> - * Copyright (C) IBM Corporation, 2006
> - *
> - * Author: Jon Mason <jdmason@us.ibm.com>
> - * Author: Muli Ben-Yehuda <muli@il.ibm.com>
> - */
> -
> -#include <linux/types.h>
> -#include <linux/slab.h>
> -#include <linux/mm.h>
> -#include <linux/spinlock.h>
> -#include <linux/string.h>
> -#include <linux/pci.h>
> -#include <linux/dma-mapping.h>
> -#include <linux/memblock.h>
> -#include <asm/tce.h>
> -#include <asm/calgary.h>
> -#include <asm/proto.h>
> -#include <asm/cacheflush.h>
> -
> -/* flush a tce at 'tceaddr' to main memory */
> -static inline void flush_tce(void* tceaddr)
> -{
> -       /* a single tce can't cross a cache line */
> -       if (boot_cpu_has(X86_FEATURE_CLFLUSH))
> -               clflush(tceaddr);
> -       else
> -               wbinvd();
> -}
> -
> -void tce_build(struct iommu_table *tbl, unsigned long index,
> -       unsigned int npages, unsigned long uaddr, int direction)
> -{
> -       u64* tp;
> -       u64 t;
> -       u64 rpn;
> -
> -       t = (1 << TCE_READ_SHIFT);
> -       if (direction != DMA_TO_DEVICE)
> -               t |= (1 << TCE_WRITE_SHIFT);
> -
> -       tp = ((u64*)tbl->it_base) + index;
> -
> -       while (npages--) {
> -               rpn = (virt_to_bus((void*)uaddr)) >> PAGE_SHIFT;
> -               t &= ~TCE_RPN_MASK;
> -               t |= (rpn << TCE_RPN_SHIFT);
> -
> -               *tp = cpu_to_be64(t);
> -               flush_tce(tp);
> -
> -               uaddr += PAGE_SIZE;
> -               tp++;
> -       }
> -}
> -
> -void tce_free(struct iommu_table *tbl, long index, unsigned int npages)
> -{
> -       u64* tp;
> -
> -       tp  = ((u64*)tbl->it_base) + index;
> -
> -       while (npages--) {
> -               *tp = cpu_to_be64(0);
> -               flush_tce(tp);
> -               tp++;
> -       }
> -}
> -
> -static inline unsigned int table_size_to_number_of_entries(unsigned char size)
> -{
> -       /*
> -        * size is the order of the table, 0-7
> -        * smallest table is 8K entries, so shift result by 13 to
> -        * multiply by 8K
> -        */
> -       return (1 << size) << 13;
> -}
> -
> -static int tce_table_setparms(struct pci_dev *dev, struct iommu_table *tbl)
> -{
> -       unsigned int bitmapsz;
> -       unsigned long bmppages;
> -       int ret;
> -
> -       tbl->it_busno = dev->bus->number;
> -
> -       /* set the tce table size - measured in entries */
> -       tbl->it_size = table_size_to_number_of_entries(specified_table_size);
> -
> -       /*
> -        * number of bytes needed for the bitmap size in number of
> -        * entries; we need one bit per entry
> -        */
> -       bitmapsz = tbl->it_size / BITS_PER_BYTE;
> -       bmppages = __get_free_pages(GFP_KERNEL, get_order(bitmapsz));
> -       if (!bmppages) {
> -               printk(KERN_ERR "Calgary: cannot allocate bitmap\n");
> -               ret = -ENOMEM;
> -               goto done;
> -       }
> -
> -       tbl->it_map = (unsigned long*)bmppages;
> -
> -       memset(tbl->it_map, 0, bitmapsz);
> -
> -       tbl->it_hint = 0;
> -
> -       spin_lock_init(&tbl->it_lock);
> -
> -       return 0;
> -
> -done:
> -       return ret;
> -}
> -
> -int __init build_tce_table(struct pci_dev *dev, void __iomem *bbar)
> -{
> -       struct iommu_table *tbl;
> -       int ret;
> -
> -       if (pci_iommu(dev->bus)) {
> -               printk(KERN_ERR "Calgary: dev %p has sysdata->iommu %p\n",
> -                      dev, pci_iommu(dev->bus));
> -               BUG();
> -       }
> -
> -       tbl = kzalloc(sizeof(struct iommu_table), GFP_KERNEL);
> -       if (!tbl) {
> -               printk(KERN_ERR "Calgary: error allocating iommu_table\n");
> -               ret = -ENOMEM;
> -               goto done;
> -       }
> -
> -       ret = tce_table_setparms(dev, tbl);
> -       if (ret)
> -               goto free_tbl;
> -
> -       tbl->bbar = bbar;
> -
> -       set_pci_iommu(dev->bus, tbl);
> -
> -       return 0;
> -
> -free_tbl:
> -       kfree(tbl);
> -done:
> -       return ret;
> -}
> -
> -void * __init alloc_tce_table(void)
> -{
> -       unsigned int size;
> -
> -       size = table_size_to_number_of_entries(specified_table_size);
> -       size *= TCE_ENTRY_SIZE;
> -
> -       return memblock_alloc_low(size, size);
> -}
> -
> -void __init free_tce_table(void *tbl)
> -{
> -       unsigned int size;
> -
> -       if (!tbl)
> -               return;
> -
> -       size = table_size_to_number_of_entries(specified_table_size);
> -       size *= TCE_ENTRY_SIZE;
> -
> -       memblock_free(__pa(tbl), size);
> -}
> --
> 2.20.1
>
