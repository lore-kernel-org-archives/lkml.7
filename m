Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188BFC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE61D21882
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573009721;
	bh=UXcWVvKMyk4uCT/8mt9Oswc2VR0c6sstuPmRDKRoOMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l96/tqbWktpoBTMVRfk6QJG3O5fy3Pf1Jgj9jy6L/zfsu1IUKd5Kg1FWzo4kSMq1o
	 ajh6hfzvI/76t+wswbb9Y9egWwsldZh/lOWQ4m1Sn3Uqr6RpHzAzhQMfZ0L4ZjeynI
	 jNtHqGZeJaGldcxMRS2RGVx/qb6lUyjrOJVlazGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388410AbfKFDIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:08:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:44438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388340AbfKFDIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:08:34 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6712B217F4;
        Wed,  6 Nov 2019 03:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573009713;
        bh=UXcWVvKMyk4uCT/8mt9Oswc2VR0c6sstuPmRDKRoOMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OMISgmGdnBMi3es7YzMCNTylDiRf5A52G/wEuGYrleqbZDYP99X2EvyRok7m7W/MA
         rGEPiEjCLDZfpvxc7oZvYmyiDu8Zee7g7fnPlwsPRt+ZxbOvR8SOujgyXcPkS8AkoZ
         cNX6h5ZreJapxaESygy1yNUl1W/Vcbs26YoXFbSM=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Pavel Machek <pavel@ucw.cz>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 6/9] procfs: Use all-in-one vtime aware kcpustat accessor
Date:   Wed,  6 Nov 2019 04:08:04 +0100
Message-Id: <20191106030807.31091-7-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030807.31091-1-frederic@kernel.org>
References: <20191106030807.31091-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we can read also user and guest time safely under vtime, use
the relevant accessor to fix frozen kcpustat values on nohz_full CPUs.

Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 fs/proc/stat.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 5c6bd0ae3802..b2ee5418dece 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -120,18 +120,21 @@ static int show_stat(struct seq_file *p, void *v)
 	getboottime64(&boottime);
 
 	for_each_possible_cpu(i) {
+		u64 cpu_user, cpu_nice, cpu_sys, cpu_guest, cpu_guest_nice;
 		struct kernel_cpustat *kcs = &kcpustat_cpu(i);
 
-		user += kcs->cpustat[CPUTIME_USER];
-		nice += kcs->cpustat[CPUTIME_NICE];
-		system += kcpustat_field(kcs, CPUTIME_SYSTEM, i);
+		kcpustat_cputime(kcs, i, &cpu_user, &cpu_nice,
+				 &cpu_sys, &cpu_guest, &cpu_guest_nice);
+		user += cpu_user;
+		nice += cpu_nice;
+		system += cpu_sys;
 		idle += get_idle_time(kcs, i);
 		iowait += get_iowait_time(kcs, i);
 		irq += kcs->cpustat[CPUTIME_IRQ];
 		softirq += kcs->cpustat[CPUTIME_SOFTIRQ];
 		steal += kcs->cpustat[CPUTIME_STEAL];
-		guest += kcs->cpustat[CPUTIME_GUEST];
-		guest_nice += kcs->cpustat[CPUTIME_GUEST_NICE];
+		guest += cpu_guest;
+		guest_nice += guest_nice;
 		sum += kstat_cpu_irqs_sum(i);
 		sum += arch_irq_stat_cpu(i);
 
@@ -159,17 +162,14 @@ static int show_stat(struct seq_file *p, void *v)
 	for_each_online_cpu(i) {
 		struct kernel_cpustat *kcs = &kcpustat_cpu(i);
 
+		kcpustat_cputime(kcs, i, &user, &nice,
+				 &system, &guest, &guest_nice);
 		/* Copy values here to work around gcc-2.95.3, gcc-2.96 */
-		user = kcs->cpustat[CPUTIME_USER];
-		nice = kcs->cpustat[CPUTIME_NICE];
-		system = kcpustat_field(kcs, CPUTIME_SYSTEM, i);
 		idle = get_idle_time(kcs, i);
 		iowait = get_iowait_time(kcs, i);
 		irq = kcs->cpustat[CPUTIME_IRQ];
 		softirq = kcs->cpustat[CPUTIME_SOFTIRQ];
 		steal = kcs->cpustat[CPUTIME_STEAL];
-		guest = kcs->cpustat[CPUTIME_GUEST];
-		guest_nice = kcs->cpustat[CPUTIME_GUEST_NICE];
 		seq_printf(p, "cpu%d", i);
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(user));
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(nice));
-- 
2.23.0

