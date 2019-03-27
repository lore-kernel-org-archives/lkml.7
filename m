Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC68C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D5C2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfC0Q6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:58:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:54192 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727454AbfC0Q6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 12:58:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44D1EAFAC;
        Wed, 27 Mar 2019 16:58:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 806EA1E1589; Wed, 27 Mar 2019 17:58:31 +0100 (CET)
Date:   Wed, 27 Mar 2019 17:58:31 +0100
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Mark Fasheh <mark@fasheh.com>, Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+7a8ba368b47fdefca61e@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jan Kara <jack@suse.cz>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Joel Becker <jlbec@evilplan.org>
Subject: Re: KASAN: use-after-free Read in path_lookupat
Message-ID: <20190327165831.GB6742@quack2.suse.cz>
References: <0000000000006946d2057bbd0eef@google.com>
 <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
 <20190325045744.GK2217@ZenIV.linux.org.uk>
 <CAHk-=wg4iJsMHBzK52WzP+5_92HbwvX_vh_s4mMUuN0FJGdM5A@mail.gmail.com>
 <20190325194332.GO2217@ZenIV.linux.org.uk>
 <20190325224823.GF26298@dastard>
 <20190325230211.GR2217@ZenIV.linux.org.uk>
 <CAGe7X7mb=gK7zhSwmT_6mmmkcbjhZAOb=wj31BdUcHkNUPsm2Q@mail.gmail.com>
 <20190326041509.GZ2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326041509.GZ2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-03-19 04:15:10, Al Viro wrote:
> On Mon, Mar 25, 2019 at 08:18:25PM -0700, Mark Fasheh wrote:
> 
> > Hey Al,
> > 
> > It's been a while since I've looked at that bit of code but it looks like
> > Ocfs2 is syncing the inode to disk and disposing of it's memory
> > representation (which would include the cluster locks held) so that other
> > nodes get a chance to delete the potentially orphaned inode. In Ocfs2 we
> > won't delete an inode if it exists in another nodes cache.
> 
> Wait a sec - what's the reason for forcing that write_inode_now(); why
> doesn't the normal mechanism work?  I'm afraid I still don't get it -
> we do wait for writeback in evict_inode(), or the local filesystems
> wouldn't work.

I'm just guessing here but they don't want an inode cached once its last
dentry goes away (it makes cluster wide synchronization easier for them and
they do play tricks with cluster lock on dentries). There is some info in
513e2dae9422 "ocfs2: flush inode data to disk and free inode when i_count
becomes zero" which adds this ocfs2_drop_inode() implementation. So when
the last inode reference is dropped, they want to flush any dirty data to
disk and evict the inode. But AFAICT they should be fine with flushing the
inode from their ->evict_inode method. I_FREEING just stops the flusher
thread from touching the inode but explicit writeback through
write_inode_now(inode, 1) should go through just fine.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
