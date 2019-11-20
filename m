Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC88C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1FE217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDOhSU6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfKTPRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:17:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37095 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbfKTPRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:17:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id b17so8248576wmj.2;
        Wed, 20 Nov 2019 07:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=79qqGS0lNwb/zyq9ZK72XcBW47MWbzSIAMwCPlUhgjw=;
        b=CDOhSU6ErxMaKzvnhNtl3k1L/TwsdRLwKN+oEDs+cVzcM9mA7cxeZr3RuUk5txUfxZ
         Isvk4oSQCBSXYyPeEsPQzGBYWGaMkOigFXRSLjJMVVA5aGm8rmK5JLgj5eJdAeQJgUis
         Hwf1a697ViUORsD0xs6dahLCR6RwWq4UlX8zID6b2unM/SlQRODR/fhAxNg5erupLfCf
         N82o6ypWVO0mGiFx93gZKkuxe9vasahqnOjwTcTbk47CwT7I9pMQjuFpdD2FbVGK4lou
         6aSL8AZcbgmdp+sR0xAv/lEuG/RKKZ4ujzjskMysak7OfX4OSJ6Pjjz5WUZEjecdBl1j
         TU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=79qqGS0lNwb/zyq9ZK72XcBW47MWbzSIAMwCPlUhgjw=;
        b=JUXa5sFNX/nzJQ67LjVxZBUXGCEtWuFwu4GJAp8na3qqjqO+N2FGru78WxmYBhb8J+
         5BBuiwDMl/RFBbYDWDwXHDGsXjlDrQtpofMAcuWecfSP4/gSqKXspb8aBzmM5POSPS3i
         Jb8OkK2snFfVzFfcp+B5Qgb3MfmkwQ9r0+HkWx3IiYXuVR3wa3SzYseY8Mw5D00xgFHO
         ipsim1lLMZJh7wEge26GYS0FHO3zt1KSJAJwPd5wvHNvsrTvo1coiPiCCvPDtjE5NysK
         AoodzS3Os+gBIiHVUeHXF614gg6/5RHmGh8AxOgMWQTdix0WMrjrBemtOGu/70vSWUeA
         qp4g==
X-Gm-Message-State: APjAAAX9u6SBdxbzTZ01pCk2UVNzjdsg4iEU/WQM9Qfc8khwulqF6e3F
        hOAcaRqDHn33SsIuiWANAsg=
X-Google-Smtp-Source: APXvYqztnoAsecqtVjRoe4DbYnzUNAzZU8YPkUKF5+b/UpNjf2ik2BYVzMZq0qF51pGVD3getxA4IQ==
X-Received: by 2002:a1c:e90b:: with SMTP id q11mr3806028wmc.125.1574263034807;
        Wed, 20 Nov 2019 07:17:14 -0800 (PST)
Received: from debian.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id y19sm7306119wmd.29.2019.11.20.07.17.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 07:17:14 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 2/2] tty: add retry to tty_init_dev() to workaround a race condition
Date:   Wed, 20 Nov 2019 15:17:09 +0000
Message-Id: <20191120151709.14148-2-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191120151709.14148-1-sudipm.mukherjee@gmail.com>
References: <20191120151709.14148-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a race condition in tty drivers and I could see on
many boot cycles a NULL pointer dereference as tty_init_dev() tries to
do 'tty->port->itty = tty' even though tty->port is NULL.
'tty->port' will be set by the driver and if the driver has not yet done
it before we open the tty device we can get to this situation. By adding
some extra debug prints, I noticed that tty_port_link_device() is
initialising 'driver->ports[index]' just few microseconds after I
get the warning.
So, add one retry so that tty_init_dev() will return -EAGAIN on its first
try if 'tty->port' is not set yet, and then tty_open() will try to open
it again.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/tty/pty.c                   |  2 +-
 drivers/tty/serdev/serdev-ttyport.c |  2 +-
 drivers/tty/tty_io.c                | 20 ++++++++++++++------
 include/linux/tty.h                 |  3 ++-
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 00099a8439d2..22e8c40d9f9c 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -842,7 +842,7 @@ static int ptmx_open(struct inode *inode, struct file *filp)
 
 
 	mutex_lock(&tty_mutex);
-	tty = tty_init_dev(ptm_driver, index);
+	tty = tty_init_dev(ptm_driver, index, 0);
 	/* The tty returned here is locked so we can safely
 	   drop the mutex */
 	mutex_unlock(&tty_mutex);
diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index d1cdd2ab8b4c..1162b4202e80 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -109,7 +109,7 @@ static int ttyport_open(struct serdev_controller *ctrl)
 	struct ktermios ktermios;
 	int ret;
 
-	tty = tty_init_dev(serport->tty_drv, serport->tty_idx);
+	tty = tty_init_dev(serport->tty_drv, serport->tty_idx, 0);
 	if (IS_ERR(tty))
 		return PTR_ERR(tty);
 	serport->tty = tty;
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index cb6370906a6d..e1b2086317fb 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1295,6 +1295,7 @@ static int tty_reopen(struct tty_struct *tty)
  *	tty_init_dev		-	initialise a tty device
  *	@driver: tty driver we are opening a device on
  *	@idx: device index
+ *	@retry: retry count if driver has not set tty->port yet
  *	@ret_tty: returned tty structure
  *
  *	Prepare a tty device. This may not be a "new" clean device but
@@ -1315,7 +1316,8 @@ static int tty_reopen(struct tty_struct *tty)
  * relaxed for the (most common) case of reopening a tty.
  */
 
-struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx)
+struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx,
+				int retry)
 {
 	struct tty_struct *tty;
 	int retval;
@@ -1344,6 +1346,10 @@ struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx)
 
 	if (!tty->port)
 		tty->port = driver->ports[idx];
+	if (!tty->port && retry) {
+		retval = -EAGAIN;
+		goto err_release_driver;
+	}
 
 	WARN_RATELIMIT(!tty->port,
 			"%s: %s driver does not set tty->port. This will crash the kernel later. Fix the driver!\n",
@@ -1366,6 +1372,8 @@ struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx)
 	/* Return the tty locked so that it cannot vanish under the caller */
 	return tty;
 
+err_release_driver:
+	tty_driver_remove_tty(driver, tty);
 err_free_tty:
 	tty_unlock(tty);
 	free_tty_struct(tty);
@@ -1910,7 +1918,7 @@ struct tty_struct *tty_kopen(dev_t device)
 		tty_kref_put(tty);
 		tty = ERR_PTR(-EBUSY);
 	} else { /* tty_init_dev returns tty with the tty_lock held */
-		tty = tty_init_dev(driver, index);
+		tty = tty_init_dev(driver, index, 0);
 		if (IS_ERR(tty))
 			goto out;
 		tty_port_set_kopened(tty->port, 1);
@@ -1937,7 +1945,7 @@ EXPORT_SYMBOL_GPL(tty_kopen);
  *	  - concurrent tty driver removal w/ lookup
  *	  - concurrent tty removal from driver table
  */
-static struct tty_struct *tty_open_by_driver(dev_t device,
+static struct tty_struct *tty_open_by_driver(dev_t device, int retry,
 					     struct file *filp)
 {
 	struct tty_struct *tty;
@@ -1981,7 +1989,7 @@ static struct tty_struct *tty_open_by_driver(dev_t device,
 			tty = ERR_PTR(retval);
 		}
 	} else { /* Returns with the tty_lock held for now */
-		tty = tty_init_dev(driver, index);
+		tty = tty_init_dev(driver, index, retry);
 		mutex_unlock(&tty_mutex);
 	}
 out:
@@ -2016,7 +2024,7 @@ static struct tty_struct *tty_open_by_driver(dev_t device,
 static int tty_open(struct inode *inode, struct file *filp)
 {
 	struct tty_struct *tty;
-	int noctty, retval;
+	int noctty, retval, retry = 1;
 	dev_t device = inode->i_rdev;
 	unsigned saved_flags = filp->f_flags;
 
@@ -2029,7 +2037,7 @@ static int tty_open(struct inode *inode, struct file *filp)
 
 	tty = tty_open_current_tty(device, filp);
 	if (!tty)
-		tty = tty_open_by_driver(device, filp);
+		tty = tty_open_by_driver(device, retry--, filp);
 
 	if (IS_ERR(tty)) {
 		tty_free_file(filp);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index bfa4e2ee94a9..2f74fc138e6a 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -559,7 +559,8 @@ extern struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx);
 extern int tty_alloc_file(struct file *file);
 extern void tty_add_file(struct tty_struct *tty, struct file *file);
 extern void tty_free_file(struct file *file);
-extern struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx);
+extern struct tty_struct *tty_init_dev(struct tty_driver *driver,
+				       int idx, int retry);
 extern void tty_release_struct(struct tty_struct *tty, int idx);
 extern int tty_release(struct inode *inode, struct file *filp);
 extern void tty_init_termios(struct tty_struct *tty);
-- 
2.11.0

