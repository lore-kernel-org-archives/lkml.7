Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CF5C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634D02073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfKOSN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:13:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44272 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfKOSNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:13:25 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVg5j-00051n-7O; Fri, 15 Nov 2019 19:13:07 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CC5531C18CE;
        Fri, 15 Nov 2019 19:13:06 +0100 (CET)
Date:   Fri, 15 Nov 2019 18:13:06 -0000
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/uclamp: Fix incorrect condition
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191114211052.15116-1-qais.yousef@arm.com>
References: <20191114211052.15116-1-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <157384158679.12247.12347903056419517407.tip-bot2@tip-bot2>
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

Commit-ID:     6e1ff0773f49c7d38e8b4a9df598def6afb9f415
Gitweb:        https://git.kernel.org/tip/6e1ff0773f49c7d38e8b4a9df598def6afb9f415
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Thu, 14 Nov 2019 21:10:52 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Nov 2019 11:02:18 +01:00

sched/uclamp: Fix incorrect condition

uclamp_update_active() should perform the update when
p->uclamp[clamp_id].active is true. But when the logic was inverted in
[1], the if condition wasn't inverted correctly too.

[1] https://lore.kernel.org/lkml/20190902073836.GO2369@hirez.programming.kicks-ass.net/

Reported-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Patrick Bellasi <patrick.bellasi@matbug.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: babbe170e053 ("sched/uclamp: Update CPU's refcount on TG's clamp changes")
Link: https://lkml.kernel.org/r/20191114211052.15116-1-qais.yousef@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 33cd250..44123b4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1065,7 +1065,7 @@ uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
 	 * affecting a valid clamp bucket, the next time it's enqueued,
 	 * it will already see the updated clamp bucket value.
 	 */
-	if (!p->uclamp[clamp_id].active) {
+	if (p->uclamp[clamp_id].active) {
 		uclamp_rq_dec_id(rq, p, clamp_id);
 		uclamp_rq_inc_id(rq, p, clamp_id);
 	}
