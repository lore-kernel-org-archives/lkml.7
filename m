Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B5EC10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAFD20643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="skrYXAjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfCGP3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:29:07 -0500
Received: from mail-eopbgr740084.outbound.protection.outlook.com ([40.107.74.84]:9114
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726294AbfCGP3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:29:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDvUUatkmMXxI+RdV2cY2CDoFUP6eD8k3dBd/yOiLcA=;
 b=skrYXAjPEV7Z6Ahp94Hrflh4YQNwKFKly+NuNFyGX+J1veVPSuScyJhm74p1Dvq2KYaYeWaAlfnFXkA+ZUOGI7HLircfpsA23weJ4/YDn5pqwOUawWxraCFpDMtKT4GCxAr6A+wxw4SXOR91Y7bf5V7ztqryi0ybizWN/zlP4UY=
Received: from DM5PR03CA0035.namprd03.prod.outlook.com (2603:10b6:4:3b::24) by
 SN2PR03MB2272.namprd03.prod.outlook.com (2603:10b6:804:d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Thu, 7 Mar 2019 15:28:58 +0000
Received: from BL2NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by DM5PR03CA0035.outlook.office365.com
 (2603:10b6:4:3b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1686.16 via Frontend
 Transport; Thu, 7 Mar 2019 15:28:57 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT056.mail.protection.outlook.com (10.152.77.221) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Thu, 7 Mar 2019 15:28:57 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x27FSubI019369
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 7 Mar 2019 07:28:57 -0800
Received: from linux.analog.com (10.32.224.122) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Thu, 7 Mar 2019
 10:28:56 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH 1/2] iio: imu: adis16480: Add support for external clock
Date:   Thu, 7 Mar 2019 17:28:32 +0200
Message-ID: <1551972512-15041-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(136003)(2980300002)(189003)(199004)(47776003)(6916009)(7696005)(336012)(186003)(7636002)(50226002)(8676002)(246002)(5660300002)(6666004)(305945005)(44832011)(426003)(486006)(30864003)(2616005)(476003)(126002)(356004)(8936002)(48376002)(2906002)(72206003)(106002)(54906003)(478600001)(316002)(16586007)(50466002)(77096007)(51416003)(26005)(4326008)(107886003)(36756003)(53416004)(106466001)(2351001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2272;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6165e84a-0460-4dca-107d-08d6a3119dda
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4608103)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN2PR03MB2272;
X-MS-TrafficTypeDiagnostic: SN2PR03MB2272:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2272;20:vSd9bnc3a5RY248SaZAF+PMfl7M6hmZfv4J5aNcMMi0crvUM7+QKnXmJf1de0H74VXgmkhZw+1m2OesXh03Q+ORE6gu16/ZJurTrMRoPJmTUHS2J0HDxQXujXglozV8Pn5bqcIr1OaBu9AION9sVnWzDN5LVPONIU9ottu+M9CW3dlMw0ugsux2H3M2riqaORz6xYhPTOLay/f7c3sNHnGpXAkt2kmwJdZYRfhUZVA4EzzGFtL9wFDw/JFUCPbIfYv0cjRuG5GmaA2d4FCZ6HFmyENqt6pg7b1KBhfueJNq4qy8sfr66QW8+aXH5f87oR3T0V8O/jsCJq5kvsM0YHek5d6Z6BdqGfeMjSEKc38RdqbPxdxSZ3gSae1SSye4pxpooz+6gj84r8ekiO6DP3iG9rNjvAJmThuM/Nq5V5YoYn1/GXSLZwJoUFkEileyJGiWf5jzsgSyNCaGkVJvdV4D1EkpQ0pHLuUb6WuRNJNSNqntiPKZizwRglSwL5XRE
X-Microsoft-Antispam-PRVS: <SN2PR03MB227257CE5218D4B6D0B793099D4C0@SN2PR03MB2272.namprd03.prod.outlook.com>
X-Forefront-PRVS: 096943F07A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR03MB2272;23:OfOaMp77BhRpON64uJRaI/bCGHqLwS8ub9aJJgh15?=
 =?us-ascii?Q?9bpWOE6Z1oUwQi5Y154y+zxeC7knr9vq90/5eRHybpQzCfXZrXq8zLqkROyM?=
 =?us-ascii?Q?oZIKysqOpypQ5E+1Od70PAAyBHmbmuTkdmtBBPxC3NPZ0eexK+DoXPTM8BXW?=
 =?us-ascii?Q?9qiyu8VuA8bgbX26wdVw7XN8AgaCSoEA8pczWQ3YmT/c/1GeafIcDrMTU1TV?=
 =?us-ascii?Q?od81IEFn8zIc6Ewr1F3Y0Um1BjdsltTnYl5knl3iCxBLAeZXXjAY1K6PjDoH?=
 =?us-ascii?Q?lWJLT+CCWwxd8/X5nqDMPff70T8/pNKat5lCEVLHPUx75NWLsk8VLgeqtNiS?=
 =?us-ascii?Q?IaIKGTFVgvD/mrCg8viESIGvls4/LdFxUyA9Ibn+/O6bELTlgFsje47LWM/K?=
 =?us-ascii?Q?0PQ85nrfALezcvyJoE0dUuAglz1oU80VmKSk/dcBvyyepmH8KN8tF22v6i+v?=
 =?us-ascii?Q?VQ+/1kTu5TmVhbPa2c0pImDOyeeyxaKRt8pBHljgnk5E4CEl8cx3kKwsJfPq?=
 =?us-ascii?Q?17UwJA7iSU3V+q85uY9XOnXiWxM7TrYSZ71R5ezS584VPvr1SBlBa7FeiZSp?=
 =?us-ascii?Q?WO5tEXmGpb7FaAcK4d6ZcDNrK0kUOJ2FJRE+C2uLVhVAQFDTi3q2HmalWujx?=
 =?us-ascii?Q?NmXKjY65Sq8NnwEXOuyTjn9bANiLUgYebmlzCCmMw/bYCz9UjmlddD1dbDmU?=
 =?us-ascii?Q?0q11lFxquBEjFTjB0Ba8SpSEtkrKa+XmFuJfdza4rfdjZKoSILjES3FX6n53?=
 =?us-ascii?Q?f5i3o0fhJr86OhjAcns/fp4cT3vwAnl6QbmeZC2ujA+TCSmZ3pbu8JDu4wm4?=
 =?us-ascii?Q?+LhWu/UbED6ldVa6i/bNpMLHrZeMj1GYjqYG9h29yPv5wDNLa2SRAvUuVT/1?=
 =?us-ascii?Q?ePAsb1PMVm87oucw2XMg0PDRqqFNl0WnbjKlqXjzyfuddmVyfgIKKN0OSHFp?=
 =?us-ascii?Q?AIJ2r+8tE4W4tUxH5xtkM0/r7vv8nsEvY9FDjMBo35brbM1l9h9NscKKiRYi?=
 =?us-ascii?Q?StdFPPAQs29rSHYjzzCWUu9NIA6i+qDidfvvMIjB/YOuQ=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: F1oZxKwMvCJNhg7puwZ6cxrWfeTLwRXFwSLimSQK7FG92DDhZMz/sG+dvRBCua7CsNkF0XyFDjA4LUL3EjUgPqN/mr1tWMai4zQQ52c6+3Uu4Ivl30Swt7Lun8mmkRwUkBTftLELHafN3pZm7JtCjxTEXTc431ldGgoSRKfxRVhRgjX/8sBPFJ+VpRMvM8pVI5TP7cd8IJrU15+OH6pEanG2F4foNCnvE3K5ZbZ42vcdy3td0qnvzvBhf0/BB4swB5FMSNkWHSLcA85MU7gx3MwT3d+lUmj0JYvcVB07qdg1Bd0ULr6Yke7V9ABaIvzqFUzyoFLpGqPc+b37K8/d+5B+U7xTEVHf5sb/cHUNJuzwGffp/kc5QlyJ/2fLrst90DmmXra326UsaAuZlmfkXaZSHJTrnMXBMJVPzzTK7Oc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2019 15:28:57.6508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6165e84a-0460-4dca-107d-08d6a3119dda
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2272
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
 drivers/iio/imu/adis16480.c | 186 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 179 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 28cece3..3a93a85 100644
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
+	if (pin == (val & ADIS16480_DRDY_SEL_MSK))
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

