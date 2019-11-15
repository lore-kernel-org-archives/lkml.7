Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84397C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 03:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648E2206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 03:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfKODUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 22:20:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6674 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727189AbfKODUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 22:20:40 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3B8F0C2FC6BF8129BBC7;
        Fri, 15 Nov 2019 11:20:38 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 15 Nov 2019
 11:20:29 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <viro@zeniv.linux.org.uk>, <rostedt@goodmis.org>,
        <oleg@redhat.com>, <mchehab+samsung@kernel.org>, <corbet@lwn.net>,
        <tytso@mit.edu>, <jmorris@namei.org>
CC:     <yukuai3@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>, <chenxiang66@hisilicon.com>,
        <xiexiuqi@huawei.com>
Subject: [PATCH 2/3] fs/libfs.c: use 'spin_lock_nested' when taking 'd_lock' for dentry in simple_empty
Date:   Fri, 15 Nov 2019 11:27:51 +0800
Message-ID: <1573788472-87426-3-git-send-email-yukuai3@huawei.com>
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

simple_emtpty currently use 'spin_lock_nested' for 'child' to avoid
confusion for lockdep. However, it's not used for 'dentry'.

In that case, there will be a problem if the caller called 'simple_empty'
with a parent's 'd_lock' held:

spin_lock(&dentry->d_parent->d_lock)
    call simple_empty(dentry)
        spin_lock(&dentry->d_lock) --> lockdep will report this
            spin_lock_nested(child->d_lock, spin_lock_nested)
            spin_unlock(child_lock)
        spin_unlock($dentry->d_lock)
    return from simple_empty
spin_unlock(&dentry->d_patrent->d_lock)

So, use 'DENTRY_D_LOCK_NESTED' for 'dentry' and 'spin_lock_nested_2' for
child.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 fs/libfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 1463b03..62e9ba9 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -336,9 +336,9 @@ int simple_empty(struct dentry *dentry)
 	struct dentry *child;
 	int ret = 0;
 
-	spin_lock(&dentry->d_lock);
+	spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
 	list_for_each_entry(child, &dentry->d_subdirs, d_child) {
-		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
+		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED_2);
 		if (simple_positive(child)) {
 			spin_unlock(&child->d_lock);
 			goto out;
-- 
2.7.4

