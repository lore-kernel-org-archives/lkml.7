Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DABC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 04:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1249420823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 04:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfCZEPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 00:15:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60142 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfCZEPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 00:15:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h8dUU-0007gH-6R; Tue, 26 Mar 2019 04:15:10 +0000
Date:   Tue, 26 Mar 2019 04:15:10 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mark Fasheh <mark@fasheh.com>
Cc:     Dave Chinner <david@fromorbit.com>,
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
Message-ID: <20190326041509.GZ2217@ZenIV.linux.org.uk>
References: <0000000000006946d2057bbd0eef@google.com>
 <CAHk-=wiijJMTw=nTj_ED+YWMCrvHzh3ezfVYRxvzcW6+trgyPA@mail.gmail.com>
 <20190325045744.GK2217@ZenIV.linux.org.uk>
 <CAHk-=wg4iJsMHBzK52WzP+5_92HbwvX_vh_s4mMUuN0FJGdM5A@mail.gmail.com>
 <20190325194332.GO2217@ZenIV.linux.org.uk>
 <20190325224823.GF26298@dastard>
 <20190325230211.GR2217@ZenIV.linux.org.uk>
 <CAGe7X7mb=gK7zhSwmT_6mmmkcbjhZAOb=wj31BdUcHkNUPsm2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGe7X7mb=gK7zhSwmT_6mmmkcbjhZAOb=wj31BdUcHkNUPsm2Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 08:18:25PM -0700, Mark Fasheh wrote:

> Hey Al,
> 
> It's been a while since I've looked at that bit of code but it looks like
> Ocfs2 is syncing the inode to disk and disposing of it's memory
> representation (which would include the cluster locks held) so that other
> nodes get a chance to delete the potentially orphaned inode. In Ocfs2 we
> won't delete an inode if it exists in another nodes cache.

Wait a sec - what's the reason for forcing that write_inode_now(); why
doesn't the normal mechanism work?  I'm afraid I still don't get it -
we do wait for writeback in evict_inode(), or the local filesystems
wouldn't work.
