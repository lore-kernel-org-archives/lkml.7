Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6F0C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D70321920
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CkEOAe5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbfISUn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 16:43:26 -0400
Received: from mail-eopbgr720048.outbound.protection.outlook.com ([40.107.72.48]:41760
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730741AbfISUn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 16:43:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDlA9s6HKqgzseU5RFulGy1vb2LGZZziLYGavTpmrO5da2j9K0mbUsScrtrWKk/nJP73p2th1yCGfl827vQ4U8fB+sNrw5his4FulDGwIdQ3KnfOLw5nJ1wdIHGPbJg4U5BjefEcdoxnO2B4EifkCM7OOQl2MtVppBQIyhvKt/w36dUAauaOs2XDXcTWNuTom+r1ckyOcCsAixxKGsP9pl6kYp/oqYS5oAeZrF8UXzneo9jWACqZ2vXevP8dOSAgdNAAgHCjzCbf1avDIpPT2ndtgZNIrdAjrfUhVpLmNdqRyfT+P+gBTknRo7236q13Ye6z9UWMRlIaIf29hkjwEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJaYkLhVsJ0xfRTGLCbSwNKTZek+Po3K8rU/3MP35rk=;
 b=eMPb9XTV9+kQVvfP1Uj2Qll3vCDLivYgphI78ryBlB/qnUVr/Va0UYyHcKgUqIruU9Bq+Gff8mRI9J859+8YPABwvfiJBMLrO8sFtqzi0Kr7jaJL1wt8r9WyxNj9K2qpBLbBYD4CXfsJ81cQ3H0ivQ+KPfGFZzvoFn9+fSX4U//NPrcbwOE2ks+ZOOEdgvn0SKqpi/DOMMAtLjfG7Y+ur7azGVyXXGRvmdGvsaRDZRgbWSO4O3VW/goOT9Mu6qxvG6Dt54CUxgZYcbTmnS1CNSp+5jBiba2+b1hOifkjfmkeEA6IG14bEsdyWIxfnnD4M749HuzzDTf/KO6aRsQDcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJaYkLhVsJ0xfRTGLCbSwNKTZek+Po3K8rU/3MP35rk=;
 b=CkEOAe5K7O1y9HXhXVzI24w//7Z7hF/F24rsJ8hCZIPyLqKrpMfrLDLRGCDz4EKeBW8PSa9dLrcAglYJawB6iaXjwoUoak8GbI82L/xxzgEyLIWd4NDq4k2tV+eNL2hvsOd3JRFE5fNoxDdBI8tkJEaFsxLRUXJXH1TWyVT1zLA=
Received: from DM5PR12CA0072.namprd12.prod.outlook.com (2603:10b6:3:103::34)
 by BYAPR12MB3318.namprd12.prod.outlook.com (2603:10b6:a03:df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.26; Thu, 19 Sep
 2019 20:43:23 +0000
Received: from CO1NAM03FT058.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::202) by DM5PR12CA0072.outlook.office365.com
 (2603:10b6:3:103::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.18 via Frontend
 Transport; Thu, 19 Sep 2019 20:43:23 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT058.mail.protection.outlook.com (10.152.81.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2284.20 via Frontend Transport; Thu, 19 Sep 2019 20:43:22 +0000
Received: from totem.amd.com (10.180.168.240) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server (TLS) id 14.3.389.1; Thu, 19 Sep
 2019 15:43:20 -0500
From:   Kim Phillips <kim.phillips@amd.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <kim.phillips@amd.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Jiri Olsa" <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@suse.de>, Martin Liska <mliska@suse.cz>,
        Luke Mujica <lukemujica@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH 1/5] perf vendor events amd: add L3 cache events for Family 17h
Date:   Thu, 19 Sep 2019 15:43:02 -0500
Message-ID: <20190919204306.12598-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(39860400002)(376002)(428003)(189003)(199004)(50226002)(44832011)(7416002)(8676002)(81166006)(1076003)(6666004)(356004)(81156014)(7736002)(3846002)(305945005)(6116002)(53416004)(6916009)(36756003)(48376002)(2906002)(486006)(316002)(8936002)(2870700001)(54906003)(126002)(70206006)(70586007)(16526019)(4326008)(50466002)(14444005)(47776003)(186003)(51416003)(7696005)(26005)(6306002)(966005)(336012)(476003)(2616005)(86362001)(426003)(478600001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3318;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07402e59-6a4b-4f9c-a69e-08d73d42035b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR12MB3318;
X-MS-TrafficTypeDiagnostic: BYAPR12MB3318:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <BYAPR12MB33186DAFEC62D49D5369E0EB87890@BYAPR12MB3318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 016572D96D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ENFbkgyrfKPoBYoXm1AzfK3j9TzvjAlQxpXJ2MLJtv2aFY0WUhIpQeyCchiNQjFAjaGvMNbLXBoeC4ZOM6jxrkwslVJBg7s/ubgsoiIQBTgpiB1VGxCT8M6PU+kDIMRpFElyjqzUhpxoUF55j63c6uaTsrbRWrgNZ4H3krDYxrGlDiKUYY3QP1KtnUSBVHguVOqNXiACzyqu/5UmO+qi7wd4TXbKqTy01uRd24gre3eXl/3F1PI3r9E0/cWfETQ/HDJEq0KQ8qtojfMA1laRQjYUsTgBPyF+rBRbVF/uhqJe8fTs8jcTcsgVUk9rx0PYaF32x/1auhcFf+goc2uQT52d4uIRfeNjQe641Rv+xxxLq3yS6WF99uJL13GCoLwMc9B5+E0y+0siJ73JSODjTY5yni4NvxhMGkD63cvKMXs=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2019 20:43:22.7836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07402e59-6a4b-4f9c-a69e-08d73d42035b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3318
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow users to symbolically specify L3 events for Family 17h processors
using the existing AMD Uncore driver.

Source of events descriptions are from section 2.1.15.4.1
"L3 Cache PMC Events" of the latest Family 17h PPR, available here:

https://www.amd.com/system/files/TechDocs/55570-B1_PUB.zip

Only BriefDescriptions added, since they show with and without
the -v and --details flags.

Tested with:

 # perf stat -e l3_request_g1.caching_l3_cache_accesses,amd_l3/event=0x01,umask=0x80/,l3_comb_clstr_state.request_miss,amd_l3/event=0x06,umask=0x01/ perf bench mem memcpy -s 4mb -l 100 -f default
...
         7,006,831      l3_request_g1.caching_l3_cache_accesses
         7,006,830      amd_l3/event=0x01,umask=0x80/
           366,530      l3_comb_clstr_state.request_miss
           366,568      amd_l3/event=0x06,umask=0x01/

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
 .../pmu-events/arch/x86/amdfam17h/cache.json  | 42 +++++++++++++++++++
 tools/perf/pmu-events/jevents.c               |  1 +
 2 files changed, 43 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/cache.json b/tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
index fad4af9142cb..6221a840fcea 100644
--- a/tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
+++ b/tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
@@ -283,5 +283,47 @@
     "BriefDescription": "Total cycles spent with one or more fill requests in flight from L2.",
     "PublicDescription": "Total cycles spent with one or more fill requests in flight from L2.",
     "UMask": "0x1"
+  },
+  {
+    "EventName": "l3_request_g1.caching_l3_cache_accesses",
+    "EventCode": "0x01",
+    "BriefDescription": "Caching: L3 cache accesses",
+    "UMask": "0x80",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_lookup_state.all_l3_req_typs",
+    "EventCode": "0x04",
+    "BriefDescription": "All L3 Request Types",
+    "UMask": "0xff",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_comb_clstr_state.other_l3_miss_typs",
+    "EventCode": "0x06",
+    "BriefDescription": "Other L3 Miss Request Types",
+    "UMask": "0xfe",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_comb_clstr_state.request_miss",
+    "EventCode": "0x06",
+    "BriefDescription": "L3 cache misses",
+    "UMask": "0x01",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "xi_sys_fill_latency",
+    "EventCode": "0x90",
+    "BriefDescription": "L3 Cache Miss Latency. Total cycles for all transactions divided by 16. Ignores SliceMask and ThreadMask.",
+    "UMask": "0x00",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "xi_ccx_sdp_req1.all_l3_miss_req_typs",
+    "EventCode": "0x9a",
+    "BriefDescription": "All L3 Miss Request Types. Ignores SliceMask and ThreadMask.",
+    "UMask": "0x3f",
+    "Unit": "L3PMC"
   }
 ]
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index d413761621b0..9e37287da924 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -239,6 +239,7 @@ static struct map {
 	{ "hisi_sccl,ddrc", "hisi_sccl,ddrc" },
 	{ "hisi_sccl,hha", "hisi_sccl,hha" },
 	{ "hisi_sccl,l3c", "hisi_sccl,l3c" },
+	{ "L3PMC", "amd_l3" },
 	{}
 };
 
-- 
2.23.0

