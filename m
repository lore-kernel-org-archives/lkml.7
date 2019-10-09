Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B633BECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B9F21BE5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbfJITLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 15:11:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732116AbfJITLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:45 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x99Im51m031124;
        Wed, 9 Oct 2019 15:11:09 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vhkdycf8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Oct 2019 15:11:09 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x99J5KQK009954;
        Wed, 9 Oct 2019 19:11:10 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01wdc.us.ibm.com with ESMTP id 2vejt745ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Oct 2019 19:11:10 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x99JB7jG57540966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Oct 2019 19:11:07 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DAC66E056;
        Wed,  9 Oct 2019 19:11:07 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0742B6E04E;
        Wed,  9 Oct 2019 19:11:06 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  9 Oct 2019 19:11:06 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jdelvare@suse.com, linux@roeck-us.net, mark.rutland@arm.com,
        robh+dt@kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 2/2] hwmon: (pmbus/ibm-cffps) Add version detection capability
Date:   Wed,  9 Oct 2019 14:11:02 -0500
Message-Id: <1570648262-25383-3-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570648262-25383-1-git-send-email-eajames@linux.ibm.com>
References: <1570648262-25383-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-09_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910090153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some systems may plug in either version 1 or version 2 of the IBM common
form factor power supply. Add a version-less compatibility string that
tells the driver to try and detect which version of the power supply is
connected.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/pmbus/ibm-cffps.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
index d44745e..d61547e 100644
--- a/drivers/hwmon/pmbus/ibm-cffps.c
+++ b/drivers/hwmon/pmbus/ibm-cffps.c
@@ -3,6 +3,7 @@
  * Copyright 2017 IBM Corp.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
@@ -29,6 +30,10 @@
 #define CFFPS_INPUT_HISTORY_CMD			0xD6
 #define CFFPS_INPUT_HISTORY_SIZE		100
 
+#define CFFPS_CCIN_VERSION			GENMASK(15, 8)
+#define CFFPS_CCIN_VERSION_1			 0x2b
+#define CFFPS_CCIN_VERSION_2			 0x2e
+
 /* STATUS_MFR_SPECIFIC bits */
 #define CFFPS_MFR_FAN_FAULT			BIT(0)
 #define CFFPS_MFR_THERMAL_FAULT			BIT(1)
@@ -54,7 +59,7 @@ enum {
 	CFFPS_DEBUGFS_NUM_ENTRIES
 };
 
-enum versions { cffps1, cffps2 };
+enum versions { cffps1, cffps2, cffps_unknown };
 
 struct ibm_cffps_input_history {
 	struct mutex update_lock;
@@ -395,7 +400,7 @@ static int ibm_cffps_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
 	int i, rc;
-	enum versions vs;
+	enum versions vs = cffps_unknown;
 	struct dentry *debugfs;
 	struct dentry *ibm_cffps_dir;
 	struct ibm_cffps *psu;
@@ -405,8 +410,27 @@ static int ibm_cffps_probe(struct i2c_client *client,
 		vs = (enum versions)md;
 	else if (id)
 		vs = (enum versions)id->driver_data;
-	else
-		vs = cffps1;
+
+	if (vs == cffps_unknown) {
+		u16 ccin_version = CFFPS_CCIN_VERSION_1;
+		int ccin = i2c_smbus_read_word_swapped(client, CFFPS_CCIN_CMD);
+
+		if (ccin > 0)
+			ccin_version = FIELD_GET(CFFPS_CCIN_VERSION, ccin);
+
+		switch (ccin_version) {
+		default:
+		case CFFPS_CCIN_VERSION_1:
+			vs = cffps1;
+			break;
+		case CFFPS_CCIN_VERSION_2:
+			vs = cffps2;
+			break;
+		}
+
+		/* Set the client name to include the version number. */
+		snprintf(client->name, I2C_NAME_SIZE, "cffps%d", vs + 1);
+	}
 
 	client->dev.platform_data = &ibm_cffps_pdata;
 	rc = pmbus_do_probe(client, id, &ibm_cffps_info[vs]);
@@ -465,6 +489,7 @@ static int ibm_cffps_probe(struct i2c_client *client,
 static const struct i2c_device_id ibm_cffps_id[] = {
 	{ "ibm_cffps1", cffps1 },
 	{ "ibm_cffps2", cffps2 },
+	{ "ibm_cffps", cffps_unknown },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ibm_cffps_id);
@@ -478,6 +503,10 @@ static int ibm_cffps_probe(struct i2c_client *client,
 		.compatible = "ibm,cffps2",
 		.data = (void *)cffps2
 	},
+	{
+		.compatible = "ibm,cffps",
+		.data = (void *)cffps_unknown
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, ibm_cffps_of_match);
-- 
1.8.3.1

