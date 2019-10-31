Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E55CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186C120862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfJaN1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:27:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38344 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbfJaN13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:27:29 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B4770349A03103BE5870;
        Thu, 31 Oct 2019 21:27:27 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 31 Oct 2019
 21:27:19 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <oleg@redhat.com>, <rostedt@goodmis.org>, <jack@suse.cz>
CC:     <linux-kernel@vger.kernel.org>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>, <chenxiang66@hisilicon.com>,
        <xiexiuqi@huawei.com>
Subject: [PATCH] debugfs: fix potential infinite loop in debugfs_remove_recursive
Date:   Thu, 31 Oct 2019 21:34:44 +0800
Message-ID: <1572528884-67565-1-git-send-email-yukuai3@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_remove_recursive uses list_empty to judge weather a dentry has
any subdentry or not. This can lead to infinite loop when any subdir is in
use.

The problem was discoverd by the following steps in the console.
1. use debugfs_create_dir to create a dir and multiple subdirs(insmod);
2. cd to the subdir with depth not less than 2;
3. call debugfs_remove_recursive(rmmod).

After removing the subdir, the infinite loop is triggered bucause
debugfs_remove_recursive uses list_empty to judge if the current dir
doesn't have any subdentry, if so, remove the current dir and which
will never happen.

Fix the problem by using simple_empty instead of list_empty.

Fixes: 776164c1faac ('debugfs: debugfs_remove_recursive() must not rely on list_empty(d_subdirs)')
Reported-by: chenxiang66@hisilicon.com
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 fs/debugfs/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 7b975db..42b28acc 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -773,8 +773,10 @@ void debugfs_remove_recursive(struct dentry *dentry)
 		if (!simple_positive(child))
 			continue;
 
-		/* perhaps simple_empty(child) makes more sense */
-		if (!list_empty(&child->d_subdirs)) {
+		/* use simple_empty to prevent infinite loop when any
+		 * subdentry of child is in use
+		 */
+		if (!simple_empty(child)) {
 			spin_unlock(&parent->d_lock);
 			inode_unlock(d_inode(parent));
 			parent = child;
-- 
2.7.4

