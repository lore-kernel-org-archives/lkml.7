Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1B3CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA33205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406082AbfJWNqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:46:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43304 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729191AbfJWNqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:46:19 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E84C9E136EF73CF8A241;
        Wed, 23 Oct 2019 21:46:16 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 21:46:07 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jk@ozlabs.org>, <arnd@arndb.de>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <mpe@ellerman.id.au>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] powerpc/spufs: remove set but not used variable 'ctx'
Date:   Wed, 23 Oct 2019 21:44:23 +0800
Message-ID: <20191023134423.15052-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/powerpc/platforms/cell/spufs/inode.c:201:22:
 warning: variable ctx set but not used [-Wunused-but-set-variable]

It is not used since commit 67cba9fd6456 ("move
spu_forget() into spufs_rmdir()")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 2dd452a..9b1586b 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -198,14 +198,12 @@ static int spufs_fill_dir(struct dentry *dir,
 
 static int spufs_dir_close(struct inode *inode, struct file *file)
 {
-	struct spu_context *ctx;
 	struct inode *parent;
 	struct dentry *dir;
 	int ret;
 
 	dir = file->f_path.dentry;
 	parent = d_inode(dir->d_parent);
-	ctx = SPUFS_I(d_inode(dir))->i_ctx;
 
 	inode_lock_nested(parent, I_MUTEX_PARENT);
 	ret = spufs_rmdir(parent, dir);
-- 
2.7.4


