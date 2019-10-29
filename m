Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A86CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E487920874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Nf48ZToK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbfJ2KbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 06:31:08 -0400
Received: from mail-eopbgr770075.outbound.protection.outlook.com ([40.107.77.75]:28160
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730552AbfJ2KbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 06:31:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWfyxJHqNXmJ9riQn+IR/KY57868pHuYs1C2CUOjTTRTFWTt9fDbpBsa8P4BCjL4LCUufFUtZTCDPt8KN/MyDXt3l2kz4KnUhHN9ZFn3VzzHhuNirXBwLZyvo1xgSFtwei5iAwIO1rbluRyjeXkFZh9K/BDfvOSc8zBkxnM8IJMZ3NbwMYbk8l5UfFdILc+vikpmY3GfPCc1iQCY8gHvN0iPfYf/YuYXvyzlHfO92YpGrlEvOuncHui4VLQk6BLb58TGAaeaRh576D3Xja1QFzuCwTtdQL3a0nSkqly3GvbxcVS/FKA3PP4DKfEZSKUNP2/ppy3yvT2JzP+oNYMciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Elx1S6x5O1qEFyNTFHBUXfMn9vSEuSXCQ8O8cIrSquA=;
 b=TviGtwT4LQx5bY6XNE9+M3gm9R2zLz7lcIKg0ASU6AGz5U/F0hWLfobAY+YtqWgYgb+QX+vE9UjqDfBAekKaqgoZWX25tlDUv4d5oa9wCV9kNSLc8jb2NwHYXeoaH3qm4FTcK5bPZSBlcb3LkICYC5PpoOHhsWp39lqeXYwDGtulHA5hnjjmo01QQxHMI+GS7bsC4vLuDH9HpR2DnqMCTLNot5MR+ZUCjpAKE846hTssTG3+58oZ6v2vqOSisyBMnFu7riElNsyOr9HszOR1kER/qZ89jRv8kWB6sqU8oCSqeXEAY9T0z7Xsval+e/jelH63whD2pmihj7JHT7awNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=arm.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Elx1S6x5O1qEFyNTFHBUXfMn9vSEuSXCQ8O8cIrSquA=;
 b=Nf48ZToKjoEEQhEj23JxF1s6U3sU1+/ovzndyxBAbNoSdhE+6K5WKsLeC7Vuo4AZd53VQ913kbK6T67I4hVQc6xlLgWYaJTRuumdmTKo5map8bO8us5m0L741rjhkRkld3cfWKp8Fn7kgdPfWEgZ5754/RpT419QCLG0sqWAJ8M=
Received: from MWHPR0201CA0069.namprd02.prod.outlook.com
 (2603:10b6:301:73::46) by DM6PR02MB7018.namprd02.prod.outlook.com
 (2603:10b6:5:259::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.22; Tue, 29 Oct
 2019 10:31:03 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by MWHPR0201CA0069.outlook.office365.com
 (2603:10b6:301:73::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.22 via Frontend
 Transport; Tue, 29 Oct 2019 10:31:03 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT055.mail.protection.outlook.com (10.152.77.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Tue, 29 Oct 2019 10:31:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iPOmD-0002u1-RU; Tue, 29 Oct 2019 03:31:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iPOm8-0005qH-MS; Tue, 29 Oct 2019 03:30:56 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1iPOly-0005lB-6u; Tue, 29 Oct 2019 03:30:46 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 7A3A71217EE; Tue, 29 Oct 2019 16:00:44 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, nava.manne@xilinx.com,
        rajan.vaja@xilinx.com, manish.narani@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: [PATCH v4 6/8] firmware: xilinx: Add SDIO Tap Delay nodes
Date:   Tue, 29 Oct 2019 16:00:40 +0530
Message-Id: <1572345042-101207-6-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1572345042-101207-1-git-send-email-manish.narani@xilinx.com>
References: <1572345042-101207-1-git-send-email-manish.narani@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(136003)(189003)(199004)(426003)(2906002)(336012)(486006)(44832011)(126002)(446003)(476003)(48376002)(8676002)(81156014)(50466002)(2616005)(11346002)(305945005)(14444005)(8936002)(81166006)(50226002)(70586007)(42186006)(186003)(26005)(16586007)(51416003)(316002)(76176011)(70206006)(356004)(36386004)(6266002)(36756003)(47776003)(4326008)(107886003)(478600001)(106002)(103686004)(5660300002)(4744005)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB7018;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70136ae7-263c-453f-358b-08d75c5b18fb
X-MS-TrafficTypeDiagnostic: DM6PR02MB7018:
X-Microsoft-Antispam-PRVS: <DM6PR02MB7018118B1BD8AB80DB046922C1610@DM6PR02MB7018.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-Forefront-PRVS: 0205EDCD76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AP4VSPwMpl4mS/usozBkMCs8QCZg49CgsvHAz36wZxM7DdiSwbK9KN4FR033/IvbVozGmFH5JXSs5jrhMD0S8rKyqMNGuyO+sQtXscy9sxFmfbBSwWmKxIFeEz+K6yTHdIK1dM2KsKNdRwcxNd2RRwD8JhJ32l+5sXHDxN8I5791Jp1EiU+q/pZI2Su7wZP8SvIqjM77IyARtCdsJduVyPzwH0BjOY9nN+oKdM5VJ+IgzX9TxzcGeBuoDMggl7cjDHyzSIGLRXw0sveAa/B5G5RPNxs+PTORyT+HkU2D3q/d+ii1yQh5/nFrATfAXPfhvfYWbEqRyVbFPOQ5xv/rkb3+//4wxb1dqhcGIv/htPbq/IltSqUcL3hfIzCGrT+4x1v9mxiBnbm/ZYW9DkVRfAbRHCtPDOgn4M9BlpAxIId8cPJfVbTtmkSgkO6uYv4y
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2019 10:31:02.5368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70136ae7-263c-453f-358b-08d75c5b18fb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tap delay nodes for setting SDIO Tap Delays on ZynqMP platform.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 include/linux/firmware/xlnx-zynqmp.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 778abbbc7d94..df366f1a4cb4 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -91,7 +91,8 @@ enum pm_ret_status {
 };
 
 enum pm_ioctl_id {
-	IOCTL_SET_PLL_FRAC_MODE = 8,
+	IOCTL_SET_SD_TAPDELAY = 7,
+	IOCTL_SET_PLL_FRAC_MODE,
 	IOCTL_GET_PLL_FRAC_MODE,
 	IOCTL_SET_PLL_FRAC_DATA,
 	IOCTL_GET_PLL_FRAC_DATA,
@@ -250,6 +251,16 @@ enum zynqmp_pm_request_ack {
 	ZYNQMP_PM_REQUEST_ACK_NON_BLOCKING,
 };
 
+enum pm_node_id {
+	NODE_SD_0 = 39,
+	NODE_SD_1,
+};
+
+enum tap_delay_type {
+	PM_TAPDELAY_INPUT = 0,
+	PM_TAPDELAY_OUTPUT,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
-- 
2.17.1

