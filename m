Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEADC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9288B20643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="i6Oj2dc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfDSTFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:05:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729156AbfDSTDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:03:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JFq7nD332641
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 08:52:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JFq7nD332641
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555689128;
        bh=xMI/e7R1bXJPK/JEkUYViqaFSdUq+gDDaNzW/fOTPN8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=i6Oj2dc+u6ozpOe9BXK9nGohlnXKozCwWbltr5mjbs0GG5ZWBiC2YxIGplPPA980k
         ASEyklBDH4MOWcLYHJ+TSjnofI4SjExJ3A9Y7ZeW/o6SrnP29jc0DuQYvMsvvU3LUq
         qWWKaeZa57047QU7FTevFdYiIY0tg/r/XxqPX6dJa9v7Ye+SNHMHIvnI/0nR3ZEgAs
         id71qw22B8APUhSnEXiEbxn2Y1ogaqyLKTKv1sH67X9OUSI5TDvbVgck3Cip8QxplJ
         ePtcMhYJrc5UA1CatQHofbIeuDqNIXvH4y5Wfr2uwky5wP+NmwDjWs50Jc9pzGdqmU
         1UUoD+carxWMQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JFq6Y9332638;
        Fri, 19 Apr 2019 08:52:06 -0700
Date:   Fri, 19 Apr 2019 08:52:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-c03e27506a564ec7db1b179e7464835901f49751@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        ak@linux.intel.com, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, ak@linux.intel.com
In-Reply-To: <20190330004743.29541-1-andi@firstfloor.org>
References: <20190330004743.29541-1-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/asm: Mark all top level asm statements as .text
Git-Commit-ID: c03e27506a564ec7db1b179e7464835901f49751
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

Commit-ID:  c03e27506a564ec7db1b179e7464835901f49751
Gitweb:     https://git.kernel.org/tip/c03e27506a564ec7db1b179e7464835901f49751
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Fri, 29 Mar 2019 17:47:35 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 19 Apr 2019 17:46:55 +0200

x86/asm: Mark all top level asm statements as .text

With gcc toplevel assembler statements that do not mark themselves as .text
may end up in other sections. This causes LTO boot crashes because various
assembler statements ended up in the middle of the initcall section. It's
also a latent problem without LTO, although it's currently not known to
cause any real problems.

According to the gcc team it's expected behavior.

Always mark all the top level assembler statements as text so that they
switch to the right section.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190330004743.29541-1-andi@firstfloor.org

---
 arch/x86/kernel/cpu/amd.c      | 3 ++-
 arch/x86/kernel/kprobes/core.c | 1 +
 arch/x86/lib/error-inject.c    | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 01004bfb1a1b..1bcb489e07e7 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -83,7 +83,8 @@ static inline int wrmsrl_amd_safe(unsigned msr, unsigned long long val)
  */
 
 extern __visible void vide(void);
-__asm__(".globl vide\n"
+__asm__(".text\n"
+	".globl vide\n"
 	".type vide, @function\n"
 	".align 4\n"
 	"vide: ret\n");
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index a034cb808e7e..31ab91c9c4e9 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -715,6 +715,7 @@ NOKPROBE_SYMBOL(kprobe_int3_handler);
  * calls trampoline_handler() runs, which calls the kretprobe's handler.
  */
 asm(
+	".text\n"
 	".global kretprobe_trampoline\n"
 	".type kretprobe_trampoline, @function\n"
 	"kretprobe_trampoline:\n"
diff --git a/arch/x86/lib/error-inject.c b/arch/x86/lib/error-inject.c
index 3cdf06128d13..be5b5fb1598b 100644
--- a/arch/x86/lib/error-inject.c
+++ b/arch/x86/lib/error-inject.c
@@ -6,6 +6,7 @@
 asmlinkage void just_return_func(void);
 
 asm(
+	".text\n"
 	".type just_return_func, @function\n"
 	".globl just_return_func\n"
 	"just_return_func:\n"
