Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0A2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A96206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfDCKdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:33:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37038 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbfDCKdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:33:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB9551596;
        Wed,  3 Apr 2019 03:33:37 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 785CC3F59C;
        Wed,  3 Apr 2019 03:33:36 -0700 (PDT)
From:   Will Deacon <will.deacon@arm.com>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        sashal@kernel.org, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.9 BACKPORT 2/2] arm64: debug: Ensure debug handlers check triggering exception level
Date:   Wed,  3 Apr 2019 11:33:26 +0100
Message-Id: <20190403103326.29161-2-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190403103326.29161-1-will.deacon@arm.com>
References: <20190403103326.29161-1-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6bd288569b50bc89fa5513031086746968f585cb upstream.

Debug exception handlers may be called for exceptions generated both by
user and kernel code. In many cases, this is checked explicitly, but
in other cases things either happen to work by happy accident or they
go slightly wrong. For example, executing 'brk #4' from userspace will
enter the kprobes code and be ignored, but the instruction will be
retried forever in userspace instead of delivering a SIGTRAP.

Fix this issue in the most stable-friendly fashion by simply adding
explicit checks of the triggering exception level to all of our debug
exception handlers.

Cc: <stable@vger.kernel.org> # 4.9.y
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/kgdb.c           | 15 ++++++++++++---
 arch/arm64/kernel/probes/kprobes.c |  6 ++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index e017a9493b92..72a660a74ff9 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -231,24 +231,33 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 
 static int kgdb_brk_fn(struct pt_regs *regs, unsigned int esr)
 {
+	if (user_mode(regs))
+		return DBG_HOOK_ERROR;
+
 	kgdb_handle_exception(1, SIGTRAP, 0, regs);
-	return 0;
+	return DBG_HOOK_HANDLED;
 }
 NOKPROBE_SYMBOL(kgdb_brk_fn)
 
 static int kgdb_compiled_brk_fn(struct pt_regs *regs, unsigned int esr)
 {
+	if (user_mode(regs))
+		return DBG_HOOK_ERROR;
+
 	compiled_break = 1;
 	kgdb_handle_exception(1, SIGTRAP, 0, regs);
 
-	return 0;
+	return DBG_HOOK_HANDLED;
 }
 NOKPROBE_SYMBOL(kgdb_compiled_brk_fn);
 
 static int kgdb_step_brk_fn(struct pt_regs *regs, unsigned int esr)
 {
+	if (user_mode(regs))
+		return DBG_HOOK_ERROR;
+
 	kgdb_handle_exception(1, SIGTRAP, 0, regs);
-	return 0;
+	return DBG_HOOK_HANDLED;
 }
 NOKPROBE_SYMBOL(kgdb_step_brk_fn);
 
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index d2b1b624ddc3..17f647103ed7 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -450,6 +450,9 @@ kprobe_single_step_handler(struct pt_regs *regs, unsigned int esr)
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 	int retval;
 
+	if (user_mode(regs))
+		return DBG_HOOK_ERROR;
+
 	/* return error if this is not our step */
 	retval = kprobe_ss_hit(kcb, instruction_pointer(regs));
 
@@ -466,6 +469,9 @@ kprobe_single_step_handler(struct pt_regs *regs, unsigned int esr)
 int __kprobes
 kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr)
 {
+	if (user_mode(regs))
+		return DBG_HOOK_ERROR;
+
 	kprobe_handler(regs);
 	return DBG_HOOK_HANDLED;
 }
-- 
2.11.0

