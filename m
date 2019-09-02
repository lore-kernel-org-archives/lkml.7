Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07649C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FDA2087E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbfIBOnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 10:43:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58364 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731175AbfIBOnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:43:20 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BEA50F3B77B84EDC58D3;
        Mon,  2 Sep 2019 22:43:17 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Sep 2019
 22:43:08 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <miklos@szeredi.hu>, <stefanha@redhat.com>, <vgoyal@redhat.com>,
        <mszeredi@redhat.com>, <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] virtio-fs: Add missing include file
Date:   Mon, 2 Sep 2019 22:39:15 +0800
Message-ID: <20190902143915.20576-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fs/fuse/virtio_fs.c: In function virtio_fs_requests_done_work:
fs/fuse/virtio_fs.c:348:6: error: implicit declaration of function zero_user_segment;
 did you mean get_user_pages? [-Werror=implicit-function-declaration]
      zero_user_segment(page, len, thislen);
      ^~~~~~~~~~~~~~~~~
      get_user_pages

Add missing include file <linux/highmem.h>

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 08f3aab37d99 ("virtio-fs: add virtiofs filesystem")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/fuse/virtio_fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index b92dfb1..e731c4f 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -10,6 +10,7 @@
 #include <linux/virtio_fs.h>
 #include <linux/delay.h>
 #include <linux/fs_context.h>
+#include <linux/highmem.h>
 #include "fuse_i.h"
 
 /* List of virtio-fs device instances and a lock for the list */
-- 
2.7.4


