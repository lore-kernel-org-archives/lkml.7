Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93123C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 00:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68EE921881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 00:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfICAAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 20:00:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfICAAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 20:00:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 595C5307D90D;
        Tue,  3 Sep 2019 00:00:10 +0000 (UTC)
Received: from dustball.brq.redhat.com (unknown [10.43.17.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFA18608AB;
        Tue,  3 Sep 2019 00:00:07 +0000 (UTC)
From:   Jan Stancek <jstancek@redhat.com>
To:     hirofumi@mail.parknet.co.jp
Cc:     linux-kernel@vger.kernel.org, jstancek@redhat.com
Subject: [PATCH] fat: fix corruption in fat_alloc_new_dir()
Date:   Tue,  3 Sep 2019 01:59:36 +0200
Message-Id: <fc8878aeefea128c105c49671b2a1ac4694e1f48.1567468225.git.jstancek@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 03 Sep 2019 00:00:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sb_getblk does not guarantee that buffer_head is uptodate. If there is
async read running in parallel for same buffer_head, it can overwrite
just initialized msdos_dir_entry, leading to corruption:
  FAT-fs (loop0): error, corrupted directory (invalid entries)
  FAT-fs (loop0): Filesystem has been set read-only

This can happen for example during LTP statx04, which creates loop
device, formats it (mkfs.vfat), mounts it and immediately creates
a new directory. In parallel, systemd-udevd is probing new block
device, which leads to async read.

  do_mkdirat                      ksys_read
   vfs_mkdir                       vfs_read
    vfat_mkdir                      __vfs_read
     fat_alloc_new_dir               new_sync_read
       /* init de[0], de[1] */        blkdev_read_iter
                                       generic_file_read_iter
                                        generic_file_buffered_read
                                         blkdev_readpage
                                          block_read_full_page

Faster reproducer (based on LTP statx04):
--------------------------------- 8< ---------------------------------
int main(void)
{
	int i, j, ret, fd, loop_fd, ctrl_fd;
	int loop_num;
	char loopdev[256], tmp[256], testfile[256];

	mkdir("/tmp/mntpoint", 0777);
	for (i = 0; ; i++) {
		printf("Iteration: %d\n", i);
		sprintf(testfile, "/tmp/test.img.%d", getpid());

		ctrl_fd = open("/dev/loop-control", O_RDWR);
		loop_num = ioctl(ctrl_fd, LOOP_CTL_GET_FREE);
		close(ctrl_fd);
		sprintf(loopdev, "/dev/loop%d", loop_num);

		fd = open(testfile, O_WRONLY|O_CREAT|O_TRUNC, 0600);
		fallocate(fd, 0, 0, 256*1024*1024);
		close(fd);

		fd = open(testfile, O_RDWR);
		loop_fd = open(loopdev, O_RDWR);
		ioctl(loop_fd, LOOP_SET_FD, fd);
		close(loop_fd);
		close(fd);

		sprintf(tmp, "mkfs.vfat %s", loopdev);
		system(tmp);
		mount(loopdev, "/tmp/mntpoint", "vfat", 0, NULL);

		for (j = 0; j < 200; j++) {
			sprintf(tmp, "/tmp/mntpoint/testdir%d", j);
			ret = mkdir(tmp, 0777);
			if (ret) {
				perror("mkdir");
				break;
			}
		}

		umount("/tmp/mntpoint");
		loop_fd = open(loopdev, O_RDWR);
		ioctl(loop_fd, LOOP_CLR_FD, fd);
		close(loop_fd);
		unlink(testfile);

		if (ret)
			break;
	}

	return 0;
}
--------------------------------- 8< ---------------------------------

Issue triggers within minute on HPE Apollo 70 (arm64, 64GB RAM, 224 CPUs).

Signed-off-by: Jan Stancek <jstancek@redhat.com>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---
 fs/fat/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 1bda2ab6745b..474fd6873ec8 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -1149,7 +1149,7 @@ int fat_alloc_new_dir(struct inode *dir, struct timespec64 *ts)
 		goto error;
 
 	blknr = fat_clus_to_blknr(sbi, cluster);
-	bhs[0] = sb_getblk(sb, blknr);
+	bhs[0] = sb_bread(sb, blknr);
 	if (!bhs[0]) {
 		err = -ENOMEM;
 		goto error_free;
-- 
1.8.3.1

