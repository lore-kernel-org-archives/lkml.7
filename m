Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6E9C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC12B24676
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="BHKfFzFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfLSLkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:40:46 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:65146 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726668AbfLSLkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:40:45 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJBZI3w008614;
        Thu, 19 Dec 2019 06:40:18 -0500
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wxf1mytv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 06:40:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJZ9qkR1VN0T9Z990V1rTGK4UQynXj37L3VTSePjTCRfdWfsYY9BL2HyQzR2dklHpZnalpQ2n/X/BZnQsDEwS5BgvRWEjs9GFZwsa2D1vwaVpT7vNOYeSPSXhcMpq3xIUjiNqXvLNdRtJsO0VyfR8z1MtdiCwbzx9ERlTU/k/O7YuQWSKsSYRHJVJ588Z/jCuf+X5uBC5HOGOq8+c+YWX6dG6nhyeyuWK52rNukzYOS7RckN132E9VCo5E7XvlBehryObgXR87YJ2/deWamdo5Ph+uN5IUjOL8unAv2ll1GZwj6haxoB/sOBByZEHTn4quNRE/YPA+o5FpYtHohb5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHIkn0VOd2cwcu70sl5V/+S64bboosDYfvHOEOhc9Q0=;
 b=bvRqB9wXLFuE5Wru3amR6Us1qooUf3tz4oFY5dZj2Ba1EijJWeJqTWsXwgT75nODBzBg4rFRaAjZzaXuup8Aqpna+aMeT4quhMNfz5l9N8Jrl0NUkg/UWrGFmviljBzoQjnpZ3EkBa8EFoQFVHXdMrNb+rDe/2n3G+d7YWMtjn59gPLmgDwEDDi1neO0XzfVdVtXUM1JAEMdVv8SnYV2fJHumD7YGcjJ7ZwcS6Tocfk5/Xib8Gz2bCStM/q8CAeoRS6OGeZmGrvbyUwSFLfgi9NGcEpt+vjwQfkyWV1OKRt9DAntiUx2D55+3qnabZ4n2cxnSrBMZdNewlStcp5V+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHIkn0VOd2cwcu70sl5V/+S64bboosDYfvHOEOhc9Q0=;
 b=BHKfFzFG3rCoeU6z3AT1o6DnRGCfgouO0b57IBuIlNrTKpzP74wHxc6Ff1WSKmQepR/gFSk+S0CTLBffSAgVpCgDF45/4icbwwWTLEeedAhwBfXICOH37/TsrSdult/oiIcwHLskk80USwvTF+snhpSzNeCSeUu8ed6AnnE/sXk=
Received: from CY4PR13CA0009.namprd13.prod.outlook.com (2603:10b6:903:32::19)
 by DM6PR03MB4395.namprd03.prod.outlook.com (2603:10b6:5:108::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.16; Thu, 19 Dec
 2019 11:40:16 +0000
Received: from CY1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:32:cafe::97) by CY4PR13CA0009.outlook.office365.com
 (2603:10b6:903:32::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.11 via Frontend
 Transport; Thu, 19 Dec 2019 11:40:16 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT025.mail.protection.outlook.com (10.152.75.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2559.14
 via Frontend Transport; Thu, 19 Dec 2019 11:40:15 +0000
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xBJBeDq8013799
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Dec 2019 03:40:14 -0800
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 19 Dec
 2019 03:40:11 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 19 Dec 2019 06:40:11 -0500
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.203])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBJBe813004004;
        Thu, 19 Dec 2019 06:40:08 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <linux-hwmon@vger.kernel.org>
CC:     <Michael.Hennerich@analog.com>, <linux-kernel@vger.kernel.org>,
        <jdelvare@suse.com>, <linux@roeck-us.net>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v2 1/3] hwmon: adm1177: Add ADM1177 Hot Swap Controller and Digital Power Monitor driver
Date:   Thu, 19 Dec 2019 13:41:25 +0200
Message-ID: <20191219114127.21905-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39860400002)(189003)(199004)(1076003)(107886003)(246002)(8676002)(426003)(2906002)(54906003)(336012)(5660300002)(966005)(356004)(86362001)(26005)(7696005)(70206006)(6666004)(4326008)(7636002)(36756003)(70586007)(44832011)(186003)(478600001)(8936002)(6916009)(2616005)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4395;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d860c9b-41dd-46cf-9cd9-08d784783789
X-MS-TrafficTypeDiagnostic: DM6PR03MB4395:
X-Microsoft-Antispam-PRVS: <DM6PR03MB439588678C0B82648656E9BAF0520@DM6PR03MB4395.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0256C18696
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1u+MgUI6ah9RWlT+pa9Bb8uRVrTof/jwykPgWKraXkLtJbXU2RT7cN2y2dAJXhvLFjp/xKgpDNLRcX1jJRqE9Gsw2A+goPmr7an2AqYUhucYHQOSD5os5jeco5s4ZONCSZU1pAIRC1DOOEzsV3bJLACvV1qY5ny//PDp6SRSBo1JkAftUDu3v5J1fDYQG2CC9pBjJt+qVfMHYmIumHtoIx9xy9k2H4yN1EhoBLaiLz/TBm6Onnluebzcu+LSTo31CUN34vVRPAfK2teL347Va0NRQMDp37x4W9g5xu20KJDTPTk8hYEtTnzEArwozbIYysC4xATMeD4LBylktY0eGSgWZmZQ6EhGd5GluoH/3cdJdwrKQVQDu01qe1wdsZIzl9W15Ek/5KLv4JkH8Y8erCup7qrT1wfF//6RFiF06DY9ZSRMgU13jAs/PbTilyZO3Bh9wMPnDwX6ey5/OsDAb4TvSUgFXpll/cNEVzUquQ=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 11:40:15.5849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d860c9b-41dd-46cf-9cd9-08d784783789
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4395
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_01:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
Changes in v2:
-includes in alphabetical order 
-unsed defines removed 
-control variable from device_state structure removed 
-unnecessary variable removed from read_raw function  
-shutdown thresshold as sysfs property 
-channel definitions with HWMON_CHANNEL_INFO 
-hwmon documentation added
-removed unnecessary paranthesis  

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

