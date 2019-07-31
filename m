Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AC3C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAD72067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="b8PLAT0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfGaR6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:58:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47713 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfGaR6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:58:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6VHwMvH3777797
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 31 Jul 2019 10:58:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6VHwMvH3777797
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564595903;
        bh=pko6qkLq6LDAsDWmAq5Xc3a/oMcEzITv7Y7TuzlWrUk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=b8PLAT0TscL+o9lyJ85NLYmoHHplO4spZBUG/XNt3zZ0G+DSA2KQZC9KudK5+E+Zu
         NmWSAd5gPUb+gc6lv9uwBSzZAjqzZfQDq4FrkoVCWFaO9QULUmN5l58O5DB2U+uDXh
         eBCe+QxNX/6biuRY1Vg7eUL+PSFOwhNV5I67ogNxM3k/ntV6jg5waqr/aqYYNLrj7F
         q6l2+kPyKHtoo9cjShSmqE1RK6qNcdxixepzZCse9L2oQQU/TaEGxAyhjko8PtR+PB
         zgNDfZxhdl65GAIAaM8UI90QW4lpMd1xtcWIoQEfnMB21kwxeoI09d/fJKiV6VE+vp
         hpUqtdgIZ+/DA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6VHwMop3777794;
        Wed, 31 Jul 2019 10:58:22 -0700
Date:   Wed, 31 Jul 2019 10:58:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-92616606368ee01f1163fcfc986116c810cd48ba@git.kernel.org>
Cc:     hpa@zytor.com, peterz@infradead.org, mhiramat@kernel.org,
        pbonzini@redhat.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, paulmck@linux.ibm.com,
        mingo@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org
Reply-To: torvalds@linux-foundation.org, paulmck@linux.ibm.com,
          rostedt@goodmis.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          mhiramat@kernel.org, hpa@zytor.com, pbonzini@redhat.com,
          tglx@linutronix.de
In-Reply-To: <20190726212124.516286187@linutronix.de>
References: <20190726212124.516286187@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/rt] kprobes: Use CONFIG_PREEMPTION
Git-Commit-ID: 92616606368ee01f1163fcfc986116c810cd48ba
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

Commit-ID:  92616606368ee01f1163fcfc986116c810cd48ba
Gitweb:     https://git.kernel.org/tip/92616606368ee01f1163fcfc986116c810cd48ba
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 23:19:41 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 31 Jul 2019 19:03:35 +0200

kprobes: Use CONFIG_PREEMPTION

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by
CONFIG_PREEMPT_RT. Both PREEMPT and PREEMPT_RT require the same
functionality which today depends on CONFIG_PREEMPT.

Switch kprobes conditional over to CONFIG_PREEMPTION.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20190726212124.516286187@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/kprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 9873fc627d61..8bc5f1ffd68e 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1906,7 +1906,7 @@ int register_kretprobe(struct kretprobe *rp)
 
 	/* Pre-allocate memory for max kretprobe instances */
 	if (rp->maxactive <= 0) {
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 		rp->maxactive = max_t(unsigned int, 10, 2*num_possible_cpus());
 #else
 		rp->maxactive = num_possible_cpus();
