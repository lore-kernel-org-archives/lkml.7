Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBDEC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDCC217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560278608;
	bh=ALc9iJVl2I0Qd5dVyJCageB5fpG8xu6C+JD8aEvC9CM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=fUILWeUY1Lo4Mf+5H5rWD5P2yUeTvURL3o8HLHMEYxjLI03/WFRGsvm5Au/JQuJxm
	 IGj6CzubmB9PMlBWvsocPHN8AWZRrZddQ7tcMn1WU3HWNenzFqZeyTy3/wtFhd+es/
	 MoJfKMat6DNJlxV+5nrjAoA3fqeGWPxA/nDcyMWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391987AbfFKSn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:43:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391882AbfFKSn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:43:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3345217D9;
        Tue, 11 Jun 2019 18:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560278606;
        bh=ALc9iJVl2I0Qd5dVyJCageB5fpG8xu6C+JD8aEvC9CM=;
        h=Date:From:To:Cc:Subject:From;
        b=meaCeKIE7dGESsWsuGPC5SdUd2tV2fJtVw/LPfBrzjPHD3vkgvPGq8Q2SGNANgkP5
         ZqEWUduqWIqfnM7Q8EQQ1LOaS7JRci/ihWQEoB2Eub48Z97rfPx1Ou1zQ7IjtVho/O
         9G8M2yghiSOryDOuj3Z3bBd3POscss18joIN7aGI=
Date:   Tue, 11 Jun 2019 20:43:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] mic: no need to check return value of debugfs_create
 functions
Message-ID: <20190611184323.GA2329@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Sudeep Dutt <sudeep.dutt@intel.com>
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mic/card/mic_debugfs.c  | 18 ++----------------
 drivers/misc/mic/cosm/cosm_debugfs.c |  4 ----
 drivers/misc/mic/host/mic_debugfs.c  |  4 ----
 drivers/misc/mic/scif/scif_debugfs.c |  5 -----
 drivers/misc/mic/vop/vop_debugfs.c   |  4 ----
 5 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/drivers/misc/mic/card/mic_debugfs.c b/drivers/misc/mic/card/mic_debugfs.c
index 7a4140874888..fa2b5fefb791 100644
--- a/drivers/misc/mic/card/mic_debugfs.c
+++ b/drivers/misc/mic/card/mic_debugfs.c
@@ -63,25 +63,13 @@ DEFINE_SHOW_ATTRIBUTE(mic_intr);
  */
 void __init mic_create_card_debug_dir(struct mic_driver *mdrv)
 {
-	struct dentry *d;
-
 	if (!mic_dbg)
 		return;
 
 	mdrv->dbg_dir = debugfs_create_dir(mdrv->name, mic_dbg);
-	if (!mdrv->dbg_dir) {
-		dev_err(mdrv->dev, "Cant create dbg_dir %s\n", mdrv->name);
-		return;
-	}
-
-	d = debugfs_create_file("intr_test", 0444, mdrv->dbg_dir,
-		mdrv, &mic_intr_fops);
 
-	if (!d) {
-		dev_err(mdrv->dev,
-			"Cant create dbg intr_test %s\n", mdrv->name);
-		return;
-	}
+	debugfs_create_file("intr_test", 0444, mdrv->dbg_dir, mdrv,
+			    &mic_intr_fops);
 }
 
 /**
@@ -101,8 +89,6 @@ void mic_delete_card_debug_dir(struct mic_driver *mdrv)
 void __init mic_init_card_debugfs(void)
 {
 	mic_dbg = debugfs_create_dir(KBUILD_MODNAME, NULL);
-	if (!mic_dbg)
-		pr_err("can't create debugfs dir\n");
 }
 
 /**
diff --git a/drivers/misc/mic/cosm/cosm_debugfs.c b/drivers/misc/mic/cosm/cosm_debugfs.c
index 71c216d0504d..340ea7171411 100644
--- a/drivers/misc/mic/cosm/cosm_debugfs.c
+++ b/drivers/misc/mic/cosm/cosm_debugfs.c
@@ -105,8 +105,6 @@ void cosm_create_debug_dir(struct cosm_device *cdev)
 
 	scnprintf(name, sizeof(name), "mic%d", cdev->index);
 	cdev->dbg_dir = debugfs_create_dir(name, cosm_dbg);
-	if (!cdev->dbg_dir)
-		return;
 
 	debugfs_create_file("log_buf", 0444, cdev->dbg_dir, cdev,
 			    &log_buf_fops);
@@ -125,8 +123,6 @@ void cosm_delete_debug_dir(struct cosm_device *cdev)
 void cosm_init_debugfs(void)
 {
 	cosm_dbg = debugfs_create_dir(KBUILD_MODNAME, NULL);
-	if (!cosm_dbg)
-		pr_err("can't create debugfs dir\n");
 }
 
 void cosm_exit_debugfs(void)
diff --git a/drivers/misc/mic/host/mic_debugfs.c b/drivers/misc/mic/host/mic_debugfs.c
index c6e3c764699f..370f98c7b752 100644
--- a/drivers/misc/mic/host/mic_debugfs.c
+++ b/drivers/misc/mic/host/mic_debugfs.c
@@ -125,8 +125,6 @@ void mic_create_debug_dir(struct mic_device *mdev)
 
 	scnprintf(name, sizeof(name), "mic%d", mdev->id);
 	mdev->dbg_dir = debugfs_create_dir(name, mic_dbg);
-	if (!mdev->dbg_dir)
-		return;
 
 	debugfs_create_file("smpt", 0444, mdev->dbg_dir, mdev,
 			    &mic_smpt_fops);
@@ -155,8 +153,6 @@ void mic_delete_debug_dir(struct mic_device *mdev)
 void __init mic_init_debugfs(void)
 {
 	mic_dbg = debugfs_create_dir(KBUILD_MODNAME, NULL);
-	if (!mic_dbg)
-		pr_err("can't create debugfs dir\n");
 }
 
 /**
diff --git a/drivers/misc/mic/scif/scif_debugfs.c b/drivers/misc/mic/scif/scif_debugfs.c
index a6820480105a..8fe38e7ca6e6 100644
--- a/drivers/misc/mic/scif/scif_debugfs.c
+++ b/drivers/misc/mic/scif/scif_debugfs.c
@@ -103,11 +103,6 @@ DEFINE_SHOW_ATTRIBUTE(scif_rma);
 void __init scif_init_debugfs(void)
 {
 	scif_dbg = debugfs_create_dir(KBUILD_MODNAME, NULL);
-	if (!scif_dbg) {
-		dev_err(scif_info.mdev.this_device,
-			"can't create debugfs dir scif\n");
-		return;
-	}
 
 	debugfs_create_file("scif_dev", 0444, scif_dbg, NULL, &scif_dev_fops);
 	debugfs_create_file("scif_rma", 0444, scif_dbg, NULL, &scif_rma_fops);
diff --git a/drivers/misc/mic/vop/vop_debugfs.c b/drivers/misc/mic/vop/vop_debugfs.c
index 2ccef52aca23..d4551d522188 100644
--- a/drivers/misc/mic/vop/vop_debugfs.c
+++ b/drivers/misc/mic/vop/vop_debugfs.c
@@ -186,10 +186,6 @@ void vop_init_debugfs(struct vop_info *vi)
 
 	snprintf(name, sizeof(name), "%s%d", KBUILD_MODNAME, vi->vpdev->dnode);
 	vi->dbg = debugfs_create_dir(name, NULL);
-	if (!vi->dbg) {
-		pr_err("can't create debugfs dir vop\n");
-		return;
-	}
 	debugfs_create_file("dp", 0444, vi->dbg, vi, &vop_dp_fops);
 	debugfs_create_file("vdev_info", 0444, vi->dbg, vi, &vop_vdev_info_fops);
 }
-- 
2.22.0

