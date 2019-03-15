Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B6CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0612184C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="QKyOi2YM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfCOLPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 07:15:18 -0400
Received: from mail-eopbgr740080.outbound.protection.outlook.com ([40.107.74.80]:44822
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727059AbfCOLPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 07:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxCFC8+Pdx40mGMveJmF00SE7D+UTQ2gd1Te0g6xSdA=;
 b=QKyOi2YMAEbofAnQYjlRjQPf99FfTW54BnVvMh8cONxlqXdp1eNNJwQEQL50NLG8Pubem4zs09+Y7DW7XfG+3ipp9Wse2KmWR4RXPEYLtA4g+x3VYQWCmsKlNzB+U2PaiOoDVjKlkRUVmd2hCZcNHsQM2QqpBWkDL6DAkW+RqyQ=
Received: from CY4PR03CA0018.namprd03.prod.outlook.com (2603:10b6:903:33::28)
 by SN2PR03MB2271.namprd03.prod.outlook.com (2603:10b6:804:d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13; Fri, 15 Mar
 2019 11:15:12 +0000
Received: from SN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by CY4PR03CA0018.outlook.office365.com
 (2603:10b6:903:33::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Fri, 15 Mar 2019 11:15:12 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT029.mail.protection.outlook.com (10.152.72.110) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1709.13
 via Frontend Transport; Fri, 15 Mar 2019 11:15:09 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x2FBF8cl025923
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 15 Mar 2019 04:15:09 -0700
Received: from mircea-Latitude-E6540.analog.com (10.50.3.101) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 15 Mar 2019 07:15:08 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH 2/2] staging: iio: adc: ad7192: Report error directly in ad7192_setup
Date:   Fri, 15 Mar 2019 13:14:25 +0200
Message-ID: <20190315111425.14275-2-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190315111425.14275-1-mircea.caprioru@analog.com>
References: <20190315111425.14275-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(2980300002)(199004)(189003)(51416003)(478600001)(316002)(86362001)(4326008)(5660300002)(77096007)(54906003)(8676002)(48376002)(72206003)(6666004)(53416004)(26005)(47776003)(50226002)(50466002)(36756003)(356004)(186003)(106002)(16586007)(8936002)(305945005)(107886003)(336012)(446003)(126002)(476003)(2616005)(11346002)(7636002)(44832011)(1076003)(6916009)(426003)(246002)(2906002)(106466001)(2351001)(76176011)(486006)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2271;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 353aac01-f679-470e-f8b7-08d6a9377dc3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:SN2PR03MB2271;
X-MS-TrafficTypeDiagnostic: SN2PR03MB2271:
X-Microsoft-Antispam-PRVS: <SN2PR03MB2271F6999942BEAFDCC90A4B81440@SN2PR03MB2271.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09778E995A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: QMGvMGUHkqXk2BydpotxBxKih9pNqk0xDbTPw//h+mBIRuY3dlK9mi10Pfjuf8z72CPnukUUh5OE1iPLk+UlNxAgBQd4XRx3uBZD2WMbh1IDpG73u15wvLa6P8/s+ttwJ6NyvBEzrZFwlQXxd09qquT0gyYk0l/b9OvmSz6epVm2p7wurQhlYlYaoscP99nLVUiH6tMpWHug4taHE7FesHOHTgGyvz6hgVRRvBlzoWzVtOxyM5WSmEiz9Upl8qEh1NWdEjuyLDm4SlTfNQv9Qrgy/6M3UGVbSxNzKIwb5e9eBrb3j0+DfTdUVL+q565SPqndKJwvmFWDSgC3uRQDuCCjbv9VxV4qyOZHK/bqVLMjNWWPfuEHoAfivwYD3c05EjySJdRBF/NCAUn9TgAIz4vvyhVyRg2BQa/sbY6UJHo=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2019 11:15:09.8199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 353aac01-f679-470e-f8b7-08d6a9377dc3
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2271
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the goto out statement thus ensuring that an error is
report as soon as it occurs. This gives more information and improves
readability.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 drivers/staging/iio/adc/ad7192.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index ebab75bdeed7..27f962b8c4ef 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -236,13 +236,13 @@ static int ad7192_setup(struct ad7192_state *st,
 	/* reset the serial interface */
 	ret = ad_sd_reset(&st->sd, 48);
 	if (ret < 0)
-		goto out;
+		return ret;
 	usleep_range(500, 1000); /* Wait for at least 500us */
 
 	/* write/read test for device presence */
 	ret = ad_sd_read_reg(&st->sd, AD7192_REG_ID, 1, &id);
 	if (ret)
-		goto out;
+		return ret;
 
 	id &= AD7192_ID_MASK;
 
@@ -310,15 +310,15 @@ static int ad7192_setup(struct ad7192_state *st,
 
 	ret = ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, st->conf);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = ad7192_calibrate_all(st);
 	if (ret)
-		goto out;
+		return ret;
 
 	/* Populate available ADC input ranges */
 	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++) {
@@ -332,9 +332,6 @@ static int ad7192_setup(struct ad7192_state *st,
 	}
 
 	return 0;
-out:
-	dev_err(&st->sd.spi->dev, "setup failed\n");
-	return ret;
 }
 
 static ssize_t
-- 
2.17.1

