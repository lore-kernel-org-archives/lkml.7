Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556C6C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE422082E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="QPl2xLBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfLSLit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:38:49 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:38360 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726656AbfLSLis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:38:48 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJBZVWb026362;
        Thu, 19 Dec 2019 06:38:19 -0500
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2052.outbound.protection.outlook.com [104.47.38.52])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wvw8cv739-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 06:38:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxqtnNetUhAFBANtRJt4gYizQhfAYRCLkeloq2ZdcALFonRkdSawT71Rfvn+pKrN9SPx6gfouxUQpbN5ZfQ0GtjZgoZPYtMk62M/ZIfoCPXMKv2m+V+XjaD+XGmMftVvZfA37NBMZ5nr5GzM1KciOyQh0fv0nFDcUsFOC7QI2M3KzciV4IFv64LuZX50TnlUx2Hn4YXfXcViwGBJ7hqK7tmEnqUHRZERyrqoTAD80Q6skR28P6NW75bUgcyWd33PTLRfJ3lupahkgXVQbr+KeWOuqGS+BUMolT6X2El2X5S8BMTpVIkIje0vfUoDJMVpIRjmMl7SaslljGdoFhSa+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+od65jC1/e3bV5O0uD0IKYmFuJnq0eQjXCFrNFVaa8=;
 b=kPPxBnr8Hyn4arImzVmkHgWbSEJyfDeB6gBbSzXp8DUrlQDWN9a0GHM9dAlQ5/ASwG1wkYdu58vBi5OqhN1J5lIV1uomL/UX98IgulQX+ET3kfUSSC3GvHKZaOEIC3KLIruaw+GunHZG8NHo0OTzgJlOUDxCAcTJOfntSTZe2pgUwcjoSO+netXsxlJQeFSHXvI/qGFhJCANSGP3ubLbUYy4ZY7E1bafKUYG6yVGSLmYxjVMFZXPJOV7MR1JHsRSLhdF09pO35O5HGlMdxe2l0p/sIg0gqGnChQzxmD0NRVm1Cmn312bWUvPWtjl8O65ezkhSX+UAgBDd615fhxm3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+od65jC1/e3bV5O0uD0IKYmFuJnq0eQjXCFrNFVaa8=;
 b=QPl2xLBnGHE0s9qbGkcKnEcT0urYyzHJaCs01ZuWoA5gG7iUwjd5bOcxERUY/qCUZ9EHkkhsjT90/IZeSCORodU//GuTb2Vz/M41Yuu8WIfcguaNNdCBB48nm5KwdDnUoJCo7tT8FeAi3tu++SRDp6ENxRcdU8CMZ+rpzdazY38=
Received: from SN6PR05CA0020.namprd05.prod.outlook.com (2603:10b6:805:de::33)
 by DM6PR03MB5322.namprd03.prod.outlook.com (2603:10b6:5:247::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14; Thu, 19 Dec
 2019 11:38:17 +0000
Received: from SN1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:de:cafe::57) by SN6PR05CA0020.outlook.office365.com
 (2603:10b6:805:de::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.10 via Frontend
 Transport; Thu, 19 Dec 2019 11:38:17 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT008.mail.protection.outlook.com (10.152.72.119) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2559.14
 via Frontend Transport; Thu, 19 Dec 2019 11:38:16 +0000
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xBJBcFre031657
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Dec 2019 03:38:15 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 19 Dec
 2019 06:38:14 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 19 Dec 2019 03:38:13 -0800
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBJBc9tc003930;
        Thu, 19 Dec 2019 06:38:09 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <linux-hwmon@vger.kernel.org>
CC:     <Michael.Hennerich@analog.com>, <linux-kernel@vger.kernel.org>,
        <jdelvare@suse.com>, <linux@roeck-us.net>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v2 1/3] hwmon: adm1177: Add ADM1177 Hot Swap Controller and Digital Power Monitor driver
Date:   Thu, 19 Dec 2019 13:39:24 +0200
Message-ID: <20191219113926.21749-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(199004)(189003)(316002)(70206006)(2616005)(966005)(107886003)(8676002)(70586007)(426003)(8936002)(2906002)(336012)(356004)(246002)(26005)(7636002)(7696005)(1076003)(478600001)(5660300002)(6916009)(54906003)(4326008)(6666004)(186003)(86362001)(44832011)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB5322;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecbf0566-f526-46a5-e70e-08d78477f091
X-MS-TrafficTypeDiagnostic: DM6PR03MB5322:
X-Microsoft-Antispam-PRVS: <DM6PR03MB53227054B221A7D52A3C83ACF0520@DM6PR03MB5322.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0256C18696
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wPte6Iv6OmYeOXVFU6OYM2kEJg6qaQUzFGDg+IvC2qcP3u21wYG9QjBVEWjz+JAta5tR5h6DX59po8/IIn4k8nrBotvGV+QRXmVP+5Us7/L8fzPF4W0jqvjNEkb9haCNZGQNCQGb4YiX6gcbNfYefBf7D3m7Gkk9pDGB2Ujoo2mrZzz1wWxulndDLuTOZ5gXWlacRsZRgbEwPWm69JbxnORa6qwgy/pSCVif84RcEniNPQzcJ9KfCg76aKKPTRa2+xt8Ikow/ZbPT7XocrH0pDQXDk+B1SIdBtFFJKNQGBOBHLvSwgHV5AOCg0ogADtLJEEoIG/UaHrdzQcizLkTniUcuwGmkTbrcZY/A2RxdsXFEsBgNbiet+IINp1yhItiHLClCCoDHdLJroX8WzlSg/lgAGBnIi26g7OZTHUnjfw645kOJNItOxaj1iyk6pUFIL6SVLXjH2KSLpMhQ3L83Rphde1/QEil7Bf07r7c5Uw=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 11:38:16.7131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbf0566-f526-46a5-e70e-08d78477f091
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5322
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_01:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190100
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
 Documentation/hwmon/adm1177.rst |  36 ++++
 drivers/hwmon/Kconfig           |  10 ++
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/adm1177.c         | 293 ++++++++++++++++++++++++++++++++
 4 files changed, 340 insertions(+)
 create mode 100644 Documentation/hwmon/adm1177.rst
 create mode 100644 drivers/hwmon/adm1177.c

diff --git a/Documentation/hwmon/adm1177.rst b/Documentation/hwmon/adm1177.rst
new file mode 100644
index 000000000000..c81e0b4abd28
--- /dev/null
+++ b/Documentation/hwmon/adm1177.rst
@@ -0,0 +1,36 @@
+Kernel driver adm1177
+=====================
+
+Supported chips:
+  * Analog Devices ADM1177
+    Prefix: 'adm1177'
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1177.pdf
+
+Author: Beniamin Bia <beniamin.bia@analog.com>
+
+
+Description
+-----------
+
+This driver supports hardware monitoring for Analog Devices ADM1177
+Hot-Swap Controller and Digital Power Monitors with Soft Start Pin.
+
+
+Usage Notes
+-----------
+
+This driver does not auto-detect devices. You will have to instantiate the
+devices explicitly. Please see Documentation/i2c/instantiating-devices for
+details.
+
+
+Sysfs entries
+-------------
+
+The following attributes are supported. Current maxim attribute
+is read-write, all other attributes are read-only.
+
+in0_input		Measured voltage in microvolts.
+
+curr1_input		Measured current in microamperes.
+curr1_max_alarm		Overcurrent alarm in microamperes.
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
index 000000000000..aaa9e17289f4
--- /dev/null
+++ b/drivers/hwmon/adm1177.c
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ADM1177 Hot Swap Controller and Digital Power Monitor with Soft Start Pin
+ *
+ * Copyright 2015-2019 Analog Devices Inc.
+ */
+
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/hwmon.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+
+/*  Command Byte Operations */
+#define ADM1177_CMD_V_CONT	BIT(0)
+#define ADM1177_CMD_I_CONT	BIT(2)
+#define ADM1177_CMD_VRANGE	BIT(4)
+
+/* Extended Register */
+#define ADM1177_REG_ALERT_TH	2
+
+#define ADM1177_BITS		12
+
+/**
+ * struct adm1177_state - driver instance specific data
+ * @client		pointer to i2c client
+ * @reg			regulator info for the the power supply of the device
+ * @r_sense_uohm	current sense resistor value
+ * @alert_threshold_ua	current limit for shutdown
+ * @vrange_high		internal voltage divider
+ */
+struct adm1177_state {
+	struct i2c_client	*client;
+	struct regulator	*reg;
+	u32			r_sense_uohm;
+	u32			alert_threshold_ua;
+	bool			vrange_high;
+};
+
+static int adm1177_read_raw(struct adm1177_state *st, u8 num, u8 *data)
+{
+	return i2c_master_recv(st->client, data, num);
+}
+
+static int adm1177_write_cmd(struct adm1177_state *st, u8 cmd)
+{
+	return i2c_smbus_write_byte(st->client, cmd);
+}
+
+static int adm1177_write_alert_thr(struct adm1177_state *st,
+				   u32 alert_threshold_ua)
+{
+	u64 val;
+	int ret;
+
+	val = 0xFFULL * alert_threshold_ua * st->r_sense_uohm;
+	val = div_u64(val, 105840000U);
+	val = div_u64(val, 1000U);
+	if (val > 0xFF) {
+		dev_warn(&st->client->dev,
+			 "Requested shutdown current %d uA above limit\n",
+			 alert_threshold_ua);
+
+		return -EINVAL;
+	}
+
+	ret = i2c_smbus_write_byte_data(st->client, ADM1177_REG_ALERT_TH,
+					val);
+	if (!ret)
+		return ret;
+
+	st->alert_threshold_ua = alert_threshold_ua;
+	return 0;
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
+		switch (attr) {
+		case hwmon_curr_input:
+			ret = adm1177_read_raw(st, 3, data);
+			if (ret < 0)
+				return ret;
+			dummy = (data[1] << 4) | (data[2] & 0xF);
+			/*
+			 * convert to milliamperes
+			 * ((105.84mV / 4096) x raw) / senseResistor(ohm)
+			 */
+			*val = div_u64((105840000ull * dummy),
+				       4096 * st->r_sense_uohm);
+			return 0;
+		case hwmon_curr_max_alarm:
+			*val = st->alert_threshold_ua;
+			return 0;
+		default:
+			return -EOPNOTSUPP;
+		}
+	case hwmon_in:
+		ret = adm1177_read_raw(st, 3, data);
+		if (ret < 0)
+			return ret;
+		dummy = (data[0] << 4) | (data[2] >> 4);
+		/*
+		 * convert to millivolts based on resistor devision
+		 * (V_fullscale / 4096) * raw
+		 */
+		if (st->vrange_high)
+			dummy *= 26350;
+		else
+			dummy *= 6650;
+
+		*val = DIV_ROUND_CLOSEST(dummy, 4096);
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int adm1177_write(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long val)
+{
+	struct adm1177_state *st = dev_get_drvdata(dev);
+
+	switch (type) {
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_max_alarm:
+			adm1177_write_alert_thr(st, val);
+			return 0;
+		default:
+			return -EOPNOTSUPP;
+		}
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
+		case hwmon_curr_max_alarm:
+			if (st->r_sense_uohm)
+				return 0644;
+			return 0;
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static const struct hwmon_channel_info *adm1177_info[] = {
+	HWMON_CHANNEL_INFO(curr,
+			   HWMON_C_INPUT | HWMON_C_MAX_ALARM),
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops adm1177_hwmon_ops = {
+	.is_visible = adm1177_is_visible,
+	.read = adm1177_read,
+	.write = adm1177_write,
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
+	u32 alert_threshold_ua;
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
+	if (device_property_read_u32(dev, "shunt-resistor-micro-ohms",
+				     &st->r_sense_uohm))
+		st->r_sense_uohm = 0;
+	if (device_property_read_u32(dev, "adi,shutdown-threshold-microamp",
+				     &alert_threshold_ua)) {
+		if (st->r_sense_uohm)
+			/*
+			 * set maximum default value from datasheet based on
+			 * shunt-resistor
+			 */
+			alert_threshold_ua = div_u64(105840000000,
+						     st->r_sense_uohm);
+		else
+			alert_threshold_ua = 0;
+	}
+	st->vrange_high = device_property_read_bool(dev,
+						    "adi,vrange-high-enable");
+	if (alert_threshold_ua && st->r_sense_uohm)
+		adm1177_write_alert_thr(st, alert_threshold_ua);
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

