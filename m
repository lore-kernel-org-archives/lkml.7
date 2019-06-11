Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C48C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1EB2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560278042;
	bh=KDKcLJyADmgSQDi9MRqoe6HpU9pNkGdMIUvChVmJQBU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=mItorT8cxv9tTftYutE2StKy/0LgSrtBV5DRn2zsOP/fDTdNP90wNr+6v4dPygLpl
	 HuHN3MlKKGmV9otqaXQ8TaDJmgT0Nr81vKKlg1ys5d19iRFQuJU/FsXWGKPYM8NaF7
	 bq2Au5OtcuVMPOmLMSkYjrgVlDx0kkGO6jgi0+8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391638AbfFKSeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390953AbfFKSeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:34:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5191220883;
        Tue, 11 Jun 2019 18:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560278039;
        bh=KDKcLJyADmgSQDi9MRqoe6HpU9pNkGdMIUvChVmJQBU=;
        h=Date:From:To:Cc:Subject:From;
        b=GaoKeQ0FEOs98VMrYcvWp57SIBODTPRfvR2reQ6Q85uRBTLQUlcf+UM8KjZnDuyEd
         TW8qB7nH4D6POI5+Jxu+4LhBz3Fo6Vb0beUTHUxdpz6J1su3VjXhJOy3vivoA9kH/g
         CvjcEVIGWFUgRDA2zQcuKjop//pjagI38Op/yoAA=
Date:   Tue, 11 Jun 2019 20:33:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] mei: no need to check return value of debugfs_create
 functions
Message-ID: <20190611183357.GA32008@kroah.com>
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

Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/genwqe/card_base.c      |   5 -
 drivers/misc/genwqe/card_base.h      |   2 +-
 drivers/misc/genwqe/card_debugfs.c   | 165 +++++----------------------
 drivers/misc/genwqe/card_dev.c       |   6 +-
 drivers/misc/mei/debugfs.c           |  47 ++------
 drivers/misc/mei/main.c              |   8 +-
 drivers/misc/mei/mei_dev.h           |   7 +-
 drivers/misc/mic/card/mic_debugfs.c  |  18 +--
 drivers/misc/mic/cosm/cosm_debugfs.c |   4 -
 drivers/misc/mic/host/mic_debugfs.c  |   4 -
 drivers/misc/mic/scif/scif_debugfs.c |   5 -
 drivers/misc/mic/vop/vop_debugfs.c   |   4 -
 drivers/misc/ti-st/st_kim.c          |   4 -
 drivers/misc/vmw_balloon.c           |  19 +--
 14 files changed, 51 insertions(+), 247 deletions(-)

diff --git a/drivers/misc/genwqe/card_base.c b/drivers/misc/genwqe/card_base.c
index d137d0fab9bf..f9f329651037 100644
--- a/drivers/misc/genwqe/card_base.c
+++ b/drivers/misc/genwqe/card_base.c
@@ -1377,10 +1377,6 @@ static int __init genwqe_init_module(void)
 	class_genwqe->devnode = genwqe_devnode;
 
 	debugfs_genwqe = debugfs_create_dir(GENWQE_DEVNAME, NULL);
-	if (!debugfs_genwqe) {
-		rc = -ENOMEM;
-		goto err_out;
-	}
 
 	rc = pci_register_driver(&genwqe_driver);
 	if (rc != 0) {
@@ -1392,7 +1388,6 @@ static int __init genwqe_init_module(void)
 
  err_out0:
 	debugfs_remove(debugfs_genwqe);
- err_out:
 	class_destroy(class_genwqe);
 	return rc;
 }
diff --git a/drivers/misc/genwqe/card_base.h b/drivers/misc/genwqe/card_base.h
index 77ed3967c5b0..d9e4a6e5fe3c 100644
--- a/drivers/misc/genwqe/card_base.h
+++ b/drivers/misc/genwqe/card_base.h
@@ -445,7 +445,7 @@ int  genwqe_device_create(struct genwqe_dev *cd);
 int  genwqe_device_remove(struct genwqe_dev *cd);
 
 /* debugfs */
-int  genwqe_init_debugfs(struct genwqe_dev *cd);
+void genwqe_init_debugfs(struct genwqe_dev *cd);
 void genqwe_exit_debugfs(struct genwqe_dev *cd);
 
 int  genwqe_read_softreset(struct genwqe_dev *cd);
diff --git a/drivers/misc/genwqe/card_debugfs.c b/drivers/misc/genwqe/card_debugfs.c
index 6f7e39f07811..3e319743e5a3 100644
--- a/drivers/misc/genwqe/card_debugfs.c
+++ b/drivers/misc/genwqe/card_debugfs.c
@@ -324,11 +324,9 @@ static int info_show(struct seq_file *s, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(info);
 
-int genwqe_init_debugfs(struct genwqe_dev *cd)
+void genwqe_init_debugfs(struct genwqe_dev *cd)
 {
 	struct dentry *root;
-	struct dentry *file;
-	int ret;
 	char card_name[64];
 	char name[64];
 	unsigned int i;
@@ -336,153 +334,50 @@ int genwqe_init_debugfs(struct genwqe_dev *cd)
 	sprintf(card_name, "%s%d_card", GENWQE_DEVNAME, cd->card_idx);
 
 	root = debugfs_create_dir(card_name, cd->debugfs_genwqe);
-	if (!root) {
-		ret = -ENOMEM;
-		goto err0;
-	}
 
 	/* non privileged interfaces are done here */
-	file = debugfs_create_file("ddcb_info", S_IRUGO, root, cd,
-				   &ddcb_info_fops);
-	if (!file) {
-		ret = -ENOMEM;
-		goto err1;
-	}
-
-	file = debugfs_create_file("info", S_IRUGO, root, cd,
-				   &info_fops);
-	if (!file) {
-		ret = -ENOMEM;
-		goto err1;
-	}
-
-	file = debugfs_create_x64("err_inject", 0666, root, &cd->err_inject);
-	if (!file) {
-		ret = -ENOMEM;
-		goto err1;
-	}
-
-	file = debugfs_create_u32("ddcb_software_timeout", 0666, root,
-				  &cd->ddcb_software_timeout);
-	if (!file) {
-		ret = -ENOMEM;
-		goto err1;
-	}
-
-	file = debugfs_create_u32("kill_timeout", 0666, root,
-				  &cd->kill_timeout);
-	if (!file) {
-		ret = -ENOMEM;
-		goto err1;
-	}
+	debugfs_create_file("ddcb_info", S_IRUGO, root, cd, &ddcb_info_fops);
+	debugfs_create_file("info", S_IRUGO, root, cd, &info_fops);
+	debugfs_create_x64("err_inject", 0666, root, &cd->err_inject);
+	debugfs_create_u32("ddcb_software_timeout", 0666, root,
+			   &cd->ddcb_software_timeout);
+	debugfs_create_u32("kill_timeout", 0666, root, &cd->kill_timeout);
 
 	/* privileged interfaces follow here */
 	if (!genwqe_is_privileged(cd)) {
 		cd->debugfs_root = root;
-		return 0;
+		return;
 	}
 
-	file = debugfs_create_file("curr_regs", S_IRUGO, root, cd,
-				   &curr_regs_fops);
-	if (!file) {
-		ret = -ENOMEM;
-		goto err1;
-	}
-
-	file = debugfs_create_file("curr_dbg_uid0", S_IRUGO, root, cd,
-				   &curr_dbg_uid0_fops);
-	if (!file) {
-		ret = -ENOMEM;
-		goto err1;
-	}
-
-	file = debugfs_create_file("curr_dbg_uid1", S_IRUGO, root, cd,
-				   &curr_dbg_uid1_fops);
-	if (!file) {
-		ret = -ENOMEM;
-		goto err1;
-	}
-
-	file = debugfs_create_file("curr_dbg_uid2", S_IRUGO, root, cd,
-				   &curr_dbg_uid2_fops);
-	if (!file) {
-		ret = -ENOMEM;
-		goto err1;
-	}
-
-	file = debugfs_create_file("prev_regs", S_IRUGO, root, cd,
-				   &prev_regs_fops);
-	if (!file) {
-		ret = -ENOMEM;
-		goto err1;
-	}
-
-	file = debugfs_create_file("prev_dbg_uid0", S_IRUGO, root, cd,
-				   &prev_dbg_uid0_fops);
-	if (!file) {
-		ret = -ENOMEM;
-		goto err1;
-	}
-
-	file = debugfs_create_file("prev_dbg_uid1", S_IRUGO, root, cd,
-				   &prev_dbg_uid1_fops);
-	if (!file) {
-		ret = -ENOMEM;
-		goto err1;
-	}
-
-	file = debugfs_create_file("prev_dbg_uid2", S_IRUGO, root, cd,
-				   &prev_dbg_uid2_fops);
-	if (!file) {
-		ret = -ENOMEM;
-		goto err1;
-	}
+	debugfs_create_file("curr_regs", S_IRUGO, root, cd, &curr_regs_fops);
+	debugfs_create_file("curr_dbg_uid0", S_IRUGO, root, cd,
+			    &curr_dbg_uid0_fops);
+	debugfs_create_file("curr_dbg_uid1", S_IRUGO, root, cd,
+			    &curr_dbg_uid1_fops);
+	debugfs_create_file("curr_dbg_uid2", S_IRUGO, root, cd,
+			    &curr_dbg_uid2_fops);
+	debugfs_create_file("prev_regs", S_IRUGO, root, cd, &prev_regs_fops);
+	debugfs_create_file("prev_dbg_uid0", S_IRUGO, root, cd,
+			    &prev_dbg_uid0_fops);
+	debugfs_create_file("prev_dbg_uid1", S_IRUGO, root, cd,
+			    &prev_dbg_uid1_fops);
+	debugfs_create_file("prev_dbg_uid2", S_IRUGO, root, cd,
+			    &prev_dbg_uid2_fops);
 
 	for (i = 0; i <  GENWQE_MAX_VFS; i++) {
 		sprintf(name, "vf%u_jobtimeout_msec", i);
-
-		file = debugfs_create_u32(name, 0666, root,
-					  &cd->vf_jobtimeout_msec[i]);
-		if (!file) {
-			ret = -ENOMEM;
-			goto err1;
-		}
+		debugfs_create_u32(name, 0666, root,
+				   &cd->vf_jobtimeout_msec[i]);
 	}
 
-	file = debugfs_create_file("jobtimer", S_IRUGO, root, cd,
-				   &jtimer_fops);
-	if (!file) {
-		ret = -ENOMEM;
-		goto err1;
-	}
-
-	file = debugfs_create_file("queue_working_time", S_IRUGO, root, cd,
-				   &queue_working_time_fops);
-	if (!file) {
-		ret = -ENOMEM;
-		goto err1;
-	}
-
-	file = debugfs_create_u32("skip_recovery", 0666, root,
-				  &cd->skip_recovery);
-	if (!file) {
-		ret = -ENOMEM;
-		goto err1;
-	}
-
-	file = debugfs_create_u32("use_platform_recovery", 0666, root,
-				  &cd->use_platform_recovery);
-	if (!file) {
-		ret = -ENOMEM;
-		goto err1;
-	}
+	debugfs_create_file("jobtimer", S_IRUGO, root, cd, &jtimer_fops);
+	debugfs_create_file("queue_working_time", S_IRUGO, root, cd,
+			    &queue_working_time_fops);
+	debugfs_create_u32("skip_recovery", 0666, root, &cd->skip_recovery);
+	debugfs_create_u32("use_platform_recovery", 0666, root,
+			   &cd->use_platform_recovery);
 
 	cd->debugfs_root = root;
-	return 0;
-err1:
-	debugfs_remove_recursive(root);
-err0:
-	return ret;
 }
 
 void genqwe_exit_debugfs(struct genwqe_dev *cd)
diff --git a/drivers/misc/genwqe/card_dev.c b/drivers/misc/genwqe/card_dev.c
index 8c1b63a4337b..b5942e8943ef 100644
--- a/drivers/misc/genwqe/card_dev.c
+++ b/drivers/misc/genwqe/card_dev.c
@@ -1307,14 +1307,10 @@ int genwqe_device_create(struct genwqe_dev *cd)
 		goto err_cdev;
 	}
 
-	rc = genwqe_init_debugfs(cd);
-	if (rc != 0)
-		goto err_debugfs;
+	genwqe_init_debugfs(cd);
 
 	return 0;
 
- err_debugfs:
-	device_destroy(cd->class_genwqe, cd->devnum_genwqe);
  err_cdev:
 	cdev_del(&cd->cdev_genwqe);
  err_add:
diff --git a/drivers/misc/mei/debugfs.c b/drivers/misc/mei/debugfs.c
index 0970142bcace..df6bf8b81936 100644
--- a/drivers/misc/mei/debugfs.c
+++ b/drivers/misc/mei/debugfs.c
@@ -233,47 +233,22 @@ void mei_dbgfs_deregister(struct mei_device *dev)
  *
  * @dev: the mei device structure
  * @name: the mei device name
- *
- * Return: 0 on success, <0 on failure.
  */
-int mei_dbgfs_register(struct mei_device *dev, const char *name)
+void mei_dbgfs_register(struct mei_device *dev, const char *name)
 {
-	struct dentry *dir, *f;
+	struct dentry *dir;
 
 	dir = debugfs_create_dir(name, NULL);
-	if (!dir)
-		return -ENOMEM;
-
 	dev->dbgfs_dir = dir;
 
-	f = debugfs_create_file("meclients", S_IRUSR, dir,
-				dev, &mei_dbgfs_fops_meclients);
-	if (!f) {
-		dev_err(dev->dev, "meclients: registration failed\n");
-		goto err;
-	}
-	f = debugfs_create_file("active", S_IRUSR, dir,
-				dev, &mei_dbgfs_fops_active);
-	if (!f) {
-		dev_err(dev->dev, "active: registration failed\n");
-		goto err;
-	}
-	f = debugfs_create_file("devstate", S_IRUSR, dir,
-				dev, &mei_dbgfs_fops_devstate);
-	if (!f) {
-		dev_err(dev->dev, "devstate: registration failed\n");
-		goto err;
-	}
-	f = debugfs_create_file("allow_fixed_address", S_IRUSR | S_IWUSR, dir,
-				&dev->allow_fixed_address,
-				&mei_dbgfs_fops_allow_fa);
-	if (!f) {
-		dev_err(dev->dev, "allow_fixed_address: registration failed\n");
-		goto err;
-	}
-	return 0;
-err:
-	mei_dbgfs_deregister(dev);
-	return -ENODEV;
+	debugfs_create_file("meclients", S_IRUSR, dir, dev,
+			    &mei_dbgfs_fops_meclients);
+	debugfs_create_file("active", S_IRUSR, dir, dev,
+			    &mei_dbgfs_fops_active);
+	debugfs_create_file("devstate", S_IRUSR, dir, dev,
+			    &mei_dbgfs_fops_devstate);
+	debugfs_create_file("allow_fixed_address", S_IRUSR | S_IWUSR, dir,
+			    &dev->allow_fixed_address,
+			    &mei_dbgfs_fops_allow_fa);
 }
 
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index ad02097d7fee..f894d1f8a53e 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -984,16 +984,10 @@ int mei_register(struct mei_device *dev, struct device *parent)
 		goto err_dev_create;
 	}
 
-	ret = mei_dbgfs_register(dev, dev_name(clsdev));
-	if (ret) {
-		dev_err(clsdev, "cannot register debugfs ret = %d\n", ret);
-		goto err_dev_dbgfs;
-	}
+	mei_dbgfs_register(dev, dev_name(clsdev));
 
 	return 0;
 
-err_dev_dbgfs:
-	device_destroy(mei_class, devno);
 err_dev_create:
 	cdev_del(&dev->cdev);
 err_dev_add:
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index fca832fcac57..f71a023aed3c 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -718,13 +718,10 @@ bool mei_hbuf_acquire(struct mei_device *dev);
 bool mei_write_is_idle(struct mei_device *dev);
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
-int mei_dbgfs_register(struct mei_device *dev, const char *name);
+void mei_dbgfs_register(struct mei_device *dev, const char *name);
 void mei_dbgfs_deregister(struct mei_device *dev);
 #else
-static inline int mei_dbgfs_register(struct mei_device *dev, const char *name)
-{
-	return 0;
-}
+static inline void mei_dbgfs_register(struct mei_device *dev, const char *name) {}
 static inline void mei_dbgfs_deregister(struct mei_device *dev) {}
 #endif /* CONFIG_DEBUG_FS */
 
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
diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index e7cfdbd1f66d..93821c11bff9 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -761,10 +761,6 @@ static int kim_probe(struct platform_device *pdev)
 	pr_info("sysfs entries created\n");
 
 	kim_debugfs_dir = debugfs_create_dir("ti-st", NULL);
-	if (!kim_debugfs_dir) {
-		pr_err(" debugfs entries creation failed ");
-		return 0;
-	}
 
 	debugfs_create_file("version", S_IRUGO, kim_debugfs_dir,
 				kim_gdata, &version_fops);
diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index ad807d5a3141..fdf5ad757226 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1516,19 +1516,10 @@ static int vmballoon_debug_show(struct seq_file *f, void *offset)
 
 DEFINE_SHOW_ATTRIBUTE(vmballoon_debug);
 
-static int __init vmballoon_debugfs_init(struct vmballoon *b)
+static void __init vmballoon_debugfs_init(struct vmballoon *b)
 {
-	int error;
-
 	b->dbg_entry = debugfs_create_file("vmmemctl", S_IRUGO, NULL, b,
 					   &vmballoon_debug_fops);
-	if (IS_ERR(b->dbg_entry)) {
-		error = PTR_ERR(b->dbg_entry);
-		pr_err("failed to create debugfs entry, error: %d\n", error);
-		return error;
-	}
-
-	return 0;
 }
 
 static void __exit vmballoon_debugfs_exit(struct vmballoon *b)
@@ -1541,9 +1532,8 @@ static void __exit vmballoon_debugfs_exit(struct vmballoon *b)
 
 #else
 
-static inline int vmballoon_debugfs_init(struct vmballoon *b)
+static inline void vmballoon_debugfs_init(struct vmballoon *b)
 {
-	return 0;
 }
 
 static inline void vmballoon_debugfs_exit(struct vmballoon *b)
@@ -1555,7 +1545,6 @@ static inline void vmballoon_debugfs_exit(struct vmballoon *b)
 static int __init vmballoon_init(void)
 {
 	enum vmballoon_page_size_type page_size;
-	int error;
 
 	/*
 	 * Check if we are running on VMware's hypervisor and bail out
@@ -1571,9 +1560,7 @@ static int __init vmballoon_init(void)
 
 	INIT_DELAYED_WORK(&balloon.dwork, vmballoon_work);
 
-	error = vmballoon_debugfs_init(&balloon);
-	if (error)
-		return error;
+	vmballoon_debugfs_init(&balloon);
 
 	spin_lock_init(&balloon.comm_lock);
 	init_rwsem(&balloon.conf_sem);
-- 
2.22.0

