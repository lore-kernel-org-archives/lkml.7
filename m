Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F4AC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63642067D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="copLnrWu";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="gYGdpuUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392335AbfHBLVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 07:21:45 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:15764 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731327AbfHBLVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 07:21:45 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72BIp3K020028;
        Fri, 2 Aug 2019 04:21:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=xIceUSo1Z6tqIOMoFigWZGYECzRz5X3zNzAIju9KkQ0=;
 b=copLnrWuym2GC3WRwXBZPjxc1f11Yers3dMDLijgmG5URFIIw4YNVoHTVqGphHN72gyW
 wGnMM4vujL8Itz/o9vyqAyO7eWAKdcFUCVSc4HBkNFHKcPo1LVMz7I20fNxIyHQaAu2C
 xA+xuoK70mvwlgPkFw6K1JDxmGbANQRUg/cSVSKjw2Q7HJA44/CaoQluGdm+ytQliads
 0Xhgam1EcZA2ZACiPXK+isusdFJhmH1GFt7lzMkHdprmQH+h2FrIbYsQWxyayGq+yG3Q
 DOFJKRIVcpOMcTfuWbjC/CCbRsVQdo+OZmt7EtX8V6CGoVkSxnX4Dhs51LDYZepYepg4 VA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=aniljoy@cadence.com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2057.outbound.protection.outlook.com [104.47.32.57])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2u49awa6c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 04:21:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AH2kW82gb2KJIwjikKDl3Jytos8S+bCvyEyLrofCUF/NvJKjNmLuoWFl+cemS9yLAUcy3mxLHfVR3/37wsfw5XbvEcA0BQx4yrZH8e+x0Su5z8g68SaBRLPz+PzWixR8DMjvZ184aUUVcWfGCgo8UntbQdPkKt4X9d/3ri1jA3bdMN9gHrfP0sNzrQ3iQNnmbc7m3c6nAJ/PYqfl2fJwiHXdgC67gmwSymz4B8fQ4N2fYZu8u8BRwRQkKY+GFiZHNL9RCWV5Wv9B+GiitAEc9vwPG8NmhIBub6N5/npeOkQR6YQrHZ9hvBcCPeHNQkimu6KGMa1n5Z8wfU+q0D9WoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIceUSo1Z6tqIOMoFigWZGYECzRz5X3zNzAIju9KkQ0=;
 b=cdo0o3X5cGjrQwPVUpVWAFeASqaeuWHQEH8OfBqeP+q+fgiMQ4+8rgbBpLQd+d/TBabtQvud/8tnRuRS27AEWUyKjiqeTzhLPrrPFrlXas/UbYM8OONbZQp/cpTFF00Ckg/5gjYexWzvecMcnH+QejxviXJx6Nz7vcvhQdebUUlXQs16BN5JCXRtOs6DsQoLq0R/lmxJnKxB03ToK3/B77CrHBj5JoCRK9DkLQvt6G1YwobMpjeZZw6vXCfcVnRAN/eOznChcZc1yJ6IlPnOJ8Z3Px1kCeTO8bmXUbCj1l7Pu4OUIwKh2gdc2lzH4iPhN0FVqvJ4eIhX2Tjs64P1EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=softfail (sender ip is
 158.140.1.28) smtp.rcpttodomain=synopsys.com
 smtp.mailfrom=cadence.com;dmarc=fail (p=none sp=none pct=100) action=none
 header.from=cadence.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIceUSo1Z6tqIOMoFigWZGYECzRz5X3zNzAIju9KkQ0=;
 b=gYGdpuUTtcfEeR+zdtJZ9BXnBjaHFZUq9EvXkYFYtQnRWQ1GX4c/NvKmr3trBx561tlz/qlTiJXEaY7j4sqHaP1YEJxWAwpSTsLMrShu2Mzf0m3t7fL0HVVw+9/5UTqiS3WLpZy+7LAKY/0gQZ6xgr7bCYJIuUsMFkv5ZUVwuo8=
Received: from BYAPR07CA0026.namprd07.prod.outlook.com (2603:10b6:a02:bc::39)
 by SN6PR07MB4351.namprd07.prod.outlook.com (2603:10b6:805:57::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.12; Fri, 2 Aug
 2019 11:21:28 +0000
Received: from CO1NAM05FT059.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::207) by BYAPR07CA0026.outlook.office365.com
 (2603:10b6:a02:bc::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.13 via Frontend
 Transport; Fri, 2 Aug 2019 11:21:27 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT059.mail.protection.outlook.com (10.152.96.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.8 via Frontend Transport; Fri, 2 Aug 2019 11:21:27 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x72BLNZQ016628
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 2 Aug 2019 04:21:24 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 2 Aug 2019 13:21:22 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 2 Aug 2019 13:21:22 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x72BLMPI018989;
        Fri, 2 Aug 2019 12:21:22 +0100
Received: (from aniljoy@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x72BLHZV018821;
        Fri, 2 Aug 2019 12:21:17 +0100
From:   Anil Varughese <aniljoy@cadence.com>
To:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <pedrom.sousa@synopsys.com>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hare@suse.de>,
        <aniljoy@cadence.com>, <rafalc@cadence.com>, <mparab@cadence.com>,
        <jank@cadence.com>, <pawell@cadence.com>, <vigneshr@ti.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] scsi: ufs: Configure clock in .hce_enable_notify() in Cadence UFS
Date:   Fri, 2 Aug 2019 12:21:12 +0100
Message-ID: <20190802112112.18714-1-aniljoy@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(2980300002)(189003)(199004)(36092001)(36756003)(186003)(6666004)(356004)(87636003)(478600001)(336012)(76130400001)(426003)(70586007)(70206006)(4326008)(476003)(47776003)(126002)(1076003)(26826003)(2201001)(7636002)(246002)(50466002)(316002)(42186006)(48376002)(2906002)(16586007)(26005)(2616005)(5660300002)(51416003)(50226002)(110136005)(54906003)(486006)(14444005)(8676002)(305945005)(86362001)(8936002)(142923001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4351;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 199927d7-7477-47e6-c7b6-08d7173b8fb0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:SN6PR07MB4351;
X-MS-TrafficTypeDiagnostic: SN6PR07MB4351:
X-Microsoft-Antispam-PRVS: <SN6PR07MB435114B144CDC8BB4F958861A8D90@SN6PR07MB4351.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 011787B9DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: /pwLi9r3e7iv6228l6Ehv+ezqg87zdWULjkG5sOk66/LRCxyXLbjlYhEwSefgS5OLYDP6QgVTjVrVAb04cBWFqQnSuRkFb4atBnrlfk5Ck2sNNvsG7Z9iGAJPg3TpXKorpwInwrrE7rtSiLwsuT4dGcyJw/zhynyINaEnhrwmc9WvNhgrDF+Srfgqdzb5aeTE2rHAJMhBh1T9vP3BxntSskeRbPLlTeyOir4DWtF5+mmnqNiRR8i1JMXVzT35e2dRebE0Ppeq9O+BlTCXisoghMO8l3abtTQl3qludriOSf/wR8jsMqmFFZIEhGv7DN3C95ePAlia5PlhQZAwUycHXcLDfbw0qnYtNqH/f4IG8S9OVy0Dnf8rT1EuMqfO+CM7NY1Voq8zL2Euf2AXQiYkM8rlFXlDU0hggXY6u5i+A8=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2019 11:21:27.4518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 199927d7-7477-47e6-c7b6-08d7173b8fb0
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4351
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure CDNS_UFS_REG_HCLKDIV in .hce_enable_notify() instead of
.setup_clock() because if UFSHCD resets the controller ip because
of phy or device related errors then CDNS_UFS_REG_HCLKDIV is
reset to default value and .setup_clock() is not called later
in the sequence whereas .hce_enable_notify will be called everytime
controller is reenabled.

Signed-off-by: Anil Varughese <aniljoy@cadence.com>
---
 drivers/scsi/ufs/cdns-pltfrm.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/ufs/cdns-pltfrm.c b/drivers/scsi/ufs/cdns-pltfrm.c
index 86dbb723f..993519080 100644
--- a/drivers/scsi/ufs/cdns-pltfrm.c
+++ b/drivers/scsi/ufs/cdns-pltfrm.c
@@ -62,17 +62,16 @@ static int cdns_ufs_set_hclkdiv(struct ufs_hba *hba)
 }
 
 /**
- * Sets clocks used by the controller
+ * Called before and after HCE enable bit is set.
  * @hba: host controller instance
- * @on: if true, enable clocks, otherwise disable
  * @status: notify stage (pre, post change)
  *
  * Return zero for success and non-zero for failure
  */
-static int cdns_ufs_setup_clocks(struct ufs_hba *hba, bool on,
-				 enum ufs_notify_change_status status)
+static int cdns_ufs_hce_enable_notify(struct ufs_hba *hba,
+				      enum ufs_notify_change_status status)
 {
-	if ((!on) || (status == PRE_CHANGE))
+	if (status != PRE_CHANGE)
 		return 0;
 
 	return cdns_ufs_set_hclkdiv(hba);
@@ -114,13 +113,13 @@ static int cdns_ufs_m31_16nm_phy_initialization(struct ufs_hba *hba)
 
 static const struct ufs_hba_variant_ops cdns_ufs_pltfm_hba_vops = {
 	.name = "cdns-ufs-pltfm",
-	.setup_clocks = cdns_ufs_setup_clocks,
+	.hce_enable_notify = cdns_ufs_hce_enable_notify,
 };
 
 static const struct ufs_hba_variant_ops cdns_ufs_m31_16nm_pltfm_hba_vops = {
 	.name = "cdns-ufs-pltfm",
 	.init = cdns_ufs_init,
-	.setup_clocks = cdns_ufs_setup_clocks,
+	.hce_enable_notify = cdns_ufs_hce_enable_notify,
 	.phy_initialization = cdns_ufs_m31_16nm_phy_initialization,
 };
 
-- 
2.15.0

