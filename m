Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB38DC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2180206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="dH7iy4be"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKUSsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:48:12 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41142 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUSsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:48:11 -0500
Received: by mail-qv1-f65.google.com with SMTP id g18so1839724qvp.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 10:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6SUpT/Cq7WAcFMI7EYou95uAqCpN60QbhWisTQcUAZE=;
        b=dH7iy4beDQA0dlnL78YTIs1dGMcBcpDEizGZylqSWQJeyua11ap3URFttiAu/XsDpw
         uGhONdmEzz1V61aPrClJAF0x4CMm0s/eZ2Au+DZLfBX+sye9mdDqbNx6RNOMoFk7Cv3e
         G/IBd/It6LWi2PQ9i1n6EDAA/NCvxgP4kytwwT53Qsw5a1Bs4Mz/dzvIZHbdlEfV7Xml
         Q2+R9+vCRQXedpAVJ9CYG7BcByVgmJ+MFiAh1rMS8sjOULTohB/xGlV+KowLwZ15vuVB
         +gsRPbtV7gvbSCTrTDy0hIj+pn+t6BjWbW2G3+ValNHGifxejI4aI9CDnh/9t7Jr+4Ft
         L/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6SUpT/Cq7WAcFMI7EYou95uAqCpN60QbhWisTQcUAZE=;
        b=nQac6FVT2jsKrgMpMRYu2NT3thO+PskNEdLCZa6bD22h5LdNgXaWRN208oVcbH8Pdw
         uypX2fQeIH4SMCwW48fgo8jQHGje0e6qKLO4whhZ+6r4xFVL/we4M6nQBIiw5hM7cX7z
         4tX+alErJHRqsqydvFOAM4LSVWusZB72Ai2xDRHseU2VCKO0n7HqE1qmnpuw8lTwME15
         iW2I1FcIdK2/DycESfVW2wPhLAx4+LVzJbjV8Fgjxy+wdpFOb7DKx9XwRWK0lhkmZsjz
         66S+Ox8kJ+/ny3HFmiP9ZFyY6iV7Vm8o8GAaTi0mMgbCR967T9MBGYQWxsn3/r4hqDBo
         Gdpg==
X-Gm-Message-State: APjAAAXFNK/Ss8ie+T1rHLV7ZJdqDk2ZIVnyfsdwlpIKutMbkGDx141U
        znKq4sy6nCphDryqV2zwt5wWxQ==
X-Google-Smtp-Source: APXvYqwHPZo6IUc+mQlModGko0y+bUwKpgW94ZH45M2odE42WQE3R6U+OVG3m1WRxN6oOvJcf7Ymkw==
X-Received: by 2002:ad4:44af:: with SMTP id n15mr358027qvt.174.1574362089507;
        Thu, 21 Nov 2019 10:48:09 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id t2sm1811634qkt.95.2019.11.21.10.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 10:48:08 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        sstabellini@kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, stefan@agner.ch, yamada.masahiro@socionext.com,
        xen-devel@lists.xenproject.org, linux@armlinux.org.uk
Subject: [PATCH 1/3] arm/arm64/xen: use C inlines for privcmd_call
Date:   Thu, 21 Nov 2019 13:48:03 -0500
Message-Id: <20191121184805.414758-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191121184805.414758-1-pasha.tatashin@soleen.com>
References: <20191121184805.414758-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

privcmd_call requires to enable access to userspace for the
duration of the hypercall.

Currently, this is done via assembly macros. Change it to C
inlines instead.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm/include/asm/assembler.h |  2 +-
 arch/arm/include/asm/uaccess.h   | 32 ++++++++++++++++++++++++++------
 arch/arm/xen/enlighten.c         |  2 +-
 arch/arm/xen/hypercall.S         | 15 ++-------------
 arch/arm64/xen/hypercall.S       | 19 ++-----------------
 include/xen/arm/hypercall.h      | 23 ++++++++++++++++++++---
 6 files changed, 52 insertions(+), 41 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 99929122dad7..8e9262a0f016 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -480,7 +480,7 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	.macro	uaccess_disable, tmp, isb=1
 #ifdef CONFIG_CPU_SW_DOMAIN_PAN
 	/*
-	 * Whenever we re-enter userspace, the domains should always be
+	 * Whenever we re-enter kernel, the domains should always be
 	 * set appropriately.
 	 */
 	mov	\tmp, #DACR_UACCESS_DISABLE
diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 98c6b91be4a8..79d4efa3eb62 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -16,6 +16,23 @@
 
 #include <asm/extable.h>
 
+#ifdef CONFIG_CPU_SW_DOMAIN_PAN
+static __always_inline void uaccess_enable(void)
+{
+	unsigned long val = DACR_UACCESS_ENABLE;
+
+	asm volatile("mcr p15, 0, %0, c3, c0, 0" : : "r" (val));
+	isb();
+}
+
+static __always_inline void uaccess_disable(void)
+{
+	unsigned long val = DACR_UACCESS_ENABLE;
+
+	asm volatile("mcr p15, 0, %0, c3, c0, 0" : : "r" (val));
+	isb();
+}
+
 /*
  * These two functions allow hooking accesses to userspace to increase
  * system integrity by ensuring that the kernel can not inadvertantly
@@ -24,7 +41,6 @@
  */
 static __always_inline unsigned int uaccess_save_and_enable(void)
 {
-#ifdef CONFIG_CPU_SW_DOMAIN_PAN
 	unsigned int old_domain = get_domain();
 
 	/* Set the current domain access to permit user accesses */
@@ -32,18 +48,22 @@ static __always_inline unsigned int uaccess_save_and_enable(void)
 		   domain_val(DOMAIN_USER, DOMAIN_CLIENT));
 
 	return old_domain;
-#else
-	return 0;
-#endif
 }
 
 static __always_inline void uaccess_restore(unsigned int flags)
 {
-#ifdef CONFIG_CPU_SW_DOMAIN_PAN
 	/* Restore the user access mask */
 	set_domain(flags);
-#endif
 }
+#else
+static __always_inline void uaccess_enable(void) {}
+static __always_inline void uaccess_disable(void) {}
+static __always_inline unsigned int uaccess_save_and_enable(void)
+{
+	return 0;
+}
+static __always_inline void uaccess_restore(unsigned int flags) {}
+#endif /* CONFIG_CPU_SW_DOMAIN_PAN */
 
 /*
  * These two are intentionally not defined anywhere - if the kernel
diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index dd6804a64f1a..e87280c6d25d 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -440,4 +440,4 @@ EXPORT_SYMBOL_GPL(HYPERVISOR_platform_op_raw);
 EXPORT_SYMBOL_GPL(HYPERVISOR_multicall);
 EXPORT_SYMBOL_GPL(HYPERVISOR_vm_assist);
 EXPORT_SYMBOL_GPL(HYPERVISOR_dm_op);
-EXPORT_SYMBOL_GPL(privcmd_call);
+EXPORT_SYMBOL_GPL(arch_privcmd_call);
diff --git a/arch/arm/xen/hypercall.S b/arch/arm/xen/hypercall.S
index b11bba542fac..2f5be0dc6195 100644
--- a/arch/arm/xen/hypercall.S
+++ b/arch/arm/xen/hypercall.S
@@ -94,29 +94,18 @@ HYPERCALL2(multicall);
 HYPERCALL2(vm_assist);
 HYPERCALL3(dm_op);
 
-ENTRY(privcmd_call)
+ENTRY(arch_privcmd_call)
 	stmdb sp!, {r4}
 	mov r12, r0
 	mov r0, r1
 	mov r1, r2
 	mov r2, r3
 	ldr r3, [sp, #8]
-	/*
-	 * Privcmd calls are issued by the userspace. We need to allow the
-	 * kernel to access the userspace memory before issuing the hypercall.
-	 */
-	uaccess_enable r4
 
 	/* r4 is loaded now as we use it as scratch register before */
 	ldr r4, [sp, #4]
 	__HVC(XEN_IMM)
 
-	/*
-	 * Disable userspace access from kernel. This is fine to do it
-	 * unconditionally as no set_fs(KERNEL_DS) is called before.
-	 */
-	uaccess_disable r4
-
 	ldm sp!, {r4}
 	ret lr
-ENDPROC(privcmd_call);
+ENDPROC(arch_privcmd_call);
diff --git a/arch/arm64/xen/hypercall.S b/arch/arm64/xen/hypercall.S
index c5f05c4a4d00..921611778d2a 100644
--- a/arch/arm64/xen/hypercall.S
+++ b/arch/arm64/xen/hypercall.S
@@ -49,7 +49,6 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
-#include <asm/asm-uaccess.h>
 #include <xen/interface/xen.h>
 
 
@@ -86,27 +85,13 @@ HYPERCALL2(multicall);
 HYPERCALL2(vm_assist);
 HYPERCALL3(dm_op);
 
-ENTRY(privcmd_call)
+ENTRY(arch_privcmd_call)
 	mov x16, x0
 	mov x0, x1
 	mov x1, x2
 	mov x2, x3
 	mov x3, x4
 	mov x4, x5
-	/*
-	 * Privcmd calls are issued by the userspace. The kernel needs to
-	 * enable access to TTBR0_EL1 as the hypervisor would issue stage 1
-	 * translations to user memory via AT instructions. Since AT
-	 * instructions are not affected by the PAN bit (ARMv8.1), we only
-	 * need the explicit uaccess_enable/disable if the TTBR0 PAN emulation
-	 * is enabled (it implies that hardware UAO and PAN disabled).
-	 */
-	uaccess_ttbr0_enable x6, x7, x8
 	hvc XEN_IMM
-
-	/*
-	 * Disable userspace access from kernel once the hyp call completed.
-	 */
-	uaccess_ttbr0_disable x6, x7
 	ret
-ENDPROC(privcmd_call);
+ENDPROC(arch_privcmd_call);
diff --git a/include/xen/arm/hypercall.h b/include/xen/arm/hypercall.h
index b40485e54d80..cfb704fd78c8 100644
--- a/include/xen/arm/hypercall.h
+++ b/include/xen/arm/hypercall.h
@@ -34,16 +34,33 @@
 #define _ASM_ARM_XEN_HYPERCALL_H
 
 #include <linux/bug.h>
+#include <linux/uaccess.h>
 
 #include <xen/interface/xen.h>
 #include <xen/interface/sched.h>
 #include <xen/interface/platform.h>
 
 struct xen_dm_op_buf;
+long arch_privcmd_call(unsigned int call, unsigned long a1,
+		       unsigned long a2, unsigned long a3,
+		       unsigned long a4, unsigned long a5);
 
-long privcmd_call(unsigned call, unsigned long a1,
-		unsigned long a2, unsigned long a3,
-		unsigned long a4, unsigned long a5);
+static inline long privcmd_call(unsigned int call, unsigned long a1,
+				unsigned long a2, unsigned long a3,
+				unsigned long a4, unsigned long a5)
+{
+	long rv;
+
+	/*
+	 * Privcmd calls are issued by the userspace. We need to allow the
+	 * kernel to access the userspace memory before issuing the hypercall.
+	 */
+	uaccess_enable();
+	rv = arch_privcmd_call(call, a1, a2, a3, a4, a5);
+	uaccess_disable();
+
+	return rv;
+}
 int HYPERVISOR_xen_version(int cmd, void *arg);
 int HYPERVISOR_console_io(int cmd, int count, char *str);
 int HYPERVISOR_grant_table_op(unsigned int cmd, void *uop, unsigned int count);
-- 
2.24.0

