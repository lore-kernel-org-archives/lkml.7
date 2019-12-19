Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2BBC2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3AB2465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfLSUur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:50:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726880AbfLSUur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:50:47 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJKldHD010425;
        Thu, 19 Dec 2019 15:50:25 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x08cg7uh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 15:50:25 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBJKmRa2012728;
        Thu, 19 Dec 2019 15:50:25 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x08cg7ugk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 15:50:25 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBJKo1uY006301;
        Thu, 19 Dec 2019 20:50:24 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04wdc.us.ibm.com with ESMTP id 2wvqc71e5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 20:50:24 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBJKoNfN17105176
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 20:50:23 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8CEEC605A;
        Thu, 19 Dec 2019 20:50:23 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 290D7C6057;
        Thu, 19 Dec 2019 20:50:23 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.103.158])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 19 Dec 2019 20:50:22 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        jdelvare@suse.com, bjwyman@gmail.com,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 2/3] hwmon: (pmbus/ibm-cffps) Add the VMON property for version 2
Date:   Thu, 19 Dec 2019 14:50:06 -0600
Message-Id: <1576788607-13567-3-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576788607-13567-1-git-send-email-eajames@linux.ibm.com>
References: <1576788607-13567-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_06:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 bulkscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2 of the PSU supports reading an auxiliary voltage. Use the
pmbus VMON property and associated virtual register to read it.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/pmbus/ibm-cffps.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
index a564be9..b37faf1 100644
--- a/drivers/hwmon/pmbus/ibm-cffps.c
+++ b/drivers/hwmon/pmbus/ibm-cffps.c
@@ -28,6 +28,7 @@
 #define CFFPS1_FW_NUM_BYTES			4
 #define CFFPS2_FW_NUM_WORDS			3
 #define CFFPS_SYS_CONFIG_CMD			0xDA
+#define CFFPS_12VCS_VOUT_CMD			0xDE
 
 #define CFFPS_INPUT_HISTORY_CMD			0xD6
 #define CFFPS_INPUT_HISTORY_SIZE		100
@@ -350,6 +351,9 @@ static int ibm_cffps_read_word_data(struct i2c_client *client, int page,
 		if (mfr & CFFPS_MFR_PS_KILL)
 			rc |= PB_STATUS_OFF;
 		break;
+	case PMBUS_VIRT_READ_VMON:
+		rc = pmbus_read_word_data(client, page, CFFPS_12VCS_VOUT_CMD);
+		break;
 	default:
 		rc = -ENODATA;
 		break;
@@ -453,7 +457,7 @@ static void ibm_cffps_create_led_class(struct ibm_cffps *psu)
 			PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
 			PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
 			PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP |
-			PMBUS_HAVE_STATUS_FAN12,
+			PMBUS_HAVE_STATUS_FAN12 | PMBUS_HAVE_VMON,
 		.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
 			PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
 			PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT,
-- 
1.8.3.1

