Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F539C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E91208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfKUBpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:45:54 -0500
Received: from mga05.intel.com ([192.55.52.43]:49098 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbfKUBpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:45:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 17:45:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,224,1571727600"; 
   d="scan'208";a="407025911"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga005.fm.intel.com with ESMTP; 20 Nov 2019 17:45:50 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v10 5/6] x86/split_lock: Handle #AC exception for split lock
Date:   Wed, 20 Nov 2019 16:53:22 -0800
Message-Id: <1574297603-198156-6-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently Linux does not expect to see an alignment check exception in
kernel mode (since it does not set CR4.AC). The existing #AC handlers
will just return from exception to the faulting instruction which will
trigger another exception.

Add a new handler for #AC exceptions that will force a panic on split
lock for kernel mode.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/traps.h |  3 +++
 arch/x86/kernel/cpu/intel.c  |  2 ++
 arch/x86/kernel/traps.c      | 22 +++++++++++++++++++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index b25e633033c3..0fa4eef83057 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -172,4 +172,7 @@ enum x86_pf_error_code {
 	X86_PF_INSTR	=		1 << 4,
 	X86_PF_PK	=		1 << 5,
 };
+
+extern bool split_lock_detect_enabled;
+
 #endif /* _ASM_X86_TRAPS_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 2614616fb6d3..bc0c2f288509 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -32,6 +32,8 @@
 #include <asm/apic.h>
 #endif
 
+bool split_lock_detect_enabled;
+
 /*
  * Just in case our CPU detection goes bad, or you have a weird system,
  * allow a way to override the automatic disabling of MPX.
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4bb0f8447112..044033ff4326 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -293,9 +293,29 @@ DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,           0, NULL, "coprocessor segment overru
 DO_ERROR(X86_TRAP_TS,     SIGSEGV,          0, NULL, "invalid TSS",         invalid_TSS)
 DO_ERROR(X86_TRAP_NP,     SIGBUS,           0, NULL, "segment not present", segment_not_present)
 DO_ERROR(X86_TRAP_SS,     SIGBUS,           0, NULL, "stack segment",       stack_segment)
-DO_ERROR(X86_TRAP_AC,     SIGBUS,  BUS_ADRALN, NULL, "alignment check",     alignment_check)
 #undef IP
 
+dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code)
+{
+	unsigned int trapnr = X86_TRAP_AC;
+	char str[] = "alignment check";
+	int signr = SIGBUS;
+
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
+
+	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) == NOTIFY_STOP)
+		return;
+
+	if (!user_mode(regs) && split_lock_detect_enabled)
+		panic("Split lock detected\n");
+
+	cond_local_irq_enable(regs);
+
+	/* Handle #AC generated in any other cases. */
+	do_trap(X86_TRAP_AC, SIGBUS, "alignment check", regs,
+		error_code, BUS_ADRALN, NULL);
+}
+
 #ifdef CONFIG_VMAP_STACK
 __visible void __noreturn handle_stack_overflow(const char *message,
 						struct pt_regs *regs,
-- 
2.19.1

