Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E49C2D0BE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D805522522
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="N4nfr8PE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfLDXVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 18:21:08 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42825 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbfLDXVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 18:21:06 -0500
Received: by mail-qk1-f194.google.com with SMTP id a10so1643722qko.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 15:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=smj6n8EMZwJiO9OcqZKdj+gFypq1fwZIXw8AeaUdZHE=;
        b=N4nfr8PE7rjna1sy2un2T8I/QbS/FDLXdrJdb0wzVkKCQ0Nj4dVx7WmOcfoTbe5Err
         pCFB4uRN8dThnvHaL9+mll+NSkYsl6VZv2Yd50MyOh3YqGpl02gUx8B4ygniHLmcS6pV
         WwaVWKjUa5ffxJzDu0ELYDn5CgGrFItaaLreOkNgU/KSp+i9Suyx3HVGq7XY4Ej0TjWJ
         Ef1KpevZtJDkH9/dlSJgvPDOft/cByij6ONlj8yl/Cwgbln3gj9DTaq7uPAXOC0aWu+O
         iJaLlmbn717MW1qDNHGc+DEKhEaHFO9VZhUoOdnlsN+wP70BOG79UXsp6UJt4CRy/Zd9
         yz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=smj6n8EMZwJiO9OcqZKdj+gFypq1fwZIXw8AeaUdZHE=;
        b=CTCsMnW+sazC91IV3Lrbpx7EgE+eP8sKgutU0Zr2ZZZbbKHr5gegL7vCNKfY/1BWL8
         +xsPSUJIbb8/6y3DBBPWzAzIZbDMWLo9qex/8/ohjc2+yqMMtBENmoOMfH2YA4r0mb06
         WSZsRZJ10fTwch3KOX93XhIkgeGRf7l/EJF41r3Qtu3mhpgks1ErLPvdih5dxQPNTSlM
         C3uJgXPIrEe9yk8b1lc2SYC3UzDejrd0u7sLXHm8n4fETm25AcfLtVOGDZ5rBBBJzorF
         h7YtBDWMjpUEM8rmgbdeVqPG6/VXieQXkZ2ehkzn2avGGVFGJGfz/Uk2+vddLP735RUd
         Xt2w==
X-Gm-Message-State: APjAAAVLiFTJQIkpC6VHEwnx91tjXrLhw5SZJNgYAN4tP8WWgngOIU/8
        qtA5PAGPmgoRDfYKVCLvK2FYFg==
X-Google-Smtp-Source: APXvYqxwjlWsEl+Nl33Swhk+ma+381+gPtq7UHPUaqWh/EAaKEnwlcNsIHolGzi5TlRApATztOnEyg==
X-Received: by 2002:a37:a744:: with SMTP id q65mr5771564qke.228.1575501664918;
        Wed, 04 Dec 2019 15:21:04 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id t38sm4667864qta.78.2019.12.04.15.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 15:21:04 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        sstabellini@kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, stefan@agner.ch, yamada.masahiro@socionext.com,
        xen-devel@lists.xenproject.org, linux@armlinux.org.uk,
        andrew.cooper3@citrix.com, julien@xen.org
Subject: [PATCH v4 2/6] arm/arm64/xen: use C inlines for privcmd_call
Date:   Wed,  4 Dec 2019 18:20:54 -0500
Message-Id: <20191204232058.2500117-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204232058.2500117-1-pasha.tatashin@soleen.com>
References: <20191204232058.2500117-1-pasha.tatashin@soleen.com>
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
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
---
 arch/arm/include/asm/xen/hypercall.h   |  6 ++++++
 arch/arm/xen/enlighten.c               |  2 +-
 arch/arm/xen/hypercall.S               |  4 ++--
 arch/arm64/include/asm/xen/hypercall.h | 24 ++++++++++++++++++++++++
 arch/arm64/xen/hypercall.S             | 19 ++-----------------
 include/xen/arm/hypercall.h            |  6 +++---
 6 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/arch/arm/include/asm/xen/hypercall.h b/arch/arm/include/asm/xen/hypercall.h
index c6882bba5284..cac5bd9ef519 100644
--- a/arch/arm/include/asm/xen/hypercall.h
+++ b/arch/arm/include/asm/xen/hypercall.h
@@ -2,4 +2,10 @@
 #define _ASM_ARM_XEN_HYPERCALL_H
 #include <xen/arm/hypercall.h>
 
+static inline long privcmd_call(unsigned int call, unsigned long a1,
+				unsigned long a2, unsigned long a3,
+				unsigned long a4, unsigned long a5)
+{
+	return arch_privcmd_call(call, a1, a2, a3, a4, a5);
+}
 #endif /* _ASM_ARM_XEN_HYPERCALL_H */
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
index c3198f9ccd2e..1a74fb28607f 100644
--- a/arch/arm64/include/asm/xen/hypercall.h
+++ b/arch/arm64/include/asm/xen/hypercall.h
@@ -1,5 +1,29 @@
 #ifndef _ASM_ARM64_XEN_HYPERCALL_H
 #define _ASM_ARM64_XEN_HYPERCALL_H
 #include <xen/arm/hypercall.h>
+#include <linux/uaccess.h>
 
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
 #endif /* _ASM_ARM64_XEN_HYPERCALL_H */
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
index babcc08af965..624c8ad7e42a 100644
--- a/include/xen/arm/hypercall.h
+++ b/include/xen/arm/hypercall.h
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
-- 
2.24.0

