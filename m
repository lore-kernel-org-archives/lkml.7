Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB12C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 11:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5653E20675
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 11:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="m89yAshI";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="CxnaxqB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfLEL6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 06:58:18 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:3312 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729044AbfLEL6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 06:58:17 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB5BvCe5003677;
        Thu, 5 Dec 2019 03:57:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=+P2pjfMbXfv2lzRu+cMsZFcYWTtyxCboQYnCl4ghDSs=;
 b=m89yAshIVxsEu9xiF9ggyEZuxEINkmxYwp1EIQrA8HBtS7NZw0Yq4nG3QRKq3ZYgEeox
 +CUG2S3BM1VRFp3aKDxxv28307Ryz9uox//lkTVZxRjtVKfbsbznwmNtSGp4NHbXYLRF
 +imsN0iQNlclj08Z1GeQEzptFILKPIYTpdMQU3XZnrx2FsKpDUhfFbMDdVV3HphgyZQq
 QfSW69Cheoh+tn7Pgs647eicWkdnUg2wF48nCylcjAF5rggBIkpJnYc5+XWDLch63vs+
 3Oo427uXnaaSMb8gqxxqopdUWWTt9dNt7ujCaIr0OMiS7VASYaBpY4UR3hCcFZvBqqWY SA== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2055.outbound.protection.outlook.com [104.47.46.55])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2wknv15qbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Dec 2019 03:57:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W07y/+Z5FXtEL/eNdVnrYAxLUlL1wqsB/U9AKedhIIERrNTn6hFhLMf4mgN+qj+wFcYaSgsnXM/k/n+QFF+zx8hyRAwmQA6SXgqDcRsCvKM0Xy9WVWGD64uPwnv8JbmK0ZqWuDjVqHS1QbLzr+x6I8YJKluWgSvrhwb2VlQ+5fCg9yKoG6ZHQ3efdQLONeq67ZZIKLwoNtDyyk60+P0WlgW8oGQureFwRfeTVJSJ9h8PRviChS0x9R61zXR+LOcfXqSJnV5VcNUumLgd88Y7p36fDbpKO90Qr1afa6Q5w+qT0jlF4X8XSIUklNXC6yXoGvX1C24P3X0igGwoCe71wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+P2pjfMbXfv2lzRu+cMsZFcYWTtyxCboQYnCl4ghDSs=;
 b=KOrfDUmN5aqovP6Cc9O5gMp0OXMdEoEJxzB4X5Gkq7GuF7zaZSuBfAnS5IbUMy7x0HBL6hYL1pUrnyT/4Xz0eZwvl8dtu2vNyvMYt5dab4hmPis0BmnsbFbOM3hBtBhNlJptPRu85h45txjhZortb52yqWu3NIqCV+ilxsj4hXV+TnA2b5Vf12DrgIolvPlom5Jw93+RTP8UzkaISIyOhGHmga8x1HbmxR7QvZmyH+wqj0W6oG4cMLkHytgGL32BUpMyXfUtfXl2SwDVuj0kSU1V/GeO6KpC3pDe+swZODqtFWvPPanL7dMU9Esn0Ib3do1XmwePfLMiCQl6PoN6PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.28) smtp.rcpttodomain=infradead.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+P2pjfMbXfv2lzRu+cMsZFcYWTtyxCboQYnCl4ghDSs=;
 b=CxnaxqB+Iht0Ig6hzN7gfU0D853NqXnEydfqDt2Mi5ySRBk+9ZRzLbBz9QEjWKMRks2lk6+lLQnUzoZDz9ffFnMoC5UY6Nbi26t8OMen785oFnal7XFikzfMr0FY8IOrs/W4axHPTe4rumPgtHL3xp52siJ03zGf2zMTucg+meY=
Received: from SN4PR0701CA0009.namprd07.prod.outlook.com
 (2603:10b6:803:28::19) by BYAPR07MB5208.namprd07.prod.outlook.com
 (2603:10b6:a03:63::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Thu, 5 Dec
 2019 11:57:44 +0000
Received: from DM6NAM12FT042.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe59::202) by SN4PR0701CA0009.outlook.office365.com
 (2603:10b6:803:28::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Thu, 5 Dec 2019 11:57:44 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.28; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM6NAM12FT042.mail.protection.outlook.com (10.13.178.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Thu, 5 Dec 2019 11:57:44 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id xB5BvXLh029212
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 5 Dec 2019 03:57:37 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 5 Dec 2019 12:57:33 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 5 Dec 2019 12:57:33 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xB5BvXVp000965;
        Thu, 5 Dec 2019 12:57:33 +0100
Received: (from piotrs@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xB5BvVJm000964;
        Thu, 5 Dec 2019 12:57:31 +0100
From:   Piotr Sroka <piotrs@cadence.com>
CC:     Piotr Sroka <piotrs@cadence.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mtd: rawnand: cadence: Change types of function parameters keeping DMA address
Date:   Thu, 5 Dec 2019 12:55:58 +0100
Message-ID: <1575546963-436-1-git-send-email-piotrs@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(39860400002)(189003)(199004)(36092001)(7636002)(87636003)(305945005)(478600001)(316002)(2906002)(246002)(26826003)(4326008)(86362001)(36756003)(109986005)(5660300002)(8936002)(50226002)(6666004)(2616005)(50466002)(48376002)(70586007)(54906003)(70206006)(8676002)(356004)(336012)(76130400001)(51416003)(426003)(42186006)(186003)(16586007)(26005)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5208;H:sjmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54a7a836-1b07-4369-8ec5-08d7797a56c6
X-MS-TrafficTypeDiagnostic: BYAPR07MB5208:
X-Microsoft-Antispam-PRVS: <BYAPR07MB520866E11412D74B3D82AA30DD5C0@BYAPR07MB5208.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-Forefront-PRVS: 02426D11FE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pmpX9kSgeWPu/SgOtgHS7aWDApggz0+5DixFCtNK3zHw5eRgzWwrFK/lRB2OuRf3fi2JyZtHHzuz5TOKkg7Kf5FeX+7A9NagOINVW79wwc3kaPHJ/TGkvLS0rxzhNJSl775Cxlt4R9zMvB10HtRc5ALxEtMWVvlevLQx9w84pYK1ekjYm9nRIwpnTOB6XiG2sTOYggli0OlQcXeZjCJofG+2lkzDNQK9nlA6kDTXeys44cuR53XdZTbbn6fdlloQ0VwGm9PYYsyO8rcKOL5iNlbRFxePXm8i4LBdG0v7QeIR8F9B+icOoWuTkz2XEMMUGHkdM7wjLZfzzzsC22PIhCn+1MdRBX/bCqI10lEh3lB5fnA9ioDpeQZxfF/ZoIkvXG9reIxdhCAfJlwV1T5TNRHuoUQTXaOtxbcW57iyktVGy9VGRpciypgmXExqoMDhboApSZ9zjWz7cUWjafA97VrF4t0dwkWTdjJIe32h234WMPh1j7CTk77o+4+FQXZj1Lq6B/l5Bhu20pENa0d3KQ==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 11:57:44.3950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a7a836-1b07-4369-8ec5-08d7797a56c6
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5208
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_03:2019-12-04,2019-12-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 spamscore=0 suspectscore=0 clxscore=1011 mlxlogscore=602 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912050100
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was changed to avoid compilation warnings during type casting.

Signed-off-by: Piotr Sroka <piotrs@cadence.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 drivers/mtd/nand/raw/cadence-nand-controller.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index 3a36285..222a5fb 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -914,8 +914,8 @@ static void cadence_nand_get_caps(struct cdns_nand_ctrl *cdns_ctrl)
 /* Prepare CDMA descriptor. */
 static void
 cadence_nand_cdma_desc_prepare(struct cdns_nand_ctrl *cdns_ctrl,
-			       char nf_mem, u32 flash_ptr, char *mem_ptr,
-			       char *ctrl_data_ptr, u16 ctype)
+			       char nf_mem, u32 flash_ptr, dma_addr_t data,
+			       dma_addr_t ctrl_data, u16 ctype)
 {
 	struct cadence_nand_cdma_desc *cdma_desc = cdns_ctrl->cdma_desc;
 
@@ -931,13 +931,13 @@ cadence_nand_cdma_desc_prepare(struct cdns_nand_ctrl *cdns_ctrl,
 	cdma_desc->command_flags |= CDMA_CF_DMA_MASTER;
 	cdma_desc->command_flags  |= CDMA_CF_INT;
 
-	cdma_desc->memory_pointer = (uintptr_t)mem_ptr;
+	cdma_desc->memory_pointer = (u64)data;
 	cdma_desc->status = 0;
 	cdma_desc->sync_flag_pointer = 0;
 	cdma_desc->sync_arguments = 0;
 
 	cdma_desc->command_type = ctype;
-	cdma_desc->ctrl_data_ptr = (uintptr_t)ctrl_data_ptr;
+	cdma_desc->ctrl_data_ptr = (u64)ctrl_data;
 }
 
 static u8 cadence_nand_check_desc_error(struct cdns_nand_ctrl *cdns_ctrl,
@@ -1280,8 +1280,7 @@ cadence_nand_cdma_transfer(struct cdns_nand_ctrl *cdns_ctrl, u8 chip_nr,
 	}
 
 	cadence_nand_cdma_desc_prepare(cdns_ctrl, chip_nr, page,
-				       (void *)dma_buf, (void *)dma_ctrl_dat,
-				       ctype);
+				       dma_buf, dma_ctrl_dat, ctype);
 
 	status = cadence_nand_cdma_send_and_wait(cdns_ctrl, thread_nr);
 
@@ -1360,7 +1359,7 @@ static int cadence_nand_erase(struct nand_chip *chip, u32 page)
 
 	cadence_nand_cdma_desc_prepare(cdns_ctrl,
 				       cdns_chip->cs[chip->cur_cs],
-				       page, NULL, NULL,
+				       page, 0, 0,
 				       CDMA_CT_ERASE);
 	status = cadence_nand_cdma_send_and_wait(cdns_ctrl, thread_nr);
 	if (status) {
-- 
2.4.5

