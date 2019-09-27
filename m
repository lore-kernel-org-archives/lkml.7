Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678A5C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45199217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfI0ILB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:11:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45228 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfI0IK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:10:59 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iDlKr-0005aR-Ev; Fri, 27 Sep 2019 10:10:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 04AF81C0440;
        Fri, 27 Sep 2019 10:10:41 +0200 (CEST)
Date:   Fri, 27 Sep 2019 08:10:40 -0000
From:   "tip-bot2 for Quentin Perret" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Avoid redundant EAS calculation
Cc:     Pavan Kondeti <pkondeti@codeaurora.org>,
        Quentin Perret <qperret@qperret.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, morten.rasmussen@arm.com,
        qais.yousef@arm.com, rjw@rjwysocki.net, tkjos@google.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190920094115.GA11503@qperret.net>
References: <20190920094115.GA11503@qperret.net>
MIME-Version: 1.0
Message-ID: <156957184084.9866.11941365250682911830.tip-bot2@tip-bot2>
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

Commit-ID:     4892f51ad54ddff2883a60b6ad4323c1f632a9d6
Gitweb:        https://git.kernel.org/tip/4892f51ad54ddff2883a60b6ad4323c1f632a9d6
Author:        Quentin Perret <qperret@qperret.net>
AuthorDate:    Fri, 20 Sep 2019 11:41:15 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Sep 2019 17:42:32 +02:00

sched/fair: Avoid redundant EAS calculation

The EAS wake-up path computes the system energy for several CPU
candidates: the CPU with maximum spare capacity in each performance
domain, and the prev_cpu. However, if prev_cpu also happens to be the
CPU with maximum spare capacity in its performance domain, the energy
calculation is still done twice, unnecessarily.

Add a condition to filter out this corner case before doing the energy
calculation.

Reported-by: Pavan Kondeti <pkondeti@codeaurora.org>
Signed-off-by: Quentin Perret <qperret@qperret.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dietmar.eggemann@arm.com
Cc: juri.lelli@redhat.com
Cc: morten.rasmussen@arm.com
Cc: qais.yousef@arm.com
Cc: rjw@rjwysocki.net
Cc: tkjos@google.com
Cc: valentin.schneider@arm.com
Cc: vincent.guittot@linaro.org
Fixes: eb92692b2544 ("sched/fair: Speed-up energy-aware wake-ups")
Link: https://lkml.kernel.org/r/20190920094115.GA11503@qperret.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dfdac90..83ab35e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6389,7 +6389,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		}
 
 		/* Evaluate the energy impact of using this CPU. */
-		if (max_spare_cap_cpu >= 0) {
+		if (max_spare_cap_cpu >= 0 && max_spare_cap_cpu != prev_cpu) {
 			cur_delta = compute_energy(p, max_spare_cap_cpu, pd);
 			cur_delta -= base_energy_pd;
 			if (cur_delta < best_delta) {
