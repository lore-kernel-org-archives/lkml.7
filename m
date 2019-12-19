Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5388EC2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2732465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfLSUu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:50:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37140 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727422AbfLSUuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:50:55 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJKleqQ026074;
        Thu, 19 Dec 2019 15:50:29 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x0g299500-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 15:50:29 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBJKliKj026433;
        Thu, 19 Dec 2019 15:50:28 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x0g2994yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 15:50:28 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBJKo1DO016922;
        Thu, 19 Dec 2019 20:50:27 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03wdc.us.ibm.com with ESMTP id 2wvqc71km5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 20:50:27 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBJKoQW560424642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 20:50:26 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A62A0C605A;
        Thu, 19 Dec 2019 20:50:26 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C102C6059;
        Thu, 19 Dec 2019 20:50:26 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.103.158])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 19 Dec 2019 20:50:26 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        jdelvare@suse.com, bjwyman@gmail.com,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 3/3] hwmon: (pmbus/ibm-cffps) Fix the LED behavior when turned off
Date:   Thu, 19 Dec 2019 14:50:07 -0600
Message-Id: <1576788607-13567-4-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576788607-13567-1-git-send-email-eajames@linux.ibm.com>
References: <1576788607-13567-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_06:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 mlxscore=0
 mlxlogscore=904 suspectscore=1 lowpriorityscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver should remain in control of the LED on the PSU, even while
off, not the PSU firmware as previously indicated.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/pmbus/ibm-cffps.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
index b37faf1..1c91ee1 100644
--- a/drivers/hwmon/pmbus/ibm-cffps.c
+++ b/drivers/hwmon/pmbus/ibm-cffps.c
@@ -47,13 +47,9 @@
 #define CFFPS_MFR_VAUX_FAULT			BIT(6)
 #define CFFPS_MFR_CURRENT_SHARE_WARNING		BIT(7)
 
-/*
- * LED off state actually relinquishes LED control to PSU firmware, so it can
- * turn on the LED for faults.
- */
-#define CFFPS_LED_OFF				0
 #define CFFPS_LED_BLINK				BIT(0)
 #define CFFPS_LED_ON				BIT(1)
+#define CFFPS_LED_OFF				BIT(2)
 #define CFFPS_BLINK_RATE_MS			250
 
 enum {
@@ -436,6 +432,9 @@ static void ibm_cffps_create_led_class(struct ibm_cffps *psu)
 	rc = devm_led_classdev_register(dev, &psu->led);
 	if (rc)
 		dev_warn(dev, "failed to register led class: %d\n", rc);
+	else
+		i2c_smbus_write_byte_data(client, CFFPS_SYS_CONFIG_CMD,
+					  CFFPS_LED_OFF);
 }
 
 static struct pmbus_driver_info ibm_cffps_info[] = {
-- 
1.8.3.1

