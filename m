Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B68C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7DA20659
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfH3TLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 15:11:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32882 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727888AbfH3TLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 15:11:48 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7UIqJxb093132;
        Fri, 30 Aug 2019 15:11:10 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uq6g6pfh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Aug 2019 15:11:10 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7UItUpx002656;
        Fri, 30 Aug 2019 19:11:09 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03dal.us.ibm.com with ESMTP id 2umpcu31yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Aug 2019 19:11:09 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7UJB70E34275640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 19:11:07 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE5AC136066;
        Fri, 30 Aug 2019 19:11:07 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23048136051;
        Fri, 30 Aug 2019 19:11:07 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 30 Aug 2019 19:11:07 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux@roeck-us.net, andrew@aj.id.au,
        joel@jms.id.au, mark.rutland@arm.com, robh+dt@kernel.org,
        jdelvare@suse.com, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 3/3] pmbus: ibm-cffps: Add support for version 2 of the PSU
Date:   Fri, 30 Aug 2019 14:11:03 -0500
Message-Id: <1567192263-15065-4-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1567192263-15065-1-git-send-email-eajames@linux.ibm.com>
References: <1567192263-15065-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908300179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2 of the PSU supports a second page of data and changes the
format of the FW version. Use the devicetree binding to differentiate
between the version the driver should use.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v1:
 - use an enum for the version instead of integers 1, 2, etc

 drivers/hwmon/pmbus/ibm-cffps.c | 110 ++++++++++++++++++++++++++++++++--------
 1 file changed, 88 insertions(+), 22 deletions(-)

diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
index ee2ee9e..d44745e 100644
--- a/drivers/hwmon/pmbus/ibm-cffps.c
+++ b/drivers/hwmon/pmbus/ibm-cffps.c
@@ -12,6 +12,7 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of_device.h>
 #include <linux/pmbus.h>
 
 #include "pmbus.h"
@@ -20,8 +21,9 @@
 #define CFFPS_PN_CMD				0x9B
 #define CFFPS_SN_CMD				0x9E
 #define CFFPS_CCIN_CMD				0xBD
-#define CFFPS_FW_CMD_START			0xFA
-#define CFFPS_FW_NUM_BYTES			4
+#define CFFPS_FW_CMD				0xFA
+#define CFFPS1_FW_NUM_BYTES			4
+#define CFFPS2_FW_NUM_WORDS			3
 #define CFFPS_SYS_CONFIG_CMD			0xDA
 
 #define CFFPS_INPUT_HISTORY_CMD			0xD6
@@ -52,6 +54,8 @@ enum {
 	CFFPS_DEBUGFS_NUM_ENTRIES
 };
 
+enum versions { cffps1, cffps2 };
+
 struct ibm_cffps_input_history {
 	struct mutex update_lock;
 	unsigned long last_update;
@@ -61,6 +65,7 @@ struct ibm_cffps_input_history {
 };
 
 struct ibm_cffps {
+	enum versions version;
 	struct i2c_client *client;
 
 	struct ibm_cffps_input_history input_history;
@@ -132,6 +137,8 @@ static ssize_t ibm_cffps_debugfs_op(struct file *file, char __user *buf,
 	struct ibm_cffps *psu = to_psu(idxp, idx);
 	char data[I2C_SMBUS_BLOCK_MAX] = { 0 };
 
+	pmbus_set_page(psu->client, 0);
+
 	switch (idx) {
 	case CFFPS_DEBUGFS_INPUT_HISTORY:
 		return ibm_cffps_read_input_history(psu, buf, count, ppos);
@@ -152,16 +159,36 @@ static ssize_t ibm_cffps_debugfs_op(struct file *file, char __user *buf,
 		rc = snprintf(data, 5, "%04X", rc);
 		goto done;
 	case CFFPS_DEBUGFS_FW:
-		for (i = 0; i < CFFPS_FW_NUM_BYTES; ++i) {
-			rc = i2c_smbus_read_byte_data(psu->client,
-						      CFFPS_FW_CMD_START + i);
-			if (rc < 0)
-				return rc;
+		switch (psu->version) {
+		case cffps1:
+			for (i = 0; i < CFFPS1_FW_NUM_BYTES; ++i) {
+				rc = i2c_smbus_read_byte_data(psu->client,
+							      CFFPS_FW_CMD +
+								i);
+				if (rc < 0)
+					return rc;
+
+				snprintf(&data[i * 2], 3, "%02X", rc);
+			}
 
-			snprintf(&data[i * 2], 3, "%02X", rc);
-		}
+			rc = i * 2;
+			break;
+		case cffps2:
+			for (i = 0; i < CFFPS2_FW_NUM_WORDS; ++i) {
+				rc = i2c_smbus_read_word_data(psu->client,
+							      CFFPS_FW_CMD +
+								i);
+				if (rc < 0)
+					return rc;
+
+				snprintf(&data[i * 4], 5, "%04X", rc);
+			}
 
-		rc = i * 2;
+			rc = i * 4;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
 		goto done;
 	default:
 		return -EINVAL;
@@ -279,6 +306,8 @@ static void ibm_cffps_led_brightness_set(struct led_classdev *led_cdev,
 			psu->led_state = CFFPS_LED_ON;
 	}
 
+	pmbus_set_page(psu->client, 0);
+
 	rc = i2c_smbus_write_byte_data(psu->client, CFFPS_SYS_CONFIG_CMD,
 				       psu->led_state);
 	if (rc < 0)
@@ -299,6 +328,8 @@ static int ibm_cffps_led_blink_set(struct led_classdev *led_cdev,
 	if (led_cdev->brightness == LED_OFF)
 		return 0;
 
+	pmbus_set_page(psu->client, 0);
+
 	rc = i2c_smbus_write_byte_data(psu->client, CFFPS_SYS_CONFIG_CMD,
 				       CFFPS_LED_BLINK);
 	if (rc < 0)
@@ -328,15 +359,32 @@ static void ibm_cffps_create_led_class(struct ibm_cffps *psu)
 		dev_warn(dev, "failed to register led class: %d\n", rc);
 }
 
-static struct pmbus_driver_info ibm_cffps_info = {
-	.pages = 1,
-	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
-		PMBUS_HAVE_PIN | PMBUS_HAVE_FAN12 | PMBUS_HAVE_TEMP |
-		PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 | PMBUS_HAVE_STATUS_VOUT |
-		PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT |
-		PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_STATUS_FAN12,
-	.read_byte_data = ibm_cffps_read_byte_data,
-	.read_word_data = ibm_cffps_read_word_data,
+static struct pmbus_driver_info ibm_cffps_info[] = {
+	[cffps1] = {
+		.pages = 1,
+		.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
+			PMBUS_HAVE_PIN | PMBUS_HAVE_FAN12 | PMBUS_HAVE_TEMP |
+			PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
+			PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
+			PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP |
+			PMBUS_HAVE_STATUS_FAN12,
+		.read_byte_data = ibm_cffps_read_byte_data,
+		.read_word_data = ibm_cffps_read_word_data,
+	},
+	[cffps2] = {
+		.pages = 2,
+		.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
+			PMBUS_HAVE_PIN | PMBUS_HAVE_FAN12 | PMBUS_HAVE_TEMP |
+			PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
+			PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
+			PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP |
+			PMBUS_HAVE_STATUS_FAN12,
+		.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
+			PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
+			PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT,
+		.read_byte_data = ibm_cffps_read_byte_data,
+		.read_word_data = ibm_cffps_read_word_data,
+	},
 };
 
 static struct pmbus_platform_data ibm_cffps_pdata = {
@@ -347,12 +395,21 @@ static int ibm_cffps_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
 	int i, rc;
+	enum versions vs;
 	struct dentry *debugfs;
 	struct dentry *ibm_cffps_dir;
 	struct ibm_cffps *psu;
+	const void *md = of_device_get_match_data(&client->dev);
+
+	if (md)
+		vs = (enum versions)md;
+	else if (id)
+		vs = (enum versions)id->driver_data;
+	else
+		vs = cffps1;
 
 	client->dev.platform_data = &ibm_cffps_pdata;
-	rc = pmbus_do_probe(client, id, &ibm_cffps_info);
+	rc = pmbus_do_probe(client, id, &ibm_cffps_info[vs]);
 	if (rc)
 		return rc;
 
@@ -364,6 +421,7 @@ static int ibm_cffps_probe(struct i2c_client *client,
 	if (!psu)
 		return 0;
 
+	psu->version = vs;
 	psu->client = client;
 	mutex_init(&psu->input_history.update_lock);
 	psu->input_history.last_update = jiffies - HZ;
@@ -405,13 +463,21 @@ static int ibm_cffps_probe(struct i2c_client *client,
 }
 
 static const struct i2c_device_id ibm_cffps_id[] = {
-	{ "ibm_cffps1", 1 },
+	{ "ibm_cffps1", cffps1 },
+	{ "ibm_cffps2", cffps2 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ibm_cffps_id);
 
 static const struct of_device_id ibm_cffps_of_match[] = {
-	{ .compatible = "ibm,cffps1" },
+	{
+		.compatible = "ibm,cffps1",
+		.data = (void *)cffps1
+	},
+	{
+		.compatible = "ibm,cffps2",
+		.data = (void *)cffps2
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, ibm_cffps_of_match);
-- 
1.8.3.1

