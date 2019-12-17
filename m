Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB62C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291DF21582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfLQMkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:40:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55305 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbfLQMkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:40:12 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ihC8m-0001oC-7u; Tue, 17 Dec 2019 13:39:52 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6963C1C2A40;
        Tue, 17 Dec 2019 13:39:51 +0100 (CET)
Date:   Tue, 17 Dec 2019 12:39:51 -0000
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix find_idlest_group() to handle CPU
 affinity
Cc:     John Stultz <john.stultz@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        rostedt@goodmis.org, mingo@redhat.com, mgorman@suse.de,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        bsegall@google.com, qais.yousef@arm.com, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1575483700-22153-1-git-send-email-vincent.guittot@linaro.org>
References: <1575483700-22153-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <157658639132.30329.18410695427794700530.tip-bot2@tip-bot2>
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

Commit-ID:     7ed735c33104f3c6194fbc67e3a8b6e64ae84ad1
Gitweb:        https://git.kernel.org/tip/7ed735c33104f3c6194fbc67e3a8b6e64ae84ad1
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 04 Dec 2019 19:21:40 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 17 Dec 2019 13:32:48 +01:00

sched/fair: Fix find_idlest_group() to handle CPU affinity

Because of CPU affinity, the local group can be skipped which breaks the
assumption that statistics are always collected for local group. With
uninitialized local_sgs, the comparison is meaningless and the behavior
unpredictable. This can even end up to use local pointer which is to
NULL in this case.

If the local group has been skipped because of CPU affinity, we return
the idlest group.

Fixes: 57abff067a08 ("sched/fair: Rework find_idlest_group()")
Reported-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: John Stultz <john.stultz@linaro.org>
Cc: rostedt@goodmis.org
Cc: valentin.schneider@arm.com
Cc: mingo@redhat.com
Cc: mgorman@suse.de
Cc: juri.lelli@redhat.com
Cc: dietmar.eggemann@arm.com
Cc: bsegall@google.com
Cc: qais.yousef@arm.com
Link: https://lkml.kernel.org/r/1575483700-22153-1-git-send-email-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 08a233e..146b6c8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8417,6 +8417,10 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 	if (!idlest)
 		return NULL;
 
+	/* The local group has been skipped because of CPU affinity */
+	if (!local)
+		return idlest;
+
 	/*
 	 * If the local group is idler than the selected idlest group
 	 * don't try and push the task.
