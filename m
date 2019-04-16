Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48797C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8B62087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbfDPPdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:33:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52013 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfDPPdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:33:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GFWqu63495144
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 08:32:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GFWoFJ3495141;
        Tue, 16 Apr 2019 08:32:50 -0700
Date:   Tue, 16 Apr 2019 08:32:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for luca abeni <tipbot@zytor.com>
Message-ID: <tip-1b02cd6a2d7f3e2a6a5262887d2cb2912083e42f@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org,
        juri.lelli@redhat.com, luca.abeni@santannapisa.it,
        peterz@infradead.org, cj.chengjian@huawei.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: peterz@infradead.org, luca.abeni@santannapisa.it,
          juri.lelli@redhat.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, cj.chengjian@huawei.com,
          hpa@zytor.com, torvalds@linux-foundation.org, tglx@linutronix.de
In-Reply-To: <20190325131530.34706-1-luca.abeni@santannapisa.it>
References: <20190325131530.34706-1-luca.abeni@santannapisa.it>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/deadline: Correctly handle active 0-lag
 timers
Git-Commit-ID: 1b02cd6a2d7f3e2a6a5262887d2cb2912083e42f
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

Commit-ID:  1b02cd6a2d7f3e2a6a5262887d2cb2912083e42f
Gitweb:     https://git.kernel.org/tip/1b02cd6a2d7f3e2a6a5262887d2cb2912083e42f
Author:     luca abeni <luca.abeni@santannapisa.it>
AuthorDate: Mon, 25 Mar 2019 14:15:30 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Apr 2019 16:54:58 +0200

sched/deadline: Correctly handle active 0-lag timers

syzbot reported the following warning:

   [ ] WARNING: CPU: 4 PID: 17089 at kernel/sched/deadline.c:255 task_non_contending+0xae0/0x1950

line 255 of deadline.c is:

	WARN_ON(hrtimer_active(&dl_se->inactive_timer));

in task_non_contending().

Unfortunately, in some cases (for example, a deadline task
continuosly blocking and waking immediately) it can happen that
a task blocks (and task_non_contending() is called) while the
0-lag timer is still active.

In this case, the safest thing to do is to immediately decrease
the running bandwidth of the task, without trying to re-arm the 0-lag timer.

Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: chengjian (D) <cj.chengjian@huawei.com>
Link: https://lkml.kernel.org/r/20190325131530.34706-1-luca.abeni@santannapisa.it
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/deadline.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 6a73e41a2016..43901fa3f269 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -252,7 +252,6 @@ static void task_non_contending(struct task_struct *p)
 	if (dl_entity_is_special(dl_se))
 		return;
 
-	WARN_ON(hrtimer_active(&dl_se->inactive_timer));
 	WARN_ON(dl_se->dl_non_contending);
 
 	zerolag_time = dl_se->deadline -
@@ -269,7 +268,7 @@ static void task_non_contending(struct task_struct *p)
 	 * If the "0-lag time" already passed, decrease the active
 	 * utilization now, instead of starting a timer
 	 */
-	if (zerolag_time < 0) {
+	if ((zerolag_time < 0) || hrtimer_active(&dl_se->inactive_timer)) {
 		if (dl_task(p))
 			sub_running_bw(dl_se, dl_rq);
 		if (!dl_task(p) || p->state == TASK_DEAD) {
