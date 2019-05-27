Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE864C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3462081C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfE0OXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 10:23:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17167 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbfE0OXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:23:23 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1E1FFFED7482FF4080F8;
        Mon, 27 May 2019 22:23:21 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 27 May 2019
 22:23:14 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <bvanassche@acm.org>, <axboe@kernel.dk>, <hare@suse.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] scsi: scsi_dh_alua: Fix possible null-ptr-deref
Date:   Mon, 27 May 2019 22:22:09 +0800
Message-ID: <20190527142209.21768-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If alloc_workqueue fails in alua_init, it should return
-ENOMEM, otherwise it will trigger null-ptr-deref while
unloading module which calls destroy_workqueue dereference
wq->lock like this:

BUG: KASAN: null-ptr-deref in __lock_acquire+0x6b4/0x1ee0
Read of size 8 at addr 0000000000000080 by task syz-executor.0/7045

CPU: 0 PID: 7045 Comm: syz-executor.0 Tainted: G         C        5.1.0+ #28
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1
Call Trace:
 dump_stack+0xa9/0x10e
 __kasan_report+0x171/0x18d
 ? __lock_acquire+0x6b4/0x1ee0
 kasan_report+0xe/0x20
 __lock_acquire+0x6b4/0x1ee0
 lock_acquire+0xb4/0x1b0
 __mutex_lock+0xd8/0xb90
 drain_workqueue+0x25/0x290
 destroy_workqueue+0x1f/0x3f0
 __x64_sys_delete_module+0x244/0x330
 do_syscall_64+0x72/0x2a0
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 03197b61c5ec ("scsi_dh_alua: Use workqueue for RTPG")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/device_handler/scsi_dh_alua.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index d7ac498ba35a..2a9dcb8973b7 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -1174,10 +1174,8 @@ static int __init alua_init(void)
 	int r;
 
 	kaluad_wq = alloc_workqueue("kaluad", WQ_MEM_RECLAIM, 0);
-	if (!kaluad_wq) {
-		/* Temporary failure, bypass */
-		return SCSI_DH_DEV_TEMP_BUSY;
-	}
+	if (!kaluad_wq)
+		return -ENOMEM;
 
 	r = scsi_register_device_handler(&alua_dh);
 	if (r != 0) {
-- 
2.17.1


