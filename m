Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D57FC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F476206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JS719KgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfDYSBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:01:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55205 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfDYSBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:01:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3PI1K9D3228052
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Apr 2019 11:01:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3PI1K9D3228052
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556215280;
        bh=XXx1ef+1P/GYFITI8MpzWUciCOjl+oj6oxt27FcKcoU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=JS719KgE7DJNDdQH5WG3N7sMYnnhvrZoePHusbCrk1rXSIw8X/fl/BFoUD9QzIhLc
         lnZevyKUA92keL9/n+zxzAARKr6Zxg8yp2JFLUOK8yoYukP0XrZ8Nzny7QdVNRztl3
         G4lHSDIVcpaciV9HGgVnYv8TRWIKcjO1LfedB9nMj5RPmZp52HoOQXRxTEFnLciYC9
         kZPleihaInheyqPFpgZRznxMoeW8lnHd7GwrPsqmC31SYZ/4WhXj2R5Vn/aVTxnqib
         rKh6RXZonRymfciWcPEUAlD0CfhtV6oBBQINlOWy1BXi+MwFFV7aqi/IR5u14SLaIf
         kgcZ2Gn651MaA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3PI1KDM3228048;
        Thu, 25 Apr 2019 11:01:20 -0700
Date:   Thu, 25 Apr 2019 11:01:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Xie XiuQi <tipbot@zytor.com>
Message-ID: <tip-993efef2483bde15fd33ec5fba5464597c2d8124@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, xiexiuqi@huawei.com, hpa@zytor.com
Reply-To: tglx@linutronix.de, torvalds@linux-foundation.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org, hpa@zytor.com, xiexiuqi@huawei.com
In-Reply-To: <20190425080016.GX11158@hirez.programming.kicks-ass.net>
References: <20190425080016.GX11158@hirez.programming.kicks-ass.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/numa: Fix a possible divide-by-zero
Git-Commit-ID: 993efef2483bde15fd33ec5fba5464597c2d8124
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

Commit-ID:  993efef2483bde15fd33ec5fba5464597c2d8124
Gitweb:     https://git.kernel.org/tip/993efef2483bde15fd33ec5fba5464597c2d8124
Author:     Xie XiuQi <xiexiuqi@huawei.com>
AuthorDate: Sat, 20 Apr 2019 16:34:16 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Apr 2019 19:58:35 +0200

sched/numa: Fix a possible divide-by-zero

sched_clock_cpu() may not be consistent between CPUs. If a task
migrates to another CPU, then se.exec_start is set to that CPU's
rq_clock_task() by update_stats_curr_start(). Specifically, the new
value might be before the old value due to clock skew.

So then if in numa_get_avg_runtime() the expression:

  'now - p->last_task_numa_placement'

ends up as -1, then the divider '*period + 1' in task_numa_placement()
is 0 and things go bang. Similar to update_curr(), check if time goes
backwards to avoid this.

[ peterz: Wrote new changelog. ]
[ mingo: Tweaked the code comment. ]

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: cj.chengjian@huawei.com
Link: http://lkml.kernel.org/r/20190425080016.GX11158@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a4d9e14bf138..35f3ea375084 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2007,6 +2007,10 @@ static u64 numa_get_avg_runtime(struct task_struct *p, u64 *period)
 	if (p->last_task_numa_placement) {
 		delta = runtime - p->last_sum_exec_runtime;
 		*period = now - p->last_task_numa_placement;
+
+		/* Avoid time going backwards, prevent potential divide error: */
+		if (unlikely((s64)*period < 0))
+			*period = 0;
 	} else {
 		delta = p->se.avg.load_sum;
 		*period = LOAD_AVG_MAX;
