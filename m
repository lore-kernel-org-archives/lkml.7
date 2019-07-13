Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA51C742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D6A20848
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LN80MYrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfGMLN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 07:13:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38433 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfGMLN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 07:13:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DBDjNX3842129
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 04:13:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DBDjNX3842129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563016425;
        bh=F/rElx3kKQ1hxUCE1jfOB4fAjpqdzkWqo6XGDJnfqWk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=LN80MYrwihNbOoxRM2QYwgxjJhirrqywH/BvsmD9pcEWq7grD+mh9IjLkb217uV+U
         +xNFdJLv0bU0Qz4Yg6HDMIFrTaf24WsDqJe18JS5bVZ2yC2qCGEHKYNc2Bs/ZPnXml
         jET6yUwxpCQIVM4XD/5WdtT40xq+0IUHWM8DXY/0zTo8AVMFogdUhtlmjQQDRR8S+z
         E/5ZlQT6yqrj2xIU/twjrgwQbSZXF16rrnRGsGsJp0ibdvcdYIWK527p7tbzMyjBS+
         YovXdl52dX1IzBsVcH7ShfiqxZPaklW6wCyXtTvz9qZpFqCo4EAWxH6Hp5ZKGQb951
         gekWajU2BV3eA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DBDi743842126;
        Sat, 13 Jul 2019 04:13:44 -0700
Date:   Sat, 13 Jul 2019 04:13:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-e3d85487fba42206024bc3ed32e4b581c7cb46db@git.kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com,
        john.stultz@linaro.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: torvalds@linux-foundation.org, akpm@linux-foundation.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, peterz@infradead.org, john.stultz@linaro.org,
          hpa@zytor.com
In-Reply-To: <20190710105736.GK3402@hirez.programming.kicks-ass.net>
References: <20190710105736.GK3402@hirez.programming.kicks-ass.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/core: Fix preempt warning in ttwu
Git-Commit-ID: e3d85487fba42206024bc3ed32e4b581c7cb46db
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

Commit-ID:  e3d85487fba42206024bc3ed32e4b581c7cb46db
Gitweb:     https://git.kernel.org/tip/e3d85487fba42206024bc3ed32e4b581c7cb46db
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Wed, 10 Jul 2019 12:57:36 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 13 Jul 2019 11:23:27 +0200

sched/core: Fix preempt warning in ttwu

John reported a DEBUG_PREEMPT warning caused by commit:

  aacedf26fb76 ("sched/core: Optimize try_to_wake_up() for local wakeups")

I overlooked that ttwu_stat() requires preemption disabled.

Reported-by: John Stultz <john.stultz@linaro.org>
Tested-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: aacedf26fb76 ("sched/core: Optimize try_to_wake_up() for local wakeups")
Link: https://lkml.kernel.org/r/20190710105736.GK3402@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fa43ce3962e7..2b037f195473 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2399,6 +2399,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	unsigned long flags;
 	int cpu, success = 0;
 
+	preempt_disable();
 	if (p == current) {
 		/*
 		 * We're waking current, this means 'p->on_rq' and 'task_cpu(p)
@@ -2412,7 +2413,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		 *    it disabling IRQs (this allows not taking ->pi_lock).
 		 */
 		if (!(p->state & state))
-			return false;
+			goto out;
 
 		success = 1;
 		cpu = task_cpu(p);
@@ -2526,6 +2527,7 @@ unlock:
 out:
 	if (success)
 		ttwu_stat(p, cpu, wake_flags);
+	preempt_enable();
 
 	return success;
 }
