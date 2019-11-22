Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69038C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 02:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388A5206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 02:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="o4/+H91q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfKVCYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 21:24:14 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46925 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfKVCYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 21:24:12 -0500
Received: by mail-qt1-f193.google.com with SMTP id r20so6073247qtp.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 18:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IzInbUaZ5lVZxuC5PuS/lufSNJLQaIPVzX6ubMoOkDc=;
        b=o4/+H91qK7SYb+s7vQHxKfn2cEXNLroSDcEukU5daKzRAKh1oi1Udrq1Hsyd/8g0XJ
         Pv8eCkaAxTRLvB/x8T6ozulHTy8Qu9uVNfpx9VQdeJ3DUdiyx77ZaR7I08ll6shh3ykW
         LOSKkbSE74/2BUl6fbj6QXdMWUSmTs7v1a39+1BKSMLwO0MLCPDAWM94S/lFgkn2bvS9
         OHLwBNd1Oy6SwdYQ8cvlMFbiH/arKXZ587+B7D0Uy3gsl2YSoENBrbx0JtLS1jaucqGn
         EUptQjG31mP+YpC05fM6Yhf0mLY7qfhxaXjjDvg7wHI/kIc7+wW0/JyRdoRLLeluuUBM
         WNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IzInbUaZ5lVZxuC5PuS/lufSNJLQaIPVzX6ubMoOkDc=;
        b=FYvtQRJenJKm7FEXGQatNHKanj5jPHwDx/b4SmiDiPQVNuEo1peiHfzxRizRWHbb0+
         0oKeOB0s5vRR/Lue0wZYwddvQI8RyTmjdO1lINiNxrZFO35ksYOsbe7uSmyWjCJGoqK5
         8qVdQmqOS4TvDlKCWiPSmSYTVeN/YPn6H+apS/GTAN2/cm5Qxfxu2G5AnZF1Q7hdVqpW
         0ItqiLboI6zeHbnHgSSp3MGfkpTFRQKZDr/dxqaE7TZaL44VfPd2gmPmubcJITcj1tIw
         QBtMviJ6WjmzkzfiAxJLOck6p6JFLemlro/BAgfVtOepgID0mt500nzzCVT50oupAiO5
         t4Ug==
X-Gm-Message-State: APjAAAWsLrK+2rQvoJsLnZMbl7UOqNIjaCRzzzOHIdwZwrKogAnEg7+Y
        rSuAyPn9u7dy/uoluDh41kBgJw==
X-Google-Smtp-Source: APXvYqx9BCxMqz1R2llqGOr6YphEnZxw3URDyaCMq7OQH8SjuGiCpAImBgMzaGID2EPxUvCj8SFafw==
X-Received: by 2002:ac8:698d:: with SMTP id o13mr12274027qtq.68.1574389450093;
        Thu, 21 Nov 2019 18:24:10 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id z5sm2609801qtm.9.2019.11.21.18.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 18:24:09 -0800 (PST)
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
Subject: [PATCH v2 1/3] arm/arm64/xen: use C inlines for privcmd_call
Date:   Thu, 21 Nov 2019 21:24:04 -0500
Message-Id: <20191122022406.590141-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122022406.590141-1-pasha.tatashin@soleen.com>
References: <20191122022406.590141-1-pasha.tatashin@soleen.com>
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
 arch/arm/include/asm/assembler.h       |  2 +-
 arch/arm/include/asm/xen/hypercall.h   | 10 +++++++++
 arch/arm/xen/enlighten.c               |  2 +-
 arch/arm/xen/hypercall.S               |  4 ++--
 arch/arm64/include/asm/xen/hypercall.h | 28 ++++++++++++++++++++++++++
 arch/arm64/xen/hypercall.S             | 19 ++---------------
 include/xen/arm/hypercall.h            | 12 +++++------
 7 files changed, 50 insertions(+), 27 deletions(-)

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
diff --git a/arch/arm/include/asm/xen/hypercall.h b/arch/arm/include/asm/xen/hypercall.h
index 3522cbaed316..cac5bd9ef519 100644
--- a/arch/arm/include/asm/xen/hypercall.h
+++ b/arch/arm/include/asm/xen/hypercall.h
@@ -1 +1,11 @@
+#ifndef _ASM_ARM_XEN_HYPERCALL_H
+#define _ASM_ARM_XEN_HYPERCALL_H
 #include <xen/arm/hypercall.h>
+
+static inline long privcmd_call(unsigned int call, unsigned long a1,
+				unsigned long a2, unsigned long a3,
+				unsigned long a4, unsigned long a5)
+{
+	return arch_privcmd_call(call, a1, a2, a3, a4, a5);
+}
+#endif /* _ASM_ARM_XEN_HYPERCALL_H */
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
index b11bba542fac..277078c7da49 100644
--- a/arch/arm/xen/hypercall.S
+++ b/arch/arm/xen/hypercall.S
@@ -94,7 +94,7 @@ HYPERCALL2(multicall);
 HYPERCALL2(vm_assist);
 HYPERCALL3(dm_op);
 
-ENTRY(privcmd_call)
+ENTRY(arch_privcmd_call)
 	stmdb sp!, {r4}
 	mov r12, r0
 	mov r0, r1
@@ -119,4 +119,4 @@ ENTRY(privcmd_call)
 
 	ldm sp!, {r4}
 	ret lr
-ENDPROC(privcmd_call);
+ENDPROC(arch_privcmd_call);
diff --git a/arch/arm64/include/asm/xen/hypercall.h b/arch/arm64/include/asm/xen/hypercall.h
index 3522cbaed316..1a74fb28607f 100644
--- a/arch/arm64/include/asm/xen/hypercall.h
+++ b/arch/arm64/include/asm/xen/hypercall.h
@@ -1 +1,29 @@
+#ifndef _ASM_ARM64_XEN_HYPERCALL_H
+#define _ASM_ARM64_XEN_HYPERCALL_H
 #include <xen/arm/hypercall.h>
+#include <linux/uaccess.h>
+
+static inline long privcmd_call(unsigned int call, unsigned long a1,
+				unsigned long a2, unsigned long a3,
+				unsigned long a4, unsigned long a5)
+{
+	long rv;
+
+	/*
+	 * Privcmd calls are issued by the userspace. The kernel needs to
+	 * enable access to TTBR0_EL1 as the hypervisor would issue stage 1
+	 * translations to user memory via AT instructions. Since AT
+	 * instructions are not affected by the PAN bit (ARMv8.1), we only
+	 * need the explicit uaccess_enable/disable if the TTBR0 PAN emulation
+	 * is enabled (it implies that hardware UAO and PAN disabled).
+	 */
+	uaccess_ttbr0_enable();
+	rv = arch_privcmd_call(call, a1, a2, a3, a4, a5);
+	/*
+	 * Disable userspace access from kernel once the hyp call completed.
+	 */
+	uaccess_ttbr0_disable();
+
+	return rv;
+}
+#endif /* _ASM_ARM64_XEN_HYPERCALL_H */
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
index b40485e54d80..624c8ad7e42a 100644
--- a/include/xen/arm/hypercall.h
+++ b/include/xen/arm/hypercall.h
@@ -30,8 +30,8 @@
  * IN THE SOFTWARE.
  */
 
-#ifndef _ASM_ARM_XEN_HYPERCALL_H
-#define _ASM_ARM_XEN_HYPERCALL_H
+#ifndef _ARM_XEN_HYPERCALL_H
+#define _ARM_XEN_HYPERCALL_H
 
 #include <linux/bug.h>
 
@@ -41,9 +41,9 @@
 
 struct xen_dm_op_buf;
 
-long privcmd_call(unsigned call, unsigned long a1,
-		unsigned long a2, unsigned long a3,
-		unsigned long a4, unsigned long a5);
+long arch_privcmd_call(unsigned int call, unsigned long a1,
+		       unsigned long a2, unsigned long a3,
+		       unsigned long a4, unsigned long a5);
 int HYPERVISOR_xen_version(int cmd, void *arg);
 int HYPERVISOR_console_io(int cmd, int count, char *str);
 int HYPERVISOR_grant_table_op(unsigned int cmd, void *uop, unsigned int count);
@@ -88,4 +88,4 @@ MULTI_mmu_update(struct multicall_entry *mcl, struct mmu_update *req,
 	BUG();
 }
 
-#endif /* _ASM_ARM_XEN_HYPERCALL_H */
+#endif /* _ARM_XEN_HYPERCALL_H */
-- 
2.24.0

