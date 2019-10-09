Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67ACC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6ED721835
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731432AbfJIM7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 08:59:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50964 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731413AbfJIM7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:59:48 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iIBZ8-0002z5-EA; Wed, 09 Oct 2019 14:59:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 20DDB1C01BD;
        Wed,  9 Oct 2019 14:59:42 +0200 (CEST)
Date:   Wed, 09 Oct 2019 12:59:41 -0000
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lib/smp_processor_id: Don't use cpumask_equal()
Cc:     Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191003203608.21881-1-longman@redhat.com>
References: <20191003203608.21881-1-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <157062598194.9978.10224113529074728326.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e950cca3f3c40902a052a78a36b3fac1f8a62d19
Gitweb:        https://git.kernel.org/tip/e950cca3f3c40902a052a78a36b3fac1f8a62d19
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 03 Oct 2019 16:36:08 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Oct 2019 12:46:10 +02:00

lib/smp_processor_id: Don't use cpumask_equal()

The check_preemption_disabled() function uses cpumask_equal() to see
if the task is bounded to the current CPU only. cpumask_equal() calls
memcmp() to do the comparison. As x86 doesn't have __HAVE_ARCH_MEMCMP,
the slow memcmp() function in lib/string.c is used.

On a RT kernel that call check_preemption_disabled() very frequently,
below is the perf-record output of a certain microbenchmark:

  42.75%  2.45%  testpmd [kernel.kallsyms] [k] check_preemption_disabled
  40.01% 39.97%  testpmd [kernel.kallsyms] [k] memcmp

We should avoid calling memcmp() in performance critical path. So the
cpumask_equal() call is now replaced with an equivalent simpler check.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by:  Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191003203608.21881-1-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 lib/smp_processor_id.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index 60ba93f..bd95716 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -23,7 +23,7 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
 	 * Kernel threads bound to a single CPU can safely use
 	 * smp_processor_id():
 	 */
-	if (cpumask_equal(current->cpus_ptr, cpumask_of(this_cpu)))
+	if (current->nr_cpus_allowed == 1)
 		goto out;
 
 	/*
