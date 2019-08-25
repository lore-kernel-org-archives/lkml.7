Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23044C3A5A3
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 09:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056B920674
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 09:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfHYJpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 05:45:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37972 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfHYJpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 05:45:15 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i1p5E-0004t8-Qq; Sun, 25 Aug 2019 11:45:12 +0200
Date:   Sun, 25 Aug 2019 09:43:00 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/urgent for 5.3-rc5
References: <156672618029.19810.8479315461492191933.tglx@nanos.tec.linutronix.de>
Message-ID: <156672618029.19810.8453030714221422841.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

up to:  f1c6ece23729: kprobes: Fix potential deadlock in kprobe_optimizer()

Two small fixes for kprobes and perf:

    - Prevent a deadlock in kprobe_optimizer() causes by reverse lock
      ordering

    - Fix a comment typo

Thanks,

	tglx

------------------>
Andrea Righi (1):
      kprobes: Fix potential deadlock in kprobe_optimizer()

Su Yanjun (1):
      perf/x86: Fix typo in comment


 arch/x86/events/core.c | 2 +-
 kernel/kprobes.c       | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 81b005e4c7d9..325959d19d9a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1236,7 +1236,7 @@ void x86_pmu_enable_event(struct perf_event *event)
  * Add a single event to the PMU.
  *
  * The event is added to the group of enabled events
- * but only if it can be scehduled with existing events.
+ * but only if it can be scheduled with existing events.
  */
 static int x86_pmu_add(struct perf_event *event, int flags)
 {
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 9873fc627d61..d9770a5393c8 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -470,6 +470,7 @@ static DECLARE_DELAYED_WORK(optimizing_work, kprobe_optimizer);
  */
 static void do_optimize_kprobes(void)
 {
+	lockdep_assert_held(&text_mutex);
 	/*
 	 * The optimization/unoptimization refers online_cpus via
 	 * stop_machine() and cpu-hotplug modifies online_cpus.
@@ -487,9 +488,7 @@ static void do_optimize_kprobes(void)
 	    list_empty(&optimizing_list))
 		return;
 
-	mutex_lock(&text_mutex);
 	arch_optimize_kprobes(&optimizing_list);
-	mutex_unlock(&text_mutex);
 }
 
 /*
@@ -500,6 +499,7 @@ static void do_unoptimize_kprobes(void)
 {
 	struct optimized_kprobe *op, *tmp;
 
+	lockdep_assert_held(&text_mutex);
 	/* See comment in do_optimize_kprobes() */
 	lockdep_assert_cpus_held();
 
@@ -507,7 +507,6 @@ static void do_unoptimize_kprobes(void)
 	if (list_empty(&unoptimizing_list))
 		return;
 
-	mutex_lock(&text_mutex);
 	arch_unoptimize_kprobes(&unoptimizing_list, &freeing_list);
 	/* Loop free_list for disarming */
 	list_for_each_entry_safe(op, tmp, &freeing_list, list) {
@@ -524,7 +523,6 @@ static void do_unoptimize_kprobes(void)
 		} else
 			list_del_init(&op->list);
 	}
-	mutex_unlock(&text_mutex);
 }
 
 /* Reclaim all kprobes on the free_list */
@@ -556,6 +554,7 @@ static void kprobe_optimizer(struct work_struct *work)
 {
 	mutex_lock(&kprobe_mutex);
 	cpus_read_lock();
+	mutex_lock(&text_mutex);
 	/* Lock modules while optimizing kprobes */
 	mutex_lock(&module_mutex);
 
@@ -583,6 +582,7 @@ static void kprobe_optimizer(struct work_struct *work)
 	do_free_cleaned_kprobes();
 
 	mutex_unlock(&module_mutex);
+	mutex_unlock(&text_mutex);
 	cpus_read_unlock();
 	mutex_unlock(&kprobe_mutex);
 


