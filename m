Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E97C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8138E20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551689031;
	bh=siI6mIx3GX/aBc9cZTcZj2qKyqFJ33dHtTsG0nKsNlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jr4s7zFDFtAD7/bClGSjdkcA6ALHDnl8bgWYwrSByQ0Q6+c0lTkxpUfXMpOFiMKk0
	 ci+6r3kum2R+slzWPgdtq5Fb9/3WHzqdQRsKO2d78NRTSMJfTC/exh/mPE/bq37iml
	 zPrXdvxG8RRZzPqU0gdBNcbV91c9iP9gXbd94Oks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfCDI3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:29:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727531AbfCDI3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:29:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 958EA21019;
        Mon,  4 Mar 2019 08:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688161;
        bh=siI6mIx3GX/aBc9cZTcZj2qKyqFJ33dHtTsG0nKsNlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CpTlEBeVaNfW0bbpKoqlWY6FtCPiZO9FBvTIL0p7LMyDzE3ExeDWfHH8ZFuvPudJ7
         Fn1GCQcYAbOxBBe439Tdsl4ObEQNnOulKv8aT1/fP+DxcBwHzloSnjG0kDdL5CUh0H
         Qt94S6cQi/9PMysBn8frkByyom20xktqCd9UuC1I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yongji Xie <elohimes@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 36/78] sched/wake_q: Fix wakeup ordering for wake_q
Date:   Mon,  4 Mar 2019 09:22:19 +0100
Message-Id: <20190304081627.116183681@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
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

[ Upstream commit 4c4e3731564c8945ac5ac90fc2a1e1f21cb79c92 ]

Notable cmpxchg() does not provide ordering when it fails, however
wake_q_add() requires ordering in this specific case too. Without this
it would be possible for the concurrent wakeup to not observe our
prior state.

Andrea Parri provided:

  C wake_up_q-wake_q_add

  {
	int next = 0;
	int y = 0;
  }

  P0(int *next, int *y)
  {
	int r0;

	/* in wake_up_q() */

	WRITE_ONCE(*next, 1);   /* node->next = NULL */
	smp_mb();               /* implied by wake_up_process() */
	r0 = READ_ONCE(*y);
  }

  P1(int *next, int *y)
  {
	int r1;

	/* in wake_q_add() */

	WRITE_ONCE(*y, 1);      /* wake_cond = true */
	smp_mb__before_atomic();
	r1 = cmpxchg_relaxed(next, 1, 2);
  }

  exists (0:r0=0 /\ 1:r1=0)

  This "exists" clause cannot be satisfied according to the LKMM:

  Test wake_up_q-wake_q_add Allowed
  States 3
  0:r0=0; 1:r1=1;
  0:r0=1; 1:r1=0;
  0:r0=1; 1:r1=1;
  No
  Witnesses
  Positive: 0 Negative: 3
  Condition exists (0:r0=0 /\ 1:r1=0)
  Observation wake_up_q-wake_q_add Never 0 3

Reported-by: Yongji Xie <elohimes@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 13ddfa46d741f..152a0b0c91bb6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -405,10 +405,11 @@ void wake_q_add(struct wake_q_head *head, struct task_struct *task)
 	 * its already queued (either by us or someone else) and will get the
 	 * wakeup due to that.
 	 *
-	 * This cmpxchg() executes a full barrier, which pairs with the full
-	 * barrier executed by the wakeup in wake_up_q().
+	 * In order to ensure that a pending wakeup will observe our pending
+	 * state, even in the failed case, an explicit smp_mb() must be used.
 	 */
-	if (cmpxchg(&node->next, NULL, WAKE_Q_TAIL))
+	smp_mb__before_atomic();
+	if (cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL))
 		return;
 
 	get_task_struct(task);
-- 
2.19.1



