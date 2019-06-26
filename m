Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC66C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F9D216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfFZS5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 14:57:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726227AbfFZS5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:57:10 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5QIv0ox069700;
        Wed, 26 Jun 2019 14:57:02 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tcdn91yp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jun 2019 14:57:02 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5QIt86o015240;
        Wed, 26 Jun 2019 18:57:01 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01wdc.us.ibm.com with ESMTP id 2t9by7152j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jun 2019 18:57:01 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5QIv0hI57475498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 18:57:00 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7284FC6057;
        Wed, 26 Jun 2019 18:57:00 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0623EC6055;
        Wed, 26 Jun 2019 18:56:59 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jun 2019 18:56:59 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, joel@jms.id.au, andrew@aj.id.au,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] fsi: sbefifo: Don't fail operations when in SBE IPL state
Date:   Wed, 26 Jun 2019 13:56:55 -0500
Message-Id: <1561575415-3282-1-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-26_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906260219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SBE fifo operations should be allowed while the SBE is in any of the
"IPL" states. Operations should succeed in this state.

Fixes: 9f4a8a2d7f9d fsi/sbefifo: Add driver for the SBE FIFO
Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Alistair Popple <alistair@popple.id.au>
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-sbefifo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index d92f5b8..f54df9e 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -289,11 +289,11 @@ static int sbefifo_check_sbe_state(struct sbefifo *sbefifo)
 	switch ((sbm & CFAM_SBM_SBE_STATE_MASK) >> CFAM_SBM_SBE_STATE_SHIFT) {
 	case SBE_STATE_UNKNOWN:
 		return -ESHUTDOWN;
+	case SBE_STATE_DMT:
+		return -EBUSY;
 	case SBE_STATE_IPLING:
 	case SBE_STATE_ISTEP:
 	case SBE_STATE_MPIPL:
-	case SBE_STATE_DMT:
-		return -EBUSY;
 	case SBE_STATE_RUNTIME:
 	case SBE_STATE_DUMP: /* Not sure about that one */
 		break;
-- 
1.8.3.1

