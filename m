Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5E0C5DF65
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B337A214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="LpNt4tqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbfKFMCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 07:02:55 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:17432 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729671AbfKFMCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 07:02:54 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA6BrKKY011139;
        Wed, 6 Nov 2019 07:02:29 -0500
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2054.outbound.protection.outlook.com [104.47.41.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w2a5rqbtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 07:02:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2Xz2/BcI7SKxbJth96DxcHTgHm85Hj5Rtrl1Xe19gHn3Bhi+K2E+07G97TW/Oddv+Ogh5CWDCRmroui/wsMzVh1cOk5G1vAsY7IlMAfNWZxL6qDRhWwRNwARPQfUN2KfEAhmL1PnDbwhIDvVwT4ydjfHd/do8D29xhE9GY7+S62lOCnFPdb/E23ZOmoJ3dt0I8uoDtqLE6hmuZbQEOSVDIIaoSaw52sQfOHJ/g5Am4ZpIHERntEGsOekDsn8hWaNLOiGuSlf8QcIB9X22QqBxyYZTC0uKwZOO0PORWYaR5Xdzkh4GX7qptcr/1io7Yzcxq+STeu1bblHP9PLtKzew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Icw1DLwKVIlabD5X2NZjvcB3oTqvQN1/67h7TLklTug=;
 b=Vlg/Q0q7Igc4p597TI4NF0eyo/cK1XXyvuX/xKYlzRiZvA71uCj36If5RgPjMka7Ecisq0TlD0waDWnWlCWpNHf6aGVVUyfR4AMuxqoUEQsWJdOnaiU4p7HaTx5797gkTBQnAIJHvM7FlOAnlDdcnTu3yL/DGXYTIUGVZt3O7JhS42hvkf8Rpx6PIaDq+Y1Vs2Xybue3Upt0i4EJcqse6xgtUs+T6fQAcnlQJ1ECplh8OPJQ0DmPE2zbOSxSS/IKS3YgDGwtEMZSrX3BcSWsOTnlw+VRyIMduaaLLJAYdCaxROCAT4/tEFMh73raHUPGU70kCJgWoPzjI3lWd2ndtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Icw1DLwKVIlabD5X2NZjvcB3oTqvQN1/67h7TLklTug=;
 b=LpNt4tqAaDAmTKrkwicUVFHlEIUHUykLJvxbMD9o8tisIcpZPlITDERfaInVHloTH4gBa6kNUh8or8dhElF6RGtdE+5cWSp9YC6kuNKA4wW99Mmce2b1zjvXUVq5mZ0bCsaSGTJrP5OCjzPJsvcXgluwsVhg2MXkDvfur54FGbs=
Received: from BYAPR03CA0028.namprd03.prod.outlook.com (2603:10b6:a02:a8::41)
 by MN2PR03MB5231.namprd03.prod.outlook.com (2603:10b6:208:1e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Wed, 6 Nov
 2019 12:02:27 +0000
Received: from CY1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by BYAPR03CA0028.outlook.office365.com
 (2603:10b6:a02:a8::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24 via Frontend
 Transport; Wed, 6 Nov 2019 12:02:27 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT033.mail.protection.outlook.com (10.152.75.179) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Wed, 6 Nov 2019 12:02:26 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xA6C2HSr010827
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 6 Nov 2019 04:02:17 -0800
Received: from saturn.ad.analog.com (10.48.65.117) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 6 Nov 2019 07:02:25 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <mina86@mina86.com>, Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] usb: gadget: ffs: ffs_aio_cancel(): Save/restore IRQ flags
Date:   Wed, 6 Nov 2019 14:02:19 +0200
Message-ID: <20191106120219.15028-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(199004)(189003)(2616005)(50226002)(7636002)(50466002)(476003)(486006)(14444005)(70586007)(70206006)(336012)(1076003)(126002)(86362001)(8676002)(246002)(6666004)(478600001)(47776003)(426003)(186003)(54906003)(51416003)(316002)(7696005)(110136005)(106002)(8936002)(356004)(48376002)(36756003)(107886003)(26005)(5660300002)(2906002)(2870700001)(4326008)(44832011)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB5231;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df58e0c0-ae3b-4d92-c68f-08d762b1312e
X-MS-TrafficTypeDiagnostic: MN2PR03MB5231:
X-Microsoft-Antispam-PRVS: <MN2PR03MB52312519F9D19BBB2AE7524BF9790@MN2PR03MB5231.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 02135EB356
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RiCdJXhynu0TWKSxn1ttsh22yVPaWmqOQo0HiLwT9xQ9OHrSw+Jia1m/OYdhsoKd3yjTI0qpj+stxYrLM96YPuxkHYCo+f1QXqDc4sr482MOGmx/K/uscyBrHDBDuEbb+urlx6o9qD9mzJLg+2uwGeBqvBpcDYlf320BPa7kSfmkotucNHQZAVoYn5Wx8Lr1MXpfdCkGk9xsgp6EGtYbh0wiMW+B8fF/nUchCOAnDiMrNnmaMEpR7nr6HS7FXv/Fg9xwSEMU67C0VSEkPGxHEG/zNLZw0C9pb+JB4ItjkytV8n9EjHO3aVVjCGSGUPsuazcu+MirmC1Q98n8L5eFAS5l3a820WaqqKx/GV8yIT4lr/WJdqGDmm2s0RlZF3nJK1tr+qF+DXDw6XIB9YiHegRvX0JsVaNZNlljKhFGDgLb19T57yml7j/4sJZEkNOB
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2019 12:02:26.8836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df58e0c0-ae3b-4d92-c68f-08d762b1312e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5231
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_03:2019-11-06,2019-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1011
 mlxlogscore=557 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911060119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

ffs_aio_cancel() can be called from both interrupt and thread context. Make
sure that the current IRQ state is saved and restored by using
spin_{un,}lock_irq{save,restore}().

Otherwise undefined behavior might occur.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/usb/gadget/function/f_fs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 59d9d512dcda..ed3bcbb84b95 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1160,18 +1160,19 @@ static int ffs_aio_cancel(struct kiocb *kiocb)
 {
 	struct ffs_io_data *io_data = kiocb->private;
 	struct ffs_epfile *epfile = kiocb->ki_filp->private_data;
+	unsigned long flags;
 	int value;
 
 	ENTER();
 
-	spin_lock_irq(&epfile->ffs->eps_lock);
+	spin_lock_irqsave(&epfile->ffs->eps_lock, flags);
 
 	if (likely(io_data && io_data->ep && io_data->req))
 		value = usb_ep_dequeue(io_data->ep, io_data->req);
 	else
 		value = -EINVAL;
 
-	spin_unlock_irq(&epfile->ffs->eps_lock);
+	spin_unlock_irqrestore(&epfile->ffs->eps_lock, flags);
 
 	return value;
 }
-- 
2.20.1

