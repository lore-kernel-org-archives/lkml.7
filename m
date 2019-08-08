Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C513EC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979CF2184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ia3j+Ici"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbfHHLBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 07:01:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47203 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfHHLBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 07:01:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78B16cd3128445
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 04:01:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78B16cd3128445
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565262066;
        bh=PfxstGCABas8L6TL/1R8TcMt3vHSJNWYWZFOgVM8s5w=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ia3j+Iciuta3/9m13m0sYDaXNe6oLkSVviZrGMdTaVtGXMELRQ28PbTmc5FX9clZc
         sZgSvKC1kZ/O0PqyoRrU3us1wlWF6ZoxgPdZyjuO5D46p8ElvLA/XmJC6Zh/kBvlzb
         SZ3+ltO1sBCURq9fPUo38B4wug5kPgr9oExQiYHBeskUCQ9dwiRka9SuFx1NJK6q05
         0OTp/Qf4It1nqGeB5YjibfWz4AxC7hnRakSaBMD8s8ipzZ6j/mEkBbK7wRUGwHrzp+
         GkMv798+crDcCNnC+ManiYTjLIw8jD4qHILOCaCOiwf1snSK2FR3HNdU9p8EUfn/ZW
         nA7fNO3XhQL2g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78B15qv3128442;
        Thu, 8 Aug 2019 04:01:05 -0700
Date:   Thu, 8 Aug 2019 04:01:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Phil Auld <tipbot@zytor.com>
Message-ID: <tip-6b8fd01b21f5f2701b407a7118f236ba4c41226d@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, mingo@kernel.org, peterz@infradead.org,
        vincent.guittot@linaro.org, pauld@redhat.com
Reply-To: pauld@redhat.com, vincent.guittot@linaro.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          mingo@redhat.com, tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20190801133749.11033-1-pauld@redhat.com>
References: <20190801133749.11033-1-pauld@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Use rq_lock/unlock in
 online_fair_sched_group
Git-Commit-ID: 6b8fd01b21f5f2701b407a7118f236ba4c41226d
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

Commit-ID:  6b8fd01b21f5f2701b407a7118f236ba4c41226d
Gitweb:     https://git.kernel.org/tip/6b8fd01b21f5f2701b407a7118f236ba4c41226d
Author:     Phil Auld <pauld@redhat.com>
AuthorDate: Thu, 1 Aug 2019 09:37:49 -0400
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Thu, 8 Aug 2019 09:09:31 +0200

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

Signed-off-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20190801133749.11033-1-pauld@redhat.com
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 19c58599e967..d9407517dae9 100644
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
+		rq_lock(rq, &rf);
 		update_rq_clock(rq);
 		attach_entity_cfs_rq(se);
 		sync_throttle(tg, i);
-		raw_spin_unlock_irq(&rq->lock);
+		rq_unlock(rq, &rf);
 	}
 }
 
