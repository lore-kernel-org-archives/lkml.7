Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241EBC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002242084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732299AbfHOTJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 15:09:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26698 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731777AbfHOTJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 15:09:06 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7FJ6sj7057171;
        Thu, 15 Aug 2019 15:08:59 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2udcjt1p67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Aug 2019 15:08:59 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7FJ36u8021866;
        Thu, 15 Aug 2019 19:08:58 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma05wdc.us.ibm.com with ESMTP id 2udbc482k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Aug 2019 19:08:58 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7FJ8vNg36634916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 19:08:57 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB9892805A;
        Thu, 15 Aug 2019 19:08:57 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 663E428059;
        Thu, 15 Aug 2019 19:08:57 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 15 Aug 2019 19:08:57 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] fsi: scom: Don't abort operations for minor errors
Date:   Thu, 15 Aug 2019 14:08:54 -0500
Message-Id: <1565896134-22749-1-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908150181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scom driver currently fails out of operations if certain system
errors are flagged in the status register; system checkstop, special
attention, or recoverable error. These errors won't impact the ability
of the scom engine to perform operations, so the driver should continue
under these conditions.
Also, don't do a PIB reset for these conditions, since it won't help.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-scom.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index 343153d..004dc03 100644
--- a/drivers/fsi/fsi-scom.c
+++ b/drivers/fsi/fsi-scom.c
@@ -38,8 +38,7 @@
 #define SCOM_STATUS_PIB_RESP_MASK	0x00007000
 #define SCOM_STATUS_PIB_RESP_SHIFT	12
 
-#define SCOM_STATUS_ANY_ERR		(SCOM_STATUS_ERR_SUMMARY | \
-					 SCOM_STATUS_PROTECTION | \
+#define SCOM_STATUS_ANY_ERR		(SCOM_STATUS_PROTECTION | \
 					 SCOM_STATUS_PARITY |	  \
 					 SCOM_STATUS_PIB_ABORT | \
 					 SCOM_STATUS_PIB_RESP_MASK)
@@ -251,11 +250,6 @@ static int handle_fsi2pib_status(struct scom_device *scom, uint32_t status)
 	/* Return -EBUSY on PIB abort to force a retry */
 	if (status & SCOM_STATUS_PIB_ABORT)
 		return -EBUSY;
-	if (status & SCOM_STATUS_ERR_SUMMARY) {
-		fsi_device_write(scom->fsi_dev, SCOM_FSI2PIB_RESET_REG, &dummy,
-				 sizeof(uint32_t));
-		return -EIO;
-	}
 	return 0;
 }
 
-- 
1.8.3.1

