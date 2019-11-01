Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3775BCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 06:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06200208CB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 06:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lje32X09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbfKAGG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 02:06:57 -0400
Received: from mail-eopbgr720058.outbound.protection.outlook.com ([40.107.72.58]:13554
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729787AbfKAGG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 02:06:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwEMGhosXuDDdgGvh3iDWfdzvQsiVYfNeBio/2rvIK5QnLId28tlgkbJ75djaj54Y7wuoARJwxrGdvVQVREJ5NakMZRprYWNvIvTgee82PO5zooYDdEYrHk13IwmyJnTTOj32YfcxFqu6ormS6gXEwXoah+c9QXzwW6V0sdLyrYXTTSCzIKjyN2LDe9m/pPbmTMIXa1sD4jdEL6aPA79ga0r/oBcnoDC3bV4Z86C5vqwWFY+7+GSGEI3qqGl8zVmHnlGvCJ8lsLT0p/TETDyuBk6AsOHWQPbxvvgL2U3QGHPfNGcnt7apKuDQ1xIYPI6jJYDcFi25KgZPZ5sFR+CMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Elx1S6x5O1qEFyNTFHBUXfMn9vSEuSXCQ8O8cIrSquA=;
 b=kMhavVKrWkdziizkO/DoU2ClnLEJpq3TA4wuHLNUz3uwrq9K1oz8iLmUN7f9murx7HEhhkdsRvtsFnZYLSDTQ/94TRZft+YlABCu2z6EnLLTlDz0JD2sfO2YdR6DML1Sh8VWxpru7iDyYUYcXqwoh+fJcs3cpZoNgQhEfO1NEpI6RlNKjFVmDWn4tsswx2xL5kWx1qZnXlIIzI7xceR03pxN9x61A6qURwX12GNc48caziswU1HJODHJCosYrHPIgoJU9s2vd2vNm2ccuuqpsBElJS1PXxF4C+SLdcmUG83eTHXV8aNFykc6Vr2iPf1EmWlyvtzkX4b50wB63VO+sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Elx1S6x5O1qEFyNTFHBUXfMn9vSEuSXCQ8O8cIrSquA=;
 b=lje32X09WbXf0/XxeLf2Ll/KtwVKt9ghnkSh08ccQPkTresYYUb8AvXyELeCkG/s2f54gRhwuT526gSc/JbZQyCbOKs88zuZTBI0aiFvMkwNz2IHH6PjXmCw1PJhSiDooC2Lmde9izvnvWuFSuSTCZ4CXTivm5dWHQcLYFlbzSQ=
Received: from BN7PR02CA0020.namprd02.prod.outlook.com (2603:10b6:408:20::33)
 by BN6PR02MB2771.namprd02.prod.outlook.com (2603:10b6:404:fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Fri, 1 Nov
 2019 06:06:10 +0000
Received: from BL2NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by BN7PR02CA0020.outlook.office365.com
 (2603:10b6:408:20::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.20 via Frontend
 Transport; Fri, 1 Nov 2019 06:06:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT008.mail.protection.outlook.com (10.152.76.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Fri, 1 Nov 2019 06:06:10 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iQQ4X-0005mY-QW; Thu, 31 Oct 2019 23:06:09 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iQQ4S-0007dN-M3; Thu, 31 Oct 2019 23:06:04 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xA165x4Q010457;
        Thu, 31 Oct 2019 23:05:59 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1iQQ4M-0007aM-Pn; Thu, 31 Oct 2019 23:05:59 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 086AA121387; Fri,  1 Nov 2019 11:35:57 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, nava.manne@xilinx.com,
        rajan.vaja@xilinx.com, manish.narani@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: [PATCH v5 6/8] firmware: xilinx: Add SDIO Tap Delay nodes
Date:   Fri,  1 Nov 2019 11:35:51 +0530
Message-Id: <1572588353-110682-7-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1572588353-110682-1-git-send-email-manish.narani@xilinx.com>
References: <1572588353-110682-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39850400004)(346002)(136003)(396003)(189003)(199004)(51416003)(16586007)(478600001)(2616005)(5660300002)(14444005)(6666004)(356004)(107886003)(186003)(4326008)(48376002)(47776003)(42186006)(70206006)(316002)(2906002)(11346002)(36756003)(70586007)(50466002)(446003)(6266002)(4744005)(476003)(76176011)(36386004)(126002)(26005)(50226002)(103686004)(8676002)(106002)(305945005)(486006)(426003)(336012)(44832011)(8936002)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2771;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69521a8c-f199-42b6-2653-08d75e9197c9
X-MS-TrafficTypeDiagnostic: BN6PR02MB2771:
X-Microsoft-Antispam-PRVS: <BN6PR02MB2771AECA5529C3A83BB20641C1620@BN6PR02MB2771.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-Forefront-PRVS: 020877E0CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wrs7xNPy3dVbAwSJpBfqJBimh22qK+eSWAkTJbzvnBPp+vufrJW0bNCbT0QR0bZ3JxswYCVcdPPqoYFgyPxA1Ic0K24s4z76R3Ce3hQE7SLfKh60meVg8Y1tI0Ma8gx1TWq8aL+3rua/7GEHcTZTREWAS89v2M2fQR8uYKhtGT7N+uOd7o9itEbA/RlqoVnVdTeIb0okUT/2/0UNW2sWQCSQnTyp7ZnGl1Ghd+8j53+ZNp5EwyIIU9qRwBX0JfhidRjiVtNaLIRO2kLBexBlODpCFVCIC6ssagAt8BWOq/iIsQTUkoiCfQ4by1SCYE6kQ/MocnCG2/VFcQYYy7snKdF6Ek4Bq1l8qRDcAt0li6excsrOqUwGBAKyVfrb0bpmm4UhUJ4Qcln0loGS6mZeEnxc2OJUDiIvyvnwjMP2HOh6MRWu0zyNmaT2nIujKfit
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 06:06:10.4204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69521a8c-f199-42b6-2653-08d75e9197c9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2771
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

