Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58129C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140782087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="JNgWAokY";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="RcTDgucT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbfC0OqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:46:01 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:50162 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728687AbfC0Op4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:45:56 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2REcm36018195;
        Wed, 27 Mar 2019 07:45:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=YTkNbgunPS0vlIxIDS5GCItpSPhXr1KxsadFjoDD7A4=;
 b=JNgWAokYfHGVMSlj19G1MKvZnELZk1465ZGCYrnmuK5tim4Hbf5O43T2GRLQ72nqRr2K
 Cmvm5JL8xn/k1bpq3eFvqePVZMZSN8oDPS4Qf0VD4QjbWE1XpEuSOmawOXA5Qg6o5cdW
 cxURsbCFSbDb0D7rqhWt6JoOB5pJT811GdXokMkn2GZX+0UO0oJS3Ss7B3ay22xRehP6
 Z+qAznAPsWbDzCX+HmUjAdSYhC0Nz9KFUQCuRIKXe0q8oGfKX7Nk01cgj927Gn002q/a
 inW48fFonqva+XnrWsPuXOmEpVMIZsWrV3WNqpbslutV21ZTkbdmCHj56GEYBodraw0M Kg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2058.outbound.protection.outlook.com [104.47.44.58])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2rfkcveetm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Mar 2019 07:45:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTkNbgunPS0vlIxIDS5GCItpSPhXr1KxsadFjoDD7A4=;
 b=RcTDgucTalemtAhix1C2B2YGXmbdPW/uSGOW8pv8JiSs8Ogl37WNyPfTVnS6L9ULcMnqzzmmN7G71FSd8iOl19XkplgNg4L/BoWqnqeQOakRrcsr2Fn52RSZBmtOVo99EBsoHLnnZa67gqoo9PgD5HRHN1qUbUm9FjYTIBjw09M=
Received: from DM5PR07CA0036.namprd07.prod.outlook.com (2603:10b6:3:16::22) by
 SN6PR07MB4718.namprd07.prod.outlook.com (2603:10b6:805:3b::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Wed, 27 Mar 2019 14:45:33 +0000
Received: from CO1NAM05FT033.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::202) by DM5PR07CA0036.outlook.office365.com
 (2603:10b6:3:16::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.15 via Frontend
 Transport; Wed, 27 Mar 2019 14:45:33 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT033.mail.protection.outlook.com (10.152.96.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.4 via Frontend Transport; Wed, 27 Mar 2019 14:45:32 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x2REjQWw002613
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 27 Mar 2019 07:45:31 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 27 Mar 2019 15:45:25 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 27 Mar 2019 15:45:25 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id x2REjP4D007099;
        Wed, 27 Mar 2019 14:45:25 GMT
Received: (from jank@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id x2REjPvc007098;
        Wed, 27 Mar 2019 14:45:25 GMT
From:   Jan Kotas <jank@cadence.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <pedrom.sousa@synopsys.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Jan Kotas <jank@cadence.com>
Subject: [PATCH 2/2] scsi: ufs-cdns: Add support for UFSHCI with M31 PHY
Date:   Wed, 27 Mar 2019 14:44:05 +0000
Message-ID: <20190327144405.5716-3-jank@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190327144405.5716-1-jank@cadence.com>
References: <20190327144405.5716-1-jank@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(39860400002)(2980300002)(36092001)(189003)(199004)(87636003)(26826003)(36756003)(356004)(110136005)(6666004)(42186006)(478600001)(16586007)(316002)(54906003)(107886003)(4326008)(47776003)(2201001)(186003)(26005)(11346002)(426003)(336012)(486006)(76176011)(446003)(476003)(2616005)(126002)(7636002)(305945005)(2906002)(14444005)(7416002)(106466001)(51416003)(1076003)(48376002)(246002)(8676002)(8936002)(50226002)(86362001)(105596002)(50466002)(5660300002)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4718;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b81f53e5-e5ad-4e67-883f-08d6b2c2ddaa
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060);SRVR:SN6PR07MB4718;
X-MS-TrafficTypeDiagnostic: SN6PR07MB4718:
X-Microsoft-Antispam-PRVS: <SN6PR07MB471868C64DF45D0FD3B9ACF0D0580@SN6PR07MB4718.namprd07.prod.outlook.com>
X-Forefront-PRVS: 0989A7979C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: MbVosZ/BT8ILqm9FNZUS5i7R25vfAm7U4vtvs1nmcJIFUQwS0G7BvLaXvL8Qa7SFOzTiFwWCzNeVwZq4qs0Khp+WKqLnX69QB6vC9EeDVw9LRsaUQZm1JieiZO/hzCHjky9lkXjFYd0wDy1sAQeY90JdjWws0owLL+FLxP13vhj8w91FkgWJqxue6Hvj/zf9IJB/bHDwnYuejNXaKvZPsW6sFwX2M2k6etPyJa5iy2hY4N67fiMjP/ndSPiEGSNPBiDSxTPNjOiXlH7SvA8h0b8Tnx5Jcot7pxLyHr8cnIH3De8vhlzWfFWeZNtavoxSTKBwgFNS6qToNtxwd1naSw0G9ZwyShkoBComuG1wgif1m4feqc7haJQMTkIjtuH81zOBP7QyT/sp9AWzJJ4hk/jxdzFJWBH/2a4mfXouXzs=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2019 14:45:32.8441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b81f53e5-e5ad-4e67-883f-08d6b2c2ddaa
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4718
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=916 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903270103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an additional PHY initialization, required for
M31 PHY when used with Cadence UFS HC.
A new compatible string has been added for this purpose.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 drivers/scsi/ufs/cdns-pltfrm.c | 77 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 67 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/ufs/cdns-pltfrm.c b/drivers/scsi/ufs/cdns-pltfrm.c
index 4a37b4f57..e0c8834df 100644
--- a/drivers/scsi/ufs/cdns-pltfrm.c
+++ b/drivers/scsi/ufs/cdns-pltfrm.c
@@ -17,7 +17,8 @@
 
 #include "ufshcd-pltfrm.h"
 
-#define CDNS_UFS_REG_HCLKDIV 0xFC
+#define CDNS_UFS_REG_HCLKDIV	0xFC
+#define CDNS_UFS_REG_PHY_XCFGD1	0x113C
 
 /**
  * Sets HCLKDIV register value based on the core_clk
@@ -77,11 +78,69 @@ static int cdns_ufs_setup_clocks(struct ufs_hba *hba, bool on,
 	return cdns_ufs_set_hclkdiv(hba);
 }
 
-static struct ufs_hba_variant_ops cdns_pltfm_hba_vops = {
+/**
+ * cdns_ufs_init - performs additional ufs initialization
+ * @hba: host controller instance
+ *
+ * Returns status of initialization
+ */
+static int cdns_ufs_init(struct ufs_hba *hba)
+{
+	int status = 0;
+
+	if (hba->vops && hba->vops->phy_initialization) {
+		status = hba->vops->phy_initialization(hba);
+		if (status)
+			return status;
+	}
+
+	return status;
+}
+
+/**
+ * cdns_ufs_m31_16nm_phy_initialization - performs m31 phy initialization
+ * @hba: host controller instance
+ *
+ * Always returns 0
+ */
+static int cdns_ufs_m31_16nm_phy_initialization(struct ufs_hba *hba)
+{
+	u32 data;
+
+	/* Increase RX_Advanced_Min_ActivateTime_Capability */
+	data = ufshcd_readl(hba, CDNS_UFS_REG_PHY_XCFGD1);
+	data |= BIT(24);
+	ufshcd_writel(hba, data, CDNS_UFS_REG_PHY_XCFGD1);
+
+	return 0;
+}
+
+static const struct ufs_hba_variant_ops cdns_ufs_pltfm_hba_vops = {
+	.name = "cdns-ufs-pltfm",
+	.setup_clocks = cdns_ufs_setup_clocks,
+};
+
+static const struct ufs_hba_variant_ops cdns_ufs_m31_16nm_pltfm_hba_vops = {
 	.name = "cdns-ufs-pltfm",
+	.init = cdns_ufs_init,
 	.setup_clocks = cdns_ufs_setup_clocks,
+	.phy_initialization = cdns_ufs_m31_16nm_phy_initialization,
 };
 
+static const struct of_device_id cdns_ufs_of_match[] = {
+	{
+		.compatible = "cdns,ufshc",
+		.data =  &cdns_ufs_pltfm_hba_vops,
+	},
+	{
+		.compatible = "cdns,ufshc-m31-16nm",
+		.data =  &cdns_ufs_m31_16nm_pltfm_hba_vops,
+	},
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, cdns_ufs_of_match);
+
 /**
  * cdns_ufs_pltfrm_probe - probe routine of the driver
  * @pdev: pointer to platform device handle
@@ -91,10 +150,15 @@ static struct ufs_hba_variant_ops cdns_pltfm_hba_vops = {
 static int cdns_ufs_pltfrm_probe(struct platform_device *pdev)
 {
 	int err;
+	const struct of_device_id *of_id;
+	struct ufs_hba_variant_ops *vops;
 	struct device *dev = &pdev->dev;
 
+	of_id = of_match_node(cdns_ufs_of_match, dev->of_node);
+	vops = (struct ufs_hba_variant_ops *)of_id->data;
+
 	/* Perform generic probe */
-	err = ufshcd_pltfrm_init(pdev, &cdns_pltfm_hba_vops);
+	err = ufshcd_pltfrm_init(pdev, vops);
 	if (err)
 		dev_err(dev, "ufshcd_pltfrm_init() failed %d\n", err);
 
@@ -115,13 +179,6 @@ static int cdns_ufs_pltfrm_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id cdns_ufs_of_match[] = {
-	{ .compatible = "cdns,ufshc" },
-	{},
-};
-
-MODULE_DEVICE_TABLE(of, cdns_ufs_of_match);
-
 static const struct dev_pm_ops cdns_ufs_dev_pm_ops = {
 	.suspend         = ufshcd_pltfrm_suspend,
 	.resume          = ufshcd_pltfrm_resume,
-- 
2.15.0

