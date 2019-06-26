Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36B5C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EFF208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfFZTOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:14:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726223AbfFZTOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 15:14:20 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5QJ7Uep100280;
        Wed, 26 Jun 2019 15:13:35 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tcdn92nan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jun 2019 15:13:35 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5QJ7Wi9100406;
        Wed, 26 Jun 2019 15:13:35 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tcdn92na3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jun 2019 15:13:34 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5QJ9RIb026146;
        Wed, 26 Jun 2019 19:13:34 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01dal.us.ibm.com with ESMTP id 2t9by7980a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jun 2019 19:13:34 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5QJDW0I43188514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 19:13:32 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5CF56A057;
        Wed, 26 Jun 2019 19:13:32 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D4086A047;
        Wed, 26 Jun 2019 19:13:32 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jun 2019 19:13:32 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        mine260309@gmail.com, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] OCC: FSI and hwmon: Add sequence numbering
Date:   Wed, 26 Jun 2019 14:13:15 -0500
Message-Id: <1561576395-6429-1-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-26_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906260222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sequence numbering of the commands submitted to the OCC is required by
the OCC interface specification. Add sequence numbering and check for
the correct sequence number on the response.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-occ.c      | 15 ++++++++++++---
 drivers/hwmon/occ/common.c |  4 ++--
 drivers/hwmon/occ/common.h |  1 +
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index a2301ce..7da9c81 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -412,6 +412,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 		msecs_to_jiffies(OCC_CMD_IN_PRG_WAIT_MS);
 	struct occ *occ = dev_get_drvdata(dev);
 	struct occ_response *resp = response;
+	u8 seq_no;
 	u16 resp_data_length;
 	unsigned long start;
 	int rc;
@@ -426,6 +427,8 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 
 	mutex_lock(&occ->occ_lock);
 
+	/* Extract the seq_no from the command (first byte) */
+	seq_no = *(const u8 *)request;
 	rc = occ_putsram(occ, OCC_SRAM_CMD_ADDR, request, req_len);
 	if (rc)
 		goto done;
@@ -441,11 +444,17 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 		if (rc)
 			goto done;
 
-		if (resp->return_status == OCC_RESP_CMD_IN_PRG) {
+		if (resp->return_status == OCC_RESP_CMD_IN_PRG ||
+		    resp->seq_no != seq_no) {
 			rc = -ETIMEDOUT;
 
-			if (time_after(jiffies, start + timeout))
-				break;
+			if (time_after(jiffies, start + timeout)) {
+				dev_err(occ->dev, "resp timeout status=%02x "
+					"resp seq_no=%d our seq_no=%d\n",
+					resp->return_status, resp->seq_no,
+					seq_no);
+				goto done;
+			}
 
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout(wait_time);
diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index d593517..a7d2b16 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -124,12 +124,12 @@ struct extended_sensor {
 static int occ_poll(struct occ *occ)
 {
 	int rc;
-	u16 checksum = occ->poll_cmd_data + 1;
+	u16 checksum = occ->poll_cmd_data + occ->seq_no + 1;
 	u8 cmd[8];
 	struct occ_poll_response_header *header;
 
 	/* big endian */
-	cmd[0] = 0;			/* sequence number */
+	cmd[0] = occ->seq_no++;		/* sequence number */
 	cmd[1] = 0;			/* cmd type */
 	cmd[2] = 0;			/* data length msb */
 	cmd[3] = 1;			/* data length lsb */
diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
index fc13f3c..67e6968 100644
--- a/drivers/hwmon/occ/common.h
+++ b/drivers/hwmon/occ/common.h
@@ -95,6 +95,7 @@ struct occ {
 	struct occ_sensors sensors;
 
 	int powr_sample_time_us;	/* average power sample time */
+	u8 seq_no;
 	u8 poll_cmd_data;		/* to perform OCC poll command */
 	int (*send_cmd)(struct occ *occ, u8 *cmd);
 
-- 
1.8.3.1

