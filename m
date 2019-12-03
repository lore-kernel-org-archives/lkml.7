Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BDCC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332B620833
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="WKoNeUpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfLCN5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:57:08 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:40024 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727048AbfLCN5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:57:01 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB3DhMY0010244;
        Tue, 3 Dec 2019 08:56:22 -0500
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2057.outbound.protection.outlook.com [104.47.32.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wkk57rqpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Dec 2019 08:56:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=de90u0fAoDkB5FX+6gjfMLnnrWlLU6A3zoOLPRxkDiU2Spbr5/8ewTACpaCPWuYDY00uEpUsxiclZSY2Xs7Bv35eunZVoa/oe8eM3tVQ7HRHyWtNWW5fYwQ2Zq17SQm5ZuuwM/eia1kgJtswbK8/tdI/4IACt98vUEJAF5i0G0dQ/qq6SpAF7vZ2WbFTIn1ZwuvTsJCfZy1ODpjTTnt2B++Tv/+dqK3upJcuByxKXlteuZbOqk9UYZvkaEysTlRMg8yR4AcHVhMbax2d6J1ZMzvWqrIiltm1lxyknGPoHHfgXcCkphvo4lUKPe9RgUqmrgmk9vei2iYY6Kh09wWQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2UtDOveWQFw6bQ3W/b5xhV2eK6Y/SC8e4LWsdEW7e4=;
 b=ZJ+z7Ww3QJCRmiPLe723hkQXNMt/lRhrEfR1lbMgmULb5O7oXy9QDqLCzRSRYo87pCsfSjbT7i3gs7OxtRVlxDE8s93BOL3CS1eCtMnpGZ8RhUjxYRR1CnBhgWy67/kSsS1MtiYgcQd5gqMXLpManjFKKOPhVTb4/OJPPA9YfdfEoZnsw4ENynk1kJNuTQxMMydlDQ6ZYsiGb/3tFI2nCTVrrSCh4Io9VLQc4M0B44eP1fTsoFhX6fPd4CKcA4emMqvB+UK8g+jZpydJqyaKnl7Q4z6NE4/xtk/Kvzpd4wyCQP1O2fy7ItxH+X5Y/7O/dfF2KRPjfWx2BLjynH5z+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=suse.com smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2UtDOveWQFw6bQ3W/b5xhV2eK6Y/SC8e4LWsdEW7e4=;
 b=WKoNeUpwNFytuSWPiql9QB+A5xgNbtjIxrfyz5NRclOswR3RNZM7ua2p3W/pixlwNUmqsen0juyopsTGAajyGOFUaeLcnmvl22GcUGsa5FsiQ9XaacwnS7bQLs0Gvucg5im9WlY3+SH0J1zepg8j5Q7ofSXyYXWV9PRXkmTLDhk=
Received: from BN6PR03CA0004.namprd03.prod.outlook.com (2603:10b6:404:23::14)
 by DM6PR03MB3641.namprd03.prod.outlook.com (2603:10b6:5:b6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.20; Tue, 3 Dec
 2019 13:56:19 +0000
Received: from SN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BN6PR03CA0004.outlook.office365.com
 (2603:10b6:404:23::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.18 via Frontend
 Transport; Tue, 3 Dec 2019 13:56:19 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT022.mail.protection.outlook.com (10.152.72.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Tue, 3 Dec 2019 13:56:19 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xB3DuIgU007851
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 3 Dec 2019 05:56:18 -0800
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.231) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 3 Dec 2019 08:56:18 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <linux-hwmon@vger.kernel.org>
CC:     <Michael.Hennerich@analog.com>, <linux-kernel@vger.kernel.org>,
        <jdelvare@suse.com>, <linux@roeck-us.net>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 1/3] hwmon: adm1177: Add ADM1177 Hot Swap Controller and Digital Power Monitor driver
Date:   Tue, 3 Dec 2019 15:57:09 +0200
Message-ID: <20191203135711.13972-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(39860400002)(189003)(199004)(2616005)(26005)(8936002)(356004)(6666004)(6306002)(50226002)(8676002)(4326008)(2906002)(2351001)(51416003)(50466002)(107886003)(44832011)(305945005)(106002)(48376002)(14444005)(7636002)(426003)(1076003)(36756003)(86362001)(246002)(7696005)(316002)(54906003)(16586007)(5660300002)(336012)(966005)(478600001)(186003)(70586007)(6916009)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3641;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d3ecbff-b5b0-43eb-beb1-08d777f892d3
X-MS-TrafficTypeDiagnostic: DM6PR03MB3641:
X-Microsoft-Antispam-PRVS: <DM6PR03MB3641C2E7425351CEDA013A70F0420@DM6PR03MB3641.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-Forefront-PRVS: 02408926C4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s0ywSHKuS4DfT+YjHfcdgCylUo1XCbKJa5vE3aCCq6ihKRGR6LaD5J0gL8J978TM+JyKFQ4j6MfiEy14tBPrg8XGw6JyI4qhND+gvQKx8scKCgG1EjAmMhc7wV8tr+FEDU6YL9pyTAA+1PS9LVP9sqG3T+n7MhlPAFMKmAeLFERXUXNAhL1ASxN25E7am0eOckvP4dOjvgvcfULwKE8ef4eKeOmFZ5xbM/5Z7dCCn9EmEtB8HsIWP3cPWKIq65gKP+iNNcWTpOyAgXMJyQTnUi1tGlzlBtFgnJNp09PzLc7Ht5iM+MRg7tDI8qrztCBIZeF0pZl27cQusDsu9D2kMIMqXusCBwRyahXE2avvNoMMCMa+XsxXO62Y1WPYRBYpCoVy4fetQuIkRuUSbJIUcFwd/mXEyDkB5o6dAbZIUuulxn+/TR92FI+eE6AeR/f7GP1wK1+vpBKUi45O7nbBi6wfP0Fa+LcTU+OoDx0frhE=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2019 13:56:19.4008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3ecbff-b5b0-43eb-beb1-08d777f892d3
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3641
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-03_03:2019-12-02,2019-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADM1177 is a Hot Swap Controller and Digital Power Monitor with
Soft Start Pin.

Datasheet:
Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1177.pdf

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/hwmon/Kconfig   |  10 ++
 drivers/hwmon/Makefile  |   1 +
 drivers/hwmon/adm1177.c | 274 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 285 insertions(+)
 create mode 100644 drivers/hwmon/adm1177.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 5308c59d7001..3db8f5752675 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -164,6 +164,16 @@ config SENSORS_ADM1031
 	  This driver can also be built as a module. If so, the module
 	  will be called adm1031.
 
+config SENSORS_ADM1177
+	tristate "Analog Devices ADM1177 and compatibles"
+	depends on I2C
+	help
+	  If you say yes here you get support for Analog Devices ADM1177
+	  sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called adm1177.
+
 config SENSORS_ADM9240
 	tristate "Analog Devices ADM9240 and compatibles"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 40c036ea45e6..27d04eab1be4 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_SENSORS_ADM1025)	+= adm1025.o
 obj-$(CONFIG_SENSORS_ADM1026)	+= adm1026.o
 obj-$(CONFIG_SENSORS_ADM1029)	+= adm1029.o
 obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031.o
+obj-$(CONFIG_SENSORS_ADM1177)	+= adm1177.o
 obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
 obj-$(CONFIG_SENSORS_ADS7828)	+= ads7828.o
 obj-$(CONFIG_SENSORS_ADS7871)	+= ads7871.o
diff --git a/drivers/hwmon/adm1177.c b/drivers/hwmon/adm1177.c
new file mode 100644
index 000000000000..08950cecc9f9
--- /dev/null
+++ b/drivers/hwmon/adm1177.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ADM1177 Hot Swap Controller and Digital Power Monitor with Soft Start Pin
+ *
+ * Copyright 2015-2019 Analog Devices Inc.
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/regulator/consumer.h>
+
+/*  Command Byte Operations */
+#define ADM1177_CMD_V_CONT	BIT(0)
+#define ADM1177_CMD_V_ONCE	BIT(1)
+#define ADM1177_CMD_I_CONT	BIT(2)
+#define ADM1177_CMD_I_ONCE	BIT(3)
+#define ADM1177_CMD_VRANGE	BIT(4)
+#define ADM1177_CMD_STATUS_RD	BIT(6)
+
+/* Extended Register */
+#define ADM1177_REG_ALERT_EN	1
+#define ADM1177_REG_ALERT_TH	2
+#define ADM1177_REG_CONTROL	3
+
+/* ADM1177_REG_ALERT_EN */
+#define ADM1177_EN_ADC_OC1	BIT(0)
+#define ADM1177_EN_ADC_OC4	BIT(1)
+#define ADM1177_EN_HS_ALERT	BIT(2)
+#define ADM1177_EN_OFF_ALERT	BIT(3)
+#define ADM1177_CLEAR		BIT(4)
+
+/* ADM1177_REG_CONTROL */
+#define ADM1177_SWOFF		BIT(0)
+
+#define ADM1177_BITS		12
+
+/**
+ * struct adm1177_state - driver instance specific data
+ * @client		pointer to i2c client
+ * @reg			regulator info for the the power supply of the device
+ * @command		internal control register
+ * @r_sense_uohm	current sense resistor value
+ * @alert_threshold_ua	current limit for shutdown
+ * @vrange_high		internal voltage divider
+ */
+struct adm1177_state {
+	struct i2c_client	*client;
+	struct regulator	*reg;
+	u8			command;
+	u32			r_sense_uohm;
+	u32			alert_threshold_ua;
+	bool			vrange_high;
+};
+
+static int adm1177_read_raw(struct adm1177_state *st, u8 num, u8 *data)
+{
+	struct i2c_client *client = st->client;
+
+	return i2c_master_recv(client, data, num);
+}
+
+static int adm1177_write_cmd(struct adm1177_state *st, u8 cmd)
+{
+	st->command = cmd;
+	return i2c_smbus_write_byte(st->client, cmd);
+}
+
+static int adm1177_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	struct adm1177_state *st = dev_get_drvdata(dev);
+	u8 data[3];
+	long dummy;
+	int ret;
+
+	switch (type) {
+	case hwmon_curr:
+		ret = adm1177_read_raw(st, 3, data);
+		if (ret < 0)
+			return ret;
+		dummy = (data[1] << 4) | (data[2] & 0xF);
+		/*
+		 * convert in milliamperes
+		 * ((105.84mV / 4096) x raw) / senseResistor(ohm)
+		 */
+		*val = div_u64((105840000ull * dummy), 4096 * st->r_sense_uohm);
+		return 0;
+	case hwmon_in:
+		ret = adm1177_read_raw(st, 3, data);
+		if (ret < 0)
+			return ret;
+		dummy = (data[0] << 4) | (data[2] >> 4);
+		/*
+		 * convert in millivolts based on resistor devision
+		 * (V_fullscale / 4096) * raw
+		 */
+		if (st->command & ADM1177_CMD_VRANGE)
+			*val = 6650;
+		else
+			*val = 26350;
+
+		*val = ((*val * dummy) / 4096);
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t adm1177_is_visible(const void *data,
+				  enum hwmon_sensor_types type,
+				  u32 attr, int channel)
+{
+	const struct adm1177_state *st = data;
+
+	switch (type) {
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+			return 0444;
+		}
+		break;
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_input:
+			if (st->r_sense_uohm)
+				return 0444;
+			return 0;
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static const u32 adm1177_curr_config[] = {
+	HWMON_C_INPUT,
+	0
+};
+
+static const struct hwmon_channel_info adm1177_curr = {
+	.type = hwmon_curr,
+	.config = adm1177_curr_config,
+};
+
+static const u32 adm1177_in_config[] = {
+	HWMON_I_INPUT,
+	0
+};
+
+static const struct hwmon_channel_info adm1177_in = {
+	.type = hwmon_in,
+	.config = adm1177_in_config,
+};
+
+static const struct hwmon_channel_info *adm1177_info[] = {
+	&adm1177_curr,
+	&adm1177_in,
+	NULL
+};
+
+static const struct hwmon_ops adm1177_hwmon_ops = {
+	.is_visible = adm1177_is_visible,
+	.read = adm1177_read,
+};
+
+static const struct hwmon_chip_info adm1177_chip_info = {
+	.ops = &adm1177_hwmon_ops,
+	.info = adm1177_info,
+};
+
+static void adm1177_remove(void *data)
+{
+	struct adm1177_state *st = data;
+
+	regulator_disable(st->reg);
+}
+
+static int adm1177_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
+	struct adm1177_state *st;
+	int ret;
+
+	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->client = client;
+
+	st->reg = devm_regulator_get_optional(&client->dev, "vref");
+	if (IS_ERR(st->reg)) {
+		if (PTR_ERR(st->reg) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		st->reg = NULL;
+	} else {
+		ret = regulator_enable(st->reg);
+		if (ret)
+			return ret;
+		ret = devm_add_action_or_reset(&client->dev, adm1177_remove,
+					       st);
+		if (ret)
+			return ret;
+	}
+
+	if (device_property_read_u32(dev, "adi,r-sense-micro-ohms",
+				     &st->r_sense_uohm))
+		st->r_sense_uohm = 1;
+	if (device_property_read_u32(dev, "adi,shutdown-threshold-microamp",
+				     &st->alert_threshold_ua))
+		st->alert_threshold_ua = 0;
+	st->vrange_high = device_property_read_bool(dev,
+						    "adi,vrange-high-enable");
+	if (st->alert_threshold_ua) {
+		u64 val;
+
+		val = (0xFFUL * st->alert_threshold_ua * st->r_sense_uohm);
+		val = div_u64(val, 105840000U);
+		if (val > 0xFF) {
+			dev_warn(&client->dev,
+				 "Requested shutdown current %d uA above limit\n",
+				 st->alert_threshold_ua);
+
+			val = 0xFF;
+		}
+		i2c_smbus_write_byte_data(st->client, ADM1177_REG_ALERT_TH,
+					  val);
+	}
+
+	ret = adm1177_write_cmd(st, ADM1177_CMD_V_CONT |
+				    ADM1177_CMD_I_CONT |
+				    (st->vrange_high ? 0 : ADM1177_CMD_VRANGE));
+	if (ret)
+		return ret;
+
+	hwmon_dev =
+		devm_hwmon_device_register_with_info(dev, client->name, st,
+						     &adm1177_chip_info, NULL);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct i2c_device_id adm1177_id[] = {
+	{"adm1177", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, adm1177_id);
+
+static const struct of_device_id adm1177_dt_ids[] = {
+	{ .compatible = "adi,adm1177" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, adm1177_dt_ids);
+
+static struct i2c_driver adm1177_driver = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {
+		.name = "adm1177",
+		.of_match_table = adm1177_dt_ids,
+	},
+	.probe = adm1177_probe,
+	.id_table = adm1177_id,
+};
+module_i2c_driver(adm1177_driver);
+
+MODULE_AUTHOR("Beniamin Bia <beniamin.bia@analog.com>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADM1177 ADC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

