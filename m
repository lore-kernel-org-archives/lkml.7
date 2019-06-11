Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7B6C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A5F217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560278472;
	bh=/PPduYLBdTAMNfKLUaKjNMNa5nxj1xSaZYMnHFzzddE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=NWJQ3zn+NZTaWOpmmPZY7nDwBzvmuIT5gLC+Smt/pL8sLorXzcYWycby1Uo8D3qF7
	 cVmgbG7YRGj/9RR1+L9aUV7/miy/htzOqg4F3NCtgy/zHESaX9gUY4M1Szpmj7lXCk
	 AXzTZAjnXRjwxaoRhwdKbKGb+0N/ggqYguK37u8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391961AbfFKSlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:41:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391882AbfFKSlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:41:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF07421783;
        Tue, 11 Jun 2019 18:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560278470;
        bh=/PPduYLBdTAMNfKLUaKjNMNa5nxj1xSaZYMnHFzzddE=;
        h=Date:From:To:Cc:Subject:From;
        b=boAfNRXDuEOIHR04+9oIfxm62bgHsFhRyJ1Cx5Kovo1FT0hNqx28Ff3925ODsu/1F
         xVTAHlkFXCOXNZ4ZD74xI/Kt5AHo9SEnNVdc/MGkH52yJbpgJz8BPVUhp8QHrvTZXt
         gNNYmYC9Bnh6DbKTtOqEtr3q1LNcqf8Xmwk5jBfg=
Date:   Tue, 11 Jun 2019 20:41:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frank Haverkamp <haver@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] genwq: no need to check return value of debugfs_create
 functions
Message-ID: <20190611184107.GA1873@kroah.com>
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

Cc: Frank Haverkamp <haver@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/genwqe/card_base.c    |   5 -
 drivers/misc/genwqe/card_base.h    |   2 +-
 drivers/misc/genwqe/card_debugfs.c | 165 ++++++-----------------------
 drivers/misc/genwqe/card_dev.c     |   6 +-
 4 files changed, 32 insertions(+), 146 deletions(-)

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
-- 
2.22.0

