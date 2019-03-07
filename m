Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18378C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE23920840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfCGIWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:22:55 -0500
Received: from mga01.intel.com ([192.55.52.88]:64740 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfCGIWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:22:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 00:22:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="325019415"
Received: from bob-dev.sh.intel.com ([10.239.15.128])
  by fmsmga006.fm.intel.com with ESMTP; 07 Mar 2019 00:22:53 -0800
From:   Tong Bo <bo.tong@intel.com>
To:     shuah@kernel.org
Cc:     luto@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tong Bo <bo.tong@intel.com>
Subject: [PATCH] selftests/x86: Support Atom for syscall_arg_fault test
Date:   Thu,  7 Mar 2019 16:25:40 +0800
Message-Id: <1551947140-22166-1-git-send-email-bo.tong@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Atom-based CPUs trigger stack fault when invoke 32-bit SYSENTER instruction
with invalid register values. So we also need sigbus handling in this case.

Following is assembly when the fault expception happens.

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

Accroding to Intel SDM, this could also be a Stack Segment Fault(#SS, 12),
except a normal Page Fault(#PF, 14). Especially, in section 6.9 of Vol.3A,
both stack and page faults are within the 10th(lowest priority) class, and
as it said, "exceptions within each class are implementation-dependent and
may vary from processor to processor". It's expected for processors like
Intel Atom to trigger stack fault(sigbus), while we get page fault(sigsegv)
from common Core processors.

Signed-off-by: Tong Bo <bo.tong@intel.com>
---
 tools/testing/selftests/x86/syscall_arg_fault.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/syscall_arg_fault.c b/tools/testing/selftests/x86/syscall_arg_fault.c
index 7db4fc9..38cd246 100644
--- a/tools/testing/selftests/x86/syscall_arg_fault.c
+++ b/tools/testing/selftests/x86/syscall_arg_fault.c
@@ -43,7 +43,7 @@ static sigjmp_buf jmpbuf;
 
 static volatile sig_atomic_t n_errs;
 
-static void sigsegv(int sig, siginfo_t *info, void *ctx_void)
+static void sigsegv_or_sigbus(int sig, siginfo_t *info, void *ctx_void)
 {
 	ucontext_t *ctx = (ucontext_t*)ctx_void;
 
@@ -73,7 +73,9 @@ int main()
 	if (sigaltstack(&stack, NULL) != 0)
 		err(1, "sigaltstack");
 
-	sethandler(SIGSEGV, sigsegv, SA_ONSTACK);
+	sethandler(SIGSEGV, sigsegv_or_sigbus, SA_ONSTACK);
+	/* Atom CPUs may trigger sigbus for below SYSENTER exception case */
+	sethandler(SIGBUS, sigsegv_or_sigbus, SA_ONSTACK);
 	sethandler(SIGILL, sigill, SA_ONSTACK);
 
 	/*
-- 
2.7.4

