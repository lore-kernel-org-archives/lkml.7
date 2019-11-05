Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E6ACA9ED9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0377020818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="gdc1OYAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387840AbfKEHbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 02:31:37 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:59720 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387484AbfKEHbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 02:31:37 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA57NGDh018376;
        Tue, 5 Nov 2019 02:31:34 -0500
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2058.outbound.protection.outlook.com [104.47.37.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w2a4e3hp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Nov 2019 02:31:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZyzi+DWnuCD+6uqx+lmcNk36+IRRyI/u0G4KVvXW8Gyo/sTVf2hg7NufBehw8ZXDcC6QQoR36YbbyZw4CX1664o4/XAPBbBAHF9snAoxLILc+D6aMqXA//C5f0KGF8j/GzzJDf5i8NunNK4Ad4Cd8PfEbBkW/H/fCfN27vsMscjwiaEzizEzl+BjJHDZuI/yCtDLuAIxk/BIGAvPeD6TZ2w567G0tuYeFP58pZ1bG66736FtgeToKbXXqgZ+ru2g2fAblbiDCedBiNGznZq7DDqp1ork22MwhWg9pv31a8JwEZCs1Sv5qvugUHPxR6yVngLG8lRs4KyhdJOUbshRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnBL7botMV3OTjmptMg5b4QjkS2zoqxPGXvdapx9Z70=;
 b=GBuSsZh3Py6lgXHf3nLxkR7CBGkVCPWks9+vJIFT5QvL/D471SEpuF+poxzfFFWYkRtpT9/YD/PevxABBFLmLwnxf89vmJV8ScCMRX0WCV+JLLJEFqZjQamh3msmttIg8DlDYUCwRFignLQ70oEZYQshI9DHGUAgA/1+Y+TUcC8mBp8yoSxavnhOa7zxeQpeIenldGsowqEfI4/6J94KJd23utDXzNLDHtIBW9Ab6qTqtovQeAZE+qXF6hrRE49kU8ERITyiLIb/UA0DP6b5A6FpzQ8WdjAu34doTCE3NiwxPSpfZwCjahCiH2AI6AZimgnzN7xEX1Q8v7DevfSy9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnBL7botMV3OTjmptMg5b4QjkS2zoqxPGXvdapx9Z70=;
 b=gdc1OYAZEKYK7eKRfabKcqAoMKqbHF52xUf4dF72P/QDmQrwZSXk08xXB1N23euEmrhkFzcQ16dVFyyRnN1WkC2QzKU9ttLY54D2jQmzT9Y6NkLJl02eQME4hp7Za+kHDRzGbj3OOETRpPuxEWDuidGEESVKgfrBKBW21wLBGuI=
Received: from BL0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:208:2d::27)
 by DM5PR03MB2538.namprd03.prod.outlook.com (2603:10b6:3:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Tue, 5 Nov
 2019 07:31:32 +0000
Received: from SN1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BL0PR03CA0014.outlook.office365.com
 (2603:10b6:208:2d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24 via Frontend
 Transport; Tue, 5 Nov 2019 07:31:32 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT055.mail.protection.outlook.com (10.152.72.174) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Tue, 5 Nov 2019 07:31:31 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xA57VVfX001288
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 4 Nov 2019 23:31:31 -0800
Received: from saturn.ad.analog.com (10.48.65.117) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 5 Nov 2019 02:31:30 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <dhobsong@igel.co.jp>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH v2] uio: fix irq init with dt support & irq not defined
Date:   Tue, 5 Nov 2019 09:32:12 +0200
Message-ID: <20191105073212.16719-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191105072807.14420-1-alexandru.ardelean@analog.com>
References: <20191105072807.14420-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(136003)(189003)(199004)(54534003)(4326008)(186003)(1076003)(50466002)(2906002)(2616005)(356004)(6666004)(126002)(2870700001)(70206006)(47776003)(70586007)(36756003)(7696005)(316002)(107886003)(486006)(446003)(44832011)(11346002)(106002)(51416003)(48376002)(6916009)(5660300002)(426003)(76176011)(305945005)(86362001)(336012)(7636002)(246002)(54906003)(50226002)(478600001)(8676002)(8936002)(2351001)(14444005)(26005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2538;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1109b13e-8600-474a-13bb-08d761c22df8
X-MS-TrafficTypeDiagnostic: DM5PR03MB2538:
X-Microsoft-Antispam-PRVS: <DM5PR03MB2538C578877D8F51DCD716A2F97E0@DM5PR03MB2538.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0212BDE3BE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nUKQfE+1lWRLnyvYxWkmTETO1K26zwx4MKJ8fB/kZzd4zzJZBis4Ui6UDYVxp2VZgJhFsHmQyZltvT3bnkk+iOLy9akYyhHFrmqUM388Bxx0rqI+NjpmK7/gi5CfB4PgIp54CC5ljBfWmqL6zS1VlnP8RRUKoFNF9gjbt1JpmbI1Xy5BsbD/l9HS6ycZMtibuo60Ri5vGP2ggPs6NYeKbEUA3W+NZ71lYLb+mO4Y5u6GeA7LYwGJMi2vIyMrVjC+RGvQkJK90pL109FkbHNNUIQdPAKil/k2jIMxufG9EEOD+3tjGNbeK1CNRCxwjs7ZWbCxbu3PPmBYiiYEu5LDesutCluEOFakNJecxjrNTiYRWUmUKw96C/My3DzXCwr40RovaI5rodTkIDthBiTqhdxlBuhl5MYxG/uklKXS0yCdzF+774KKTuY1xcaD0I1V
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2019 07:31:31.7785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1109b13e-8600-474a-13bb-08d761c22df8
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2538
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-05_02:2019-11-04,2019-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1911050061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change also does a bit of a unification for the IRQ init code.

But the actual problem is that UIO_IRQ_NONE == 0, so for the DT case where
UIO_IRQ_NONE gets assigned to `uioinfo->irq`, a 2nd initialization will get
triggered (for the IRQ) and this one will exit via `goto bad1`.

As far as things seem to go, the only case where UIO_IRQ_NONE seems valid,
is when using a device-tree. The driver has some legacy support for old
platform_data structures. It looks like, for platform_data a non-existent
IRQ is an invalid case (or was considered an invalid case).
Which is why -ENXIO is treated only when a DT is used.

Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
* removed `int irq` variable ; was omitted when porting the patch to a
  newer kernel base

 drivers/uio/uio_dmem_genirq.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index ebcf1434e296..81c88f7bbbcb 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -151,8 +151,6 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 	int i;
 
 	if (pdev->dev.of_node) {
-		int irq;
-
 		/* alloc uioinfo for one device */
 		uioinfo = kzalloc(sizeof(*uioinfo), GFP_KERNEL);
 		if (!uioinfo) {
@@ -163,13 +161,6 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 		uioinfo->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%pOFn",
 					       pdev->dev.of_node);
 		uioinfo->version = "devicetree";
-
-		/* Multiple IRQs are not supported */
-		irq = platform_get_irq(pdev, 0);
-		if (irq == -ENXIO)
-			uioinfo->irq = UIO_IRQ_NONE;
-		else
-			uioinfo->irq = irq;
 	}
 
 	if (!uioinfo || !uioinfo->name || !uioinfo->version) {
@@ -199,8 +190,11 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 	mutex_init(&priv->alloc_lock);
 
 	if (!uioinfo->irq) {
+		/* Multiple IRQs are not supported */
 		ret = platform_get_irq(pdev, 0);
-		if (ret < 0)
+		if (ret == -ENXIO && pdev->dev.of_node)
+			ret = UIO_IRQ_NONE;
+		else if (ret < 0)
 			goto bad1;
 		uioinfo->irq = ret;
 	}
-- 
2.20.1

