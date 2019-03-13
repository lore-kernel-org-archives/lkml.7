Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2560BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E413F2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504309;
	bh=1kpuBLjSTZQ3I8xhLRnKlzjV5TUFzFBfoYdjTuGZ8ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b9uqpSLqKyb33g/33NOvAkQkCT6uZnU837rE3/yWetvdxVt1d4UxBTk954SqfJfA5
	 JmBEA1NqE9pn8njRhT8H33H3o8t+97CGRU+LlxIVstVpyIyKjvNjE9HHbZVa/SEGS4
	 RjrsRnfKL9K89twdo1qaXa/qhhMxp5G+C+ho4CkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfCMTLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:11:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727550AbfCMTLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:11:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DB78217F5;
        Wed, 13 Mar 2019 19:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504301;
        bh=1kpuBLjSTZQ3I8xhLRnKlzjV5TUFzFBfoYdjTuGZ8ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZPpCupdTeOl42F1TW/Z+rLlULkYB2h7mHoCgR2EFfT/V3Ea75yewjmk3+wMLK3NKo
         7rbS/DW0HLgkKET0V30ZlWMRlsydPk4DLZA1EkkMSRXv4sNke0fs6VjLWXmEaWif3e
         iIokYmGPHCuxogBVM0uJSB/rOrP9eqptKrnrg1WM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 36/60] psi: avoid divide-by-zero crash inside virtual machines
Date:   Wed, 13 Mar 2019 15:09:57 -0400
Message-Id: <20190313191021.158171-36-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Weiner <hannes@cmpxchg.org>

[ Upstream commit 4e37504d1c49eec6434d0cc97278d2b51c9e8763 ]

We've been seeing hard-to-trigger psi crashes when running inside VM
instances:

    divide error: 0000 [#1] SMP PTI
    Modules linked in: [...]
    CPU: 0 PID: 212 Comm: kworker/0:2 Not tainted 4.16.18-119_fbk9_3817_gfe944c98d695 #119
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
    Workqueue: events psi_clock
    RIP: 0010:psi_update_stats+0x270/0x490
    RSP: 0018:ffffc90001117e10 EFLAGS: 00010246
    RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8800a35a13f8
    RDX: 0000000000000000 RSI: ffff8800a35a1340 RDI: 0000000000000000
    RBP: 0000000000000658 R08: ffff8800a35a1470 R09: 0000000000000000
    R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
    R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000f8502
    FS:  0000000000000000(0000) GS:ffff88023fc00000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 00007fbe370fa000 CR3: 00000000b1e3a000 CR4: 00000000000006f0
    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
    Call Trace:
     psi_clock+0x12/0x50
     process_one_work+0x1e0/0x390
     worker_thread+0x2b/0x3c0
     ? rescuer_thread+0x330/0x330
     kthread+0x113/0x130
     ? kthread_create_worker_on_cpu+0x40/0x40
     ? SyS_exit_group+0x10/0x10
     ret_from_fork+0x35/0x40
    Code: 48 0f 47 c7 48 01 c2 45 85 e4 48 89 16 0f 85 e6 00 00 00 4c 8b 49 10 4c 8b 51 08 49 69 d9 f2 07 00 00 48 6b c0 64 4c 8b 29 31 d2 <48> f7 f7 49 69 d5 8d 06 00 00 48 89 c5 4c 69 f0 00 98 0b 00 48

The Code-line points to `period` being 0 inside update_stats(), and we
divide by that when calculating that period's pressure percentage.

The elapsed period should never be 0.  The reason this can happen is due
to an off-by-one in the idle time / missing period calculation combined
with a coarse sched_clock() in the virtual machine.

The target time for aggregation is advanced into the future on a fixed
grid to prevent clock drift.  So when an aggregation runs after some idle
period, we can not just set it to "now + psi_period", but have to
calculate the downtime and advance the target time relative to itself.

However, if the aggregator was disabled exactly one psi_period (ns), we
drop one idle period in the calculation due to a > when we should do >=.
In that case, next_update will be advanced from 'now - psi_period' to
'now' when it should be moved to 'now + psi_period'.  The run finishes
with last_update == next_update == sched_clock().

With hardware clocks, this exact nanosecond match isn't likely in the
first place; but if it does happen, the clock will still have moved on and
the period non-zero by the time the worker runs.  A pointlessly short
period, but besides the extra work, no harm no foul.  However, a slow
sched_clock() like we have on VMs might not have advanced either by the
time the worker runs again.  And when we calculate the elapsed period, the
result, our pressure divisor, will be 0.  Ouch.

Fix this by correctly handling the situation when the elapsed time between
aggregation runs is precisely two periods, and advance the expiration
timestamp correctly to period into the future.

Link: http://lkml.kernel.org/r/20190214193157.15788-1-hannes@cmpxchg.org
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reported-by: Łukasz Siudut <lsiudut@fb.com
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/psi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index fe24de3fbc93..ba4ab443bb67 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -321,7 +321,7 @@ static bool update_stats(struct psi_group *group)
 	expires = group->next_update;
 	if (now < expires)
 		goto out;
-	if (now - expires > psi_period)
+	if (now - expires >= psi_period)
 		missed_periods = div_u64(now - expires, psi_period);
 
 	/*
-- 
2.19.1

