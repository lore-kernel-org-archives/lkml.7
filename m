Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C9BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F7D208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551687789;
	bh=Im0ccbENMgSHBPMue2rd/5Y3/QnWDRL2qIYLBe9PlS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zv9cx9JfL1M4oNwdFYGcuB5Y5og+NkRq4ZPjyXE3L5TpH/ab9MsZDwhnZRJuzbARP
	 eK9mdXNf2UG8yfyjtBjlgTKOv1jzNjPfy+da2JQw0sHLZm/hbVZssS4Spt01eRQrTA
	 3LeIGRaU2aa4P7mH/iyl91eQZtRe7+2zy0ADp6AQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfCDIXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:23:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:38388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfCDIXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:23:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30BDB20823;
        Mon,  4 Mar 2019 08:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687785;
        bh=Im0ccbENMgSHBPMue2rd/5Y3/QnWDRL2qIYLBe9PlS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xa8McjZRo9WlvHkt33H8zv0SRKe2U8tnN+he8ZmyfMyxJXhieJuIqNujirOcy1tys
         BzvQUsSLrNVkE9NAazKPDN48W77EMh2ezzoQG1fl4mWMNgM4U+J+gfRpiwtBFfOD1J
         TC8PuNStSOTq/vWrfXqGKFWBTU2cn8EO6FGOwWdE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Lindroth <thomas.lindroth@gmail.com>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.9 02/32] Revert "loop: Get rid of loop_index_mutex"
Date:   Mon,  4 Mar 2019 09:21:50 +0100
Message-Id: <20190304081602.478558699@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081602.307094059@linuxfoundation.org>
References: <20190304081602.307094059@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 6a8f1d8d701462937ce01a3f2219af5435372af7 which is
commit 0a42e99b58a208839626465af194cfe640ef9493 upstream.

It does not work properly in the 4.9.y tree and causes more problems
than it fixes, so revert it.

Reported-by: Thomas Lindroth <thomas.lindroth@gmail.com>
Reported-by: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/loop.c |   39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -81,6 +81,7 @@
 #include <asm/uaccess.h>
 
 static DEFINE_IDR(loop_index_idr);
+static DEFINE_MUTEX(loop_index_mutex);
 static DEFINE_MUTEX(loop_ctl_mutex);
 
 static int max_part;
@@ -1559,11 +1560,9 @@ static int lo_compat_ioctl(struct block_
 static int lo_open(struct block_device *bdev, fmode_t mode)
 {
 	struct loop_device *lo;
-	int err;
+	int err = 0;
 
-	err = mutex_lock_killable(&loop_ctl_mutex);
-	if (err)
-		return err;
+	mutex_lock(&loop_index_mutex);
 	lo = bdev->bd_disk->private_data;
 	if (!lo) {
 		err = -ENXIO;
@@ -1572,7 +1571,7 @@ static int lo_open(struct block_device *
 
 	atomic_inc(&lo->lo_refcnt);
 out:
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&loop_index_mutex);
 	return err;
 }
 
@@ -1581,11 +1580,12 @@ static void lo_release(struct gendisk *d
 	struct loop_device *lo;
 	int err;
 
-	mutex_lock(&loop_ctl_mutex);
+	mutex_lock(&loop_index_mutex);
 	lo = disk->private_data;
 	if (atomic_dec_return(&lo->lo_refcnt))
-		goto out_unlock;
+		goto unlock_index;
 
+	mutex_lock(&loop_ctl_mutex);
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
 		/*
 		 * In autoclear mode, stop the loop thread
@@ -1593,7 +1593,7 @@ static void lo_release(struct gendisk *d
 		 */
 		err = loop_clr_fd(lo);
 		if (!err)
-			return;
+			goto unlock_index;
 	} else {
 		/*
 		 * Otherwise keep thread (if running) and config,
@@ -1602,8 +1602,9 @@ static void lo_release(struct gendisk *d
 		loop_flush(lo);
 	}
 
-out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
+unlock_index:
+	mutex_unlock(&loop_index_mutex);
 }
 
 static const struct block_device_operations lo_fops = {
@@ -1889,7 +1890,7 @@ static struct kobject *loop_probe(dev_t
 	struct kobject *kobj;
 	int err;
 
-	mutex_lock(&loop_ctl_mutex);
+	mutex_lock(&loop_index_mutex);
 	err = loop_lookup(&lo, MINOR(dev) >> part_shift);
 	if (err < 0)
 		err = loop_add(&lo, MINOR(dev) >> part_shift);
@@ -1897,7 +1898,7 @@ static struct kobject *loop_probe(dev_t
 		kobj = NULL;
 	else
 		kobj = get_disk(lo->lo_disk);
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&loop_index_mutex);
 
 	*part = 0;
 	return kobj;
@@ -1907,13 +1908,9 @@ static long loop_control_ioctl(struct fi
 			       unsigned long parm)
 {
 	struct loop_device *lo;
-	int ret;
-
-	ret = mutex_lock_killable(&loop_ctl_mutex);
-	if (ret)
-		return ret;
+	int ret = -ENOSYS;
 
-	ret = -ENOSYS;
+	mutex_lock(&loop_index_mutex);
 	switch (cmd) {
 	case LOOP_CTL_ADD:
 		ret = loop_lookup(&lo, parm);
@@ -1927,6 +1924,7 @@ static long loop_control_ioctl(struct fi
 		ret = loop_lookup(&lo, parm);
 		if (ret < 0)
 			break;
+		mutex_lock(&loop_ctl_mutex);
 		if (lo->lo_state != Lo_unbound) {
 			ret = -EBUSY;
 			mutex_unlock(&loop_ctl_mutex);
@@ -1938,6 +1936,7 @@ static long loop_control_ioctl(struct fi
 			break;
 		}
 		lo->lo_disk->private_data = NULL;
+		mutex_unlock(&loop_ctl_mutex);
 		idr_remove(&loop_index_idr, lo->lo_number);
 		loop_remove(lo);
 		break;
@@ -1947,7 +1946,7 @@ static long loop_control_ioctl(struct fi
 			break;
 		ret = loop_add(&lo, -1);
 	}
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&loop_index_mutex);
 
 	return ret;
 }
@@ -2030,10 +2029,10 @@ static int __init loop_init(void)
 				  THIS_MODULE, loop_probe, NULL, NULL);
 
 	/* pre-create number of devices given by config or max_loop */
-	mutex_lock(&loop_ctl_mutex);
+	mutex_lock(&loop_index_mutex);
 	for (i = 0; i < nr; i++)
 		loop_add(&lo, i);
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&loop_index_mutex);
 
 	printk(KERN_INFO "loop: module loaded\n");
 	return 0;


