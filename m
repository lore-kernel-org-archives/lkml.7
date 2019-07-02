Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13A5C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786BF20663
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfGBPr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 11:47:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725972AbfGBPr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:47:57 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x62FkvgH003563
        for <linux-kernel@vger.kernel.org>; Tue, 2 Jul 2019 11:47:56 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tg8qscq4k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 11:47:56 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Tue, 2 Jul 2019 16:47:55 +0100
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Jul 2019 16:47:52 +0100
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x62FlpXC58982844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Jul 2019 15:47:51 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A108413604F;
        Tue,  2 Jul 2019 15:47:51 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49126136051;
        Tue,  2 Jul 2019 15:47:51 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  2 Jul 2019 15:47:51 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, joel@jms.id.au, linux@roeck-us.net,
        mine260309@gmail.com, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] OCC: FSI and hwmon: Add sequence numbering
Date:   Tue,  2 Jul 2019 10:47:42 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19070215-0016-0000-0000-000009C9B5A0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011366; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01226427; UDB=6.00645661; IPR=6.01007648;
 MB=3.00027555; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-02 15:47:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070215-0017-0000-0000-000043DE4FED
Message-Id: <1562082462-23794-1-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907020172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sequence numbering of the commands submitted to the OCC is required by
the OCC interface specification. Add sequence numbering and check for
the correct sequence number on the response.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Lei YU <mine260309@gmail.com>
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

