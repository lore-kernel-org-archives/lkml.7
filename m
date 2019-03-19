Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CF7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072912147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="TWDCbgke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfCSOZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:25:42 -0400
Received: from mail-eopbgr750072.outbound.protection.outlook.com ([40.107.75.72]:10820
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbfCSOZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3cvyV3SYLQIeNt3X2imhYZxHJfBDpyg774ANLvJxM8=;
 b=TWDCbgkeQ6GE03MVPKp3jhTFdYIq+CLtv+Mlb/wCPFbMK2EO28+TqtD2wh7kLAvDbMNcITPrSt22xzC6keTltLVX0Ykl9nNDk0aoy7I+LKhOpyGZ0lx6nmqCnxuP6SbT4/XE2FoJTOBh/o7kK17Gyx8deTjQJB3KzDgPz9K7ZI0=
Received: from MWHPR03CA0060.namprd03.prod.outlook.com (2603:10b6:301:3b::49)
 by MWHPR03MB3134.namprd03.prod.outlook.com (2603:10b6:301:3c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.15; Tue, 19 Mar
 2019 14:25:37 +0000
Received: from SN1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by MWHPR03CA0060.outlook.office365.com
 (2603:10b6:301:3b::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Tue, 19 Mar 2019 14:25:37 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT048.mail.protection.outlook.com (10.152.72.202) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Tue, 19 Mar 2019 14:25:36 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x2JEPZVS027372
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 19 Mar 2019 07:25:35 -0700
Received: from mircea-Latitude-E6540.analog.com (10.50.3.101) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 19 Mar 2019 10:25:34 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH] staging: iio: adc: ad7192: Use read_avail for available attributes
Date:   Tue, 19 Mar 2019 16:25:20 +0200
Message-ID: <20190319142520.664-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(376002)(396003)(2980300002)(189003)(199004)(106466001)(8676002)(126002)(53416004)(86362001)(2351001)(50226002)(476003)(6666004)(486006)(5660300002)(1076003)(4326008)(356004)(6916009)(36756003)(7636002)(7696005)(336012)(48376002)(14444005)(51416003)(44832011)(47776003)(107886003)(478600001)(54906003)(72206003)(186003)(2906002)(305945005)(106002)(316002)(16586007)(8936002)(26005)(50466002)(246002)(77096007)(426003)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3134;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a42e2b7-1b41-47f1-b435-08d6ac76c110
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4608103)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:MWHPR03MB3134;
X-MS-TrafficTypeDiagnostic: MWHPR03MB3134:
X-Microsoft-Antispam-PRVS: <MWHPR03MB31344EDC86802C34FA77526781400@MWHPR03MB3134.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ZLSz0gQTtaeEwxpXA9VqaEjIEYGeLXsLAf0Y/JPx94XDF6sYqGVBuQnQZdzWAokb9JzKnV2lMTbF57IPEZOWHXcZ4YIq1Qhhvz9FrKVrHrj/KNz87dkUQdtMShsR6WBlUNp6vl1YVjpzBjZNpCvHjeY2YfHXex2aM1tDbg7dwOV+6PI0xBXOv3q35Po1s2HDHivQx0ytruhVRbc4eCdHhEz09GTEFAfAqAnvYtNoNV2UwAeend+swfts2HO80KyC9+6k3spvflyXr1ivj3t7Jjt0k6Ja/DBYSaZekOs9Q+D8iRBLBdiNC7Q2Qpz6dYJ6bxRO8GqgeAbr4pdwy8VNSO2eXlje2vn+J9NJb37l46qwUm2lkHdLUKHPhwZw663XjLFcs9DIxFXWmuumipvira89Zmw2Tvqlv8fJV9P1OLU=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 14:25:36.1887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a42e2b7-1b41-47f1-b435-08d6ac76c110
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the in_voltage-voltage_scale_available and
in_voltage_scale_available attributes. These are replaced with available
attributes added in info_mask_shared_by_type_available.

With this modification the iio core will be responsible with naming the
attributes thus removing the checkpatch warning related to
in_voltage-voltage_scale_available naming.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 drivers/staging/iio/adc/ad7192.c | 99 ++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index acdbc07fd259..d8a20f9066f4 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -337,30 +337,6 @@ static int ad7192_setup(struct ad7192_state *st,
 	return ret;
 }
 
-static ssize_t
-ad7192_show_scale_available(struct device *dev,
-			    struct device_attribute *attr, char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7192_state *st = iio_priv(indio_dev);
-	int i, len = 0;
-
-	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
-		len += sprintf(buf + len, "%d.%09u ", st->scale_avail[i][0],
-			       st->scale_avail[i][1]);
-
-	len += sprintf(buf + len, "\n");
-
-	return len;
-}
-
-static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
-			     in_voltage-voltage_scale_available,
-			     0444, ad7192_show_scale_available, NULL, 0);
-
-static IIO_DEVICE_ATTR(in_voltage_scale_available, 0444,
-		       ad7192_show_scale_available, NULL, 0);
-
 static ssize_t ad7192_show_ac_excitation(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -435,8 +411,6 @@ static IIO_DEVICE_ATTR(ac_excitation_en, 0644,
 		       AD7192_REG_MODE);
 
 static struct attribute *ad7192_attributes[] = {
-	&iio_dev_attr_in_v_m_v_scale_available.dev_attr.attr,
-	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
 	&iio_dev_attr_ac_excitation_en.dev_attr.attr,
 	NULL
@@ -447,8 +421,6 @@ static const struct attribute_group ad7192_attribute_group = {
 };
 
 static struct attribute *ad7195_attributes[] = {
-	&iio_dev_attr_in_v_m_v_scale_available.dev_attr.attr,
-	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
 	NULL
 };
@@ -579,10 +551,31 @@ static int ad7192_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
+static int ad7192_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	struct ad7192_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (int *)st->scale_avail;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		/* Values are stored in a 2D matrix  */
+		*length = ARRAY_SIZE(st->scale_avail) * 2;
+
+		return IIO_AVAIL_LIST;
+	}
+
+	return -EINVAL;
+}
+
 static const struct iio_info ad7192_info = {
 	.read_raw = ad7192_read_raw,
 	.write_raw = ad7192_write_raw,
 	.write_raw_get_fmt = ad7192_write_raw_get_fmt,
+	.read_avail = ad7192_read_avail,
 	.attrs = &ad7192_attribute_group,
 	.validate_trigger = ad_sd_validate_trigger,
 };
@@ -591,6 +584,7 @@ static const struct iio_info ad7195_info = {
 	.read_raw = ad7192_read_raw,
 	.write_raw = ad7192_write_raw,
 	.write_raw_get_fmt = ad7192_write_raw_get_fmt,
+	.read_avail = ad7192_read_avail,
 	.attrs = &ad7195_attribute_group,
 	.validate_trigger = ad_sd_validate_trigger,
 };
@@ -625,6 +619,42 @@ static const struct iio_chan_spec ad7193_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(14),
 };
 
+static int ad7192_channels_config(struct iio_dev *indio_dev)
+{
+	struct ad7192_state *st = iio_priv(indio_dev);
+	const struct iio_chan_spec *channels;
+	struct iio_chan_spec *chan;
+	int i;
+
+	switch (st->devid) {
+	case ID_AD7193:
+		channels = ad7193_channels;
+		indio_dev->num_channels = ARRAY_SIZE(ad7193_channels);
+		break;
+	default:
+		channels = ad7192_channels;
+		indio_dev->num_channels = ARRAY_SIZE(ad7192_channels);
+		break;
+	}
+
+	chan = devm_kcalloc(indio_dev->dev.parent, indio_dev->num_channels,
+			    sizeof(*chan), GFP_KERNEL);
+	if (!chan)
+		return -ENOMEM;
+
+	indio_dev->channels = chan;
+
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		*chan = channels[i];
+		if (chan->type != IIO_TEMP)
+			chan->info_mask_shared_by_type_available |=
+				BIT(IIO_CHAN_INFO_SCALE);
+		chan++;
+	}
+
+	return 0;
+}
+
 static int ad7192_probe(struct spi_device *spi)
 {
 	const struct ad7192_platform_data *pdata = dev_get_platdata(&spi->dev);
@@ -687,16 +717,9 @@ static int ad7192_probe(struct spi_device *spi)
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	switch (st->devid) {
-	case ID_AD7193:
-		indio_dev->channels = ad7193_channels;
-		indio_dev->num_channels = ARRAY_SIZE(ad7193_channels);
-		break;
-	default:
-		indio_dev->channels = ad7192_channels;
-		indio_dev->num_channels = ARRAY_SIZE(ad7192_channels);
-		break;
-	}
+	ret = ad7192_channels_config(indio_dev);
+	if (ret < 0)
+		goto error_disable_dvdd;
 
 	if (st->devid == ID_AD7195)
 		indio_dev->info = &ad7195_info;
-- 
2.17.1

