Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2BDC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DA6272AE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HDl9T3wu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfFCN1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:27:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53711 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfFCN1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:27:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DRYkx609615
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:27:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DRYkx609615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559568454;
        bh=P4ttUhxGtuwNPZVvCDeOIUJAP0mCa9X3KocpeNEBCdU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=HDl9T3wuFwNok8JYvKYurLJzMS4WYhz/LsmH4bQg5UPappXst9Ohf9JF9DEgP3CGr
         aCa9Od5TjS3yCwTYDoW20Yzv9aFLup/KVOH6bsHIOTSPcrO2Zvbyyj97pK9mG1TnQV
         QgSS6AQ20NbkjDlj0sBrYfUSg7oBc5ru8UtqDAJ81GFGZRPj+32vG/2W/TZGLCmkYx
         EWHri1uFBnPA3GJQ1y3VHoBzxl+/nK7uSl/EqHqtLcAUZiloQMXuQcm5801i4yvgzt
         BA36biVf5GsE+7u+ncmCSGqYHSsrW5Q1YqADfGGqI2H8LpakAgSf2XtMTUrOnyHU/i
         tc2oDUI2nrFtQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DRXC3609612;
        Mon, 3 Jun 2019 06:27:33 -0700
Date:   Mon, 3 Jun 2019 06:27:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-baa0c83363c7aafb04734acf4ac252be8e13bd88@git.kernel.org>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, torvalds@linux-foundation.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        peterz@infradead.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: gregkh@linuxfoundation.org, tglx@linutronix.de,
          peterz@infradead.org, mingo@kernel.org, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          torvalds@linux-foundation.org, acme@kernel.org,
          alexander.shishkin@linux.intel.com, hpa@zytor.com
In-Reply-To: <20190512155518.21468-5-jolsa@kernel.org>
References: <20190512155518.21468-5-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86: Use the new pmu::update_attrs attribute
 group
Git-Commit-ID: baa0c83363c7aafb04734acf4ac252be8e13bd88
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

Commit-ID:  baa0c83363c7aafb04734acf4ac252be8e13bd88
Gitweb:     https://git.kernel.org/tip/baa0c83363c7aafb04734acf4ac252be8e13bd88
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 12 May 2019 17:55:13 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:58:23 +0200

perf/x86: Use the new pmu::update_attrs attribute group

Using the new pmu::update_attrs attribute group to
create detected events for x86_pmu.

Moving the topdown/memory/tsx attributes to separate
attribute groups with specific is_visible functions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190512155518.21468-5-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/core.c       | 10 ++----
 arch/x86/events/intel/core.c | 86 +++++++++++++++++++++++++-------------------
 arch/x86/events/perf_event.h |  2 +-
 3 files changed, 52 insertions(+), 46 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 0c5a2c783374..db815ceb5017 100644
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
index a5436cee20b1..600e87055ba9 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4274,13 +4274,6 @@ static struct attribute *icl_tsx_events_attrs[] = {
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
@@ -4406,32 +4399,47 @@ static struct attribute *intel_pmu_attrs[] = {
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
+
+static struct attribute *empty_attrs;
 
 __init int intel_pmu_init(void)
 {
-	struct attribute **extra_attr = NULL;
-	struct attribute **mem_attr = NULL;
-	struct attribute **tsx_attr = NULL;
+	struct attribute **extra_attr = &empty_attrs;
+	struct attribute **td_attr    = &empty_attrs;
+	struct attribute **mem_attr   = &empty_attrs;
+	struct attribute **tsx_attr   = &empty_attrs;
 	struct attribute **to_free = NULL;
 	union cpuid10_edx edx;
 	union cpuid10_eax eax;
@@ -4596,7 +4604,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.pebs_constraints = intel_slm_pebs_event_constraints;
 		x86_pmu.extra_regs = intel_slm_extra_regs;
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
-		x86_pmu.cpu_events = slm_events_attrs;
+		td_attr = slm_events_attrs;
 		extra_attr = slm_format_attr;
 		pr_cont("Silvermont events, ");
 		name = "silvermont";
@@ -4624,7 +4632,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.pebs_prec_dist = true;
 		x86_pmu.lbr_pt_coexist = true;
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
-		x86_pmu.cpu_events = glm_events_attrs;
+		td_attr = glm_events_attrs;
 		extra_attr = slm_format_attr;
 		pr_cont("Goldmont events, ");
 		name = "goldmont";
@@ -4651,7 +4659,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_PEBS_ALL;
 		x86_pmu.get_event_constraints = glp_get_event_constraints;
-		x86_pmu.cpu_events = glm_events_attrs;
+		td_attr = glm_events_attrs;
 		/* Goldmont Plus has 4-wide pipeline */
 		event_attr_td_total_slots_scale_glm.event_str = "4";
 		extra_attr = slm_format_attr;
@@ -4740,7 +4748,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
 
-		x86_pmu.cpu_events = snb_events_attrs;
+		td_attr  = snb_events_attrs;
 		mem_attr = snb_mem_events_attrs;
 
 		/* UOPS_ISSUED.ANY,c=1,i=1 to count stall cycles */
@@ -4781,7 +4789,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
 
-		x86_pmu.cpu_events = snb_events_attrs;
+		td_attr  = snb_events_attrs;
 		mem_attr = snb_mem_events_attrs;
 
 		/* UOPS_ISSUED.ANY,c=1,i=1 to count stall cycles */
@@ -4818,10 +4826,10 @@ __init int intel_pmu_init(void)
 
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
@@ -4860,10 +4868,10 @@ __init int intel_pmu_init(void)
 
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
@@ -4922,7 +4930,7 @@ __init int intel_pmu_init(void)
 			hsw_format_attr : nhm_format_attr;
 		extra_attr = merge_attr(extra_attr, skl_format_attr);
 		to_free = extra_attr;
-		x86_pmu.cpu_events = hsw_events_attrs;
+		td_attr  = hsw_events_attrs;
 		mem_attr = hsw_mem_events_attrs;
 		tsx_attr = hsw_tsx_events_attrs;
 		intel_pmu_pebs_data_source_skl(
@@ -4960,7 +4968,8 @@ __init int intel_pmu_init(void)
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 			hsw_format_attr : nhm_format_attr;
 		extra_attr = merge_attr(extra_attr, skl_format_attr);
-		x86_pmu.cpu_events = get_icl_events_attrs();
+		mem_attr = icl_events_attrs;
+		tsx_attr = icl_tsx_events_attrs;
 		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xca, .umask=0x02);
 		x86_pmu.lbr_pt_coexist = true;
 		intel_pmu_pebs_data_source_skl(false);
@@ -4994,8 +5003,11 @@ __init int intel_pmu_init(void)
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
index 1599008f156a..629b313d8b8b 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -634,7 +634,7 @@ struct x86_pmu {
 	struct attribute **caps_attrs;
 
 	ssize_t		(*events_sysfs_show)(char *page, u64 config);
-	struct attribute **cpu_events;
+	const struct attribute_group **attr_update;
 
 	unsigned long	attr_freeze_on_smi;
 	struct attribute **attrs;
