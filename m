Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38568C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA572085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553037562;
	bh=bgb0k+DPFT94xA9ObhiQ6BSh8sYQkukXfT0DXw7xhVc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=S+/6mCZv9BL4Oapbpvv/VyemLDeo7OwqdlvgRFJD4QtkZQ7DF6RUK2ZxZNlYQGhcF
	 6XOnE+1gdYGZrA1LL/CD6+OimEClexBvTUPZsQyCYLh+VdDFuCOPFCfkslo5Tvjjcf
	 Nrea0yE2yTbK1iLORAu0yofhVNIJ6rpv3emaDWP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfCSXTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 19:19:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42680 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfCSXTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 19:19:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so269045pgh.9;
        Tue, 19 Mar 2019 16:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ME/sErz7zcCchDZVvi2cBPSVDZhFNC6Cd0/ndZ3CCfg=;
        b=SnH94AvUzgshgJpixMDmmFlhFYCtrSE41HDPFF8wgDLC78QbT1Un1WIaRotY2rZULZ
         dzir7GTv9ewd49+ZhMqKPdERB2Yg3MHkY8MHqu6VYGmqZK1UOdLDHAfTnAEMguz6V6I3
         q5yJqJMIT9foQkiM+5znPgxJGhbkab9Z39+apMo5b0ffW0VDtRL90wnu+n+0h+1lAUKb
         vMQIZEv3IPFjh9hBhZm7DjYJMheMZJhe/tGcNu0gdgagvp0EywfLY9XHlfgmgawDu5ci
         rEJUAU58cnwohrKHbxTpIViKkAHAtjUqgd1NO0WyM1zl7j2npTA93Wdn4VfSJiRZ+HeY
         lxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ME/sErz7zcCchDZVvi2cBPSVDZhFNC6Cd0/ndZ3CCfg=;
        b=rK3pXbYmXj9foLcvKLpLaJfXEekIZW2A+jIRWufkVSC+wKOgjHulBBLAlA7eAnyfgj
         JAVf4C0xGG2xG9IuIdgWOaKrPoHAa4qzqaJoZI8WjtumQIZuSYQT27CbBjX3tEHsXu7P
         QS9VqZjVVdlf8MQB32hru9Dwa1HuMMHprzOU2/qyLYJN2cApA8pR6A3SE6u0Zy5I3f9k
         MqNADPKBdQ3MLMCr6NnXxHx1ttQAi2fzRxkliBO1QIREQdKzgCkxzOloiSUVXa3xgoPC
         QpSUs2SMT+1k8ne/MxUDz0IgZSuXOAMlfMuWJH10Uh6jFGeNSf3RLwXUx2xGDm30N349
         zoLA==
X-Gm-Message-State: APjAAAWa52Kaf67mq7MSv6JxeCEerKaT0lP33EAOof6vKXgooZXjvMf7
        1O0gqQAjvRf4tXRq2iVpuzY=
X-Google-Smtp-Source: APXvYqwW2otZNQq2jTE+VRTxIK1rDO0VjTbtqEsHtRG2qWRbQsYfkv8PHs1IRh3xJvBLr3z+KB46cQ==
X-Received: by 2002:a62:b502:: with SMTP id y2mr4388591pfe.212.1553037559451;
        Tue, 19 Mar 2019 16:19:19 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id r8sm193880pfd.8.2019.03.19.16.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 16:19:17 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>, stable@vger.kernel.org,
        Makoto Wu <makotowu@google.com>
Subject: [PATCH] zram: fix idle/writeback string compare
Date:   Wed, 20 Mar 2019 08:19:11 +0900
Message-Id: <20190319231911.145968-1-minchan@kernel.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makoto report a below KASAN error: zram does out-of-bounds read.
Because strscpy copies from source up to count bytes unconditionally.
It could cause out-of-bounds read on next object in slab
To prevent it, use strlcpy which checks source's length automatically.

[  280.626730] c0 1314   ==================================================================
[  280.626855] c0 1314   BUG: KASAN: slab-out-of-bounds in strscpy+0x68/0x154
[  280.626896] c0 1314   Read of size 8 at addr ffffffc0c3495a00 by task system_server/1314
[  280.626921] c0 1314
..
[  280.627041] c0 1314   Call trace:
[  280.627097] c0 1314   [<ffffff90080902b8>] dump_backtrace+0x0/0x6bc
[  280.627142] c0 1314   [<ffffff90080902ac>] show_stack+0x20/0x2c
[  280.627193] c0 1314   [<ffffff900871fa90>] dump_stack+0xfc/0x140
[  280.627250] c0 1314   [<ffffff90083364ec>] print_address_description+0x80/0x2d8
[  280.627294] c0 1314   [<ffffff9008336b48>] kasan_report_error+0x198/0x1fc
[  280.627335] c0 1314   [<ffffff90083369b0>] kasan_report_error+0x0/0x1fc
[  280.627376] c0 1314   [<ffffff9008335c1c>] __asan_load8+0x1b0/0x1b8
[  280.627415] c0 1314   [<ffffff900872fb6c>] strscpy+0x68/0x154
[  280.627465] c0 1314   [<ffffff9008ceca44>] idle_store+0xc4/0x34c
[  280.627511] c0 1314   [<ffffff9008c91a98>] dev_attr_store+0x50/0x6c
[  280.627558] c0 1314   [<ffffff900845602c>] sysfs_kf_write+0x98/0xb4
[  280.627596] c0 1314   [<ffffff9008453d20>] kernfs_fop_write+0x198/0x260
[  280.627642] c0 1314   [<ffffff90083578b4>] __vfs_write+0x10c/0x338
[  280.627684] c0 1314   [<ffffff9008357dac>] vfs_write+0x114/0x238
[  280.627726] c0 1314   [<ffffff9008358100>] SyS_write+0xc8/0x168
[  280.627767] c0 1314   [<ffffff900808425c>] __sys_trace_return+0x0/0x4
[  280.627791] c0 1314
[  280.627824] c0 1314   Allocated by task 1314:
[  280.627866] c0 1314    kasan_kmalloc+0xe0/0x1ac
[  280.627903] c0 1314    __kmalloc+0x280/0x318
[  280.627938] c0 1314    kernfs_fop_write+0xac/0x260
[  280.627980] c0 1314    __vfs_write+0x10c/0x338
[  280.628020] c0 1314    vfs_write+0x114/0x238
[  280.628061] c0 1314    SyS_write+0xc8/0x168
[  280.628098] c0 1314    __sys_trace_return+0x0/0x4
[  280.628125] c0 1314
[  280.628154] c0 1314   Freed by task 2855:
[  280.628194] c0 1314    kasan_slab_free+0xb8/0x194
[  280.628229] c0 1314    kfree+0x138/0x630
[  280.628266] c0 1314    kernfs_put_open_node+0x10c/0x124
[  280.628302] c0 1314    kernfs_fop_release+0xd8/0x114
[  280.628336] c0 1314    __fput+0x130/0x2a4
[  280.628370] c0 1314    ____fput+0x1c/0x28
[  280.628410] c0 1314    task_work_run+0x16c/0x1c8
[  280.628449] c0 1314    do_notify_resume+0x2bc/0x107c
[  280.628483] c0 1314    work_pending+0x8/0x10
[  280.628506] c0 1314
[  280.628542] c0 1314   The buggy address belongs to the object at ffffffc0c3495a00
[  280.628542] c0 1314    which belongs to the cache kmalloc-128 of size 128
[  280.628597] c0 1314   The buggy address is located 0 bytes inside of
[  280.628597] c0 1314    128-byte region [ffffffc0c3495a00, ffffffc0c3495a80)
[  280.628642] c0 1314   The buggy address belongs to the page:
[  280.628680] c0 1314   page:ffffffbf030d2500 count:1 mapcount:0 mapping:          (null) index:0x0 compound_mapcount: 0
[  280.628721] c0 1314   flags: 0x4000000000010200(slab|head)
[  280.628748] c0 1314   page dumped because: kasan: bad access detected
[  280.628772] c0 1314
[  280.628797] c0 1314   Memory state around the buggy address:
[  280.628840] c0 1314    ffffffc0c3495900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  280.628874] c0 1314    ffffffc0c3495980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  280.628909] c0 1314   >ffffffc0c3495a00: 04 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  280.628935] c0 1314                      ^
[  280.628969] c0 1314    ffffffc0c3495a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  280.629005] c0 1314    ffffffc0c3495b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Cc: <stable@vger.kernel.org>	[5.0]
Reported-by: Makoto Wu <makotowu@google.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e7a5f1d1c3141..399cad7daae77 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -290,18 +290,8 @@ static ssize_t idle_store(struct device *dev,
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
@@ -635,25 +625,15 @@ static ssize_t writeback_store(struct device *dev,
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
-- 
2.21.0.225.g810b269d1ac-goog

