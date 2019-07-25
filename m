Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06292C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA9E22BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="2oeaKC/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390499AbfGYQYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:24:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37931 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387722AbfGYQYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:24:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PGOA9j1078434
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:24:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PGOA9j1078434
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564071851;
        bh=nxA6pw+0kkdmyEyEUASWzYnVUed0fSQ6Ni6z51k5ChY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=2oeaKC/e1Rq8qagAfOV2af1thXoIw13DZdHHV+5Gf7GWtk1dUc0tnCNyQQHGNoL6F
         rqvWNmpx4R2eSWC4lhDrd2hR3CDtO6PkFS+6tPNgeloOChtLwnrVoR2GYYiKSef5di
         a7GFkKvFmtnNZ95dPXbv1yduaRHej4vjDsp1oRPpUt+HmZzgWIoBi+2lGZuHVCusyV
         E9L9CWgqC04bzmCkV49UECAMCDhp2lERFLhhjMGNw1Q80K3Z3pGy0HepLkGW4db3l2
         tmVsLoXQIyLprbiQc+GZVJEH96xfVytMEJPFasGRfI10LL5H52jGr++pIg/k+iIBKf
         B8DXSW10khYCQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PGOAbl1078430;
        Thu, 25 Jul 2019 09:24:10 -0700
Date:   Thu, 25 Jul 2019 09:24:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juri Lelli <tipbot@zytor.com>
Message-ID: <tip-1a763fd7c6335e3122c1cc09576ef6c99ada4267@git.kernel.org>
Cc:     juri.lelli@redhat.com, hpa@zytor.com, mingo@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        dietmar.eggemann@arm.com
Reply-To: hpa@zytor.com, juri.lelli@redhat.com,
          torvalds@linux-foundation.org, dietmar.eggemann@arm.com,
          tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190719140000.31694-8-juri.lelli@redhat.com>
References: <20190719140000.31694-8-juri.lelli@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] rcu/tree: Call setschedule() gp ktread to
 SCHED_FIFO outside of atomic region
Git-Commit-ID: 1a763fd7c6335e3122c1cc09576ef6c99ada4267
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

Commit-ID:  1a763fd7c6335e3122c1cc09576ef6c99ada4267
Gitweb:     https://git.kernel.org/tip/1a763fd7c6335e3122c1cc09576ef6c99ada4267
Author:     Juri Lelli <juri.lelli@redhat.com>
AuthorDate: Fri, 19 Jul 2019 15:59:59 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:55:03 +0200

rcu/tree: Call setschedule() gp ktread to SCHED_FIFO outside of atomic region

sched_setscheduler() needs to acquire cpuset_rwsem, but it is currently
called from an invalid (atomic) context by rcu_spawn_gp_kthread().

Fix that by simply moving sched_setscheduler_nocheck() call outside of
the atomic region, as it doesn't actually require to be guarded by
rcu_node lock.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bristot@redhat.com
Cc: claudio@evidence.eu.com
Cc: lizefan@huawei.com
Cc: longman@redhat.com
Cc: luca.abeni@santannapisa.it
Cc: mathieu.poirier@linaro.org
Cc: rostedt@goodmis.org
Cc: tj@kernel.org
Cc: tommaso.cucinotta@santannapisa.it
Link: https://lkml.kernel.org/r/20190719140000.31694-8-juri.lelli@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/rcu/tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a14e5fbbea46..eb764c24bc4d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3234,13 +3234,13 @@ static int __init rcu_spawn_gp_kthread(void)
 	t = kthread_create(rcu_gp_kthread, NULL, "%s", rcu_state.name);
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start grace-period kthread, OOM is now expected behavior\n", __func__))
 		return 0;
+	if (kthread_prio)
+		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
 	rnp = rcu_get_root();
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	rcu_state.gp_kthread = t;
-	if (kthread_prio) {
+	if (kthread_prio)
 		sp.sched_priority = kthread_prio;
-		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
-	}
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	wake_up_process(t);
 	rcu_spawn_nocb_kthreads();
