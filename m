Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63294CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B86205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WEsWUmh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733037AbfJ1Hmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 03:42:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44882 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbfJ1Hmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:42:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id q26so2695918pfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 00:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=L4m60UOD+ooGOVzctozeQvam6HXu3Gt5g4bBAc5A+wE=;
        b=WEsWUmh7RN2p53cp84XX+iXl40s5+H5WrC5nanWxvlVs75JvyxSVVyF1yw6mSwHh+R
         3KunRF7La4krx4TRMxem5RrWnkXOn5UmfJqUtxbM7MQaxRKAubmfoI4oByLtmlNSTSE+
         3g1WA2yFNZcqbWTeHaxcQHgetLtdfubWf8GI+oLXvcCTkL+l1PrtLah1ynxkDgvBC+3L
         Z+KC91uJmDU0ThWaP6IZfXZfUL4wMr5BPtiXjTWNIGWbCs7ZWXq17Gcd8lf4MndaQ8xf
         b//WFeVrcDeZVhsXxPhtTW6OsJpc7NexmCOcI3oaPIYrDgjQ637zGpX43VFDDI53DHwc
         rSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L4m60UOD+ooGOVzctozeQvam6HXu3Gt5g4bBAc5A+wE=;
        b=P4mlmboJKo90lA5XiqLWxf47+EBkV0GvgAvZyAN6trTkWFfnpTUs/cJxpI0s1h00XB
         pnD3QLY1N2e4CEbLyZq3tXhh5rDs/adgcV047aDGM06bEmK7QXIjEu/WtzlgjrqG/qTV
         b8SIRsb/fYhmRPxHN/4T2lYfuoFzuryupvJxlG7bO2z77WZXdsKRCu9UvPnuPsymq0rj
         tPBS9RpEAAXcLmF1S513rqUasyw8HeEPwvQ8QdmszRurWHxMjmL50uyYOMdxQqLBa+qH
         pZo4XgCtttXvrlEuHpKec3ucrECQM8ec+ux7gSTdr6Ci+h7eDemf/m1eWnhweWN8vrXF
         RfRQ==
X-Gm-Message-State: APjAAAXAwh7/jFWnIk8f5BOR1Up1uKrGstOFIRxY56NGi2ADdnsY24uO
        eJwHqhQHOjHfsuli82NUNIvRxDFmlWk=
X-Google-Smtp-Source: APXvYqzzmFlEpOlkVN8RBFt3koIXJWDhJrSQuPVArdzUWJFVC7WwFbrY2slC+AKTiN6J4mfUaU7/Aw==
X-Received: by 2002:aa7:9ad0:: with SMTP id x16mr19245786pfp.51.1572248570303;
        Mon, 28 Oct 2019 00:42:50 -0700 (PDT)
Received: from gamma07.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id b4sm8350683pju.16.2019.10.28.00.42.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Oct 2019 00:42:49 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        paul.walmsley@sifive.com, palmer@sifive.com
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH] riscv: clean up the macro format in each header file
Date:   Mon, 28 Oct 2019 00:42:47 -0700
Message-Id: <1572248567-22504-1-git-send-email-zong.li@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many different formats in each header now, such as
_ASM_XXX_H, __ASM_XXX_H, _ASM_RISCV_XXX_H, RISCV_XXX_H, etc., This patch
tries to unify the format by using _ASM_RISCV_XXX_H, because the most
header use it now. This patch also adds the conditional to the headers
if they lost it.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/include/asm/asm-prototypes.h | 1 +
 arch/riscv/include/asm/current.h        | 6 +++---
 arch/riscv/include/asm/ftrace.h         | 5 +++++
 arch/riscv/include/asm/futex.h          | 6 +++---
 arch/riscv/include/asm/hwcap.h          | 7 ++++---
 arch/riscv/include/asm/image.h          | 6 +++---
 arch/riscv/include/asm/kprobes.h        | 6 +++---
 arch/riscv/include/asm/mmiowb.h         | 2 +-
 arch/riscv/include/asm/pci.h            | 6 +++---
 arch/riscv/include/asm/sbi.h            | 2 +-
 arch/riscv/include/asm/sparsemem.h      | 6 +++---
 arch/riscv/include/asm/spinlock_types.h | 2 +-
 arch/riscv/include/uapi/asm/elf.h       | 6 +++---
 arch/riscv/include/uapi/asm/hwcap.h     | 6 +++---
 arch/riscv/include/uapi/asm/ucontext.h  | 6 +++---
 15 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
index c9fecd12..dd62b69 100644
--- a/arch/riscv/include/asm/asm-prototypes.h
+++ b/arch/riscv/include/asm/asm-prototypes.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_RISCV_PROTOTYPES_H
+#define _ASM_RISCV_PROTOTYPES_H
 
 #include <linux/ftrace.h>
 #include <asm-generic/asm-prototypes.h>
diff --git a/arch/riscv/include/asm/current.h b/arch/riscv/include/asm/current.h
index 44dcf7f..dd973ef 100644
--- a/arch/riscv/include/asm/current.h
+++ b/arch/riscv/include/asm/current.h
@@ -7,8 +7,8 @@
  */
 
 
-#ifndef __ASM_CURRENT_H
-#define __ASM_CURRENT_H
+#ifndef _ASM_RISCV_CURRENT_H
+#define _ASM_RISCV_CURRENT_H
 
 #include <linux/bug.h>
 #include <linux/compiler.h>
@@ -34,4 +34,4 @@ static __always_inline struct task_struct *get_current(void)
 
 #endif /* __ASSEMBLY__ */
 
-#endif /* __ASM_CURRENT_H */
+#endif /* _ASM_RISCV_CURRENT_H */
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index c6dcc52..ace8a6e 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -1,6 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2017 Andes Technology Corporation */
 
+#ifndef _ASM_RISCV_FTRACE_H
+#define _ASM_RISCV_FTRACE_H
+
 /*
  * The graph frame test is not possible if CONFIG_FRAME_POINTER is not enabled.
  * Check arch/riscv/kernel/mcount.S for detail.
@@ -64,3 +67,5 @@ do {									\
  */
 #define MCOUNT_INSN_SIZE 8
 #endif
+
+#endif /* _ASM_RISCV_FTRACE_H */
diff --git a/arch/riscv/include/asm/futex.h b/arch/riscv/include/asm/futex.h
index 4ad6409..2073105 100644
--- a/arch/riscv/include/asm/futex.h
+++ b/arch/riscv/include/asm/futex.h
@@ -4,8 +4,8 @@
  * Copyright (c) 2018  Jim Wilson (jimw@sifive.com)
  */
 
-#ifndef _ASM_FUTEX_H
-#define _ASM_FUTEX_H
+#ifndef _ASM_RISCV_FUTEX_H
+#define _ASM_RISCV_FUTEX_H
 
 #include <linux/futex.h>
 #include <linux/uaccess.h>
@@ -112,4 +112,4 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	return ret;
 }
 
-#endif /* _ASM_FUTEX_H */
+#endif /* _ASM_RISCV_FUTEX_H */
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 7ecb7c6..1bb0cd0 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -5,8 +5,8 @@
  * Copyright (C) 2012 ARM Ltd.
  * Copyright (C) 2017 SiFive
  */
-#ifndef __ASM_HWCAP_H
-#define __ASM_HWCAP_H
+#ifndef _ASM_RISCV_HWCAP_H
+#define _ASM_RISCV_HWCAP_H
 
 #include <uapi/asm/hwcap.h>
 
@@ -23,4 +23,5 @@ enum {
 
 extern unsigned long elf_hwcap;
 #endif
-#endif
+
+#endif /* _ASM_RISCV_HWCAP_H */
diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
index 344db52..7b0f92b 100644
--- a/arch/riscv/include/asm/image.h
+++ b/arch/riscv/include/asm/image.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-#ifndef __ASM_IMAGE_H
-#define __ASM_IMAGE_H
+#ifndef _ASM_RISCV_IMAGE_H
+#define _ASM_RISCV_IMAGE_H
 
 #define RISCV_IMAGE_MAGIC	"RISCV\0\0\0"
 #define RISCV_IMAGE_MAGIC2	"RSC\x05"
@@ -62,4 +62,4 @@ struct riscv_image_header {
 	u32 res4;
 };
 #endif /* __ASSEMBLY__ */
-#endif /* __ASM_IMAGE_H */
+#endif /* _ASM_RISCV_IMAGE_H */
diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
index 96e30ef..56a98ea3 100644
--- a/arch/riscv/include/asm/kprobes.h
+++ b/arch/riscv/include/asm/kprobes.h
@@ -6,9 +6,9 @@
  * Copyright (C) 2017 SiFive
  */
 
-#ifndef _RISCV_KPROBES_H
-#define _RISCV_KPROBES_H
+#ifndef _ASM_RISCV_KPROBES_H
+#define _ASM_RISCV_KPROBES_H
 
 #include <asm-generic/kprobes.h>
 
-#endif /* _RISCV_KPROBES_H */
+#endif /* _ASM_RISCV_KPROBES_H */
diff --git a/arch/riscv/include/asm/mmiowb.h b/arch/riscv/include/asm/mmiowb.h
index 5d7e3a2..bb4091f 100644
--- a/arch/riscv/include/asm/mmiowb.h
+++ b/arch/riscv/include/asm/mmiowb.h
@@ -11,4 +11,4 @@
 
 #include <asm-generic/mmiowb.h>
 
-#endif	/* ASM_RISCV_MMIOWB_H */
+#endif	/* _ASM_RISCV_MMIOWB_H */
diff --git a/arch/riscv/include/asm/pci.h b/arch/riscv/include/asm/pci.h
index 5ac8daa..1c473a1 100644
--- a/arch/riscv/include/asm/pci.h
+++ b/arch/riscv/include/asm/pci.h
@@ -3,8 +3,8 @@
  * Copyright (C) 2016 SiFive
  */
 
-#ifndef __ASM_RISCV_PCI_H
-#define __ASM_RISCV_PCI_H
+#ifndef _ASM_RISCV_PCI_H
+#define _ASM_RISCV_PCI_H
 
 #include <linux/types.h>
 #include <linux/slab.h>
@@ -34,4 +34,4 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 }
 #endif  /* CONFIG_PCI */
 
-#endif  /* __ASM_PCI_H */
+#endif  /* _ASM_RISCV_PCI_H */
diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 21134b3..b0d6fda 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -94,4 +94,4 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 	SBI_CALL_4(SBI_REMOTE_SFENCE_VMA_ASID, hart_mask, start, size, asid);
 }
 
-#endif
+#endif /* _ASM_RISCV_SBI_H */
diff --git a/arch/riscv/include/asm/sparsemem.h b/arch/riscv/include/asm/sparsemem.h
index b58ba2d9..45a7018 100644
--- a/arch/riscv/include/asm/sparsemem.h
+++ b/arch/riscv/include/asm/sparsemem.h
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-#ifndef __ASM_SPARSEMEM_H
-#define __ASM_SPARSEMEM_H
+#ifndef _ASM_RISCV_SPARSEMEM_H
+#define _ASM_RISCV_SPARSEMEM_H
 
 #ifdef CONFIG_SPARSEMEM
 #define MAX_PHYSMEM_BITS	CONFIG_PA_BITS
 #define SECTION_SIZE_BITS	27
 #endif /* CONFIG_SPARSEMEM */
 
-#endif /* __ASM_SPARSEMEM_H */
+#endif /* _ASM_RISCV_SPARSEMEM_H */
diff --git a/arch/riscv/include/asm/spinlock_types.h b/arch/riscv/include/asm/spinlock_types.h
index 888cbf8..f398e76 100644
--- a/arch/riscv/include/asm/spinlock_types.h
+++ b/arch/riscv/include/asm/spinlock_types.h
@@ -22,4 +22,4 @@ typedef struct {
 
 #define __ARCH_RW_LOCK_UNLOCKED		{ 0 }
 
-#endif
+#endif /* _ASM_RISCV_SPINLOCK_TYPES_H */
diff --git a/arch/riscv/include/uapi/asm/elf.h b/arch/riscv/include/uapi/asm/elf.h
index 644a00c..d696d66 100644
--- a/arch/riscv/include/uapi/asm/elf.h
+++ b/arch/riscv/include/uapi/asm/elf.h
@@ -9,8 +9,8 @@
  * (at your option) any later version.
  */
 
-#ifndef _UAPI_ASM_ELF_H
-#define _UAPI_ASM_ELF_H
+#ifndef _UAPI_ASM_RISCV_ELF_H
+#define _UAPI_ASM_RISCV_ELF_H
 
 #include <asm/ptrace.h>
 
@@ -95,4 +95,4 @@ typedef union __riscv_fp_state elf_fpregset_t;
 #define R_RISCV_32_PCREL	57
 
 
-#endif /* _UAPI_ASM_ELF_H */
+#endif /* _UAPI_ASM_RISCV_ELF_H */
diff --git a/arch/riscv/include/uapi/asm/hwcap.h b/arch/riscv/include/uapi/asm/hwcap.h
index 4e76460..dee98ee 100644
--- a/arch/riscv/include/uapi/asm/hwcap.h
+++ b/arch/riscv/include/uapi/asm/hwcap.h
@@ -5,8 +5,8 @@
  * Copyright (C) 2012 ARM Ltd.
  * Copyright (C) 2017 SiFive
  */
-#ifndef __UAPI_ASM_HWCAP_H
-#define __UAPI_ASM_HWCAP_H
+#ifndef _UAPI_ASM_RISCV_HWCAP_H
+#define _UAPI_ASM_RISCV_HWCAP_H
 
 /*
  * Linux saves the floating-point registers according to the ISA Linux is
@@ -22,4 +22,4 @@
 #define COMPAT_HWCAP_ISA_D	(1 << ('D' - 'A'))
 #define COMPAT_HWCAP_ISA_C	(1 << ('C' - 'A'))
 
-#endif
+#endif /* _UAPI_ASM_RISCV_HWCAP_H */
diff --git a/arch/riscv/include/uapi/asm/ucontext.h b/arch/riscv/include/uapi/asm/ucontext.h
index 411dd7b..44eb993 100644
--- a/arch/riscv/include/uapi/asm/ucontext.h
+++ b/arch/riscv/include/uapi/asm/ucontext.h
@@ -5,8 +5,8 @@
  *
  * This file was copied from arch/arm64/include/uapi/asm/ucontext.h
  */
-#ifndef _UAPI__ASM_UCONTEXT_H
-#define _UAPI__ASM_UCONTEXT_H
+#ifndef _UAPI_ASM_RISCV_UCONTEXT_H
+#define _UAPI_ASM_RISCV_UCONTEXT_H
 
 #include <linux/types.h>
 
@@ -31,4 +31,4 @@ struct ucontext {
 	struct sigcontext uc_mcontext;
 };
 
-#endif /* _UAPI__ASM_UCONTEXT_H */
+#endif /* _UAPI_ASM_RISCV_UCONTEXT_H */
-- 
2.7.4

