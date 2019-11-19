Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60D9C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED16222ED
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfKSMOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 07:14:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52124 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbfKSMOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 07:14:34 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iX2Or-0003To-3p; Tue, 19 Nov 2019 13:14:29 +0100
Date:   Tue, 19 Nov 2019 13:14:29 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] perf/core: Add SRCU annotation for pmus list walk
Message-ID: <20191119121429.zhcubzdhm672zasg@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit
   28875945ba98d ("rcu: Add support for consolidated-RCU reader checking")

there is an additional check to ensure that a RCU related lock is held
while the RCU list is iterated.
This section holds the SRCU reader lock instead.

Add annotation to list_for_each_entry_rcu() that pmus_srcu must be
acquired during the list traversal.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

I see the warning in in v5.4-rc during boot. For some reason I don't see
it in tip/master during boot but "perf stat w" triggers it again (among
other things).

 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5224388872069..dbb3b26a55612 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10497,7 +10497,7 @@ static struct pmu *perf_init_event(struct perf_event *event)
 		goto unlock;
 	}
 
-	list_for_each_entry_rcu(pmu, &pmus, entry) {
+	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
 		ret = perf_try_init_event(pmu, event);
 		if (!ret)
 			goto unlock;
-- 
2.24.0

