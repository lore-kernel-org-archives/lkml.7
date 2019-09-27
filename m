Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD7DC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85D5217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfI0IKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:10:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45156 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfI0IKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:10:50 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iDlKr-0005aT-Oi; Fri, 27 Sep 2019 10:10:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3C0C91C073C;
        Fri, 27 Sep 2019 10:10:41 +0200 (CEST)
Date:   Fri, 27 Sep 2019 08:10:41 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Remove double update_max_interval()
 call on CPU startup
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190923093017.11755-1-valentin.schneider@arm.com>
References: <20190923093017.11755-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <156957184120.9866.12838336712837668803.tip-bot2@tip-bot2>
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

Commit-ID:     9fc41acc89e58262c917b4be89ef00a87485804f
Gitweb:        https://git.kernel.org/tip/9fc41acc89e58262c917b4be89ef00a87485804f
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 23 Sep 2019 10:30:17 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Sep 2019 17:42:32 +02:00

sched/core: Remove double update_max_interval() call on CPU startup

update_max_interval() is called in both CPUHP_AP_SCHED_STARTING's startup
and teardown callbacks, but it turns out it's also called at the end of
the startup callback of CPUHP_AP_ACTIVE (which is further down the
startup sequence).

There's no point in repeating this interval update in the startup sequence
since the CPU will remain online until it goes down the teardown path.

Remove the redundant call in sched_cpu_activate() (CPUHP_AP_ACTIVE).

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dietmar.eggemann@arm.com
Cc: juri.lelli@redhat.com
Cc: vincent.guittot@linaro.org
Link: https://lkml.kernel.org/r/20190923093017.11755-1-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 00ef44c..1b61cf4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6425,8 +6425,6 @@ int sched_cpu_activate(unsigned int cpu)
 	}
 	rq_unlock_irqrestore(rq, &rf);
 
-	update_max_interval();
-
 	return 0;
 }
 
