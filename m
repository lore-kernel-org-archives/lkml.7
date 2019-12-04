Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8E4C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E9322464
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="YpiG2PrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfLDX3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 18:29:47 -0500
Received: from mail-eopbgr690073.outbound.protection.outlook.com ([40.107.69.73]:36750
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728060AbfLDX3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 18:29:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6pn1kCD8W2Ajt/yPDz8tWdbmz973yEvfoq9GpydAbcwUG6L4GLXd/d9wska0IoWo5ocHKoNVvUWfC/zrm/jCZvuqeXBS3saxYU6UBUh3sKl7xI3cNNGMN86yJRQqqj4zENyJamauK8RCoRRoQYt9+jj9cjV5Y5gjtueBOXM+WeBIwr3u19PHy8KTmOf1Dfb2t2EjOOsZ842Hd2pdagzUSKmeyGvF4qmA6Df2/Yxf/u16E8248TnEbulfhpM5XQpiNBmFCwjmqvHFjEFcw6fwY33CtPU6zuUDgjlmTBsli7YE6g2VWAdD9ijSRueqebtz4kSD5v3vl/PlDi1UoZZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PS1iBmLZ6KRIKxIxwTNBJnyVuN9IEZnmnGOV+WnukGc=;
 b=FnvOQUErkvOJef/1/Vvp9RHZbpaw4zvAIBi7hi9AWdNZAr5YLxJG8RiV0Fo8gHUqAI1KrIhTmbBW2Ac4PukVwwAXTeSjr230/5+DHyXbjJrG4MXUyi9tmZtcSRrtmO/GRdGqaazYribahu3Vytmkb3cGmPoQi/PR9tX79Boz43VwymA4IGOpmKGmy+jYCZG+nHbwJ1x/FiyYF0uLo3nNYWaVi1TEkAMgEUskC+ET4WHGoWCr5UsUWox327OmFI5NzZeJB0noET74SSv1brtvDS2ek/kD1KVegOuaS+OMcSOfE5NHDgXpFbgdd6s2fmqyvHuPGGxPobJ0/DbFTm5giw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PS1iBmLZ6KRIKxIxwTNBJnyVuN9IEZnmnGOV+WnukGc=;
 b=YpiG2PrP9N6z76CwVbx0YD5vxe6noWUzFSob6uL6VPA4uHeP5GV+8w8Fgw6mZ/L5Nw1kytcpWkzIYLN56hzyG39JY1/90hMPA+9/vUfXA6SulHlLCVHpLgRjjDBkcDFetXprjfd6vyHH+sE/utn2bskYc1dw396rCg+1k6YvK3Q=
Received: from BYAPR02CA0004.namprd02.prod.outlook.com (2603:10b6:a02:ee::17)
 by MWHPR02MB2495.namprd02.prod.outlook.com (2603:10b6:300:42::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.21; Wed, 4 Dec
 2019 23:29:37 +0000
Received: from BL2NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by BYAPR02CA0004.outlook.office365.com
 (2603:10b6:a02:ee::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.18 via Frontend
 Transport; Wed, 4 Dec 2019 23:29:36 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT042.mail.protection.outlook.com (10.152.76.193) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Wed, 4 Dec 2019 23:29:35 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ice5O-0005aE-V7; Wed, 04 Dec 2019 15:29:34 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ice5J-00080R-Rp; Wed, 04 Dec 2019 15:29:29 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xB4NTRV6024869;
        Wed, 4 Dec 2019 15:29:27 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ice5H-000802-Ig; Wed, 04 Dec 2019 15:29:27 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH 3/5] firmware: xilinx: Add system shutdown API interface
Date:   Wed,  4 Dec 2019 15:29:17 -0800
Message-Id: <1575502159-11327-4-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575502159-11327-1-git-send-email-jolly.shah@xilinx.com>
References: <1575502159-11327-1-git-send-email-jolly.shah@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(199004)(189003)(8936002)(9786002)(6636002)(316002)(186003)(44832011)(50226002)(36756003)(14444005)(2616005)(54906003)(81166006)(8676002)(81156014)(2906002)(11346002)(426003)(26005)(5660300002)(7696005)(76176011)(4326008)(478600001)(51416003)(36386004)(356004)(305945005)(6666004)(107886003)(48376002)(336012)(50466002)(7416002)(70206006)(16586007)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2495;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c35cdc5-b898-4751-36ca-08d77911d388
X-MS-TrafficTypeDiagnostic: MWHPR02MB2495:
X-Microsoft-Antispam-PRVS: <MWHPR02MB24955785C377EF5FFFA5606FB85D0@MWHPR02MB2495.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:556;
X-Forefront-PRVS: 0241D5F98C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IBkHnWl3G32cxnNKaASdx2/THmVzKXat5BZhQt+DBwhs0A2zPRV9ANQElvZqkOI+boFPRAc8lMmeI4Z2C77fVRaqm+L6QSCG7w8JUdjWZF09Z4tl16CPKfAgXTPh9owgQ6OF8Zp8QjyhzxQynhi9bph10/MxMYVnxgd/8up7nfD+bBOjhxAVXe++nm7GKCSar8+kV5bEDI4nDEp2uR9AotHrPUvjbo3YH3cvaEwo5V1IsVMUmmOn+qbdgDg8G39FAMXWq9vDneygU2dEobpSKlp6zGrlAz2BAVsPCcQez4UEirgUKZrOh7aVrHcsmW778oRGU/Ij/d5YGDpVscsUQ1CPPAiUMMiBFCMSLJcmpru5LLbbbxwDDy1r9ihGZYOITwo80S4FQBAxIeaPTVtL+xVFF3+PeBaBEBk98wxhpax1DoPZxJcNp/52VoXmiH2k
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 23:29:35.5700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c35cdc5-b898-4751-36ca-08d77911d388
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2495
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add system shutdown API interface which asks firmware to
perform system shutdown/restart.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 14 ++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  4 +++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 9836174..8dcf5a4 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -690,6 +690,19 @@ static int zynqmp_pm_config_reg_access(u32 register_access_id, u32 address,
 				   address, mask, value, out);
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
@@ -714,6 +727,7 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.fpga_load = zynqmp_pm_fpga_load,
 	.fpga_get_status = zynqmp_pm_fpga_get_status,
 	.register_access = zynqmp_pm_config_reg_access,
+	.system_shutdown = zynqmp_pm_system_shutdown,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index bf6e9db..b96ea5d 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -61,7 +61,8 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
-	PM_REQUEST_NODE = 13,
+	PM_SYSTEM_SHUTDOWN = 12,
+	PM_REQUEST_NODE,
 	PM_RELEASE_NODE,
 	PM_SET_REQUIREMENT,
 	PM_RESET_ASSERT = 17,
@@ -322,6 +323,7 @@ struct zynqmp_eemi_ops {
 			       const enum zynqmp_pm_request_ack ack);
 	int (*register_access)(u32 register_access_id, u32 address,
 			       u32 mask, u32 value, u32 *out);
+	int (*system_shutdown)(const u32 type, const u32 subtype);
 };
 
 int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
-- 
2.7.4

