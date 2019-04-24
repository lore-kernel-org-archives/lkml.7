Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B731C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C92321901
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128821;
	bh=VrjvUy0eGpI8rf5exHklPhueAayyHnH1mZW3CVDziQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xQpclZr1FogxN/cQxCukppVw5bZgQJb9F01g4V0A2uTcMFf/sLkEPftuaEZVgjasF
	 hGVuxDa5dMPcRCrMQPj4gjI6G0Tg6GX0/+ylby+SrW+KojeOkmIC6+Ic3LsRmrd+L4
	 Jushc1bd4RMD8tuagk6Pm7bhibe9i/OxbkDeqbQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389300AbfDXRXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:23:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389665AbfDXRXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:23:12 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1D28205ED;
        Wed, 24 Apr 2019 17:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126591;
        bh=VrjvUy0eGpI8rf5exHklPhueAayyHnH1mZW3CVDziQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mq9L3EYtxupArb8MvUbhXWXj0zq3/Df1vlJhS4HJUqxJ/iieYozN8i6dt6GDlqJbw
         jpGz1aebkxK9layMVyYocDtCD7NVMDRanWWZs4vnM3CsRAP7c3ZfZpXDAo9GpIiQbZ
         z5AcTWNlufUoA7HiFIdaxbd0BDEiduSGzNMcHzJ4=
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
Subject: [PATCH 4.4 162/168] kprobes: Fix error check when reusing optimized probes
Date:   Wed, 24 Apr 2019 19:10:06 +0200
Message-Id: <20190424170932.801687407@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
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
@@ -668,7 +668,6 @@ static void unoptimize_kprobe(struct kpr
 static int reuse_unused_kprobe(struct kprobe *ap)
 {
 	struct optimized_kprobe *op;
-	int ret;
 
 	BUG_ON(!kprobe_unused(ap));
 	/*
@@ -682,9 +681,8 @@ static int reuse_unused_kprobe(struct kp
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


