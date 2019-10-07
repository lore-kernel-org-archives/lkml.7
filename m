Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9B0ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07C121655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="mCcAMhc/";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="wIQUFRQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfJGMEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:04:02 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:45528 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727490AbfJGMEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:04:01 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x97C3o9O002479;
        Mon, 7 Oct 2019 05:03:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=0uIp/AhWIWGVgvND+Fwu1dAZVZUhbMBbuX2ojfPD5qY=;
 b=mCcAMhc/UnHwJyLFWXc2+Sg11D46O4MaqQRcFRnlUc4f7NeIc3hUeRZsNDtjjUWbfIbt
 8wnFn8ovY7fZlRW6iffUPpB34UdelipVsmK3XNQICA1I5IvmGsPkX3pcB+b9OrelWas1
 sx62g1+bbkgPAA+pNQ+Wpm5oAu9jxx5inlikbdbsELC6LjkvZCBx+Z7vGKfg3R5XRAAb
 Hy8yBz7Z9ojcJFzfjrUvWXiClveXCXe/ZIis77xy1wpe0QEzGkPn4SgHFHmk/XJaA8Yp
 zZuhi6K2I0QCxo8QbxPzRtBPKi1XBZb8LeJPLsvexOxyKbi/2hvHM5ZTCnnF4yoxKXn7 Iw== 
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2058.outbound.protection.outlook.com [104.47.42.58])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2vepry680b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 05:03:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoZ9Jn0Hhw+u3bZlCmRbs3W3VDfGR9GEXLBkclMMmiKhhcdoJ0dOrEdqBHa+4niX/Bhw1VmUjq9FgnwPwyCMEJ2yXAT+503ti8gsvblFDN6ZYVv7+VgntOYml2m0p8oYdJ+rRBUK5SjpQ7KH28KRKXibCnwg+L7PX81cMV2VsWr6dJVRS8VN7BrFhEIjemdNeAOkXMR0oo5WMwHZKCy5DI8QHtq9a7HUorOozqMwcqDmazhl6ioGXYSPmXiG8C1HpwSnylkm44PdDUH9hh/Ji/8w8/xD4LiDb9F+nXnq48m3l8IuDAq99qtbvYZsRKKIvAIOXiX/FBFjqysYx21SDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uIp/AhWIWGVgvND+Fwu1dAZVZUhbMBbuX2ojfPD5qY=;
 b=FL8nznCUtY5f34R5WkR8AAbg4bfo2TGEEyv6nO7evu4W42+nXksZZEHXf73l8BA983Bxz1EGBGn0A3rR7rWJkKfpKhCgU4/SY0cPHNk1sc6IvAhModBpm4I4jq3Hku3PhyvfdQJIEarVaKl3oF0E/q/fJPepGcdqp/evUoNMrg2TYc1Ii3nlSmoTq2wIsLxj8PRtd9Hyup+IHIMaFfjkLxwwJ9CjOUoDgwF/TKgNFJI6ffuJhEFlCufphtmMYjVCdcOD9YD+a7C9XX1pOn+obZ/S8RafthVsXafLr0hsWJ5GY8s2lKlyae4w0WNHdsL6ai1p1nGoeitnm9DCSPzkRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 158.140.1.28) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uIp/AhWIWGVgvND+Fwu1dAZVZUhbMBbuX2ojfPD5qY=;
 b=wIQUFRQFtKWO85nngLKy3PuOEUaezo3ENxXDKqSyd2sbvJiMp/0HL24T6DPddP5gtHmADmLpE5x9JLPP/ldzZ5+LCxJRj57/7ciznbNWPp977Z7S1pdawxo4tDeUxtq/3aVCZE2G5CIYK+GmE7faPuEd4p6bg/y3idRg019Uk9Y=
Received: from DM5PR07CA0044.namprd07.prod.outlook.com (2603:10b6:3:16::30) by
 BN6PR07MB3203.namprd07.prod.outlook.com (2603:10b6:404:a6::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Mon, 7 Oct 2019 12:03:48 +0000
Received: from CO1NAM05FT034.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::200) by DM5PR07CA0044.outlook.office365.com
 (2603:10b6:3:16::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.24 via Frontend
 Transport; Mon, 7 Oct 2019 12:03:48 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT034.mail.protection.outlook.com (10.152.96.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.8 via Frontend Transport; Mon, 7 Oct 2019 12:03:48 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x97C3j1u012849
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 7 Oct 2019 05:03:47 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 7 Oct 2019 14:03:45 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 7 Oct 2019 14:03:45 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x97C3i6w015716;
        Mon, 7 Oct 2019 13:03:44 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x97C3hGa015702;
        Mon, 7 Oct 2019 13:03:43 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <felipe.balbi@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH] usb: cdns3: Fix for incorrect DMA mask.
Date:   Mon, 7 Oct 2019 13:03:23 +0100
Message-ID: <1570449803-15299-1-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(39850400004)(36092001)(199004)(189003)(4326008)(36756003)(26826003)(478600001)(5660300002)(87636003)(2351001)(2906002)(4720700003)(6666004)(356004)(48376002)(47776003)(107886003)(76130400001)(70206006)(305945005)(50226002)(50466002)(16586007)(186003)(26005)(86362001)(6916009)(246002)(7636002)(70586007)(336012)(126002)(486006)(8676002)(54906003)(42186006)(426003)(8936002)(2616005)(476003)(316002)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3203;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5a37f07-b8cd-4abd-45af-08d74b1e694d
X-MS-TrafficTypeDiagnostic: BN6PR07MB3203:
X-Microsoft-Antispam-PRVS: <BN6PR07MB32030E083F9B51BFBA5AE0F2DD9B0@BN6PR07MB3203.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 01834E39B7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: odupIDn9czqeBRVasxrg8tktpsANJcuY+MwC06RyIhsLlucO0j2cCsGdUBP5x8BNe8BhAoWW9xSnxbFKtmo3ZfGpyuZOIdhVTemPl1P13sReRoNw4w4flLknO0gHVuCjcCEp4iEtjBBfOOe3w3sMjkhfZJV/WSw0mzrffxOQIUUitjDMS+v1vW7TMV0Ywy/CDkuO7yYcGQROPHWI06QebMRWsyG8x9kp0XJULgz1rU0tmrCFAoRFo7VqHUHCpLjiWxGMx35CfqFau/j6f+ZQCdBapLQ6ZMuaI93YwxHZJTT4AGxd9ay2ctKZZilC7I57tqalCD5/ge2O1SGMzuUB6633qwHOUdrTCp3s/TK9i7qDlUB9sM8UoRwAnb/bXgEZShMh4EGDhlB0J/PSLT3npwsQUoysXGoW7mQIFWGEdTE=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2019 12:03:48.2947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a37f07-b8cd-4abd-45af-08d74b1e694d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3203
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_02:2019-10-07,2019-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=918 phishscore=0 suspectscore=1
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910070120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch restores the correct DMA mask after switching back to device
mode.
The issue occurred because Device part of controller use 32 bits DMA and
Host side use 64 bits DMA. During loading XHCI driver the DMA mask
used by driver is overwritten by XHCI driver so it must be restored
to 32 bits.

Reported-by: Pawel Laszczak <pawell@cadence.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
---
 drivers/usb/cdns3/gadget.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 157536753b8c..2ca280f4c054 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -2663,6 +2663,13 @@ static int __cdns3_gadget_init(struct cdns3 *cdns)
 {
 	int ret = 0;
 
+	/* Ensure 32-bit DMA Mask in case we switched back from Host mode */
+	ret = dma_set_mask_and_coherent(cdns->dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(cdns->dev, "Failed to set dma mask: %d\n", ret);
+		return ret;
+	}
+
 	cdns3_drd_switch_gadget(cdns, 1);
 	pm_runtime_get_sync(cdns->dev);
 
-- 
2.17.1

