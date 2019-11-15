Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B267C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 03:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44007206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 03:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfKODUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 22:20:42 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6673 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727192AbfKODUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 22:20:40 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 34467167B78BBFEC3706;
        Fri, 15 Nov 2019 11:20:38 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 15 Nov 2019
 11:20:30 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <viro@zeniv.linux.org.uk>, <rostedt@goodmis.org>,
        <oleg@redhat.com>, <mchehab+samsung@kernel.org>, <corbet@lwn.net>,
        <tytso@mit.edu>, <jmorris@namei.org>
CC:     <yukuai3@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>, <chenxiang66@hisilicon.com>,
        <xiexiuqi@huawei.com>
Subject: [PATCH 3/3] debugfs: fix potential infinite loop in debugfs_remove_recursive
Date:   Fri, 15 Nov 2019 11:27:52 +0800
Message-ID: <1573788472-87426-4-git-send-email-yukuai3@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573788472-87426-1-git-send-email-yukuai3@huawei.com>
References: <1573788472-87426-1-git-send-email-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_remove_recursive uses list_empty to judge weather a dentry has
any subdentry or not. This can lead to infinite loop when any subdir is
in use.

The problem was discoverd by the following steps in the console.
1. use debugfs_create_dir to create a dir and multiple subdirs(insmod);
2. cd to the subdir with depth not less than 2;
3. call debugfs_remove_recursive(rmmod).

After removing the subdir, the infinite loop is triggered because
debugfs_remove_recursive uses list_empty to judge if the current dir
doesn't have any subdentry. However list_empty can't skip the subdentry
that is not simple_positive(simple_positive() will return false).

Fix the problem by using simple_empty instead of list_empty.

Fixes: 776164c1faac ('debugfs: debugfs_remove_recursive() must not rely
on list_empty(d_subdirs)')
Reported-by: chenxiang66@hisilicon.com

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 fs/debugfs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 7b975db..d64608276 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -773,8 +773,11 @@ void debugfs_remove_recursive(struct dentry *dentry)
 		if (!simple_positive(child))
 			continue;
 
-		/* perhaps simple_empty(child) makes more sense */
-		if (!list_empty(&child->d_subdirs)) {
+		/*
+		 * use simple_empty to prevent infinite loop when any
+		 * subdentry of child is in use
+		 */
+		if (!simple_empty(child)) {
 			spin_unlock(&parent->d_lock);
 			inode_unlock(d_inode(parent));
 			parent = child;
-- 
2.7.4

