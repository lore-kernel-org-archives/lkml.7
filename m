Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E94BC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F6C20679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MFGjidgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfHLMw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:52:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57435 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfHLMw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:52:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7CCq5qj911603
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 12 Aug 2019 05:52:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7CCq5qj911603
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565614325;
        bh=/bsntWjVZfImfzcAidw6AqiGCqtrKOJA5xIxNE3KE38=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=MFGjidgYHnRptP4j4A+xUuLQakdlBKAeoXGOIkZOCZvzhojLNt56q9FRF5HHrFurt
         wiYOkQG4w1tXF3raEDgSn+lghtDz20/q+4KR6qgvp6jez/gjxUKk4hTOzSHbUx7bWr
         a5TrLunfROAMNhLEmdDdF88+lxFRNOZy5jmB+qG1jjA5oKJw15DZofLFf+RmnI6HP6
         yRGNVF7c0YMBPADgJ91R594akdZGsraD/CR+CHr41SOLQuNznspGZRJRs2mA7NodcK
         OtskiXRX903FX4A7F4P4FMjDdAAM7hPDwbyQkKU3f3Zry+4EyNkmZveS8F3vc2w9Eq
         M8NolsgciccPA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7CCq46H911600;
        Mon, 12 Aug 2019 05:52:04 -0700
Date:   Mon, 12 Aug 2019 05:52:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Phil Auld <tipbot@zytor.com>
Message-ID: <tip-a46d14eca7b75fffe35603aa8b81df654353d80f@git.kernel.org>
Cc:     pauld@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
          pauld@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, vincent.guittot@linaro.org
In-Reply-To: <20190801133749.11033-1-pauld@redhat.com>
References: <20190801133749.11033-1-pauld@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Use rq_lock/unlock in
 online_fair_sched_group
Git-Commit-ID: a46d14eca7b75fffe35603aa8b81df654353d80f
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

Commit-ID:  a46d14eca7b75fffe35603aa8b81df654353d80f
Gitweb:     https://git.kernel.org/tip/a46d14eca7b75fffe35603aa8b81df654353d80f
Author:     Phil Auld <pauld@redhat.com>
AuthorDate: Thu, 1 Aug 2019 09:37:49 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 12 Aug 2019 14:45:34 +0200

sched/fair: Use rq_lock/unlock in online_fair_sched_group

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
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 19c58599e967..1054d2cf6aaa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10281,18 +10281,18 @@ err:
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
 
