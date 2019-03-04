Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E31C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713DD20835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfCDTla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:41:30 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:38145 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfCDTl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:41:29 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N3bb1-1hA01h3Zcx-010fdQ; Mon, 04 Mar 2019 20:40:58 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Wei Li <liwei213@huawei.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] scsi: ufs: hisi: fix ufs_hba_variant_ops passing
Date:   Mon,  4 Mar 2019 20:39:11 +0100
Message-Id: <20190304193917.702601-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190304193917.702601-1-arnd@arndb.de>
References: <20190304193917.702601-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iDV3wbl1jv0zwUySViRu9AW+5mW6LMS14QEtSMcadmyPsv4Df8/
 u07BlmQ9TjYCgDNrvZ1eE6oJFOMi06PTI64CYLTPIgMKYPd1ySpKzxyWdWdYArHiyLEZZtQ
 1bBf3jsi6ueg6KTf2kTN8Be9CvEoOIxaXjJySentrCKRtHWNmujZ1jl5BAq4g/chPNw7VpV
 jB64phSxE4cSXcCZPRx+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FnSvrfJJWHo=:BzQ859kEH/Jrbpck8dqDH/
 cwBRmsFEt9xhn5mb5/y/2OcDaQy5U4ncLDc08VTmY4e48K0aSqgXszcyocZ4pYY0gCyiqD2m9
 yXcPgX6kbJmZL2Bdy2Rl+0XmTJk2hGLZ9DWWq6Ovtu6FhiLOj7lQrlD+nqFbDLd8TdGkUTBVx
 kHTqJmDZ0FF9y3qbFw56fnxkHzS7R9f6+rfNUG5S05Dtnn8FOBiInPyN6PPyNpvSwEYwit7y7
 DBdLocgCXf4O5TGGtPnm+gRA94NFy4WsFcViBv3/CIKh6vsXspX660YJ6nVMTXCvYKFUkMI8p
 1ZOmnMF2pnQLG0va/UN9RzYQBwZ5o497Z1EASU8wN1bGuO2bnZt7Jf/J5QKszrI5m9JHyCsq+
 hVWtT8SrW89RiK01HLfQWHIrzRX7FVi/72RBsOGFXM0Hc8O0/cguWFDIOBVphXqAnalSMypfa
 6tNQ8IyJkcgpubQejhCnJb73ySUAZ8TL/JqPpA8AhX/zkbI26iVMKamwLT+GAysYnXSeG1wFZ
 UZctqgKguW5c/tdx5FczJEQ8U16oS+S8Dd8VUbLqsnwXLRG7OWllxrIO7AwwEU0OJx5mAzl6C
 1ykmzvc6LPb3CS5jv1+m3lj/OFwYyAnyA7Ph/AtgiLydFSDkCx8kO9HTaN166U11Tcy5cktfQ
 L7kjxCvDzjMOtxTQ06aXC0YfMFtMj6L+pPbtUWd8OzDcGMjSuE42YDu89KRXvhv5FffE3T4/w
 3LiJzzylegOglkz5SmmGOhyacvoJrAbTZdcd/g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_OF, the of_match_node() helper does not evaluate
its argument, and the compiler warns about the unused variable:

drivers/scsi/ufs/ufs-hisi.c: In function 'ufs_hisi_probe':
drivers/scsi/ufs/ufs-hisi.c:673:17: error: unused variable 'dev' [-Werror=unused-variable]

Rework this code to pass the data directly, and while we're
at it, correctly handle the const pointers.

Fixes: 653fcb07d95e ("scsi: ufs: Add HI3670 SoC UFS driver support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/ufs/ufs-hisi.c      | 11 ++++-------
 drivers/scsi/ufs/ufshcd-pltfrm.c |  2 +-
 drivers/scsi/ufs/ufshcd-pltfrm.h |  2 +-
 drivers/scsi/ufs/ufshcd.h        |  2 +-
 4 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-hisi.c b/drivers/scsi/ufs/ufs-hisi.c
index f2d3df357a97..0e855b5afe82 100644
--- a/drivers/scsi/ufs/ufs-hisi.c
+++ b/drivers/scsi/ufs/ufs-hisi.c
@@ -640,7 +640,7 @@ static int ufs_hi3670_init(struct ufs_hba *hba)
 	return 0;
 }
 
-static struct ufs_hba_variant_ops ufs_hba_hi3660_vops = {
+static const struct ufs_hba_variant_ops ufs_hba_hi3660_vops = {
 	.name = "hi3660",
 	.init = ufs_hi3660_init,
 	.link_startup_notify = ufs_hisi_link_startup_notify,
@@ -649,7 +649,7 @@ static struct ufs_hba_variant_ops ufs_hba_hi3660_vops = {
 	.resume = ufs_hisi_resume,
 };
 
-static struct ufs_hba_variant_ops ufs_hba_hi3670_vops = {
+static const struct ufs_hba_variant_ops ufs_hba_hi3670_vops = {
 	.name = "hi3670",
 	.init = ufs_hi3670_init,
 	.link_startup_notify = ufs_hisi_link_startup_notify,
@@ -669,13 +669,10 @@ MODULE_DEVICE_TABLE(of, ufs_hisi_of_match);
 static int ufs_hisi_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id;
-	struct ufs_hba_variant_ops *vops;
-	struct device *dev = &pdev->dev;
 
-	of_id = of_match_node(ufs_hisi_of_match, dev->of_node);
-	vops = (struct ufs_hba_variant_ops *)of_id->data;
+	of_id = of_match_node(ufs_hisi_of_match, pdev->dev.of_node);
 
-	return ufshcd_pltfrm_init(pdev, vops);
+	return ufshcd_pltfrm_init(pdev, of_id->data);
 }
 
 static int ufs_hisi_remove(struct platform_device *pdev)
diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
index 895a9b5ac989..27213676329c 100644
--- a/drivers/scsi/ufs/ufshcd-pltfrm.c
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
@@ -297,7 +297,7 @@ static void ufshcd_init_lanes_per_dir(struct ufs_hba *hba)
  * Returns 0 on success, non-zero value on failure
  */
 int ufshcd_pltfrm_init(struct platform_device *pdev,
-		       struct ufs_hba_variant_ops *vops)
+		       const struct ufs_hba_variant_ops *vops)
 {
 	struct ufs_hba *hba;
 	void __iomem *mmio_base;
diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.h b/drivers/scsi/ufs/ufshcd-pltfrm.h
index df64c4180340..1f29e1fd6d52 100644
--- a/drivers/scsi/ufs/ufshcd-pltfrm.h
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.h
@@ -17,7 +17,7 @@
 #include "ufshcd.h"
 
 int ufshcd_pltfrm_init(struct platform_device *pdev,
-		       struct ufs_hba_variant_ops *vops);
+		       const struct ufs_hba_variant_ops *vops);
 void ufshcd_pltfrm_shutdown(struct platform_device *pdev);
 
 #ifdef CONFIG_PM
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 69ba7445d2b3..ecfa898b9ccc 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -546,7 +546,7 @@ struct ufs_hba {
 	int nutrs;
 	int nutmrs;
 	u32 ufs_version;
-	struct ufs_hba_variant_ops *vops;
+	const struct ufs_hba_variant_ops *vops;
 	void *priv;
 	unsigned int irq;
 	bool is_irq_enabled;
-- 
2.20.0

