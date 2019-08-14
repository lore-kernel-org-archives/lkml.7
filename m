Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04ECC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F532206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565803690;
	bh=3bSg0NQM5Wvew2KrvpYZQ7EbTTUjofAdVmPG3s5dh3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0hD2dXjcmGryfaWkS/QFUHD6VaT3WtTcMLSxnIfrFcmHcOlq3qu1imI0AcypTePCc
	 Q1hRvQLUBcy+rPVtDHu7d50vRngVG8gL2dcBaN0UqR/Mzzi8s7On9HjI0OpvA3SIzg
	 3jMoHQiWqPLDBmrU7J1anjbBMLbQBbVV51wT2Ijs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfHNRCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbfHNRCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:02:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C27AB214DA;
        Wed, 14 Aug 2019 17:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802158;
        bh=3bSg0NQM5Wvew2KrvpYZQ7EbTTUjofAdVmPG3s5dh3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yyJqmjIuJgw4ZN0Gwrw+iZiATQ2oLvtbVYybFUh1xFFVgcu4ghIcIjYQCblXnfmM9
         MbM4LyRgsq6w7EDrWtOuw7MC4YASQqAzbmAYQeSJp2gm1TjyCCsWsn8TKVWhpDY+e0
         sxp/ScCXRIjViWzKhuu8e+CbWyrBSs9r3/+rCHzs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+7bbcbe9c9ff0cd49592a@syzkaller.appspotmail.com,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 5.2 017/144] Revert "USB: rio500: simplify locking"
Date:   Wed, 14 Aug 2019 18:59:33 +0200
Message-Id: <20190814165800.615302353@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165759.466811854@linuxfoundation.org>
References: <20190814165759.466811854@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit 2ca359f4f8b954b3a9d15a89f22a8b7283e7669f upstream.

This reverts commit d710734b06770814de2bfa2819420fb5df7f3a81.
This simplification causes a deadlock.

Reported-by: syzbot+7bbcbe9c9ff0cd49592a@syzkaller.appspotmail.com
Fixes: d710734b0677 ("USB: rio500: simplify locking")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Link: https://lore.kernel.org/r/20190808092854.23519-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/rio500.c |   43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

--- a/drivers/usb/misc/rio500.c
+++ b/drivers/usb/misc/rio500.c
@@ -51,6 +51,7 @@ struct rio_usb_data {
         char *obuf, *ibuf;              /* transfer buffers */
         char bulk_in_ep, bulk_out_ep;   /* Endpoint assignments */
         wait_queue_head_t wait_q;       /* for timeouts */
+	struct mutex lock;          /* general race avoidance */
 };
 
 static DEFINE_MUTEX(rio500_mutex);
@@ -62,8 +63,10 @@ static int open_rio(struct inode *inode,
 
 	/* against disconnect() */
 	mutex_lock(&rio500_mutex);
+	mutex_lock(&(rio->lock));
 
 	if (rio->isopen || !rio->present) {
+		mutex_unlock(&(rio->lock));
 		mutex_unlock(&rio500_mutex);
 		return -EBUSY;
 	}
@@ -71,6 +74,7 @@ static int open_rio(struct inode *inode,
 
 	init_waitqueue_head(&rio->wait_q);
 
+	mutex_unlock(&(rio->lock));
 
 	dev_info(&rio->rio_dev->dev, "Rio opened.\n");
 	mutex_unlock(&rio500_mutex);
@@ -84,6 +88,7 @@ static int close_rio(struct inode *inode
 
 	/* against disconnect() */
 	mutex_lock(&rio500_mutex);
+	mutex_lock(&(rio->lock));
 
 	rio->isopen = 0;
 	if (!rio->present) {
@@ -95,6 +100,7 @@ static int close_rio(struct inode *inode
 	} else {
 		dev_info(&rio->rio_dev->dev, "Rio closed.\n");
 	}
+	mutex_unlock(&(rio->lock));
 	mutex_unlock(&rio500_mutex);
 	return 0;
 }
@@ -109,7 +115,7 @@ static long ioctl_rio(struct file *file,
 	int retries;
 	int retval=0;
 
-	mutex_lock(&rio500_mutex);
+	mutex_lock(&(rio->lock));
         /* Sanity check to make sure rio is connected, powered, etc */
         if (rio->present == 0 || rio->rio_dev == NULL) {
 		retval = -ENODEV;
@@ -253,7 +259,7 @@ static long ioctl_rio(struct file *file,
 
 
 err_out:
-	mutex_unlock(&rio500_mutex);
+	mutex_unlock(&(rio->lock));
 	return retval;
 }
 
@@ -273,12 +279,12 @@ write_rio(struct file *file, const char
 	int errn = 0;
 	int intr;
 
-	intr = mutex_lock_interruptible(&rio500_mutex);
+	intr = mutex_lock_interruptible(&(rio->lock));
 	if (intr)
 		return -EINTR;
         /* Sanity check to make sure rio is connected, powered, etc */
         if (rio->present == 0 || rio->rio_dev == NULL) {
-		mutex_unlock(&rio500_mutex);
+		mutex_unlock(&(rio->lock));
 		return -ENODEV;
 	}
 
@@ -301,7 +307,7 @@ write_rio(struct file *file, const char
 				goto error;
 			}
 			if (signal_pending(current)) {
-				mutex_unlock(&rio500_mutex);
+				mutex_unlock(&(rio->lock));
 				return bytes_written ? bytes_written : -EINTR;
 			}
 
@@ -339,12 +345,12 @@ write_rio(struct file *file, const char
 		buffer += copy_size;
 	} while (count > 0);
 
-	mutex_unlock(&rio500_mutex);
+	mutex_unlock(&(rio->lock));
 
 	return bytes_written ? bytes_written : -EIO;
 
 error:
-	mutex_unlock(&rio500_mutex);
+	mutex_unlock(&(rio->lock));
 	return errn;
 }
 
@@ -361,12 +367,12 @@ read_rio(struct file *file, char __user
 	char *ibuf;
 	int intr;
 
-	intr = mutex_lock_interruptible(&rio500_mutex);
+	intr = mutex_lock_interruptible(&(rio->lock));
 	if (intr)
 		return -EINTR;
 	/* Sanity check to make sure rio is connected, powered, etc */
         if (rio->present == 0 || rio->rio_dev == NULL) {
-		mutex_unlock(&rio500_mutex);
+		mutex_unlock(&(rio->lock));
 		return -ENODEV;
 	}
 
@@ -377,11 +383,11 @@ read_rio(struct file *file, char __user
 
 	while (count > 0) {
 		if (signal_pending(current)) {
-			mutex_unlock(&rio500_mutex);
+			mutex_unlock(&(rio->lock));
 			return read_count ? read_count : -EINTR;
 		}
 		if (!rio->rio_dev) {
-			mutex_unlock(&rio500_mutex);
+			mutex_unlock(&(rio->lock));
 			return -ENODEV;
 		}
 		this_read = (count >= IBUF_SIZE) ? IBUF_SIZE : count;
@@ -399,7 +405,7 @@ read_rio(struct file *file, char __user
 			count = this_read = partial;
 		} else if (result == -ETIMEDOUT || result == 15) {	/* FIXME: 15 ??? */
 			if (!maxretry--) {
-				mutex_unlock(&rio500_mutex);
+				mutex_unlock(&(rio->lock));
 				dev_err(&rio->rio_dev->dev,
 					"read_rio: maxretry timeout\n");
 				return -ETIME;
@@ -409,19 +415,19 @@ read_rio(struct file *file, char __user
 			finish_wait(&rio->wait_q, &wait);
 			continue;
 		} else if (result != -EREMOTEIO) {
-			mutex_unlock(&rio500_mutex);
+			mutex_unlock(&(rio->lock));
 			dev_err(&rio->rio_dev->dev,
 				"Read Whoops - result:%d partial:%u this_read:%u\n",
 				result, partial, this_read);
 			return -EIO;
 		} else {
-			mutex_unlock(&rio500_mutex);
+			mutex_unlock(&(rio->lock));
 			return (0);
 		}
 
 		if (this_read) {
 			if (copy_to_user(buffer, ibuf, this_read)) {
-				mutex_unlock(&rio500_mutex);
+				mutex_unlock(&(rio->lock));
 				return -EFAULT;
 			}
 			count -= this_read;
@@ -429,7 +435,7 @@ read_rio(struct file *file, char __user
 			buffer += this_read;
 		}
 	}
-	mutex_unlock(&rio500_mutex);
+	mutex_unlock(&(rio->lock));
 	return read_count;
 }
 
@@ -494,6 +500,8 @@ static int probe_rio(struct usb_interfac
 	}
 	dev_dbg(&intf->dev, "ibuf address:%p\n", rio->ibuf);
 
+	mutex_init(&(rio->lock));
+
 	usb_set_intfdata (intf, rio);
 	rio->present = 1;
 bail_out:
@@ -511,10 +519,12 @@ static void disconnect_rio(struct usb_in
 	if (rio) {
 		usb_deregister_dev(intf, &usb_rio_class);
 
+		mutex_lock(&(rio->lock));
 		if (rio->isopen) {
 			rio->isopen = 0;
 			/* better let it finish - the release will do whats needed */
 			rio->rio_dev = NULL;
+			mutex_unlock(&(rio->lock));
 			mutex_unlock(&rio500_mutex);
 			return;
 		}
@@ -524,6 +534,7 @@ static void disconnect_rio(struct usb_in
 		dev_info(&intf->dev, "USB Rio disconnected.\n");
 
 		rio->present = 0;
+		mutex_unlock(&(rio->lock));
 	}
 	mutex_unlock(&rio500_mutex);
 }


