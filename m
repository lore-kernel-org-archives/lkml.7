Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F1AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF2D218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfCOUHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:07:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:22898 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfCOUHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:07:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 13:07:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,483,1544515200"; 
   d="scan'208";a="307617716"
Received: from chang-linux-3.sc.intel.com ([143.183.85.65])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2019 13:07:02 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [RESEND PATCH v6 07/12] x86/fsgsbase/64: Introduce the FIND_PERCPU_BASE macro
Date:   Fri, 15 Mar 2019 13:06:40 -0700
Message-Id: <1552680405-5265-8-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552680405-5265-1-git-send-email-chang.seok.bae@intel.com>
References: <1552680405-5265-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GSBASE is used to find per-CPU data in the kernel. But when it is unknown,
the per-CPU base can be found from the per_cpu_offset table with a CPU NR.
The CPU NR is extracted from the limit field of the CPUNODE entry in GDT,
or by the RDPID instruction.

Also, add the GAS-compatible RDPID macro.

The new macro will be used on a following patch.

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/include/asm/fsgsbase.h | 41 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/inst.h     | 15 ++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index aefd53767a5d..5e3dfbe8c1bf 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -78,6 +78,47 @@ extern void x86_gsbase_write_cpu_inactive(unsigned long gsbase);
 
 #endif /* CONFIG_X86_64 */
 
+#else /* __ASSEMBLY__ */
+
+#ifdef CONFIG_X86_64
+
+#include <asm/inst.h>
+
+#ifdef CONFIG_SMP
+
+/*
+ * CPU/node NR is loaded from the limit (size) field of a special segment
+ * descriptor entry in GDT.
+ */
+.macro LOAD_CPU_AND_NODE_SEG_LIMIT reg:req
+	movq	$__CPUNODE_SEG, \reg
+	lsl	\reg, \reg
+.endm
+
+/*
+ * Fetch the per-CPU GSBASE value for this processor and put it in @reg.
+ * We normally use %gs for accessing per-CPU data, but we are setting up
+ * %gs here and obviously can not use %gs itself to access per-CPU data.
+ */
+.macro FIND_PERCPU_BASE reg:req
+	ALTERNATIVE \
+		"LOAD_CPU_AND_NODE_SEG_LIMIT \reg", \
+		"RDPID	\reg", \
+		X86_FEATURE_RDPID
+	andq	$VDSO_CPUNODE_MASK, \reg
+	movq	__per_cpu_offset(, \reg, 8), \reg
+.endm
+
+#else
+
+.macro FIND_PERCPU_BASE reg:req
+	movq	pcpu_unit_offsets(%rip), \reg
+.endm
+
+#endif /* CONFIG_SMP */
+
+#endif /* CONFIG_X86_64 */
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_FSGSBASE_H */
diff --git a/arch/x86/include/asm/inst.h b/arch/x86/include/asm/inst.h
index f5a796da07f8..d063841a17e3 100644
--- a/arch/x86/include/asm/inst.h
+++ b/arch/x86/include/asm/inst.h
@@ -306,6 +306,21 @@
 	.endif
 	MODRM 0xc0 movq_r64_xmm_opd1 movq_r64_xmm_opd2
 	.endm
+
+.macro RDPID opd
+	REG_TYPE rdpid_opd_type \opd
+	.if rdpid_opd_type == REG_TYPE_R64
+	R64_NUM rdpid_opd \opd
+	.else
+	R32_NUM rdpid_opd \opd
+	.endif
+	.byte 0xf3
+	.if rdpid_opd > 7
+	PFX_REX rdpid_opd 0
+	.endif
+	.byte 0x0f, 0xc7
+	MODRM 0xc0 rdpid_opd 0x7
+.endm
 #endif
 
 #endif
-- 
2.19.1

