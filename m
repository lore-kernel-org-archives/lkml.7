Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BA1C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37BB2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfLKUsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:48:12 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:38543 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfLKUsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:48:12 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mekzb-1i6twK2kir-00ann6; Wed, 11 Dec 2019 21:47:37 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hannes Reinecke <hare@suse.com>,
        Martin Wilck <mwilck@suse.com>,
        Amol Surati <suratiamol@gmail.com>, linux-ide@vger.kernel.org
Subject: [PATCH 14/24] compat_ioctl: ide: floppy: add handler
Date:   Wed, 11 Dec 2019 21:42:48 +0100
Message-Id: <20191211204306.1207817-15-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191211204306.1207817-1-arnd@arndb.de>
References: <20191211204306.1207817-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IvMP2z5YVCzTvfD6TzM8mO/FDut3fDi9clWAIVOAKQ93amLy1cC
 HRMNnnS3Jh8NFtNdPec+W92Ubk5oC4PIQ3b9ys0V92gINm3PrE+R/TaBqRI1lIF5MR1sjAn
 Bzi/Q//wOfsqW13GMHz89tVMV39l31bTV1ZBZe90popRMNO1u9Y/M7buvnmvOQ23RPSATwO
 LKCmU89E6oL19n6kj5HnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cJ5UoDf47fg=:6MvwK9m7x1EFzq7MGFpMQ6
 6R8OBWh6wz4jtW+BKHiMrITSuki5bg/Up3EZs+tx/Qeeeq1rSLx67KPrIhJD2PFIRt+xLEV+E
 QVyO6L86/XuOBAxVYwX/G+ESSpexRklx0K2mFDs4TfnuysHD6tfTeCoaQOJEbDcGv0xqtp+Q5
 X9h5d5UDGJLkisRKOX1jVMT7//kcEBElGzg6sd/rC8OcNnz4rNUAQlVnFOymcbTh0RFGTkDoS
 W7IOKgldnjK/CTZcmAupSaONozFLgA+a1gt04xLqVHqWQVBelEFvZ1IZ/R6KdX/2QEMeuCl7N
 nxtmnP7mIji3dF+QKukKMKB/dZQsugZtF68QmAJ1lLP7tEtOJJ0L90bEqK4OgXZDom8VQp2ZE
 UmjXM+SEf0x3A2lJqrux+5ipbbCbVrMpXtRbCk7uswAW6SL0+ZIKDrTu/BttPEuxB46mSqymO
 t3GrjL7+SL2ZibkZMIwi4WAuJthf4lezXj6zTrBSEvszLeYsTbDQr4yIDO5IsljICUZz8bthE
 UhhcOkxszZbuesFbwkaKIAfOD7CEqCkVeEHLoiFE/F8q8a3dOkN1muGcPLT4COXqGf6niTlQf
 jdM516lHC/yIioUexSCh1kNmUW4hBhgaE7v0Ojw3kBYyw4M8WzL6Hm4/aMLlgi3IIQcafZIym
 nQNmvCwwxM+0hs085vppOCYaY1PE1wjL9XF/eLJ/gg6O2C00JpaL8+fF007qwswTNSbaPxD/p
 LvipP8LJhfQ83m8mBhTrSEdhvvmMzIPcXDSyrC14EIfTZ/YBVg2NwEYTZOSB8p4LnZNW+ohAf
 On/I37Ay5Zi4/9koZjL9kLEiyvR+kn1rDP0uM9/O3cvV6cP1C+q+xwKjiSWrGJGT8tztLZMqi
 YU5r+N70aE8HFqBeY1qw==
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
 drivers/ide/ide-gd.c           | 14 +++++++++++++
 include/linux/ide.h            |  2 ++
 5 files changed, 58 insertions(+)

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
index dba9ad5c97b3..1b0270efcce2 100644
--- a/drivers/ide/ide-gd.c
+++ b/drivers/ide/ide-gd.c
@@ -341,11 +341,25 @@ static int ide_gd_ioctl(struct block_device *bdev, fmode_t mode,
 	return drive->disk_ops->ioctl(drive, bdev, mode, cmd, arg);
 }
 
+#ifdef CONFIG_COMPAT
+static int ide_gd_compat_ioctl(struct block_device *bdev, fmode_t mode,
+			       unsigned int cmd, unsigned long arg)
+{
+	struct ide_disk_obj *idkp = ide_drv_g(bdev->bd_disk, ide_disk_obj);
+	ide_drive_t *drive = idkp->drive;
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

