Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2469DC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFAD32077C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="C0R75jjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbfKFLgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 06:36:12 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:49968 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725856AbfKFLgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 06:36:12 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA6BXPeg028181;
        Wed, 6 Nov 2019 06:36:06 -0500
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2050.outbound.protection.outlook.com [104.47.37.50])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w2a9yqx0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 06:36:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHS1Ah4GmvEOGHvBTojnfyiUk7vbwfNtfdB1n+p7CKhvumpYgRly6oZ7EqtviE4iOafW4iLDsZTsXshOFtuDtPkzqmK6qSmhEB2Gt3vfBuubuU3PttYJvr98p7YjQfheHiyIE8URVfyrUglq8LPRZdyI3Qlk1GEw3yBICOfQNa0xrrvbqFDApXeyd28/CogOXXodI5VXoWs1vb4ZwSSE4syx5uruVMzQePV6RWobibOsp1A8yq6U6Sjl/odXrg9buyjSCEEfUL4KM6bVC/sExAYyZ8PL1sst2Bsmu0ZkfDj7B+fOLyHLV+Ue43gRV14SZgcLmTR+RSlGF8VG03IxwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BEP0//ASSydsEG74/YfBU6cIfTc41NJyeeJ+zaoHB0=;
 b=AiAb6Mang1cB1UAyVnr1RBgcOjbnocmiwvPJzrBNqg1Kq5F0YhOpue4ue78MgvF7hh9zsaVWJCnT3aJjo7Vrg/+RsZ/a+V08/5Br8o04PH/Fg6EtTbZZL+wFjgnpmLUS1gXyRpyBd6ALmuI0XlDa5m5et0Kv2aRcrTGeL6aN/oYGrT0L5ZFy1aDdyEmssic5iFkdkUcB42M4PNDfKL8R6yXXYbbzaf4zc7vgQ1mCVC7ICtvyW85xCJo99OKO/LoGreTqRrlxW8BnDY+6R1WY4FO0MxpM241n8d5Bk5YDwztPTrcTxhZypQZA/iwnNkq+LY3MmPri5yeEkANplpjLBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BEP0//ASSydsEG74/YfBU6cIfTc41NJyeeJ+zaoHB0=;
 b=C0R75jjmS5m837IJvvsYbzy8ZL9ahxaivqdrSxcfzY1XGief22DIHUWj/vtqZ3iLcM304C4PKEA9nG7U58pA2FZP6E4XIsjuN3y8eaZwD2DgnxJZX39TNCy8fuDPxuNtCE7Cp7DxXIKbYbrOQtDT4USY1/Yn2HKf/cF3IyqnLaQ=
Received: from MWHPR03CA0006.namprd03.prod.outlook.com (2603:10b6:300:117::16)
 by BN7PR03MB3585.namprd03.prod.outlook.com (2603:10b6:406:c3::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Wed, 6 Nov
 2019 11:36:04 +0000
Received: from SN1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by MWHPR03CA0006.outlook.office365.com
 (2603:10b6:300:117::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20 via Frontend
 Transport; Wed, 6 Nov 2019 11:36:03 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT063.mail.protection.outlook.com (10.152.72.213) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Wed, 6 Nov 2019 11:36:03 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xA6Ba1vW003535
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 6 Nov 2019 03:36:01 -0800
Received: from saturn.ad.analog.com (10.48.65.117) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 6 Nov 2019 06:36:01 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sboyd@kernel.org>, <mturquette@baylibre.com>, <jsarha@ti.com>,
        <ce3a@gmx.de>, Michael Hennerich <michael.hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] clk: clk-gpio: Add dt option to propagate rate change to parent
Date:   Wed, 6 Nov 2019 13:35:51 +0200
Message-ID: <20191106113551.5557-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(189003)(199004)(8676002)(8936002)(86362001)(476003)(126002)(70206006)(2616005)(426003)(36756003)(305945005)(26005)(186003)(356004)(336012)(50466002)(486006)(246002)(6666004)(106002)(110136005)(54906003)(48376002)(316002)(2870700001)(7636002)(2906002)(50226002)(47776003)(44832011)(51416003)(7696005)(1076003)(5660300002)(4326008)(107886003)(478600001)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3585;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45082c29-c45b-4e2c-941a-08d762ad8178
X-MS-TrafficTypeDiagnostic: BN7PR03MB3585:
X-Microsoft-Antispam-PRVS: <BN7PR03MB358565D6FE5A01739EE5D627F9790@BN7PR03MB3585.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-Forefront-PRVS: 02135EB356
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fp3LJ7gCbajcWXWROLp1sszCKnnAT9HwcxGNzWFhjY4+zykjj54/c3tPJghsD1VVUQ3mKXvWYryeD1zeumc/GLYH6kWi9sjRZBGugHcdsEzhQx6LJW2HxPH5HxD6QKL6l3wGxgVwarvCGZ4CnfIo+jY+jT2lA+q5wQNLNbat1bND3w0+yq9IZPxynkEPLVC5yBLk2v5kFBQ/BymX2Cs9i5jJwg07t/tcQOV3C4p3giu4Ps36PSPqcrtVA+okP4sbrSwplhMhwtsTzOfTnXIUqm8pNv74diJTTJsQSpU8FjCUavHsb4Ks8Cq8k8RsJW0RpRlbxjyIkPk7TsLxHbOTtUvHQjy9ifQ7vCFQ4u2/D0WuR9buGYAazAb7jNpc88u36ymS8eC7/R3ptR25BYTssnKNGZI0pk7iaSm9e+qqjLPP6AucGVrbdJ6QJIccczOE
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2019 11:36:03.5970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45082c29-c45b-4e2c-941a-08d762ad8178
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3585
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_03:2019-11-06,2019-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=892
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911060118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

For certain setups/boards it's useful to propagate the rate change of the
clock up one level to the parent clock.

This change implements this by defining a `clk-set-rate-parent` device-tree
property which sets the `CLK_SET_RATE_PARENT` flag to the clock (when set).

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/clk/clk-gpio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index 9d930edd6516..6dfbc4b952fe 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -241,6 +241,7 @@ static int gpio_clk_driver_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	const char **parent_names, *gpio_name;
 	unsigned int num_parents;
+	unsigned long clk_flags;
 	struct gpio_desc *gpiod;
 	struct clk *clk;
 	bool is_mux;
@@ -274,13 +275,16 @@ static int gpio_clk_driver_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	clk_flags = of_property_read_bool(node, "clk-set-rate-parent") ?
+			CLK_SET_RATE_PARENT : 0;
+
 	if (is_mux)
 		clk = clk_register_gpio_mux(&pdev->dev, node->name,
-				parent_names, num_parents, gpiod, 0);
+				parent_names, num_parents, gpiod, clk_flags);
 	else
 		clk = clk_register_gpio_gate(&pdev->dev, node->name,
 				parent_names ?  parent_names[0] : NULL, gpiod,
-				0);
+				clk_flags);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-- 
2.20.1

