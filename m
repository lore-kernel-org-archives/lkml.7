Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC8CC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3020A2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389110AbfEXBRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 21:17:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:15055 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731688AbfEXBQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 21:16:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 18:16:37 -0700
X-ExtLoop1: 1
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
  by fmsmga008.fm.intel.com with ESMTP; 23 May 2019 18:16:36 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     Ashok Raj <ashok.raj@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Don Zickus <dzickus@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Babu Moger <Babu.Moger@amd.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Colin Ian King <colin.king@canonical.com>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Rientjes <rientjes@google.com>
Subject: [RFC PATCH v4 12/21] watchdog/hardlockup/hpet: Adjust timer expiration on the number of monitored CPUs
Date:   Thu, 23 May 2019 18:16:14 -0700
Message-Id: <1558660583-28561-13-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each CPU should be monitored for hardlockups every watchdog_thresh seconds.
Since all the CPUs in the system are monitored by the same timer and the
timer interrupt is rotated among the monitored CPUs, the timer must expire
every watchdog_thresh/N seconds; where N is the number of monitored CPUs.
Use the new member of struct hld_data, ticks_per_cpu, to store the
aforementioned quantity.

The ticks-per-CPU quantity is updated every time the number of monitored
CPUs changes: when the watchdog is enabled or disabled for a specific CPU.
If the timer is used in periodic mode, it needs to be adjusted to reflect
the new expected expiration.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Babu Moger <Babu.Moger@amd.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Byungchul Park <byungchul.park@lge.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/hpet.h         |  1 +
 arch/x86/kernel/watchdog_hld_hpet.c | 46 +++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 31fc27508cf3..64acacce095d 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -114,6 +114,7 @@ struct hpet_hld_data {
 	bool		has_periodic;
 	u32		num;
 	u64		ticks_per_second;
+	u64		ticks_per_cpu;
 	u32		handling_cpu;
 	u32		enabled_cpus;
 	struct msi_msg	msi_msg;
diff --git a/arch/x86/kernel/watchdog_hld_hpet.c b/arch/x86/kernel/watchdog_hld_hpet.c
index dff4dadabd4c..74aeb0535d08 100644
--- a/arch/x86/kernel/watchdog_hld_hpet.c
+++ b/arch/x86/kernel/watchdog_hld_hpet.c
@@ -45,6 +45,13 @@ static void kick_timer(struct hpet_hld_data *hdata, bool force)
 	 * are able to update the comparator before the counter reaches such new
 	 * value.
 	 *
+	 * Each CPU must be monitored every watch_thresh seconds. Since the
+	 * timer targets one CPU at a time, it must expire every
+	 *
+	 *        ticks_per_cpu = watch_thresh * ticks_per_second /enabled_cpus
+	 *
+	 * as computed in update_ticks_per_cpu().
+	 *
 	 * Let it wrap around if needed.
 	 */
 
@@ -52,10 +59,10 @@ static void kick_timer(struct hpet_hld_data *hdata, bool force)
 		return;
 
 	if (hdata->has_periodic)
-		period = watchdog_thresh * hdata->ticks_per_second;
+		period = watchdog_thresh * hdata->ticks_per_cpu;
 
 	count = hpet_readl(HPET_COUNTER);
-	new_compare = count + watchdog_thresh * hdata->ticks_per_second;
+	new_compare = count + watchdog_thresh * hdata->ticks_per_cpu;
 	hpet_set_comparator(hdata->num, (u32)new_compare, (u32)period);
 }
 
@@ -234,6 +241,27 @@ static int setup_hpet_irq(struct hpet_hld_data *hdata)
 	return ret;
 }
 
+/**
+ * update_ticks_per_cpu() - Update the number of HPET ticks per CPU
+ * @hdata:     struct with the timer's the ticks-per-second and CPU mask
+ *
+ * From the overall ticks-per-second of the timer, compute the number of ticks
+ * after which the timer should expire to monitor each CPU every watch_thresh
+ * seconds. The ticks-per-cpu quantity is computed using the number of CPUs that
+ * the watchdog currently monitors.
+ */
+static void update_ticks_per_cpu(struct hpet_hld_data *hdata)
+{
+	u64 temp = hdata->ticks_per_second;
+
+	/* Only update if there are monitored CPUs. */
+	if (!hdata->enabled_cpus)
+		return;
+
+	do_div(temp, hdata->enabled_cpus);
+	hdata->ticks_per_cpu = temp;
+}
+
 /**
  * hardlockup_detector_hpet_enable() - Enable the hardlockup detector
  * @cpu:	CPU Index in which the watchdog will be enabled.
@@ -246,13 +274,23 @@ void hardlockup_detector_hpet_enable(unsigned int cpu)
 {
 	cpumask_set_cpu(cpu, to_cpumask(hld_data->cpu_monitored_mask));
 
-	if (!hld_data->enabled_cpus++) {
+	hld_data->enabled_cpus++;
+	update_ticks_per_cpu(hld_data);
+
+	if (hld_data->enabled_cpus == 1) {
 		hld_data->handling_cpu = cpu;
 		update_msi_destid(hld_data);
 		/* Force timer kick when detector is just enabled */
 		kick_timer(hld_data, true);
 		enable_timer(hld_data);
 	}
+
+	/*
+	 * When in periodic mode, we only kick the timer here. Hence,
+	 * as there are now more CPUs to monitor, we need to adjust the
+	 * periodic expiration.
+	 */
+	kick_timer(hld_data, hld_data->has_periodic);
 }
 
 /**
@@ -268,6 +306,8 @@ void hardlockup_detector_hpet_disable(unsigned int cpu)
 	cpumask_clear_cpu(cpu, to_cpumask(hld_data->cpu_monitored_mask));
 	hld_data->enabled_cpus--;
 
+	update_ticks_per_cpu(hld_data);
+
 	if (hld_data->handling_cpu != cpu)
 		return;
 
-- 
2.17.1

