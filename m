Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFB9CA9ED9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DE1206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="xyWsMnxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbfKEH1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 02:27:39 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:29712 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387484AbfKEH1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 02:27:38 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA57NLuh017742;
        Tue, 5 Nov 2019 02:27:35 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2059.outbound.protection.outlook.com [104.47.36.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w2a5rkeyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Nov 2019 02:27:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADbwQTmQbwp4q+9fG5dG171dKyvsjXpAwU0zefIkY1sVJs5na/T14kIyvhj0zzyZxD35kBBF4oxFv6gOdZVXo5ecdnjvCELFecn5RUSTzsl42jnfl3GGYEB9r3EAxWR1V+N4DDRa5nbKhrzSvz9t48HufKewlIfWIEiM9ZExYrSsoDGw+yYyoYnP9q0+YlMubgP2b4iHORnKHUA0cxQFNE7GhS/K208OQoFCQrRWvyVLLTz6QX7TgyaScxam2nb8CnVn7/p/ss1HoHRa1q+iBKiExx9S2s24Vod7xBuvNSEfHhDL54cZqE5K7o5/cAy6BFSyqXNZcv1qbqtzbu4Ckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7XYp80oO+alYsh7K2B7NrU9jEhmeCALfu78V945Rr8=;
 b=Le9HFeDBhNtVJxwhb0J4jJ8Sj8Tnd1Kx/GcawfkelDMtGoqgzQqzmyTxQ1ASMVqJTCwQZ1jQ1Xxm7OGBRHBsnTyWjcTK6vJ0Y5Dgl6u7ScCt3fWDbKaVRvGkBcVuyT6YObARzpRUcgyXNRdzg25XsN+1/z6aDsBZY/gC01EPe+3+oGl/yt5SRbe8DJxhNTByIN307yj67qjznumGpuhIP3Clotp8nBiaaNv5O3XLgJ7uxSFoGxzTbp6yircyR+RbYQxnaZnimjiY8caJUu8LF6SpVXl7lUUgYHZ5My+izmpEhg0nTGFz9wvDuyyJuwkl6f3BpTcmk2Vm9YAf7ldjKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7XYp80oO+alYsh7K2B7NrU9jEhmeCALfu78V945Rr8=;
 b=xyWsMnxYShRWf3mAWnsMKReLMUltYBIIZRxU2Q/DgeUrOANkVzt7hj2FiFhmWz0zmdGX+bL4akbFQA3tjSrlij8m+rf4YS8EZwMpH0Ul1pepAeAnuyjOmoHcxrmiQ8huA3RfChCrFqYGIhcm+vBbcKe7HXt5ilSrC8/ttHJYTbQ=
Received: from BN6PR03CA0001.namprd03.prod.outlook.com (2603:10b6:404:23::11)
 by CY4PR03MB2581.namprd03.prod.outlook.com (2603:10b6:903:70::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Tue, 5 Nov
 2019 07:27:32 +0000
Received: from CY1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by BN6PR03CA0001.outlook.office365.com
 (2603:10b6:404:23::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.20 via Frontend
 Transport; Tue, 5 Nov 2019 07:27:31 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT024.mail.protection.outlook.com (10.152.74.210) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Tue, 5 Nov 2019 07:27:31 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xA57RUmr000511
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 4 Nov 2019 23:27:30 -0800
Received: from saturn.ad.analog.com (10.48.65.117) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 5 Nov 2019 02:27:29 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <dhobsong@igel.co.jp>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH] uio: fix irq init with dt support & irq not defined
Date:   Tue, 5 Nov 2019 09:28:07 +0200
Message-ID: <20191105072807.14420-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(136003)(199004)(189003)(2906002)(126002)(5660300002)(476003)(47776003)(50226002)(356004)(6666004)(246002)(8676002)(8936002)(14444005)(70206006)(70586007)(6916009)(4326008)(426003)(50466002)(305945005)(7636002)(36756003)(51416003)(86362001)(7696005)(2870700001)(44832011)(486006)(106002)(2616005)(336012)(478600001)(107886003)(48376002)(186003)(1076003)(316002)(54906003)(26005)(2351001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2581;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d891421-5fe1-43b2-941b-08d761c19ea6
X-MS-TrafficTypeDiagnostic: CY4PR03MB2581:
X-Microsoft-Antispam-PRVS: <CY4PR03MB258135F1C50D37ECFCE5C058F97E0@CY4PR03MB2581.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0212BDE3BE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BAXBWiJWgpMjtkYBSn8KMa1fBEirTpf2MeMf855iEXkBVApNKL2pCBXjAYmCZSJmnaBTvxy3pIdqR9m5r6yENgfWl0jvXmy+8yl/igMxik3t9ne3m2p4PkXZzezHoeT6r3XchyD9xwnykXFGUF+khjxrTTsyGJ76iICQ7G1y4aZ4ikak9vD3xnJXw8DbhPvT1U9S+7mAl7p7LrOwT6AR6Z3bKhgkhVUnOMTRbc7hEPaEh1TF+X/wo58FQDHZVojvGcOroHVvM1yJRrnYe7puFw6f0+C3EbgbcCH9OX2BJTQYjYpFvNiCtzLMQMC6oUxoNOmOi4JUTuNrCacI3eXb2JN4SSPlBk0Scbot88NMz6at5r5el+gVUyb/wOPDe6pkEgo+EwWmcHc0uC2R3JzMZt6mym8/kVwFWq1f/Y9MQgCRWJTObwQrYMew15jeBT6v
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2019 07:27:31.3343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d891421-5fe1-43b2-941b-08d761c19ea6
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2581
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-05_02:2019-11-04,2019-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1011
 mlxlogscore=999 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911050061
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
 drivers/uio/uio_dmem_genirq.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index ebcf1434e296..0a7d71d4a4f0 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -163,13 +163,6 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
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
@@ -199,8 +192,11 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
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

