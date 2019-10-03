Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772B2C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D78222C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570067272;
	bh=qtBn42AgWJ/rI3ej7GIoXis4NYZunL4lVU1bCqYG+XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fQvfMEQbVT7+twRmVE6YMbrjR6Zl9O4PaUZALqkfdVDkJZEAZm7qlIme1Fvj2l1xV
	 lntp7dfQQDLb9WUJxXh1YzeBs9jzCODjpiwpfxcZnZwfXdc0oG25OmHwIPoWVBOCRG
	 0p54G4pNdhSbbRIMDzQS4+O0L/4mlpykYKjF+TUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfJCBrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:47:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727456AbfJCBrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:47:33 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DF53222C7;
        Thu,  3 Oct 2019 01:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570067252;
        bh=qtBn42AgWJ/rI3ej7GIoXis4NYZunL4lVU1bCqYG+XE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AxpHhGGXyxn+dkHAVmU4yvjcl4Vrkz3QGcoeCxxxczXl3UDHq9Lnatl0wtRlSc6ot
         PrmeMWMdt3IaCxTEPgg7BBk7weB+msdWP9fQf/VUTwt30hhspVpXgK4oRL6cqihYjB
         fjX35JE85te+uSGAVSu1jcriw5lmHVLJgSLq7J+4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 7/9] rcutorture: Make in-kernel-loop testing more brutal
Date:   Wed,  2 Oct 2019 18:47:26 -0700
Message-Id: <20191003014728.13496-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003014710.GA13323@paulmck-ThinkPad-P72>
References: <20191003014710.GA13323@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

The rcu_torture_fwd_prog_nr() tests the ability of RCU to tolerate
in-kernel busy loops.  It invokes rcu_torture_fwd_prog_cond_resched()
within its delay loop, which, in PREEMPT && NO_HZ_FULL kernels results
in the occasional direct call to schedule().  Now, this direct call to
schedule() is appropriate for call_rcu() flood testing, in which either
the kernel should restrain itself or userspace transitions will supply
the needed restraint.  But in pure in-kernel loops, the occasional
cond_resched() should do the job.

This commit therefore makes rcu_torture_fwd_prog_nr() use cond_resched()
instead of rcu_torture_fwd_prog_cond_resched() in order to increase the
brutality of this aspect of rcutorture testing.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index a9e97c3..f1339ee 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1811,7 +1811,7 @@ static void rcu_torture_fwd_prog_nr(int *tested, int *tested_tries)
 		udelay(10);
 		cur_ops->readunlock(idx);
 		if (!fwd_progress_need_resched || need_resched())
-			rcu_torture_fwd_prog_cond_resched(1);
+			cond_resched();
 	}
 	(*tested_tries)++;
 	if (!time_before(jiffies, stopat) &&
-- 
2.9.5

