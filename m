Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED49C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B5D217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="z8sWQKvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfGaSAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:00:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51623 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfGaSA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:00:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6VHxxJv3778051
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 31 Jul 2019 11:00:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6VHxxJv3778051
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564596000;
        bh=nsYAFQM8gfidSokFIfrG+4eIsJn63TQyEXpI9WbMpEA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=z8sWQKvnUgPDDVCFZkVheMqaVqQe6P4dUT3w7rzwAxvpORXuYx8QDtkb9wqEhMWKk
         d4G9Akv1PPkrjxibj/FcNt1sXBVP5icuSmxB628yNy8KnF6Iz1pSWDn6oBuMvTEWhx
         Xhnuqbb+jA418bj1AJ8eDmBDU1VRAYNDjJErxBRpq7BAI+l09EREkgIykVMBGG/sVB
         jRJf30g0MkGno1/CRECaqAWR08EesazamX3lIUl/2FbIOJ50cFugIye+LOKnzQIgt4
         9B+eN6VDRmnJhMtepRuKo3Liqflb1y2hE7CX65CIgfkzsmogCoBXt2mLbLnd7zJMt1
         cspnXPcIrN6PA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6VHxxon3778046;
        Wed, 31 Jul 2019 10:59:59 -0700
Date:   Wed, 31 Jul 2019 10:59:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-cb376c26971ff54f25980ec1f0ae2f06d6a69df0@git.kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        paulmck@linux.ibm.com, mingo@kernel.org, pbonzini@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, mhiramat@kernel.org,
        hpa@zytor.com, rostedt@goodmis.org
Reply-To: tglx@linutronix.de, pbonzini@redhat.com, peterz@infradead.org,
          hpa@zytor.com, rostedt@goodmis.org, mhiramat@kernel.org,
          paulmck@linux.ibm.com, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, mingo@kernel.org
In-Reply-To: <20190726212124.699136351@linutronix.de>
References: <20190726212124.699136351@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/rt] x86/dumpstack: Indicate PREEMPT_RT in dumps
Git-Commit-ID: cb376c26971ff54f25980ec1f0ae2f06d6a69df0
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

Commit-ID:  cb376c26971ff54f25980ec1f0ae2f06d6a69df0
Gitweb:     https://git.kernel.org/tip/cb376c26971ff54f25980ec1f0ae2f06d6a69df0
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 23:19:43 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 31 Jul 2019 19:03:36 +0200

x86/dumpstack: Indicate PREEMPT_RT in dumps

Stack dumps print whether the kernel has preemption enabled or not. Extend
it so a PREEMPT_RT enabled kernel can be identified.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20190726212124.699136351@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/dumpstack.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 2b5886401e5f..e07424e19274 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -367,13 +367,18 @@ NOKPROBE_SYMBOL(oops_end);
 
 int __die(const char *str, struct pt_regs *regs, long err)
 {
+	const char *pr = "";
+
 	/* Save the regs of the first oops for the executive summary later. */
 	if (!die_counter)
 		exec_summary_regs = *regs;
 
+	if (IS_ENABLED(CONFIG_PREEMPTION))
+		pr = IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : " PREEMPT";
+
 	printk(KERN_DEFAULT
 	       "%s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff, ++die_counter,
-	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT"         : "",
+	       pr,
 	       IS_ENABLED(CONFIG_SMP)     ? " SMP"             : "",
 	       debug_pagealloc_enabled()  ? " DEBUG_PAGEALLOC" : "",
 	       IS_ENABLED(CONFIG_KASAN)   ? " KASAN"           : "",
