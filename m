Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD4CC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B4920656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="KAPMZp3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfDVODd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 10:03:33 -0400
Received: from mail-eopbgr740075.outbound.protection.outlook.com ([40.107.74.75]:23738
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726098AbfDVODc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 10:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbJvTC3aeAC9dDJgiOliRR849yDHfz+F7WTYIp3x5As=;
 b=KAPMZp3b1goGv4uKAqvI+KQcC3yHUPMLfdzaEr8HP0TNSXRziyUDTbHr0PyFIpsZveQ/iCyxQYLcSfsLin5KYLxNtZPfvgbOIF7/s6MkfYUB7WBafZNrWyDqeWu1Kk3Mxp1Nw0Q1Ml9zMs9BLdywwnnL5KC+OBWfk/6LteX0z1c=
Received: from DM6PR03CA0060.namprd03.prod.outlook.com (2603:10b6:5:100::37)
 by BLUPR03MB552.namprd03.prod.outlook.com (2a01:111:e400:883::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1813.14; Mon, 22 Apr
 2019 14:03:29 +0000
Received: from BL2NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by DM6PR03CA0060.outlook.office365.com
 (2603:10b6:5:100::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1813.12 via Frontend
 Transport; Mon, 22 Apr 2019 14:03:28 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT053.mail.protection.outlook.com (10.152.76.225) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Mon, 22 Apr 2019 14:03:28 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x3ME3S4B012304
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 22 Apr 2019 07:03:28 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Mon, 22 Apr 2019
 10:03:27 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <andriy.shevchenko@linux.intel.com>,
        <namhyung@kernel.org>, <mingo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/2][V2] iio: Handle enumerated properties with gaps
Date:   Mon, 22 Apr 2019 17:03:23 +0300
Message-ID: <20190422140323.9120-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190422083257.21805-2-alexandru.ardelean@analog.com>
References: <20190422083257.21805-2-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(376002)(2980300002)(189003)(199004)(107886003)(50226002)(4326008)(126002)(486006)(86362001)(2906002)(7636002)(53416004)(305945005)(246002)(48376002)(44832011)(8936002)(50466002)(8676002)(47776003)(77096007)(478600001)(110136005)(186003)(76176011)(26005)(51416003)(316002)(16586007)(6666004)(356004)(70586007)(106002)(70206006)(1076003)(54906003)(36756003)(426003)(476003)(336012)(7696005)(2616005)(11346002)(5660300002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB552;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6b447e0-679e-42bf-123d-08d6c72b4ba1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BLUPR03MB552;
X-MS-TrafficTypeDiagnostic: BLUPR03MB552:
X-Microsoft-Antispam-PRVS: <BLUPR03MB5529E7E52EA12238C10A5D4F9220@BLUPR03MB552.namprd03.prod.outlook.com>
X-Forefront-PRVS: 00159D1518
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: vZhi1MyR8e705gmw4DqiJ9/0mfBeEMQmJD43Ga1Xo0RThPXmuaDKJ66hziLU2mz0z7PPaGNQDHDuGK19+ZxH8X7ZU0N7zP9gtg70euWqzK0Mgm87K9T2pjkrgCKEIkp2cOejwONJXKQaLzLmJIDyRNrHoXpl7i+B2X2gRgwzgRYoKpzK5hNI5buDGCRFwZhqls8JeXXnQCIUVHCjR1+TKhLLRaHZgIU6VvEzGG3bTmi0ighFjOG8FkSCj7BDPJNZ3cAFmf7mkCu11L8NYzjcUK7FOu2p0a2U+zrID0GRDigfw+qcWADIxma0atogLX93DyzY38EgzClU4PE02ZBrwKmgTSjZ/KkhLEUumAx+5ibZgNrJMuLkGMYRRUFnXLB5eaexTMaTW4zcwj7I+mjDer2ab2aRA4kfiwHhmXaUQ8M=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2019 14:03:28.4861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b447e0-679e-42bf-123d-08d6c72b4ba1
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB552
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Some enums might have gaps or reserved values in the middle of their value
range. E.g. consider a 2-bit enum where the values 0, 1 and 3 have a
meaning, but 2 is a reserved value and can not be used.

Add support for such enums to the IIO enum helper functions. A reserved
values is marked by setting its entry in the items array to NULL rather
than the normal descriptive string value.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f2ebca65f964..e848b35bd9c0 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -447,8 +447,11 @@ ssize_t iio_enum_available_read(struct iio_dev *indio_dev,
 	if (!e->num_items)
 		return 0;
 
-	for (i = 0; i < e->num_items; ++i)
+	for (i = 0; i < e->num_items; ++i) {
+		if (!e->items[i])
+			continue;
 		len += scnprintf(buf + len, PAGE_SIZE - len, "%s ", e->items[i]);
+	}
 
 	/* replace last space with a newline */
 	buf[len - 1] = '\n';
@@ -469,7 +472,7 @@ ssize_t iio_enum_read(struct iio_dev *indio_dev,
 	i = e->get(indio_dev, chan);
 	if (i < 0)
 		return i;
-	else if (i >= e->num_items)
+	else if (i >= e->num_items || !e->items[i])
 		return -EINVAL;
 
 	return snprintf(buf, PAGE_SIZE, "%s\n", e->items[i]);
@@ -486,7 +489,7 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
 	if (!e->set)
 		return -EINVAL;
 
-	ret = __sysfs_match_string(e->items, e->num_items, buf);
+	ret = __sysfs_match_string_with_gaps(e->items, e->num_items, buf);
 	if (ret < 0)
 		return ret;
 
-- 
2.17.1

