Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0378C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7E720657
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbfCYWFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:05:00 -0400
Received: from www62.your-server.de ([213.133.104.62]:50782 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCYWFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:05:00 -0400
Received: from [88.198.220.132] (helo=sslproxy03.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h8XiA-0001hx-9N; Mon, 25 Mar 2019 23:04:54 +0100
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h8XiA-0003yB-1z; Mon, 25 Mar 2019 23:04:54 +0100
Subject: Re: KASAN: use-after-free Read in path_lookupat
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <0000000000006946d2057bbd0eef@google.com>
 <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
 <20190325045744.GK2217@ZenIV.linux.org.uk>
 <CAHk-=wg4iJsMHBzK52WzP+5_92HbwvX_vh_s4mMUuN0FJGdM5A@mail.gmail.com>
 <CAHk-=whJ4M5FegOLvnjUtJ0+pHv4L8UNFt+9jJDhox3Ada8kwA@mail.gmail.com>
 <20190325211405.GP2217@ZenIV.linux.org.uk>
 <CAHk-=wj+-e=X9cvvNwc5+QuvBOyYT7OtZTBzy-Wg8zGrUwxSbw@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f4eccb87-1ea2-c0d5-19db-d638f2c5aa57@iogearbox.net>
Date:   Mon, 25 Mar 2019 23:04:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wj+-e=X9cvvNwc5+QuvBOyYT7OtZTBzy-Wg8zGrUwxSbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25399/Mon Mar 25 08:46:48 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/25/2019 10:45 PM, Linus Torvalds wrote:
> On Mon, Mar 25, 2019 at 2:14 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>
>> Maybe, but we really need to come up with sane documentation on the
>> entire drop_inode/evict_inode/destroy_inode/rcu_destroy_inode
>> group ;-/
> 
> Yeah.
> 
> I actually think the "destroy_inode/rcu_destroy_inode" part is the
> simplest one to understand: it's just tearing down the inode, and the
> RCU part is (obviously, as shown by this thread) somewhat subtle, but
> at the same time not really all that hard to explain: "inodes that can
> be looked up through RCU lookup need to be destroyed with RCU delay".
> 
> I think drop_inode->evict_inode is arguably the much more subtle
> stuff. That's the "we're not destroying things, we're making decisions
> about the state" kind of thing.
> 
> And we actually don't have any documentation at all for those two.
> Well, there's the "porting" thing, but..
> 
>> And I want to understand the writeback-related issues
>> in ocfs2 and f2fs - the current kludges in those smell fishy.
> 
> I'm assuming you're talking about exactly that drop_inode() kind of subtlety.
> 
> At least for ocfs2, the whole "rcu_destroy_inode()" patch I sent out
> would simplify things a lot. *All* that the ocfs2_destroy_inode()
> function does is to schedule the inode freeing for RCU delay.
> 
> Assuming my patch is fine (as mentioned, it was entirely untested),
> that patch would actually simplify that a lot. Get rid of
> ocfs2_destroy_inode() entirely, and just make
> ocfs2_rcu_destroy_inode() do that kmem_cache_free(). Mucho clean-up
> (we have that ocfs2_rcu_destroy_inode() currently as
> ocfs2_i_callback(), but with the ugly rcu-head interface).
> 
>>>       if (unlikely(inode_init_always(sb, inode))) {
>>> -             if (inode->i_sb->s_op->destroy_inode)
>>> +             if (inode->i_sb->s_op->destroy_inode) {
>>>                       inode->i_sb->s_op->destroy_inode(inode);
>>> -             else
>>> +                     if (!inode->i_sb->s_op->rcu_destroy_inode)
>>> +                             return NULL;
>>> +             }
>>> +             if (!inode->i_sb->s_op->rcu_destroy_inode ||
>>> +                 !inode->i_sb->s_op->rcu_destroy_inode(inode))
>>>                       kmem_cache_free(inode_cachep, inode);
>>
>> ITYM  i_callback(inode); here, possibly suitably renamed.
> 
> Yeah, I guess we could just call that i_callback() directly. I wrote
> it that way because it was how the code was organized (it didn't call
> i_callback() before either), but yes, it woudl avoid some duplicate
> code to do it that way.
> 
> And yes, at that point we'd probably want to rename it too.
> 
> On the whole, looking at a few filesystems, I really think that
> 'rcu_destroy_inode()" would simplify several of them.  That ocfs2 case
> I already mentioned, but looking around the exact same is trye in
> v9fs, vxfs, dlmfs, hostfs, bfs, coda, fatfs, isofs, minix, nfs,
> openprom, proc, qnx4, qnx6, sysv, befs, adfs, affs, efs, ext2, f2fs,
> gfs2, hfs, hfsplus, hpfs, jffs2, nilfs, reiserfs, romfs, squashfs)
> 
> And in other filesystems that actually *do* have a real
> destroy_inode() that does other things too, they still want the rcu
> delayed part as well (eg btrfs, ceph, fuse, hugetlbfs, afs, ecryptfs,
> ext4, jfs, organgefs, ovl, ubifs).
> 
> In fact, every single filesystem I looked at (and I looked at most)
> would be simplified by that patch.
> 
> And for some it would make it easier to fix bugs in the process (ie
> bpf) because they don't currently have that rcu delay and they need
> it.

I'm fine either way, I think the rcu_destroy_inode would indeed simplify
it nicely. In any case fwiw, here's what I'd have ready for standby on bpf
side and tested as well. Decided to get rid of bpf_evict_inode() entirely
since the only callback we'd really need is on final inode destruction:

From fc2111c4ebb487b630a423752c0f23b5f2535a55 Mon Sep 17 00:00:00 2001
From: Daniel Borkmann <daniel@iogearbox.net>
Date: Mon, 25 Mar 2019 15:54:43 +0100
Subject: [PATCH bpf] bpf: fix use after free in bpf_evict_inode

syzkaller was able to generate the following UAF in bpf:

  BUG: KASAN: use-after-free in lookup_last fs/namei.c:2269 [inline]
  BUG: KASAN: use-after-free in path_lookupat.isra.43+0x9f8/0xc00 fs/namei.c:2318
  Read of size 1 at addr ffff8801c4865c47 by task syz-executor2/9423

  CPU: 0 PID: 9423 Comm: syz-executor2 Not tainted 4.20.0-rc1-next-20181109+
  #110
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
  Google 01/01/2011
  Call Trace:
    __dump_stack lib/dump_stack.c:77 [inline]
    dump_stack+0x244/0x39d lib/dump_stack.c:113
    print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
    kasan_report_error mm/kasan/report.c:354 [inline]
    kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
    __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
    lookup_last fs/namei.c:2269 [inline]
    path_lookupat.isra.43+0x9f8/0xc00 fs/namei.c:2318
    filename_lookup+0x26a/0x520 fs/namei.c:2348
    user_path_at_empty+0x40/0x50 fs/namei.c:2608
    user_path include/linux/namei.h:62 [inline]
    do_mount+0x180/0x1ff0 fs/namespace.c:2980
    ksys_mount+0x12d/0x140 fs/namespace.c:3258
    __do_sys_mount fs/namespace.c:3272 [inline]
    __se_sys_mount fs/namespace.c:3269 [inline]
    __x64_sys_mount+0xbe/0x150 fs/namespace.c:3269
    do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
    entry_SYSCALL_64_after_hwframe+0x49/0xbe
  RIP: 0033:0x457569
  Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
  48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
  ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
  RSP: 002b:00007fde6ed96c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
  RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000457569
  RDX: 0000000020000040 RSI: 0000000020000000 RDI: 0000000000000000
  RBP: 000000000072bf00 R08: 0000000020000340 R09: 0000000000000000
  R10: 0000000000200000 R11: 0000000000000246 R12: 00007fde6ed976d4
  R13: 00000000004c2c24 R14: 00000000004d4990 R15: 00000000ffffffff

  Allocated by task 9424:
    save_stack+0x43/0xd0 mm/kasan/kasan.c:448
    set_track mm/kasan/kasan.c:460 [inline]
    kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
    __do_kmalloc mm/slab.c:3722 [inline]
    __kmalloc_track_caller+0x157/0x760 mm/slab.c:3737
    kstrdup+0x39/0x70 mm/util.c:49
    bpf_symlink+0x26/0x140 kernel/bpf/inode.c:356
    vfs_symlink+0x37a/0x5d0 fs/namei.c:4127
    do_symlinkat+0x242/0x2d0 fs/namei.c:4154
    __do_sys_symlink fs/namei.c:4173 [inline]
    __se_sys_symlink fs/namei.c:4171 [inline]
    __x64_sys_symlink+0x59/0x80 fs/namei.c:4171
    do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
    entry_SYSCALL_64_after_hwframe+0x49/0xbe

  Freed by task 9425:
    save_stack+0x43/0xd0 mm/kasan/kasan.c:448
    set_track mm/kasan/kasan.c:460 [inline]
    __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
    kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
    __cache_free mm/slab.c:3498 [inline]
    kfree+0xcf/0x230 mm/slab.c:3817
    bpf_evict_inode+0x11f/0x150 kernel/bpf/inode.c:565
    evict+0x4b9/0x980 fs/inode.c:558
    iput_final fs/inode.c:1550 [inline]
    iput+0x674/0xa90 fs/inode.c:1576
    do_unlinkat+0x733/0xa30 fs/namei.c:4069
    __do_sys_unlink fs/namei.c:4110 [inline]
    __se_sys_unlink fs/namei.c:4108 [inline]
    __x64_sys_unlink+0x42/0x50 fs/namei.c:4108
    do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
    entry_SYSCALL_64_after_hwframe+0x49/0xbe

In this scenario path lookup under RCU is racing with the final
unlink in case of symlinks. As Linus puts it in his analysis:

  [...] We actually RCU-delay the inode freeing itself, but
  when we do the final iput(), the "evict()" function is called
  synchronously. Now, the simple fix would seem to just RCU-delay
  the kfree() of the symlink data in bpf_evict_inode(). Maybe
  that's the right thing to do. [...]

Al suggested to piggy-back on the ->destroy_inode() callback in
order to implement RCU deferral there which can then kfree() the
inode->i_link eventually right before putting inode back into
inode cache. By reusing free_inode_nonrcu() from there we can
avoid the need for our own inode cache and just reuse generic
one as we currently do.

And in-fact on top of all this we should just get rid of the
bpf_evict_inode() entirely. This means truncate_inode_pages_final()
and clear_inode() will then simply be called by the fs core via
evict(). Dropping the reference should really only be done when
inode is unhashed and nothing reachable anymore, so it's better
also moved into the final ->destroy_inode() callback.

Fixes: 0f98621bef5d ("bpf, inode: add support for symlinks and fix mtime/ctime")
Reported-by: syzbot+fb731ca573367b7f6564@syzkaller.appspotmail.com
Reported-by: syzbot+a13e5ead792d6df37818@syzkaller.appspotmail.com
Reported-by: syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Analyzed-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/lkml/0000000000006946d2057bbd0eef@google.com/T/
---
 kernel/bpf/inode.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 2ada5e21dfa6..4a8f390a2b82 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -554,19 +554,6 @@ struct bpf_prog *bpf_prog_get_type_path(const char *name, enum bpf_prog_type typ
 }
 EXPORT_SYMBOL(bpf_prog_get_type_path);

-static void bpf_evict_inode(struct inode *inode)
-{
-	enum bpf_type type;
-
-	truncate_inode_pages_final(&inode->i_data);
-	clear_inode(inode);
-
-	if (S_ISLNK(inode->i_mode))
-		kfree(inode->i_link);
-	if (!bpf_inode_type(inode, &type))
-		bpf_any_put(inode->i_private, type);
-}
-
 /*
  * Display the mount options in /proc/mounts.
  */
@@ -579,11 +566,28 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }

+static void bpf_destroy_inode_deferred(struct rcu_head *head)
+{
+	struct inode *inode = container_of(head, struct inode, i_rcu);
+	enum bpf_type type;
+
+	if (S_ISLNK(inode->i_mode))
+		kfree(inode->i_link);
+	if (!bpf_inode_type(inode, &type))
+		bpf_any_put(inode->i_private, type);
+	free_inode_nonrcu(inode);
+}
+
+static void bpf_destroy_inode(struct inode *inode)
+{
+	call_rcu(&inode->i_rcu, bpf_destroy_inode_deferred);
+}
+
 static const struct super_operations bpf_super_ops = {
 	.statfs		= simple_statfs,
 	.drop_inode	= generic_delete_inode,
 	.show_options	= bpf_show_options,
-	.evict_inode	= bpf_evict_inode,
+	.destroy_inode	= bpf_destroy_inode,
 };

 enum {
-- 
2.17.1

