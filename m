Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D997DC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 23:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A235020720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 23:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="LN/AKvLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbgAHXza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 18:55:30 -0500
Received: from mail-eopbgr760072.outbound.protection.outlook.com ([40.107.76.72]:36928
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726930AbgAHXza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 18:55:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyzF0As19f+5T0qlXfcUZwxYrNE2FG78eoZDQt+gDloinV9efBoyUMEx1a+iKGVjxig2/LXk1aKTJIdCIArJPRxDe43bGE3gtO9+BZD1fe1SCNbJlT5rxqJtIC6bKz1jJl2kreEpUL4hx71C/PwD/CisJPvezg3OqPD9uENwRyDYZL61LLe2p2aNBxEdu2pv0Yhzrbx9vJfN3lgPwBxV2+Qp1rLPB3gEdlnN/9DXLnahW3Fg6M5EYAj7HIOUDCtNhWmdGrhjOlFFWqwJvwGXkMwmMmGEUVCrlWzCDL3pD3kSoiAc/y22mjqW7act7OCsDaIfHzGJFu4MTXcNP1VKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ1oMz9Yd1FhsQB2SzC6dQsxsGM6koBg2IizX+ZpOJI=;
 b=Q/l9qgX7dHuxvnPhQQaRbMct0pMMkNGczUIdr1bIZ49UZkUUqZ5iThd53y0e6d2B1lvnnnGONXX7EHC/Raksa6qpeTQ2kh286el7qLi2mPz16hLlP9V1JrDRRrgvL2FbdDFMyJNTOGhgJT75gWgPMdYfceS7IAuUwIkz52xm59Lpp30Dt7SQAuVM6T+tcC2j6M6Z20lLhHy0EDVO6yaF3Z2PAwlgSPP0LtbE5DBlG1x7sd8F+do+3qXEt/kAe6CStY+Omd1mVxkoIT7kKJaeIzJbkRH+MeH07BYHtWAvljCJJsAv8+VFUA/ikeVBLgjb+OZpVGVbCG4tbcj5jEIEBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ1oMz9Yd1FhsQB2SzC6dQsxsGM6koBg2IizX+ZpOJI=;
 b=LN/AKvLgtBtIp/BfVLSha29l9mYlghXowSJawhi0CUD3AriuTGOPmxXcNuOl+DnINKSnnPZrzvyPE+JTB4psjU95BI3sluMOFIl6ZCW1aNzN81HGowL1Dpu4r/Ka4wV3hrku4bsj+Px3Wq1qzqcJd5eg3pb8MMZjAwWao3EAj38=
Received: from BN7PR02CA0020.namprd02.prod.outlook.com (2603:10b6:408:20::33)
 by DM5PR02MB2489.namprd02.prod.outlook.com (2603:10b6:3:47::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9; Wed, 8 Jan
 2020 23:54:47 +0000
Received: from SN1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by BN7PR02CA0020.outlook.office365.com
 (2603:10b6:408:20::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend
 Transport; Wed, 8 Jan 2020 23:54:47 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT011.mail.protection.outlook.com (10.152.72.82) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2623.9
 via Frontend Transport; Wed, 8 Jan 2020 23:54:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ipL9z-0003pu-03; Wed, 08 Jan 2020 15:54:47 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ipL9t-0002BN-SE; Wed, 08 Jan 2020 15:54:41 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ipL9l-0002A4-L4; Wed, 08 Jan 2020 15:54:33 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v2 2/4] firmware: xilinx: Add system shutdown API interface
Date:   Wed,  8 Jan 2020 15:54:21 -0800
Message-Id: <1578527663-10243-3-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578527663-10243-1-git-send-email-jolly.shah@xilinx.com>
References: <1578527663-10243-1-git-send-email-jolly.shah@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(39860400002)(189003)(199004)(426003)(356004)(336012)(44832011)(36756003)(186003)(81156014)(26005)(7416002)(6666004)(54906003)(7696005)(2616005)(316002)(5660300002)(107886003)(8936002)(8676002)(4326008)(6636002)(81166006)(9786002)(70586007)(70206006)(2906002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2489;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5035743-d7a5-4d62-be93-08d794962485
X-MS-TrafficTypeDiagnostic: DM5PR02MB2489:
X-Microsoft-Antispam-PRVS: <DM5PR02MB24890B76E1F53C64A750D72CB83E0@DM5PR02MB2489.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:556;
X-Forefront-PRVS: 02760F0D1C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: av4E1OozbFgyZmkWgzmzLNkhknZbzNgCJn3K7bLrWT4hDMrFiAy3Ax+M3DiTxkHAkk5zfaSjaEIqD1rahND6WJBSFlKH+ZyFipkJY/3iNS4ccseZ1KL3gOcxOikSlL6L8XMiN0KoadVCGhIuqjwDJ+7uo1xPt6dHRw1kyKnsfD3z+dg/7q624av7cibFkMGOYIYtsmFyWHf96Y7lV1hlMNVNDR34Yn8Uh0qH3L4Ywn08NvsLzHiz103k7jxfGQZoapOoA0w7ir0IOyqWla92GM8NySgezl/RKExDwkoz7lvJ+UeDE9YMjo4qdyHuUjU1+6VTThCb7qQobhByelmgMDv/bovG+t2fSICPiDpgkmzeEUiNdemR+yoT7OrarNwAFsgaMOrT0hHa1ksen8NOi64/rcsCcPRdzCWJrBnmmuyIuNWZGx8k46sWwpt0WERX
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 23:54:47.3833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5035743-d7a5-4d62-be93-08d794962485
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2489
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add system shutdown API interface which asks firmware to
perform system shutdown/restart.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
Changes in v2:
 - Updated Signed-off-by sequence.
---
 drivers/firmware/xilinx/zynqmp.c     | 14 ++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  4 +++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 4c1117d..0f90793 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -668,6 +668,19 @@ static int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
 				   qos, ack, NULL);
 }
 
+/**
+ * zynqmp_pm_system_shutdown - PM call to request a system shutdown or restart
+ * @type:	Shutdown or restart? 0 for shutdown, 1 for restart
+ * @subtype:	Specifies which system should be restarted or shut down
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
+{
+	return zynqmp_pm_invoke_fn(PM_SYSTEM_SHUTDOWN, type, subtype,
+				   0, 0, NULL);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.get_chipid = zynqmp_pm_get_chipid,
@@ -691,6 +704,7 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.set_requirement = zynqmp_pm_set_requirement,
 	.fpga_load = zynqmp_pm_fpga_load,
 	.fpga_get_status = zynqmp_pm_fpga_get_status,
+	.system_shutdown = zynqmp_pm_system_shutdown,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 534814e..1fd246c 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -62,7 +62,8 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
-	PM_REQUEST_NODE = 13,
+	PM_SYSTEM_SHUTDOWN = 12,
+	PM_REQUEST_NODE,
 	PM_RELEASE_NODE,
 	PM_SET_REQUIREMENT,
 	PM_RESET_ASSERT = 17,
@@ -314,6 +315,7 @@ struct zynqmp_eemi_ops {
 			       const u32 capabilities,
 			       const u32 qos,
 			       const enum zynqmp_pm_request_ack ack);
+	int (*system_shutdown)(const u32 type, const u32 subtype);
 };
 
 int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
-- 
2.7.4

