Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ED8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAA520848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbfCYXhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:37:38 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57248 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfCYXhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:37:37 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h8Z9o-0001nA-8s; Mon, 25 Mar 2019 23:37:32 +0000
Date:   Mon, 25 Mar 2019 23:37:32 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in path_lookupat
Message-ID: <20190325233731.GS2217@ZenIV.linux.org.uk>
References: <0000000000006946d2057bbd0eef@google.com>
 <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
 <20190325045744.GK2217@ZenIV.linux.org.uk>
 <CAHk-=wg4iJsMHBzK52WzP+5_92HbwvX_vh_s4mMUuN0FJGdM5A@mail.gmail.com>
 <CAHk-=whJ4M5FegOLvnjUtJ0+pHv4L8UNFt+9jJDhox3Ada8kwA@mail.gmail.com>
 <20190325211405.GP2217@ZenIV.linux.org.uk>
 <CAHk-=wj+-e=X9cvvNwc5+QuvBOyYT7OtZTBzy-Wg8zGrUwxSbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj+-e=X9cvvNwc5+QuvBOyYT7OtZTBzy-Wg8zGrUwxSbw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 02:45:00PM -0700, Linus Torvalds wrote:
> On Mon, Mar 25, 2019 at 2:14 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Maybe, but we really need to come up with sane documentation on the
> > entire drop_inode/evict_inode/destroy_inode/rcu_destroy_inode
> > group ;-/
> 
> Yeah.
> 
> I actually think the "destroy_inode/rcu_destroy_inode" part is the
> simplest one to understand: it's just tearing down the inode, and the
> RCU part is (obviously, as shown by this thread) somewhat subtle, but
> at the same time not really all that hard to explain: "inodes that can
> be looked up through RCU lookup need to be destroyed with RCU delay".

... with at least "but remember that call_rcu()-scheduled stuff runs in
softirq, so there's a limit to what you can defer there; furthermore,
there are implications for any spinlocks taken in that callback".

> I think drop_inode->evict_inode is arguably the much more subtle
> stuff. That's the "we're not destroying things, we're making decisions
> about the state" kind of thing.

It's worse than that - another bloody subtle question is the location
of clear_inode() wrt the other work done in ->evict_inode() ;-/

> And we actually don't have any documentation at all for those two.
> Well, there's the "porting" thing, but..
>
> > And I want to understand the writeback-related issues
> > in ocfs2 and f2fs - the current kludges in those smell fishy.
> 
> I'm assuming you're talking about exactly that drop_inode() kind of subtlety.

Yes.

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

Sure, but I wonder if cleaner solution (if any) for whatever is going
on in their drop_inode/evict_inode area might spill into destroy_inode...

I certainly agree that having destroy_inode consist just of call_rcu()
is very common.  FWIW, non-trivial exceptions from that pattern are:

fs/afs/super.c:673:static void afs_destroy_inode(struct inode *inode)
fs/btrfs/inode.c:9215:void btrfs_destroy_inode(struct inode *inode)
fs/btrfs/inode.c:9202:void btrfs_test_destroy_inode(struct inode *inode)
fs/ceph/inode.c:530:void ceph_destroy_inode(struct inode *inode)
fs/ecryptfs/super.c:88:static void ecryptfs_destroy_inode(struct inode *inode)
fs/ext4/super.c:1106:static void ext4_destroy_inode(struct inode *inode)
fs/inode.c:228:void free_inode_nonrcu(struct inode *inode)
fs/fuse/inode.c:116:static void fuse_destroy_inode(struct inode *inode)
fs/hugetlbfs/inode.c:1052:static void hugetlbfs_destroy_inode(struct inode *inode)
fs/jfs/super.c:134:static void jfs_destroy_inode(struct inode *inode)
fs/ntfs/inode.c:341:void ntfs_destroy_big_inode(struct inode *inode)
fs/overlayfs/super.c:200:static void ovl_destroy_inode(struct inode *inode)
mm/shmem.c:3646:static void shmem_destroy_inode(struct inode *inode)
net/socket.c:266:static void sock_destroy_inode(struct inode *inode)
fs/ubifs/super.c:282:static void ubifs_destroy_inode(struct inode *inode)
fs/xfs/xfs_super.c:969:xfs_fs_destroy_inode(

Some of those could convert to that pattern, so it's even fewer than
that.  And getting rid of container_of in those callbacks would be
nice too.  One obvious observation, though - we want the actual
fixes to go before any method changes, for backporting reasons.

For debugfs it's clearly "use default ->evict_inode(), have explicit
->destroy_inode() using free_inode_nonrcu()" - there we have nothing
else done in ->evict_inode() and kfree is obviously safe in softirq.
I'll post that (or push to vfs.git#fixes), along with minimal fixes
for other 3.  If bpf_any_put() is softirq-safe, we'll have the full
set for -stable and the rest could be done on top of that.

Won't solve the documetation problem, unfortunately ;-/
