Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C027CC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 06:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523EA2133F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 06:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="MzJWAaYm";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="K72LJ8es"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfJGGkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 02:40:02 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:38980 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726984AbfJGGkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 02:40:01 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x976d4Bg020112;
        Sun, 6 Oct 2019 23:39:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=17s99B+fBraCSnfR0iDu2qrFmYxWAWAoqS5uKkZGVCc=;
 b=MzJWAaYm/oBJvn8gtPR6F03qGe6AGutJjr4VzYxrHR8uMbwAomtomhgKPBRAPUiVTzpl
 c66Mtr3iU/o2nLkQr3f+GSPG/X5uUKGXiqBC1sHT9fHK/mHj4QPz/HeMcFMOSiWh33YA
 48/rZlpPPxKpPDMEE5aunV4WmIAr6daa0oLNSWRNAJBvRGjXVJvULG0Z5amn12Te3nAz
 GUBAtjc2yByFlmVFuzlqyLYSL3NGrBtxE/GLCjGpC3VWvGZCEC49uVHwbeYDYzx91LuG
 5giXYNt1d14eO+gAL5gieCaTCtyJGqFg14eJzq/4j9qT9IOLzP2FTWtlf2sPf+hxYApF zA== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2053.outbound.protection.outlook.com [104.47.44.53])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2vepry5dq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Oct 2019 23:39:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gg10/8e8DvxrEIpzWmUispG8XQuYkRmxR+XOtN3KAsGumTVmqrrvb24RM2ykMz8gZVzCUKQted5FY5U9A90KplrabRDlEr/gzTtoNdKxH6nH7i2rOE2vyoeOgfPOUrx3AfHb7v0BI+drU3BV/eaZ4WHHMZ3HcyQ53OntG7YTH+1i3aovzSRLzlc2zYuXtehUCrYTh7nOnCJBJedpuNaUG5WsQBL3Ll8Pl75dPE5dRz/vAzYFraQp79dJY6vCelwY4vzx+OwxBJAHbiks9BAPcAXXRuBGy/tx7JYdb1Xh1I62lwR9oKGXCjLTEIrH/GybaMrb3b3GjB7+ZpCQ+l9SOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17s99B+fBraCSnfR0iDu2qrFmYxWAWAoqS5uKkZGVCc=;
 b=aqBSWj8jFKmd0Nl8U+fR+YiNaxusImReTHBT2+bMbPF3BUhgA5Rxeu3DZzNmouro3ePaixn+ZBWVhseP3wsUF3Yv9GQls0Vo/0/4vBbocollq2Cm2nWfscg6bbnydMrkxSDUpgvLWt3+3Y2ErlLm6W4N45PAV4yYSw19PH7OUVV6AOcPAViW83ZSIT0SYjv9sdvT4mIkbkHJmBr55cfT+VUPA1S/zz7Qg79SWwX1v9y0QhItNMOHbG2yZRs58CMl1h12g/sXHd9cvKdzSOCSXUtlvLtZOGg3lTKCWdVsGiprqBHwIHdMyOF/IdaZZQ7Rhg7RjClXJCWO1s6lEwe8tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 158.140.1.28) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17s99B+fBraCSnfR0iDu2qrFmYxWAWAoqS5uKkZGVCc=;
 b=K72LJ8eszKhUeAEKCdTlWt6Odu7aI2ViNdq7h1+j03z/xR1ONThmvwTujbx4j+sq+J/WSRICuI5mTukMTfaGxZNpjhO1xZe8QDK3rgM6InG5DmLx3V2C/CHUFDR2Zy7wGffJGtSofpCqKX5DQl0rbx5jytQV96cewb7WQFUbpuc=
Received: from BYAPR07CA0064.namprd07.prod.outlook.com (2603:10b6:a03:60::41)
 by DM5PR0701MB3717.namprd07.prod.outlook.com (2603:10b6:4:7f::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.24; Mon, 7 Oct
 2019 06:39:49 +0000
Received: from BY2NAM05FT024.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::206) by BYAPR07CA0064.outlook.office365.com
 (2603:10b6:a03:60::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.16 via Frontend
 Transport; Mon, 7 Oct 2019 06:39:49 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT024.mail.protection.outlook.com (10.152.100.161) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.8 via Frontend Transport; Mon, 7 Oct 2019 06:39:48 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x976dk14030397
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 6 Oct 2019 23:39:48 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 7 Oct 2019 08:39:46 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 7 Oct 2019 08:39:46 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x976djqA027699;
        Mon, 7 Oct 2019 07:39:45 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x976dimq027688;
        Mon, 7 Oct 2019 07:39:44 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <felipe.balbi@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH] usb:cdns3: Fix for CV CH9 running with g_zero driver.
Date:   Mon, 7 Oct 2019 07:39:11 +0100
Message-ID: <1570430355-26118-1-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(36092001)(199004)(189003)(70586007)(47776003)(336012)(486006)(2616005)(7636002)(305945005)(26005)(186003)(86362001)(426003)(2906002)(126002)(476003)(316002)(42186006)(50466002)(50226002)(54906003)(16586007)(70206006)(107886003)(246002)(14444005)(2351001)(48376002)(76130400001)(6916009)(8936002)(87636003)(5660300002)(478600001)(6666004)(26826003)(8676002)(356004)(36756003)(4326008)(51416003)(4720700003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0701MB3717;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.Cadence.COM;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d6845d6-c2c4-4ec7-e2dd-08d74af1265f
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3717:
X-Microsoft-Antispam-PRVS: <DM5PR0701MB37178601089D6D6BD7C2A52EDD9B0@DM5PR0701MB3717.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 01834E39B7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qVUFTcy+Az38/BgOrQ804GtA2EBR/zMHOCscBJyclEhNbXZa08/fu4LSQNJVVgYCrHI0IeF6LJjHXAUfAyoUhw4OG8x1Wlxznmr6vZs74y07uJluvl4x6TX6cBGsBfMJX8n+Aln9MdTaw1U/uitJPCMvMvD+ynFkII7xNAM4UTwti5VJ82FdZZ5d5H2mTJGFlUDnoDoRIBHaMEtV8uMI0cFZb8topRkw3O9Y2dwMNm+qM9SHq4wFCmMUIFL35Gqn8ZzuyRcL9Ddy81lGjOu5EfByKp7A4DiQE5R/aFUvoANVYuT0xJh9sP136U+apGwqA7dEJtpR9+v6Q0wJHpc8SXKQhITIQ153Z9KUoy7muyx3zS70e6KTpK5bdqPO7mmoiez4PPpCQcyvAMbMtmNm3ae86dJaSSBo23NHxTj4xqQ=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2019 06:39:48.7326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6845d6-c2c4-4ec7-e2dd-08d74af1265f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3717
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_01:2019-10-03,2019-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 adultscore=0 impostorscore=0 clxscore=1011 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=867 phishscore=0 suspectscore=1
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910070070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch fixes issue with Halt Endnpoint Test observed during using g_zero
driver as DUT. Bug occurred only on some testing board.

Endpoint can defer transition to Halted state if endpoint has pending
requests.
Patch add additional condition that allows to return correct endpoint
status during Get Endpoint Status request even if the halting endpoint
is in progress.

Reported-by: Rahul Kumar <kurahul@cadence.com>
Signed-off-by: Rahul Kumar <kurahul@cadence.com>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
---
 drivers/usb/cdns3/ep0.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
index 44f652e8b5a2..10ae03430f34 100644
--- a/drivers/usb/cdns3/ep0.c
+++ b/drivers/usb/cdns3/ep0.c
@@ -234,9 +234,11 @@ static int cdns3_req_ep0_set_address(struct cdns3_device *priv_dev,
 static int cdns3_req_ep0_get_status(struct cdns3_device *priv_dev,
 				    struct usb_ctrlrequest *ctrl)
 {
+	struct cdns3_endpoint *priv_ep;
 	__le16 *response_pkt;
 	u16 usb_status = 0;
 	u32 recip;
+	u8 index;
 
 	recip = ctrl->bRequestType & USB_RECIP_MASK;
 
@@ -262,9 +264,13 @@ static int cdns3_req_ep0_get_status(struct cdns3_device *priv_dev,
 	case USB_RECIP_INTERFACE:
 		return cdns3_ep0_delegate_req(priv_dev, ctrl);
 	case USB_RECIP_ENDPOINT:
-		/* check if endpoint is stalled */
+		index = cdns3_ep_addr_to_index(ctrl->wIndex);
+		priv_ep = priv_dev->eps[index];
+
+		/* check if endpoint is stalled or stall is pending */
 		cdns3_select_ep(priv_dev, ctrl->wIndex);
-		if (EP_STS_STALL(readl(&priv_dev->regs->ep_sts)))
+		if (EP_STS_STALL(readl(&priv_dev->regs->ep_sts)) ||
+		    (priv_ep->flags & EP_STALL_PENDING))
 			usb_status =  BIT(USB_ENDPOINT_HALT);
 		break;
 	default:
-- 
2.17.1

