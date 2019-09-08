Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D653C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCBB207FC
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfIHKUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 06:20:54 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:41980 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfIHKUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 06:20:53 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 09FB615CBF0;
        Sun,  8 Sep 2019 19:20:52 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-14) with ESMTPS id x88AKoOj022349
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 8 Sep 2019 19:20:51 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-14) with ESMTPS id x88AKoLY011844
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 8 Sep 2019 19:20:50 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id x88AKnVe011843;
        Sun, 8 Sep 2019 19:20:49 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: fix corruption in fat_alloc_new_dir()
References: <fc8878aeefea128c105c49671b2a1ac4694e1f48.1567468225.git.jstancek@redhat.com>
Date:   Sun, 08 Sep 2019 19:20:49 +0900
In-Reply-To: <fc8878aeefea128c105c49671b2a1ac4694e1f48.1567468225.git.jstancek@redhat.com>
        (Jan Stancek's message of "Tue, 3 Sep 2019 01:59:36 +0200")
Message-ID: <87v9u3xf5q.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Stancek <jstancek@redhat.com> writes:

> sb_getblk does not guarantee that buffer_head is uptodate. If there is
> async read running in parallel for same buffer_head, it can overwrite
> just initialized msdos_dir_entry, leading to corruption:
>   FAT-fs (loop0): error, corrupted directory (invalid entries)
>   FAT-fs (loop0): Filesystem has been set read-only
>
> This can happen for example during LTP statx04, which creates loop
> device, formats it (mkfs.vfat), mounts it and immediately creates
> a new directory. In parallel, systemd-udevd is probing new block
> device, which leads to async read.
>
>   do_mkdirat                      ksys_read
>    vfs_mkdir                       vfs_read
>     vfat_mkdir                      __vfs_read
>      fat_alloc_new_dir               new_sync_read
>        /* init de[0], de[1] */        blkdev_read_iter
>                                        generic_file_read_iter
>                                         generic_file_buffered_read
>                                          blkdev_readpage
>                                           block_read_full_page
>
> Faster reproducer (based on LTP statx04):
>
> int main(void)
> {
> 	int i, j, ret, fd, loop_fd, ctrl_fd;
> 	int loop_num;
> 	char loopdev[256], tmp[256], testfile[256];
>
> 	mkdir("/tmp/mntpoint", 0777);
> 	for (i = 0; ; i++) {
> 		printf("Iteration: %d\n", i);
> 		sprintf(testfile, "/tmp/test.img.%d", getpid());
>
> 		ctrl_fd = open("/dev/loop-control", O_RDWR);
> 		loop_num = ioctl(ctrl_fd, LOOP_CTL_GET_FREE);
> 		close(ctrl_fd);
> 		sprintf(loopdev, "/dev/loop%d", loop_num);
>
> 		fd = open(testfile, O_WRONLY|O_CREAT|O_TRUNC, 0600);
> 		fallocate(fd, 0, 0, 256*1024*1024);
> 		close(fd);
>
> 		fd = open(testfile, O_RDWR);
> 		loop_fd = open(loopdev, O_RDWR);
> 		ioctl(loop_fd, LOOP_SET_FD, fd);
> 		close(loop_fd);
> 		close(fd);
>
> 		sprintf(tmp, "mkfs.vfat %s", loopdev);
> 		system(tmp);
> 		mount(loopdev, "/tmp/mntpoint", "vfat", 0, NULL);
>
> 		for (j = 0; j < 200; j++) {
> 			sprintf(tmp, "/tmp/mntpoint/testdir%d", j);
> 			ret = mkdir(tmp, 0777);
> 			if (ret) {
> 				perror("mkdir");
> 				break;
> 			}
> 		}
>
> 		umount("/tmp/mntpoint");
> 		loop_fd = open(loopdev, O_RDWR);
> 		ioctl(loop_fd, LOOP_CLR_FD, fd);
> 		close(loop_fd);
> 		unlink(testfile);
>
> 		if (ret)
> 			break;
> 	}
>
> 	return 0;
> }
>
> Issue triggers within minute on HPE Apollo 70 (arm64, 64GB RAM, 224 CPUs).

Using the device while mounting same device doesn't work reliably like
this race.  (getblk() is intentionally used to get the buffer to write
new data.)

mount(2) internally opens the device by EXCL mode, so I guess udev opens
without EXCL (I dont know if it is intent or not).

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
