Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB37C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEAC206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k7t7fJfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387951AbfHZT7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 15:59:36 -0400
Received: from mail-eopbgr720081.outbound.protection.outlook.com ([40.107.72.81]:13904
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732459AbfHZT7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 15:59:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcCbsAdoQyqToDYhMIXJ1Zi9htUl6juxGqUOWQyE/0FYHTWXp9Q975rBxd5MOl/WuRQTafifVNOEE7xG4OUq7jBrYjhzCOTDEJW5tG6rzOxDlzBXie729XVGtutdoGmoDdNg8kATSjmlffMv09AuC00EqFds3WYYfeO43GQjzbFZRv+ShlvFwXvB6xkZoWMFKpRbg+EkHjKImRg47bv2md0VsYEND7sp26oGjBeCo1YIxe0iEoWR7ezrTDi522n2Ku+BqEbCFWWS1WG0n/daYt/vXjZyqz5iNwylpiGknE4SYzWXxn3uD5S52CZNH1oUc54JSryVP1xNGc/SCx0Ang==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMIsIUox2Difz/nr6UNv/kxkAEaj1h13EumwMSaFsZQ=;
 b=ZONU+pCRP1Hv6zjdVkpYdygH7U4jDLqzMvYgawBPx3OmKYDYU7iOZPReA/XRJ+bYNNuut17dZYkjS9Yz7d1/62qqKACdpUMgSOqn96nS5+6oLQu8yNJf1+AIP2sZK5u/nhxHirJDdt9//Y0grUUtDiAfoSdPrulyHm539BLJ0l4m7H9Yj2cBCSaJCa/twdlKaRs/xVz3xq+x7SkfbtT0KJjA8znSLE3/iTVuGyOq8YO7yaJuXrnxsYF8MPiEJrgV98tt8Y4St8raI9rWA8ctT/2t4/dwoMvLzJt85Ljmxppu/v7mXsmHJ9rx0rlGzwCaoFBb7ZIWv4kUXqx43R6RaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMIsIUox2Difz/nr6UNv/kxkAEaj1h13EumwMSaFsZQ=;
 b=k7t7fJfZbZCGCSf8jnHpxivlSZiY2vc+fHaab7mu11L7v3pj2DFe27kdIcTutG2aqtcAee3tXM58VxhGM2MvxhLYQEfCuOfP/OGJb8TxejeASJxcT5coLqfiWBy9ZT7zNzxPDtX2twIf8EqlVGotFxMuM6l768gCAH99miAycBw=
Received: from MWHPR1201CA0012.namprd12.prod.outlook.com
 (2603:10b6:301:4a::22) by CY4PR12MB1525.namprd12.prod.outlook.com
 (2603:10b6:910:11::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.21; Mon, 26 Aug
 2019 19:59:27 +0000
Received: from CO1NAM03FT022.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::205) by MWHPR1201CA0012.outlook.office365.com
 (2603:10b6:301:4a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2199.14 via Frontend
 Transport; Mon, 26 Aug 2019 19:59:27 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 CO1NAM03FT022.mail.protection.outlook.com (10.152.80.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2178.16 via Frontend Transport; Mon, 26 Aug 2019 19:59:26 +0000
Received: from totem.amd.com (10.180.168.240) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server (TLS) id 14.3.389.1; Mon, 26 Aug
 2019 14:59:25 -0500
From:   Kim Phillips <kim.phillips@amd.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kim Phillips <kim.phillips@amd.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Martin Liska <mliska@suse.cz>,
        "Ingo Molnar" <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>
Subject: [RFC] perf/x86/amd: add support for Large Increment per Cycle Events
Date:   Mon, 26 Aug 2019 14:59:15 -0500
Message-ID: <20190826195915.30680-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.23.0.37.g745f6812895b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(396003)(2980300002)(428003)(199004)(189003)(186003)(16526019)(36756003)(8936002)(426003)(26005)(561924002)(3846002)(6116002)(86362001)(126002)(5660300002)(50226002)(476003)(81166006)(81156014)(8676002)(2616005)(53416004)(486006)(44832011)(14444005)(4326008)(6306002)(48376002)(336012)(53936002)(50466002)(966005)(478600001)(110136005)(54906003)(7416002)(2870700001)(305945005)(70586007)(70206006)(47776003)(1076003)(7696005)(51416003)(6666004)(356004)(30864003)(7736002)(316002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1525;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45304ea8-f0d9-45ab-5a88-08d72a5fe646
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CY4PR12MB1525;
X-MS-TrafficTypeDiagnostic: CY4PR12MB1525:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <CY4PR12MB152529587F15F7C0C259092C87A10@CY4PR12MB1525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 01415BB535
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: cSXBG/IkWZ7tZ9vQcuvv2rE1x3BZ86DLiT+a0aItUA+e0tP7cAmXidTIN0rgvRtXUNK5k8rFQG07GVsFKUeqSBsSDe5xw/+MzS2d8TzRTorQ5Q+Lj8Glu6kOtUWJqBMgoRpNmqblgNb83ifBbVLAINU0PQpZcY2R12bdxkpPV0hPxcZqgNrYXwHvpykln/LvpbsC9Zf5zVGFw8hdDEhsmjuKe1UUI9HDhipe4zrX4wDd6IM7V4bGgZQD+p2z8q8K9V9YiJWybjxHju4tJyjLJIv5BVSI6cG4iHbo/J0BNTMJxWhjy0nm46+KCsYnDX6LThjs34nJ2XNQr384t1sabYNJFEL/yANgU2uZpSBiEerq2+c4mmxpqjopgVScjFPimfhRkaw1OHSiFryVVCvjR9uAq7krkWqd9/AMNWM950Q=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2019 19:59:26.4700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45304ea8-f0d9-45ab-5a88-08d72a5fe646
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1525
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core AMD PMU has a 4-bit wide per-cycle increment for each
performance monitor counter.  That works for most counters, but
now with AMD Family 17h and above processors, for some, more than 15
events can occur in a cycle.  Those events are called "Large
Increment per Cycle" events, and one example is the number of
SSE/AVX FLOPs retired (event code 0x003).  In order to count these
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
PERF_CTR0 (msr 0xc0010201) 0x0000800000000001 # read 64-bit count, wr low 48b
PERF_CTL1 (msr 0xc0010202) 0x0000000f004000ff # Merge event, enable bit
PERF_CTR1 (msr 0xc0010203) 0x0000000000000000 # write higher 16-bits of count

The count is widened from the normal 48-bits to 64 bits by having the
second counter carry the higher 16 bits of the count in its lower 16
bits of its counter register.  Support for mixed 48- and 64-bit counting
is not supported in this version.

For more details, search a Family 17h PPR for the "Large Increment per
Cycle Events" section, e.g., section 2.1.15.3 on p. 173 in this version:

https://www.amd.com/system/files/TechDocs/56176_ppr_Family_17h_Model_71h_B0_pub_Rev_3.06.zip

In order to support reserving the extra counter for a single Large
Increment per Cycle event in the perf core, we:

1. Add a f17h get_event_constraints() that returns only an even counter
bitmask, since Large Increment events can only be placed on counters 0,
2, and 4 out of the currently available 0-5.

2. We add a commit_scheduler hook that adds the Merge event (0xFFF) to
any Large Increment event being scheduled.  If the event being scheduled
is not a Large Increment event, we check for, and remove any
pre-existing Large Increment events on the next counter.

3. In the main x86 scheduler, we reduce the number of available
counters by the number of Large Increment per Cycle events being added.
This improves the counter scheduler success rate.

4. In perf_assign_events(), if a counter is assigned to a Large
Increment event, we increment the current counter variable, so the
counter used for the Merge event is skipped.

5. In find_counter(), if a counter has been found for the
Large Increment event, we set the next counter as used, to
prevent other events from using it.

A side-effect of assigning a new get_constraints function for f17h
disables calling the old (prior to f15h) amd_get_event_constraints
implementation left enabled by commit e40ed1542dd7 ("perf/x86: Add perf
support for AMD family-17h processors"), which is no longer
necessary since those North Bridge events are obsolete.

Simple invocation example:

perf stat -e cpu/fp_ret_sse_avx_ops.all/,cpu/instructions/, \
	cpu/event=0x03,umask=0xff/ <workload>

 Performance counter stats for '<workload>':

       800,000,000      cpu/fp_ret_sse_avx_ops.all/u
       300,042,101      cpu/instructions/u
       800,000,000      cpu/event=0x03,umask=0xff/u

       0.041359898 seconds time elapsed

       0.041200000 seconds user
       0.000000000 seconds sys

Fixes: e40ed1542dd7 ("perf/x86: Add perf support for AMD family-17h processors")
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Martin Liska <mliska@suse.cz>
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
RFC because I'd like input on the approach, including how to add support
for mixed-width (48- and 64-bit) counting for a single PMU.  Plus there
are bugs:

 - with nmi_watchdog=0, single invocations work, but it fails to count
   correctly under when invoking two simultaneous perfs pinned to the
   same cpu

 - it fails to count correctly under certain conditions with
   nmi_watchdog=1

 arch/x86/events/amd/core.c   | 102 +++++++++++++++++++++++++++--------
 arch/x86/events/core.c       |  39 +++++++++++++-
 arch/x86/events/perf_event.h |  46 ++++++++++++++++
 3 files changed, 163 insertions(+), 24 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index e7d35f60d53f..351e72449fb8 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -12,6 +12,10 @@
 
 static DEFINE_PER_CPU(unsigned int, perf_nmi_counter);
 
+/* AMD Event 0xFFF: Merge.  For pairing with Large Increment per Cycle events */
+#define AMD_MERGE_EVENT (0xFFULL | (0xFULL << 32))
+#define AMD_MERGE_EVENT_ENABLE (AMD_MERGE_EVENT | ARCH_PERFMON_EVENTSEL_ENABLE)
+
 static __initconst const u64 amd_hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -317,19 +321,6 @@ static int amd_core_hw_config(struct perf_event *event)
 	return 0;
 }
 
-/*
- * AMD64 events are detected based on their event codes.
- */
-static inline unsigned int amd_get_event_code(struct hw_perf_event *hwc)
-{
-	return ((hwc->config >> 24) & 0x0f00) | (hwc->config & 0x00ff);
-}
-
-static inline int amd_is_nb_event(struct hw_perf_event *hwc)
-{
-	return (hwc->config & 0xe0) == 0xe0;
-}
-
 static inline int amd_has_nb(struct cpu_hw_events *cpuc)
 {
 	struct amd_nb *nb = cpuc->amd_nb;
@@ -863,6 +854,53 @@ amd_get_event_constraints_f15h(struct cpu_hw_events *cpuc, int idx,
 	}
 }
 
+static struct event_constraint lg_inc_constraint;
+
+static struct event_constraint *
+amd_get_event_constraints_f17h(struct cpu_hw_events *cpuc, int idx,
+			       struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (is_lg_inc_event(hwc))
+		return &lg_inc_constraint;
+
+	return &unconstrained;
+}
+
+/*
+ * Add the Merge event to any merged event being scheduled.
+ * Otherwise, check and remove any pre-existing Merge events
+ * on the next adjacent counter
+ */
+static void
+amd_commit_scheduling_f17h(struct cpu_hw_events *cpuc, int idx, int cntr)
+{
+	struct event_constraint *c = cpuc->event_constraint[idx];
+	unsigned int next_ctr_ctl;
+	u64 config;
+
+	/*
+	 * Merge events only modify events on even numbered counters,
+	 * and up to the one before last
+	 */
+	if ((cntr & 1) || cntr + 1 >= x86_pmu.num_counters)
+		return;
+
+	next_ctr_ctl = x86_pmu_config_addr(cntr + 1);
+
+	if (c->flags & PERF_X86_EVENT_LARGE_INC) {
+		wrmsrl(next_ctr_ctl, AMD_MERGE_EVENT_ENABLE);
+	} else {
+		rdmsrl(next_ctr_ctl, config);
+		if ((config & AMD_MERGE_EVENT_ENABLE) ==
+		    AMD_MERGE_EVENT_ENABLE) {
+			config &= ~AMD_MERGE_EVENT_ENABLE;
+			wrmsrl(next_ctr_ctl, config);
+		}
+	}
+}
+
 static ssize_t amd_event_sysfs_show(char *page, u64 config)
 {
 	u64 event = (config & ARCH_PERFMON_EVENTSEL_EVENT) |
@@ -906,9 +944,21 @@ static __initconst const struct x86_pmu amd_pmu = {
 
 static int __init amd_core_pmu_init(void)
 {
+	u64 even_ctr_mask = 0ULL;
+	int i;
+
 	if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
 		return 0;
 
+	/*
+	 * If core performance counter extensions exists, we must use
+	 * MSR_F15H_PERF_CTL/MSR_F15H_PERF_CTR msrs. See also
+	 * amd_pmu_addr_offset().
+	 */
+	x86_pmu.eventsel	= MSR_F15H_PERF_CTL;
+	x86_pmu.perfctr		= MSR_F15H_PERF_CTR;
+	x86_pmu.num_counters	= AMD64_NUM_COUNTERS_CORE;
+
 	switch (boot_cpu_data.x86) {
 	case 0x15:
 		pr_cont("Fam15h ");
@@ -917,9 +967,23 @@ static int __init amd_core_pmu_init(void)
 	case 0x17:
 		pr_cont("Fam17h ");
 		/*
-		 * In family 17h, there are no event constraints in the PMC hardware.
-		 * We fallback to using default amd_get_event_constraints.
+		 * Family 17h has constraints for Large Increment per Cycle
+		 * events: they may only land on an even numbered counter
+		 * that has a consecutive adjacent odd numbered counter
+		 * following it.
 		 */
+		for (i = 0; i < x86_pmu.num_counters - 1; i += 2)
+			even_ctr_mask |= 1 << i;
+
+		lg_inc_constraint = (struct event_constraint)
+				    __EVENT_CONSTRAINT(0, even_ctr_mask, 0,
+				    x86_pmu.num_counters / 2, 0,
+				    PERF_X86_EVENT_LARGE_INC);
+
+		x86_pmu.get_event_constraints = amd_get_event_constraints_f17h;
+		x86_pmu.commit_scheduling = amd_commit_scheduling_f17h;
+		x86_pmu.flags |= PMU_FL_MERGE;
+
 		break;
 	case 0x18:
 		pr_cont("Fam18h ");
@@ -930,14 +994,6 @@ static int __init amd_core_pmu_init(void)
 		return -ENODEV;
 	}
 
-	/*
-	 * If core performance counter extensions exists, we must use
-	 * MSR_F15H_PERF_CTL/MSR_F15H_PERF_CTR msrs. See also
-	 * amd_pmu_addr_offset().
-	 */
-	x86_pmu.eventsel	= MSR_F15H_PERF_CTL;
-	x86_pmu.perfctr		= MSR_F15H_PERF_CTR;
-	x86_pmu.num_counters	= AMD64_NUM_COUNTERS_CORE;
 	/*
 	 * AMD Core perfctr has separate MSRs for the NB events, see
 	 * the amd/uncore.c driver.
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 325959d19d9a..4596c141f348 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -787,6 +787,18 @@ static bool __perf_sched_find_counter(struct perf_sched *sched)
 		if (!__test_and_set_bit(idx, sched->state.used)) {
 			if (sched->state.nr_gp++ >= sched->max_gp)
 				return false;
+			if (c->flags & PERF_X86_EVENT_LARGE_INC) {
+				/*
+				 * merged events need the Merge event
+				 * on the next counter
+				 */
+				if (__test_and_set_bit(idx + 1,
+						       sched->state.used))
+					/* next counter already used */
+					return false;
+
+				set_bit(idx + 1, sched->state.used);
+			}
 
 			goto done;
 		}
@@ -849,14 +861,20 @@ int perf_assign_events(struct event_constraint **constraints, int n,
 			int wmin, int wmax, int gpmax, int *assign)
 {
 	struct perf_sched sched;
+	struct event_constraint *c;
+
 
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
@@ -952,6 +970,18 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 		    READ_ONCE(cpuc->excl_cntrs->exclusive_present))
 			gpmax /= 2;
 
+		/*
+		 * reduce the amount of available counters
+		 * to allow fitting the Merge event along
+		 * with their large increment event
+		 */
+		if (x86_pmu.flags & PMU_FL_MERGE) {
+			for (i = 0; i < n; i++) {
+				hwc = &cpuc->event_list[i]->hw;
+				if (is_lg_inc_event(hwc) && gpmax > 1)
+					gpmax--;
+			}
+		}
 		unsched = perf_assign_events(cpuc->event_constraint, n, wmin,
 					     wmax, gpmax, assign);
 	}
@@ -1210,6 +1240,13 @@ int x86_perf_event_set_period(struct perf_event *event)
 
 	wrmsrl(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
 
+	/*
+	 * Clear the Merge event counter's upper 16 bits since
+	 * we currently declare a 48-bit counter width
+	 */
+	if (is_lg_inc_event(hwc))
+		wrmsrl(x86_pmu_event_addr(idx + 1), 0);
+
 	/*
 	 * Due to erratum on certan cpu we need
 	 * a second write to be sure the register
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 8751008fc170..533fd9f982fc 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -76,6 +76,7 @@ static inline bool constraint_match(struct event_constraint *c, u64 ecode)
 #define PERF_X86_EVENT_EXCL_ACCT	0x0100 /* accounted EXCL event */
 #define PERF_X86_EVENT_AUTO_RELOAD	0x0200 /* use PEBS auto-reload */
 #define PERF_X86_EVENT_LARGE_PEBS	0x0400 /* use large PEBS */
+#define PERF_X86_EVENT_LARGE_INC	0x0800 /* Large Increment per Cycle */
 
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
@@ -324,6 +325,8 @@ struct cpu_hw_events {
  */
 #define INTEL_EVENT_CONSTRAINT(c, n)	\
 	EVENT_CONSTRAINT(c, n, ARCH_PERFMON_EVENTSEL_EVENT)
+#define AMD_EVENT_CONSTRAINT(c, n)	\
+	EVENT_CONSTRAINT(c, n, AMD64_EVENTSEL_EVENT)
 
 /*
  * Constraint on a range of Event codes
@@ -723,6 +726,7 @@ do {									\
 #define PMU_FL_EXCL_ENABLED	0x8 /* exclusive counter active */
 #define PMU_FL_PEBS_ALL		0x10 /* all events are valid PEBS events */
 #define PMU_FL_TFA		0x20 /* deal with TSX force abort */
+#define PMU_FL_MERGE		0x40 /* merge counters for large incr. events */
 
 #define EVENT_VAR(_id)  event_attr_##_id
 #define EVENT_PTR(_id) &event_attr_##_id.attr.attr
@@ -892,6 +896,28 @@ ssize_t events_ht_sysfs_show(struct device *dev, struct device_attribute *attr,
 
 int amd_pmu_init(void);
 
+/*
+ * AMD64 events are detected based on their event codes.
+ */
+static inline unsigned int amd_get_event_code(struct hw_perf_event *hwc)
+{
+	return ((hwc->config >> 24) & 0x0f00) | (hwc->config & 0x00ff);
+}
+
+static inline int amd_is_nb_event(struct hw_perf_event *hwc)
+{
+	return (hwc->config & 0xe0) == 0xe0;
+}
+
+/* assumes x86_pmu.flags & PMU_FL_MERGE */
+static inline bool is_lg_inc_event(struct hw_perf_event *hwc)
+{
+	switch (amd_get_event_code(hwc)) {
+	case 0x003: return true; /* Retired SSE/AVX FLOPs */
+	default:    return false;
+	}
+}
+
 #else /* CONFIG_CPU_SUP_AMD */
 
 static inline int amd_pmu_init(void)
@@ -899,6 +925,26 @@ static inline int amd_pmu_init(void)
 	return 0;
 }
 
+static inline unsigned int amd_get_event_code(struct hw_perf_event *hwc)
+{
+	return 0;
+}
+
+static inline int amd_is_nb_event(struct hw_perf_event *hwc)
+{
+	return 0;
+}
+
+static inline int amd_is_merged_event(struct hw_perf_event *hwc)
+{
+	return 0;
+}
+
+static inline bool is_lg_inc_event(struct hw_perf_event *hwc)
+{
+	return 0;
+}
+
 #endif /* CONFIG_CPU_SUP_AMD */
 
 #ifdef CONFIG_CPU_SUP_INTEL
-- 
2.23.0

