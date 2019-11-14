Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2836C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D532206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4dzox1Ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfKNSkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:40:22 -0500
Received: from mail-eopbgr730041.outbound.protection.outlook.com ([40.107.73.41]:36096
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726628AbfKNSkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:40:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idVs/UlNyW739UTrcyQCSppU0NWXZEbn6tiUvr83TdFUhblhfKty7uiFOGjCs23N4lfOfWkqsxamoGazU24f1RATrZ8jChDKYvqxdEg7B0ZdpRfUXc8kqBECv+Mxsc7zPWq2nmUFOLjeZHiB4PwNUxZVHQ8gv1TSONcFPXXW4VB6YgR3mE68Fx7zL7Kz2q4k3P9XjXfGIOKG5PIZDjICbnF5w3kJn7YzFhu8JIGGJyD9L/9CcfBHP4+AlNL0I0AQZEE5+K0QurAm/uT8yyDz+XkuSGhsoMTk76O/q5tRQ8Qbo0IBLzHwr77vCLNjgeWq+slTO7GZUb5VRqXqll6/2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYBItDgy3tV1HPhIHM7f6jBx6XgjdpmieW4SWJxMGRI=;
 b=NQdXH+Hk++PyhD4KCLnZPZNpl9JpjRZUHx8SsROcx2fFptg73flB/DHN2LbFm64lSKXVoutjDYHsLeVv8BjVA5g+Hb3/wLzbWNoZCFN00VDynZngm3TExSiNC3MeDL68mldIV9Gx4sdDkyKEhuIIeB+MSMGlDGjwTxkuAjacsPV3jp5w1z4C1/yfjDi6qgT6E3vC/5Rpsx3h+EO4Layah0YUvEgkhzQo2MBiFx1CgePntlaiNVGtQGwd/ojKntclPfuorJOuC/GJD/SfDPFe8HZGT1G1EdLR7yRKZSmbcvAyxVIrLy4gd8bvVXpZzo7DbLWsvUHXgCK0V6rt92atsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYBItDgy3tV1HPhIHM7f6jBx6XgjdpmieW4SWJxMGRI=;
 b=4dzox1TyJsTW6NlQYONzVsE5MqxLAt1+g1ii4TWMthsn9UEawYzGYr+53HW3MjTmypcmIFeh+LuVYJp9a2aY5QJmgKRs6yiZt9k9n0w3fqwnKIaF7ankV9sUZiHPyOOwL6+NJVG1r3eFu4suywv2dVrv6nfBBWeAKZsJPhazVx4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (52.135.102.141) by
 SN6PR12MB2815.namprd12.prod.outlook.com (52.135.107.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Thu, 14 Nov 2019 18:37:38 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::7175:51ac:283b:b306]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::7175:51ac:283b:b306%4]) with mapi id 15.20.2430.028; Thu, 14 Nov 2019
 18:37:38 +0000
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
Subject: [PATCH 1/2] perf/x86/amd: Constrain Large Increment per Cycle events
Date:   Thu, 14 Nov 2019 12:37:19 -0600
Message-Id: <20191114183720.19887-2-kim.phillips@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191114183720.19887-1-kim.phillips@amd.com>
References: <20191114183720.19887-1-kim.phillips@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:805:8e::27) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:6e::13)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da5c6698-4676-4f75-da0e-08d76931b99e
X-MS-TrafficTypeDiagnostic: SN6PR12MB2815:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB28153A5351C83C8D25E8BC5487710@SN6PR12MB2815.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 02213C82F8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(199004)(189003)(486006)(8676002)(81156014)(81166006)(54906003)(478600001)(47776003)(305945005)(66066001)(4326008)(8936002)(7736002)(36756003)(44832011)(1076003)(6116002)(50226002)(5660300002)(6436002)(86362001)(25786009)(2870700001)(6486002)(3846002)(11346002)(6666004)(52116002)(76176011)(23676004)(2906002)(110136005)(316002)(66476007)(66556008)(14454004)(476003)(2616005)(66946007)(446003)(386003)(6506007)(99286004)(26005)(50466002)(186003)(7416002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2815;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRF1GpEuDoz9AMwHHs/a9AW2gqtl0ph7TUa0H66C2diHHJCaNgj7zyYS1VLGT0b3rbFn3k9HK79Q/H/bNpVBxSGh/AxHQWuUz5T76aaur6EKEgpo+Eza5fv5xrcVoEVwFZfmmHDzWq6WbIOXWa9hKa+KG4AQk6OK1otR/SB1Dwn3Qqvyb1Y54xY9r+eZEPUcJ4A7vznbpZQARspStxogGF9jDugjWgU5FFn9IOrYZH4LJo45MyC4C7dbM6E5WKOOQyCIaAq1Qc5LwzQnv65o6TW4plYhfbBZlNGHIQBs5pai895VNhU3qIJBNLgPZtedPKZjF5VH9pJF9vlzTQ+srd8t7tIy0HOdsErAYjDNG7MtmOmyEaxk/4ITVVna85MhwJ8gRKTL77LjAUuGLZftU0ysxy3IPrOe3m3GwzT372s6WfoVPmA1dgvW82XBcz3a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5c6698-4676-4f75-da0e-08d76931b99e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2019 18:37:38.7782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ma+zYdZk92ukaFWofiIgY30Gfdc2abACbRFM6LnazJIj73N2bzWNnnZzJf5m5rQyoAR0h5GE8mt+zGqz/5/T5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2815
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Family 17h processors and above gain support for Large Increment
per Cycle events.  Unfortunately there is no CPUID or equivalent bit
that indicates whether the feature exists or not, so we continue to
determine eligibility based on a CPU family number comparison.

For Large Increment per Cycle events, we add a f17h-and-compatibles
get_event_constraints_f17h() that returns an even counter bitmask:
Large Increment per Cycle events can only be placed on PMCs 0, 2,
and 4 out of the currently available 0-5.  The only currently
public event that requires this feature to report valid counts
is PMCx003 "Retired SSE/AVX Operations".

Note that the CPU family logic in amd_core_pmu_init() is changed
so as to be able to selectively add initialization for features
available in ranges of backward-compatible CPU families.  This
Large Increment per Cycle feature is expected to be retained
in future families.

A side-effect of assigning a new get_constraints function for f17h
disables calling the old (prior to f15h) amd_get_event_constraints
implementation left enabled by commit e40ed1542dd7 ("perf/x86: Add perf
support for AMD family-17h processors"), which is no longer
necessary since those North Bridge event codes are obsoleted.

Also fix a spelling mistake whilst in the area (calulating ->
calculating).

Fixes: e40ed1542dd7 ("perf/x86: Add perf support for AMD family-17h processors")
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
 arch/x86/events/amd/core.c   | 91 ++++++++++++++++++++++++------------
 arch/x86/events/perf_event.h |  2 +
 2 files changed, 63 insertions(+), 30 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 64c3e70b0556..78f771cadb8e 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -301,6 +301,25 @@ static inline int amd_pmu_addr_offset(int index, bool eventsel)
 	return offset;
 }
 
+/*
+ * AMD64 events are detected based on their event codes.
+ */
+static inline unsigned int amd_get_event_code(struct hw_perf_event *hwc)
+{
+	return ((hwc->config >> 24) & 0x0f00) | (hwc->config & 0x00ff);
+}
+
+static inline bool amd_is_lg_inc_event_code(struct hw_perf_event *hwc)
+{
+	if (!(x86_pmu.flags & PMU_FL_MERGE))
+		return false;
+
+	switch (amd_get_event_code(hwc)) {
+	case 0x003:	return true;	/* Retired SSE/AVX FLOPs */
+	default:	return false;
+	}
+}
+
 static int amd_core_hw_config(struct perf_event *event)
 {
 	if (event->attr.exclude_host && event->attr.exclude_guest)
@@ -319,14 +338,6 @@ static int amd_core_hw_config(struct perf_event *event)
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
 static inline int amd_is_nb_event(struct hw_perf_event *hwc)
 {
 	return (hwc->config & 0xe0) == 0xe0;
@@ -864,6 +875,20 @@ amd_get_event_constraints_f15h(struct cpu_hw_events *cpuc, int idx,
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
+	if (amd_is_lg_inc_event_code(hwc))
+		return &lg_inc_constraint;
+
+	return &unconstrained;
+}
+
 static ssize_t amd_event_sysfs_show(char *page, u64 config)
 {
 	u64 event = (config & ARCH_PERFMON_EVENTSEL_EVENT) |
@@ -907,33 +932,15 @@ static __initconst const struct x86_pmu amd_pmu = {
 
 static int __init amd_core_pmu_init(void)
 {
+	u64 even_ctr_mask = 0ULL;
+	int i;
+
 	if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
 		return 0;
 
-	/* Avoid calulating the value each time in the NMI handler */
+	/* Avoid calculating the value each time in the NMI handler */
 	perf_nmi_window = msecs_to_jiffies(100);
 
-	switch (boot_cpu_data.x86) {
-	case 0x15:
-		pr_cont("Fam15h ");
-		x86_pmu.get_event_constraints = amd_get_event_constraints_f15h;
-		break;
-	case 0x17:
-		pr_cont("Fam17h ");
-		/*
-		 * In family 17h, there are no event constraints in the PMC hardware.
-		 * We fallback to using default amd_get_event_constraints.
-		 */
-		break;
-	case 0x18:
-		pr_cont("Fam18h ");
-		/* Using default amd_get_event_constraints. */
-		break;
-	default:
-		pr_err("core perfctr but no constraints; unknown hardware!\n");
-		return -ENODEV;
-	}
-
 	/*
 	 * If core performance counter extensions exists, we must use
 	 * MSR_F15H_PERF_CTL/MSR_F15H_PERF_CTR msrs. See also
@@ -948,6 +955,30 @@ static int __init amd_core_pmu_init(void)
 	 */
 	x86_pmu.amd_nb_constraints = 0;
 
+	if (boot_cpu_data.x86 == 0x15) {
+		pr_cont("Fam15h ");
+		x86_pmu.get_event_constraints = amd_get_event_constraints_f15h;
+	}
+	if (boot_cpu_data.x86 >= 0x17) {
+		pr_cont("Fam17h+ ");
+		/*
+		 * Family 17h and compatibles have constraints for Large
+		 * Increment per Cycle events: they may only be assigned an
+		 * even numbered counter that has a consecutive adjacent odd
+		 * numbered counter following it.
+		 */
+		for (i = 0; i < x86_pmu.num_counters - 1; i += 2)
+			even_ctr_mask |= 1 << i;
+
+		lg_inc_constraint = (struct event_constraint)
+				    __EVENT_CONSTRAINT(0, even_ctr_mask, 0,
+				    x86_pmu.num_counters / 2, 0,
+				    PERF_X86_EVENT_LARGE_INC);
+
+		x86_pmu.get_event_constraints = amd_get_event_constraints_f17h;
+		x86_pmu.flags |= PMU_FL_MERGE;
+	}
+
 	pr_cont("core perfctr, ");
 	return 0;
 }
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ecacfbf4ebc1..6154f06eb4ba 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -77,6 +77,7 @@ static inline bool constraint_match(struct event_constraint *c, u64 ecode)
 #define PERF_X86_EVENT_AUTO_RELOAD	0x0200 /* use PEBS auto-reload */
 #define PERF_X86_EVENT_LARGE_PEBS	0x0400 /* use large PEBS */
 #define PERF_X86_EVENT_PEBS_VIA_PT	0x0800 /* use PT buffer for PEBS */
+#define PERF_X86_EVENT_LARGE_INC	0x1000 /* Large Increment per Cycle */
 
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
@@ -735,6 +736,7 @@ do {									\
 #define PMU_FL_EXCL_ENABLED	0x8 /* exclusive counter active */
 #define PMU_FL_PEBS_ALL		0x10 /* all events are valid PEBS events */
 #define PMU_FL_TFA		0x20 /* deal with TSX force abort */
+#define PMU_FL_MERGE		0x40 /* merge counters for large incr. events */
 
 #define EVENT_VAR(_id)  event_attr_##_id
 #define EVENT_PTR(_id) &event_attr_##_id.attr.attr
-- 
2.24.0

