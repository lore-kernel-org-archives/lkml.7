Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EFFC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72662245F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FUSNdYsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfKTGrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 01:47:53 -0500
Received: from mail-eopbgr690072.outbound.protection.outlook.com ([40.107.69.72]:59646
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727127AbfKTGrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 01:47:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QH4X2ORUf3OPGkNVTW5dF/85np1QlXxJtJWSAnPFo/A5XxNRsDomrGwAjGN9vqBgZ0OCXESxP2eXvlyh86DBM8+rFLyIJpGqfXttbGdLkw8QZf7O/Cdwf+ehSpxCaJ29GLK7tecmAAAo7l2Fahy9JNJw15JpADAPte6HyBgBnXT5cqpRLwaTyxxReZln/0b87YGdXEiHA6IL0mXTGJDgZbp2Cy/2WecLI6lumlL+hZgy8z7Bu15bg31WiH/9U5Io8NBpdACWPH+VKDLNQcy+DNN8cqcOcKt0Vy4/EQAqD/YmN4Qmf4i5Q5taOfAvi5Sq2vEdERg4jHWRiLgV6dH+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzXvD+IcJGqNn9EqJ780uC5HVrfKOntSd7rWjYG8Csg=;
 b=T+U4chYTIsLvueoYBFWm2Q7SDUNC2T2ALoaoINtERyXlYYjtVbheradR8Uj+r7xzJyt8zStCyRtjlEPWGo4aQJNg0JdSHj/eFGbxaxYmuQsyi2IMgqdUO1HaZHQNGP9XbpqksTl84khe7+NdjZFnVHt7UL0kLakybbHDjFy2MwgK+OYltGlfiupVeBxZKVvdMGqlf9nBubTgYU2u6B7S/WYZiCtnG8WX/ebwD/eZoqsC24XWswe8F0fTkVpySEIqCAa330diEB7qh82su5etOxi8/qB++OqvQBAYP1IJ2VX/2lwLWtGEldsAIpGSGqqCJCOApV2wL6GJ1KfvTzRAuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzXvD+IcJGqNn9EqJ780uC5HVrfKOntSd7rWjYG8Csg=;
 b=FUSNdYscgdtD9jIV2xYsR4UvPjuH5xoMKkjBrNoPzWLMP5A3UKTWZ7DfSkePu6qe+nbUgJCUaJGURGaMPWwqmLjsu/ZvFKEIInU3Ianj/d3FLgMYI90greEfH+dmzaG0MZkCWPF7cKWBV5nwkdj5yh0KRpT27gXzop69NZiI+Y4=
Received: from BL0PR02CA0083.namprd02.prod.outlook.com (2603:10b6:208:51::24)
 by BYAPR02MB5879.namprd02.prod.outlook.com (2603:10b6:a03:121::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.30; Wed, 20 Nov
 2019 06:47:49 +0000
Received: from SN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BL0PR02CA0083.outlook.office365.com
 (2603:10b6:208:51::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16 via Frontend
 Transport; Wed, 20 Nov 2019 06:47:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT032.mail.protection.outlook.com (10.152.72.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Wed, 20 Nov 2019 06:47:48 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iXJmF-00061D-Vg; Tue, 19 Nov 2019 22:47:47 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iXJmA-00049o-S4; Tue, 19 Nov 2019 22:47:42 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAK6lapv027287;
        Tue, 19 Nov 2019 22:47:37 -0800
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1iXJm4-000491-KZ; Tue, 19 Nov 2019 22:47:36 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id D8E4512136F; Wed, 20 Nov 2019 12:17:35 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, rajan.vaja@xilinx.com,
        nava.manne@xilinx.com, mdf@kernel.org, manish.narani@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: [PATCH v6 2/8] dt-bindings: mmc: arasan: Update Documentation for the input clock
Date:   Wed, 20 Nov 2019 12:17:23 +0530
Message-Id: <1574232449-13570-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1574232449-13570-1-git-send-email-manish.narani@xilinx.com>
References: <1574232449-13570-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(6666004)(126002)(70586007)(70206006)(476003)(486006)(11346002)(446003)(2616005)(26005)(186003)(107886003)(478600001)(44832011)(106002)(6266002)(316002)(42186006)(16586007)(51416003)(47776003)(8676002)(103686004)(50466002)(36386004)(50226002)(81156014)(81166006)(2906002)(36756003)(426003)(4326008)(5660300002)(336012)(8936002)(356004)(305945005)(48376002)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5879;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d09fe77-a13f-4218-d4b6-08d76d858e89
X-MS-TrafficTypeDiagnostic: BYAPR02MB5879:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5879641A8668D7875B7328CEC14F0@BYAPR02MB5879.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02272225C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OVEl2p+SkjNppL63sHYH+mMupUubiKV+PkJNQzeWcs8+JEuolf+CAEt3j6RSvMNrb/VrnnC0fOwxJewxynfRiqJ1QsMEodJDH86hsWWKY8bzttiyoFFQ9sb3MvRq1smpu2vRAcrcPBm/LiHWT+dut9xcHLwhK77qwrvTFyfoHbRkBPfzEH6Nu3HNkODFvAHUNzR1HVboLEgZEbiIfZEq8l1wBq5xZWLUvmZhdKv736zlKSxgJXOqdciPjHLuCEFjJjDIvCzrW48n/VmwJ/fGKMzCyy1jdcmZDKeaP0sXhPqHUXZ8Tq1wFsmr676lhVxT3aEDvxoYheDKyT+2W2HzSquvcAY7l+/k+xSxId5HfrFLXKFPK7FSPsyXU0fCKj+O9raPXbznJyntYz+cz2miIonhlq6ZjH389mYPIeVTB2p6cGc/BJUv5sYMPdnvvXKg
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 06:47:48.4398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d09fe77-a13f-4218-d4b6-08d76d858e89
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5879
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for an optional input clock which is essentially used
in sampling the input data coming from the card.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

