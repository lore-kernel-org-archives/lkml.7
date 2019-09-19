Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DC5C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD66921D71
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kfnYhtCE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389688AbfISUnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 16:43:49 -0400
Received: from mail-eopbgr740042.outbound.protection.outlook.com ([40.107.74.42]:3520
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389418AbfISUns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 16:43:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivilMwNS0csUMnqXF4AThDnzli98EuQAAL0e7K7SzUYO5ONKaqL8NAlkl60/Mjc0sg3B5iV+BbBflWLPzZ/EpZ5CnGNiVoKJ+7ivJFmjr1+GE7p+xTXBqubhk0s/l/jgxxs4Y68e/IC9JeB/xnPtVEk567qxg3xd51p9h8bglF68sCCogjt+uaqWZi54j1rt6nOmul0Ky8XR3tiATc4jO/CRLmTWuWw5quNwwocEd7oQq3dftJg76iuEpJXxaL92rwDH9i4RHSDzMO2IBa+oOkVKW43jjKkPYXGVTPY78bY9TMqEIugL+TX1fypxQ1kgwSX6aVorqox1VGLpC7gg8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvMFZMdBM2veJtNVSGX874n6R+DtTmCg7B/HzDa8qJU=;
 b=U89jUPYiFR9hqyLP8aIFP8Rknh4sb+XXdj9rJ75ZpUgfacdBZcK0droh2ExN+rTTAQQll+1EPxYt7i3HXHkS31biTFwfIL0TJ7uAJyzJ+5HNL7s2VpQIFfRWLcv/L2bWQYy/xh6xND6RqJ3zz0qqBTYuK8yHTS7nvaGN9Gn6/UyKais/gqngJggHU/16w0gHXhIj8FR7JZhl26E9Bd3CHdwGfx3piyhRrkCYX/GuecVk/KiZTGqg7SL948cADhQzifPcSbn2RAK3nd0Dz5SMnf68UdCQwAeuIQ4rMY1ltVqD4Zi2iI52ZBtwgraWqezyECBBy6tqtdHUdC7sHbjHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvMFZMdBM2veJtNVSGX874n6R+DtTmCg7B/HzDa8qJU=;
 b=kfnYhtCEQkGl2/kuyRK1z9XJES2PTja6sJM0/iAb9gYWxePTRZ08lE2WVguHBPueToN9X19IqaxrY7M9Vm2priKGufjsqIA6TclNRsIKyxAghzxe6+DTFBfYRWS+v5H39I2e8DWp1RsmoLSAFHrYxgJTsGJ/E27OZVykw9H1do8=
Received: from BN8PR12CA0019.namprd12.prod.outlook.com (2603:10b6:408:60::32)
 by DM5PR12MB1356.namprd12.prod.outlook.com (2603:10b6:3:74::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.26; Thu, 19 Sep
 2019 20:43:45 +0000
Received: from CO1NAM03FT057.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::200) by BN8PR12CA0019.outlook.office365.com
 (2603:10b6:408:60::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.20 via Frontend
 Transport; Thu, 19 Sep 2019 20:43:45 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT057.mail.protection.outlook.com (10.152.81.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2284.20 via Frontend Transport; Thu, 19 Sep 2019 20:43:45 +0000
Received: from totem.amd.com (10.180.168.240) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server (TLS) id 14.3.389.1; Thu, 19 Sep
 2019 15:43:43 -0500
From:   Kim Phillips <kim.phillips@amd.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <kim.phillips@amd.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Jiri Olsa" <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@suse.de>, Martin Liska <mliska@suse.cz>,
        Luke Mujica <lukemujica@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH 3/5] perf vendor events: minor fixes to the README
Date:   Thu, 19 Sep 2019 15:43:04 -0500
Message-ID: <20190919204306.12598-3-kim.phillips@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919204306.12598-1-kim.phillips@amd.com>
References: <20190919204306.12598-1-kim.phillips@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(396003)(428003)(199004)(189003)(6116002)(8676002)(426003)(76176011)(26005)(3846002)(70586007)(7696005)(47776003)(48376002)(53416004)(50226002)(6666004)(186003)(16526019)(70206006)(2906002)(356004)(305945005)(51416003)(50466002)(336012)(7736002)(8936002)(44832011)(486006)(6916009)(7416002)(81166006)(86362001)(1076003)(11346002)(4326008)(2870700001)(81156014)(2616005)(446003)(478600001)(126002)(36756003)(54906003)(5660300002)(476003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1356;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42e3e8eb-8406-470d-eaf0-08d73d4210a8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1356;
X-MS-TrafficTypeDiagnostic: DM5PR12MB1356:
X-Microsoft-Antispam-PRVS: <DM5PR12MB13563027C77DA569E6C69DE787890@DM5PR12MB1356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 016572D96D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: voVQAATS92GKKaSoqNIJanzj6o0bOLeQhzJiM6IaiZjrSB1yGF8bb/CVCjxDcFNEkBiL06T1n6II85M+jqOlk0zcaVHAooIcuSRyqZMcL0nV8H0yLJZL1xDeWq78MiZ+2Cb7aw4U1hDrbE7M2SmDKIwvLY0Iqc6vGodTuGVT/I2yPkeuoum4t6PSTNcbCE2EQcGgVajLGFKpNzQ3H6PDA0YQMcIWxGYriq3ZjE/sRY9jWOE2NVdxXSup0icX7cYXCFPoC57zhsm7djkQbPqlV6gd3DUNhn5Qdl6aQg5EBNHBMo9ifZ2ppBnFWS56ohFtsDNt6X0ULkFZpGvEYfJJJhYHjj74hdG8JiKSTXXcPORpHPKV6bpnCGpsVMUXxYF908J5GBwbkUlyt862Kuz/w0tywAW3IAR/MpIUKb29oa8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2019 20:43:45.0804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e3e8eb-8406-470d-eaf0-08d73d4210a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1356
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some grammatical fixes, and updates to some path references that have
since changed.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Martin Liska <mliska@suse.cz>
Cc: Luke Mujica <lukemujica@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
---
 tools/perf/pmu-events/README | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/pmu-events/README b/tools/perf/pmu-events/README
index e62b09b6a844..de7efa2cebd1 100644
--- a/tools/perf/pmu-events/README
+++ b/tools/perf/pmu-events/README
@@ -30,9 +30,9 @@ the topic. Eg: "Floating-point.json".
 All the topic JSON files for a CPU model/family should be in a separate
 sub directory. Thus for the Silvermont X86 CPU:
 
-	$ ls tools/perf/pmu-events/arch/x86/Silvermont_core
-	Cache.json 	Memory.json 	Virtual-Memory.json
-	Frontend.json 	Pipeline.json
+	$ ls tools/perf/pmu-events/arch/x86/silvermont
+	cache.json     memory.json    virtual-memory.json
+	frontend.json  pipeline.json
 
 The JSONs folder for a CPU model/family may be placed in the root arch
 folder, or may be placed in a vendor sub-folder under the arch folder
@@ -94,7 +94,7 @@ users to specify events by their name:
 
 where 'pm_1plus_ppc_cmpl' is a Power8 PMU event.
 
-However some errors in processing may cause the perf build to fail.
+However some errors in processing may cause the alias build to fail.
 
 Mapfile format
 ===============
@@ -119,7 +119,7 @@ where:
 
 	Header line
 		The header line is the first line in the file, which is
-		always _IGNORED_. It can empty.
+		always _IGNORED_. It can be empty.
 
 	CPUID:
 		CPUID is an arch-specific char string, that can be used
@@ -138,15 +138,15 @@ where:
 		files, relative to the directory containing the mapfile.csv
 
 	Type:
-		indicates whether the events or "core" or "uncore" events.
+		indicates whether the events are "core" or "uncore" events.
 
 
 	Eg:
 
-	$ grep Silvermont tools/perf/pmu-events/arch/x86/mapfile.csv
-	GenuineIntel-6-37,V13,Silvermont_core,core
-	GenuineIntel-6-4D,V13,Silvermont_core,core
-	GenuineIntel-6-4C,V13,Silvermont_core,core
+	$ grep silvermont tools/perf/pmu-events/arch/x86/mapfile.csv
+	GenuineIntel-6-37,v13,silvermont,core
+	GenuineIntel-6-4D,v13,silvermont,core
+	GenuineIntel-6-4C,v13,silvermont,core
 
 	i.e the three CPU models use the JSON files (i.e PMU events) listed
-	in the directory 'tools/perf/pmu-events/arch/x86/Silvermont_core'.
+	in the directory 'tools/perf/pmu-events/arch/x86/silvermont'.
-- 
2.23.0

