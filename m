Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685FDC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 10:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43630214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 10:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbfIRKo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 06:44:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45946 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfIRKo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 06:44:26 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iAXRA-0005FF-NK; Wed, 18 Sep 2019 12:43:52 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E34AC1C07A5;
        Wed, 18 Sep 2019 12:43:51 +0200 (CEST)
Date:   Wed, 18 Sep 2019 10:43:51 -0000
From:   "tip-bot2 for Qian Cai" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Convert vcpu_is_preempted() from
 macro to an inline function
Cc:     Qian Cai <cai@lca.pw>, Mel Gorman <mgorman@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, bsegall@google.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, vincent.guittot@linaro.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1568730894-10483-1-git-send-email-cai@lca.pw>
References: <1568730894-10483-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Message-ID: <156880343178.24167.799070129320101322.tip-bot2@tip-bot2>
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

Commit-ID:     42fd8baab31f53bed2952485fcf0e92f244c5e55
Gitweb:        https://git.kernel.org/tip/42fd8baab31f53bed2952485fcf0e92f244c5e55
Author:        Qian Cai <cai@lca.pw>
AuthorDate:    Tue, 17 Sep 2019 10:34:54 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 18 Sep 2019 12:38:17 +02:00

sched/core: Convert vcpu_is_preempted() from macro to an inline function

Clang reports this warning:

  kernel/locking/osq_lock.c:25:19: warning: unused function 'node_cpu' [-Wunused-function]

due to osq_lock() calling vcpu_is_preempted(node_cpu(node->prev))), but
vcpu_is_preempted() is compiled away. Fix it by converting the dummy
vcpu_is_preempted() from a macro to a proper static inline function.

Signed-off-by: Qian Cai <cai@lca.pw>
Acked-by: Mel Gorman <mgorman@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bsegall@google.com
Cc: dietmar.eggemann@arm.com
Cc: juri.lelli@redhat.com
Cc: rostedt@goodmis.org
Cc: vincent.guittot@linaro.org
Link: https://lkml.kernel.org/r/1568730894-10483-1-git-send-email-cai@lca.pw
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f0edee9..e2e9196 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1856,7 +1856,10 @@ static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
  * running or not.
  */
 #ifndef vcpu_is_preempted
-# define vcpu_is_preempted(cpu)	false
+static inline bool vcpu_is_preempted(int cpu)
+{
+	return false;
+}
 #endif
 
 extern long sched_setaffinity(pid_t pid, const struct cpumask *new_mask);
