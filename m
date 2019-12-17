Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5405C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B668B21775
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfLQMkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:40:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55240 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfLQMj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:39:58 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ihC8m-0001oD-5Q; Tue, 17 Dec 2019 13:39:52 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3E6501C2A3F;
        Tue, 17 Dec 2019 13:39:51 +0100 (CET)
Date:   Tue, 17 Dec 2019 12:39:51 -0000
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/cfs: fix spurious active migration
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1575036287-6052-1-git-send-email-vincent.guittot@linaro.org>
References: <1575036287-6052-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <157658639113.30329.18388929547654840709.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     6cf82d559e1a1d89f06ff4d428aca479c1dd0be6
Gitweb:        https://git.kernel.org/tip/6cf82d559e1a1d89f06ff4d428aca479c1dd0be6
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Fri, 29 Nov 2019 15:04:47 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 17 Dec 2019 13:32:48 +01:00

sched/cfs: fix spurious active migration

The load balance can fail to find a suitable task during the periodic check
because  the imbalance is smaller than half of the load of the waiting
tasks. This results in the increase of the number of failed load balance,
which can end up to start an active migration. This active migration is
useless because the current running task is not a better choice than the
waiting ones. In fact, the current task was probably not running but
waiting for the CPU during one of the previous attempts and it had already
not been selected.

When load balance fails too many times to migrate a task, we should relax
the contraint on the maximum load of the tasks that can be migrated
similarly to what is done with cache hotness.

Before the rework, load balance used to set the imbalance to the average
load_per_task in order to mitigate such situation. This increased the
likelihood of migrating a task but also of selecting a larger task than
needed while more appropriate ones were in the list.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1575036287-6052-1-git-send-email-vincent.guittot@linaro.org
---
 kernel/sched/fair.c |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 146b6c8..ba749f5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7328,7 +7328,14 @@ static int detach_tasks(struct lb_env *env)
 			    load < 16 && !env->sd->nr_balance_failed)
 				goto next;
 
-			if (load/2 > env->imbalance)
+			/*
+			 * Make sure that we don't migrate too much load.
+			 * Nevertheless, let relax the constraint if
+			 * scheduler fails to find a good waiting task to
+			 * migrate.
+			 */
+			if (load/2 > env->imbalance &&
+			    env->sd->nr_balance_failed <= env->sd->cache_nice_tries)
 				goto next;
 
 			env->imbalance -= load;
