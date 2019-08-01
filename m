Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AD3C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD49D20644
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbfHAJCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 05:02:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730567AbfHAJCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:02:17 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EC4231E189F8CB4F00ED;
        Thu,  1 Aug 2019 17:02:10 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Thu, 1 Aug 2019
 17:01:56 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <yi.zhang@huawei.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>
Subject: [RFC] ubi: ubi_wl_get_peb: Replace a limited number of attempts with polling while getting PEB
Date:   Thu, 1 Aug 2019 17:07:49 +0800
Message-ID: <1564650469-130037-1-git-send-email-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running pressure test io_paral (A pressure ubi test in mtd-utils) on an
UBI device with fewer PEBs (fastmap enabled) may cause ENOSPC errors and
make UBI device read-only, but there are still free PEBs on the UBI
device. This problem can be easily reproduced by performing the following
steps on a 2-core machine:
  $ modprobe nandsim first_id_byte=0x20 second_id_byte=0x33 parts=80
  $ modprobe ubi mtd="0,0" fm_autoconvert
  $ ./io_paral /dev/ubi0

We may see the following verbose:
(output)
  [io_paral] update_volume():105: function write() failed with error 30
  (Read-only file system)
  [io_paral] update_volume():108: failed to write 380 bytes at offset
  95920 of volume 2
  [io_paral] update_volume():109: update: 97088 bytes
  [io_paral] write_thread():227: function pwrite() failed with error 28
  (No space left on device)
  [io_paral] write_thread():229: cannot write 15872 bytes to offs 31744,
  wrote -1
(dmesg)
  ubi0 error: ubi_wl_get_peb [ubi]: Unable to get a free PEB from user WL
  pool
  ubi0 warning: ubi_eba_write_leb [ubi]: switch to read-only mode
  ubi0 error: ubi_io_write [ubi]: read-only mode
  CPU: 0 PID: 2027 Comm: io_paral Not tainted 5.3.0-rc2-00001-g5986cd0 #9
  ubi0 warning: try_write_vid_and_data [ubi]: failed to write VID header
  to LEB 2:5, PEB 18
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0
  -0-ga698c8995f-prebuilt.qemu.org 04/01/2014
  Call Trace:
   dump_stack+0x85/0xba
   ubi_eba_write_leb+0xa1e/0xa40 [ubi]
   vol_cdev_write+0x307/0x520 [ubi]
  ubi0 error: vol_cdev_write [ubi]: cannot accept more 380 bytes of data,
  error -30
   vfs_write+0xfa/0x280
   ksys_pwrite64+0xc5/0xe0
   __x64_sys_pwrite64+0x22/0x30
   do_syscall_64+0xbf/0x440

In function ubi_wl_get_peb, the operation of filling the pool
(ubi_update_fastmap) with free PEBs and fetching a free PEB from the pool
is not atomic. After thread A filling the pool with free PEB, free PEB may
be taken away by thread B. When thread A checks the expression again, the
condition is still unsatisfactory. At this time, there may still be free
PEBs on UBI that can be filled into the pool.
So, ubi_wl_get_peb (in fastmap-wil.c) should be implemented to obtain a
free PEB by polling method. The polling exit condition is that there is
no free PEBs on UBI, no free PEBs in pool, and ubi->works_count is 0.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/ubi/fastmap-wl.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/ubi/fastmap-wl.c b/drivers/mtd/ubi/fastmap-wl.c
index d9e2e3a..c5512cf 100644
--- a/drivers/mtd/ubi/fastmap-wl.c
+++ b/drivers/mtd/ubi/fastmap-wl.c
@@ -196,7 +196,7 @@ static int produce_free_peb(struct ubi_device *ubi)
  */
 int ubi_wl_get_peb(struct ubi_device *ubi)
 {
-	int ret, retried = 0;
+	int ret;
 	struct ubi_fm_pool *pool = &ubi->fm_pool;
 	struct ubi_fm_pool *wl_pool = &ubi->fm_wl_pool;
 
@@ -220,13 +220,14 @@ int ubi_wl_get_peb(struct ubi_device *ubi)
 	}
 
 	if (pool->used == pool->size) {
-		spin_unlock(&ubi->wl_lock);
-		if (retried) {
+		if (!ubi->free.rb_node && ubi->works_count == 0) {
 			ubi_err(ubi, "Unable to get a free PEB from user WL pool");
+			ubi_assert(list_empty(&ubi->works));
+			spin_unlock(&ubi->wl_lock);
 			ret = -ENOSPC;
 			goto out;
 		}
-		retried = 1;
+		spin_unlock(&ubi->wl_lock);
 		up_read(&ubi->fm_eba_sem);
 		ret = produce_free_peb(ubi);
 		if (ret < 0) {
-- 
2.7.4

