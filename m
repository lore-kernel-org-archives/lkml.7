Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45F1C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D502077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfDPLeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:34:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36723 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfDPLeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:34:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GBXgqO3428098
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 04:33:42 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GBXgUR3428095;
        Tue, 16 Apr 2019 04:33:42 -0700
Date:   Tue, 16 Apr 2019 04:33:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Stephane Eranian <tipbot@zytor.com>
Message-ID: <tip-f447e4eb3ad1e60d173ca997fcb2ef2a66f12574@git.kernel.org>
Cc:     acme@redhat.com, vincent.weaver@maine.edu, eranian@google.com,
        mingo@kernel.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, hpa@zytor.com
Reply-To: vincent.weaver@maine.edu, mingo@kernel.org, eranian@google.com,
          peterz@infradead.org, alexander.shishkin@linux.intel.com,
          acme@redhat.com, hpa@zytor.com, torvalds@linux-foundation.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          jolsa@redhat.com
In-Reply-To: <20190408173252.37932-3-eranian@google.com>
References: <20190408173252.37932-3-eranian@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel: Force resched when TFA sysctl is
 modified
Git-Commit-ID: f447e4eb3ad1e60d173ca997fcb2ef2a66f12574
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

Commit-ID:  f447e4eb3ad1e60d173ca997fcb2ef2a66f12574
Gitweb:     https://git.kernel.org/tip/f447e4eb3ad1e60d173ca997fcb2ef2a66f12574
Author:     Stephane Eranian <eranian@google.com>
AuthorDate: Mon, 8 Apr 2019 10:32:52 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Apr 2019 12:19:35 +0200

perf/x86/intel: Force resched when TFA sysctl is modified

This patch provides guarantee to the sysadmin that when TFA is disabled, no PMU
event is using PMC3 when the echo command returns. Vice-Versa, when TFA
is enabled, PMU can use PMC3 immediately (to eliminate possible multiplexing).

  $ perf stat -a -I 1000 --no-merge -e branches,branches,branches,branches
     1.000123979    125,768,725,208      branches
     1.000562520    125,631,000,456      branches
     1.000942898    125,487,114,291      branches
     1.001333316    125,323,363,620      branches
     2.004721306    125,514,968,546      branches
     2.005114560    125,511,110,861      branches
     2.005482722    125,510,132,724      branches
     2.005851245    125,508,967,086      branches
     3.006323475    125,166,570,648      branches
     3.006709247    125,165,650,056      branches
     3.007086605    125,164,639,142      branches
     3.007459298    125,164,402,912      branches
     4.007922698    125,045,577,140      branches
     4.008310775    125,046,804,324      branches
     4.008670814    125,048,265,111      branches
     4.009039251    125,048,677,611      branches
     5.009503373    125,122,240,217      branches
     5.009897067    125,122,450,517      branches

Then on another connection, sysadmin does:

  $ echo  1 >/sys/devices/cpu/allow_tsx_force_abort

Then perf stat adjusts the events immediately:

     5.010286029    125,121,393,483      branches
     5.010646308    125,120,556,786      branches
     6.011113588    124,963,351,832      branches
     6.011510331    124,964,267,566      branches
     6.011889913    124,964,829,130      branches
     6.012262996    124,965,841,156      branches
     7.012708299    124,419,832,234      branches [79.69%]
     7.012847908    124,416,363,853      branches [79.73%]
     7.013225462    124,400,723,712      branches [79.73%]
     7.013598191    124,376,154,434      branches [79.70%]
     8.014089834    124,250,862,693      branches [74.98%]
     8.014481363    124,267,539,139      branches [74.94%]
     8.014856006    124,259,519,786      branches [74.98%]
     8.014980848    124,225,457,969      branches [75.04%]
     9.015464576    124,204,235,423      branches [75.03%]
     9.015858587    124,204,988,490      branches [75.04%]
     9.016243680    124,220,092,486      branches [74.99%]
     9.016620104    124,231,260,146      branches [74.94%]

And vice-versa if the syadmin does:

  $ echo  0 >/sys/devices/cpu/allow_tsx_force_abort

Events are again spread over the 4 counters:

    10.017096277    124,276,230,565      branches [74.96%]
    10.017237209    124,228,062,171      branches [75.03%]
    10.017478637    124,178,780,626      branches [75.03%]
    10.017853402    124,198,316,177      branches [75.03%]
    11.018334423    124,602,418,933      branches [85.40%]
    11.018722584    124,602,921,320      branches [85.42%]
    11.019095621    124,603,956,093      branches [85.42%]
    11.019467742    124,595,273,783      branches [85.42%]
    12.019945736    125,110,114,864      branches
    12.020330764    125,109,334,472      branches
    12.020688740    125,109,818,865      branches
    12.021054020    125,108,594,014      branches
    13.021516774    125,109,164,018      branches
    13.021903640    125,108,794,510      branches
    13.022270770    125,107,756,978      branches
    13.022630819    125,109,380,471      branches
    14.023114989    125,133,140,817      branches
    14.023501880    125,133,785,858      branches
    14.023868339    125,133,852,700      branches

Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: kan.liang@intel.com
Cc: nelson.dsouza@intel.com
Cc: tonyj@suse.com
Link: https://lkml.kernel.org/r/20190408173252.37932-3-eranian@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/core.c       |  4 ++++
 arch/x86/events/intel/core.c | 50 ++++++++++++++++++++++++++++++++++++++++++--
 arch/x86/events/perf_event.h |  1 +
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 87b50f4be201..fdd106267fd2 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -661,6 +661,10 @@ static inline int is_x86_event(struct perf_event *event)
 	return event->pmu == &pmu;
 }
 
+struct pmu *x86_get_pmu(void)
+{
+	return &pmu;
+}
 /*
  * Event scheduler state:
  *
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 1bb59c4c59f2..8265b5026a19 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4156,6 +4156,50 @@ done:
 	return count;
 }
 
+static void update_tfa_sched(void *ignored)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	/*
+	 * check if PMC3 is used
+	 * and if so force schedule out for all event types all contexts
+	 */
+	if (test_bit(3, cpuc->active_mask))
+		perf_pmu_resched(x86_get_pmu());
+}
+
+static ssize_t show_sysctl_tfa(struct device *cdev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	return snprintf(buf, 40, "%d\n", allow_tsx_force_abort);
+}
+
+static ssize_t set_sysctl_tfa(struct device *cdev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	bool val;
+	ssize_t ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	/* no change */
+	if (val == allow_tsx_force_abort)
+		return count;
+
+	allow_tsx_force_abort = val;
+
+	get_online_cpus();
+	on_each_cpu(update_tfa_sched, NULL, 1);
+	put_online_cpus();
+
+	return count;
+}
+
+
 static DEVICE_ATTR_RW(freeze_on_smi);
 
 static ssize_t branches_show(struct device *cdev,
@@ -4188,7 +4232,9 @@ static struct attribute *intel_pmu_caps_attrs[] = {
        NULL
 };
 
-static DEVICE_BOOL_ATTR(allow_tsx_force_abort, 0644, allow_tsx_force_abort);
+static DEVICE_ATTR(allow_tsx_force_abort, 0644,
+		   show_sysctl_tfa,
+		   set_sysctl_tfa);
 
 static struct attribute *intel_pmu_attrs[] = {
 	&dev_attr_freeze_on_smi.attr,
@@ -4697,7 +4743,7 @@ __init int intel_pmu_init(void)
 			x86_pmu.get_event_constraints = tfa_get_event_constraints;
 			x86_pmu.enable_all = intel_tfa_pmu_enable_all;
 			x86_pmu.commit_scheduling = intel_tfa_commit_scheduling;
-			intel_pmu_attrs[1] = &dev_attr_allow_tsx_force_abort.attr.attr;
+			intel_pmu_attrs[1] = &dev_attr_allow_tsx_force_abort.attr;
 		}
 
 		pr_cont("Skylake events, ");
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e544d83ea4b4..9e474a5f3b86 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -713,6 +713,7 @@ static struct perf_pmu_events_ht_attr event_attr_##v = {		\
 	.event_str_ht	= ht,						\
 }
 
+struct pmu *x86_get_pmu(void);
 extern struct x86_pmu x86_pmu __read_mostly;
 
 static inline bool x86_pmu_has_lbr_callstack(void)
