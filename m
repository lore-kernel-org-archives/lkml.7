Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BFDC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E8F2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbfDPPoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:44:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726178AbfDPPoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:44:06 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3GFe0tA046481
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 11:44:05 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rwh6ftd54-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 11:44:05 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Tue, 16 Apr 2019 16:44:04 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 16 Apr 2019 16:44:01 +0100
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3GFhxZG8257564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Apr 2019 15:44:00 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA94E6E052;
        Tue, 16 Apr 2019 15:43:59 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 513CB6E050;
        Tue, 16 Apr 2019 15:43:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.3.116.186])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 16 Apr 2019 15:43:59 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        andrew@aj.id.au, mine260309@gmail.com,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 1/3] hwmon (occ): Store error condition for rate-limited polls
Date:   Tue, 16 Apr 2019 15:43:48 +0000
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19041615-0012-0000-0000-00001727A19E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010938; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01189952; UDB=6.00623516; IPR=6.00970746;
 MB=3.00026468; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-16 15:44:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041615-0013-0000-0000-000056E49907
Message-Id: <1555429430-23118-1-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OCC driver limits the rate of sending poll commands to the OCC. If a
user reads a hwmon entry after a poll response resulted in an error and
is rate-limited, the error is invisible to the user. Fix this by storing
the last error and returning that in the rate-limited case.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/occ/common.c | 4 ++++
 drivers/hwmon/occ/common.h | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index 9d197e9..13a6290 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -141,6 +141,7 @@ static int occ_poll(struct occ *occ)
 	/* mutex should already be locked if necessary */
 	rc = occ->send_cmd(occ, cmd);
 	if (rc) {
+		occ->last_error = rc;
 		if (occ->error_count++ > OCC_ERROR_COUNT_THRESHOLD)
 			occ->error = rc;
 
@@ -149,6 +150,7 @@ static int occ_poll(struct occ *occ)
 
 	/* clear error since communication was successful */
 	occ->error_count = 0;
+	occ->last_error = 0;
 	occ->error = 0;
 
 	/* check for safe state */
@@ -210,6 +212,8 @@ int occ_update_response(struct occ *occ)
 	if (time_after(jiffies, occ->last_update + OCC_UPDATE_FREQUENCY)) {
 		rc = occ_poll(occ);
 		occ->last_update = jiffies;
+	} else {
+		rc = occ->last_error;
 	}
 
 	mutex_unlock(&occ->lock);
diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
index ed2cf42..fc13f3c 100644
--- a/drivers/hwmon/occ/common.h
+++ b/drivers/hwmon/occ/common.h
@@ -106,7 +106,8 @@ struct occ {
 	struct attribute_group group;
 	const struct attribute_group *groups[2];
 
-	int error;                      /* latest transfer error */
+	int error;                      /* final transfer error after retry */
+	int last_error;			/* latest transfer error */
 	unsigned int error_count;       /* number of xfr errors observed */
 	unsigned long last_safe;        /* time OCC entered "safe" state */
 
-- 
2.7.4

