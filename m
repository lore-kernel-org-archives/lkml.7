Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C93AC10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318A020883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="Y05FHVDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbfDBLSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:18:54 -0400
Received: from mail-eopbgr720084.outbound.protection.outlook.com ([40.107.72.84]:33411
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbfDBLSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJk8NW96Y+U6R/WI8COyCiBmiQk1pOchHYPsYwX1Y/4=;
 b=Y05FHVDhbSRMQL8PL+X7I/Cz/9hRApr51r8x2eQDKu4KGzhLE6e6R/Ry3Ye15+qQZ6O/hfXQ6eb5ZzHui32zkld+QKrOwDob1ZqYyIHDqMdXpvn/2b2l2Tf5nRJvfETAbamN13RDGQhRlG5L97Xz39ELArEO+68ifo2Jf4oCC+k=
Received: from MWHPR03CA0046.namprd03.prod.outlook.com (2603:10b6:301:3b::35)
 by BL2PR03MB548.namprd03.prod.outlook.com (2a01:111:e400:c26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.16; Tue, 2 Apr
 2019 11:18:49 +0000
Received: from SN1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by MWHPR03CA0046.outlook.office365.com
 (2603:10b6:301:3b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1750.17 via Frontend
 Transport; Tue, 2 Apr 2019 11:18:48 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT034.mail.protection.outlook.com (10.152.72.141) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1750.16
 via Frontend Transport; Tue, 2 Apr 2019 11:18:47 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x32BIlPh026582
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 2 Apr 2019 04:18:47 -0700
Received: from ben-Latitude-E6540.analog.com (10.50.1.133) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 2 Apr 2019 07:18:46 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/3] iio: adc: ad7616: Add support for AD7616 ADC
Date:   Tue, 2 Apr 2019 16:18:40 +0300
Message-ID: <20190402131841.8430-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402131841.8430-1-beniamin.bia@analog.com>
References: <20190402131841.8430-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(39860400002)(376002)(2980300002)(199004)(189003)(86362001)(6666004)(5660300002)(186003)(2616005)(53416004)(316002)(966005)(44832011)(7696005)(6306002)(72206003)(478600001)(246002)(126002)(2906002)(26005)(7636002)(1076003)(426003)(14444005)(476003)(36756003)(11346002)(446003)(2351001)(54906003)(4326008)(77096007)(6916009)(47776003)(356004)(51416003)(7416002)(50226002)(305945005)(76176011)(16586007)(50466002)(486006)(106466001)(8936002)(107886003)(8676002)(48376002)(106002)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB548;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77b8cf74-f154-4cb6-630d-08d6b75cfa2f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BL2PR03MB548;
X-MS-TrafficTypeDiagnostic: BL2PR03MB548:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <BL2PR03MB5488F85A5FA84240F44F472F0560@BL2PR03MB548.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0995196AA2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 06yxvrQ7C8sQP4NxDQ8Al6JyRp2Po6644MMJsQqcc8aWMok5/lU6V9YVF9X+P5J9tlB3jgRLR8x4wcjepmuQ+uI/YXup7Kn6Aoh97L2U34HkohXKN4lJ6jeZsjOT7yeOd7Q9zjoH7ZdgaunxcinL51f/Wer5jjeMHs8lPInPU6e7Xm3AUebdeA07/f+f6wN5Q2xcpa0SjC+C/GqTHy37xCnWQJNIQ+qJNf17QUXffQn8ua69/pdi2tenrzTpRwppqAJm8m0YQ+ecMeEwBpeLydO2R2NRBVokpdEkaSgTEOLQ1BllliRUWsOsAOJKH+Xo0VOA+CCa85N7gdRN9o6vQmjcVRusot8wG4fBmio4cmm+C3OFLipTuvGt4DG87vMRHhEi2mBhkaIFnkizqAclVJyJEdcsOjc8IdOaaOEQ64E=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2019 11:18:47.6773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b8cf74-f154-4cb6-630d-08d6b75cfa2f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB548
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AD7616 is a 12-bit ADC with 16 channels.

The AD7616 can be configured to work in hardware mode by controlling it via
gpio pins and read data via spi. No support for software mode yet, but it
is a work in progress.

This device requires a reset in order to update oversampling, so chip info
has got a new attribute to mark this.

The current assumption that this driver makes for AD7616, is that it's
working in Hardware Mode with Serial, Burst and Sequencer modes activated.
To activate them, following pins must be pulled high:
	-SER/PAR
	-SEQEN
And following must be pulled low:
	-WR/BURST
	-DB4/SEQEN

Datasheets:
Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ad7616.pdf

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad7606.c     | 46 ++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7606.h     |  9 ++++---
 drivers/iio/adc/ad7606_spi.c |  2 ++
 3 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 6b87ed410c93..24c70c3cefb4 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -39,6 +39,10 @@ static const unsigned int ad7606_oversampling_avail[7] = {
 	1, 2, 4, 8, 16, 32, 64,
 };
 
+static const unsigned int ad7616_oversampling_avail[8] = {
+	1, 2, 4, 8, 16, 32, 64, 128,
+};
+
 static int ad7606_reset(struct ad7606_state *st)
 {
 	if (st->gpio_reset) {
@@ -220,6 +224,11 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 		mutex_lock(&st->lock);
 		gpiod_set_array_value(ARRAY_SIZE(values), st->gpio_os->desc,
 				      st->gpio_os->info, values);
+
+		/* AD7616 requires a reset to update value */
+		if (st->chip_info->os_req_reset)
+			ad7606_reset(st);
+
 		st->oversampling = st->oversampling_avail[i];
 		mutex_unlock(&st->lock);
 
@@ -314,6 +323,36 @@ static const struct iio_chan_spec ad7606_channels[] = {
 	AD7606_CHANNEL(7),
 };
 
+/*
+ * The current assumption that this driver makes for AD7616, is that it's
+ * working in Hardware Mode with Serial, Burst and Sequencer modes activated.
+ * To activate them, following pins must be pulled high:
+ *	-SER/PAR
+ *	-SEQEN
+ * And following pins must be pulled low:
+ *	-WR/BURST
+ *	-DB4/SER1W
+ */
+static const struct iio_chan_spec ad7616_channels[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(16),
+	AD7606_CHANNEL(0),
+	AD7606_CHANNEL(1),
+	AD7606_CHANNEL(2),
+	AD7606_CHANNEL(3),
+	AD7606_CHANNEL(4),
+	AD7606_CHANNEL(5),
+	AD7606_CHANNEL(6),
+	AD7606_CHANNEL(7),
+	AD7606_CHANNEL(8),
+	AD7606_CHANNEL(9),
+	AD7606_CHANNEL(10),
+	AD7606_CHANNEL(11),
+	AD7606_CHANNEL(12),
+	AD7606_CHANNEL(13),
+	AD7606_CHANNEL(14),
+	AD7606_CHANNEL(15),
+};
+
 static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
 	/* More devices added in future */
 	[ID_AD7605_4] = {
@@ -338,6 +377,13 @@ static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
 		.oversampling_avail = ad7606_oversampling_avail,
 		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	},
+	[ID_AD7616] = {
+		.channels = ad7616_channels,
+		.num_channels = 17,
+		.oversampling_avail = ad7616_oversampling_avail,
+		.oversampling_num = ARRAY_SIZE(ad7616_oversampling_avail),
+		.os_req_reset = true,
+	},
 };
 
 static int ad7606_request_gpios(struct ad7606_state *st)
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 8c91bd427c4e..f9ef52131e74 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -15,12 +15,14 @@
  * @oversampling_avail	pointer to the array which stores the available
  *			oversampling ratios.
  * @oversampling_num	number of elements stored in oversampling_avail array
+ * @os_req_reset	some devices require a reset to update oversampling
  */
 struct ad7606_chip_info {
 	const struct iio_chan_spec	*channels;
 	unsigned int			num_channels;
 	const unsigned int		*oversampling_avail;
 	unsigned int			oversampling_num;
+	bool				os_req_reset;
 };
 
 /**
@@ -76,9 +78,9 @@ struct ad7606_state {
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
-	 * 8 * 16-bit samples + 64-bit timestamp
+	 * 16 * 16-bit samples + 64-bit timestamp
 	 */
-	unsigned short			data[12] ____cacheline_aligned;
+	unsigned short			data[20] ____cacheline_aligned;
 };
 
 /**
@@ -98,7 +100,8 @@ enum ad7606_supported_device_ids {
 	ID_AD7605_4,
 	ID_AD7606_8,
 	ID_AD7606_6,
-	ID_AD7606_4
+	ID_AD7606_4,
+	ID_AD7616,
 };
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 4fd0ec36a086..b7faef69a58f 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -53,6 +53,7 @@ static const struct spi_device_id ad7606_id_table[] = {
 	{ "ad7606-4", ID_AD7606_4 },
 	{ "ad7606-6", ID_AD7606_6 },
 	{ "ad7606-8", ID_AD7606_8 },
+	{ "ad7616",   ID_AD7616 },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad7606_id_table);
@@ -62,6 +63,7 @@ static const struct of_device_id ad7606_of_match[] = {
 	{ .compatible = "adi,ad7606-4" },
 	{ .compatible = "adi,ad7606-6" },
 	{ .compatible = "adi,ad7606-8" },
+	{ .compatible = "adi,ad7616" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ad7606_of_match);
-- 
2.17.1

