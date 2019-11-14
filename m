Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E2FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2AB206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q7tw9hOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKNShy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:37:54 -0500
Received: from mail-eopbgr820080.outbound.protection.outlook.com ([40.107.82.80]:33556
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726549AbfKNShy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:37:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEqf1o4D6i1ljWAakz6HDcTOznuQFTGtZsicMRjHAka89uNtRc3gd39SJOPJpSO7/9fhBFVW06BfzWBgnpZBSnvaMsS906rZFFaHmlwP/wyra3ikYg4mbKnavq3kMubEePyENdMZo9Dqojr7zdMPpnQxeyjXoDKwPjATe8XmcIt6AGz1aRQHvWfs/RF3cEriOJ3knLGI5gPPFZCf5UMTvO9kVNtFT8+9TW/6YYb2lF1RczO2xLbCSGPxJI7fjedeAyiyRifHho03dzbGQGs3A9z5kt9WTRnvPxG8ONBozIPJ+wbM1/jQ3uSNUOaUziHBGV4mZhY337HwgtiA2ANvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8j2A/9Rak3twr3uiR/Yxe3Gfq6sDclfyLAbx7jPddY=;
 b=CNvUGMANnrUUbIumbwEGqzGjemKtrpyqhhz1/kKvYEcAJa2ta/6q8fDlFcYHwN7X4SFCNPrHKWZxpQ1PaHsw7yAD/EqU1CA6WZR+GZpN8pq6xuhqGXi+BOsg82QrKDHAOHDZqWv/DydJV5F4DYwUP8UiQLu4OhOrUqwqytm9pRu2a/B0PG+h3vBAgJ6W8Cl3cGWJC9jF3yLkagjYxOmTj37H8Y5IfbTZzb3D/D4bXT+xct1MlB8cvkFCr1OZDIZmvoK0MXc3wV/ozqKETmGYyULN/4R+cmJFlEnBBEvK1XXfah6F5qtH5DxHZvB7x8q2EMYNPsTlgLei6/3jWf3dQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8j2A/9Rak3twr3uiR/Yxe3Gfq6sDclfyLAbx7jPddY=;
 b=Q7tw9hOsxy2tedfxEKgGQqjl/lKJ2W1g6paK7wqgwzeeg936wsbeoJ0Y8mq86QFu9x164JvMzp930YuEDwWYiq60xmtbDjs+3MKehBdRLD5VbUcVLhNgvcKjl4vRPMHx2x0G//EXZpUiDf0agPztXa0ySiPaZ6yu+iWim+gg2mI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (52.135.102.141) by
 SN6PR12MB2752.namprd12.prod.outlook.com (52.135.107.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Thu, 14 Nov 2019 18:37:50 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::7175:51ac:283b:b306]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::7175:51ac:283b:b306%4]) with mapi id 15.20.2430.028; Thu, 14 Nov 2019
 18:37:50 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Kim Phillips <kim.phillips@amd.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stephane Eranian <eranian@google.com>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH 2/2] perf/x86/amd: Add support for Large Increment per Cycle Events
Date:   Thu, 14 Nov 2019 12:37:20 -0600
Message-Id: <20191114183720.19887-3-kim.phillips@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191114183720.19887-1-kim.phillips@amd.com>
References: <20191114183720.19887-1-kim.phillips@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0601CA0013.namprd06.prod.outlook.com
 (2603:10b6:803:2f::23) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:6e::13)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 728c16d4-4ef2-425c-8000-08d76931c0af
X-MS-TrafficTypeDiagnostic: SN6PR12MB2752:
X-MS-Exchange-PUrlCount: 1
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2752D38773B68008E49C808187710@SN6PR12MB2752.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02213C82F8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(366004)(39850400004)(376002)(199004)(189003)(561924002)(2616005)(66946007)(2870700001)(36756003)(25786009)(2906002)(26005)(6512007)(6306002)(446003)(52116002)(44832011)(386003)(8676002)(6506007)(486006)(476003)(7416002)(76176011)(186003)(6666004)(11346002)(7736002)(23676004)(86362001)(50226002)(14444005)(81156014)(81166006)(6436002)(305945005)(6486002)(66066001)(66574012)(478600001)(47776003)(110136005)(54906003)(316002)(14454004)(5660300002)(966005)(99286004)(4326008)(1076003)(66556008)(66476007)(6116002)(30864003)(8936002)(50466002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2752;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dv8rc+udW9CtkRxjoGJNYdDTF69+6rz6WLw/Qlu2ZoubIgJqWO8AG82SW+U9aJueYRhTFhoKxK9Uk8Qhx6hdd0En0lUWFmMdl0sJNwG9sfCD7/zARK/BDlwtXUoHQzn3LW1tE+pKgQFOK06Ekker9dG/SOUGhWiXtvfAZcAtxZgDA6OURqFIVRbSqiaoIzfQmBU0d7/ECFljTsLnVYlr2NT3kPYk8K9zi3zhdS/dpFRn7LE9OqDkFicimUWgTtKi8DQuzyfQvIslHvQctRedyjMBNlmeO8MXKpOmZjRmP5YWDurMOoqwAY/7pvepVaXAeTfOcKozTNR7gihy02ie6j6HXADhTjptLg8LFnB65Ghr8F8XCk4Ku3N1JSBxsdJF1mloR0CMNl+UTu7ZztJsLMpVteEAXBKZLcKzrajcEtNhIRMdJ4O8R6H8mwn2iY4XSIkOlphPnNbvPQzth9huYF509DZSTcCAetVUhy/4Gsk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728c16d4-4ef2-425c-8000-08d76931c0af
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2019 18:37:50.4654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z31Kw7eOvi+Ni/J2cRp12cVtOlK3srfi5MlJeQ5Mq8DRE4w4gcpLajYPS1Cif9leYRi7FqMjg90+2svUTWuhgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2752
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Description of hardware operation
---------------------------------

The core AMD PMU has a 4-bit wide per-cycle increment for each
performance monitor counter.  That works for most events, but
now with AMD Family 17h and above processors, some events can
occur more than 15 times in a cycle.  Those events are called
"Large Increment per Cycle" events. In order to count these
events, two adjacent h/w PMCs get their count signals merged
to form 8 bits per cycle total.  In addition, the PERF_CTR count
registers are merged to be able to count up to 64 bits.

Normally, events like instructions retired, get programmed on a single
counter like so:

PERF_CTL0 (MSR 0xc0010200) 0x000000000053ff0c # event 0x0c, umask 0xff
PERF_CTR0 (MSR 0xc0010201) 0x0000800000000001 # r/w 48-bit count

The next counter at MSRs 0xc0010202-3 remains unused, or can be used
independently to count something else.

When counting Large Increment per Cycle events, such as FLOPs,
however, we now have to reserve the next counter and program the
PERF_CTL (config) register with the Merge event (0xFFF), like so:

PERF_CTL0 (msr 0xc0010200) 0x000000000053ff03 # FLOPs event, umask 0xff
PERF_CTR0 (msr 0xc0010201) 0x0000800000000001 # rd 64-bit cnt, wr lo 48b
PERF_CTL1 (msr 0xc0010202) 0x0000000f004000ff # Merge event, enable bit
PERF_CTR1 (msr 0xc0010203) 0x0000000000000000 # wr hi 16-bits count

The count is widened from the normal 48-bits to 64 bits by having the
second counter carry the higher 16 bits of the count in its lower 16
bits of its counter register.

The odd counter, e.g., PERF_CTL1, is programmed with the enabled Merge
event before the even counter, PERF_CTL0.

The Large Increment feature is available starting with Family 17h.
For more details, search any Family 17h PPR for the "Large Increment
per Cycle Events" section, e.g., section 2.1.15.3 on p. 173 in this
version:

https://www.amd.com/system/files/TechDocs/56176_ppr_Family_17h_Model_71h_B0_pub_Rev_3.06.zip

Description of software operation
---------------------------------

The following steps are taken in order to support reserving and
enabling the extra counter for Large Increment per Cycle events:

1. In the main x86 scheduler, we reduce the number of available
counters by the number of Large Increment per Cycle events being
scheduled, tracked by a new cpuc variable 'n_lg_inc' and a new
amd_put_event_constraints_f17h().  This improves the counter
scheduler success rate.

2. In perf_assign_events(), if a counter is assigned to a Large
Increment event, we increment the current counter variable, so the
counter used for the Merge event is removed from assignment
consideration by upcoming event assignments.

3. In find_counter(), if a counter has been found for the Large
Increment event, we set the next counter as used, to prevent other
events from using it.

4. We perform steps 2 & 3 also in the x86 scheduler fastpath, i.e.,
we add Merge event accounting to the existing used_mask logic.

5. Finally, we add on the programming of Merge event to the
neighbouring PMC counters in the counter enable/disable{_all}
code paths.

Currently, software does not support a single PMU with mixed 48- and
64-bit counting, so Large increment event counts are limited to 48
bits.  In set_period, we zero-out the upper 16 bits of the count, so
the hardware doesn't copy them to the even counter's higher bits.

Simple invocation example showing counting 8 FLOPs per 256-bit/%ymm
vaddps instruction executed in a loop 100 million times:

perf stat -e cpu/fp_ret_sse_avx_ops.all/,cpu/instructions/ <workload>

 Performance counter stats for '<workload>':

       800,000,000      cpu/fp_ret_sse_avx_ops.all/u
       300,042,101      cpu/instructions/u

Prior to this patch, the reported SSE/AVX FLOPs retired count would
be wrong.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Martin Liška <mliska@suse.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/events/amd/core.c   | 19 +++++++++++++++
 arch/x86/events/core.c       | 46 ++++++++++++++++++++++++++++++++++--
 arch/x86/events/perf_event.h | 19 +++++++++++++++
 3 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 78f771cadb8e..e69723cb5b51 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -14,6 +14,10 @@
 static DEFINE_PER_CPU(unsigned long, perf_nmi_tstamp);
 static unsigned long perf_nmi_window;
 
+/* AMD Event 0xFFF: Merge.  Used with Large Increment per Cycle events */
+#define AMD_MERGE_EVENT ((0xFULL << 32) | 0xFFULL)
+#define AMD_MERGE_EVENT_ENABLE (AMD_MERGE_EVENT | ARCH_PERFMON_EVENTSEL_ENABLE)
+
 static __initconst const u64 amd_hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -335,6 +339,10 @@ static int amd_core_hw_config(struct perf_event *event)
 	else if (event->attr.exclude_guest)
 		event->hw.config |= AMD64_EVENTSEL_HOSTONLY;
 
+	if ((x86_pmu.flags & PMU_FL_MERGE) &&
+	    amd_is_lg_inc_event_code(&event->hw))
+		event->hw.flags |= PERF_X86_EVENT_LARGE_INC;
+
 	return 0;
 }
 
@@ -889,6 +897,15 @@ amd_get_event_constraints_f17h(struct cpu_hw_events *cpuc, int idx,
 	return &unconstrained;
 }
 
+static void amd_put_event_constraints_f17h(struct cpu_hw_events *cpuc,
+					   struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (is_large_inc(hwc))
+		--cpuc->n_lg_inc;
+}
+
 static ssize_t amd_event_sysfs_show(char *page, u64 config)
 {
 	u64 event = (config & ARCH_PERFMON_EVENTSEL_EVENT) |
@@ -919,6 +936,7 @@ static __initconst const struct x86_pmu amd_pmu = {
 	.max_period		= (1ULL << 47) - 1,
 	.get_event_constraints	= amd_get_event_constraints,
 	.put_event_constraints	= amd_put_event_constraints,
+	.perf_ctr_merge_en	= AMD_MERGE_EVENT_ENABLE,
 
 	.format_attrs		= amd_format_attr,
 	.events_sysfs_show	= amd_event_sysfs_show,
@@ -976,6 +994,7 @@ static int __init amd_core_pmu_init(void)
 				    PERF_X86_EVENT_LARGE_INC);
 
 		x86_pmu.get_event_constraints = amd_get_event_constraints_f17h;
+		x86_pmu.put_event_constraints = amd_put_event_constraints_f17h;
 		x86_pmu.flags |= PMU_FL_MERGE;
 	}
 
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7b21455d7504..51c4c69a9d76 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -612,6 +612,7 @@ void x86_pmu_disable_all(void)
 	int idx;
 
 	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
+		struct hw_perf_event *hwc = &cpuc->events[idx]->hw;
 		u64 val;
 
 		if (!test_bit(idx, cpuc->active_mask))
@@ -621,6 +622,8 @@ void x86_pmu_disable_all(void)
 			continue;
 		val &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
 		wrmsrl(x86_pmu_config_addr(idx), val);
+		if (is_large_inc(hwc))
+			wrmsrl(x86_pmu_config_addr(idx + 1), 0);
 	}
 }
 
@@ -787,6 +790,16 @@ static bool __perf_sched_find_counter(struct perf_sched *sched)
 		if (!__test_and_set_bit(idx, sched->state.used)) {
 			if (sched->state.nr_gp++ >= sched->max_gp)
 				return false;
+			/*
+			 * Large inc. events need the Merge event
+			 * on the next counter
+			 */
+			if ((c->flags & PERF_X86_EVENT_LARGE_INC) &&
+			    __test_and_set_bit(idx + 1, sched->state.used)) {
+				/* next counter already used */
+				__clear_bit(idx, sched->state.used);
+				return false;
+			}
 
 			goto done;
 		}
@@ -849,14 +862,19 @@ int perf_assign_events(struct event_constraint **constraints, int n,
 			int wmin, int wmax, int gpmax, int *assign)
 {
 	struct perf_sched sched;
+	struct event_constraint *c;
 
 	perf_sched_init(&sched, constraints, n, wmin, wmax, gpmax);
 
 	do {
 		if (!perf_sched_find_counter(&sched))
 			break;	/* failed */
-		if (assign)
+		if (assign) {
 			assign[sched.state.event] = sched.state.counter;
+			c = constraints[sched.state.event];
+			if (c->flags & PERF_X86_EVENT_LARGE_INC)
+				sched.state.counter++;
+		}
 	} while (perf_sched_next_event(&sched));
 
 	return sched.state.unassigned;
@@ -926,10 +944,14 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 			break;
 
 		/* not already used */
-		if (test_bit(hwc->idx, used_mask))
+		if (test_bit(hwc->idx, used_mask) || (is_large_inc(hwc) &&
+		    test_bit(hwc->idx + 1, used_mask)))
 			break;
 
 		__set_bit(hwc->idx, used_mask);
+		if (is_large_inc(hwc))
+			__set_bit(hwc->idx + 1, used_mask);
+
 		if (assign)
 			assign[i] = hwc->idx;
 	}
@@ -952,6 +974,15 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 		    READ_ONCE(cpuc->excl_cntrs->exclusive_present))
 			gpmax /= 2;
 
+		/*
+		 * Reduce the amount of available counters to allow fitting
+		 * the extra Merge events needed by large increment events.
+		 */
+		if (x86_pmu.flags & PMU_FL_MERGE) {
+			gpmax = x86_pmu.num_counters - cpuc->n_lg_inc;
+			WARN_ON(gpmax <= 0);
+		}
+
 		unsched = perf_assign_events(cpuc->event_constraint, n, wmin,
 					     wmax, gpmax, assign);
 	}
@@ -1032,6 +1063,8 @@ static int collect_events(struct cpu_hw_events *cpuc, struct perf_event *leader,
 			return -EINVAL;
 		cpuc->event_list[n] = leader;
 		n++;
+		if (is_large_inc(&leader->hw))
+			cpuc->n_lg_inc++;
 	}
 	if (!dogrp)
 		return n;
@@ -1046,6 +1079,8 @@ static int collect_events(struct cpu_hw_events *cpuc, struct perf_event *leader,
 
 		cpuc->event_list[n] = event;
 		n++;
+		if (is_large_inc(&event->hw))
+			cpuc->n_lg_inc++;
 	}
 	return n;
 }
@@ -1231,6 +1266,13 @@ int x86_perf_event_set_period(struct perf_event *event)
 
 	wrmsrl(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
 
+	/*
+	 * Clear the Merge event counter's upper 16 bits since
+	 * we currently declare a 48-bit counter width
+	 */
+	if (is_large_inc(hwc))
+		wrmsrl(x86_pmu_event_addr(idx + 1), 0);
+
 	/*
 	 * Due to erratum on certan cpu we need
 	 * a second write to be sure the register
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 6154f06eb4ba..6db6e4c69e3d 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -273,6 +273,7 @@ struct cpu_hw_events {
 	struct amd_nb			*amd_nb;
 	/* Inverted mask of bits to clear in the perf_ctr ctrl registers */
 	u64				perf_ctr_virt_mask;
+	int				n_lg_inc; /* Large increment events */
 
 	void				*kfree_on_online[X86_PERF_KFREE_MAX];
 };
@@ -687,6 +688,8 @@ struct x86_pmu {
 	 * AMD bits
 	 */
 	unsigned int	amd_nb_constraints : 1;
+	/* Merge event enable: value to set in perf_ctl next to large inc. */
+	u64		perf_ctr_merge_en;
 
 	/*
 	 * Extra registers for events
@@ -832,6 +835,11 @@ int x86_pmu_hw_config(struct perf_event *event);
 
 void x86_pmu_disable_all(void);
 
+static inline int is_large_inc(struct hw_perf_event *hwc)
+{
+	return !!(hwc->flags & PERF_X86_EVENT_LARGE_INC);
+}
+
 static inline void __x86_pmu_enable_event(struct hw_perf_event *hwc,
 					  u64 enable_mask)
 {
@@ -839,6 +847,14 @@ static inline void __x86_pmu_enable_event(struct hw_perf_event *hwc,
 
 	if (hwc->extra_reg.reg)
 		wrmsrl(hwc->extra_reg.reg, hwc->extra_reg.config);
+
+	/*
+	 * Add enabled Merge event on next counter
+	 * if large increment event being enabled on this counter
+	 */
+	if (is_large_inc(hwc))
+		wrmsrl(hwc->config_base + 2, x86_pmu.perf_ctr_merge_en);
+
 	wrmsrl(hwc->config_base, (hwc->config | enable_mask) & ~disable_mask);
 }
 
@@ -855,6 +871,9 @@ static inline void x86_pmu_disable_event(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 
 	wrmsrl(hwc->config_base, hwc->config);
+
+	if (is_large_inc(hwc))
+		wrmsrl(hwc->config_base + 2, 0);
 }
 
 void x86_pmu_enable_event(struct perf_event *event);
-- 
2.24.0

