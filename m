Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59612C5DF65
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BDC2173E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbfKFUDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 15:03:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726934AbfKFUC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 15:02:59 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA6JxxFm083667;
        Wed, 6 Nov 2019 15:01:15 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w41wfppmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 15:01:15 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA6K0eWb008217;
        Wed, 6 Nov 2019 20:01:14 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04wdc.us.ibm.com with ESMTP id 2w41uj9e7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 20:01:14 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA6K1DKw46268706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Nov 2019 20:01:13 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D61428065;
        Wed,  6 Nov 2019 20:01:13 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA07528066;
        Wed,  6 Nov 2019 20:01:12 +0000 (GMT)
Received: from wisp4.ibm.com (unknown [9.163.22.179])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  6 Nov 2019 20:01:12 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        jdelvare@suse.com, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 1/2] hwmon: (pmbus/ibm-cffps) Switch LEDs to blocking brightness call
Date:   Wed,  6 Nov 2019 14:01:05 -0600
Message-Id: <20191106200106.29519-2-eajames@linux.ibm.com>
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
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911060196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since i2c_smbus functions can sleep, the brightness setting function
for this driver must be the blocking version to avoid scheduling while
atomic.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/pmbus/ibm-cffps.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
index d61547ed0da0..c6a00e83aac6 100644
--- a/drivers/hwmon/pmbus/ibm-cffps.c
+++ b/drivers/hwmon/pmbus/ibm-cffps.c
@@ -297,8 +297,8 @@ static int ibm_cffps_read_word_data(struct i2c_client *client, int page,
 	return rc;
 }
 
-static void ibm_cffps_led_brightness_set(struct led_classdev *led_cdev,
-					 enum led_brightness brightness)
+static int ibm_cffps_led_brightness_set(struct led_classdev *led_cdev,
+					enum led_brightness brightness)
 {
 	int rc;
 	struct ibm_cffps *psu = container_of(led_cdev, struct ibm_cffps, led);
@@ -316,9 +316,11 @@ static void ibm_cffps_led_brightness_set(struct led_classdev *led_cdev,
 	rc = i2c_smbus_write_byte_data(psu->client, CFFPS_SYS_CONFIG_CMD,
 				       psu->led_state);
 	if (rc < 0)
-		return;
+		return rc;
 
 	led_cdev->brightness = brightness;
+
+	return 0;
 }
 
 static int ibm_cffps_led_blink_set(struct led_classdev *led_cdev,
@@ -356,7 +358,7 @@ static void ibm_cffps_create_led_class(struct ibm_cffps *psu)
 		 client->addr);
 	psu->led.name = psu->led_name;
 	psu->led.max_brightness = LED_FULL;
-	psu->led.brightness_set = ibm_cffps_led_brightness_set;
+	psu->led.brightness_set_blocking = ibm_cffps_led_brightness_set;
 	psu->led.blink_set = ibm_cffps_led_blink_set;
 
 	rc = devm_led_classdev_register(dev, &psu->led);
-- 
2.23.0

