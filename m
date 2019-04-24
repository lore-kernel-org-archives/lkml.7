Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E65C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DC92084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127640;
	bh=cGPyj2p2DHO1IkK8DTMXjlcs0mp1PhkVm1e3g7BTq3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W5HeNCj/1Dd/H7++YtDZGjlWhghXGdDkv7h847/ulk3pYVhDOjzT8C5703lmblkXY
	 DFScTBw95ih0qcKzhSwfewcZjYulPhb0NwlfYfNbwyIrMufgwEYrMxBwRn71NYFl9G
	 eadRTSuHsWOO/RTXdIihNzjvY0/yLkOve1L/7X7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392122AbfDXRkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:40:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403992AbfDXRhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:37:16 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B07C20675;
        Wed, 24 Apr 2019 17:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127434;
        bh=cGPyj2p2DHO1IkK8DTMXjlcs0mp1PhkVm1e3g7BTq3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m5PIuK71oOfq4+s/HmZeJdQU5Y2Sw8xF050tGLH9Y9vll/LuMsJEir0J50B1oumGC
         pRgxmSi8ZF5118Hdb4/dv1Jr38JKkoGAhk9y0UvrIubNplfz4abircLpMgb5P6W9WR
         eBeeq98+H33x4vDk4uBqtayXMsI7ePh/l802B6uM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 5.0 090/115] kprobes: Fix error check when reusing optimized probes
Date:   Wed, 24 Apr 2019 19:10:26 +0200
Message-Id: <20190424170930.126677861@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 5f843ed415581cfad4ef8fefe31c138a8346ca8a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/kprobes.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -709,7 +709,6 @@ static void unoptimize_kprobe(struct kpr
 static int reuse_unused_kprobe(struct kprobe *ap)
 {
 	struct optimized_kprobe *op;
-	int ret;
 
 	/*
 	 * Unused kprobe MUST be on the way of delayed unoptimizing (means
@@ -720,9 +719,8 @@ static int reuse_unused_kprobe(struct kp
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


