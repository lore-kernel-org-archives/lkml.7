Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C0FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 12:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407EB2190F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 12:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKKMY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 07:24:59 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:41858 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726811AbfKKMY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 07:24:58 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 289F912BCEF92F048447;
        Mon, 11 Nov 2019 20:24:55 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Mon, 11 Nov 2019
 20:24:45 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <vgoyal@redhat.com>, <stefanha@redhat.com>, <miklos@szeredi.hu>,
        <mszeredi@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] virtiofs: Fix old-style declaration
Date:   Mon, 11 Nov 2019 20:23:59 +0800
Message-ID: <20191111122359.43624-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There expect the 'static' keyword to come first in a
declaration, and we get warnings like this with "make W=1":

fs/fuse/virtio_fs.c:687:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
fs/fuse/virtio_fs.c:692:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
fs/fuse/virtio_fs.c:1029:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/fuse/virtio_fs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index b77acea..2ac6818 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -684,12 +684,12 @@ static int virtio_fs_restore(struct virtio_device *vdev)
 }
 #endif /* CONFIG_PM_SLEEP */
 
-const static struct virtio_device_id id_table[] = {
+static const struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_FS, VIRTIO_DEV_ANY_ID },
 	{},
 };
 
-const static unsigned int feature_table[] = {};
+static const unsigned int feature_table[] = {};
 
 static struct virtio_driver virtio_fs_driver = {
 	.driver.name		= KBUILD_MODNAME,
@@ -1026,7 +1026,7 @@ __releases(fiq->lock)
 	}
 }
 
-const static struct fuse_iqueue_ops virtio_fs_fiq_ops = {
+static const struct fuse_iqueue_ops virtio_fs_fiq_ops = {
 	.wake_forget_and_unlock		= virtio_fs_wake_forget_and_unlock,
 	.wake_interrupt_and_unlock	= virtio_fs_wake_interrupt_and_unlock,
 	.wake_pending_and_unlock	= virtio_fs_wake_pending_and_unlock,
-- 
2.7.4


