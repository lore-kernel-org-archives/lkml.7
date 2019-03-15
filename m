Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B834BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A23321871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="EIfEZcNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfCOL3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 07:29:35 -0400
Received: from mail-eopbgr780047.outbound.protection.outlook.com ([40.107.78.47]:40439
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727553AbfCOL3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 07:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WADb2XkRjRqBoQMxI9IQb8edvNfMsMpwdkP8qBQ1eo=;
 b=EIfEZcNMgZu3uwCTG3GDFIgWT+26bQye0yMhV6JjsLkY+axIw21OmRUa6luTUCXHPdKPrbbmkJPjrCb6U/zuJetuFLM7k6DnZaQV7JtF8rRrX1z+q1iqT3pfhoS4ceNghTb8yY5WEVxqmjmVL9t9Vv4nv04UaKQuNcr6grom1tw=
Received: from BN6PR03CA0095.namprd03.prod.outlook.com (10.164.122.161) by
 BL2PR03MB548.namprd03.prod.outlook.com (10.141.91.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Fri, 15 Mar 2019 11:29:29 +0000
Received: from BL2NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BN6PR03CA0095.outlook.office365.com
 (2603:10b6:405:6f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13 via Frontend
 Transport; Fri, 15 Mar 2019 11:29:29 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT035.mail.protection.outlook.com (10.152.77.157) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1709.13
 via Frontend Transport; Fri, 15 Mar 2019 11:29:22 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x2FBTLFR008781
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 15 Mar 2019 04:29:21 -0700
Received: from mircea-Latitude-E6540.analog.com (10.50.3.101) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 15 Mar 2019 07:29:21 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH 2/2] staging: iio: adc: ad7192: Convert platform data to DT properties
Date:   Fri, 15 Mar 2019 13:29:03 +0200
Message-ID: <20190315112903.15855-2-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190315112903.15855-1-mircea.caprioru@analog.com>
References: <20190315112903.15855-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(2980300002)(189003)(199004)(72206003)(8676002)(50466002)(6916009)(486006)(7696005)(2616005)(106002)(7636002)(246002)(8936002)(47776003)(478600001)(51416003)(4326008)(6666004)(336012)(48376002)(426003)(305945005)(5660300002)(356004)(36756003)(50226002)(44832011)(107886003)(76176011)(86362001)(446003)(77096007)(2906002)(26005)(11346002)(186003)(106466001)(476003)(126002)(316002)(53416004)(54906003)(14444005)(2351001)(1076003)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB548;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd582063-3e31-4080-dfcc-08d6a9397c48
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BL2PR03MB548;
X-MS-TrafficTypeDiagnostic: BL2PR03MB548:
X-Microsoft-Antispam-PRVS: <BL2PR03MB5483529FA30BFB87340652F81440@BL2PR03MB548.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09778E995A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: GuyGEbGhNh+ot3w6fB3Bxcrgmb4iPuU2+69fMGL+1Od8+Y2qikEWIRIHlejdEudB+7dpd9Osjx0jG7K8pizwSYl5Im9+xsapoEh24nBhVvQX3G2eOGR3WK78BukQ47074t6KaDzEr4lT0CvdLuqDDZHH3a8oMKR0hm+YQlqdRvex6j21RrB4n3rq5/NWl4CbOLQP7Nro3OUJv37LGmb6j99DKWwnbwVjGoJRvMyTXE2opUAcO1PtB0eMMeljolEiGIZcrsMvjkwU1GoYN5ZOGu4ftGuuuyEwdo7KT0NF+Zj4IQzwj73RCV2nlleObNaZUtz96klMfmcFgvORoiWvJ9qvGxjBubCzJ97Elx5jUOmQZ0GO/pQBxHaRsGQ4Ubyr8WmloKs/8/F1+U1dqTT8KkRclHi9B72Yd6GaEJeo5Kw=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2019 11:29:22.4843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd582063-3e31-4080-dfcc-08d6a9397c48
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB548
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will remove platform data members and replace them with device
tree properties. These properties will be subject to further modifications
and probably replaced with other functionalities at some point in time.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 drivers/staging/iio/adc/ad7192.c | 33 ++++++++++++++++++++------------
 drivers/staging/iio/adc/ad7192.h |  7 -------
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 5c54ce380fa5..c56eaefbbe41 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -250,10 +250,11 @@ static int ad7192_of_clock_select(struct ad7192_state *st)
 	return clock_sel;
 }
 
-static int ad7192_setup(struct ad7192_state *st,
-			const struct ad7192_platform_data *pdata)
+static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(st->sd.spi);
+	bool rej60_en, sinc3_en, refin2_en, chop_en;
+	bool buf_en, bipolar, burnout_curr_en;
 	unsigned long long scale_uv;
 	int i, ret, id;
 
@@ -280,18 +281,22 @@ static int ad7192_setup(struct ad7192_state *st,
 
 	st->conf = AD7192_CONF_GAIN(0);
 
-	if (pdata->rej60_en)
+	rej60_en = of_property_read_bool(np, "adi,rejection-60-Hz-enable");
+	if (rej60_en)
 		st->mode |= AD7192_MODE_REJ60;
 
-	if (pdata->sinc3_en)
+	sinc3_en = of_property_read_bool(np, "adi,sinc3-filter-enable");
+	if (sinc3_en)
 		st->mode |= AD7192_MODE_SINC3;
 
-	if (pdata->refin2_en && st->devid != ID_AD7195)
+	refin2_en = of_property_read_bool(np, "adi,refin2-pins-enable");
+	if (refin2_en && st->devid != ID_AD7195)
 		st->conf |= AD7192_CONF_REFSEL;
 
-	if (pdata->chop_en) {
+	chop_en = of_property_read_bool(np, "adi,chop-enable");
+	if (chop_en) {
 		st->conf |= AD7192_CONF_CHOP;
-		if (pdata->sinc3_en)
+		if (sinc3_en)
 			st->f_order = 3; /* SINC 3rd order */
 		else
 			st->f_order = 4; /* SINC 4th order */
@@ -299,15 +304,19 @@ static int ad7192_setup(struct ad7192_state *st,
 		st->f_order = 1;
 	}
 
-	if (pdata->buf_en)
+	buf_en = of_property_read_bool(np, "adi,buffer-enable");
+	if (buf_en)
 		st->conf |= AD7192_CONF_BUF;
 
-	if (pdata->unipolar_en)
+	bipolar = of_property_read_bool(np, "bipolar");
+	if (!bipolar)
 		st->conf |= AD7192_CONF_UNIPOLAR;
 
-	if (pdata->burnout_curr_en && pdata->buf_en && !pdata->chop_en) {
+	burnout_curr_en = of_property_read_bool(np,
+						"adi,burnout-currents-enable");
+	if (burnout_curr_en && buf_en && !chop_en) {
 		st->conf |= AD7192_CONF_BURN;
-	} else if (pdata->burnout_curr_en) {
+	} else if (burnout_curr_en) {
 		dev_warn(&st->sd.spi->dev,
 			 "Can't enable burnout currents: see CHOP or buffer\n");
 	}
@@ -735,7 +744,7 @@ static int ad7192_probe(struct spi_device *spi)
 		}
 	}
 
-	ret = ad7192_setup(st, pdata);
+	ret = ad7192_setup(st, spi->dev.of_node);
 	if (ret)
 		goto error_disable_clk;
 
diff --git a/drivers/staging/iio/adc/ad7192.h b/drivers/staging/iio/adc/ad7192.h
index 3be3ee269ed5..aa3322c14e38 100644
--- a/drivers/staging/iio/adc/ad7192.h
+++ b/drivers/staging/iio/adc/ad7192.h
@@ -33,13 +33,6 @@
 
 struct ad7192_platform_data {
 	u16		vref_mv;
-	bool		refin2_en;
-	bool		rej60_en;
-	bool		sinc3_en;
-	bool		chop_en;
-	bool		buf_en;
-	bool		unipolar_en;
-	bool		burnout_curr_en;
 };
 
 #endif /* IIO_ADC_AD7192_H_ */
-- 
2.17.1

