Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B325C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A702072C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgABPBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 10:01:42 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:35147 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgABPBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 10:01:41 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MrPyJ-1jYEoj3ART-00oSvc; Thu, 02 Jan 2020 16:00:38 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>,
        Martin Wilck <mwilck@suse.com>,
        Amol Surati <suratiamol@gmail.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/22] compat_ioctl: ide: floppy: add handler
Date:   Thu,  2 Jan 2020 15:55:30 +0100
Message-Id: <20200102145552.1853992-13-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200102145552.1853992-1-arnd@arndb.de>
References: <20200102145552.1853992-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PpFBLdgmMhPS8ohTpLjgVgR48oR0XOCUBItZhe4AT+xbR/Z1a2P
 tOr70kI+XNqVktlBmCJCRAC0t4kgNfRUShbGiTabC8AJY1kNDlrV9jR2dyprHVvETZyPu9o
 ZJxX344gvTkx0ZlPzneHfYkA0Qlf4nsy8ysQUyX9BeSBXQ/qvKwUhpyjRGJJ6mgRBYep3q/
 b5dmCICcpaPeigK/V3yKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5RxWy8LIVGo=:GvElw8pEl/9N4GkxpgjMXj
 IVnffGDzbcQjHuV1iuFtBO5yXoPah459tyQyTgXkdo9jqSTxhMMONNM7ZYrRiDr9+Sv+JROke
 H3S5HtBLZc7rG/sYckHk5sCfJ64Uk0O5auhRcVNBHuPbQyuDDNRkG0GK25QHUYLeOcPb+wuPg
 vjozaItY9XbRl2RCWnVKOHSZ8Voj5qecb2hQcIVTQecgdVQo004l9gSA70S80Fa+L+uosydyL
 msnV7IqB0N5Xrq4tWMRjzb1qYw/6l1RSdAcPEmE4slbogWBd9+W9eiOiLC9+hXtZ3gd68O5g9
 bM9gWyaa9LkiaeKrS704tDGSN3sE2GYEDoBXNDfwQ9ewruEkz/tVXRJx4O7mZjg6/CRCO1/q3
 zqYtw2Sdb+zkMwAnrGi7o97qVLisxk6M+6PjPgzLg/USyrAO+7Ftzo6OBAxHCR44Wt5giofI8
 ZHRFKPOM1Axh59370WMyZpGv+X2oBDTdrjx5/8zMfDUt2X99xbxa3zZq/S563bCC1Ivl3SD3V
 zBuaZnnTwRhlMMfFxoCCymAI++IMFVWm5g691ANirPDKQSMCEQZLy+2LAtfzP2vdKODgBWDYx
 t6lwdsBjwpjEmm7J4wbbWaBxv8w7LuALQ+pcDieNjEyv9pBx9MpLBjfAUrbd0zfTGU665O4pk
 iWWniBlS7h2/oKVTIdlkZXm6uKeHt5m28RIHj9vJMD+AMjIUGcX7EwrFxwfgu39zfW/NmDMj3
 xbQBuJhMsPOqGbm0ybegCQOGhNKYLQVLLFU6Su5LwckOvYXUITbHnBMzJLG9yM//2I0/KHa5v
 LvBnEg7i4BKBlu6QpRNoOF5Kl9Fj5b/TBNoeg9PU+giDPRF8BONAGD9/LXhHJF2sHT/S3hPWL
 x2D3qEaPKuFT16Ii06gA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than relying on fs/compat_ioctl.c, this adds support
for a compat_ioctl() callback in the ide-floppy driver directly,
which lets it translate the scsi commands.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ide/ide-floppy.c       |  4 ++++
 drivers/ide/ide-floppy.h       |  2 ++
 drivers/ide/ide-floppy_ioctl.c | 36 ++++++++++++++++++++++++++++++++++
 drivers/ide/ide-gd.c           | 17 ++++++++++++++++
 include/linux/ide.h            |  2 ++
 5 files changed, 61 insertions(+)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 1ea2f9e82bf8..1fe1f9d37a51 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -19,6 +19,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
+#include <linux/compat.h>
 #include <linux/delay.h>
 #include <linux/timer.h>
 #include <linux/mm.h>
@@ -546,4 +547,7 @@ const struct ide_disk_ops ide_atapi_disk_ops = {
 	.set_doorlock	= ide_set_media_lock,
 	.do_request	= ide_floppy_do_request,
 	.ioctl		= ide_floppy_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= ide_floppy_compat_ioctl,
+#endif
 };
diff --git a/drivers/ide/ide-floppy.h b/drivers/ide/ide-floppy.h
index 13c9b4b6d75e..8505a5f58f4e 100644
--- a/drivers/ide/ide-floppy.h
+++ b/drivers/ide/ide-floppy.h
@@ -26,6 +26,8 @@ void ide_floppy_create_read_capacity_cmd(struct ide_atapi_pc *);
 /* ide-floppy_ioctl.c */
 int ide_floppy_ioctl(ide_drive_t *, struct block_device *, fmode_t,
 		     unsigned int, unsigned long);
+int ide_floppy_compat_ioctl(ide_drive_t *, struct block_device *, fmode_t,
+			    unsigned int, unsigned long);
 
 #ifdef CONFIG_IDE_PROC_FS
 /* ide-floppy_proc.c */
diff --git a/drivers/ide/ide-floppy_ioctl.c b/drivers/ide/ide-floppy_ioctl.c
index 40a2ebe34e1d..4fd70f804d6f 100644
--- a/drivers/ide/ide-floppy_ioctl.c
+++ b/drivers/ide/ide-floppy_ioctl.c
@@ -5,6 +5,7 @@
 
 #include <linux/kernel.h>
 #include <linux/ide.h>
+#include <linux/compat.h>
 #include <linux/cdrom.h>
 #include <linux/mutex.h>
 
@@ -302,3 +303,38 @@ int ide_floppy_ioctl(ide_drive_t *drive, struct block_device *bdev,
 	mutex_unlock(&ide_floppy_ioctl_mutex);
 	return err;
 }
+
+#ifdef CONFIG_COMPAT
+int ide_floppy_compat_ioctl(ide_drive_t *drive, struct block_device *bdev,
+			    fmode_t mode, unsigned int cmd, unsigned long arg)
+{
+	struct ide_atapi_pc pc;
+	void __user *argp = compat_ptr(arg);
+	int err;
+
+	mutex_lock(&ide_floppy_ioctl_mutex);
+	if (cmd == CDROMEJECT || cmd == CDROM_LOCKDOOR) {
+		err = ide_floppy_lockdoor(drive, &pc, arg, cmd);
+		goto out;
+	}
+
+	err = ide_floppy_format_ioctl(drive, &pc, mode, cmd, argp);
+	if (err != -ENOTTY)
+		goto out;
+
+	/*
+	 * skip SCSI_IOCTL_SEND_COMMAND (deprecated)
+	 * and CDROM_SEND_PACKET (legacy) ioctls
+	 */
+	if (cmd != CDROM_SEND_PACKET && cmd != SCSI_IOCTL_SEND_COMMAND)
+		err = scsi_cmd_blk_ioctl(bdev, mode, cmd, argp);
+
+	/*
+	 * there is no generic_ide_compat_ioctl(), that is handled
+	 * through compat_blkdev_ioctl().
+	 */
+out:
+	mutex_unlock(&ide_floppy_ioctl_mutex);
+	return err;
+}
+#endif
diff --git a/drivers/ide/ide-gd.c b/drivers/ide/ide-gd.c
index dba9ad5c97b3..1bb99b556393 100644
--- a/drivers/ide/ide-gd.c
+++ b/drivers/ide/ide-gd.c
@@ -341,11 +341,28 @@ static int ide_gd_ioctl(struct block_device *bdev, fmode_t mode,
 	return drive->disk_ops->ioctl(drive, bdev, mode, cmd, arg);
 }
 
+#ifdef CONFIG_COMPAT
+static int ide_gd_compat_ioctl(struct block_device *bdev, fmode_t mode,
+			       unsigned int cmd, unsigned long arg)
+{
+	struct ide_disk_obj *idkp = ide_drv_g(bdev->bd_disk, ide_disk_obj);
+	ide_drive_t *drive = idkp->drive;
+
+	if (!drive->disk_ops->compat_ioctl)
+		return -ENOIOCTLCMD;
+
+	return drive->disk_ops->compat_ioctl(drive, bdev, mode, cmd, arg);
+}
+#endif
+
 static const struct block_device_operations ide_gd_ops = {
 	.owner			= THIS_MODULE,
 	.open			= ide_gd_unlocked_open,
 	.release		= ide_gd_release,
 	.ioctl			= ide_gd_ioctl,
+#ifdef CONFIG_COMPAT
+	.ioctl			= ide_gd_compat_ioctl,
+#endif
 	.getgeo			= ide_gd_getgeo,
 	.check_events		= ide_gd_check_events,
 	.unlock_native_capacity	= ide_gd_unlock_native_capacity,
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 46b771d6999e..06dae6438557 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -413,6 +413,8 @@ struct ide_disk_ops {
 				      sector_t);
 	int		(*ioctl)(struct ide_drive_s *, struct block_device *,
 				 fmode_t, unsigned int, unsigned long);
+	int		(*compat_ioctl)(struct ide_drive_s *, struct block_device *,
+					fmode_t, unsigned int, unsigned long);
 };
 
 /* ATAPI device flags */
-- 
2.20.0

