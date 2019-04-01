Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E4BC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F97206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138566;
	bh=JsfMbJlnrOweOhKl2Ym1LOshHT+iz0+cseajk3rMzgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jcHNOXkpnxGNBlImdJmOrpD66e5BzwKpbuXY/ySUbyV3DwaAmJ7UldplALks6JAhn
	 P+dmWIui0Xuj3jBQke0t25scz3JNn7bStetZnTsp6LzgURNEhLiZRv1FvnnYa1ZRnO
	 zODu96yhlFe9Pen6gicZsSmeEhhuu+hjUOFDsIpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfDARJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:09:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbfDARJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:09:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CEA7206B8;
        Mon,  1 Apr 2019 17:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138561;
        bh=JsfMbJlnrOweOhKl2Ym1LOshHT+iz0+cseajk3rMzgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Utt5LK1oPt2nHWFTFxs3S5nQXhMqDTPqQmVNfC2LOtEJaju++e0xsgQIejgTWOtK
         9rp0hxnjt7mxQB5zeGoLQjWFwZ0/+ZLuqPGRz2YMYb9cY5/non4BhrTifhE+0lOZC5
         yK7RJT0eCC9zbrKFrO+It+nseHidmbfiwtCtGf20=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Makoto Wu <makotowu@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.0 102/146] drivers/block/zram/zram_drv.c: fix idle/writeback string compare
Date:   Mon,  1 Apr 2019 19:01:54 +0200
Message-Id: <20190401170057.314389729@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Minchan Kim <minchan@kernel.org>

commit 0bc9f5d14a93971c6cd9c0d81b0fc154fc54c65d upstream.

Makoto report a below KASAN error: zram does out-of-bounds read.  Because
strscpy copies from source up to count bytes unconditionally.  It could
cause out-of-bounds read on next object in slab.

To prevent it, use strlcpy which checks source's length automatically.

   BUG: KASAN: slab-out-of-bounds in strscpy+0x68/0x154
   Read of size 8 at addr ffffffc0c3495a00 by task system_server/1314
   ..
   Call trace:
     strscpy+0x68/0x154
     idle_store+0xc4/0x34c
     dev_attr_store+0x50/0x6c
     sysfs_kf_write+0x98/0xb4
     kernfs_fop_write+0x198/0x260
     __vfs_write+0x10c/0x338
     vfs_write+0x114/0x238
     SyS_write+0xc8/0x168
     __sys_trace_return+0x0/0x4

   Allocated by task 1314:
    __kmalloc+0x280/0x318
    kernfs_fop_write+0xac/0x260
    __vfs_write+0x10c/0x338
    vfs_write+0x114/0x238
    SyS_write+0xc8/0x168
    __sys_trace_return+0x0/0x4

   Freed by task 2855:
    kfree+0x138/0x630
    kernfs_put_open_node+0x10c/0x124
    kernfs_fop_release+0xd8/0x114
    __fput+0x130/0x2a4
    ____fput+0x1c/0x28
    task_work_run+0x16c/0x1c8
    do_notify_resume+0x2bc/0x107c
    work_pending+0x8/0x10

   The buggy address belongs to the object at ffffffc0c3495a00
    which belongs to the cache kmalloc-128 of size 128
   The buggy address is located 0 bytes inside of
    128-byte region [ffffffc0c3495a00, ffffffc0c3495a80)
   The buggy address belongs to the page:
   page:ffffffbf030d2500 count:1 mapcount:0 mapping:          (null) index:0x0 compound_mapcount: 0
   flags: 0x4000000000010200(slab|head)
   page dumped because: kasan: bad access detected

   Memory state around the buggy address:
    ffffffc0c3495900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    ffffffc0c3495980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
   >ffffffc0c3495a00: 04 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                      ^
    ffffffc0c3495a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
    ffffffc0c3495b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Link: http://lkml.kernel.org/r/20190319231911.145968-1-minchan@kernel.org
Cc: <stable@vger.kernel.org>	[5.0]
Signed-off-by: Minchan Kim <minchan@kernel.org>
Reported-by: Makoto Wu <makotowu@google.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/zram/zram_drv.c |   32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -290,18 +290,8 @@ static ssize_t idle_store(struct device
 	struct zram *zram = dev_to_zram(dev);
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
 	int index;
-	char mode_buf[8];
-	ssize_t sz;
 
-	sz = strscpy(mode_buf, buf, sizeof(mode_buf));
-	if (sz <= 0)
-		return -EINVAL;
-
-	/* ignore trailing new line */
-	if (mode_buf[sz - 1] == '\n')
-		mode_buf[sz - 1] = 0x00;
-
-	if (strcmp(mode_buf, "all"))
+	if (!sysfs_streq(buf, "all"))
 		return -EINVAL;
 
 	down_read(&zram->init_lock);
@@ -635,25 +625,15 @@ static ssize_t writeback_store(struct de
 	struct bio bio;
 	struct bio_vec bio_vec;
 	struct page *page;
-	ssize_t ret, sz;
-	char mode_buf[8];
-	int mode = -1;
+	ssize_t ret;
+	int mode;
 	unsigned long blk_idx = 0;
 
-	sz = strscpy(mode_buf, buf, sizeof(mode_buf));
-	if (sz <= 0)
-		return -EINVAL;
-
-	/* ignore trailing newline */
-	if (mode_buf[sz - 1] == '\n')
-		mode_buf[sz - 1] = 0x00;
-
-	if (!strcmp(mode_buf, "idle"))
+	if (sysfs_streq(buf, "idle"))
 		mode = IDLE_WRITEBACK;
-	else if (!strcmp(mode_buf, "huge"))
+	else if (sysfs_streq(buf, "huge"))
 		mode = HUGE_WRITEBACK;
-
-	if (mode == -1)
+	else
 		return -EINVAL;
 
 	down_read(&zram->init_lock);


