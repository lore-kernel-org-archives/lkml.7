Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34030C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED2420896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbfCYE5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 00:57:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43772 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfCYE5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 00:57:52 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h8Hg9-0005VV-0J; Mon, 25 Mar 2019 04:57:45 +0000
Date:   Mon, 25 Mar 2019 04:57:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in path_lookupat
Message-ID: <20190325045744.GK2217@ZenIV.linux.org.uk>
References: <0000000000006946d2057bbd0eef@google.com>
 <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 06:23:24PM -0700, Linus Torvalds wrote:


> Al, comments? At the very least, if we don't make
> simple_symlink_inode_operations() do that, we should have a *big*
> comment that if it's not part of the inode data, it needs to be
> RCU-delayed.

simple_symlink_inode_operations is red herring here - what matters
is ->i_link being set; those have ->get_link == simple_get_link,
but note that it is *not* called:
        res = inode->i_link;
        if (!res) {
                const char * (*get)(struct dentry *, struct inode *,
                                struct delayed_call *);
                get = inode->i_op->get_link;
                if (nd->flags & LOOKUP_RCU) {
                        res = get(NULL, inode, &last->done);
                        if (res == ERR_PTR(-ECHILD)) {
                                if (unlikely(unlazy_walk(nd)))
                                        return ERR_PTR(-ECHILD);
                                res = get(dentry, inode, &last->done);
                        }
                } else {
                        res = get(dentry, inode, &last->done);
                }
                if (IS_ERR_OR_NULL(res))
                        return res;
	}
for traversal and similar for readlink(2).  And we certainly don't want
to allocate copies in those cases - it would fuck RCU traversals for
all fast symlinks (i.e. for the majority of symlinks out there).

Actual situation:

* shmem, erofs: OK, kfree() from the thing ->destroy_inode() is calling via
call_rcu().
* befs, ext2, ext4, freevxfs, jfs, orangefs, ufs: OK, coallocated with inode
* debugfs: broken
* jffs2: broken, freeing of f->target should be moved to jffs2_i_callback().
* ubifs: broken, ought to move kfree(ui->data); from ubifs_destroy_inode() to
ubifs_i_callback()
* ceph: broken, needs to move kfree(ci->symlink) from ceph_destroy_inode()
to ceph_i_callback().
* bpf: broken

So we have 5 broken cases, all with the same kind of fix: move freeing
into the RCU-delayed part of ->destroy_inode(); for debugfs and bpf
that requires adding ->alloc_inode()/->destroy_inode(), rather than
relying upon the defaults from fs/inode.c

> Or maybe we could add a final inode callback function for "rcu_free"
> that is called as the RCU-delayed freeing of the inode itself happens?
> And then people could hook into that for freeing the inode->i_link
> data.

You mean, split ->destroy_inode() into immediate and RCU-delayed parts?
There are filesystems where both parts are non-empty - we can't just
switch all ->destroy_inode() work to call_rcu().

> So many choices.. But the current situation seems unnecessarily
> complex for the filesystem, and isn't really documented.
> 
> Our documentation currently says for get_link(): "If the body won't go
> away until the inode is gone, nothing else is needed", which is wrong
> (or at least very misleading, since the last "inode is gone" callback
> we have is that evict() function).

s/inode is gone/struct inode is freed/, but it's obviously not clear
enough.
