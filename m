Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A50C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B1220880
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405751AbfHBKqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 06:46:43 -0400
Received: from foss.arm.com ([217.140.110.172]:49566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405641AbfHBKqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:46:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62618344;
        Fri,  2 Aug 2019 03:46:39 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5ED193F71F;
        Fri,  2 Aug 2019 03:46:38 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH] cpufreq: schedutil: fix equation in comment
Date:   Fri,  2 Aug 2019 11:46:28 +0100
Message-Id: <20190802104628.8410-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scale_irq_capacity() call in schedutil_cpu_util() does

	util *= (max - irq)
	util /= max

But the comment says

	util *= (1 - irq)
	util /= max

Fix the comment to match what the scaling function does.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 636ca6f88c8e..e127d89d5974 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -259,9 +259,9 @@ unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
 	 * irq metric. Because IRQ/steal time is hidden from the task clock we
 	 * need to scale the task numbers:
 	 *
-	 *              1 - irq
-	 *   U' = irq + ------- * U
-	 *                max
+	 *              max - irq
+	 *   U' = irq + --------- * U
+	 *                 max
 	 */
 	util = scale_irq_capacity(util, irq, max);
 	util += irq;
-- 
2.17.1

