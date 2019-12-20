Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8641C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858F724679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfLTHI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 02:08:27 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727110AbfLTHI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:08:27 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B1E4FF35266EDFC729C5;
        Fri, 20 Dec 2019 15:08:22 +0800 (CST)
Received: from DESKTOP-9SCKDU9.china.huawei.com (10.67.102.224) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Dec 2019 15:08:13 +0800
From:   Huaijie Yi <yihuaijie@huawei.com>
To:     <dwmw2@infradead.org>, <richard@nod.at>, <viro@zeniv.linux.org.uk>,
        <dhowells@redhat.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yihuaijie@huawei.com>, Guohua Zhong <zhongguohua1@huawei.com>,
        zhangyi <yi.zhang@huawei.com>, chenjie <chenjie6@huawei.com>,
        fangxinwei <fangxinwei@huawei.com>
Subject: [PATCH] jffs2: fix kfree uninitialized pointer in jffs2_i_callback
Date:   Fri, 20 Dec 2019 15:07:24 +0800
Message-ID: <20191220070724.27660-1-yihuaijie@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.102.224]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 4fdcfab5b553 ("jffs2: fix use-after-free on
symlink traversal") move free operation of f->target
to jffs2_i_callback().

But when destroy an jffs2 inode in iget_locked(), jffs2_inode_info
was not initialized. which results in destroy_inode() calling
jffs2_i_callback() to kfree the uninitialized pointer f->target
and then BUG_ON. So move the initialization from jffs2_init_inode_info()
to jffs2_alloc_inode().

The stack likes following:
[19700101000004]kernel BUG at mm/slub.c:3824!
[19700101000004]Internal error: Oops - BUG: 0 [#1] SMP ARM
[19700101000004]CPU: 2 PID: 9 Comm: rcuos/0 Tainted: P O 4.4.185 #1
[19700101000004]PC is at kfree+0xfc/0x264
[19700101000004]LR is at jffs2_i_callback+0x10/0x28 [jffs2]
......
[20191219102226][<ffffff80083630a4>] kfree+0xd4/0x2ac
[20191219102226][<ffffff80008a0ae4>] jffs2_i_callback+0x24/0x40 [jffs2]
[20191219102226][<ffffff800828a908>] rcu_process_callbacks+0x524/0x61c
[20191219102226][<ffffff8008229cf8>] __do_softirq+0x1e0/0x3bc
[20191219102226][<ffffff800822a19c>] irq_exit+0xa0/0x124
[20191219102226][<ffffff800825074c>] msa_irq_exit+0x138/0x1c4
[20191219102226][<ffffff800827aaf8>] __handle_domain_irq+0xf0/0x1a4
[20191219102226][<ffffff8008200944>] gic_handle_irq+0xac/0x140

Reported-by: Guohua Zhong <zhongguohua1@huawei.com>
Signed-off-by: Huaijie Yi <yihuaijie@huawei.com>
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Signed-off-by: chenjie <chenjie6@huawei.com>
Signed-off-by: fangxinwei <fangxinwei@huawei.com>
---
 fs/jffs2/os-linux.h | 1 -
 fs/jffs2/super.c    | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jffs2/os-linux.h b/fs/jffs2/os-linux.h
index ef1cfa61549e..625c4da3246d 100644
--- a/fs/jffs2/os-linux.h
+++ b/fs/jffs2/os-linux.h
@@ -54,7 +54,6 @@ static inline void jffs2_init_inode_info(struct jffs2_inode_info *f)
 	f->fragtree = RB_ROOT;
 	f->metadata = NULL;
 	f->dents = NULL;
-	f->target = NULL;
 	f->flags = 0;
 	f->usercompr = 0;
 }
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 0e6406c4f362..d76ed98057a1 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -42,6 +42,8 @@ static struct inode *jffs2_alloc_inode(struct super_block *sb)
 	f = kmem_cache_alloc(jffs2_inode_cachep, GFP_KERNEL);
 	if (!f)
 		return NULL;
+	f->target = NULL;
+
 	return &f->vfs_inode;
 }
 
-- 
2.12.3


