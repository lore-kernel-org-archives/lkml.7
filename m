Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2504FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD11120663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbfDPUWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:22:49 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:54037 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730472AbfDPUWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:22:48 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MYLqs-1hKMVj2DQ2-00VROG; Tue, 16 Apr 2019 22:22:29 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Felipe Balbi <balbi@kernel.org>,
        Jerry Zhang <zhangjerry@google.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Shen Jing <jingx.shen@intel.com>,
        linuxppc-dev@lists.ozlabs.org, megaraidlinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v3 10/26] compat_ioctl: use correct compat_ptr() translation in drivers
Date:   Tue, 16 Apr 2019 22:19:48 +0200
Message-Id: <20190416202013.4034148-11-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190416202013.4034148-1-arnd@arndb.de>
References: <20190416202013.4034148-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dhXxVwlF+OTv8zTau2mq8cW9se+5+L4XB4D+BXwtDLVtt1eHtvH
 9j0eCYXXgpxChG2e+3m5sp1o66pwBmHIM2FHcEPi9zE0BZKkLHbZNmHnn2+GcU+w9KKJ0Xr
 +OSW2NH8h1S951PFymOn/9mrd2neAmTVkxmgkRDwiI2y7EQMG12TYsIUTnf0SUxFMAktcKM
 /O02KIxJdbN27u4CGMA4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p/lEhNyfi0M=:BGMO+DqJh9KBHQtwPEOwGx
 ZvFHFvMvfly9/nfku2neA5EJJ0wA/7lYo2R92uQbDZ4RSunLr4T3lNgvwy8J2miL4ONveNol0
 NO0TBQCQ+Kv4Lr9VnORrI9XV8IR9huTtI9Kkz+kuzHZWlivbFJwQxgX7hGtYwV3fJxnY1rWn3
 1UYFA/0oowmuOdzjvn1K8BEwz2lOGQz/TMc+yv5UuJQ2v3iaXL8fqpOg7oM/SGBngGL9Zq3QJ
 76Lo3SUQuBgoBwW3vyukwEHw363Va2GXlPbbF4mPDzOGRpDBunS1ghS2gYU9ZjTbDlc6FHtDf
 XuZCgJ1WkglsDHhbegTdCIgzhRz9CY8MLOarplHlUkrqVjxKIo+EQDw3rlUWdxSIjutMjadMp
 Q5d+sYXmL5nxc41yjTr6IEy+FRb8M/gFRpiCrqHKh6lV7IF6OwfDFLuXN64Od+s/YCQ4yze1S
 4NGTx3sJiDXUXsY0G7E+ne1X2DSfvtoF6PbZzOcWGUvYNKcz6GzPB9eoA4hgO5JXXgu8OP4GH
 9mvOERN3xpBwk409vs3LKwMiNar3EdDF75tVcEQEzX8WPIJ+deJwS44rhZ4pSp8usbPjrGC8c
 EsfY+Ftfu9ngwxbRw5lLYuN8AsTEl/BSELPDew5KLKLNBkfVq54qhM3qs654jfrPJyWhnArQN
 FRh2ekxvl5xRzxrw9VCHRmLcdkyamf/BKexhZefiopdVuK7TmkF3IyUBtt1Tbrr4LAmGWj4Rv
 60qC4WULwufY42ykZcHrTiyfzlUZFbScqwLLkA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A handful of drivers all have a trivial wrapper around their ioctl
handler, but don't call the compat_ptr() conversion function at the
moment. In practice this does not matter, since none of them are used
on the s390 architecture and for all other architectures, compat_ptr()
does not do anything, but using the new compat_ptr_ioctl()
helper makes it more correct in theory, and simplifies the code.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/cxl/flash.c            |  8 +-------
 drivers/misc/genwqe/card_dev.c      | 23 +----------------------
 drivers/scsi/megaraid/megaraid_mm.c | 28 +---------------------------
 drivers/usb/gadget/function/f_fs.c  | 12 +-----------
 4 files changed, 4 insertions(+), 67 deletions(-)

diff --git a/drivers/misc/cxl/flash.c b/drivers/misc/cxl/flash.c
index 4d6836f19489..cb9cca35a226 100644
--- a/drivers/misc/cxl/flash.c
+++ b/drivers/misc/cxl/flash.c
@@ -473,12 +473,6 @@ static long device_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		return -EINVAL;
 }
 
-static long device_compat_ioctl(struct file *file, unsigned int cmd,
-				unsigned long arg)
-{
-	return device_ioctl(file, cmd, arg);
-}
-
 static int device_close(struct inode *inode, struct file *file)
 {
 	struct cxl *adapter = file->private_data;
@@ -514,7 +508,7 @@ static const struct file_operations fops = {
 	.owner		= THIS_MODULE,
 	.open		= device_open,
 	.unlocked_ioctl	= device_ioctl,
-	.compat_ioctl	= device_compat_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.release	= device_close,
 };
 
diff --git a/drivers/misc/genwqe/card_dev.c b/drivers/misc/genwqe/card_dev.c
index 8c1b63a4337b..5de0796f2786 100644
--- a/drivers/misc/genwqe/card_dev.c
+++ b/drivers/misc/genwqe/card_dev.c
@@ -1221,34 +1221,13 @@ static long genwqe_ioctl(struct file *filp, unsigned int cmd,
 	return rc;
 }
 
-#if defined(CONFIG_COMPAT)
-/**
- * genwqe_compat_ioctl() - Compatibility ioctl
- *
- * Called whenever a 32-bit process running under a 64-bit kernel
- * performs an ioctl on /dev/genwqe<n>_card.
- *
- * @filp:        file pointer.
- * @cmd:         command.
- * @arg:         user argument.
- * Return:       zero on success or negative number on failure.
- */
-static long genwqe_compat_ioctl(struct file *filp, unsigned int cmd,
-				unsigned long arg)
-{
-	return genwqe_ioctl(filp, cmd, arg);
-}
-#endif /* defined(CONFIG_COMPAT) */
-
 static const struct file_operations genwqe_fops = {
 	.owner		= THIS_MODULE,
 	.open		= genwqe_open,
 	.fasync		= genwqe_fasync,
 	.mmap		= genwqe_mmap,
 	.unlocked_ioctl	= genwqe_ioctl,
-#if defined(CONFIG_COMPAT)
-	.compat_ioctl   = genwqe_compat_ioctl,
-#endif
+	.compat_ioctl   = compat_ptr_ioctl,
 	.release	= genwqe_release,
 };
 
diff --git a/drivers/scsi/megaraid/megaraid_mm.c b/drivers/scsi/megaraid/megaraid_mm.c
index 3ce837e4b24c..21ee5751c04e 100644
--- a/drivers/scsi/megaraid/megaraid_mm.c
+++ b/drivers/scsi/megaraid/megaraid_mm.c
@@ -45,10 +45,6 @@ static int mraid_mm_setup_dma_pools(mraid_mmadp_t *);
 static void mraid_mm_free_adp_resources(mraid_mmadp_t *);
 static void mraid_mm_teardown_dma_pools(mraid_mmadp_t *);
 
-#ifdef CONFIG_COMPAT
-static long mraid_mm_compat_ioctl(struct file *, unsigned int, unsigned long);
-#endif
-
 MODULE_AUTHOR("LSI Logic Corporation");
 MODULE_DESCRIPTION("LSI Logic Management Module");
 MODULE_LICENSE("GPL");
@@ -72,9 +68,7 @@ static wait_queue_head_t wait_q;
 static const struct file_operations lsi_fops = {
 	.open	= mraid_mm_open,
 	.unlocked_ioctl = mraid_mm_unlocked_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl = mraid_mm_compat_ioctl,
-#endif
+	.compat_ioctl = compat_ptr_ioctl,
 	.owner	= THIS_MODULE,
 	.llseek = noop_llseek,
 };
@@ -228,7 +222,6 @@ mraid_mm_unlocked_ioctl(struct file *filep, unsigned int cmd,
 {
 	int err;
 
-	/* inconsistent: mraid_mm_compat_ioctl doesn't take the BKL */
 	mutex_lock(&mraid_mm_mutex);
 	err = mraid_mm_ioctl(filep, cmd, arg);
 	mutex_unlock(&mraid_mm_mutex);
@@ -1232,25 +1225,6 @@ mraid_mm_init(void)
 }
 
 
-#ifdef CONFIG_COMPAT
-/**
- * mraid_mm_compat_ioctl	- 32bit to 64bit ioctl conversion routine
- * @filep	: file operations pointer (ignored)
- * @cmd		: ioctl command
- * @arg		: user ioctl packet
- */
-static long
-mraid_mm_compat_ioctl(struct file *filep, unsigned int cmd,
-		      unsigned long arg)
-{
-	int err;
-
-	err = mraid_mm_ioctl(filep, cmd, arg);
-
-	return err;
-}
-#endif
-
 /**
  * mraid_mm_exit	- Module exit point
  */
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 20413c276c61..addc210d198a 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1347,14 +1347,6 @@ static long ffs_epfile_ioctl(struct file *file, unsigned code,
 	return ret;
 }
 
-#ifdef CONFIG_COMPAT
-static long ffs_epfile_compat_ioctl(struct file *file, unsigned code,
-		unsigned long value)
-{
-	return ffs_epfile_ioctl(file, code, value);
-}
-#endif
-
 static const struct file_operations ffs_epfile_operations = {
 	.llseek =	no_llseek,
 
@@ -1363,9 +1355,7 @@ static const struct file_operations ffs_epfile_operations = {
 	.read_iter =	ffs_epfile_read_iter,
 	.release =	ffs_epfile_release,
 	.unlocked_ioctl =	ffs_epfile_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl = ffs_epfile_compat_ioctl,
-#endif
+	.compat_ioctl = compat_ptr_ioctl,
 };
 
 
-- 
2.20.0

