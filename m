Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2409C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7E1206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NFRzr5vX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfL0SEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 13:04:13 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:38872 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727444AbfL0SEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 13:04:00 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B62A442CEB;
        Fri, 27 Dec 2019 18:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1577469839; bh=MNHNunTibBM6/zU1ZK+HBdMiwgE+FDn1kLfKOuU2ejU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NFRzr5vX10j5cvfrnnMxaCZizC089F49QB6wtbFU1fLS5hloQ1YiovmJEEq0VkcJh
         g0r1Vn1JveWXPjc0zOQ5hFpC0v0hfv3GuqanqZ3gMZaJl0fVbps3XrvqhrSb5VHTVJ
         f0AydX4yMezyLZkIa8AqJp1p4YFNK6gFyB2C3ldu4FBx+4or5MbEmGQozxKzgiyZBv
         9KkDiaMA6ZBoi2f2NAyzXx3GRkopp2QEiPI4Xttc9AOX0fU7MeteI29UX0kP4rvohb
         AKO9zEaldrGqzeA2PEIjNGDySyT4bVkLZJawwn4fcvEZrGP+etXfLEYXR+K1t7awJP
         CWs9qfnLRZ6RA==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.65])
        by mailhost.synopsys.com (Postfix) with ESMTP id EB563A006C;
        Fri, 27 Dec 2019 18:03:56 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 3/5] ARC: handle DSP presence in HW
Date:   Fri, 27 Dec 2019 21:03:45 +0300
Message-Id: <20191227180347.3579-4-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191227180347.3579-1-Eugeniy.Paltsev@synopsys.com>
References: <20191227180347.3579-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of DSP extension presence in HW some instructions
(related to integer multiply, multiply-accumulate, and divide
operation) executes on this DSP execution unit. So their
execution will depend on dsp configuration register (DSP_CTRL)

As we want these instructions to execute the same way regardless
of DSP presence we need to set DSP_CTRL properly. However this
register can be modified bu any usersace app therefore any
usersace may break kernel execution.

Fix that by configure DSP_CTRL in CPU early code and in IRQs
entries.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/Kconfig                   | 25 ++++++++++++++++-
 arch/arc/include/asm/arcregs.h     | 12 ++++++++
 arch/arc/include/asm/dsp-impl.h    | 45 ++++++++++++++++++++++++++++++
 arch/arc/include/asm/entry-arcv2.h |  3 ++
 arch/arc/kernel/head.S             |  4 +++
 arch/arc/kernel/setup.c            |  4 +++
 6 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100644 arch/arc/include/asm/dsp-impl.h

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 8383155c8c82..b9cd7ce3f878 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -404,13 +404,36 @@ config ARC_HAS_DIV_REM
 	default y
 
 config ARC_HAS_ACCL_REGS
-	bool "Reg Pair ACCL:ACCH (FPU and/or MPY > 6)"
+	bool "Reg Pair ACCL:ACCH (FPU and/or MPY > 6 and/or DSP)"
 	default y
 	help
 	  Depending on the configuration, CPU can contain accumulator reg-pair
 	  (also referred to as r58:r59). These can also be used by gcc as GPR so
 	  kernel needs to save/restore per process
 
+choice
+	prompt "DSP support"
+	default ARC_NO_DSP
+	help
+	  Depending on the configuration, CPU can contain DSP registers
+	  (ACC0_GLO, ACC0_GHI, DSP_BFLY0, DSP_CTRL, DSP_FFT_CTRL).
+	  Bellow is options describing how to handle these registers in
+	  interrupt entry / exit and in context switch.
+
+config ARC_NO_DSP
+	bool "No DSP extension presence in HW"
+	help
+	  No DSP extension presence in HW
+
+config ARC_DSP_KERNEL
+	bool "DSP extension in HW, no support for userspace"
+	select ARC_HAS_ACCL_REGS
+	help
+	  DSP extension presence in HW, no support for DSP-enabled userspace
+	  applications. We don't save / restore DSP registers and only do
+	  some minimal preparations so userspace won't be able to break kernel
+endchoice
+
 config ARC_IRQ_NO_AUTOSAVE
 	bool "Disable hardware autosave regfile on interrupts"
 	default n
diff --git a/arch/arc/include/asm/arcregs.h b/arch/arc/include/asm/arcregs.h
index 5134f0baf33c..0004b1e9b325 100644
--- a/arch/arc/include/asm/arcregs.h
+++ b/arch/arc/include/asm/arcregs.h
@@ -116,6 +116,18 @@
 #define ARC_AUX_DPFP_2H         0x304
 #define ARC_AUX_DPFP_STAT       0x305
 
+/*
+ * DSP-related registers
+ */
+#define ARC_AUX_DSP_BUILD	0x7A
+#define ARC_AUX_ACC0_LO		0x580
+#define ARC_AUX_ACC0_GLO	0x581
+#define ARC_AUX_ACC0_HI		0x582
+#define ARC_AUX_ACC0_GHI	0x583
+#define ARC_AUX_DSP_BFLY0	0x598
+#define ARC_AUX_DSP_CTRL	0x59F
+#define ARC_AUX_DSP_FFT_CTRL	0x59E
+
 #ifndef __ASSEMBLY__
 
 #include <soc/arc/aux.h>
diff --git a/arch/arc/include/asm/dsp-impl.h b/arch/arc/include/asm/dsp-impl.h
new file mode 100644
index 000000000000..788093cbe689
--- /dev/null
+++ b/arch/arc/include/asm/dsp-impl.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 Synopsys, Inc. (www.synopsys.com)
+ *
+ * Author: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
+ */
+#ifndef __ASM_ARC_DSP_IMPL_H
+#define __ASM_ARC_DSP_IMPL_H
+
+#define DSP_CTRL_DISABLED_ALL		0
+
+#ifdef __ASSEMBLY__
+
+/* clobbers r5 register */
+.macro DSP_EARLY_INIT
+	lr	r5, [ARC_AUX_DSP_BUILD]
+	bmsk	r5, r5, 7
+	breq    r5, 0, 1f
+	mov	r5, DSP_CTRL_DISABLED_ALL
+	sr	r5, [ARC_AUX_DSP_CTRL]
+1:
+.endm
+
+/* clobbers r58, r59 registers pair */
+.macro DSP_SAVE_REGFILE_IRQ
+#if defined(CONFIG_ARC_DSP_KERNEL)
+	/* Drop any changes to DSP_CTRL made by userspace so userspace won't be
+	 * able to break kernel */
+	mov	r58, DSP_CTRL_DISABLED_ALL
+	sr	r58, [ARC_AUX_DSP_CTRL]
+#endif /* ARC_DSP_KERNEL */
+.endm
+
+#else /* __ASEMBLY__ */
+
+static inline bool dsp_exist(void)
+{
+	struct bcr_generic bcr;
+
+	READ_BCR(ARC_AUX_DSP_BUILD, bcr);
+	return !!bcr.ver;
+}
+
+#endif /* __ASEMBLY__ */
+#endif /* __ASM_ARC_DSP_IMPL_H */
diff --git a/arch/arc/include/asm/entry-arcv2.h b/arch/arc/include/asm/entry-arcv2.h
index 0b8b63d0bec1..e3f8bd3e2eba 100644
--- a/arch/arc/include/asm/entry-arcv2.h
+++ b/arch/arc/include/asm/entry-arcv2.h
@@ -4,6 +4,7 @@
 #define __ASM_ARC_ENTRY_ARCV2_H
 
 #include <asm/asm-offsets.h>
+#include <asm/dsp-impl.h>
 #include <asm/irqflags-arcv2.h>
 #include <asm/thread_info.h>	/* For THREAD_SIZE */
 
@@ -165,6 +166,8 @@
 	ST2	r58, r59, PT_r58
 #endif
 
+	/* clobbers r58, r59 registers pair, so must be after r58, r59 save */
+	DSP_SAVE_REGFILE_IRQ
 .endm
 
 /*------------------------------------------------------------------------*/
diff --git a/arch/arc/kernel/head.S b/arch/arc/kernel/head.S
index 6f41265f6250..6eb23f1545ee 100644
--- a/arch/arc/kernel/head.S
+++ b/arch/arc/kernel/head.S
@@ -14,6 +14,7 @@
 #include <asm/entry.h>
 #include <asm/arcregs.h>
 #include <asm/cache.h>
+#include <asm/dsp-impl.h>
 #include <asm/irqflags.h>
 
 .macro CPU_EARLY_SETUP
@@ -59,6 +60,9 @@
 #endif
 	kflag	r5
 #endif
+	; Config DSP_CTRL properly, so kernel may use integer multiply,
+	; multiply-accumulate, and divide operations
+	DSP_EARLY_INIT
 .endm
 
 	.section .init.text, "ax",@progbits
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index edb55b6ee278..b3995dd673d9 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -26,6 +26,7 @@
 #include <asm/unwind.h>
 #include <asm/mach_desc.h>
 #include <asm/smp.h>
+#include <asm/dsp-impl.h>
 
 #define FIX_PTR(x)  __asm__ __volatile__(";" : "+r"(x))
 
@@ -444,6 +445,9 @@ static void arc_chk_core_config(void)
 		/* Accumulator Low:High pair (r58:59) present if DSP MPY or FPU */
 		present = cpu->extn_mpy.dsp | cpu->extn.fpu_sp | cpu->extn.fpu_dp;
 		CHK_OPT_STRICT(CONFIG_ARC_HAS_ACCL_REGS, present);
+
+		present = dsp_exist();
+		CHK_OPT_STRICT(CONFIG_ARC_DSP_KERNEL, present);
 	}
 }
 
-- 
2.21.0

