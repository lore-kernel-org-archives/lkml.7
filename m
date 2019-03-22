Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A8CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A8F206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256518;
	bh=1htCl6tD3KSwtXjsV0pIkzTDPx2MxGeGSbjIXuH375w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R+09YwS4YLxSpDKIVGhbWeg7q+vJyvm1VgX32O2TDGGwmUbqRpUgz5Wtu4UPjrMwD
	 0wY2ZrUbyO9mW/xsVL6I7RkCGrsz1VzHv5ma59yduDfxGeL76FT+RtMDTiT/f7IcEm
	 KaBwZvzjJXpvLeX7XWYumCFaXlJB4rYWgDtUl8/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389180AbfCVMIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:08:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388269AbfCVMId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:08:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A9CD2082C;
        Fri, 22 Mar 2019 12:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256511;
        bh=1htCl6tD3KSwtXjsV0pIkzTDPx2MxGeGSbjIXuH375w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O4Nl+wmJuuthYuwhH7YZRvZwayViKEfIsqNmi2a/yqd72D7G8silnN9Vv2bwEn26X
         ZlcWIH3GdnPMkSSRxBRZO7tec65jMEDBzY0iaQgK/9Aph1wUofJaNmcRZP9YupV0Vt
         HZufO2ODbIruJwDXNzhvQ9gdEhvycTVTc49MnkJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.19 233/280] arm64: debug: Ensure debug handlers check triggering exception level
Date:   Fri, 22 Mar 2019 12:16:26 +0100
Message-Id: <20190322111337.674610361@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit 6bd288569b50bc89fa5513031086746968f585cb upstream.

Debug exception handlers may be called for exceptions generated both by
user and kernel code. In many cases, this is checked explicitly, but
in other cases things either happen to work by happy accident or they
go slightly wrong. For example, executing 'brk #4' from userspace will
enter the kprobes code and be ignored, but the instruction will be
retried forever in userspace instead of delivering a SIGTRAP.

Fix this issue in the most stable-friendly fashion by simply adding
explicit checks of the triggering exception level to all of our debug
exception handlers.

Cc: <stable@vger.kernel.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/kgdb.c           |   14 ++++++++++----
 arch/arm64/kernel/probes/kprobes.c |    6 ++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -244,27 +244,33 @@ int kgdb_arch_handle_exception(int excep
 
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
-	if (!kgdb_single_step)
+	if (user_mode(regs) || !kgdb_single_step)
 		return DBG_HOOK_ERROR;
 
 	kgdb_handle_exception(1, SIGTRAP, 0, regs);
-	return 0;
+	return DBG_HOOK_HANDLED;
 }
 NOKPROBE_SYMBOL(kgdb_step_brk_fn);
 
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -450,6 +450,9 @@ kprobe_single_step_handler(struct pt_reg
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 	int retval;
 
+	if (user_mode(regs))
+		return DBG_HOOK_ERROR;
+
 	/* return error if this is not our step */
 	retval = kprobe_ss_hit(kcb, instruction_pointer(regs));
 
@@ -466,6 +469,9 @@ kprobe_single_step_handler(struct pt_reg
 int __kprobes
 kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr)
 {
+	if (user_mode(regs))
+		return DBG_HOOK_ERROR;
+
 	kprobe_handler(regs);
 	return DBG_HOOK_HANDLED;
 }


