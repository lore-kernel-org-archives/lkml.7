Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245B7C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 22:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EFE242A8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 22:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="TIcEBMZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfE2Wf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 18:35:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55304 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbfE2Wf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 18:35:28 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4TMVcjS029423
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 15:35:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=22SNMUgGB2CXoUFYzuPVQZ60CnMhuhMebQ8GsCZJlx4=;
 b=TIcEBMZduyEZ2+pyhqCpYJ66Oe/TmavFKgqpMRBjOUZa8UJ+VDBNQVGeq7OnE82rLA2W
 tbNIpG7fAVXVz07oOrrnhR8jNLUq1eQJs7sAMPHXPDksMemWWoZxTkaNHKGuftWWUthy
 5tbIQyQM1WoWLw7BE39jyydQA0XV/zHd6E4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ssn0x2xb1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 15:35:27 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 29 May 2019 15:35:25 -0700
Received: by devvm4117.prn2.facebook.com (Postfix, from userid 167582)
        id 1D93CE882C2F; Wed, 29 May 2019 15:35:25 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Vijay Khemka <vijaykhemka@fb.com>
Smtp-Origin-Hostname: devvm4117.prn2.facebook.com
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <vijaykhemka@fb.com>, <joel@jms.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <sdasari@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH 1/2] hwmon: pmbus: Add Infineon PXE1610 VR driver
Date:   Wed, 29 May 2019 15:35:08 -0700
Message-ID: <20190529223511.4059120-1-vijaykhemka@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-29_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905290140
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added pmbus driver for the new device Infineon pxe1610
voltage regulator. It also supports similar family device
PXE1110 and PXM1310.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 drivers/hwmon/pmbus/Kconfig   |   9 +++
 drivers/hwmon/pmbus/Makefile  |   1 +
 drivers/hwmon/pmbus/pxe1610.c | 119 ++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 drivers/hwmon/pmbus/pxe1610.c

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 30751eb9550a..338ef9b5a395 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -154,6 +154,15 @@ config SENSORS_MAX8688
 	  This driver can also be built as a module. If so, the module will
 	  be called max8688.
 
+config SENSORS_PXE1610
+	tristate "Infineon PXE1610"
+	help
+	  If you say yes here you get hardware monitoring support for Infineon
+	  PXE1610.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called pxe1610.
+
 config SENSORS_TPS40422
 	tristate "TI TPS40422"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 2219b9300316..b0fbd017a91a 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_SENSORS_MAX20751)	+= max20751.o
 obj-$(CONFIG_SENSORS_MAX31785)	+= max31785.o
 obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
 obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
+obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
 obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
 obj-$(CONFIG_SENSORS_TPS53679)	+= tps53679.o
 obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
diff --git a/drivers/hwmon/pmbus/pxe1610.c b/drivers/hwmon/pmbus/pxe1610.c
new file mode 100644
index 000000000000..01e267944df5
--- /dev/null
+++ b/drivers/hwmon/pmbus/pxe1610.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hardware monitoring driver for Infineon PXE1610
+ *
+ * Copyright (c) 2019 Facebook Inc
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include "pmbus.h"
+
+/*
+ * Identify chip parameters.
+ */
+static int pxe1610_identify(struct i2c_client *client,
+			  struct pmbus_driver_info *info)
+{
+	if (pmbus_check_byte_register(client, 0, PMBUS_VOUT_MODE)) {
+		int vout_mode;
+
+		vout_mode = pmbus_read_byte_data(client, 0, PMBUS_VOUT_MODE);
+		switch (vout_mode & 0x1f) {
+		case 1:
+			info->vrm_version = vr12;
+		break;
+		case 2:
+			info->vrm_version = vr13;
+		break;
+		default:
+			return -ENODEV;
+		}
+	}
+	return 0;
+}
+
+static int pxe1610_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct pmbus_driver_info *info;
+	u8 buf[I2C_SMBUS_BLOCK_MAX];
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_BYTE_DATA
+				| I2C_FUNC_SMBUS_READ_WORD_DATA
+				| I2C_FUNC_SMBUS_READ_BLOCK_DATA))
+		return -ENODEV;
+
+	/* By default this device doesn't boot to page 0, so set page 0
+	 * to access all pmbus registers.
+	 */
+	i2c_smbus_write_byte_data(client, 0, 0);
+
+	/* Read Manufacturer id */
+	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to read PMBUS_MFR_ID\n");
+		return ret;
+	}
+	if (ret != 2 || strncmp(buf, "XP", strlen("XP"))) {
+		dev_err(&client->dev, "MFR_ID unrecognised\n");
+		return -ENODEV;
+	}
+
+	info = devm_kzalloc(&client->dev, sizeof(struct pmbus_driver_info),
+			    GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->format[PSC_VOLTAGE_IN] = linear;
+	info->format[PSC_VOLTAGE_OUT] = vid;
+	info->format[PSC_CURRENT_IN] = linear;
+	info->format[PSC_CURRENT_OUT] = linear;
+	info->format[PSC_POWER] = linear;
+	info->format[PSC_TEMPERATURE] = linear;
+
+	info->func[0] = PMBUS_HAVE_VIN
+		| PMBUS_HAVE_VOUT | PMBUS_HAVE_IIN
+		| PMBUS_HAVE_IOUT | PMBUS_HAVE_PIN
+		| PMBUS_HAVE_POUT | PMBUS_HAVE_TEMP
+		| PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT
+		| PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP;
+	info->func[1] = info->func[0];
+	info->func[2] = info->func[0];
+
+	info->pages = id->driver_data;
+	info->identify = pxe1610_identify;
+
+	return pmbus_do_probe(client, id, info);
+}
+
+static const struct i2c_device_id pxe1610_id[] = {
+	{"pxe1610", 3},
+	{"pxe1110", 3},
+	{"pxm1310", 3},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, pxe1610_id);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver pxe1610_driver = {
+	.driver = {
+		   .name = "pxe1610",
+		   },
+	.probe = pxe1610_probe,
+	.remove = pmbus_do_remove,
+	.id_table = pxe1610_id,
+};
+
+module_i2c_driver(pxe1610_driver);
+
+MODULE_AUTHOR("Vijay Khemka <vijaykhemka@fb.com>");
+MODULE_DESCRIPTION("PMBus driver for Infineon PXE1610, PXE1110 and PXM1310");
+MODULE_LICENSE("GPL");
-- 
2.17.1

