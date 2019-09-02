Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DE9C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B520217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="jn2nLLpS";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="jn2nLLpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfIBQIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 12:08:45 -0400
Received: from mail-eopbgr00058.outbound.protection.outlook.com ([40.107.0.58]:40897
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726219AbfIBQIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 12:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYA++4Y3rgQMdAPiDYr+auaml/x7SNJ7tEJTPNjKSUE=;
 b=jn2nLLpSG2qd6VQxp+Zs7QSDkcnrF1ueeCQOEh2rSRb9FISkgcmbXrJk3fH2CxPPXIRmFpta/2F/ob1wwsnvLaR6f4QTZoofFBe/UmUYdjxNEc0KxzHKCh5UjVIlTMcQUe3bRuYf3Rx8abcl5jmjWsN7T3FkThuNaa0R9BNya/Y=
Received: from VI1PR08CA0233.eurprd08.prod.outlook.com (2603:10a6:802:15::42)
 by DB8PR08MB4956.eurprd08.prod.outlook.com (2603:10a6:10:e0::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.22; Mon, 2 Sep
 2019 16:08:33 +0000
Received: from DB5EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by VI1PR08CA0233.outlook.office365.com
 (2603:10a6:802:15::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.19 via Frontend
 Transport; Mon, 2 Sep 2019 16:08:33 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT025.mail.protection.outlook.com (10.152.20.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16 via Frontend Transport; Mon, 2 Sep 2019 16:08:31 +0000
Received: ("Tessian outbound 108f768cde3d:v27"); Mon, 02 Sep 2019 16:08:31 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0f9a3b90578257ce
X-CR-MTA-TID: 64aa7808
Received: from bbfda4bd78e9.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.5.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id FBFC4656-7524-4494-95B7-EAADB599A267.1;
        Mon, 02 Sep 2019 16:08:31 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02lp2056.outbound.protection.outlook.com [104.47.5.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id bbfda4bd78e9.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 02 Sep 2019 16:08:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyYHUq29WhaQEocSRb9ajI2wcaUOBpAe+LHCDgQ/U6w5Jpp+nCM4/5ZIMDQCaicx2+QRvjN5zwRZntNY4AeSSinP0eXTh69ukdAsTu7X+NfiTdNq8C8edKVKCSJawPi/9HoX8mM5L+te2Jn3zZnrokoe31YTliWjSB/v6XatNAn6wNs+h23SmvlTRZWfL1AxUxkPMwaMTlIcfoqrNJHLvYg60cqbA5cXFw6FXImdCDwzQqBqk4pbbdhP9uetGiHKnmeVg9FqYUQg/GxmdNrsBQohv7qwOXY/Eif18yUfahswk6QQWZ0wKFo7vhCUaOLzocJGAmowBVpwxGwlpgasZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYA++4Y3rgQMdAPiDYr+auaml/x7SNJ7tEJTPNjKSUE=;
 b=D7arm0jhBavbzXvWuUaNadPyI28hWbdjO8BxHTClUfOcvgM0Q8o/C4Ei+honMntIvP0CNWOi9pVNdW7rOq5/oT1tp4SEg0treenPecdc/oyhUVYqRNmO2z2G2hC0+mVXm8PxS/f2JfhrBu6mWTGsPnrJ7PzrtImerNjUTAHBuzwUrvl47lpyhIoT53YkaYCukQPo6SjW4iWgxZrOkPjS71PvmJxunwKgH5KMTShH3n5zp0tWAhqr4d1TA8svcfUdMiANEz1w516DnYxGY9vcKS4WR/V9+fxTszdaArBBYK4m51RPLFCInJtREPGiuTi4jIo6wIkR3ltO0mflUrSHGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYA++4Y3rgQMdAPiDYr+auaml/x7SNJ7tEJTPNjKSUE=;
 b=jn2nLLpSG2qd6VQxp+Zs7QSDkcnrF1ueeCQOEh2rSRb9FISkgcmbXrJk3fH2CxPPXIRmFpta/2F/ob1wwsnvLaR6f4QTZoofFBe/UmUYdjxNEc0KxzHKCh5UjVIlTMcQUe3bRuYf3Rx8abcl5jmjWsN7T3FkThuNaa0R9BNya/Y=
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com (10.172.218.15) by
 AM4PR0802MB2337.eurprd08.prod.outlook.com (10.172.218.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Mon, 2 Sep 2019 16:08:19 +0000
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::7d5c:f74d:f62b:2f9f]) by AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::7d5c:f74d:f62b:2f9f%9]) with mapi id 15.20.2220.021; Mon, 2 Sep 2019
 16:08:19 +0000
From:   James Clark <James.Clark@arm.com>
To:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>, James Clark <James.Clark@arm.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v2 1/1] perf tools: Add PMU event JSON files for ARM
 Cortex-A76 and, Neoverse N1.
Thread-Topic: [PATCH v2 1/1] perf tools: Add PMU event JSON files for ARM
 Cortex-A76 and, Neoverse N1.
Thread-Index: AQHVYaijxljQ5VWnlkaCOmgKOvKJaQ==
Date:   Mon, 2 Sep 2019 16:08:19 +0000
Message-ID: <20190902160713.1425-2-james.clark@arm.com>
References: <00f00310-09ae-909c-4dfd-021996e45be1@arm.com>
 <20190902160713.1425-1-james.clark@arm.com>
In-Reply-To: <20190902160713.1425-1-james.clark@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.40]
x-clientproxiedby: LO2P265CA0355.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::31) To AM4PR0802MB2242.eurprd08.prod.outlook.com
 (2603:10a6:200:5f::15)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: e4d4698c-e7df-459a-95e4-08d72fbfccbe
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR0802MB2337;
X-MS-TrafficTypeDiagnostic: AM4PR0802MB2337:|AM4PR0802MB2337:|DB8PR08MB4956:
X-MS-Exchange-PUrlCount: 2
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB495680F662CBD138F4531EF1E2BE0@DB8PR08MB4956.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 01480965DA
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(189003)(199004)(316002)(14444005)(256004)(99286004)(305945005)(7736002)(50226002)(36756003)(66066001)(8936002)(2906002)(486006)(446003)(11346002)(2616005)(476003)(81156014)(81166006)(8676002)(44832011)(52116002)(66946007)(66446008)(66476007)(66556008)(64756008)(110136005)(54906003)(76176011)(71200400001)(71190400001)(102836004)(6506007)(186003)(2501003)(26005)(386003)(6436002)(6512007)(53946003)(6306002)(3846002)(6116002)(25786009)(4326008)(5660300002)(966005)(30864003)(6486002)(14454004)(53936002)(86362001)(1076003)(478600001)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2337;H:AM4PR0802MB2242.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: 4Hw69ZrAhV9GVsQRxXj31CIi+HI7B/3xfK/5JStpzxWeOCj1JjfLHjfgotOVuQ6JB0R0Pu/Uy2NaQYYYvqmtCXHhMaqZ6sXPbQH9k1tynh2T2D0sb7IOy3m/nGTO7aDLefZZrY5QUuMouUZu3Jgmx5faYxljGSLlBQkttKA81+VdvQGj06z2LOBbDtw4ovycix0PUiZC4T12p/7dfiw2u7VRJifWDNomZeP/13mdZ97zdojiXBJNFlkuvKKeds8XjctIaPYzXUnwsi+77FLDCAYmjbg6+yeHQhSxIO/V1oYz8NlQJmUqfIriV64AsXarxLC7VG/YlwZwF4+zFff+AQ1pjD07Ug9Xaf3w985BHj7Uy6oYwnvFRwArGEhRe2eAGTIHoCy/oeC4fTL4IIIXH44uTJy2W/f+/KrEMN03+ZY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2337
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(2980300002)(199004)(189003)(6506007)(386003)(102836004)(186003)(11346002)(36756003)(450100002)(356004)(478600001)(4326008)(26005)(305945005)(14444005)(476003)(6306002)(336012)(6512007)(63350400001)(7736002)(63370400001)(126002)(446003)(70206006)(76176011)(2616005)(14454004)(25786009)(26826003)(486006)(966005)(316002)(6486002)(1076003)(99286004)(22756006)(47776003)(110136005)(54906003)(23756003)(3846002)(2501003)(76130400001)(70586007)(6116002)(2906002)(5660300002)(66066001)(8746002)(86362001)(50226002)(8936002)(81166006)(81156014)(8676002)(30864003)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB4956;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: d5103267-5eef-430c-b18a-08d72fbfc567
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR08MB4956;
NoDisclaimer: True
X-Forefront-PRVS: 01480965DA
X-Microsoft-Antispam-Message-Info: LI+qCJcXkMlyIcHL3mH3E83YFa0wgKo3oEmHYKnSDCBG+qnzCL7euIOXI2M9IkavnkfMUPlFK4Lo+6va74ZpaAxCBxYW9LlyT8NYifKLtbE2K5E/6sSvodZbGwwWLeVbul6ZJyhbLMSqO2QwIZAKxrGLGh8rE1uSIXc2MHhqEisVp+ny/+kX8accWBjUOe98LX9NIfLbS8bOMZcYyqWyT2dyHN7xs0hl0zrNggz/P2mrp1aAq250Kq1SsP7p/TxPND99HH2NAl9oZZBZDZHrS4opLnjlCXWQs30+O9yAWV3j8paItlEUyr/4qfSKEcSqJjT9WuUjOIGNRfuqsegEnTp++1Z74jL7/TQtcVBlmobCkSpxSpp2RZ050wTfwhO6o6tCoN4t+LUt3MdYeyabqW3GApAtAt+uHC+3RwQvxWE=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2019 16:08:31.5635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d4698c-e7df-459a-95e4-08d72fbfccbe
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4956
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The source of the event codes and description text was the Neoverse N1
technical reference manual at:

  http://infocenter.arm.com/help/topic/com.arm.doc.100616_0301_01_en/neover=
se_n1_trm_100616_0301_01_en.pdf

The Cortex-A76 shares the same event IDs as the Neoverse N1 and they
can be viewed at:

  https://static.docs.arm.com/100798/0400/cortex_a76_trm_100798_0400_00_en.=
pdf

Signed-off-by: James Clark <james.clark@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 .../arch/arm64/arm/cortex-a76-n1/branch.json  |  14 ++
 .../arch/arm64/arm/cortex-a76-n1/bus.json     |  24 ++
 .../arch/arm64/arm/cortex-a76-n1/cache.json   | 207 ++++++++++++++++++
 .../arm64/arm/cortex-a76-n1/exception.json    |  52 +++++
 .../arm64/arm/cortex-a76-n1/instruction.json  | 108 +++++++++
 .../arch/arm64/arm/cortex-a76-n1/memory.json  |  23 ++
 .../arch/arm64/arm/cortex-a76-n1/other.json   |   7 +
 .../arm64/arm/cortex-a76-n1/pipeline.json     |  14 ++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   2 +
 9 files changed, 451 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bran=
ch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.=
json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cach=
e.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exce=
ption.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/inst=
ruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memo=
ry.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/othe=
r.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipe=
line.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.json=
 b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.json
new file mode 100644
index 000000000000..b5e5d055c70d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.json
@@ -0,0 +1,14 @@
+[
+    {
+        "PublicDescription": "Mispredicted or not predicted branch specula=
tively executed. This event counts any predictable branch instruction which=
 is mispredicted either due to dynamic misprediction or because the MMU is =
off and the branches are statically predicted not taken.",
+        "EventCode": "0x10",
+        "EventName": "BR_MIS_PRED",
+        "BriefDescription": "Mispredicted or not predicted branch speculat=
ively executed."
+    },
+    {
+        "PublicDescription": "Predictable branch speculatively executed. T=
his event counts all predictable branches.",
+        "EventCode": "0x12",
+        "EventName": "BR_PRED",
+        "BriefDescription": "Predictable branch speculatively executed."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.json b/=
tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.json
new file mode 100644
index 000000000000..fce7309ae624
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.json
@@ -0,0 +1,24 @@
+[
+    {
+        "EventCode": "0x11",
+        "EventName": "CPU_CYCLES",
+        "BriefDescription": "The number of core clock cycles."
+    },
+    {
+        "PublicDescription": "Bus access. This event counts for every beat=
 of data transferred over the data channels between the core and the SCU. I=
f both read and write data beats are transferred on a given cycle, this eve=
nt is counted twice on that cycle. This event counts the sum of BUS_ACCESS_=
RD and BUS_ACCESS_WR.",
+        "EventCode": "0x19",
+        "EventName": "BUS_ACCESS",
+        "BriefDescription": "Bus access."
+    },
+    {
+        "EventCode": "0x1D",
+        "EventName": "BUS_CYCLES",
+        "BriefDescription": "Bus cycles. This event duplicates CPU_CYCLES.=
"
+    },
+    {
+        "ArchStdEvent":  "BUS_ACCESS_RD"
+    },
+    {
+        "ArchStdEvent":  "BUS_ACCESS_WR"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cache.json =
b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cache.json
new file mode 100644
index 000000000000..24594081c199
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cache.json
@@ -0,0 +1,207 @@
+[
+    {
+        "PublicDescription": "L1 instruction cache refill. This event coun=
ts any instruction fetch which misses in the cache.",
+        "EventCode": "0x01",
+        "EventName": "L1I_CACHE_REFILL",
+        "BriefDescription": "L1 instruction cache refill"
+    },
+    {
+        "PublicDescription": "L1 instruction TLB refill. This event counts=
 any refill of the instruction L1 TLB from the L2 TLB. This includes refill=
s that result in a translation fault.",
+        "EventCode": "0x02",
+        "EventName": "L1I_TLB_REFILL",
+        "BriefDescription": "L1 instruction TLB refill"
+    },
+    {
+        "PublicDescription": "L1 data cache refill. This event counts any =
load or store operation or page table walk access which causes data to be r=
ead from outside the L1, including accesses which do not allocate into L1."=
,
+        "EventCode": "0x03",
+        "EventName": "L1D_CACHE_REFILL",
+        "BriefDescription": "L1 data cache refill"
+    },
+    {
+        "PublicDescription": "L1 data cache access. This event counts any =
load or store operation or page table walk access which looks up in the L1 =
data cache. In particular, any access which could count the L1D_CACHE_REFIL=
L event causes this event to count.",
+        "EventCode": "0x04",
+        "EventName": "L1D_CACHE",
+        "BriefDescription": "L1 data cache access"
+    },
+    {
+        "PublicDescription": "L1 data TLB refill. This event counts any re=
fill of the data L1 TLB from the L2 TLB. This includes refills that result =
in a translation fault.",
+        "EventCode": "0x05",
+        "EventName": "L1D_TLB_REFILL",
+        "BriefDescription": "L1 data TLB refill"
+    },
+    {
+        "PublicDescription": "Level 1 instruction cache access or Level 0 =
Macro-op cache access. This event counts any instruction fetch which access=
es the L1 instruction cache or L0 Macro-op cache.",
+        "EventCode": "0x14",
+        "EventName": "L1I_CACHE",
+        "BriefDescription": "L1 instruction cache access"
+    },
+    {
+        "PublicDescription": "L1 data cache Write-Back. This event counts =
any write-back of data from the L1 data cache to L2 or L3. This counts both=
 victim line evictions and snoops, including cache maintenance operations."=
,
+        "EventCode": "0x15",
+        "EventName": "L1D_CACHE_WB",
+        "BriefDescription": "L1 data cache Write-Back"
+    },
+    {
+        "PublicDescription": "L2 data cache access. This event counts any =
transaction from L1 which looks up in the L2 cache, and any write-back from=
 the L1 to the L2. Snoops from outside the core and cache maintenance opera=
tions are not counted.",
+        "EventCode": "0x16",
+        "EventName": "L2D_CACHE",
+        "BriefDescription": "L2 data cache access"
+    },
+    {
+        "PublicDescription": "L2 data cache refill. This event counts any =
cacheable transaction from L1 which causes data to be read from outside the=
 core. L2 refills caused by stashes into L2 should not be counted",
+        "EventCode": "0x17",
+        "EventName": "L2D_CACHE_REFILL",
+        "BriefDescription": "L2 data cache refill"
+    },
+    {
+        "PublicDescription": "L2 data cache write-back. This event counts =
any write-back of data from the L2 cache to outside the core. This includes=
 snoops to the L2 which return data, regardless of whether they cause an in=
validation. Invalidations from the L2 which do not write data outside of th=
e core and snoops which return data from the L1 are not counted",
+        "EventCode": "0x18",
+        "EventName": "L2D_CACHE_WB",
+        "BriefDescription": "L2 data cache write-back"
+    },
+    {
+        "PublicDescription": "L2 data cache allocation without refill. Thi=
s event counts any full cache line write into the L2 cache which does not c=
ause a linefill, including write-backs from L1 to L2 and full-line writes w=
hich do not allocate into L1.",
+        "EventCode": "0x20",
+        "EventName": "L2D_CACHE_ALLOCATE",
+        "BriefDescription": "L2 data cache allocation without refill"
+    },
+    {
+        "PublicDescription": "Level 1 data TLB access. This event counts a=
ny load or store operation which accesses the data L1 TLB. If both a load a=
nd a store are executed on a cycle, this event counts twice. This event cou=
nts regardless of whether the MMU is enabled.",
+        "EventCode": "0x25",
+        "EventName": "L1D_TLB",
+        "BriefDescription": "Level 1 data TLB access."
+    },
+    {
+        "PublicDescription": "Level 1 instruction TLB access. This event c=
ounts any instruction fetch which accesses the instruction L1 TLB.This even=
t counts regardless of whether the MMU is enabled.",
+        "EventCode": "0x26",
+        "EventName": "L1I_TLB",
+        "BriefDescription": "Level 1 instruction TLB access"
+    },
+    {
+        "PublicDescription": "This event counts any full cache line write =
into the L3 cache which does not cause a linefill, including write-backs fr=
om L2 to L3 and full-line writes which do not allocate into L2",
+        "EventCode": "0x29",
+        "EventName": "L3D_CACHE_ALLOCATE",
+        "BriefDescription": "Allocation without refill"
+    },
+    {
+        "PublicDescription": "Attributable Level 3 unified cache refill. T=
his event counts for any cacheable read transaction returning datafrom the =
SCU for which the data source was outside the cluster. Transactions such as=
 ReadUnique are counted here as 'read' transactions, even though they can b=
e generated by store instructions.",
+        "EventCode": "0x2A",
+        "EventName": "L3D_CACHE_REFILL",
+        "BriefDescription": "Attributable Level 3 unified cache refill."
+    },
+    {
+        "PublicDescription": "Attributable Level 3 unified cache access. T=
his event counts for any cacheable read transaction returning datafrom the =
SCU, or for any cacheable write to the SCU.",
+        "EventCode": "0x2B",
+        "EventName": "L3D_CACHE",
+        "BriefDescription": "Attributable Level 3 unified cache access."
+    },
+    {
+        "PublicDescription": "Attributable L2 data or unified TLB refill. =
This event counts on anyrefill of the L2 TLB, caused by either an instructi=
on or data access.This event does not count if the MMU is disabled.",
+        "EventCode": "0x2D",
+        "EventName": "L2D_TLB_REFILL",
+        "BriefDescription": "Attributable L2 data or unified TLB refill"
+    },
+    {
+        "PublicDescription": "Attributable L2 data or unified TLB access. =
This event counts on any access to the L2 TLB (caused by a refill of any of=
 the L1 TLBs). This event does not count if the MMU is disabled.",
+        "EventCode": "0x2F",
+        "EventName": "L2D_TLB",
+        "BriefDescription": "Attributable L2 data or unified TLB access"
+    },
+    {
+        "PublicDescription": "Access to data TLB that caused a page table =
walk. This event counts on any data access which causes L2D_TLB_REFILL to c=
ount.",
+        "EventCode": "0x34",
+        "EventName": "DTLB_WALK",
+        "BriefDescription": "Access to data TLB that caused a page table w=
alk."
+    },
+    {
+        "PublicDescription": "Access to instruction TLB that caused a page=
 table walk. This event counts on any instruction access which causes L2D_T=
LB_REFILL to count.",
+        "EventCode": "0x35",
+        "EventName": "ITLB_WALK",
+        "BriefDescription": "Access to instruction TLB that caused a page =
table walk."
+    },
+    {
+        "EventCode": "0x36",
+        "EventName": "LL_CACHE_RD",
+        "BriefDescription": "Last level cache access, read"
+    },
+    {
+        "EventCode": "0x37",
+        "EventName": "LL_CACHE_MISS_RD",
+        "BriefDescription": "Last level cache miss, read"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_INVAL"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_INNER"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_WR"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_CLEAN"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_VICTIM"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WR"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_WR"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_INVAL"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_CLEAN"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_VICTIM"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_WR"
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_RD"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exception.j=
son b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exception.json
new file mode 100644
index 000000000000..98d29c862320
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exception.json
@@ -0,0 +1,52 @@
+[
+    {
+        "EventCode": "0x09",
+        "EventName": "EXC_TAKEN",
+        "BriefDescription": "Exception taken."
+    },
+    {
+        "PublicDescription": "Local memory error. This event counts any co=
rrectable or uncorrectable memory error (ECC or parity) in the protected co=
re RAMs",
+        "EventCode": "0x1A",
+        "EventName": "MEMORY_ERROR",
+        "BriefDescription": "Local memory error."
+    },
+    {
+        "ArchStdEvent": "EXC_DABORT"
+    },
+    {
+        "ArchStdEvent": "EXC_FIQ"
+    },
+    {
+        "ArchStdEvent": "EXC_HVC"
+    },
+    {
+        "ArchStdEvent": "EXC_IRQ"
+    },
+    {
+        "ArchStdEvent": "EXC_PABORT"
+    },
+    {
+        "ArchStdEvent": "EXC_SMC"
+    },
+    {
+        "ArchStdEvent": "EXC_SVC"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_DABORT"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_FIQ"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_IRQ"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_OTHER"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_PABORT"
+    },
+    {
+        "ArchStdEvent": "EXC_UNDEF"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/instruction=
.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/instruction.json
new file mode 100644
index 000000000000..c153ac706d8d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/instruction.json
@@ -0,0 +1,108 @@
+[
+    {
+        "PublicDescription": "Software increment. Instruction architectura=
lly executed (condition code check pass).",
+        "EventCode": "0x00",
+        "EventName": "SW_INCR",
+        "BriefDescription": "Software increment."
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed. This e=
vent counts all retired instructions, including those that fail their condi=
tion check.",
+        "EventCode": "0x08",
+        "EventName": "INST_RETIRED",
+        "BriefDescription": "Instruction architecturally executed."
+    },
+    {
+        "EventCode": "0x0A",
+        "EventName": "EXC_RETURN",
+        "BriefDescription": "Instruction architecturally executed, conditi=
on code check pass, exception return."
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, condit=
ion code check pass, write to CONTEXTIDR. This event only counts writes to =
CONTEXTIDR in AArch32 state, and via the CONTEXTIDR_EL1 mnemonic in AArch64=
 state.",
+        "EventCode": "0x0B",
+        "EventName": "CID_WRITE_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, conditi=
on code check pass, write to CONTEXTIDR."
+    },
+    {
+        "EventCode": "0x1B",
+        "EventName": "INST_SPEC",
+        "BriefDescription": "Operation speculatively executed"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, condit=
ion code check pass, write to TTBR. This event only counts writes to TTBR0/=
TTBR1 in AArch32 state and TTBR0_EL1/TTBR1_EL1 in AArch64 state.",
+        "EventCode": "0x1C",
+        "EventName": "TTBR_WRITE_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, conditi=
on code check pass, write to TTBR"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, branch=
. This event counts all branches, taken or not. This excludes exception ent=
ries, debug entries and CCFAIL branches.",
+        "EventCode": "0x21",
+        "EventName": "BR_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, branch.=
"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, mispre=
dicted branch. This event counts any branch counted by BR_RETIRED which is =
not correctly predicted and causes a pipeline flush.",
+        "EventCode": "0x22",
+        "EventName": "BR_MIS_PRED_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, mispred=
icted branch."
+    },
+    {
+        "ArchStdEvent": "ASE_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_INDIRECT_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_SPEC"
+    },
+    {
+        "ArchStdEvent": "CRYPTO_SPEC"
+    },
+    {
+        "ArchStdEvent": "DMB_SPEC"
+    },
+    {
+        "ArchStdEvent": "DP_SPEC"
+    },
+    {
+        "ArchStdEvent": "DSB_SPEC"
+    },
+    {
+        "ArchStdEvent": "ISB_SPEC"
+    },
+    {
+        "ArchStdEvent": "LDREX_SPEC"
+    },
+    {
+        "ArchStdEvent": "LDST_SPEC"
+    },
+    {
+        "ArchStdEvent": "LD_SPEC"
+    },
+    {
+        "ArchStdEvent": "PC_WRITE_SPEC"
+    },
+    {
+        "ArchStdEvent": "RC_LD_SPEC"
+    },
+    {
+        "ArchStdEvent": "RC_ST_SPEC"
+    },
+    {
+        "ArchStdEvent": "STREX_FAIL_SPEC"
+    },
+    {
+        "ArchStdEvent": "STREX_PASS_SPEC"
+    },
+    {
+        "ArchStdEvent": "STREX_SPEC"
+    },
+    {
+        "ArchStdEvent": "ST_SPEC"
+    },
+    {
+        "ArchStdEvent": "VFP_SPEC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json=
 b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json
new file mode 100644
index 000000000000..b86643253f19
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json
@@ -0,0 +1,23 @@
+[
+    {
+        "PublicDescription": "Data memory access. This event counts memory=
 accesses due to load or store instructions. This event counts the sum of M=
EM_ACCESS_RD and MEM_ACCESS_WR.",
+        "EventCode": "0x13",
+        "EventName": "MEM_ACCESS",
+        "BriefDescription": "Data memory access"
+    },
+    {
+         "ArchStdEvent": "MEM_ACCESS_RD"
+    },
+    {
+         "ArchStdEvent": "MEM_ACCESS_WR"
+    },
+    {
+         "ArchStdEvent": "UNALIGNED_LD_SPEC"
+    },
+    {
+         "ArchStdEvent": "UNALIGNED_ST_SPEC"
+    },
+    {
+         "ArchStdEvent": "UNALIGNED_LDST_SPEC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json =
b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json
new file mode 100644
index 000000000000..8bde029a62d5
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json
@@ -0,0 +1,7 @@
+[
+    {
+        "EventCode": "0x31",
+        "EventName": "REMOTE_ACCESS",
+        "BriefDescription": "Access to another socket in a multi-socket sy=
stem"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipeline.js=
on b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipeline.json
new file mode 100644
index 000000000000..010a647f9d02
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipeline.json
@@ -0,0 +1,14 @@
+[
+    {
+        "PublicDescription": "No operation issued because of the frontend.=
 The counter counts on any cycle when there are no fetched instructions ava=
ilable to dispatch.",
+        "EventCode": "0x23",
+        "EventName": "STALL_FRONTEND",
+        "BriefDescription": "No operation issued because of the frontend."
+    },
+    {
+        "PublicDescription": "No operation issued because of the backend. =
The counter counts on any cycle fetched instructions are not dispatched due=
 to resource constraints.",
+        "EventCode": "0x24",
+        "EventName": "STALL_BACKEND",
+        "BriefDescription": "No operation issued because of the backend."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-=
events/arch/arm64/mapfile.csv
index 927fcddcb4aa..0d609149b82a 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -16,6 +16,8 @@
 0x00000000420f1000,v1,arm/cortex-a53,core
 0x00000000410fd070,v1,arm/cortex-a57-a72,core
 0x00000000410fd080,v1,arm/cortex-a57-a72,core
+0x00000000410fd0b0,v1,arm/cortex-a76-n1,core
+0x00000000410fd0c0,v1,arm/cortex-a76-n1,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000480fd010,v1,hisilicon/hip08,core
--=20
2.23.0

