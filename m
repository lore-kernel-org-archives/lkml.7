Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DE4CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA2E20874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UZ/sEe/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbfJ2KbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 06:31:11 -0400
Received: from mail-eopbgr760078.outbound.protection.outlook.com ([40.107.76.78]:45134
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727749AbfJ2KbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 06:31:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNIMjMvxDv3pVw0++MBLZ4S+qAGFToS3PQNvbNB0Y6ZS7bsOHK28Pzi0JUgQJUcuU/pjTbn2/jUeW0APKPFR/0itiZFFii0P7R4wo7HHMISPoNlf/Lvg0lhEkiWeoQkfZup/s7YEf45cjHQ4CBU5NdMY5RnBV+O3di/YUrIQs6krZLmyEKbbw4nmaYMV43+qQMTrYPrAuNvhCohI4bbpzQvlKpZsYglzRYAO2iRp3E/yAXN7sNsUpnmrHOADzvKmJfCSWWgqi6pTPKzAkEam5o6VAljTsQZdPXVVcbNd1pXH2qR/lE4sTSyLHjMd11SF5Alj0uu+vsnOT1IE5eUevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXoPYeaz6IJVGbGlZ6HkOSNYtTLoVxVYczxjp4u62TI=;
 b=LYEduMlQfm6GPArvrY55H5rRZ/f8LMOU609eUyZGO09wvzRjCwno9yotbOcY/SLnoZ7YyfL9uXiHVaALNyz7q9UjDaVxxLs94OA1oSGE3/AtsYZ3rBcztnmH4Casb9SfHqVk0uuzJ5uf3WMr+Zw9USwkdLqTv7qJIWscyWmjeia1Oe4bpzh53gxoJE0xZAVUV2bUeId/2dH1ww2bqHPuDSzLej841VTjpeBo4npwSxoH1bmpfR1O0BznPXrIjsSO/H6BaJ5jvtQAjx/flIGDE8hN1f4axqDYmBzRlt9ul4OLBXIPey1KL6TioAV75y1MBpYn+TOgUzPo8nhqU9j1aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=arm.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXoPYeaz6IJVGbGlZ6HkOSNYtTLoVxVYczxjp4u62TI=;
 b=UZ/sEe/EznKKGOEONI5/SDz12uhZObAMP+WTfEW8adowO8nzaK/yvQize4GVkrWzUyawIfUtG1+l8+yIH0ebHGy0TPwHiZQrq+3EYNOGSnx8ZNjTZiEp/yr0eH9OZvYspMEJAntiFtPVaxmIGJ8yHe1WSPWGctdW7O/ix+JXgU8=
Received: from MWHPR0201CA0020.namprd02.prod.outlook.com
 (2603:10b6:301:74::33) by BYAPR02MB4535.namprd02.prod.outlook.com
 (2603:10b6:a03:14::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Tue, 29 Oct
 2019 10:30:52 +0000
Received: from BL2NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by MWHPR0201CA0020.outlook.office365.com
 (2603:10b6:301:74::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.17 via Frontend
 Transport; Tue, 29 Oct 2019 10:30:52 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT027.mail.protection.outlook.com (10.152.77.160) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Tue, 29 Oct 2019 10:30:51 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iPOm3-0002t8-7S; Tue, 29 Oct 2019 03:30:51 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iPOly-0005lF-2a; Tue, 29 Oct 2019 03:30:46 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1iPOlx-0005kX-3W; Tue, 29 Oct 2019 03:30:45 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 61EB412172C; Tue, 29 Oct 2019 16:00:44 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, nava.manne@xilinx.com,
        rajan.vaja@xilinx.com, manish.narani@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: [PATCH v4 2/8] dt-bindings: mmc: arasan: Update Documentation for the input clock
Date:   Tue, 29 Oct 2019 16:00:36 +0530
Message-Id: <1572345042-101207-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1572345042-101207-1-git-send-email-manish.narani@xilinx.com>
References: <1572345042-101207-1-git-send-email-manish.narani@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(376002)(346002)(199004)(189003)(8676002)(42186006)(51416003)(316002)(70206006)(6666004)(16586007)(44832011)(486006)(107886003)(26005)(476003)(2906002)(8936002)(446003)(478600001)(103686004)(70586007)(76176011)(47776003)(2616005)(36386004)(5660300002)(11346002)(50466002)(126002)(4326008)(6266002)(36756003)(426003)(186003)(81166006)(356004)(106002)(336012)(305945005)(50226002)(48376002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4535;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40ee7ac4-c5da-45ec-0205-08d75c5b1294
X-MS-TrafficTypeDiagnostic: BYAPR02MB4535:
X-Microsoft-Antispam-PRVS: <BYAPR02MB45353EDDA21872490F2A79C3C1610@BYAPR02MB4535.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0205EDCD76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8+p3gC7pGngZR03pNds3uYg/SLdlV1WJ2hQ31YEnSB9kXW6LmAsW5712nyylVHVsnKTLax2M0GiyVFY4aJ3Fgk1hUnOgZHZqIaCkclIfzYt7f8zyqY8J4CECigWToEOCLMxrTepRoTRb9eODoyjBtVdC7N92bApGQ/WNJymWQVrz7/xn9m6WvGVYkKrJIv5NF9P5G2KCpKUShclT/FprX4CeR1Fa1HocjrcxI8Vwye6aE2YGGSWn1BOKIxXWVWWOHa1ZE/qXOVCkDmzvUTT3+VkfQIIrnfC7Qwlisvivpa5UncAzxV+L/KtQbi680kqfRJsT0WAYVj0vKMVnTHviOFPNuFRXVc1V7DvOSq7Y12oQ70YMqPTOAOqiyfSgqfGygz5V+69kK4M08CAFcQnsonBSIYeK+MBJEvdR6MoveLk0+rWihjjOhIAU6QPEfuCu
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2019 10:30:51.7942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ee7ac4-c5da-45ec-0205-08d75c5b1294
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4535
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for an optional input clock which is essentially used
in sampling the input data coming from the card.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 7ca0aa7ccc0b..b51e40b2e0c5 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -38,9 +38,9 @@ Optional Properties:
   - clock-output-names: If specified, this will be the name of the card clock
     which will be exposed by this device.  Required if #clock-cells is
     specified.
-  - #clock-cells: If specified this should be the value <0>.  With this property
-    in place we will export a clock representing the Card Clock.  This clock
-    is expected to be consumed by our PHY.  You must also specify
+  - #clock-cells: If specified this should be the value <0> or <1>. With this
+    property in place we will export one or two clocks representing the Card
+    Clock. These clocks are expected to be consumed by our PHY.
   - xlnx,fails-without-test-cd: when present, the controller doesn't work when
     the CD line is not connected properly, and the line is not connected
     properly. Test mode can be used to force the controller to function.
-- 
2.17.1

