Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2418C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C8C2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950890;
	bh=TvosYzjHhqHwTKEBhd/3tiZRrmMCcSiwrNi8S60IGbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g6vr4WLgMiXTDb4kqXJxLf0cjjw5HCVkVRa9xKCbd+yVaARhW1tL01Kea+0igmyFi
	 csnuSpkOdXhW7SG05h+niUvVT5Hl6KBv7vc9CC5AYtOS6BHVTSEbEUSvinGr5rxP4w
	 DBN/hGCyhOEcbf92/j6Jv5/fLm3DE5vNPAZ/rOw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfLJEIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:08:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbfLJEHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:07:49 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBE5321556;
        Tue, 10 Dec 2019 04:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950869;
        bh=TvosYzjHhqHwTKEBhd/3tiZRrmMCcSiwrNi8S60IGbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yoyQ2iWIecL42QowLXibFx2YW2D9EBEnB9jklhBXZvHES7f7issqAHIQ196Glny6x
         WT/VoesfY4Q17Nyaue71qZkt5hIVL/ZHF4ISdLYQDWaXu7rfiXrT8Ho0mgltEPAc2H
         62+Y4wrN8ob/eLUFySOCqu2VbbjJI3t1bY2DMHsc=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/12] srcu: Apply *_ONCE() to ->srcu_last_gp_end
Date:   Mon,  9 Dec 2019 20:07:38 -0800
Message-Id: <20191210040741.2943-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210040714.GA2715@paulmck-ThinkPad-P72>
References: <20191210040714.GA2715@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The ->srcu_last_gp_end field is accessed from any CPU at any time
by synchronize_srcu(), so non-initialization references need to use
READ_ONCE() and WRITE_ONCE().  This commit therefore makes that change.

Reported-by: syzbot+08f3e9d26e5541e1ecf2@syzkaller.appspotmail.com
Acked-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 5dffade..21acdff 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -530,7 +530,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	idx = rcu_seq_state(ssp->srcu_gp_seq);
 	WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
 	cbdelay = srcu_get_delay(ssp);
-	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
+	WRITE_ONCE(ssp->srcu_last_gp_end, ktime_get_mono_fast_ns());
 	rcu_seq_end(&ssp->srcu_gp_seq);
 	gpseq = rcu_seq_current(&ssp->srcu_gp_seq);
 	if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, gpseq))
@@ -762,6 +762,7 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
 	unsigned long flags;
 	struct srcu_data *sdp;
 	unsigned long t;
+	unsigned long tlast;
 
 	/* If the local srcu_data structure has callbacks, not idle.  */
 	local_irq_save(flags);
@@ -780,9 +781,9 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
 
 	/* First, see if enough time has passed since the last GP. */
 	t = ktime_get_mono_fast_ns();
+	tlast = READ_ONCE(ssp->srcu_last_gp_end);
 	if (exp_holdoff == 0 ||
-	    time_in_range_open(t, ssp->srcu_last_gp_end,
-			       ssp->srcu_last_gp_end + exp_holdoff))
+	    time_in_range_open(t, tlast, tlast + exp_holdoff))
 		return false; /* Too soon after last GP. */
 
 	/* Next, check for probable idleness. */
-- 
2.9.5

