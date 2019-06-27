Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41ADC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C016E2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="chLT8Iya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfF0Xea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:34:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54689 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfF0Xe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:34:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNY4lU499163
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:34:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNY4lU499163
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561678445;
        bh=bvqaff+LKO2duYOPWIh0tvkywsjapO72ypsVuyq/aro=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=chLT8IyazUOq82Ogpq8wm3EOl+sqPQHBxqnZokTYbnL0GY58Jmk7G6moCV6MVpFq8
         HoxsPd6YwAQS77RIh0wg+rcbn3rSD/qA4rs5tYcmoiEkiYwN2NVtY9HW+vJqA3Z7YN
         l7ZFF3zLeuWjwSamLkYPq5IZJgs922x2BMR7S76Q7qQE8WP6PhbiPXEiXpS8fvIlEd
         vt0bKe8P+c9xuzxGhU71483PILKY6tM6R+ul5pMJcG40VKGuKhFhqWbAxdo0Wrk4P2
         MRlS9VH5oBZUjU8E5F6vGEck5bQIas2sDhOCIcJyhceuO1oYBKmlf5A0E4KJ9ZzuSe
         Msd/QRpWSbGXg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNY3LS499160;
        Thu, 27 Jun 2019 16:34:03 -0700
Date:   Thu, 27 Jun 2019 16:34:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-36b9017f0250a5299bb715b3b8c41b5e2b05b320@git.kernel.org>
Cc:     ricardo.neri-calderon@linux.intel.com, hpa@zytor.com,
        tglx@linutronix.de, mingo@kernel.org, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        eranian@google.com, andi.kleen@intel.com,
        Suravee.Suthikulpanit@amd.com, ashok.raj@intel.com
Reply-To: andi.kleen@intel.com, peterz@infradead.org, eranian@google.com,
          Suravee.Suthikulpanit@amd.com, ashok.raj@intel.com,
          hpa@zytor.com, tglx@linutronix.de,
          ricardo.neri-calderon@linux.intel.com, ravi.v.shankar@intel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20190623132434.047254075@linutronix.de>
References: <20190623132434.047254075@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Simplify CPU online code
Git-Commit-ID: 36b9017f0250a5299bb715b3b8c41b5e2b05b320
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  36b9017f0250a5299bb715b3b8c41b5e2b05b320
Gitweb:     https://git.kernel.org/tip/36b9017f0250a5299bb715b3b8c41b5e2b05b320
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Jun 2019 15:23:41 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:15 +0200

x86/hpet: Simplify CPU online code

The indirection via work scheduled on the upcoming CPU was necessary with the
old hotplug code because the online callback was invoked on the control CPU
not on the upcoming CPU. The rework of the CPU hotplug core guarantees that
the online callbacks are invoked on the upcoming CPU.

Remove the now pointless work redirection.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/20190623132434.047254075@linutronix.de

---
 arch/x86/kernel/hpet.c | 31 ++-----------------------------
 1 file changed, 2 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index a0573f2e7763..a6aa22677768 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -547,12 +547,10 @@ static int hpet_setup_irq(struct hpet_dev *dev)
 	return 0;
 }
 
-/* This should be called in specific @cpu */
 static void init_one_hpet_msi_clockevent(struct hpet_dev *hdev, int cpu)
 {
 	struct clock_event_device *evt = &hdev->evt;
 
-	WARN_ON(cpu != smp_processor_id());
 	if (!(hdev->flags & HPET_DEV_VALID))
 		return;
 
@@ -684,36 +682,12 @@ static struct hpet_dev *hpet_get_unused_timer(void)
 	return NULL;
 }
 
-struct hpet_work_struct {
-	struct delayed_work work;
-	struct completion complete;
-};
-
-static void hpet_work(struct work_struct *w)
+static int hpet_cpuhp_online(unsigned int cpu)
 {
-	struct hpet_dev *hdev;
-	int cpu = smp_processor_id();
-	struct hpet_work_struct *hpet_work;
+	struct hpet_dev *hdev = hpet_get_unused_timer();
 
-	hpet_work = container_of(w, struct hpet_work_struct, work.work);
-
-	hdev = hpet_get_unused_timer();
 	if (hdev)
 		init_one_hpet_msi_clockevent(hdev, cpu);
-
-	complete(&hpet_work->complete);
-}
-
-static int hpet_cpuhp_online(unsigned int cpu)
-{
-	struct hpet_work_struct work;
-
-	INIT_DELAYED_WORK_ONSTACK(&work.work, hpet_work);
-	init_completion(&work.complete);
-	/* FIXME: add schedule_work_on() */
-	schedule_delayed_work_on(cpu, &work.work, 0);
-	wait_for_completion(&work.complete);
-	destroy_delayed_work_on_stack(&work.work);
 	return 0;
 }
 
@@ -1045,7 +1019,6 @@ static __init int hpet_late_init(void)
 	if (boot_cpu_has(X86_FEATURE_ARAT))
 		return 0;
 
-	/* This notifier should be called after workqueue is ready */
 	ret = cpuhp_setup_state(CPUHP_AP_X86_HPET_ONLINE, "x86/hpet:online",
 				hpet_cpuhp_online, NULL);
 	if (ret)
