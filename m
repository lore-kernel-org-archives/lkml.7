Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2B7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C8620644
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569181022;
	bh=Oe369tPZ5whZDrheTC9pmJV5JCCU/mBGbbOVzTKFx4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MCGHtvnGBlC2K+ETbhN4DkuR5gZtbEZiG1WpBFA6PBNUdiz5aU5Od/sZs3RMbu0dC
	 5qb07BX3cRGt8Et2b/+L0MFz4VB2GSj5bxEufYLf4KXwhpvfSS5C3iaRVg/h9p5aUf
	 jKC/pmYfunarXaY1IV9Bkvx3of9Ulr/Afn8QyKPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406794AbfIVThB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389752AbfIVSqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:46:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 601D821479;
        Sun, 22 Sep 2019 18:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569177960;
        bh=Oe369tPZ5whZDrheTC9pmJV5JCCU/mBGbbOVzTKFx4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WPaL2hXJkWaGOO6spk1xB82EarHoJuklDSrWn+4pbVpcl2iYvoqJFLdQz0++IuTFq
         5m9pawME/wBulPr2i2zSY8OQ2lLFtRZUujqvPs2rTSKcIqYeZ9kbTbTzJxdzDxAZSm
         C4KZ/rP4Ghzn/mo8kHEcqzv98JZaPkDxiWjcOxm8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 064/203] sched/fair: Use rq_lock/unlock in online_fair_sched_group
Date:   Sun, 22 Sep 2019 14:41:30 -0400
Message-Id: <20190922184350.30563-64-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184350.30563-1-sashal@kernel.org>
References: <20190922184350.30563-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phil Auld <pauld@redhat.com>

[ Upstream commit a46d14eca7b75fffe35603aa8b81df654353d80f ]

Enabling WARN_DOUBLE_CLOCK in /sys/kernel/debug/sched_features causes
warning to fire in update_rq_clock. This seems to be caused by onlining
a new fair sched group not using the rq lock wrappers.

  [] rq->clock_update_flags & RQCF_UPDATED
  [] WARNING: CPU: 5 PID: 54385 at kernel/sched/core.c:210 update_rq_clock+0xec/0x150

  [] Call Trace:
  []  online_fair_sched_group+0x53/0x100
  []  cpu_cgroup_css_online+0x16/0x20
  []  online_css+0x1c/0x60
  []  cgroup_apply_control_enable+0x231/0x3b0
  []  cgroup_mkdir+0x41b/0x530
  []  kernfs_iop_mkdir+0x61/0xa0
  []  vfs_mkdir+0x108/0x1a0
  []  do_mkdirat+0x77/0xe0
  []  do_syscall_64+0x55/0x1d0
  []  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Using the wrappers in online_fair_sched_group instead of the raw locking
removes this warning.

[ tglx: Use rq_*lock_irq() ]

Signed-off-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20190801133749.11033-1-pauld@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 105b1aead0c3a..86cfc5d5129ce 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10301,18 +10301,18 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 void online_fair_sched_group(struct task_group *tg)
 {
 	struct sched_entity *se;
+	struct rq_flags rf;
 	struct rq *rq;
 	int i;
 
 	for_each_possible_cpu(i) {
 		rq = cpu_rq(i);
 		se = tg->se[i];
-
-		raw_spin_lock_irq(&rq->lock);
+		rq_lock_irq(rq, &rf);
 		update_rq_clock(rq);
 		attach_entity_cfs_rq(se);
 		sync_throttle(tg, i);
-		raw_spin_unlock_irq(&rq->lock);
+		rq_unlock_irq(rq, &rf);
 	}
 }
 
-- 
2.20.1

