Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6071C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 12:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82607206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 12:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556974344;
	bh=RbqCy6HjxGO7pw+jRIzuGJ1kUTBV2supMCCSPBQrevI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I4xK97YVGSiW1OGQlolxAJe5Xc2Ke3m48er8xE0V31deUDACSLvOJCbUKeJp4/ZpS
	 VHW8CaQzE/JhMWEz6V/EbRSj86ssZiG01CqF4YJiy17soRix6BUZUu1qU0MU/hh1Ne
	 GbA2uMeWWw9sqPzLr9oR/RdKbUgIBO8F9j/e/L2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfEDMwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 08:52:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727279AbfEDMwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 08:52:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 935E159447;
        Sat,  4 May 2019 12:52:17 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA5465C298;
        Sat,  4 May 2019 12:52:15 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4/8] perf/x86: Use the new pmu::update_attrs attribute group
Date:   Sat,  4 May 2019 14:52:03 +0200
Message-Id: <20190504125207.24662-5-jolsa@kernel.org>
In-Reply-To: <20190504125207.24662-1-jolsa@kernel.org>
References: <20190504125207.24662-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sat, 04 May 2019 12:52:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the new pmu::update_attrs attribute group to
create detected events for x86_pmu.

Moving the topdown/memory/tsx attributes to separate
attribute groups with specific is_visible functions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/core.c       | 10 +----
 arch/x86/events/intel/core.c | 78 ++++++++++++++++++++----------------
 arch/x86/events/perf_event.h |  2 +-
 3 files changed, 47 insertions(+), 43 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f2be5d2a62fe..a43d8d1e8590 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1855,14 +1855,6 @@ static int __init init_hw_perf_events(void)
 	else
 		filter_events(x86_pmu_events_group.attrs);
 
-	if (x86_pmu.cpu_events) {
-		struct attribute **tmp;
-
-		tmp = merge_attr(x86_pmu_events_group.attrs, x86_pmu.cpu_events);
-		if (!WARN_ON(!tmp))
-			x86_pmu_events_group.attrs = tmp;
-	}
-
 	if (x86_pmu.attrs) {
 		struct attribute **tmp;
 
@@ -1871,6 +1863,8 @@ static int __init init_hw_perf_events(void)
 			x86_pmu_attr_group.attrs = tmp;
 	}
 
+	pmu.attr_update = x86_pmu.attr_update;
+
 	pr_info("... version:                %d\n",     x86_pmu.version);
 	pr_info("... bit width:              %d\n",     x86_pmu.cntval_bits);
 	pr_info("... generic registers:      %d\n",     x86_pmu.num_counters);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4b4dac089635..354396da90a8 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4265,13 +4265,6 @@ static struct attribute *icl_tsx_events_attrs[] = {
 	NULL,
 };
 
-static __init struct attribute **get_icl_events_attrs(void)
-{
-	return boot_cpu_has(X86_FEATURE_RTM) ?
-		merge_attr(icl_events_attrs, icl_tsx_events_attrs) :
-		icl_events_attrs;
-}
-
 static ssize_t freeze_on_smi_show(struct device *cdev,
 				  struct device_attribute *attr,
 				  char *buf)
@@ -4397,30 +4390,43 @@ static struct attribute *intel_pmu_attrs[] = {
 	NULL,
 };
 
-static __init struct attribute **
-get_events_attrs(struct attribute **base,
-		 struct attribute **mem,
-		 struct attribute **tsx)
+static umode_t
+tsx_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
-	struct attribute **attrs = base;
-	struct attribute **old;
+	return boot_cpu_has(X86_FEATURE_RTM) ? attr->mode : 0;
+}
 
-	if (mem && x86_pmu.pebs)
-		attrs = merge_attr(attrs, mem);
+static umode_t
+pebs_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return x86_pmu.pebs ? attr->mode : 0;
+}
 
-	if (tsx && boot_cpu_has(X86_FEATURE_RTM)) {
-		old = attrs;
-		attrs = merge_attr(attrs, tsx);
-		if (old != base)
-			kfree(old);
-	}
+static struct attribute_group group_events_td  = {
+	.name = "events",
+};
 
-	return attrs;
-}
+static struct attribute_group group_events_mem = {
+	.name       = "events",
+	.is_visible = pebs_is_visible,
+};
+
+static struct attribute_group group_events_tsx = {
+	.name       = "events",
+	.is_visible = tsx_is_visible,
+};
+
+static const struct attribute_group *attr_update[] = {
+	&group_events_td,
+	&group_events_mem,
+	&group_events_tsx,
+	NULL,
+};
 
 __init int intel_pmu_init(void)
 {
 	struct attribute **extra_attr = NULL;
+	struct attribute **td_attr = NULL;
 	struct attribute **mem_attr = NULL;
 	struct attribute **tsx_attr = NULL;
 	struct attribute **to_free = NULL;
@@ -4587,7 +4593,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.pebs_constraints = intel_slm_pebs_event_constraints;
 		x86_pmu.extra_regs = intel_slm_extra_regs;
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
-		x86_pmu.cpu_events = slm_events_attrs;
+		td_attr = slm_events_attrs;
 		extra_attr = slm_format_attr;
 		pr_cont("Silvermont events, ");
 		name = "silvermont";
@@ -4615,7 +4621,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.pebs_prec_dist = true;
 		x86_pmu.lbr_pt_coexist = true;
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
-		x86_pmu.cpu_events = glm_events_attrs;
+		td_attr = glm_events_attrs;
 		extra_attr = slm_format_attr;
 		pr_cont("Goldmont events, ");
 		name = "goldmont";
@@ -4642,7 +4648,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_PEBS_ALL;
 		x86_pmu.get_event_constraints = glp_get_event_constraints;
-		x86_pmu.cpu_events = glm_events_attrs;
+		td_attr = glm_events_attrs;
 		/* Goldmont Plus has 4-wide pipeline */
 		event_attr_td_total_slots_scale_glm.event_str = "4";
 		extra_attr = slm_format_attr;
@@ -4731,7 +4737,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
 
-		x86_pmu.cpu_events = snb_events_attrs;
+		td_attr  = snb_events_attrs;
 		mem_attr = snb_mem_events_attrs;
 
 		/* UOPS_ISSUED.ANY,c=1,i=1 to count stall cycles */
@@ -4772,7 +4778,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
 
-		x86_pmu.cpu_events = snb_events_attrs;
+		td_attr  = snb_events_attrs;
 		mem_attr = snb_mem_events_attrs;
 
 		/* UOPS_ISSUED.ANY,c=1,i=1 to count stall cycles */
@@ -4809,10 +4815,10 @@ __init int intel_pmu_init(void)
 
 		x86_pmu.hw_config = hsw_hw_config;
 		x86_pmu.get_event_constraints = hsw_get_event_constraints;
-		x86_pmu.cpu_events = hsw_events_attrs;
 		x86_pmu.lbr_double_abort = true;
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 			hsw_format_attr : nhm_format_attr;
+		td_attr  = hsw_events_attrs;
 		mem_attr = hsw_mem_events_attrs;
 		tsx_attr = hsw_tsx_events_attrs;
 		pr_cont("Haswell events, ");
@@ -4851,10 +4857,10 @@ __init int intel_pmu_init(void)
 
 		x86_pmu.hw_config = hsw_hw_config;
 		x86_pmu.get_event_constraints = hsw_get_event_constraints;
-		x86_pmu.cpu_events = hsw_events_attrs;
 		x86_pmu.limit_period = bdw_limit_period;
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 			hsw_format_attr : nhm_format_attr;
+		td_attr  = hsw_events_attrs;
 		mem_attr = hsw_mem_events_attrs;
 		tsx_attr = hsw_tsx_events_attrs;
 		pr_cont("Broadwell events, ");
@@ -4913,7 +4919,7 @@ __init int intel_pmu_init(void)
 			hsw_format_attr : nhm_format_attr;
 		extra_attr = merge_attr(extra_attr, skl_format_attr);
 		to_free = extra_attr;
-		x86_pmu.cpu_events = hsw_events_attrs;
+		td_attr  = hsw_events_attrs;
 		mem_attr = hsw_mem_events_attrs;
 		tsx_attr = hsw_tsx_events_attrs;
 		intel_pmu_pebs_data_source_skl(
@@ -4951,7 +4957,8 @@ __init int intel_pmu_init(void)
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 			hsw_format_attr : nhm_format_attr;
 		extra_attr = merge_attr(extra_attr, skl_format_attr);
-		x86_pmu.cpu_events = get_icl_events_attrs();
+		mem_attr = icl_events_attrs;
+		tsx_attr = icl_tsx_events_attrs;
 		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xca, .umask=0x02);
 		x86_pmu.lbr_pt_coexist = true;
 		intel_pmu_pebs_data_source_skl(false);
@@ -4985,8 +4992,11 @@ __init int intel_pmu_init(void)
 		WARN_ON(!x86_pmu.format_attrs);
 	}
 
-	x86_pmu.cpu_events = get_events_attrs(x86_pmu.cpu_events,
-					      mem_attr, tsx_attr);
+	group_events_td.attrs  = td_attr;
+	group_events_mem.attrs = mem_attr;
+	group_events_tsx.attrs = tsx_attr;
+
+	x86_pmu.attr_update = attr_update;
 
 	if (x86_pmu.num_counters > INTEL_PMC_MAX_GENERIC) {
 		WARN(1, KERN_ERR "hw perf events %d > max(%d), clipping!",
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 3f87cb4d7585..7dd91607b5fa 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -634,7 +634,7 @@ struct x86_pmu {
 	struct attribute **caps_attrs;
 
 	ssize_t		(*events_sysfs_show)(char *page, u64 config);
-	struct attribute **cpu_events;
+	const struct attribute_group **attr_update;
 
 	unsigned long	attr_freeze_on_smi;
 	struct attribute **attrs;
-- 
2.20.1

