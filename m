Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0B3C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC0C2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbfJNNwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:52:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3711 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731092AbfJNNwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:52:53 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F3990FE4F67A274B6D56;
        Mon, 14 Oct 2019 21:52:50 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Mon, 14 Oct 2019 21:52:44 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] docs: block: Remove blk_init_queue related description
Date:   Mon, 14 Oct 2019 21:50:02 +0800
Message-ID: <1571061002-25998-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk_init_queue has been removed since commit <a1ce35fa4985>
("block: remove dead elevator code"), Let's cleanup the description
in the biodoc.rst document.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 Documentation/block/biodoc.rst | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/block/biodoc.rst b/Documentation/block/biodoc.rst
index b964796ec9c7..a19081d88349 100644
--- a/Documentation/block/biodoc.rst
+++ b/Documentation/block/biodoc.rst
@@ -1013,11 +1013,6 @@ request_fn execution which it means that lots of older drivers
 should still be SMP safe. Drivers are free to drop the queue
 lock themselves, if required. Drivers that explicitly used the
 io_request_lock for serialization need to be modified accordingly.
-Usually it's as easy as adding a global lock::
-
-	static DEFINE_SPINLOCK(my_driver_lock);
-
-and passing the address to that lock to blk_init_queue().
 
 5.2 64 bit sector numbers (sector_t prepares for 64 bit support)
 ----------------------------------------------------------------
@@ -1071,11 +1066,6 @@ right thing to use is bio_endio(bio) instead.
 If the driver is dropping the io_request_lock from its request_fn strategy,
 then it just needs to replace that with q->queue_lock instead.
 
-As described in Sec 1.1, drivers can set max sector size, max segment size
-etc per queue now. Drivers that used to define their own merge functions i
-to handle things like this can now just use the blk_queue_* functions at
-blk_init_queue time.
-
 Drivers no longer have to map a {partition, sector offset} into the
 correct absolute location anymore, this is done by the block layer, so
 where a driver received a request ala this before::
-- 
2.7.4

