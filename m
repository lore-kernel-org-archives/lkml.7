Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290F4C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08609206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfKKU3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 15:29:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44348 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726877AbfKKU3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:29:08 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xABKQcU1103004;
        Mon, 11 Nov 2019 15:29:04 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w7c1tdqqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 15:29:04 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xABKRhRf006405;
        Mon, 11 Nov 2019 20:29:03 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03dal.us.ibm.com with ESMTP id 2w5n366mu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 20:29:03 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xABKT2NN50856302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Nov 2019 20:29:03 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4C6D6E04E;
        Mon, 11 Nov 2019 20:29:02 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D6206E052;
        Mon, 11 Nov 2019 20:29:02 +0000 (GMT)
Received: from oc6220003374.ibm.com (unknown [9.40.45.99])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Mon, 11 Nov 2019 20:29:02 +0000 (GMT)
From:   Kyle Mahlkuch <kmahlkuc@linux.vnet.ibm.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>
Subject: [PATCH] drm/radeon: Clean up code in radeon_pci_shutdown()
Date:   Mon, 11 Nov 2019 14:27:58 -0600
Message-Id: <1573504078-7691-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-11_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=750 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911110178
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>

This fixes the formatting on one comment and consolidates the
pci_get_drvdata() into the radeon_suspend_kms().

Signed-off-by: Kyle Mahlkuch <kmahlkuc@linux.vnet.ibm.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 4528f4d..357d29a 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -379,10 +379,6 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 static void
 radeon_pci_shutdown(struct pci_dev *pdev)
 {
-#ifdef CONFIG_PPC64
-	struct drm_device *ddev = pci_get_drvdata(pdev);
-#endif
-
 	/* if we are running in a VM, make sure the device
 	 * torn down properly on reboot/shutdown
 	 */
@@ -390,13 +386,14 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 		radeon_pci_remove(pdev);
 
 #ifdef CONFIG_PPC64
-	/* Some adapters need to be suspended before a
+	/*
+	 * Some adapters need to be suspended before a
 	 * shutdown occurs in order to prevent an error
 	 * during kexec.
 	 * Make this power specific becauase it breaks
 	 * some non-power boards.
 	 */
-	radeon_suspend_kms(ddev, true, true, false);
+	radeon_suspend_kms(pci_get_drvdata(pdev), true, true, false);
 #endif
 }
 
-- 
1.8.3.1

