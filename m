Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4D5CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 17:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D870921734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 17:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572630529;
	bh=fOf/WsWJqJ2gN+gzOoPyTQDskuAkwvOEX8SuCEtcPbA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=nNDfcE2bThnz9Ofg+c8UbQgy1mOmSHUZkUp964zk9VUDD2y+KSKOeg6nNReH9Hzx/
	 tGt4yUEn1gD5A1p+q+gbpsUTQzrI5k1mlEfLPBhbAhsGTN8gVHgxsTiNPmQGuPAj67
	 Xd4ftwabd+R+np2ijNCKv5xRyQF6uW2khl9Ybr+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfKARsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 13:48:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37952 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfKARsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 13:48:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id v9so10412136wrq.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 10:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fZLyQqDyzkFIzc0XcJJtHwXKhW6lgr9vJZdT1jqXwGs=;
        b=l+zs/GHDRopipfI+Tqe8oMl7yuM1ebd/Rwdw2YpVjBbjFrwGRR5IgbtWUbiZAOpcqA
         DMYb+uXENaoss0awWPMgw43oSLZ/16sOlAP8LagYAVZGcg9gXJSNUlFf1Z9cJ+54FCNC
         IMaPQh+3h4CqNsen3Uh1CyhLNFHqnhAWO2/E5UwUNtXxTFBf+NVsluZouISi+gAvlt2g
         b82qC1xZ4xMkcgeYbK8UoUvKhMGa1sOCl5yeeE0CLFjMT3TF7moFQG25YLvucIe6QYal
         RDokF2BnuzXTQ0AeqYhhhUIvZ5uKaChMdzXqLt/FRm+3QDiv/kAAF7npzBvdpby4kJZx
         kTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=fZLyQqDyzkFIzc0XcJJtHwXKhW6lgr9vJZdT1jqXwGs=;
        b=K2v2fN/RpogIhb65dvdqGzWyMvZkGxcaH7N7NGZruP/gaS/Wl9GhhkWFoIjInDDglz
         SOeR32VpWX3wypmWJKXSBnyvDUZQ3pb6bnOFJFGl5Lltu2AQI19MSNc8XKYgQ/z7to2R
         jqG3znqhdanq1Mtpp7Odl+3QJzj9BZYnVcEmvZrgZ2DlQB6tWDZgdbEaRtpFfnDjXXGJ
         x4yZ+LYfwpMhbO9ZYx1KZBuTsMLJJ+OdHVucoHrhqtDZ2m/58yqDwKS6VEB+TvD7DI7E
         3NpJnFjFy3+KbSlxCUM2eVj/6OY8xnQrSvg4Si7JaY/BZOAkR4dQBWuFij3Bll6StDlN
         FkjA==
X-Gm-Message-State: APjAAAWL8OlnmRcGiSXMbfeeu8gBtinnU6nV+ULj+nxA6ALguXbQLRUl
        rr0LTMitCO20c1BoUMOg1Nc=
X-Google-Smtp-Source: APXvYqxj25kdVNup8l60s965CwawkI67U4PN3ZLMhaOfPGSEn+r3ilW1Z4RBUC3B0ua47Ngbp+p3Ag==
X-Received: by 2002:a05:6000:1048:: with SMTP id c8mr11668362wrx.349.1572630523473;
        Fri, 01 Nov 2019 10:48:43 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id z13sm8644267wrm.64.2019.11.01.10.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 10:48:42 -0700 (PDT)
Date:   Fri, 1 Nov 2019 18:48:40 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [GIT PULL] perf fixes
Message-ID: <20191101174840.GA81963@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: 652521d460cbfa24ef27717b4b28acfac4281be6 perf/headers: Fix spelling s/EACCESS/EACCES/, s/privilidge/privilege/

Misc fixes: an ABI fix for a reserved field, AMD IBS fixes, an Intel 
uncore PMU driver fix and a header typo fix.

 Thanks,

	Ingo

------------------>
Alexander Shishkin (1):
      perf/core: Start rejecting the syscall with attr.__reserved_2 set

Geert Uytterhoeven (1):
      perf/headers: Fix spelling s/EACCESS/EACCES/, s/privilidge/privilege/

Kan Liang (1):
      perf/x86/uncore: Fix event group support

Kim Phillips (2):
      perf/x86/amd/ibs: Fix reading of the IBS OpData register and thus precise RIP validity
      perf/x86/amd/ibs: Handle erratum #420 only on the affected CPU family (10h)


 arch/x86/events/amd/ibs.c      |  8 +++++---
 arch/x86/events/intel/uncore.c | 44 ++++++++++++++++++++++++++++++++++++------
 arch/x86/events/intel/uncore.h | 12 ------------
 include/linux/perf_event.h     |  2 +-
 kernel/events/core.c           |  2 +-
 5 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 5b35b7ea5d72..26c36357c4c9 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -377,7 +377,8 @@ static inline void perf_ibs_disable_event(struct perf_ibs *perf_ibs,
 					  struct hw_perf_event *hwc, u64 config)
 {
 	config &= ~perf_ibs->cnt_mask;
-	wrmsrl(hwc->config_base, config);
+	if (boot_cpu_data.x86 == 0x10)
+		wrmsrl(hwc->config_base, config);
 	config &= ~perf_ibs->enable_mask;
 	wrmsrl(hwc->config_base, config);
 }
@@ -553,7 +554,8 @@ static struct perf_ibs perf_ibs_op = {
 	},
 	.msr			= MSR_AMD64_IBSOPCTL,
 	.config_mask		= IBS_OP_CONFIG_MASK,
-	.cnt_mask		= IBS_OP_MAX_CNT,
+	.cnt_mask		= IBS_OP_MAX_CNT | IBS_OP_CUR_CNT |
+				  IBS_OP_CUR_CNT_RAND,
 	.enable_mask		= IBS_OP_ENABLE,
 	.valid_mask		= IBS_OP_VAL,
 	.max_period		= IBS_OP_MAX_CNT << 4,
@@ -614,7 +616,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	if (event->attr.sample_type & PERF_SAMPLE_RAW)
 		offset_max = perf_ibs->offset_max;
 	else if (check_rip)
-		offset_max = 2;
+		offset_max = 3;
 	else
 		offset_max = 1;
 	do {
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 6fc2e06ab4c6..86467f85c383 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -502,10 +502,8 @@ void uncore_pmu_event_start(struct perf_event *event, int flags)
 	local64_set(&event->hw.prev_count, uncore_read_counter(box, event));
 	uncore_enable_event(box, event);
 
-	if (box->n_active == 1) {
-		uncore_enable_box(box);
+	if (box->n_active == 1)
 		uncore_pmu_start_hrtimer(box);
-	}
 }
 
 void uncore_pmu_event_stop(struct perf_event *event, int flags)
@@ -529,10 +527,8 @@ void uncore_pmu_event_stop(struct perf_event *event, int flags)
 		WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
 		hwc->state |= PERF_HES_STOPPED;
 
-		if (box->n_active == 0) {
-			uncore_disable_box(box);
+		if (box->n_active == 0)
 			uncore_pmu_cancel_hrtimer(box);
-		}
 	}
 
 	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
@@ -778,6 +774,40 @@ static int uncore_pmu_event_init(struct perf_event *event)
 	return ret;
 }
 
+static void uncore_pmu_enable(struct pmu *pmu)
+{
+	struct intel_uncore_pmu *uncore_pmu;
+	struct intel_uncore_box *box;
+
+	uncore_pmu = container_of(pmu, struct intel_uncore_pmu, pmu);
+	if (!uncore_pmu)
+		return;
+
+	box = uncore_pmu_to_box(uncore_pmu, smp_processor_id());
+	if (!box)
+		return;
+
+	if (uncore_pmu->type->ops->enable_box)
+		uncore_pmu->type->ops->enable_box(box);
+}
+
+static void uncore_pmu_disable(struct pmu *pmu)
+{
+	struct intel_uncore_pmu *uncore_pmu;
+	struct intel_uncore_box *box;
+
+	uncore_pmu = container_of(pmu, struct intel_uncore_pmu, pmu);
+	if (!uncore_pmu)
+		return;
+
+	box = uncore_pmu_to_box(uncore_pmu, smp_processor_id());
+	if (!box)
+		return;
+
+	if (uncore_pmu->type->ops->disable_box)
+		uncore_pmu->type->ops->disable_box(box);
+}
+
 static ssize_t uncore_get_attr_cpumask(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -803,6 +833,8 @@ static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
 		pmu->pmu = (struct pmu) {
 			.attr_groups	= pmu->type->attr_groups,
 			.task_ctx_nr	= perf_invalid_context,
+			.pmu_enable	= uncore_pmu_enable,
+			.pmu_disable	= uncore_pmu_disable,
 			.event_init	= uncore_pmu_event_init,
 			.add		= uncore_pmu_event_add,
 			.del		= uncore_pmu_event_del,
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index f36f7bebbc1b..bbfdaa720b45 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -441,18 +441,6 @@ static inline int uncore_freerunning_hw_config(struct intel_uncore_box *box,
 	return -EINVAL;
 }
 
-static inline void uncore_disable_box(struct intel_uncore_box *box)
-{
-	if (box->pmu->type->ops->disable_box)
-		box->pmu->type->ops->disable_box(box);
-}
-
-static inline void uncore_enable_box(struct intel_uncore_box *box)
-{
-	if (box->pmu->type->ops->enable_box)
-		box->pmu->type->ops->enable_box(box);
-}
-
 static inline void uncore_disable_event(struct intel_uncore_box *box,
 				struct perf_event *event)
 {
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 61448c19a132..68ccc5b1913b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -292,7 +292,7 @@ struct pmu {
 	 *  -EBUSY	-- @event is for this PMU but PMU temporarily unavailable
 	 *  -EINVAL	-- @event is for this PMU but @event is not valid
 	 *  -EOPNOTSUPP -- @event is for this PMU, @event is valid, but not supported
-	 *  -EACCESS	-- @event is for this PMU, @event is valid, but no privilidges
+	 *  -EACCES	-- @event is for this PMU, @event is valid, but no privileges
 	 *
 	 *  0		-- @event is for this PMU and valid
 	 *
diff --git a/kernel/events/core.c b/kernel/events/core.c
index bb3748d29b04..aec8dba2bea4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10635,7 +10635,7 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 
 	attr->size = size;
 
-	if (attr->__reserved_1)
+	if (attr->__reserved_1 || attr->__reserved_2)
 		return -EINVAL;
 
 	if (attr->sample_type & ~(PERF_SAMPLE_MAX-1))
