Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACF5C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC212054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PZf7U885"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407829AbfJQGWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 02:22:35 -0400
Received: from mail-eopbgr820053.outbound.protection.outlook.com ([40.107.82.53]:21088
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437783AbfJQGWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 02:22:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzUHt1ZWPPGI3Nil7wmLO2bzqN+uRalRAluOw01DOH+2d+14TDOfq71hdY8xdhlm3lzeciZw96hluixDUM24BgrK8tPcHMzA79tCHtk12e/QeOUex1wV06i1XazgWfaNLMY5crKz2IqMPo9JQlNeE2QkEKcw8DSQMANoHX7KIfocqyb0dR7xWNSOqZgz7GxsXjkaAZEyZIRt8TfkIguH3URy8FwX5owyyJ1Fh4pvWU3xKzk0bdS44IRqFnszMXwZ6uG9hOR5G8nx+3QE6nKMJH8ypPo6satyZsYKv1RhVkAo2C7oyLLQGCu95/rN38zVlXiyJYkvYFtq1P2bxxSSLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Elx1S6x5O1qEFyNTFHBUXfMn9vSEuSXCQ8O8cIrSquA=;
 b=iqzDK438UfuD0lID0oMXDI73l+hBheTT9zHnOp+Jc2EafXj1nSQi6kw3fRQkaOvrYr5LdGibcFHu23uJywShbHW6L9TKCQkRVsTIj5HucQ18TlTIKV9lAKj8AiXd2RlDnBQFEPAPVg4g5YAaL8h2WMdh844W2p5N2JQPYfOTmT5/lKt6yW5EYBmwYmT8WqUNSwmHkvKNEAMmF63i5H3Yq2E/1ddQEYdMrIWgE3rJFDKnFLx8YlvifeB8M56JNGyJ2bk2HEuikDeW9riI9l1J502F05Gzp5WcRp6b2FK+EfPMxhy3FFq+2jFX6QFlqAwe26GPYS7xF+Jqs6Kcze8P2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=arm.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Elx1S6x5O1qEFyNTFHBUXfMn9vSEuSXCQ8O8cIrSquA=;
 b=PZf7U885PKCJW7saSIJovumcl8aZQhyWJh+pg2cc9NaX82Xpb5Pvuvbec8kpriRMJKgnR3lj3ZBxGRJTT93baD1s305jRTwr+yyuWSvjVY7xu3bm4OzeQV5yTRvNQpY+Uj6x93X5W+hmxmqTjSfGjVYHtRSk9CNSD2pwY2iCulA=
Received: from SN4PR0201CA0065.namprd02.prod.outlook.com
 (2603:10b6:803:20::27) by BYAPR02MB5158.namprd02.prod.outlook.com
 (2603:10b6:a03:6c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.21; Thu, 17 Oct
 2019 06:22:15 +0000
Received: from BL2NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by SN4PR0201CA0065.outlook.office365.com
 (2603:10b6:803:20::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.17 via Frontend
 Transport; Thu, 17 Oct 2019 06:22:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT006.mail.protection.outlook.com (10.152.76.239) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Thu, 17 Oct 2019 06:22:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iKzAs-0004bT-7I; Wed, 16 Oct 2019 23:22:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iKzAn-0003mX-4C; Wed, 16 Oct 2019 23:22:09 -0700
Received: from [172.23.64.104] (helo=xhdvnc123.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1iKzAe-0003f5-27; Wed, 16 Oct 2019 23:22:00 -0700
Received: by xhdvnc123.xilinx.com (Postfix, from userid 16987)
        id B2DD543A9A; Thu, 17 Oct 2019 11:51:59 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, rajan.vaja@xilinx.com,
        nava.manne@xilinx.com, mdf@kernel.org, manish.narani@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: [PATCH v3 6/8] firmware: xilinx: Add SDIO Tap Delay nodes
Date:   Thu, 17 Oct 2019 11:51:48 +0530
Message-Id: <1571293310-92563-7-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1571293310-92563-1-git-send-email-manish.narani@xilinx.com>
References: <1571293310-92563-1-git-send-email-manish.narani@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(199004)(189003)(36386004)(8676002)(81156014)(478600001)(8936002)(16586007)(6266002)(42186006)(2906002)(81166006)(316002)(50466002)(36756003)(4326008)(106002)(107886003)(48376002)(50226002)(356004)(6666004)(51416003)(47776003)(70206006)(14444005)(70586007)(186003)(486006)(476003)(4744005)(426003)(126002)(11346002)(336012)(2616005)(446003)(76176011)(103686004)(26005)(5660300002)(305945005)(44832011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5158;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccdee2b5-54f6-445f-5913-08d752ca5a6a
X-MS-TrafficTypeDiagnostic: BYAPR02MB5158:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5158DBCD5C9919DB9B86B6E3C16D0@BYAPR02MB5158.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-Forefront-PRVS: 01930B2BA8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tUJcyX0WMhrg11zyu79hI4Q4nvsfCTrY4vfkR38tu6ih45jmBXlBrkIZCcdCjR2TaOsPyCihQ8I0WC0LpEP2cmxc1Au5eXoc009mXUUKH51NsPbLW/GDyMQSYrF8Sv3N1l67bjRXLt+qwER3D30ndccoQY7RrhaGWhq+XqQJ4Mdhqljau9pxv4E6C4lWqg0eKyF/MQZuh6VyZsq3c0ds53US4mYDJa2aATbxIr4SC/Q+3C3kDn6lzafH5fpztG5SvwWbXtBdDSdkFdGprtkPNRYIBmbQGTs1tXaVgClf1UCuAJOwQjKV/53yss4rcYF8a/gjywPI6PzrVmlx7JgLGaqLzU6IgfwqQvZhBFcHKgZSdql3Vs3Nhg3Mm2M19/IAGHcYFU7CNzwFj7mNUIVGquytBjrIgrANU0gnHRZYTt8=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2019 06:22:14.8263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccdee2b5-54f6-445f-5913-08d752ca5a6a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5158
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

