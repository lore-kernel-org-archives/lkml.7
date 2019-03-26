Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCFEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704B5206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbfCZBnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:43:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58700 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfCZBnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:43:42 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h8b7p-0004dB-S9; Tue, 26 Mar 2019 01:43:37 +0000
Date:   Tue, 26 Mar 2019 01:43:37 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: debugfs: fix use-after-free on symlink traversal
Message-ID: <20190326014337.GX2217@ZenIV.linux.org.uk>
References: <0000000000006946d2057bbd0eef@google.com>
 <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
 <20190325045744.GK2217@ZenIV.linux.org.uk>
 <CAHk-=wg4iJsMHBzK52WzP+5_92HbwvX_vh_s4mMUuN0FJGdM5A@mail.gmail.com>
 <CAHk-=whJ4M5FegOLvnjUtJ0+pHv4L8UNFt+9jJDhox3Ada8kwA@mail.gmail.com>
 <20190325211405.GP2217@ZenIV.linux.org.uk>
 <CAHk-=wj+-e=X9cvvNwc5+QuvBOyYT7OtZTBzy-Wg8zGrUwxSbw@mail.gmail.com>
 <20190325233731.GS2217@ZenIV.linux.org.uk>
 <20190326013858.GU2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326013858.GU2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

symlink body shouldn't be freed without an RCU delay.  Switch debugfs to
->destroy_inode() and use of call_rcu(); free both the inode and symlink
body in the callback.  Similar to solution for bpf, only here it's even
more obvious that ->evict_inode() can be dropped.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 95b5e78c22b1..f25daa207421 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -163,19 +163,24 @@ static int debugfs_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
-static void debugfs_evict_inode(struct inode *inode)
+static void debugfs_i_callback(struct rcu_head *head)
 {
-	truncate_inode_pages_final(&inode->i_data);
-	clear_inode(inode);
+	struct inode *inode = container_of(head, struct inode, i_rcu);
 	if (S_ISLNK(inode->i_mode))
 		kfree(inode->i_link);
+	free_inode_nonrcu(inode);
+}
+
+static void debugfs_destroy_inode(struct inode *inode)
+{
+	call_rcu(&inode->i_rcu, debugfs_i_callback);
 }
 
 static const struct super_operations debugfs_super_operations = {
 	.statfs		= simple_statfs,
 	.remount_fs	= debugfs_remount,
 	.show_options	= debugfs_show_options,
-	.evict_inode	= debugfs_evict_inode,
+	.destroy_inode	= debugfs_destroy_inode,
 };
 
 static void debugfs_release_dentry(struct dentry *dentry)
