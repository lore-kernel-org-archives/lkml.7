Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADA0C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AC920883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="tw+aIBBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbfDBLSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:18:42 -0400
Received: from mail-eopbgr690056.outbound.protection.outlook.com ([40.107.69.56]:59104
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbfDBLSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGrDVf9NzseDAxCxvIIh7WKQmaJEXIuCHCJymUwQodA=;
 b=tw+aIBBVKSxAiPkBAlADZzi4piBD1ZJgDLGZy5lrZy4bHM6HsJ2SlcGnIDOZEIcjeNJdUhPuUviY/IgIQzGLODP22CeNpXPK03ooOHFwysU8PlnyRXpCwHctFoIb4Eo0BzGHQlMgHzXid9cSK2avzQoe11qFJyutRZOx6uX9T98=
Received: from BN6PR03CA0011.namprd03.prod.outlook.com (2603:10b6:404:23::21)
 by SN2PR03MB2269.namprd03.prod.outlook.com (2603:10b6:804:d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.19; Tue, 2 Apr
 2019 11:18:33 +0000
Received: from CY1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BN6PR03CA0011.outlook.office365.com
 (2603:10b6:404:23::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1750.17 via Frontend
 Transport; Tue, 2 Apr 2019 11:18:32 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT041.mail.protection.outlook.com (10.152.74.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1750.16
 via Frontend Transport; Tue, 2 Apr 2019 11:18:31 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x32BIUSA026547
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 2 Apr 2019 04:18:30 -0700
Received: from ben-Latitude-E6540.analog.com (10.50.1.133) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 2 Apr 2019 07:18:30 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 1/3] iio: adc: ad7606: Move oversampling options in chip info and rework *_avail attributes
Date:   Tue, 2 Apr 2019 16:18:39 +0300
Message-ID: <20190402131841.8430-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(199004)(189003)(486006)(48376002)(336012)(47776003)(2616005)(476003)(14444005)(51416003)(478600001)(106002)(72206003)(54906003)(426003)(126002)(2906002)(86362001)(36756003)(50226002)(7696005)(1076003)(50466002)(44832011)(5660300002)(246002)(8936002)(53416004)(16586007)(6916009)(2351001)(316002)(106466001)(356004)(305945005)(7416002)(7636002)(77096007)(107886003)(4326008)(186003)(26005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2269;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6f0fd30-f24e-4caa-0498-08d6b75cf0b8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:SN2PR03MB2269;
X-MS-TrafficTypeDiagnostic: SN2PR03MB2269:
X-Microsoft-Antispam-PRVS: <SN2PR03MB22690C33277C8D5AE71E9F9FF0560@SN2PR03MB2269.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0995196AA2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Bqry1dVpG1YyLitmIlXc85PWKPGkDW28Tjw2yxfl0e89tDkJZmsUvPgm05cu5R6G3qLezclvsyLS/QnSbElNmvS43uca9PV+p71HGtWsyk/D7jgpLUvGqCm1d4bStru9FUBVae64H8zMWCXnqLFV9t997whLIammfLy6PaXAFIJchTtGnVgwL57+YH2qqSyHKZKGdXHwg6zCX7M92JzP1a2eKZtsxPpJyu92bVGiFq+Hxi3nWioH3LvRzyoL65pq3SB67YJu4f0+zzlSmzf/zzxHgp/aY8h9oFQqB63Dqij7XYSPOxzcsD9yAOmnxuRwbpJ6GCKjQyAGSSml52Bayj9JG6WKoGerJK25mCwzsv8PwBNMN9l4CgB8s6e9oVkCOg5s+ipi5tDGorbEeSXKMxn1mrLJhb42EFvSd+j0rv8=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2019 11:18:31.5428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f0fd30-f24e-4caa-0498-08d6b75cf0b8
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2269
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Popa <stefan.popa@analog.com>

Available oversampling ratios and scales can be shown by calling a
common ad7606_show_avail function which takes as parameters the array
which stores the values, together with the size of the array.

Oversampling options are now defined in chip info
structure and they are loaded at probe.

Has_Oversampling attribute was removed because oversampling_num was added
and it is not needed anymore.

The purpose of this patch is to deal with the scale_avail and
oversampling_avail arrays in a generic way. This makes it easier to add
support for new devices which will work with different scales and
oversampling ratios. It is also an intermediate step for adding support
for ad7616 which has different oversampling sampling ratios available.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/iio/adc/ad7606.c | 74 ++++++++++++++++++++++++++++------------
 drivers/iio/adc/ad7606.h | 16 +++++++--
 2 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index ebb8de03bbce..6b87ed410c93 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -31,7 +31,7 @@
  * Scales are computed as 5000/32768 and 10000/32768 respectively,
  * so that when applied to the raw values they provide mV values
  */
-static const unsigned int scale_avail[2] = {
+static const unsigned int ad7606_scale_avail[2] = {
 	152588, 305176
 };
 
@@ -154,7 +154,7 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
-		*val2 = scale_avail[st->range];
+		*val2 = st->scale_avail[st->range];
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*val = st->oversampling;
@@ -163,21 +163,31 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-static ssize_t in_voltage_scale_available_show(struct device *dev,
-					       struct device_attribute *attr,
-					       char *buf)
+static ssize_t ad7606_show_avail(char *buf, const unsigned int *vals,
+				 unsigned int n, bool micros)
 {
-	int i, len = 0;
-
-	for (i = 0; i < ARRAY_SIZE(scale_avail); i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06u ",
-				 scale_avail[i]);
+	size_t len = 0;
+	int i;
 
+	for (i = 0; i < n; i++) {
+		len += scnprintf(buf + len, PAGE_SIZE - len,
+			micros ? "0.%06u " : "%u ", vals[i]);
+	}
 	buf[len - 1] = '\n';
 
 	return len;
 }
 
+static ssize_t in_voltage_scale_available_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	return ad7606_show_avail(buf, st->scale_avail, st->num_scales, true);
+}
+
 static IIO_DEVICE_ATTR_RO(in_voltage_scale_available, 0);
 
 static int ad7606_write_raw(struct iio_dev *indio_dev,
@@ -193,7 +203,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		mutex_lock(&st->lock);
-		i = find_closest(val2, scale_avail, ARRAY_SIZE(scale_avail));
+		i = find_closest(val2, st->scale_avail, st->num_scales);
 		gpiod_set_value(st->gpio_range, i);
 		st->range = i;
 		mutex_unlock(&st->lock);
@@ -202,15 +212,15 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		if (val2)
 			return -EINVAL;
-		i = find_closest(val, ad7606_oversampling_avail,
-				 ARRAY_SIZE(ad7606_oversampling_avail));
+		i = find_closest(val, st->oversampling_avail,
+				 st->num_os_ratios);
 
 		values[0] = i;
 
 		mutex_lock(&st->lock);
 		gpiod_set_array_value(ARRAY_SIZE(values), st->gpio_os->desc,
 				      st->gpio_os->info, values);
-		st->oversampling = ad7606_oversampling_avail[i];
+		st->oversampling = st->oversampling_avail[i];
 		mutex_unlock(&st->lock);
 
 		return 0;
@@ -219,11 +229,23 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
-static IIO_CONST_ATTR(oversampling_ratio_available, "1 2 4 8 16 32 64");
+static ssize_t ad7606_oversampling_ratio_avail(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	return ad7606_show_avail(buf, st->oversampling_avail,
+				 st->num_os_ratios, false);
+}
+
+static IIO_DEVICE_ATTR(oversampling_ratio_available, 0444,
+		       ad7606_oversampling_ratio_avail, NULL, 0);
 
 static struct attribute *ad7606_attributes_os_and_range[] = {
 	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
-	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
+	&iio_dev_attr_oversampling_ratio_available.dev_attr.attr,
 	NULL,
 };
 
@@ -232,7 +254,7 @@ static const struct attribute_group ad7606_attribute_group_os_and_range = {
 };
 
 static struct attribute *ad7606_attributes_os[] = {
-	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
+	&iio_dev_attr_oversampling_ratio_available.dev_attr.attr,
 	NULL,
 };
 
@@ -301,17 +323,20 @@ static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
 	[ID_AD7606_8] = {
 		.channels = ad7606_channels,
 		.num_channels = 9,
-		.has_oversampling = true,
+		.oversampling_avail = ad7606_oversampling_avail,
+		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	},
 	[ID_AD7606_6] = {
 		.channels = ad7606_channels,
 		.num_channels = 7,
-		.has_oversampling = true,
+		.oversampling_avail = ad7606_oversampling_avail,
+		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	},
 	[ID_AD7606_4] = {
 		.channels = ad7606_channels,
 		.num_channels = 5,
-		.has_oversampling = true,
+		.oversampling_avail = ad7606_oversampling_avail,
+		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	},
 };
 
@@ -343,7 +368,7 @@ static int ad7606_request_gpios(struct ad7606_state *st)
 	if (IS_ERR(st->gpio_frstdata))
 		return PTR_ERR(st->gpio_frstdata);
 
-	if (!st->chip_info->has_oversampling)
+	if (!st->chip_info->oversampling_num)
 		return 0;
 
 	st->gpio_os = devm_gpiod_get_array_optional(dev,
@@ -467,6 +492,8 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	/* tied to logic low, analog input range is +/- 5V */
 	st->range = 0;
 	st->oversampling = 1;
+	st->scale_avail = ad7606_scale_avail;
+	st->num_scales = ARRAY_SIZE(ad7606_scale_avail);
 
 	st->reg = devm_regulator_get(dev, "avcc");
 	if (IS_ERR(st->reg))
@@ -484,6 +511,11 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 
 	st->chip_info = &ad7606_chip_info_tbl[id];
 
+	if (st->chip_info->oversampling_num) {
+		st->oversampling_avail = st->chip_info->oversampling_avail;
+		st->num_os_ratios = st->chip_info->oversampling_num;
+	}
+
 	ret = ad7606_request_gpios(st);
 	if (ret)
 		return ret;
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 5d12410f68e1..8c91bd427c4e 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -12,12 +12,15 @@
  * struct ad7606_chip_info - chip specific information
  * @channels:		channel specification
  * @num_channels:	number of channels
- * @has_oversampling:   whether the device has oversampling support
+ * @oversampling_avail	pointer to the array which stores the available
+ *			oversampling ratios.
+ * @oversampling_num	number of elements stored in oversampling_avail array
  */
 struct ad7606_chip_info {
 	const struct iio_chan_spec	*channels;
 	unsigned int			num_channels;
-	bool				has_oversampling;
+	const unsigned int		*oversampling_avail;
+	unsigned int			oversampling_num;
 };
 
 /**
@@ -29,6 +32,11 @@ struct ad7606_chip_info {
  * @range		voltage range selection, selects which scale to apply
  * @oversampling	oversampling selection
  * @base_address	address from where to read data in parallel operation
+ * @scale_avail		pointer to the array which stores the available scales
+ * @num_scales		number of elements stored in the scale_avail array
+ * @oversampling_avail	pointer to the array which stores the available
+ *			oversampling ratios.
+ * @num_os_ratios	number of elements stored in oversampling_avail array
  * @lock		protect sensor state from concurrent accesses to GPIOs
  * @gpio_convst	GPIO descriptor for conversion start signal (CONVST)
  * @gpio_reset		GPIO descriptor for device hard-reset
@@ -50,6 +58,10 @@ struct ad7606_state {
 	unsigned int			range;
 	unsigned int			oversampling;
 	void __iomem			*base_address;
+	const unsigned int		*scale_avail;
+	unsigned int			num_scales;
+	const unsigned int		*oversampling_avail;
+	unsigned int			num_os_ratios;
 
 	struct mutex			lock; /* protect sensor state */
 	struct gpio_desc		*gpio_convst;
-- 
2.17.1

