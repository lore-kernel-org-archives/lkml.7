Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE76AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9174121871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="KUiAKMhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfCOL3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 07:29:21 -0400
Received: from mail-eopbgr770058.outbound.protection.outlook.com ([40.107.77.58]:3982
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726503AbfCOL3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 07:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8Yxv7GbyKkteUmd4avBcIOP/FL9TRzUmLNz1N5nZXM=;
 b=KUiAKMhzX5xzPDV6zf/IKzaBFndR7Rzg98JLguk+idaKW6TcJvPJ3mKwG00PC+1S8C+5b5fkSKxN8UcvP0LtT90v74hCkw8htT5DsgeFg+7eq0xgeyCz2lZ002ziAcDcEFklL9lOMzLrL5S9C2UpH2+eWAKnRmWvEA8JlFtSCkE=
Received: from BN6PR03CA0010.namprd03.prod.outlook.com (2603:10b6:404:23::20)
 by BLUPR03MB551.namprd03.prod.outlook.com (2a01:111:e400:882::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Fri, 15 Mar
 2019 11:29:15 +0000
Received: from BL2NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by BN6PR03CA0010.outlook.office365.com
 (2603:10b6:404:23::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13 via Frontend
 Transport; Fri, 15 Mar 2019 11:29:15 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT014.mail.protection.outlook.com (10.152.76.154) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1709.13
 via Frontend Transport; Fri, 15 Mar 2019 11:29:13 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x2FBTC8m008748
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 15 Mar 2019 04:29:12 -0700
Received: from mircea-Latitude-E6540.analog.com (10.50.3.101) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 15 Mar 2019 07:29:11 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH 1/2] staging: iio: adc: ad7192: Use DT clock binding
Date:   Fri, 15 Mar 2019 13:29:02 +0200
Message-ID: <20190315112903.15855-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(136003)(2980300002)(199004)(189003)(50226002)(77096007)(16586007)(54906003)(7696005)(476003)(51416003)(2616005)(47776003)(126002)(106002)(486006)(316002)(426003)(106466001)(14444005)(36756003)(6666004)(53416004)(2351001)(8936002)(44832011)(107886003)(478600001)(356004)(2906002)(1076003)(246002)(4326008)(8676002)(50466002)(48376002)(305945005)(72206003)(26005)(7636002)(186003)(86362001)(6916009)(336012)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB551;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2a953da-dd7c-4d43-b152-08d6a939745d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BLUPR03MB551;
X-MS-TrafficTypeDiagnostic: BLUPR03MB551:
X-Microsoft-Antispam-PRVS: <BLUPR03MB551E75583BAC060B99F309881440@BLUPR03MB551.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09778E995A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: bIH1NtI8M6kNOcWiz4iMwu0i9dVnZR9uoNZiUBlnY6oqTuvsILvpGoEK5wlehJkjldixj3VHr+9gVoQucC5nWJqkTBtB1hjwQke2EUURD5XWCkgYlU3GAYiUwRKGMVN6HqD/pK6RCWJQig7YyABKlQ2Oj5/rt3GhMZ0MehjAupBnxDt/h7TRCfqT84bnZ7gaubS/YqiDWd+t4L7tZ4Ewr8L/YKh8lWvGumHvZUCH0XwqDbyMSKnTQH096zRoYbk6hd32O75EhLNePxUzqwmd54gCRrpJnXs4Fdmf8qSZPMg6KR0Hoxo4upQi+V10IQ6IDNsCU4PLdisDgNprjUEsm+PddivzspL8PsANdg8pdnTHSDPX+cWjcM4KhtMZEAFal7msEka2lfhNn0FYfhLrtX0wgC3Q6A8ukIldiLxRE14=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2019 11:29:13.1465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a953da-dd7c-4d43-b152-08d6a939745d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces the platform data clock select member with DT clock
binding. Through the DT the external clock binding is specified. If this is
not provided then the device will use the internal clock source.

With the external clock binding there is the option to use a clock or a
crystal as the clock source. When an external crystal is used it is
connected to MCLK1 and MCLK2 pins. If the external clock is used only MCLK2
pin will be connected.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 drivers/staging/iio/adc/ad7192.c | 84 ++++++++++++++++++++++----------
 drivers/staging/iio/adc/ad7192.h |  2 -
 2 files changed, 58 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 27f962b8c4ef..5c54ce380fa5 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/interrupt.h>
+#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -156,14 +157,16 @@
 struct ad7192_state {
 	struct regulator		*avdd;
 	struct regulator		*dvdd;
+	struct clk			*mclk;
 	u16				int_vref_mv;
-	u32				mclk;
+	u32				fclk;
 	u32				f_order;
 	u32				mode;
 	u32				conf;
 	u32				scale_avail[8][2];
 	u8				gpocon;
 	u8				devid;
+	u8				clock_sel;
 	struct mutex			lock;	/* protect sensor state */
 
 	struct ad_sigma_delta		sd;
@@ -226,6 +229,27 @@ static inline bool ad7192_valid_external_frequency(u32 freq)
 		freq <= AD7192_EXT_FREQ_MHZ_MAX);
 }
 
+static int ad7192_of_clock_select(struct ad7192_state *st)
+{
+	struct device_node *np = st->sd.spi->dev.of_node;
+	unsigned int clock_sel;
+
+	clock_sel = AD7192_CLK_INT;
+
+	/* use internal clock */
+	if (PTR_ERR(st->mclk) == -ENOENT) {
+		if (of_property_read_bool(np, "adi,int-clock-output-enable"))
+			clock_sel = AD7192_CLK_INT_CO;
+	} else {
+		if (of_property_read_bool(np, "adi,clock-xtal"))
+			clock_sel = AD7192_CLK_EXT_MCLK1_2;
+		else
+			clock_sel = AD7192_CLK_EXT_MCLK2;
+	}
+
+	return clock_sel;
+}
+
 static int ad7192_setup(struct ad7192_state *st,
 			const struct ad7192_platform_data *pdata)
 {
@@ -250,28 +274,8 @@ static int ad7192_setup(struct ad7192_state *st,
 		dev_warn(&st->sd.spi->dev, "device ID query failed (0x%X)\n",
 			 id);
 
-	switch (pdata->clock_source_sel) {
-	case AD7192_CLK_INT:
-	case AD7192_CLK_INT_CO:
-		st->mclk = AD7192_INT_FREQ_MHZ;
-		break;
-	case AD7192_CLK_EXT_MCLK1_2:
-	case AD7192_CLK_EXT_MCLK2:
-		if (ad7192_valid_external_frequency(pdata->ext_clk_hz)) {
-			st->mclk = pdata->ext_clk_hz;
-			break;
-		}
-		dev_err(&st->sd.spi->dev, "Invalid frequency setting %u\n",
-			pdata->ext_clk_hz);
-		ret = -EINVAL;
-		goto out;
-	default:
-		ret = -EINVAL;
-		goto out;
-	}
-
 	st->mode = AD7192_MODE_SEL(AD7192_MODE_IDLE) |
-		AD7192_MODE_CLKSRC(pdata->clock_source_sel) |
+		AD7192_MODE_CLKSRC(st->clock_sel) |
 		AD7192_MODE_RATE(480);
 
 	st->conf = AD7192_CONF_GAIN(0);
@@ -496,7 +500,7 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 			*val -= 273 * ad7192_get_temp_scale(unipolar);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = st->mclk /
+		*val = st->fclk /
 			(st->f_order * 1024 * AD7192_MODE_RATE(st->mode));
 		return IIO_VAL_INT;
 	}
@@ -543,7 +547,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 			break;
 		}
 
-		div = st->mclk / (val * st->f_order * 1024);
+		div = st->fclk / (val * st->f_order * 1024);
 		if (div < 1 || div > 1023) {
 			ret = -EINVAL;
 			break;
@@ -706,15 +710,42 @@ static int ad7192_probe(struct spi_device *spi)
 	if (ret)
 		goto error_disable_dvdd;
 
+	st->fclk = AD7192_INT_FREQ_MHZ;
+
+	st->mclk = devm_clk_get(&st->sd.spi->dev, "mclk");
+	if (IS_ERR(st->mclk) && PTR_ERR(st->mclk) != -ENOENT) {
+		ret = PTR_ERR(st->mclk);
+		goto error_remove_trigger;
+	}
+
+	st->clock_sel = ad7192_of_clock_select(st);
+
+	if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
+	    st->clock_sel == AD7192_CLK_EXT_MCLK2) {
+		ret = clk_prepare_enable(st->mclk);
+		if (ret < 0)
+			goto error_remove_trigger;
+
+		st->fclk = clk_get_rate(st->mclk);
+		if (!ad7192_valid_external_frequency(st->fclk)) {
+			ret = -EINVAL;
+			dev_err(&spi->dev,
+				"External clock frequency out of bounds\n");
+			goto error_disable_clk;
+		}
+	}
+
 	ret = ad7192_setup(st, pdata);
 	if (ret)
-		goto error_remove_trigger;
+		goto error_disable_clk;
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
-		goto error_remove_trigger;
+		goto error_disable_clk;
 	return 0;
 
+error_disable_clk:
+	clk_disable_unprepare(st->mclk);
 error_remove_trigger:
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 error_disable_dvdd:
@@ -731,6 +762,7 @@ static int ad7192_remove(struct spi_device *spi)
 	struct ad7192_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
+	clk_disable_unprepare(st->mclk);
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 
 	regulator_disable(st->dvdd);
diff --git a/drivers/staging/iio/adc/ad7192.h b/drivers/staging/iio/adc/ad7192.h
index 7433a43c2611..3be3ee269ed5 100644
--- a/drivers/staging/iio/adc/ad7192.h
+++ b/drivers/staging/iio/adc/ad7192.h
@@ -33,8 +33,6 @@
 
 struct ad7192_platform_data {
 	u16		vref_mv;
-	u8		clock_source_sel;
-	u32		ext_clk_hz;
 	bool		refin2_en;
 	bool		rej60_en;
 	bool		sinc3_en;
-- 
2.17.1

