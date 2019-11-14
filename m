Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3048C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDAB20715
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AcwcMhI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfKNHj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 02:39:26 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33104 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfKNHj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 02:39:26 -0500
Received: by mail-oi1-f193.google.com with SMTP id m193so4436196oig.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 23:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=7Ad+PLr3QmhYM1M2mlxBYtAoRJ2xUG9cwnquHYSdYYc=;
        b=AcwcMhI74SCrXe3Tga44jqAG4VTYR6K7oGPZ7LqXYIJ+JYgTIxm6pPs5nVYEufUdtO
         zWcfu2FxA021825z2XTfQHvm5a5dPluQ4cPPkpiMbkdKAdz0hToJUpWOnoGXQY4Wj7S6
         Lg2IwtzMPMe2/DP16fb2QQh9/mbYuBNgB89FLpY/DQrRtUGEy/evUNWs/FI9JPt7QCH8
         94dnK17nc8aQculyLZXc7uhAk+WZ8iEdh7VNhSzEbCdgc0cFyoJMVkrUxMxosWUfuCy3
         1uYLOpOSIctkOSLr+S2U1LZDN7lycQfT6A4Nf872V0XVE5g7lxAGQ4J3ZGq7Z++8PH8V
         d0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=7Ad+PLr3QmhYM1M2mlxBYtAoRJ2xUG9cwnquHYSdYYc=;
        b=cdKBX9Hd9YogndDnGMmunoDoFeYB4C9XJnE8bSyNH2VxkH0RWv/LiQ3sPAvqyjubfD
         6Qp3dWwYdzggnBCzDKo3E9zUub9+51xzERMlQtVIT3QGzv9YBjDEZGtSyx/JmGutb99/
         9bwLSreZr9uZmCRQKfjMBjU9YO5bK69ErmaU2WvykZdtIqZ45KIjH6eNXk1Wb348Zs7B
         HiBYR+gs1VAtjTy9AzR6IauxG3IbMnGqSJ9pneURsQMkzktgERaspAWseYKyWy/bxi0g
         3+gTo+MOSBTjzDakxwugfF3u9/M9a/rdZ/NfNGuy2C0slCA9U+nL0wivmhW5MaM3nZu9
         QYXw==
X-Gm-Message-State: APjAAAULfJaPPtCW8S7gZBSLFaUWoZbp8eCKhWxEMqB/TbHTcHM6m25E
        cbiWv8NdzZA5tcbbEAFaFxGm6Q==
X-Google-Smtp-Source: APXvYqxcYguJniRypgeL05dkeDnKe1oIHb++Pi7KGjXR+QmIyaQpxjHreQau9YonHzM1i7T7C7Co9Q==
X-Received: by 2002:aca:c583:: with SMTP id v125mr2301060oif.156.1573717165164;
        Wed, 13 Nov 2019 23:39:25 -0800 (PST)
Received: from localhost (wsip-98-172-187-222.no.no.cox.net. [98.172.187.222])
        by smtp.gmail.com with ESMTPSA id r4sm1608411otg.55.2019.11.13.23.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 23:39:24 -0800 (PST)
Date:   Wed, 13 Nov 2019 23:39:24 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/15] riscv: provide native clint access for M-mode
In-Reply-To: <20191017173743.5430-10-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1911132337520.11342@viisi.sifive.com>
References: <20191017173743.5430-1-hch@lst.de> <20191017173743.5430-10-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2019, Christoph Hellwig wrote:

> RISC-V has the concept of a cpu level interrupt controller.  The
> interface for it is split between a standardized part that is exposed
> as bits in the mstatus/sstatus register and the mie/mip/sie/sip
> CRS.  But the bit to actually trigger IPIs is not standardized and
> just mentioned as implementable using MMIO.
> 
> Add support for IPIs using MMIO using the SiFive clint layout (which is
> also shared by Ariane, Kendrye and the Qemu virt platform).  Additional
> the MMIO block also support the time value and timer compare registers,
> so they are also set up using the same OF node.  Support for other
> layouts should also be relatively easy to add in the future.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks, queued the following for v5.5-rc1.


- Paul

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 28 Oct 2019 13:10:38 +0100
Subject: [PATCH] riscv: provide native clint access for M-mode

RISC-V has the concept of a cpu level interrupt controller.  The
interface for it is split between a standardized part that is exposed
as bits in the mstatus/sstatus register and the mie/mip/sie/sip
CRS.  But the bit to actually trigger IPIs is not standardized and
just mentioned as implementable using MMIO.

Add support for IPIs using MMIO using the SiFive clint layout (which
is also shared by Ariane, Kendryte and the Qemu virt platform).
Additionally the MMIO block also supports the time value and timer
compare registers, so they are also set up using the same OF node.
Support for other layouts should also be relatively easy to add in the
future.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
[paul.walmsley@sifive.com: update include guard format; fix checkpatch
 issues; minor commit message cleanups]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/include/asm/clint.h | 39 ++++++++++++++++++++++++++++++
 arch/riscv/include/asm/sbi.h   |  2 ++
 arch/riscv/kernel/Makefile     |  1 +
 arch/riscv/kernel/clint.c      | 44 ++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/setup.c      |  2 ++
 arch/riscv/kernel/smp.c        | 16 ++++++++++---
 arch/riscv/kernel/smpboot.c    |  4 ++++
 7 files changed, 105 insertions(+), 3 deletions(-)
 create mode 100644 arch/riscv/include/asm/clint.h
 create mode 100644 arch/riscv/kernel/clint.c

diff --git a/arch/riscv/include/asm/clint.h b/arch/riscv/include/asm/clint.h
new file mode 100644
index 000000000000..6eaa2eedd694
--- /dev/null
+++ b/arch/riscv/include/asm/clint.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_CLINT_H
+#define _ASM_RISCV_CLINT_H 1
+
+#include <linux/io.h>
+#include <linux/smp.h>
+
+#ifdef CONFIG_RISCV_M_MODE
+extern u32 __iomem *clint_ipi_base;
+
+void clint_init_boot_cpu(void);
+
+static inline void clint_send_ipi_single(unsigned long hartid)
+{
+	writel(1, clint_ipi_base + hartid);
+}
+
+static inline void clint_send_ipi_mask(const struct cpumask *hartid_mask)
+{
+	int hartid;
+
+	for_each_cpu(hartid, hartid_mask)
+		clint_send_ipi_single(hartid);
+}
+
+static inline void clint_clear_ipi(unsigned long hartid)
+{
+	writel(0, clint_ipi_base + hartid);
+}
+#else /* CONFIG_RISCV_M_MODE */
+#define clint_init_boot_cpu()	do { } while (0)
+
+/* stubs to for code is only reachable under IS_ENABLED(CONFIG_RISCV_M_MODE): */
+void clint_send_ipi_single(unsigned long hartid);
+void clint_send_ipi_mask(const struct cpumask *hartid_mask);
+void clint_clear_ipi(unsigned long hartid);
+#endif /* CONFIG_RISCV_M_MODE */
+
+#endif /* _ASM_RISCV_CLINT_H */
diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 8e14d4819d0f..2570c1e683d3 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -97,6 +97,8 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 #else /* CONFIG_RISCV_SBI */
 /* stubs for code that is only reachable under IS_ENABLED(CONFIG_RISCV_SBI): */
 void sbi_set_timer(uint64_t stime_value);
+void sbi_clear_ipi(void);
+void sbi_send_ipi(const unsigned long *hart_mask);
 void sbi_remote_fence_i(const unsigned long *hart_mask);
 #endif /* CONFIG_RISCV_SBI */
 #endif /* _ASM_RISCV_SBI_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index d8c35fa93cc6..2dca51046899 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -29,6 +29,7 @@ obj-y	+= vdso.o
 obj-y	+= cacheinfo.o
 obj-y	+= vdso/
 
+obj-$(CONFIG_RISCV_M_MODE)	+= clint.o
 obj-$(CONFIG_FPU)		+= fpu.o
 obj-$(CONFIG_SMP)		+= smpboot.o
 obj-$(CONFIG_SMP)		+= smp.o
diff --git a/arch/riscv/kernel/clint.c b/arch/riscv/kernel/clint.c
new file mode 100644
index 000000000000..3647980d14c3
--- /dev/null
+++ b/arch/riscv/kernel/clint.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Christoph Hellwig.
+ */
+
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/types.h>
+#include <asm/clint.h>
+#include <asm/csr.h>
+#include <asm/timex.h>
+#include <asm/smp.h>
+
+/*
+ * This is the layout used by the SiFive clint, which is also shared by the qemu
+ * virt platform, and the Kendryte KD210 at least.
+ */
+#define CLINT_IPI_OFF		0
+#define CLINT_TIME_CMP_OFF	0x4000
+#define CLINT_TIME_VAL_OFF	0xbff8
+
+u32 __iomem *clint_ipi_base;
+
+void clint_init_boot_cpu(void)
+{
+	struct device_node *np;
+	void __iomem *base;
+
+	np = of_find_compatible_node(NULL, NULL, "riscv,clint0");
+	if (!np) {
+		panic("clint not found");
+		return;
+	}
+
+	base = of_iomap(np, 0);
+	if (!base)
+		panic("could not map CLINT");
+
+	clint_ipi_base = base + CLINT_IPI_OFF;
+	riscv_time_cmp = base + CLINT_TIME_CMP_OFF;
+	riscv_time_val = base + CLINT_TIME_VAL_OFF;
+
+	clint_clear_ipi(boot_cpu_hartid);
+}
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 845ae0e12115..365ff8420bfe 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -17,6 +17,7 @@
 #include <linux/sched/task.h>
 #include <linux/swiotlb.h>
 
+#include <asm/clint.h>
 #include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/pgtable.h>
@@ -67,6 +68,7 @@ void __init setup_arch(char **cmdline_p)
 	setup_bootmem();
 	paging_init();
 	unflatten_device_tree();
+	clint_init_boot_cpu();
 
 #ifdef CONFIG_SWIOTLB
 	swiotlb_init(1);
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index c0fbc04e6810..eb878abcaaf8 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -16,6 +16,7 @@
 #include <linux/seq_file.h>
 #include <linux/delay.h>
 
+#include <asm/clint.h>
 #include <asm/sbi.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
@@ -92,7 +93,10 @@ static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
 	smp_mb__after_atomic();
 
 	riscv_cpuid_to_hartid_mask(mask, &hartid_mask);
-	sbi_send_ipi(cpumask_bits(&hartid_mask));
+	if (IS_ENABLED(CONFIG_RISCV_SBI))
+		sbi_send_ipi(cpumask_bits(&hartid_mask));
+	else
+		clint_send_ipi_mask(&hartid_mask);
 }
 
 static void send_ipi_single(int cpu, enum ipi_message_type op)
@@ -103,12 +107,18 @@ static void send_ipi_single(int cpu, enum ipi_message_type op)
 	set_bit(op, &ipi_data[cpu].bits);
 	smp_mb__after_atomic();
 
-	sbi_send_ipi(cpumask_bits(cpumask_of(hartid)));
+	if (IS_ENABLED(CONFIG_RISCV_SBI))
+		sbi_send_ipi(cpumask_bits(cpumask_of(hartid)));
+	else
+		clint_send_ipi_single(hartid);
 }
 
 static inline void clear_ipi(void)
 {
-	csr_clear(CSR_IP, IE_SIE);
+	if (IS_ENABLED(CONFIG_RISCV_SBI))
+		csr_clear(CSR_IP, IE_SIE);
+	else
+		clint_clear_ipi(cpuid_to_hartid_map(smp_processor_id()));
 }
 
 void riscv_software_interrupt(void)
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 261f4087cc39..8bc01f0ca73b 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/mm.h>
+#include <asm/clint.h>
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
@@ -137,6 +138,9 @@ asmlinkage __visible void __init smp_callin(void)
 {
 	struct mm_struct *mm = &init_mm;
 
+	if (!IS_ENABLED(CONFIG_RISCV_SBI))
+		clint_clear_ipi(cpuid_to_hartid_map(smp_processor_id()));
+
 	/* All kernel threads share the same mm context.  */
 	mmgrab(mm);
 	current->active_mm = mm;
-- 
2.24.0.rc0

