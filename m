Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B57C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B8521D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="A7dGL4la"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390307AbfISUoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 16:44:14 -0400
Received: from mail-eopbgr750072.outbound.protection.outlook.com ([40.107.75.72]:52098
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387403AbfISUoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 16:44:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c22TfhQrtIb+HZzmDp3pTN0crKwVQTGOSg8K3poqYC5T+nlAdcjQpeho+tQo0jKMkkwRdrrlaUUvcW/k/q+mVcfQmwKZ9gf8L4i7APoOC6+uBBy59z6Nxer+wCKP9st0UEGUVev+SdHvMrJKuweaPrjgH0v9kxDLw44urMAI4bTY8ac8oBx8F3Ah4/+MQhPJy2UOfEyUJNvQbT/3g0xrN8IDfCYga2QyZQRxq8+ch7OzdhUEfTM7t0cyLdAQktcMaXQ+HtPy9U3hXSI9Lur9SnkRaxrMAfJdIVuW3r2Jx9ti+JC97sw7R+KQONI9h4OEANeao15qVT8XiE8flLGOzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZQrI1z4p3JMQVIYjr6tGQ4BaJaBk/f9OJtfvb0JRoo=;
 b=M8AA/n6KAZTe9qC0xYSXJGJ1La2WFKVpy7KXteFAQtURG7c3fDK0drDKYGwh/2pDwtVWEn7y4gGGyrZe8Qrl/Zx8geBJXgiJYCqvTA35KjLcaeWOImly3+t0YcZNXT0Zl+VwshlOYJmsbR1HtmqzDMCohEBLOKtsqiOwx+cZ2mZqndKd6azI6cx6VwegzQmRgY/E1yc3fim0FUoDH3N2L9WFb3/ujW6owUbBzcL136ZOSXPA3BP7Q5Mk+6JLhHeqRwQGy28Wsl7qj3dWS+vl7l8vJE979IO7Rbw4rWcGmvsPRl3K5Ky4/dXLLLKOfVZUtfMa1XclJvBAFpzvCj8LQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZQrI1z4p3JMQVIYjr6tGQ4BaJaBk/f9OJtfvb0JRoo=;
 b=A7dGL4la5HMFUVjpqFjbww29hvZzYw6OXySlkq7++CyWJNkaf87AH6eVaCw9lrl2TQ5y3n5vleohpU2krTe4/xlvyTAsH0GE9b6GDY8nHQL4S1+3fIHdEXnKuwwWAplvo0ayk/HzPs4X4I4qMtNCLZ7/n3U7oJ04HMgn8uLZDSY=
Received: from MN2PR12CA0015.namprd12.prod.outlook.com (2603:10b6:208:a8::28)
 by MWHPR12MB1487.namprd12.prod.outlook.com (2603:10b6:301:3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.18; Thu, 19 Sep
 2019 20:44:09 +0000
Received: from CO1NAM03FT044.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::209) by MN2PR12CA0015.outlook.office365.com
 (2603:10b6:208:a8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.19 via Frontend
 Transport; Thu, 19 Sep 2019 20:44:09 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT044.mail.protection.outlook.com (10.152.81.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2284.20 via Frontend Transport; Thu, 19 Sep 2019 20:44:09 +0000
Received: from totem.amd.com (10.180.168.240) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server (TLS) id 14.3.389.1; Thu, 19 Sep
 2019 15:44:06 -0500
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
Subject: [PATCH 5/5] perf list: specify metrics are to be used with -M
Date:   Thu, 19 Sep 2019 15:43:06 -0500
Message-ID: <20190919204306.12598-5-kim.phillips@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919204306.12598-1-kim.phillips@amd.com>
References: <20190919204306.12598-1-kim.phillips@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(136003)(396003)(428003)(199004)(189003)(426003)(81166006)(81156014)(2616005)(4326008)(48376002)(7416002)(486006)(50226002)(476003)(446003)(11346002)(44832011)(126002)(16526019)(186003)(26005)(478600001)(70586007)(70206006)(8676002)(8936002)(7736002)(86362001)(336012)(316002)(2870700001)(76176011)(7696005)(51416003)(3846002)(2906002)(6116002)(50466002)(305945005)(36756003)(47776003)(54906003)(6916009)(5660300002)(53416004)(1076003)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1487;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bb6bb04-d736-4c06-40a0-08d73d421eec
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MWHPR12MB1487;
X-MS-TrafficTypeDiagnostic: MWHPR12MB1487:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1487D549AA5B86122F8FBB2287890@MWHPR12MB1487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 016572D96D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Xg/wKLBaCSsQl26LI/+pirpLTajP8gPdnXKNT8y2P1lQzoT3WFcRd0eU62mLUJ8mobR1GRSzJQ+wmp5/Z6wMIXh19ZKA27GHun3pzPjjNOskndlOHvT6CKaFgzI/33IKfeBFTWVmMKNbIIjU01z7UXkZCfDlFYWyaDQMX7zHOK5EgfXIp7OfSRcFk5x9Zzd/tRNI/0ciJ2+JgX00p6gHCk8TEcUbN9bVLmU1p7stDxZ8qpV0MEuBEvoRR6h4FeLO4WVZxKRbMT8IMTM0oVDn+t8/JEh9iWKcf4axOw5eYvbg/vdvsT9XJunIUXUHijeBgGSSJSDdwDo51VT5u+hoexZX89WaGhjDv+e3QcFcGNaLWsF7Hge29nLTHac4tSEoMKnoQJgc1dxUHjzJCrjbWT4Fps4x+wDUb9+WoNTCjIE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2019 20:44:09.0148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb6bb04-d736-4c06-40a0-08d73d421eec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1487
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Output of 'perf list metrics' before:

  $ perf list metrics

  List of pre-defined events (to be used in -e):

  Metrics:

    C2_Pkg_Residency
         [C2 residency percent per package]
  ...

This misleads the uninitiated user to try:

  $ perf stat -e C2_Pkg_Residency

which gets:

  event syntax error: 'C2_Pkg_Residency'
                       \___ parser error
  Run 'perf list' for a list of valid events

Explicitly clarify that metrics and metricgroups are meant to
be used with -M, and correct the grammar for the -e equivalent
statement.

Output of 'perf list metrics' after:

  $ perf list metrics

  List of pre-defined events (to be used with -e):

  Metrics (to be used with -M):

    C2_Pkg_Residency
         [C2 residency percent per package]
  ...

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
 tools/perf/builtin-list.c     | 2 +-
 tools/perf/util/metricgroup.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 08e62ae9d37e..be8e878aa556 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -51,7 +51,7 @@ int cmd_list(int argc, const char **argv)
 	setup_pager();
 
 	if (!raw_dump && pager_in_use())
-		printf("\nList of pre-defined events (to be used in -e):\n\n");
+		printf("\nList of pre-defined events (to be used with -e):\n\n");
 
 	if (argc == 0) {
 		print_events(NULL, raw_dump, !desc_flag, long_desc_flag,
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index a7c0424dbda3..f116848be9f7 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -377,9 +377,10 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 	}
 
 	if (metricgroups && !raw)
-		printf("\nMetric Groups:\n\n");
+		printf("\nMetric Groups");
 	else if (metrics && !raw)
-		printf("\nMetrics:\n\n");
+		printf("\nMetrics");
+	printf(" (to be used with -M):\n\n");
 
 	for (node = rb_first_cached(&groups.entries); node; node = next) {
 		struct mep *me = container_of(node, struct mep, nd);
-- 
2.23.0

