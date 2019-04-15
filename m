Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3DCC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EE320881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555308103;
	bh=/MzyQFL/wBpTLdxwMWluiFvFv22skfYJ0MfNoQhkvLc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=HaoWqPe5bIvRcCnkoDDgAbeUzBmq3834XG44ysTcNYcHcH0lamMcokZd64kRqf5vB
	 HxS5e+ojrXIh+Wt0C+suQJlCMTEP/mn5IYco4UGC9g6yDgl6iQWngD3UdeAtxGhtuS
	 v9jY3OoDCNHMzaVJgUafDQL80zJx+/inuWgCoTkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfDOGBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:01:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbfDOGBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 02:01:41 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F58520825;
        Mon, 15 Apr 2019 06:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555308101;
        bh=/MzyQFL/wBpTLdxwMWluiFvFv22skfYJ0MfNoQhkvLc=;
        h=From:To:Cc:Subject:Date:From;
        b=epTU/GE4TqI1DB6MPMBNOHFOxaOJyLsulNol1x/K4kh/T6qYb/3/w49iRWQSi55ev
         F/YiIkxMJ3KNnTfemymHjM+p4ZpwuOJV9HyERfQ2mJZ0yD4mnRlo57llpdMkbzJXQ6
         4AEK8WwdDAe2AZb/3l6Rpt/MTZnlaJC2bNIwlnYY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH -tip] kprobes: Fix an inverted result check for reusing optimized probe
Date:   Mon, 15 Apr 2019 15:01:25 +0900
Message-Id: <155530808559.32517.539898325433642204.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an inverted result check for reusing unused kprobe correctly.
This has been introduced by commit 819319fc9346 ("kprobes: Return
error if we fail to reuse kprobe instead of BUG_ON()"), which
missed to handle the return value of kprobe_optready() as
error-value. In reality, the kprobe_optready() returns a bool
result, so "true" case must be passed instead of 0.

This causes some errors on kprobe boot-time selftests on arm.

[    4.563544] Beginning kprobe tests...
[    4.563648] Probe ARM code
[    4.563733]     kprobe
[    4.564700]     kretprobe
[    4.565538] ARM instruction simulation
[    4.565671]     Check decoding tables
[    4.565883]     Run test cases
[    5.070700] FAIL: test_case_handler not run
[    5.070938] FAIL: Test andge	r10, r11, r14, asr r7
[    5.071118] FAIL: Scenario 11
...
[   74.174729] FAIL: Scenario 7
[   74.211776] Total instruction simulation tests=1631, pass=1433 fail=198
[   74.212168] kprobe tests failed

This can happen if an optimized probe is unregistered and next
kprobe is registered on same address until the previous probe
is not reclaimed.

If this happens, a hidden aggregated probe may be kept in memory,
and no new kprobe can probe same address. Also, in that case
register_kprobe() will return "1" instead of minus error value,
which can mislead caller logic.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: 819319fc9346 ("kprobes: Return error if we fail to reuse kprobe instead of BUG_ON()")
Cc: stable@vger.kernel.org # v5.0+
---
 kernel/kprobes.c |    6 ++----
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

