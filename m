Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA89FC10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19EE20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfDJA0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:26:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:55920 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfDJA0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 20:26:10 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hE13z-0002Nr-KK; Wed, 10 Apr 2019 00:26:03 +0000
Date:   Wed, 10 Apr 2019 01:26:03 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, amir73il@gmail.com, dvyukov@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp, raven@themaw.net,
        syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at fs/inode.c:LINE!
Message-ID: <20190410002603.GS2217@ZenIV.linux.org.uk>
References: <00000000000051e9c2057d31a563@google.com>
 <00000000000036a4a9058619dff3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000036a4a9058619dff3@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 07:36:00AM -0700, syzbot wrote:
> Bisection is inconclusive: the first bad commit could be any of:

[snip the useless pile]

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e1fc2b200000
> start commit:   [unknown
> git tree:       linux-next
> dashboard link: https://syzkaller.appspot.com/bug?extid=5399ed0832693e29f392
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101032b3400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16534063400000
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If I'm not misreading the "crash report" there, it has injected an allocation
failure in dentry allocation in d_make_root() from autofs_fill_super() (
        root_inode = autofs_get_inode(s, S_IFDIR | 0755);
        root = d_make_root(root_inode);
) which has triggered iput() on the inode passed to d_make_root() (as it ought
to).  At which point it stepped into some BUG_ON() in fs/inode.c, but I've
no idea which one it is - line numbers do not match anything in linux-next
or in mainline.  Reported line 1566 is
                if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {   
in all of them; as the matter of fact, the diff in fs/inode.c between
-next and mainline is empty.

There is a BUG_ON() several lines prior, and in 4.20 it used to be line 1566,
so _probably_ that's what it is.  With that assumption, it's
	BUG_ON(inode->i_state & I_CLEAR);
IOW, we'd got I_CLEAR in the inode passed to d_make_root() there.  Which
should not happen - the inode must have come from new_inode(), which
gets it from new_inode_pseudo(), which zeroes ->i_state.  And I_CLEAR
is set only in clear_inode().  For autofs inodes that can come only
from autofs_evict_inode(), called as ->evict() from evict_inode().
Which should never ever be called for inode with positive ->i_count...

It might be memory corruption; it might be a dangling inode pointer
somewhere, it might be something else.

To get any further we really need a confirmation of the identity of
triggered BUG_ON().

As an aside, your "sample crash reports" would've been much more useful if
they went with commit SHA1 in question, especially when they contain line
numbers.
