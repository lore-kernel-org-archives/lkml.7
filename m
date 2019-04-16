Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDADC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25672086A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbfDPHn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:43:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46397 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfDPHn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:43:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3G7h7wt3334591
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 00:43:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3G7h6rs3334585;
        Tue, 16 Apr 2019 00:43:06 -0700
Date:   Tue, 16 Apr 2019 00:43:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-5f843ed415581cfad4ef8fefe31c138a8346ca8a@git.kernel.org>
Cc:     mhiramat@kernel.org, mingo@kernel.org,
        anil.s.keshavamurthy@intel.com, peterz@infradead.org,
        hpa@zytor.com, davem@davemloft.net,
        naveen.n.rao@linux.vnet.ibm.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, naveen.n.rao@linux.vnet.ibm.com,
          davem@davemloft.net, hpa@zytor.com, peterz@infradead.org,
          anil.s.keshavamurthy@intel.com, mingo@kernel.org,
          mhiramat@kernel.org
In-Reply-To: <155530808559.32517.539898325433642204.stgit@devnote2>
References: <155530808559.32517.539898325433642204.stgit@devnote2>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] kprobes: Fix error check when reusing optimized
 probes
Git-Commit-ID: 5f843ed415581cfad4ef8fefe31c138a8346ca8a
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

Commit-ID:  5f843ed415581cfad4ef8fefe31c138a8346ca8a
Gitweb:     https://git.kernel.org/tip/5f843ed415581cfad4ef8fefe31c138a8346ca8a
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Mon, 15 Apr 2019 15:01:25 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Apr 2019 09:38:16 +0200

kprobes: Fix error check when reusing optimized probes

The following commit introduced a bug in one of our error paths:

  819319fc9346 ("kprobes: Return error if we fail to reuse kprobe instead of BUG_ON()")

it missed to handle the return value of kprobe_optready() as
error-value. In reality, the kprobe_optready() returns a bool
result, so "true" case must be passed instead of 0.

This causes some errors on kprobe boot-time selftests on ARM:

 [   ] Beginning kprobe tests...
 [   ] Probe ARM code
 [   ]     kprobe
 [   ]     kretprobe
 [   ] ARM instruction simulation
 [   ]     Check decoding tables
 [   ]     Run test cases
 [   ] FAIL: test_case_handler not run
 [   ] FAIL: Test andge	r10, r11, r14, asr r7
 [   ] FAIL: Scenario 11
 ...
 [   ] FAIL: Scenario 7
 [   ] Total instruction simulation tests=1631, pass=1433 fail=198
 [   ] kprobe tests failed

This can happen if an optimized probe is unregistered and next
kprobe is registered on same address until the previous probe
is not reclaimed.

If this happens, a hidden aggregated probe may be kept in memory,
and no new kprobe can probe same address. Also, in that case
register_kprobe() will return "1" instead of minus error value,
which can mislead caller logic.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Naveen N . Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org # v5.0+
Fixes: 819319fc9346 ("kprobes: Return error if we fail to reuse kprobe instead of BUG_ON()")
Link: http://lkml.kernel.org/r/155530808559.32517.539898325433642204.stgit@devnote2
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/kprobes.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index c83e54727131..b1ea30a5540e 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -709,7 +709,6 @@ static void unoptimize_kprobe(struct kprobe *p, bool force)
 static int reuse_unused_kprobe(struct kprobe *ap)
 {
 	struct optimized_kprobe *op;
-	int ret;
 
 	/*
 	 * Unused kprobe MUST be on the way of delayed unoptimizing (means
@@ -720,9 +719,8 @@ static int reuse_unused_kprobe(struct kprobe *ap)
 	/* Enable the probe again */
 	ap->flags &= ~KPROBE_FLAG_DISABLED;
 	/* Optimize it again (remove from op->list) */
-	ret = kprobe_optready(ap);
-	if (ret)
-		return ret;
+	if (!kprobe_optready(ap))
+		return -EINVAL;
 
 	optimize_kprobe(ap);
 	return 0;
