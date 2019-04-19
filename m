Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDAAC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6AF20449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfDSSbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:31:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:24408 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbfDSSa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:30:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Apr 2019 00:08:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,368,1549958400"; 
   d="scan'208";a="150647763"
Received: from bob-dev.sh.intel.com ([10.239.15.128])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Apr 2019 00:08:25 -0700
From:   Tong Bo <bo.tong@intel.com>
To:     luto@kernel.org, x86@kernel.org
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tong Bo <bo.tong@intel.com>
Subject: [PATCH v3] selftests/x86: Support Atom for syscall_arg_fault test
Date:   Fri, 19 Apr 2019 15:10:55 +0800
Message-Id: <1555657855-31855-1-git-send-email-bo.tong@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Atom-based CPUs trigger stack fault when invoke 32-bit SYSENTER instruction
with invalid register values. So we also need SIGBUS handling in this case.

Following is assembly when the fault exception happens.

(gdb) disassemble $eip
Dump of assembler code for function __kernel_vsyscall:
   0xf7fd8fe0 <+0>:     push   %ecx
   0xf7fd8fe1 <+1>:     push   %edx
   0xf7fd8fe2 <+2>:     push   %ebp
   0xf7fd8fe3 <+3>:     mov    %esp,%ebp
   0xf7fd8fe5 <+5>:     sysenter
   0xf7fd8fe7 <+7>:     int    $0x80
=> 0xf7fd8fe9 <+9>:     pop    %ebp
   0xf7fd8fea <+10>:    pop    %edx
   0xf7fd8feb <+11>:    pop    %ecx
   0xf7fd8fec <+12>:    ret
End of assembler dump.

According to Intel SDM, this could also be a Stack Segment Fault(#SS, 12),
except a normal Page Fault(#PF, 14). Especially, in section 6.9 of Vol.3A,
both stack and page faults are within the 10th(lowest priority) class, and
as it said, "exceptions within each class are implementation-dependent and
may vary from processor to processor". It's expected for processors like
Intel Atom to trigger stack fault(SIGBUS), while we get page fault(SIGSEGV)
from common Core processors.

Signed-off-by: Tong Bo <bo.tong@intel.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
 tools/testing/selftests/x86/syscall_arg_fault.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/syscall_arg_fault.c b/tools/testing/selftests/x86/syscall_arg_fault.c
index 7db4fc9..d2548401 100644
--- a/tools/testing/selftests/x86/syscall_arg_fault.c
+++ b/tools/testing/selftests/x86/syscall_arg_fault.c
@@ -43,7 +43,7 @@ static sigjmp_buf jmpbuf;
 
 static volatile sig_atomic_t n_errs;
 
-static void sigsegv(int sig, siginfo_t *info, void *ctx_void)
+static void sigsegv_or_sigbus(int sig, siginfo_t *info, void *ctx_void)
 {
 	ucontext_t *ctx = (ucontext_t*)ctx_void;
 
@@ -73,7 +73,13 @@ int main()
 	if (sigaltstack(&stack, NULL) != 0)
 		err(1, "sigaltstack");
 
-	sethandler(SIGSEGV, sigsegv, SA_ONSTACK);
+	sethandler(SIGSEGV, sigsegv_or_sigbus, SA_ONSTACK);
+	/*
+	 * The actual exception can vary.  On Atom CPUs, we get #SS
+	 * instead of #PF when the vDSO fails to access the stack when
+	 * ESP is too close to 2^32, and #SS causes SIGBUS.
+	 */
+	sethandler(SIGBUS, sigsegv_or_sigbus, SA_ONSTACK);
 	sethandler(SIGILL, sigill, SA_ONSTACK);
 
 	/*
-- 
2.7.4

