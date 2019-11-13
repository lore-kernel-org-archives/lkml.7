Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53518C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2BC2222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Tzbu17Rg";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="vDTJ59vn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfKMKZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:25:45 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:12304 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbfKMKZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:25:45 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xADALufT008931;
        Wed, 13 Nov 2019 02:25:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=Qv+nswBlN/yxOM1n66f0Z8KLhFb3u5YARiapow+iAxk=;
 b=Tzbu17RgwtTGa1sMMDJUBZP/6cRvOtAG6i7KopyfTP1Gulgl3IOb56jopC7FqS74prHS
 mlVLiOC3alOX2KZe6KpY7SHp2g9NrWBfFfGn1+lrl1f/YoFG14FlST7DBBkFBMmcrJW+
 sRfzac3gSbtar+IREVCsD3AowEN6q+8yl0th2H10N6sSdKIiQD/lhLNhjivIAgCN4dGP
 O5pLIqr1j8SwRlwpCyb4DxF1KmqR+YP4OefES64reC1nBSRC8CH8HlAApNsAdRVoBtpr
 Qh0Mi2A9n6maVQJRs/X3NLG0JXwq7ZLy5fDyyDIqx4KRX/0CHGWFXO+mhaYXmjJScmqq cA== 
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2053.outbound.protection.outlook.com [104.47.40.53])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2w7prsw7n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Nov 2019 02:25:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUP7sZWzn6mLc5MQO8fWcOo6hcydRZ8Pn3cmJUGsE671kDqM/BgIKQ/N/CDU5q+ItPRPBt7JPB8F+iHfpMswX0DjopIveukKBdWRoWTxpumoqjNv86pEmCqiVelv/cVA5Kgw7R/gxfa9K1GV0lFjr4LY5jWBkwaF2uQDKcw4H9esJvyHfNpluqPu/TF0kBLtz6y29XQMDY3pNq+mR8ogimAn19FkYLfrnE7zJ7xMawng5cH34KmMgMlzlE/hSTHLVeTjEeK7z9U2tbhZyPu2sexunuEIk5XeJX0+FFlPh6uDzGvLkkA7ua4hNB9yihAaRtVPrGMCBjjEK8pLVxxD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qv+nswBlN/yxOM1n66f0Z8KLhFb3u5YARiapow+iAxk=;
 b=CvssYLeUcFcCZLGnca2exhu3N7Wp0iTXV5ffnBHnOd5cw2sPdeOkN/FTxenuKD8nz/W2hi0DOzrHs4PBFuDftejJeJPNm6DITSz9lDiQFRPVW+uCaZcxAjixbsGU5WnK9hfOk3ewKocNXGV1E4MkcU7dR2EoY71c+wpkrYKIKYHcst9/TySye+UvNxKrxC6KLeHZ89hxo5FjUpUV1c1Np2z/srStz9Ni1MSTzSXA0fhz0n0jGSpwYcCEocYqVQNCYrxkv7dckslp9lcPdoQyj8+dwRmD8jN8YTJ+SKyuWbEuuK3c+yeOCkCOgI+BhH5GO964OamuDykzSLVg0nAkYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 199.43.4.28) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qv+nswBlN/yxOM1n66f0Z8KLhFb3u5YARiapow+iAxk=;
 b=vDTJ59vnMXahkNsIp6milx+qPCHKLmLcpWELQFiYVTpu5PmExKai2YhrgyloXxYbZ5FkqyfzF5z41KrQMNlitWeJSZpt4i0Pw0mTH5KDxYVuQ9sIfH0i5T1m4mBAv0yX5hV1rLK4xurl6AWUbRRRFdo1pm4jWlxukHQOcx2UB1U=
Received: from MN2PR07CA0021.namprd07.prod.outlook.com (2603:10b6:208:1a0::31)
 by DM5PR07MB4038.namprd07.prod.outlook.com (2603:10b6:4:ba::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.25; Wed, 13 Nov
 2019 10:25:33 +0000
Received: from DM3NAM05FT010.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::204) by MN2PR07CA0021.outlook.office365.com
 (2603:10b6:208:1a0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22 via Frontend
 Transport; Wed, 13 Nov 2019 10:25:33 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT010.mail.protection.outlook.com (10.152.98.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.15 via Frontend Transport; Wed, 13 Nov 2019 10:25:33 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id xADAPTSJ005709
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 13 Nov 2019 05:25:30 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 13 Nov 2019 11:25:29 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 13 Nov 2019 11:25:29 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id xADAPSrx013724;
        Wed, 13 Nov 2019 10:25:28 GMT
Received: (from jpawar@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id xADAPQEx013570;
        Wed, 13 Nov 2019 10:25:26 GMT
From:   Jayshri Pawar <jpawar@cadence.com>
To:     <linux-usb@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <felipe.balbi@linux.intel.com>,
        <heikki.krogerus@linux.intel.com>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <peter.chen@nxp.com>,
        <kurahul@cadence.com>, <pawell@cadence.com>, <sparmar@cadence.com>,
        <jpawar@cadence.com>
Subject: [RFC PATCH] usb: gadget: f_tcm: Added DMA32 flag while allocation of command buffer
Date:   Wed, 13 Nov 2019 10:24:32 +0000
Message-ID: <1573640672-10344-1-git-send-email-jpawar@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(396003)(376002)(189003)(36092001)(199004)(7416002)(6916009)(76130400001)(186003)(26005)(16586007)(2906002)(2351001)(50466002)(126002)(54906003)(476003)(316002)(51416003)(36756003)(48376002)(486006)(8936002)(2616005)(42186006)(50226002)(305945005)(336012)(426003)(8676002)(81156014)(81166006)(87636003)(478600001)(47776003)(70206006)(14444005)(70586007)(107886003)(4326008)(356004)(6666004)(86362001)(26826003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB4038;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0a6d906-0013-4d21-aa7b-08d76823d0ba
X-MS-TrafficTypeDiagnostic: DM5PR07MB4038:
X-Microsoft-Antispam-PRVS: <DM5PR07MB40388175F033149180858A7FC1760@DM5PR07MB4038.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0220D4B98D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tUaSlvoq2Npd2VGVMJEaNe3JQ12vY0Jf9jyTPNaJP2UvacmxOmX3uFMV9KWjIMmz3l2UJnE5+k6FM/FsIDvnKOro7oVh1618evSrhREIPJpEfEptfVp9XCA9qVThtTCUhNsyZNLzrm0UZHONli5fDe8lgUAyb/0zEHr+Iew40EXv7C3GvWpuZYhbJ5TU1ptVM2DrC2ViMEjEtTh6fpA9Y4Dy7EQ+O70MCIRcKEly7xGSHHLC/qMXP5cTkiykFRkHLxIaoAasCXaTdXYtsAQG7cmRTNIS6BwhyhdbgXGSLwauBf98BoqOOkzZHkZXKPsfFpXC4Jbzf+mUZkfYulO/trvxpTppovipKvNpjSzO9yDxDzCnNdls86rMk7kw4vaeCNP4d4A9nE+21GQxb/fH1FsaE+Uw6OaM06JIK8l7MmLzvEvxk7giRaJLoLazd6QHKx7y6C9z5aFLbDvUROnTBg==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2019 10:25:33.0472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a6d906-0013-4d21-aa7b-08d76823d0ba
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB4038
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-13_02:2019-11-13,2019-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 spamscore=0 clxscore=1011 impostorscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=1
 mlxlogscore=996 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911130098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a problem when function driver allocate memory for buffer
used by DMA from outside dma_mask space.
It appears during testing f_tcm driver with cdns3 controller.
In the result cdns3 driver was not able to map virtual buffer to DMA.
This fix should be improved depending on dma_mask associated with device.
Adding GFP_DMA32 flag while allocationg command data buffer only for 32
bit controllers.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
---
 drivers/usb/gadget/function/f_tcm.c | 20 ++++++++++++++------
 include/linux/usb/gadget.h          |  2 ++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 36504931b2d1..a78d5fad3d84 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -213,7 +213,8 @@ static int bot_send_read_response(struct usbg_cmd *cmd)
 	}
 
 	if (!gadget->sg_supported) {
-		cmd->data_buf = kmalloc(se_cmd->data_length, GFP_ATOMIC);
+		cmd->data_buf = kmalloc(se_cmd->data_length, GFP_ATOMIC |
+					gadget->dma_flag);
 		if (!cmd->data_buf)
 			return -ENOMEM;
 
@@ -257,7 +258,8 @@ static int bot_send_write_request(struct usbg_cmd *cmd)
 	}
 
 	if (!gadget->sg_supported) {
-		cmd->data_buf = kmalloc(se_cmd->data_length, GFP_KERNEL);
+		cmd->data_buf = kmalloc(se_cmd->data_length, GFP_KERNEL |
+					gadget->dma_flag);
 		if (!cmd->data_buf)
 			return -ENOMEM;
 
@@ -305,6 +307,7 @@ static void bot_cmd_complete(struct usb_ep *ep, struct usb_request *req)
 static int bot_prepare_reqs(struct f_uas *fu)
 {
 	int ret;
+	struct usb_gadget *gadget = fuas_to_gadget(fu);
 
 	fu->bot_req_in = usb_ep_alloc_request(fu->ep_in, GFP_KERNEL);
 	if (!fu->bot_req_in)
@@ -327,7 +330,8 @@ static int bot_prepare_reqs(struct f_uas *fu)
 	fu->bot_status.req->complete = bot_status_complete;
 	fu->bot_status.csw.Signature = cpu_to_le32(US_BULK_CS_SIGN);
 
-	fu->cmd.buf = kmalloc(fu->ep_out->maxpacket, GFP_KERNEL);
+	fu->cmd.buf = kmalloc(fu->ep_out->maxpacket, GFP_KERNEL |
+				gadget->dma_flag);
 	if (!fu->cmd.buf)
 		goto err_buf;
 
@@ -515,7 +519,8 @@ static int uasp_prepare_r_request(struct usbg_cmd *cmd)
 	struct uas_stream *stream = cmd->stream;
 
 	if (!gadget->sg_supported) {
-		cmd->data_buf = kmalloc(se_cmd->data_length, GFP_ATOMIC);
+		cmd->data_buf = kmalloc(se_cmd->data_length, GFP_ATOMIC |
+					gadget->dma_flag);
 		if (!cmd->data_buf)
 			return -ENOMEM;
 
@@ -763,11 +768,13 @@ static int uasp_alloc_stream_res(struct f_uas *fu, struct uas_stream *stream)
 
 static int uasp_alloc_cmd(struct f_uas *fu)
 {
+	struct usb_gadget *gadget = fuas_to_gadget(fu);
 	fu->cmd.req = usb_ep_alloc_request(fu->ep_cmd, GFP_KERNEL);
 	if (!fu->cmd.req)
 		goto err;
 
-	fu->cmd.buf = kmalloc(fu->ep_cmd->maxpacket, GFP_KERNEL);
+	fu->cmd.buf = kmalloc(fu->ep_cmd->maxpacket, GFP_KERNEL |
+				gadget->dma_flag);
 	if (!fu->cmd.buf)
 		goto err_buf;
 
@@ -980,7 +987,8 @@ static int usbg_prepare_w_request(struct usbg_cmd *cmd, struct usb_request *req)
 	struct usb_gadget *gadget = fuas_to_gadget(fu);
 
 	if (!gadget->sg_supported) {
-		cmd->data_buf = kmalloc(se_cmd->data_length, GFP_ATOMIC);
+		cmd->data_buf = kmalloc(se_cmd->data_length, GFP_ATOMIC |
+					gadget->dma_flag);
 		if (!cmd->data_buf)
 			return -ENOMEM;
 
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 124462d65eac..d6c9cd222600 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -373,6 +373,7 @@ struct usb_gadget_ops {
  * @connected: True if gadget is connected.
  * @lpm_capable: If the gadget max_speed is FULL or HIGH, this flag
  *	indicates that it supports LPM as per the LPM ECN & errata.
+ * @dma_flag: dma zone to be used for buffer allocation.
  *
  * Gadgets have a mostly-portable "gadget driver" implementing device
  * functions, handling all usb configurations and interfaces.  Gadget
@@ -427,6 +428,7 @@ struct usb_gadget {
 	unsigned			deactivated:1;
 	unsigned			connected:1;
 	unsigned			lpm_capable:1;
+	unsigned int			dma_flag;
 };
 #define work_to_gadget(w)	(container_of((w), struct usb_gadget, work))
 
-- 
2.20.1

