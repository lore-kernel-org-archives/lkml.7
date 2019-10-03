Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0D2C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A24420862
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388673AbfJCUUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 16:20:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388527AbfJCUUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 16:20:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E5CF3091753;
        Thu,  3 Oct 2019 20:20:13 +0000 (UTC)
Received: from llong.com (ovpn-122-104.rdu2.redhat.com [10.10.122.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8C67608C0;
        Thu,  3 Oct 2019 20:20:09 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] lib/smp_processor_id: Don't use cpumask_equal()
Date:   Thu,  3 Oct 2019 16:18:35 -0400
Message-Id: <20191003201835.19903-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 03 Oct 2019 20:20:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check_preemption_disabled() function uses cpumask_equal() to see
if the task is bounded to the current CPU only. cpumask_equal() calls
memcmp() to do the comparison. As x86 doesn't have __HAVE_ARCH_MEMCMP,
the slow memcmp() function in lib/string.c is used.

On a RT kernel that call check_preemption_disabled() very frequently,
below is the perf-record output of a certain microbenchmark:

  42.75%  2.45%  testpmd [kernel.kallsyms] [k] check_preemption_disabled
  40.01% 39.97%  testpmd [kernel.kallsyms] [k] memcmp

We should avoid calling memcmp() in performance critical path. So the
cpumask_equal() call is now replaced with an equivalent check that
makes no external function call.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/smp_processor_id.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index 60ba93fc42ce..3fee05ac92f8 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -23,7 +23,8 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
 	 * Kernel threads bound to a single CPU can safely use
 	 * smp_processor_id():
 	 */
-	if (cpumask_equal(current->cpus_ptr, cpumask_of(this_cpu)))
+	if ((current->nr_cpus_allowed == 1) &&
+	    cpumask_test_cpu(this_cpu, current->cpus_ptr))
 		goto out;
 
 	/*
-- 
2.18.1

