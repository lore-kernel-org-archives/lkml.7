Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B81C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A66821920
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DTJl12YE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390098AbfISUoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 16:44:08 -0400
Received: from mail-eopbgr770082.outbound.protection.outlook.com ([40.107.77.82]:9696
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387403AbfISUoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 16:44:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5DltKjnXGQnQ5YtUZ9KKsAv77DYZmUQgGxVJnkOy9QL5EURRGYYXum7brKwYZcSBO23AmaJI9cIhfYIRTDLSzoHEFbog97hR+r2z8j5y8y6K8/vr0tVenm7IHZjlyyj0I29eWDYaPOLDYdFJiZUCRTnu/IPifLsz833y4FhyGU2H+rKIFwpp8VIovSn5WXwOFkmTIJKl9/N2dBVtXz+Zjq+oaVkcTe6OxeHAmtisqJAlK5j7VjaOu4OUF7IBPMWUfe9r89VtWmbc47rGoi2rWyyXjd+bbuGXT7OGSrYWdHA8dAftXLacgxQrejyhJzOYT0CT71n/5C+pJwa64RGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLughKxE4Pr/pPzV1MEwWvRbCgRkRvKQIyCIsrRipFQ=;
 b=mkzItQPzIn92OLpo047De9mJ5X26uC/6Z7jNdbr+hAojgnu0+UbxVPtqZk/UgydRmOEPCYXWJ+LtDpAxdE92DS0aq8y6/8naNQ+byqo4NLSWuOFL84uaTZu9MoDObLcG71IyKZTlhBEO+DBFf6GwiJoiSfYBREPetJUEw9DN5V7sYml9F2GWAfkHCncpzIc3CLwAIv+cilc0tGRUClVslSXxTfkmqHVCgPZxaTFgvU3W9SixridmURXNjML6LKILEdEjW1jVCYVPLAhGZjEzwvCnuK+3MpTqt9Yz24HeSFCqZ3LmQdkqMtSIxXHdsUaHt+x1GFZfpCzn8H8LBBMFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLughKxE4Pr/pPzV1MEwWvRbCgRkRvKQIyCIsrRipFQ=;
 b=DTJl12YEtksXAno/LaLqCCqt52iKlcJHfEAZMo0o/1YrMGwS/3S1tzBnSMZWWTyMVKH6KHidye3a+QyUTCTg0Wjl+mQEKy55mmhlMhbXO6U/n9x/WVe6kfQD8qYdpDT3MMKjyeMlVB6LGHstDnE3aPXWsvFw8uDv21h9catorTg=
Received: from MN2PR12CA0029.namprd12.prod.outlook.com (2603:10b6:208:a8::42)
 by SN1PR12MB2496.namprd12.prod.outlook.com (2603:10b6:802:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.17; Thu, 19 Sep
 2019 20:44:04 +0000
Received: from CO1NAM03FT044.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::201) by MN2PR12CA0029.outlook.office365.com
 (2603:10b6:208:a8::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20 via Frontend
 Transport; Thu, 19 Sep 2019 20:44:04 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT044.mail.protection.outlook.com (10.152.81.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2284.20 via Frontend Transport; Thu, 19 Sep 2019 20:44:03 +0000
Received: from totem.amd.com (10.180.168.240) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server (TLS) id 14.3.389.1; Thu, 19 Sep
 2019 15:43:55 -0500
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
Subject: [PATCH 4/5] perf list: allow plurals for metric, metricgroup
Date:   Thu, 19 Sep 2019 15:43:05 -0500
Message-ID: <20190919204306.12598-4-kim.phillips@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919204306.12598-1-kim.phillips@amd.com>
References: <20190919204306.12598-1-kim.phillips@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(428003)(189003)(199004)(426003)(51416003)(76176011)(476003)(53416004)(8676002)(86362001)(486006)(6916009)(36756003)(7736002)(186003)(44832011)(48376002)(2616005)(47776003)(5660300002)(3846002)(50466002)(26005)(54906003)(446003)(11346002)(70206006)(1076003)(70586007)(2870700001)(6116002)(81156014)(50226002)(126002)(81166006)(305945005)(4326008)(8936002)(316002)(356004)(2906002)(6666004)(7416002)(478600001)(16526019)(336012)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2496;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ba9ae3c-41e1-4c83-f8a2-08d73d421bdc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN1PR12MB2496;
X-MS-TrafficTypeDiagnostic: SN1PR12MB2496:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2496EA0DD8B77A9FF893E18887890@SN1PR12MB2496.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 016572D96D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: PJzVwaXHR4s26Z404AQP9HGbXfEwcK0BQAPrSFp5P/aGW8OhlVt4B4QhsGXdmSuDbAIE+hjnnJu5nQoKwfvKFQJ8RAW326Ixp2f/3Jyr5x9sRVPy1U7FHEVd9XrDppnWe/dXjbwNGwModzHo8Hqec+wmSvTsW60eH013rqtw2XZv1drklpu3dZtaop0ELOUQEvPUcBSxBtOXVBwzZD1PMwgtA6LmbM4iq9PTlYqDtDIi9xQSvcdIfjjsSg/pzdALy5ikjnY4vPM7Zdxl19j6HDD14ZArZrV4Mm5TdrxJ19dMcRfHOJyMnSi7vEHEUd2Z9M42OE3XTIcLNxKAKCiLI0tythES2AjLKWKwKRJcidwUVvQ4lRcJZXoqyYCWWAtfTMYQsTsZ/3cvXeBek0vzr/i3j97B5k0PtTN1HhAzV38=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2019 20:44:03.8885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba9ae3c-41e1-4c83-f8a2-08d73d421bdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2496
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enhance usability by allowing the same plurality used in the output title, for
the command line parameter.

BEFORE, perf deceitfully acts as if there are no metrics to be had:

  $ perf list metrics

  List of pre-defined events (to be used in -e):

  Metric Groups:

  $

But singular 'metric' shows a list of metrics:

$ perf list metric

List of pre-defined events (to be used in -e):

Metrics:

  IPC
       [Instructions Per Cycle (per logical thread)]
  UPI
       [Uops Per Instruction]

AFTER, when asking for 'metrics', we actually see the metrics get listed:

$ perf list metrics

List of pre-defined events (to be used in -e):

Metrics:

  IPC
       [Instructions Per Cycle (per logical thread)]
  UPI
       [Uops Per Instruction]

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
Fixes: 71b0acce78d1 ("perf list: Add metric groups to perf list")
---
 tools/perf/builtin-list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index e290f6b348d8..08e62ae9d37e 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -81,9 +81,9 @@ int cmd_list(int argc, const char **argv)
 						long_desc_flag, details_flag);
 		else if (strcmp(argv[i], "sdt") == 0)
 			print_sdt_events(NULL, NULL, raw_dump);
-		else if (strcmp(argv[i], "metric") == 0)
+		else if (strcmp(argv[i], "metric") == 0 || strcmp(argv[i], "metrics") == 0)
 			metricgroup__print(true, false, NULL, raw_dump, details_flag);
-		else if (strcmp(argv[i], "metricgroup") == 0)
+		else if (strcmp(argv[i], "metricgroup") == 0 || strcmp(argv[i], "metricgroups") == 0)
 			metricgroup__print(false, true, NULL, raw_dump, details_flag);
 		else if ((sep = strchr(argv[i], ':')) != NULL) {
 			int sep_idx;
-- 
2.23.0

