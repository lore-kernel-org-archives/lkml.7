Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B28AC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B892177B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560278302;
	bh=op+unP1g+6aUGXSass0EO2pdGGP4Nq3gma2bxnFko7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UD9yXf4V9WCDloDnaEChlQI7+/JvTNizZWXeudPgWCYzsak2tAy8Bhh8Rq+dpGun3
	 0xUZtHCdikz63biOs7bsR/Tfeb7cI7LKLhY+rEeRgCT/Awdk37aj4GZpqDKZ7fIWjl
	 zSeDUqoqhM2NSPPTaVxQ24tOpmgozBgudcjexjCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391847AbfFKSiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:38:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388207AbfFKSiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:38:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 226E521743;
        Tue, 11 Jun 2019 18:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560278299;
        bh=op+unP1g+6aUGXSass0EO2pdGGP4Nq3gma2bxnFko7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ly5kCkPTmC6TeT8l+bNynWgf3TWDMqnvP1eknwgLW7uAtDbNAowHDFBLz0B9qNPOQ
         RFJb9anzu0k96SWyB9vx9S7QTWECzL5y+z61xdxYuf09TJgr0QyDAN8Cff8EIyp+lQ
         dx7r2cIFusvTLn2NinOArGRBnwwlUfIQmY4AsKKk=
Date:   Tue, 11 Jun 2019 20:38:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mei: no need to check return value of debugfs_create
 functions
Message-ID: <20190611183816.GA952@kroah.com>
References: <20190611183357.GA32008@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611183357.GA32008@kroah.com>
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
v2: break the patch up properly

 drivers/misc/mei/debugfs.c | 47 +++++++++-----------------------------
 drivers/misc/mei/main.c    |  8 +------
 drivers/misc/mei/mei_dev.h |  7 ++----
 3 files changed, 14 insertions(+), 48 deletions(-)

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
 
-- 
2.22.0

