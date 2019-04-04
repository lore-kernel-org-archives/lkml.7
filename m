Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A67C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 23:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121892183E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 23:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1wO4i7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbfDDXZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 19:25:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36413 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730086AbfDDXZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 19:25:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85so2003708pgc.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 16:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CCdrf7jqoTvyTGvaGfuBCcpBw0EjRGKPGe2OH2TTLn0=;
        b=h1wO4i7PN3LELMMX5rjV+GmDZpzR9tJy5sbngb2hxjz4tu0vnwbT8kfy4/0it+Wt4E
         6vU1IbrFkTKjp5EgR5TzqOv57ZPE2vLwwUn/UFlP2dENoEwQxOt8IJtqLV/WNxTqnjYa
         B7XsYEZSsVUz2zV78MpLbcWGrKjZe5sDrbAyoxCPZTknPoKmRUseyyiOeB8NukUPYjFX
         z8TpZ5gJ8HbtgS9TJB7qURgzifOB0Zdbf60VgNyHEpPG6bTmweitu9SL32KCfYinKORA
         DYYJ+cvq8870QymHhsZkp8xxSw7rI5QuhuNlCPpoDu19DcMCK+fSKOoyoFUNbRRavd/T
         R5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CCdrf7jqoTvyTGvaGfuBCcpBw0EjRGKPGe2OH2TTLn0=;
        b=DYA0pRltNk19Y6SmqlqEXVFUXWn/C5o3VFtnqQutelrBwQHWjubzXxpq3f0v2u3xcH
         JmKZG4o0VYmOkBeLdU7nDwzx6DhCZ+WxaatUEs85Ps8aDQR0CiXS5+rnI9B2BRPcx4Zq
         3fSg/aENh08RQPodoc3cxkb0mbdAfO1FjfHRadYnWFX45rcMptf4PPxCATVamNPXemZq
         yoyg+WBJ46aUytXj4epeF1ShMsdRjRVtcRdqYwZoaa/5c4k69PsfYu9wDtUfwRVyQGwx
         ho/laSVyoh03J4wS5/8ktIRYsRoi80O1Gcgdswh0kS16tHal/ZhYs7m6lYu49DdcvMh6
         yc0w==
X-Gm-Message-State: APjAAAUxqOI1x92tsvUipMoqpNC5S8IvyvOBW7XETIn9BVPIKiicIFTH
        ngQY3HFQoHjpouDfQ3OdKOA=
X-Google-Smtp-Source: APXvYqx9GAVFVMVGcqf8d5iEofm3FXVFigHJk3zlOgJ974RmJajEDqs00fe1U7FAUiVTe472tqYauQ==
X-Received: by 2002:aa7:8284:: with SMTP id s4mr8960338pfm.235.1554420352526;
        Thu, 04 Apr 2019 16:25:52 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id e23sm28750036pfd.11.2019.04.04.16.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 16:25:51 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH 2/2] arm64: perf: Expose Cortex-A53 micro architectural events
Date:   Thu,  4 Apr 2019 16:25:45 -0700
Message-Id: <20190404232545.2627-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404232545.2627-1-f.fainelli@gmail.com>
References: <20190404232545.2627-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a variety of useful Cortex-A53 PMU specific events which were
recently found useful during a debug session.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/kernel/perf_event.c | 118 ++++++++++++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 2d30922692b1..ef4105908830 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -31,7 +31,23 @@
 #include <linux/platform_device.h>
 
 /* ARMv8 Cortex-A53 specific event types. */
+#define ARMV8_A53_PERFCTR_EXT_MEM_REQ				0xC0
+#define ARMV8_A53_PERFCTR_NC_EXT_MEM_REQ			0xC1
 #define ARMV8_A53_PERFCTR_PREF_LINEFILL				0xC2
+#define ARMV8_A53_PERFCTR_I_CACHE_THROTTLE			0xC3
+#define ARMV8_A53_PERFCTR_ENT_READ_ALLOC			0xC4
+#define ARMV8_A53_PERFCTR_READ_ALLOC_MODE			0xC5
+#define ARMV8_A53_PERFCTR_PRE_DECODE_ERROR			0xC6
+#define ARMV8_A53_PERFCTR_DATA_WR_STALL				0xC7
+#define ARMV8_A53_PERFCTR_SCU_SNOOP_OTHER_CPU			0xC8
+#define ARMV8_A53_PERFCTR_COND_BRANCH_EXEC			0xC9
+#define ARMV8_A53_PERFCTR_INDIR_BRANCH_MISPRED			0xCA
+#define ARMV8_A53_PERFCTR_INDIR_BRANCH_MISPRED_COMP		0xCB
+#define ARMV8_A53_PERFCTR_COND_BRANCH_MISPRED			0xCC
+#define ARMV8_A53_PERFCTR_L1I_CACHE_MEM_ERR			0xD0
+#define ARMV8_A53_PERFCTR_L1D_CACHE_MEM_ERR			0xD1
+#define ARMV8_A53_PERFCTR_TLB_MEM_ERR				0xD2
+#define ARMV8_A53_PERFCTR_MAX_EVENTS				0xD3
 
 /* ARMv8 Cavium ThunderX specific event types. */
 #define ARMV8_THUNDER_PERFCTR_L1D_CACHE_MISS_ST			0xE9
@@ -349,6 +365,82 @@ static struct attribute_group armv8_pmuv3_format_attr_group = {
 	.attrs = armv8_pmuv3_format_attrs,
 };
 
+#define ARMV8_CORTEXA53_EVENT_ATTR_RESOLVE(m) #m
+#define ARMV8_CORTEXA53_EVENT_ATTR(name, config) \
+	PMU_EVENT_ATTR(name, armv8_cortex_a53_event_attr_##name, \
+		       config, armv8pmu_events_sysfs_show)
+
+ARMV8_CORTEXA53_EVENT_ATTR(ext_mem_req, ARMV8_A53_PERFCTR_EXT_MEM_REQ);
+ARMV8_CORTEXA53_EVENT_ATTR(nc_ext_mem_req, ARMV8_A53_PERFCTR_NC_EXT_MEM_REQ);
+ARMV8_CORTEXA53_EVENT_ATTR(pref_linefill, ARMV8_A53_PERFCTR_PREF_LINEFILL);
+ARMV8_CORTEXA53_EVENT_ATTR(i_cache_throttle, ARMV8_A53_PERFCTR_I_CACHE_THROTTLE);
+ARMV8_CORTEXA53_EVENT_ATTR(enter_read_allocate, ARMV8_A53_PERFCTR_ENT_READ_ALLOC);
+ARMV8_CORTEXA53_EVENT_ATTR(read_allocate_mode, ARMV8_A53_PERFCTR_READ_ALLOC_MODE);
+ARMV8_CORTEXA53_EVENT_ATTR(pre_decode_error, ARMV8_A53_PERFCTR_PRE_DECODE_ERROR);
+ARMV8_CORTEXA53_EVENT_ATTR(data_write_stall, ARMV8_A53_PERFCTR_DATA_WR_STALL);
+ARMV8_CORTEXA53_EVENT_ATTR(scu_snoop_other_cpu, ARMV8_A53_PERFCTR_SCU_SNOOP_OTHER_CPU);
+ARMV8_CORTEXA53_EVENT_ATTR(cond_branch_exec, ARMV8_A53_PERFCTR_COND_BRANCH_EXEC);
+ARMV8_CORTEXA53_EVENT_ATTR(indir_br_pred, ARMV8_A53_PERFCTR_INDIR_BRANCH_MISPRED);
+ARMV8_CORTEXA53_EVENT_ATTR(indir_br_pred_comp, ARMV8_A53_PERFCTR_INDIR_BRANCH_MISPRED_COMP);
+ARMV8_CORTEXA53_EVENT_ATTR(cond_br_mis_pred, ARMV8_A53_PERFCTR_COND_BRANCH_MISPRED);
+ARMV8_CORTEXA53_EVENT_ATTR(l1i_cache_mem_err, ARMV8_A53_PERFCTR_L1I_CACHE_MEM_ERR);
+ARMV8_CORTEXA53_EVENT_ATTR(l1d_cache_mem_err, ARMV8_A53_PERFCTR_L1D_CACHE_MEM_ERR);
+ARMV8_CORTEXA53_EVENT_ATTR(tlb_mem_err, ARMV8_A53_PERFCTR_TLB_MEM_ERR);
+
+static struct attribute *armv8_cortex_a53_event_attrs[] = {
+	ARMV8_PMUV3_EVENT_ATTRS
+	&armv8_cortex_a53_event_attr_ext_mem_req.attr.attr,
+	&armv8_cortex_a53_event_attr_nc_ext_mem_req.attr.attr,
+	&armv8_cortex_a53_event_attr_pref_linefill.attr.attr,
+	&armv8_cortex_a53_event_attr_i_cache_throttle.attr.attr,
+	&armv8_cortex_a53_event_attr_enter_read_allocate.attr.attr,
+	&armv8_cortex_a53_event_attr_read_allocate_mode.attr.attr,
+	&armv8_cortex_a53_event_attr_pre_decode_error.attr.attr,
+	&armv8_cortex_a53_event_attr_data_write_stall.attr.attr,
+	&armv8_cortex_a53_event_attr_scu_snoop_other_cpu.attr.attr,
+	&armv8_cortex_a53_event_attr_cond_branch_exec.attr.attr,
+	&armv8_cortex_a53_event_attr_indir_br_pred.attr.attr,
+	&armv8_cortex_a53_event_attr_indir_br_pred_comp.attr.attr,
+	&armv8_cortex_a53_event_attr_cond_br_mis_pred.attr.attr,
+	&armv8_cortex_a53_event_attr_l1i_cache_mem_err.attr.attr,
+	&armv8_cortex_a53_event_attr_l1d_cache_mem_err.attr.attr,
+	&armv8_cortex_a53_event_attr_tlb_mem_err.attr.attr,
+	NULL
+};
+
+static umode_t
+armv8_cortex_a53_pmu_event_attr_is_visible(struct kobject *kobj,
+					   struct attribute *attr, int unused)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct arm_pmu *cpu_pmu = container_of(pmu, struct arm_pmu, pmu);
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr.attr);
+
+	if (pmu_attr->id < ARMV8_PMUV3_MAX_COMMON_EVENTS &&
+	    test_bit(pmu_attr->id, cpu_pmu->pmceid_bitmap))
+		return attr->mode;
+
+	if (pmu_attr->id >= ARMV8_A53_PERFCTR_EXT_MEM_REQ &&
+	    pmu_attr->id < ARMV8_A53_PERFCTR_MAX_EVENTS)
+		return attr->mode;
+
+	pmu_attr->id -= ARMV8_PMUV3_EXT_COMMON_EVENT_BASE;
+	if (pmu_attr->id < ARMV8_PMUV3_MAX_COMMON_EVENTS &&
+	    test_bit(pmu_attr->id, cpu_pmu->pmceid_ext_bitmap))
+		return attr->mode;
+
+	return 0;
+}
+
+static struct attribute_group armv8_cortex_a53_events_attr_group = {
+	.name = "events",
+	.attrs = armv8_cortex_a53_event_attrs,
+	.is_visible = armv8_cortex_a53_pmu_event_attr_is_visible,
+};
+
 /*
  * Perf Events' indices
  */
@@ -910,7 +1002,29 @@ static int armv8_pmuv3_map_event(struct perf_event *event)
 
 static int armv8_a53_map_event(struct perf_event *event)
 {
-	return __armv8_pmuv3_map_event(event, NULL, &armv8_a53_perf_cache_map);
+	int hw_event_id;
+	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
+
+	hw_event_id = armpmu_map_event(event, &armv8_pmuv3_perf_map,
+				       &armv8_pmuv3_perf_cache_map,
+				       ARMV8_PMU_EVTYPE_EVENT);
+
+	if (armv8pmu_event_is_64bit(event))
+		event->hw.flags |= ARMPMU_EVT_64BIT;
+
+	/* Only expose micro/arch events supported by this PMU */
+	if ((hw_event_id > 0) && (hw_event_id < ARMV8_PMUV3_MAX_COMMON_EVENTS)
+	    && test_bit(hw_event_id, armpmu->pmceid_bitmap)) {
+		return hw_event_id;
+	}
+
+	/* Expose Cortex-A53 specific events */
+	if (hw_event_id >= ARMV8_A53_PERFCTR_EXT_MEM_REQ &&
+	    hw_event_id <= ARMV8_A53_PERFCTR_MAX_EVENTS)
+		return hw_event_id;
+
+	return armpmu_map_event(event, NULL, &armv8_a53_perf_cache_map,
+				ARMV8_PMU_EVTYPE_EVENT);
 }
 
 static int armv8_a57_map_event(struct perf_event *event)
@@ -1057,7 +1171,7 @@ static int armv8_a53_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name			= "armv8_cortex_a53";
 	cpu_pmu->map_event		= armv8_a53_map_event;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =
-		&armv8_pmuv3_events_attr_group;
+		&armv8_cortex_a53_events_attr_group;
 	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
 		&armv8_pmuv3_format_attr_group;
 
-- 
2.17.1

