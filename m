Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D581EC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD11520693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388299AbfGPSL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:11:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728137AbfGPSL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:11:28 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6GIBRn5073740
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 14:11:27 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tshy54m60-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 14:11:27 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kmahlkuc@linux.vnet.ibm.com>;
        Tue, 16 Jul 2019 19:11:20 +0100
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 16 Jul 2019 19:11:17 +0100
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6GIBGmA52494678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:11:16 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 337666E054;
        Tue, 16 Jul 2019 18:11:16 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBF1F6E064;
        Tue, 16 Jul 2019 18:11:15 +0000 (GMT)
Received: from oc6220003374.ibm.com (unknown [9.40.45.99])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 16 Jul 2019 18:11:15 +0000 (GMT)
From:   KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>
Subject: [PATCH] drm/radeon: Fix EEH during kexec
Date:   Tue, 16 Jul 2019 13:10:02 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19071618-8235-0000-0000-00000EB70A7E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011440; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01233098; UDB=6.00649713; IPR=6.01014409;
 MB=3.00027747; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-16 18:11:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071618-8236-0000-0000-0000466A69BE
Message-Id: <1563300606-28434-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-16_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=730 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907160223
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During kexec some adapters hit an EEH since they are not properly
shut down in the radeon_pci_shutdown() function. Adding
radeon_suspend_kms() fixes this issue.

Since radeon.h is now included in radeon_drv.c radeon_init() needs
a new name. I chose radeon_initl(). This can be changed if there is
another suggestion for a name.

Signed-off-by: Kyle Mahlkuch <Kyle.Mahlkuch at ibm.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 2e96c88..550f9b0 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -32,6 +32,7 @@
 #include <drm/drmP.h>
 #include <drm/radeon_drm.h>
 #include "radeon_drv.h"
+#include "radeon.h"
 
 #include <drm/drm_pciids.h>
 #include <linux/console.h>
@@ -344,11 +345,21 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 static void
 radeon_pci_shutdown(struct pci_dev *pdev)
 {
+	struct drm_device *ddev = pci_get_drvdata(pdev);
+	struct radeon_device *rdev = ddev->dev_private;
+
 	/* if we are running in a VM, make sure the device
 	 * torn down properly on reboot/shutdown
 	 */
 	if (radeon_device_is_virtual())
 		radeon_pci_remove(pdev);
+
+	/* Some adapters need to be suspended before a
+	* shutdown occurs in order to prevent an error
+	* during kexec.
+	*/
+	if (rdev->family == CHIP_CAICOS)
+		radeon_suspend_kms(ddev, true, true, false);
 }
 
 static int radeon_pmops_suspend(struct device *dev)
@@ -589,7 +600,7 @@ static long radeon_kms_compat_ioctl(struct file *filp, unsigned int cmd, unsigne
 	.driver.pm = &radeon_pm_ops,
 };
 
-static int __init radeon_init(void)
+static int __init radeon_initl(void)
 {
 	if (vgacon_text_force() && radeon_modeset == -1) {
 		DRM_INFO("VGACON disable radeon kernel modesetting.\n");
@@ -621,7 +632,7 @@ static void __exit radeon_exit(void)
 	radeon_unregister_atpx_handler();
 }
 
-module_init(radeon_init);
+module_init(radeon_initl);
 module_exit(radeon_exit);
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
-- 
1.8.3.1

