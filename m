Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A99C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB2B2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="aA86qmzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfCKJpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:45:55 -0400
Received: from mail-eopbgr780053.outbound.protection.outlook.com ([40.107.78.53]:23072
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727206AbfCKJpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScSLMdFtqrel04OnDS9THIbZ0890Js1/3D9JIVP14O0=;
 b=aA86qmzZM9t3AC9DxnrhtV8gnwszyM0iSIvqltDdEoRnGphhD0wMlt5MBoGMGG+oHFLNMQGotiCsPLf6mxbFuzh3b+Lm4Tei4hiQCkjMEXQYqV26txVQEeq8cxQ+3bbpkB5MRKHBYzXXZGY+CVyWzi/W5hOs9eajsBZxkmf40AA=
Received: from BN6PR03CA0083.namprd03.prod.outlook.com (2603:10b6:405:6f::21)
 by DM2PR03MB558.namprd03.prod.outlook.com (2a01:111:e400:241d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.18; Mon, 11 Mar
 2019 09:45:47 +0000
Received: from SN1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by BN6PR03CA0083.outlook.office365.com
 (2603:10b6:405:6f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.16 via Frontend
 Transport; Mon, 11 Mar 2019 09:45:47 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT003.mail.protection.outlook.com (10.152.73.29) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1686.19
 via Frontend Transport; Mon, 11 Mar 2019 09:45:47 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x2B9jkT1021748
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 11 Mar 2019 02:45:46 -0700
Received: from linux.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Mon, 11 Mar 2019
 05:45:45 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH v2 1/2] iio: imu: adis16480: Add support for external clock
Date:   Mon, 11 Mar 2019 11:45:29 +0200
Message-ID: <1552297529-26422-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(199004)(189003)(426003)(336012)(486006)(2616005)(2906002)(126002)(476003)(44832011)(7636002)(51416003)(7696005)(478600001)(72206003)(2351001)(106466001)(6916009)(246002)(6666004)(356004)(53416004)(5660300002)(8936002)(8676002)(4326008)(50226002)(50466002)(36756003)(54906003)(77096007)(305945005)(47776003)(106002)(26005)(186003)(48376002)(107886003)(316002)(16586007)(30864003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB558;H:nwd2mta1.analog.com;FPR:;SPF:Pass;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 336060c8-0d81-4804-71b8-08d6a60656b6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:DM2PR03MB558;
X-MS-TrafficTypeDiagnostic: DM2PR03MB558:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB558;20:W455msiNf7PBJalRvztrYb79VfMekWG1OZHW6eRgmm4bwqhqnmc/kFK8IJyrcQ3UEL3rRdribFJslLElZLndJ0oKcQnlXDYMYoGhuIoat5S3zjKirZo9gOJf9vO3uaOo1qx/HMx+x7Oey1xUNYVYd/wZ84L7bo7TR6eTXFMtigw7cHDsFIp8j+Emc5P6bUyifeG3bcj88F3Lyhxhb8EVRPuPzqy8ccoHI/pRwE+HS/wUMxKnm7ZMhcTImImNjZq2VlZdPWvyvT+QZSFVg1CN360zZ3JPlbvUfjKOKW0xT/S8rb6EeDOVzbLZje7p8rr+CIbAFfNRDmNWw2Fmv9sNH71STVyKuDnhVPr1g11JUiEUI+3t96lyKB47fQIS6K1dFQyNcWzt+viGrx1Zvj6eGd4qNMWawKntv3LNao6bpAGIgncVvgthMBdviGC5x7QPTeYLUhhOKyayHBX50lqC2HSEA5yF92QigP37v8BDFDeOJRMPMqu+yQ06Ko6cYC9E
X-Microsoft-Antispam-PRVS: <DM2PR03MB558B25363739576EEE1DF359D480@DM2PR03MB558.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09730BD177
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR03MB558;23:Ki48YR+R1EaskYkfRt41fhSNuDjW31zb+le2v0IAkQ?=
 =?us-ascii?Q?vwzq8TMWmcMjHKiEYPmzsVEGX7erJQHyZCbtxChSYgVJKr+QLjmrDb7HxHjH?=
 =?us-ascii?Q?L2tFcDYyaRrUcoZNCsitu1LJlTNCYQ26xnqcbujAYXxo8mXQ4p25acBZasmO?=
 =?us-ascii?Q?WuZVTyitfG9Xsyp8sAA0cWkrk5m4iwhvB6G2Ca69Xx/SToBpL98GR+b8jIk9?=
 =?us-ascii?Q?aPDw6BtHqkMVkcKsFO4X7FkArfsg3V6vxWj5HGnrgw3O+ll5bZmFYRCnp8Qm?=
 =?us-ascii?Q?Jo0zL0RXGbzAPQzu183iRmmsNsgbW44azq4Nry7YaN51GdlYaJiqTh4MjarX?=
 =?us-ascii?Q?H3UftmAPdIajVKgbNoSRFgFdmfskUXMmoiZ+Mwf0WmOZjZ//M3bPSJnoZ6vF?=
 =?us-ascii?Q?Kq3//4+ISsVRw38J/183Y3oMBN54z+PmBSnB58wJAtA+HqDK5pqd3VVEm6xH?=
 =?us-ascii?Q?f1+YPl8dTKRc9vL5k4zE06ss4tUho74UpGlRbyCslarsbZBPME1LULb4u28A?=
 =?us-ascii?Q?hiYqlEarJlD2DmPCZTb0aDUok+n3amHYUbhtHZSK27AgCUA2ZdoWBt8KQMm5?=
 =?us-ascii?Q?r2IoaDXW4u2ByEIM8X7e7/VcOpS0wWF4i1Ug4nEM5ge7qxp3WGsba7ibsJjw?=
 =?us-ascii?Q?psjhU7AISAtxmoqJtEAn1+t6hxQdpi0uxbrcSYHOEJNNcnvVugsZ2CH2XXOe?=
 =?us-ascii?Q?hbIpQMCcDHAz7yAP/L0wGvvlfTGJ7G6a0P+cITlEDc0PPBVuYdeArTl+agg5?=
 =?us-ascii?Q?EhacjPrmnVdBBrPlbwNKGS86QtsvlFvPiJR425uXgasFDjrMeX+4ch6ApJmW?=
 =?us-ascii?Q?ni+U9shFrxyXk7JMs+rE5j75USGISq05BXY7Zed8OS1bfAZKO5CUFzLUQfL9?=
 =?us-ascii?Q?q9SexSD9Ihn2VRY5UuVTGrkjsjZ7n2BB8KQlCR4uvb6J85dvVSEtwmAbkwMU?=
 =?us-ascii?Q?2JbjT4T44tCCaDzI+IY2Sp+86WQ+eAD5ma4yAHj+LB/aJ7m3KQtKPM/gaCuy?=
 =?us-ascii?Q?Id9TUF2VHXk1QsqP+/kfuQpKQu9r/sk/fvT9XXDjJBoQ=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: mhTpCYrgYw3vx8veeU518WEB3vtjOhUFHK1ZZbBhctfmwf5+tz6Hp6aoY2cb34L3GXw5YE+NPbbwUwJqUq1/jnUl+KuwSxQDEQ0ErZJkFuxQmvQbKJqeO0P4Li/lIFIDJ8Q8Wl8gtGstsmtn4TTtSW2+u0wMv6hQrrFGUG6QrVnHMd1SWkB/pbqrJfc/ziERcd03Nlj+wjK43d1YAXoqDGXtrWGoxQDhHOVDhlAUuneqbDdlst2dc0VPZPnTU34vujauT7AWAXz5cNmMoxPhZtV/SefkTp2nje+rnrfdE/Z8/xcZ7U6uOquwMO35MfhLB0BKw1LL56Jw/tO7e3/WoUIbIoGCpcciZcV6HjAsdavYui88IwUXkvXysWy58fny75ubFGykgykH6JfB7hl8Kn9zYmBKRWRFr3UWG46SGsc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2019 09:45:47.0772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 336060c8-0d81-4804-71b8-08d6a60656b6
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB558
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inertial sensor data collection and processing can be controlled by
configuring one of the DIOx lines as an external clock input. This
option is available for all devices supported by this driver. However,
only adis1649x devices support different modes for the external clock.

Sync mode is supported by all devices. In this mode, the output data
rate is equal with the clock frequency divided by DEC_RATE + 1. This
mode of calculation is similar with the case when the internal clock is
used.

Pulse Per Second (PPS) Mode, is only supported by adis1649x devices. In
this mode, the output data rate is equal to the product of the external
clock frequency and the scale factor in the SYNC_SCALE register.

This patch uses the "clock-names" property to enable the external clock
in one of the two supported modes: "sync" or "pps". This property is
optional. If it is not specified, the internal clock is used.

This patch also offers the option to select the DIOx line to be used as
an external clock input via the custom "adi,ext-clk-pin" property. If this
field is left empty, DIO2 is assigned as default external clock input pin.
Each DIOx pin supports only one function at a time (data ready line
selection or external clock input).

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- used ADIS16480_DRDY_SEL() macro when checking for external clock
	  input pin.

 drivers/iio/imu/adis16480.c | 186 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 179 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 28cece3..ab137c1 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -9,6 +9,7 @@
  *
  */
 
+#include <linux/clk.h>
 #include <linux/bitfield.h>
 #include <linux/of_irq.h>
 #include <linux/interrupt.h>
@@ -99,6 +100,12 @@
 #define ADIS16480_REG_FIRM_DM			ADIS16480_REG(0x03, 0x7A)
 #define ADIS16480_REG_FIRM_Y			ADIS16480_REG(0x03, 0x7C)
 
+/*
+ * External clock scaling in PPS mode.
+ * Available only for ADIS1649x devices
+ */
+#define ADIS16495_REG_SYNC_SCALE		ADIS16480_REG(0x03, 0x10)
+
 #define ADIS16480_REG_SERIAL_NUM		ADIS16480_REG(0x04, 0x20)
 
 /* Each filter coefficent bank spans two pages */
@@ -116,6 +123,12 @@
 #define ADIS16480_DRDY_POL(x)		FIELD_PREP(ADIS16480_DRDY_POL_MSK, x)
 #define ADIS16480_DRDY_EN_MSK		BIT(3)
 #define ADIS16480_DRDY_EN(x)		FIELD_PREP(ADIS16480_DRDY_EN_MSK, x)
+#define ADIS16480_SYNC_SEL_MSK		GENMASK(5, 4)
+#define ADIS16480_SYNC_SEL(x)		FIELD_PREP(ADIS16480_SYNC_SEL_MSK, x)
+#define ADIS16480_SYNC_EN_MSK		BIT(7)
+#define ADIS16480_SYNC_EN(x)		FIELD_PREP(ADIS16480_SYNC_EN_MSK, x)
+#define ADIS16480_SYNC_MODE_MSK		BIT(8)
+#define ADIS16480_SYNC_MODE(x)		FIELD_PREP(ADIS16480_SYNC_MODE_MSK, x)
 
 struct adis16480_chip_info {
 	unsigned int num_channels;
@@ -128,6 +141,7 @@ struct adis16480_chip_info {
 	unsigned int int_clk;
 	unsigned int max_dec_rate;
 	const unsigned int *filter_freqs;
+	bool has_pps_clk_mode;
 };
 
 enum adis16480_int_pin {
@@ -137,10 +151,19 @@ enum adis16480_int_pin {
 	ADIS16480_PIN_DIO4
 };
 
+enum adis16480_clock_mode {
+	ADIS16480_CLK_SYNC,
+	ADIS16480_CLK_PPS,
+	ADIS16480_CLK_INT
+};
+
 struct adis16480 {
 	const struct adis16480_chip_info *chip_info;
 
 	struct adis adis;
+	struct clk *ext_clk;
+	enum adis16480_clock_mode clk_mode;
+	unsigned int clk_freq;
 };
 
 static const char * const adis16480_int_pin_names[4] = {
@@ -296,20 +319,34 @@ static int adis16480_debugfs_init(struct iio_dev *indio_dev)
 static int adis16480_set_freq(struct iio_dev *indio_dev, int val, int val2)
 {
 	struct adis16480 *st = iio_priv(indio_dev);
-	unsigned int t;
+	unsigned int t, reg;
 
 	t =  val * 1000 + val2 / 1000;
 	if (t <= 0)
 		return -EINVAL;
 
-	t = st->chip_info->int_clk / t;
+	/*
+	 * When using PPS mode, the rate of data collection is equal to the
+	 * product of the external clock frequency and the scale factor in the
+	 * SYNC_SCALE register.
+	 * When using sync mode, or internal clock, the output data rate is
+	 * equal with  the clock frequency divided by DEC_RATE + 1.
+	 */
+	if (st->clk_mode == ADIS16480_CLK_PPS) {
+		t = t / st->clk_freq;
+		reg = ADIS16495_REG_SYNC_SCALE;
+	} else {
+		t = st->clk_freq / t;
+		reg = ADIS16480_REG_DEC_RATE;
+	}
+
 	if (t > st->chip_info->max_dec_rate)
 		t = st->chip_info->max_dec_rate;
 
-	if (t != 0)
+	if ((t != 0) && (st->clk_mode != ADIS16480_CLK_PPS))
 		t--;
 
-	return adis_write_reg_16(&st->adis, ADIS16480_REG_DEC_RATE, t);
+	return adis_write_reg_16(&st->adis, reg, t);
 }
 
 static int adis16480_get_freq(struct iio_dev *indio_dev, int *val, int *val2)
@@ -318,12 +355,29 @@ static int adis16480_get_freq(struct iio_dev *indio_dev, int *val, int *val2)
 	uint16_t t;
 	int ret;
 	unsigned freq;
+	unsigned int reg;
+
+	if (st->clk_mode == ADIS16480_CLK_PPS)
+		reg = ADIS16495_REG_SYNC_SCALE;
+	else
+		reg = ADIS16480_REG_DEC_RATE;
 
-	ret = adis_read_reg_16(&st->adis, ADIS16480_REG_DEC_RATE, &t);
+	ret = adis_read_reg_16(&st->adis, reg, &t);
 	if (ret < 0)
 		return ret;
 
-	freq = st->chip_info->int_clk / (t + 1);
+	/*
+	 * When using PPS mode, the rate of data collection is equal to the
+	 * product of the external clock frequency and the scale factor in the
+	 * SYNC_SCALE register.
+	 * When using sync mode, or internal clock, the output data rate is
+	 * equal with  the clock frequency divided by DEC_RATE + 1.
+	 */
+	if (st->clk_mode == ADIS16480_CLK_PPS)
+		freq = st->clk_freq * t;
+	else
+		freq = st->clk_freq / (t + 1);
+
 	*val = freq / 1000;
 	*val2 = (freq % 1000) * 1000;
 
@@ -793,6 +847,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.int_clk = 4250000,
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
+		.has_pps_clk_mode = true,
 	},
 	[ADIS16495_2] = {
 		.channels = adis16485_channels,
@@ -805,6 +860,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.int_clk = 4250000,
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
+		.has_pps_clk_mode = true,
 	},
 	[ADIS16495_3] = {
 		.channels = adis16485_channels,
@@ -817,6 +873,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.int_clk = 4250000,
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
+		.has_pps_clk_mode = true,
 	},
 	[ADIS16497_1] = {
 		.channels = adis16485_channels,
@@ -829,6 +886,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.int_clk = 4250000,
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
+		.has_pps_clk_mode = true,
 	},
 	[ADIS16497_2] = {
 		.channels = adis16485_channels,
@@ -841,6 +899,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.int_clk = 4250000,
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
+		.has_pps_clk_mode = true,
 	},
 	[ADIS16497_3] = {
 		.channels = adis16485_channels,
@@ -853,6 +912,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.int_clk = 4250000,
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
+		.has_pps_clk_mode = true,
 	},
 };
 
@@ -1027,6 +1087,100 @@ static int adis16480_config_irq_pin(struct device_node *of_node,
 	return adis_write_reg_16(&st->adis, ADIS16480_REG_FNCTIO_CTRL, val);
 }
 
+static int adis16480_of_get_ext_clk_pin(struct adis16480 *st,
+					struct device_node *of_node)
+{
+	const char *ext_clk_pin;
+	enum adis16480_int_pin pin;
+	int i;
+
+	pin = ADIS16480_PIN_DIO2;
+	if (of_property_read_string(of_node, "adi,ext-clk-pin", &ext_clk_pin))
+		goto clk_input_not_found;
+
+	for (i = 0; i < ARRAY_SIZE(adis16480_int_pin_names); i++) {
+		if (strcasecmp(ext_clk_pin, adis16480_int_pin_names[i]) == 0)
+			return i;
+	}
+
+clk_input_not_found:
+	dev_info(&st->adis.spi->dev,
+		"clk input line not specified, using DIO2\n");
+	return pin;
+}
+
+static int adis16480_ext_clk_config(struct adis16480 *st,
+				    struct device_node *of_node,
+				    bool enable)
+{
+	unsigned int mode, mask;
+	enum adis16480_int_pin pin;
+	uint16_t val;
+	int ret;
+
+	ret = adis_read_reg_16(&st->adis, ADIS16480_REG_FNCTIO_CTRL, &val);
+	if (ret < 0)
+		return ret;
+
+	pin = adis16480_of_get_ext_clk_pin(st, of_node);
+	/*
+	 * Each DIOx pin supports only one function at a time. When a single pin
+	 * has two assignments, the enable bit for a lower priority function
+	 * automatically resets to zero (disabling the lower priority function).
+	 */
+	if (pin == ADIS16480_DRDY_SEL(val))
+		dev_warn(&st->adis.spi->dev,
+			"DIO%x pin supports only one function at a time\n",
+			pin + 1);
+
+	mode = ADIS16480_SYNC_EN(enable) | ADIS16480_SYNC_SEL(pin);
+	mask = ADIS16480_SYNC_EN_MSK | ADIS16480_SYNC_SEL_MSK;
+	/* Only ADIS1649x devices support pps ext clock mode */
+	if (st->chip_info->has_pps_clk_mode) {
+		mode |= ADIS16480_SYNC_MODE(st->clk_mode);
+		mask |= ADIS16480_SYNC_MODE_MSK;
+	}
+
+	val &= ~mask;
+	val |= mode;
+
+	ret = adis_write_reg_16(&st->adis, ADIS16480_REG_FNCTIO_CTRL, val);
+	if (ret < 0)
+		return ret;
+
+	return clk_prepare_enable(st->ext_clk);
+}
+
+static int adis16480_get_ext_clocks(struct adis16480 *st)
+{
+	st->clk_mode = ADIS16480_CLK_INT;
+	st->ext_clk = devm_clk_get(&st->adis.spi->dev, "sync");
+	if (!IS_ERR_OR_NULL(st->ext_clk)) {
+		st->clk_mode = ADIS16480_CLK_SYNC;
+		return 0;
+	}
+
+	if (PTR_ERR(st->ext_clk) != -ENOENT) {
+		dev_err(&st->adis.spi->dev, "failed to get ext clk\n");
+		return PTR_ERR(st->ext_clk);
+	}
+
+	if (st->chip_info->has_pps_clk_mode) {
+		st->ext_clk = devm_clk_get(&st->adis.spi->dev, "pps");
+		if (!IS_ERR_OR_NULL(st->ext_clk)) {
+			st->clk_mode = ADIS16480_CLK_PPS;
+			return 0;
+		}
+
+		if (PTR_ERR(st->ext_clk) != -ENOENT) {
+			dev_err(&st->adis.spi->dev, "failed to get ext clk\n");
+			return PTR_ERR(st->ext_clk);
+		}
+	}
+
+	return 0;
+}
+
 static int adis16480_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
@@ -1058,10 +1212,25 @@ static int adis16480_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
+	ret = adis16480_get_ext_clocks(st);
 	if (ret)
 		return ret;
 
+	if (!IS_ERR_OR_NULL(st->ext_clk)) {
+		ret = adis16480_ext_clk_config(st, spi->dev.of_node, true);
+		if (ret)
+			return ret;
+
+		st->clk_freq = clk_get_rate(st->ext_clk);
+		st->clk_freq *= 1000; /* micro */
+	} else {
+		st->clk_freq = st->chip_info->int_clk;
+	}
+
+	ret = adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
+	if (ret)
+		goto error_clk_disable_unprepare;
+
 	ret = adis16480_initial_setup(indio_dev);
 	if (ret)
 		goto error_cleanup_buffer;
@@ -1078,6 +1247,8 @@ static int adis16480_probe(struct spi_device *spi)
 	adis16480_stop_device(indio_dev);
 error_cleanup_buffer:
 	adis_cleanup_buffer_and_trigger(&st->adis, indio_dev);
+error_clk_disable_unprepare:
+	clk_disable_unprepare(st->ext_clk);
 	return ret;
 }
 
@@ -1090,6 +1261,7 @@ static int adis16480_remove(struct spi_device *spi)
 	adis16480_stop_device(indio_dev);
 
 	adis_cleanup_buffer_and_trigger(&st->adis, indio_dev);
+	clk_disable_unprepare(st->ext_clk);
 
 	return 0;
 }
-- 
2.7.4

