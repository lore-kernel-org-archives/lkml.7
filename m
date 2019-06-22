Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177B5C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FEF20665
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="njV5NTe7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfFVKKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:10:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49303 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfFVKKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:10:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MAATB92097280
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 03:10:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MAATB92097280
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561198230;
        bh=gTND2DBZeseQSs7ocwQbubb7EY7qtmdUKccOBH4D3xk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=njV5NTe7XmclNk0L0J5bAvcT/JizlNVZazZZxyMkdVcc5dRMl9PWRc/Rro67EodBu
         4aA3p3//h9XBMfdlmb1m6edndnTlc4n6n9tJFrCxReuDlNhKOonkvRqMS9i0h1l/SA
         cnIs6409ShrH8Bqz0ezfUUuOSAEcMhKHgfBbugPG9tHAX+6qPzvyVVnzuSH4WAb/tE
         W/klWZUr3XXfl/+xVy2tq6e94js2aw1sWn1DTPRDny//MZ1o8qtv85fP0v4v0baTfH
         Tb2l68gL2R7mhx0hF4xRviGdnUWjMJCvo5SgunmLlDfpAERrT/2wJPAJvBohB9HXS8
         N3iSF1Wolvriw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MAATp22097277;
        Sat, 22 Jun 2019 03:10:29 -0700
Date:   Sat, 22 Jun 2019 03:10:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Chang S. Bae" <tipbot@zytor.com>
Message-ID: <tip-79e1932fa3cedd731ddbd6af111fe4db8ca109ae@git.kernel.org>
Cc:     luto@kernel.org, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, ak@linux.intel.com,
        chang.seok.bae@intel.com, tglx@linutronix.de
Reply-To: luto@kernel.org, ravi.v.shankar@intel.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, ak@linux.intel.com,
          dave.hansen@linux.intel.com, mingo@kernel.org,
          tglx@linutronix.de, chang.seok.bae@intel.com
In-Reply-To: <1557309753-24073-12-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-12-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/entry/64: Introduce the FIND_PERCPU_BASE macro
Git-Commit-ID: 79e1932fa3cedd731ddbd6af111fe4db8ca109ae
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  79e1932fa3cedd731ddbd6af111fe4db8ca109ae
Gitweb:     https://git.kernel.org/tip/79e1932fa3cedd731ddbd6af111fe4db8ca109ae
Author:     Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate: Wed, 8 May 2019 03:02:26 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:38:54 +0200

x86/entry/64: Introduce the FIND_PERCPU_BASE macro

GSBASE is used to find per-CPU data in the kernel. But when GSBASE is
unknown, the per-CPU base can be found from the per_cpu_offset table with a
CPU NR.  The CPU NR is extracted from the limit field of the CPUNODE entry
in GDT, or by the RDPID instruction. This is a prerequisite for using
FSGSBASE in the low level entry code.

Also, add the GAS-compatible RDPID macro as binutils 2.21 do not support
it. Support is added in version 2.27.

[ tglx: Massaged changelog ]

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/1557309753-24073-12-git-send-email-chang.seok.bae@intel.com

---
 arch/x86/entry/calling.h    | 34 ++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/inst.h | 15 +++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index efb0d1b1f15f..9a524360ae2e 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -6,6 +6,7 @@
 #include <asm/percpu.h>
 #include <asm/asm-offsets.h>
 #include <asm/processor-flags.h>
+#include <asm/inst.h>
 
 /*
 
@@ -345,6 +346,39 @@ For 32-bit we have the following conventions - kernel is built with
 #endif
 .endm
 
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
+.macro GET_PERCPU_BASE reg:req
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
+.macro GET_PERCPU_BASE reg:req
+	movq	pcpu_unit_offsets(%rip), \reg
+.endm
+
+#endif /* CONFIG_SMP */
+
 /*
  * This does 'call enter_from_user_mode' unless we can avoid it based on
  * kernel config or using the static jump infrastructure.
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
