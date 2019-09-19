Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C52C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3C221929
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QnedbK7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389421AbfISUni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 16:43:38 -0400
Received: from mail-eopbgr740072.outbound.protection.outlook.com ([40.107.74.72]:52659
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730741AbfISUni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 16:43:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R730IqNZtv1nJck6tPxE+WLJxf8lo2MyGdzx2I5WZdf+uc6uTpRGmPcgLlTPY2YGkk8cb0h8PkXl9RB/9tGzKm5EWHvVOYBuk2Tqrnmp6jIPY7/XNyI7QDhmVPDVLqhZB66863AMvrsNbPFXmkuOyVp6qHqNpT5JncxRCzeskF4facJKi7McU7Cvk8A7fEkGd5MJ6hBYg6Q0+e6GATcQJ5NjqJedajcbzJyO8t820F/JnbEk0w0W4zz/rPp6pZAC3835tPTyOYaQgZfl9h/pRSwOqJ4vdLZ3T9mpyau585LhDU0b1jDPXIhHSKMfESrdjdfY8B+MFbiyg0/clgq2lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6kikqTn97Mzj3uHHEn6YOpB4qFyxb0x3wTR5BbCj/4=;
 b=Pe8OnEnvzm8lafG0alqq+UFjr4RdVf2TbjFornrYj/ZVhGBVK7qob4Yyo8louZoFfCNBZCBumGlhDEV+pzUtQ8OcYDB0nljDk8mYTDyL2ebDoxFolCzPjP7SB6qILHN+RyZjw7G47JVjf7fzLVj7NZqxqmOJV8Yy3G1lJTbLHHlVPEbY/gc15CvTMJSrobFPx1fyznD+6+Y/9vVLhW3XHKemC1+/YJENKdipkjDGW2Wppem/3eSuXaVPJxHxq0HNSEGF0ZIIDWj/t5ZhzyAo78At/hw+UW1EPQuYKw/gQnlH8kstBPfANaAlEr0oxUxEUvmap5Okpw19Wq+UYdbCFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6kikqTn97Mzj3uHHEn6YOpB4qFyxb0x3wTR5BbCj/4=;
 b=QnedbK7VVnbWWDEprdSBImrS6TdvPVVelt5UunOqSxBnqfImLy7HdvWoS+sHcY70emWTe63ez1qq/JQs6LycEzeS7VVYlBViHramxJI/ayNOm9MbJq3HLlkNw7UVFsISgUIj1BX5Gp8YNlaCAlqFCUdV86z/eiWk+tj6JgdUPhE=
Received: from DM3PR12CA0044.namprd12.prod.outlook.com (2603:10b6:0:56::12) by
 BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.19; Thu, 19 Sep
 2019 20:43:34 +0000
Received: from CO1NAM03FT013.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::206) by DM3PR12CA0044.outlook.office365.com
 (2603:10b6:0:56::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20 via Frontend
 Transport; Thu, 19 Sep 2019 20:43:33 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT013.mail.protection.outlook.com (10.152.80.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2284.20 via Frontend Transport; Thu, 19 Sep 2019 20:43:33 +0000
Received: from totem.amd.com (10.180.168.240) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server (TLS) id 14.3.389.1; Thu, 19 Sep
 2019 15:43:32 -0500
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
Subject: [PATCH 2/5] perf vendor events amd: remove redundant '['
Date:   Thu, 19 Sep 2019 15:43:03 -0500
Message-ID: <20190919204306.12598-2-kim.phillips@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919204306.12598-1-kim.phillips@amd.com>
References: <20190919204306.12598-1-kim.phillips@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(376002)(136003)(428003)(189003)(199004)(356004)(6666004)(53416004)(6116002)(3846002)(47776003)(2870700001)(2906002)(5660300002)(50466002)(48376002)(478600001)(36756003)(305945005)(7736002)(1076003)(86362001)(51416003)(7696005)(486006)(76176011)(16526019)(14444005)(126002)(6916009)(70586007)(44832011)(4326008)(70206006)(81166006)(7416002)(50226002)(26005)(81156014)(476003)(446003)(186003)(426003)(54906003)(336012)(316002)(8676002)(2616005)(8936002)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR12MB4116;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7440184-bbdc-4b76-be99-08d73d4209bd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BY5PR12MB4116;
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:
X-Microsoft-Antispam-PRVS: <BY5PR12MB41168FE4193672309444752987890@BY5PR12MB4116.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 016572D96D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: +shRdcsXf5l3I4Mahgz8xoyX8+SJmj/723brgU3FV2wUSEfuYx5EGOOFWmdWmyfE8vtRGjsETLiOFJQLOHo9qS/5gdF0b5gvNwX2R3ZA1WumWybpyn7zEa2pa0/58nTCRgqkKE0u4RbqDQUhMJJgm5IVG7OCJgelVShYosi8kPEl5lbSyRQ730ZUph+ILh3dYxti0oF7jY5mpyN7ztQzVJmG6HbnC8BtquRdMBKn2nQ7wAM5WPfs/N11g5FzjVieAW7CayKUZH6WPjyCok9ga7zx0C/WEPJy9ANaMYqbl8w25toHKLhgzlEHhkpFeKkC4jB7nnRicQp7Y0E3HkEEQNDFzYNdPtANYzUISdRDu41dEOp2y7ew2Zvyd5Q+YN/Oe0I7QJC5X7udgFGGuZrPUdMOiEgbZXkSlCNRZS8JFJQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2019 20:43:33.4738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7440184-bbdc-4b76-be99-08d73d4209bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the redundant '['.

perf list output before:
  ex_ret_brn
       [[Retired Branch Instructions]

perf list output after:
  ex_ret_brn
       [Retired Branch Instructions]

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
Fixes: 98c07a8f74f8 ("perf vendor events amd: perf PMU events for AMD Family 17h")
---
 tools/perf/pmu-events/arch/x86/amdfam17h/core.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/core.json b/tools/perf/pmu-events/arch/x86/amdfam17h/core.json
index 7b285b0a7f35..1079544eeed5 100644
--- a/tools/perf/pmu-events/arch/x86/amdfam17h/core.json
+++ b/tools/perf/pmu-events/arch/x86/amdfam17h/core.json
@@ -13,7 +13,7 @@
   {
     "EventName": "ex_ret_brn",
     "EventCode": "0xc2",
-    "BriefDescription": "[Retired Branch Instructions.",
+    "BriefDescription": "Retired Branch Instructions.",
     "PublicDescription": "The number of branch instructions retired. This includes all types of architectural control flow changes, including exceptions and interrupts."
   },
   {
-- 
2.23.0

