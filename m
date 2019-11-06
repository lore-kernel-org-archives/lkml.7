Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E512C5DF65
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B8E2173E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732491AbfKFUC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 15:02:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726934AbfKFUC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 15:02:56 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA6JwoxG062832;
        Wed, 6 Nov 2019 15:01:18 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w41wcepmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 15:01:17 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA6K0ebD022045;
        Wed, 6 Nov 2019 20:01:16 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 2w41uk1stf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 20:01:16 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA6K1FFf43843876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Nov 2019 20:01:15 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC5A528068;
        Wed,  6 Nov 2019 20:01:15 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 361E42805A;
        Wed,  6 Nov 2019 20:01:15 +0000 (GMT)
Received: from wisp4.ibm.com (unknown [9.163.22.179])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  6 Nov 2019 20:01:15 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        jdelvare@suse.com, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 2/2] hwmon: (pmbus/ibm-cffps) Fix LED blink behavior
Date:   Wed,  6 Nov 2019 14:01:06 -0600
Message-Id: <20191106200106.29519-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106200106.29519-1-eajames@linux.ibm.com>
References: <20191106200106.29519-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=796 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911060196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LED blink_set function incorrectly did not tell the PSU LED to blink
if brightness was LED_OFF. Fix this, and also correct the LED_OFF
command data, which should give control of the LED back to the PSU
firmware. Also prevent I2C failures from getting the driver LED state
out of sync and add some dev_dbg statements.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/pmbus/ibm-cffps.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
index c6a00e83aac6..d359b76bcb36 100644
--- a/drivers/hwmon/pmbus/ibm-cffps.c
+++ b/drivers/hwmon/pmbus/ibm-cffps.c
@@ -44,9 +44,13 @@
 #define CFFPS_MFR_VAUX_FAULT			BIT(6)
 #define CFFPS_MFR_CURRENT_SHARE_WARNING		BIT(7)
 
+/*
+ * LED off state actually relinquishes LED control to PSU firmware, so it can
+ * turn on the LED for faults.
+ */
+#define CFFPS_LED_OFF				0
 #define CFFPS_LED_BLINK				BIT(0)
 #define CFFPS_LED_ON				BIT(1)
-#define CFFPS_LED_OFF				BIT(2)
 #define CFFPS_BLINK_RATE_MS			250
 
 enum {
@@ -301,23 +305,31 @@ static int ibm_cffps_led_brightness_set(struct led_classdev *led_cdev,
 					enum led_brightness brightness)
 {
 	int rc;
+	u8 next_led_state;
 	struct ibm_cffps *psu = container_of(led_cdev, struct ibm_cffps, led);
 
 	if (brightness == LED_OFF) {
-		psu->led_state = CFFPS_LED_OFF;
+		next_led_state = CFFPS_LED_OFF;
 	} else {
 		brightness = LED_FULL;
+
 		if (psu->led_state != CFFPS_LED_BLINK)
-			psu->led_state = CFFPS_LED_ON;
+			next_led_state = CFFPS_LED_ON;
+		else
+			next_led_state = CFFPS_LED_BLINK;
 	}
 
+	dev_dbg(&psu->client->dev, "LED brightness set: %d. Command: %d.\n",
+		brightness, next_led_state);
+
 	pmbus_set_page(psu->client, 0);
 
 	rc = i2c_smbus_write_byte_data(psu->client, CFFPS_SYS_CONFIG_CMD,
-				       psu->led_state);
+				       next_led_state);
 	if (rc < 0)
 		return rc;
 
+	psu->led_state = next_led_state;
 	led_cdev->brightness = brightness;
 
 	return 0;
@@ -330,10 +342,7 @@ static int ibm_cffps_led_blink_set(struct led_classdev *led_cdev,
 	int rc;
 	struct ibm_cffps *psu = container_of(led_cdev, struct ibm_cffps, led);
 
-	psu->led_state = CFFPS_LED_BLINK;
-
-	if (led_cdev->brightness == LED_OFF)
-		return 0;
+	dev_dbg(&psu->client->dev, "LED blink set.\n");
 
 	pmbus_set_page(psu->client, 0);
 
@@ -342,6 +351,8 @@ static int ibm_cffps_led_blink_set(struct led_classdev *led_cdev,
 	if (rc < 0)
 		return rc;
 
+	psu->led_state = CFFPS_LED_BLINK;
+	led_cdev->brightness = LED_FULL;
 	*delay_on = CFFPS_BLINK_RATE_MS;
 	*delay_off = CFFPS_BLINK_RATE_MS;
 
-- 
2.23.0

