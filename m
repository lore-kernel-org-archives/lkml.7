Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7634BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB762087C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbfDBC1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:27:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43524 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfDBC1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 22:27:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2344E80D;
        Mon,  1 Apr 2019 19:27:50 -0700 (PDT)
Received: from a075553-lin.blr.arm.com (a075553-lin.blr.arm.com [10.162.0.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6790B3F59C;
        Mon,  1 Apr 2019 19:27:45 -0700 (PDT)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v8 3/9] KVM: arm64: Move hyp_symbol_addr to fix dependency
Date:   Tue,  2 Apr 2019 07:57:11 +0530
Message-Id: <1554172037-4516-4-git-send-email-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554172037-4516-1-git-send-email-amit.kachhap@arm.com>
References: <1554172037-4516-1-git-send-email-amit.kachhap@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently hyp_symbol_addr is placed in kvm_mmu.h which is mostly
used by __hyp_this_cpu_ptr in kvm_asm.h but it cannot include
kvm_mmu.h directly as kvm_mmu.h uses kvm_ksym_ref which is
defined inside kvm_asm.h. Hence, hyp_symbol_addr is moved inside
kvm_asm.h to fix this dependency on each other.

Also, hyp_symbol_addr corresponding counterpart, kvm_ksym_ref,
is already in kvm_asm.h, making it more sensible to move
kvm_symbol_addr to the same file.

Suggested by: James Morse <james.morse@arm.com>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
---

Changes since v7:
* Slight change in commit message [Julien Thierry].

 arch/arm64/include/asm/kvm_asm.h | 20 ++++++++++++++++++++
 arch/arm64/include/asm/kvm_mmu.h | 20 --------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index f5b79e9..57a07e8 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -80,6 +80,26 @@ extern void __vgic_v3_init_lrs(void);
 
 extern u32 __kvm_get_mdcr_el2(void);
 
+/*
+ * Obtain the PC-relative address of a kernel symbol
+ * s: symbol
+ *
+ * The goal of this macro is to return a symbol's address based on a
+ * PC-relative computation, as opposed to a loading the VA from a
+ * constant pool or something similar. This works well for HYP, as an
+ * absolute VA is guaranteed to be wrong. Only use this if trying to
+ * obtain the address of a symbol (i.e. not something you obtained by
+ * following a pointer).
+ */
+#define hyp_symbol_addr(s)						\
+	({								\
+		typeof(s) *addr;					\
+		asm("adrp	%0, %1\n"				\
+		    "add	%0, %0, :lo12:%1\n"			\
+		    : "=r" (addr) : "S" (&s));				\
+		addr;							\
+	})
+
 /* Home-grown __this_cpu_{ptr,read} variants that always work at HYP */
 #define __hyp_this_cpu_ptr(sym)						\
 	({								\
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index b0742a1..3dea6af 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -118,26 +118,6 @@ static inline unsigned long __kern_hyp_va(unsigned long v)
 #define kern_hyp_va(v) 	((typeof(v))(__kern_hyp_va((unsigned long)(v))))
 
 /*
- * Obtain the PC-relative address of a kernel symbol
- * s: symbol
- *
- * The goal of this macro is to return a symbol's address based on a
- * PC-relative computation, as opposed to a loading the VA from a
- * constant pool or something similar. This works well for HYP, as an
- * absolute VA is guaranteed to be wrong. Only use this if trying to
- * obtain the address of a symbol (i.e. not something you obtained by
- * following a pointer).
- */
-#define hyp_symbol_addr(s)						\
-	({								\
-		typeof(s) *addr;					\
-		asm("adrp	%0, %1\n"				\
-		    "add	%0, %0, :lo12:%1\n"			\
-		    : "=r" (addr) : "S" (&s));				\
-		addr;							\
-	})
-
-/*
  * We currently support using a VM-specified IPA size. For backward
  * compatibility, the default IPA size is fixed to 40bits.
  */
-- 
2.7.4

