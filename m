Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D15C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F14D2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Lo1cA5wp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388702AbgAITGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:06:24 -0500
Received: from mail-dm6nam10on2062.outbound.protection.outlook.com ([40.107.93.62]:58209
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732181AbgAITGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:06:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6U9ELEC5aFr6wvKPmpGSs1wqoM0OSLMfKHfxMtV5B7VJn7oYlPTBEURh6+poNnvEfE9voX6Wcmk+Cy+0kNeCeJAq+3NQ2cyHe6ozO8wNtRp9ckWuxjHzW+xZGVTvwj4dlGAYACveUpYW4ezgZ4IESbzoBT+IWxv4RbYIufXSxSOeWfmzub5LWyOMejSByIzMQZhAV3t9IAyVnD/VpS344E8PzKbHYMXeMI8BBgWtmHhx3mAAhyahUlAnt1Rgf9OWbpKh377WVzWxxsYsOLqsiYmC6UntrA8eN4/MyIty8RBuxRKU5otCJw71G89k+lkVxF1TzJhH2I2tzSaa6LU3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMDdQ8+Nc8MgOXTmxR1X2vgeiyXkI3PjbiyrRO5yEpQ=;
 b=OGHQFSi448NJHPFvKlR9fWcAjSGkJRBNNk5P5xVFffnp71dUdLOZE77veYFtGCYurknboW2IEo1IeAab8PnkwF7vWjpTuufcS2uyWWTU6mULcT930E+3qeCGuAeE9fYvxcEp25BntLVU62BPCBMDvMENYG7BuvOt6ke+B69SxyQB/YYmzyOsk8vXrmN5dIXtHrSaGod5DN5f4H6rKgVZeILQss/cEONkXcyAzIZkbRBZiTDq4xU3cdu4d5M4jjBfEkiF0w45mYueLoGCmpbNyQIQVh+wPQHFlvhC631ghLMuIG6aNE78DAvHlyxT1qWYkiiG6ArnNbzDTj0B96T/Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMDdQ8+Nc8MgOXTmxR1X2vgeiyXkI3PjbiyrRO5yEpQ=;
 b=Lo1cA5wpNJw8VSFaNsZ35jTvd667n7I1xSZm8vvLcwZ2gsE+rzEw2JlNDxo1yFblwW7r5Iqdlu1x4xzqpdsZWLsqY5h3uWyWc+gu/diBIt0saADDIfoqrZ3clUjYlbqxNFWdrWnOZbz1TeDC7/ZYoIm9Mx+TUWttngeVCEV48ys=
Received: from SN4PR0201CA0031.namprd02.prod.outlook.com
 (2603:10b6:803:2e::17) by MWHPR02MB2653.namprd02.prod.outlook.com
 (2603:10b6:300:42::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.13; Thu, 9 Jan
 2020 19:06:21 +0000
Received: from BL2NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by SN4PR0201CA0031.outlook.office365.com
 (2603:10b6:803:2e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend
 Transport; Thu, 9 Jan 2020 19:06:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT011.mail.protection.outlook.com (10.152.77.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2623.9
 via Frontend Transport; Thu, 9 Jan 2020 19:06:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ipd8O-0008O5-2J; Thu, 09 Jan 2020 11:06:20 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ipd8I-00030t-V9; Thu, 09 Jan 2020 11:06:15 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 009J67vu029182;
        Thu, 9 Jan 2020 11:06:07 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ipd8A-0002yD-V2; Thu, 09 Jan 2020 11:06:07 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH 1/2] include: linux: firmware: Correct config dependency of zynqmp_eemi_ops
Date:   Thu,  9 Jan 2020 11:06:03 -0800
Message-Id: <1578596764-29351-2-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578596764-29351-1-git-send-email-jolly.shah@xilinx.com>
References: <1578596764-29351-1-git-send-email-jolly.shah@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(396003)(199004)(189003)(107886003)(7416002)(8936002)(26005)(5660300002)(4326008)(478600001)(4744005)(70586007)(70206006)(316002)(36756003)(44832011)(7696005)(336012)(9786002)(2616005)(6636002)(2906002)(426003)(81166006)(8676002)(81156014)(186003)(6666004)(356004)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2653;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07ec5e2f-2b5a-4f1e-04b8-08d79537035a
X-MS-TrafficTypeDiagnostic: MWHPR02MB2653:
X-Microsoft-Antispam-PRVS: <MWHPR02MB265332DA715448B4874B53DEB8390@MWHPR02MB2653.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:422;
X-Forefront-PRVS: 02778BF158
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i+Z3dQO2tTZMEud5IKhgn4v+IRcftkkWzSZS18V89E0KBaQ5AZE5KnSfv9kFHytfPeCjTFxYENwYPz7JWBuryBPQB2HOfNApzLT64Edr212yAQ8MoNGKDhGrq0jo7we3OyJmJbv1g90znJMjRxKypieaqJS3hhUv5FdmDlSg95hdsa8hUvblnDMCJ4JL1x3HeMbrS07zbsTn4X+dSWDt1weRR3X9ss7t0xSz7XeBrewtgftKRqTyrtritGm8Chy/AEXs5tkEnYbe/4b2RqhsNesxN8jAnVxtp/HCjf6pet+u2F5hcmq1Rm/PQ/2X9qQPR7DjuyUas3maQk44L1omZYWGortR9D8lkCgGTVY79QWblFqfnk85kvMnDwgq6+QvGBDT4aHPRnyuSUA0rL/tC9NqVcuHnbRz684VdZWQr5Iqdrn21OlilvmdObncRFyN
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 19:06:20.6404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ec5e2f-2b5a-4f1e-04b8-08d79537035a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2653
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejas Patel <tejas.patel@xilinx.com>

zynqmp_eemi_ops will be compiled only when CONFIG_ZYNQMP_FIRMWARE is
enabled. So check for CONFIG_ZYNQMP_FIRMWARE instead of checking for
CONFIG_ARCH_ZYNQMP.

Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 include/linux/firmware/xlnx-zynqmp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index e41ad9e..a50a30b 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -311,7 +311,7 @@ struct zynqmp_eemi_ops {
 int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 			u32 arg2, u32 arg3, u32 *ret_payload);
 
-#if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
+#if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
 const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
-- 
2.7.4

