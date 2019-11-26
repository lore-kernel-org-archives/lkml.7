Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE66C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130EC2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfKZNSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:18:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727258AbfKZNSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:18:41 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAQDHpFh185284;
        Tue, 26 Nov 2019 08:18:37 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wfjyy74t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Nov 2019 08:18:36 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xAQDI3Wa186946;
        Tue, 26 Nov 2019 08:18:36 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wfjyy74sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Nov 2019 08:18:36 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAQDITlI029600;
        Tue, 26 Nov 2019 13:18:35 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02wdc.us.ibm.com with ESMTP id 2wevd6k7mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Nov 2019 13:18:35 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAQDIZcv37355834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 13:18:35 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E282B2805A;
        Tue, 26 Nov 2019 13:18:34 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4D812805E;
        Tue, 26 Nov 2019 13:18:34 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Nov 2019 13:18:34 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH 2/2] tpm: Revert "tpm_tis_core: Turn on the TPM before probing IRQ's"
Date:   Tue, 26 Nov 2019 08:17:53 -0500
Message-Id: <20191126131753.3424363-3-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191126131753.3424363-1-stefanb@linux.vnet.ibm.com>
References: <20191126131753.3424363-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-26_03:2019-11-26,2019-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 mlxlogscore=968 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911260119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Revert the patch that was turning the TPM on before probing for IRQs.

Fixes: 5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing IRQ's")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/char/tpm/tpm_tis_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 5dc52c4e2292..27c6ca031e23 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1059,7 +1059,6 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 			goto out_err;
 		}
 
-		tpm_chip_start(chip);
 		if (irq) {
 			tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
 						 irq);
@@ -1069,7 +1068,6 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		} else {
 			tpm_tis_probe_irq(chip, intmask);
 		}
-		tpm_chip_stop(chip);
 	}
 
 	rc = tpm_chip_register(chip);
-- 
2.14.5

