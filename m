Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0B5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EF72087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbfCYJPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:15:48 -0400
Received: from www62.your-server.de ([213.133.104.62]:36888 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730076AbfCYJPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:15:47 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h8Lhm-0003Zi-55; Mon, 25 Mar 2019 10:15:42 +0100
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h8Lhl-000PoA-U8; Mon, 25 Mar 2019 10:15:42 +0100
Subject: Re: KASAN: use-after-free Read in path_lookupat
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <0000000000006946d2057bbd0eef@google.com>
 <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
 <20190325045744.GK2217@ZenIV.linux.org.uk>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <717eaff9-1f49-28f3-bbb6-c8f14ebbe03b@iogearbox.net>
Date:   Mon, 25 Mar 2019 10:15:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190325045744.GK2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25399/Mon Mar 25 08:46:48 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al, hi Linus,

On 03/25/2019 05:57 AM, Al Viro wrote:
> On Sun, Mar 24, 2019 at 06:23:24PM -0700, Linus Torvalds wrote:
> 
>> Al, comments? At the very least, if we don't make
>> simple_symlink_inode_operations() do that, we should have a *big*
>> comment that if it's not part of the inode data, it needs to be
>> RCU-delayed.
> 
> simple_symlink_inode_operations is red herring here - what matters
> is ->i_link being set; those have ->get_link == simple_get_link,
> but note that it is *not* called:
>         res = inode->i_link;
>         if (!res) {
>                 const char * (*get)(struct dentry *, struct inode *,
>                                 struct delayed_call *);
>                 get = inode->i_op->get_link;
>                 if (nd->flags & LOOKUP_RCU) {
>                         res = get(NULL, inode, &last->done);
>                         if (res == ERR_PTR(-ECHILD)) {
>                                 if (unlikely(unlazy_walk(nd)))
>                                         return ERR_PTR(-ECHILD);
>                                 res = get(dentry, inode, &last->done);
>                         }
>                 } else {
>                         res = get(dentry, inode, &last->done);
>                 }
>                 if (IS_ERR_OR_NULL(res))
>                         return res;
> 	}
> for traversal and similar for readlink(2).  And we certainly don't want
> to allocate copies in those cases - it would fuck RCU traversals for
> all fast symlinks (i.e. for the majority of symlinks out there).
> 
> Actual situation:
> 
> * shmem, erofs: OK, kfree() from the thing ->destroy_inode() is calling via
> call_rcu().
> * befs, ext2, ext4, freevxfs, jfs, orangefs, ufs: OK, coallocated with inode
> * debugfs: broken
> * jffs2: broken, freeing of f->target should be moved to jffs2_i_callback().
> * ubifs: broken, ought to move kfree(ui->data); from ubifs_destroy_inode() to
> ubifs_i_callback()
> * ceph: broken, needs to move kfree(ci->symlink) from ceph_destroy_inode()
> to ceph_i_callback().
> * bpf: broken
> 
> So we have 5 broken cases, all with the same kind of fix: move freeing
> into the RCU-delayed part of ->destroy_inode(); for debugfs and bpf
> that requires adding ->alloc_inode()/->destroy_inode(), rather than
> relying upon the defaults from fs/inode.c

I believe I copied that logic from one of the other fs'es back then, sigh.
Thanks for the analysis and hints for fixing. Would the below (only compile
tested for now) look reasonable to you? I believe there is no other way
around than to add our own inode cache, but so be it. The freeing of the
i_link is then RCU-deferred in bpf_destroy_inode_deferred():

 kernel/bpf/inode.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 2ada5e2..69fcaf6 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -80,6 +80,47 @@ static const struct inode_operations bpf_dir_iops;
 static const struct inode_operations bpf_prog_iops = { };
 static const struct inode_operations bpf_map_iops  = { };

+static struct kmem_cache *bpf_inode_cache __read_mostly;
+
+struct inode *bpf_alloc_inode(struct super_block *sb)
+{
+	return kmem_cache_alloc(bpf_inode_cache, GFP_KERNEL);
+}
+
+static void bpf_destroy_inode_deferred(struct rcu_head *head)
+{
+	struct inode *inode = container_of(head, struct inode, i_rcu);
+
+	if (S_ISLNK(inode->i_mode))
+		kfree(inode->i_link);
+	kmem_cache_free(bpf_inode_cache, inode);
+}
+
+static void bpf_destroy_inode(struct inode *inode)
+{
+	call_rcu(&inode->i_rcu, bpf_destroy_inode_deferred);
+}
+
+static void bpf_inode_init_once(void *inode)
+{
+	inode_init_once(inode);
+}
+
+static int bpf_init_inode_cache(void)
+{
+	bpf_inode_cache = kmem_cache_create("bpf_inode_cache",
+					    sizeof(struct inode), 0,
+					    (SLAB_RECLAIM_ACCOUNT|
+					     SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+					    bpf_inode_init_once);
+	return !bpf_inode_cache ? -ENOMEM : 0;
+}
+
+static void bpf_destroy_inode_cache(void)
+{
+	kmem_cache_destroy(bpf_inode_cache);
+}
+
 static struct inode *bpf_get_inode(struct super_block *sb,
 				   const struct inode *dir,
 				   umode_t mode)
@@ -561,8 +602,6 @@ static void bpf_evict_inode(struct inode *inode)
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);

-	if (S_ISLNK(inode->i_mode))
-		kfree(inode->i_link);
 	if (!bpf_inode_type(inode, &type))
 		bpf_any_put(inode->i_private, type);
 }
@@ -580,6 +619,8 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
 }

 static const struct super_operations bpf_super_ops = {
+	.alloc_inode	= bpf_alloc_inode,
+	.destroy_inode	= bpf_destroy_inode,
 	.statfs		= simple_statfs,
 	.drop_inode	= generic_delete_inode,
 	.show_options	= bpf_show_options,
@@ -671,13 +712,19 @@ static int __init bpf_init(void)
 {
 	int ret;

-	ret = sysfs_create_mount_point(fs_kobj, "bpf");
+	ret = bpf_init_inode_cache();
 	if (ret)
 		return ret;
-
+	ret = sysfs_create_mount_point(fs_kobj, "bpf");
+	if (ret) {
+		bpf_destroy_inode_cache();
+		return ret;
+	}
 	ret = register_filesystem(&bpf_fs_type);
-	if (ret)
+	if (ret) {
 		sysfs_remove_mount_point(fs_kobj, "bpf");
+		bpf_destroy_inode_cache();
+	}

 	return ret;
 }
-- 
2.9.5

>> Or maybe we could add a final inode callback function for "rcu_free"
>> that is called as the RCU-delayed freeing of the inode itself happens?
>> And then people could hook into that for freeing the inode->i_link
>> data.
> 
> You mean, split ->destroy_inode() into immediate and RCU-delayed parts?
> There are filesystems where both parts are non-empty - we can't just
> switch all ->destroy_inode() work to call_rcu().
> 
>> So many choices.. But the current situation seems unnecessarily
>> complex for the filesystem, and isn't really documented.
>>
>> Our documentation currently says for get_link(): "If the body won't go
>> away until the inode is gone, nothing else is needed", which is wrong
>> (or at least very misleading, since the last "inode is gone" callback
>> we have is that evict() function).
> 
> s/inode is gone/struct inode is freed/, but it's obviously not clear
> enough.
> 

