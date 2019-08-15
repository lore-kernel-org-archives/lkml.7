Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEE8C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 11:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16A92083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 11:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbfHOLp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 07:45:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42072 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728464AbfHOLp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 07:45:58 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 00F349C9855E94F96FF4;
        Thu, 15 Aug 2019 19:45:57 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 15 Aug 2019 19:45:49 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     Chao Yu <yuchao0@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
Subject: [PATCH 3/3] f2fs: fix to use more generic EOPNOTSUPP
Date:   Thu, 15 Aug 2019 19:45:36 +0800
Message-ID: <20190815114536.114255-3-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20190815114536.114255-1-yuchao0@huawei.com>
References: <20190815114536.114255-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EOPNOTSUPP is widely used as error number indicating operation is
not supported in syscall, and ENOTSUPP was defined and only used
for NFSv3 protocol, so use EOPNOTSUPP instead.

Fixes: 0a2aa8fbb969 ("f2fs: refactor __exchange_data_block for speed up")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b3937a6497d9..64469555e774 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1034,7 +1034,7 @@ static int __read_out_blkaddrs(struct inode *inode, block_t *blkaddr,
 
 			if (test_opt(sbi, LFS)) {
 				f2fs_put_dnode(&dn);
-				return -ENOTSUPP;
+				return -EOPNOTSUPP;
 			}
 
 			/* do not invalidate this block address */
-- 
2.18.0.rc1

