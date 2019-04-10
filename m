Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8946C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BAB2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JRxLc9Jk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbfDJLkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:40:31 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42636 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfDJLka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:40:30 -0400
Received: by mail-io1-f68.google.com with SMTP id c4so1777689ioh.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 04:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=saLNc2eThVWkvcpFDpNOP6/0KhgjnL/9KNU1VUHIxgM=;
        b=JRxLc9Jk5jxMJscZ8JhzjWDc5FQCZcuypnGXm86tK+wTQvkYiGERa3mj7qmwJo9mMS
         fAYIp2IKDBsmGpt6ixKJ6jCZwLcSn/5tpGTKhnpnKLQQerl1KhOsO1XpY9GXl3qqEOnU
         KpoFUmVjHRDT+n7nP75BCfsZ9ukq3RztWGu8LPpbCJl3XH3OH7jFkDkVQS81c9oZSq9Z
         6kf1dUDYn6S/C6RqzjPUKDMBVjWMrFls/dAEsAp+DNuBdmQsZtzbbYDzM7E8Hot9Z/Di
         LwMFk/KBOkGtwVNqVpelz6mFrgNxx4aKLojgpqRJ7lDBumOHDFdm6LyeWc5EZKePAzJi
         J9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=saLNc2eThVWkvcpFDpNOP6/0KhgjnL/9KNU1VUHIxgM=;
        b=NjbxQsCLgegJuddOqqgXo2keCfMV4Yz9lYlbjcv6E6/Fc3WevPw9GiGnc9s/YQXURR
         dvkZC1s1hgOJBuppFGYnBcj4Pjdv4ZKOf9UBuYbt4KqfMN/bhDXGlb9fo1mir1+mcsUq
         FH+crOCa0FcgcFrKpnIfxhzkXMzCOnDW+fdKKtfu/qsF6alQ2a6UoCZz/oU6Hlt0k++K
         Bar+SM5AAi3syi0Xs6/HAWioxhFc3sYVEvcrlAk5ngVgRPj0fhm1aDHmv+zt6ettYxXJ
         ebcu3lxCfAR87NSuzfirGzcbuE39vil/VxMgnb+HpQ4L+9N2MmUi70lq/T+tK/3yf/i5
         l2oQ==
X-Gm-Message-State: APjAAAWDwzq+4MSRMvPW3aDge6em6xxLJ4Op7ENJC756T2w/YTMOa1tC
        YWJ3Soi/aYO3Ira5YJGjuq39QhC6vlDDeIivDu5a+w==
X-Google-Smtp-Source: APXvYqw4II+L0oaW9IKzCwTYss5fK2OhUkZq3RhfKkhmqDKNRUOB0PQtZQcc4ISwr0Am1fWBp4P/gLW5d58X/BTV1us=
X-Received: by 2002:a5e:d80e:: with SMTP id l14mr27662016iok.227.1554896429278;
 Wed, 10 Apr 2019 04:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000051e9c2057d31a563@google.com> <00000000000036a4a9058619dff3@google.com>
 <20190410002603.GS2217@ZenIV.linux.org.uk> <CACT4Y+YurDDxvvd2MbOf8pGyA0B+W_EFB34oVAcHXyv-ApKC7Q@mail.gmail.com>
 <eb223b47641df91a56fd200188a65d2c0ca4abe1.camel@themaw.net>
In-Reply-To: <eb223b47641df91a56fd200188a65d2c0ca4abe1.camel@themaw.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Apr 2019 13:40:18 +0200
Message-ID: <CACT4Y+YdaDdDbRvQZzvqbPofMD6F9cPtGFzcW+db-etJayfaJw@mail.gmail.com>
Subject: Re: kernel BUG at fs/inode.c:LINE!
To:     Ian Kent <raven@themaw.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 12:35 PM Ian Kent <raven@themaw.net> wrote:
>
> On Wed, 2019-04-10 at 10:27 +0200, Dmitry Vyukov wrote:
> > On Wed, Apr 10, 2019 at 2:26 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Tue, Apr 09, 2019 at 07:36:00AM -0700, syzbot wrote:
> > > > Bisection is inconclusive: the first bad commit could be any of:
> > >
> > > [snip the useless pile]
> > >
> > > > bisection log:
> > > > https://syzkaller.appspot.com/x/bisect.txt?x=15e1fc2b200000
> > > > start commit:   [unknown
> > > > git tree:       linux-next
> > > > dashboard link:
> > > > https://syzkaller.appspot.com/bug?extid=5399ed0832693e29f392
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101032b3400000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16534063400000
> > > >
> > > > For information about bisection process see:
> > > > https://goo.gl/tpsmEJ#bisection
> > >
> > > If I'm not misreading the "crash report" there, it has injected an
> > > allocation
> > > failure in dentry allocation in d_make_root() from autofs_fill_super() (
> > >         root_inode = autofs_get_inode(s, S_IFDIR | 0755);
> > >         root = d_make_root(root_inode);
> > > ) which has triggered iput() on the inode passed to d_make_root() (as it
> > > ought
> > > to).  At which point it stepped into some BUG_ON() in fs/inode.c, but I've
> > > no idea which one it is - line numbers do not match anything in linux-next
> > > or in mainline.  Reported line 1566 is
> > >                 if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
> > > in all of them; as the matter of fact, the diff in fs/inode.c between
> > > -next and mainline is empty.
> > >
> > > There is a BUG_ON() several lines prior, and in 4.20 it used to be line
> > > 1566,
> > > so _probably_ that's what it is.  With that assumption, it's
> > >         BUG_ON(inode->i_state & I_CLEAR);
> > > IOW, we'd got I_CLEAR in the inode passed to d_make_root() there.  Which
> > > should not happen - the inode must have come from new_inode(), which
> > > gets it from new_inode_pseudo(), which zeroes ->i_state.  And I_CLEAR
> > > is set only in clear_inode().  For autofs inodes that can come only
> > > from autofs_evict_inode(), called as ->evict() from evict_inode().
> > > Which should never ever be called for inode with positive ->i_count...
> > >
> > > It might be memory corruption; it might be a dangling inode pointer
> > > somewhere, it might be something else.
> > >
> > > To get any further we really need a confirmation of the identity of
> > > triggered BUG_ON().
> > >
> > > As an aside, your "sample crash reports" would've been much more useful if
> > > they went with commit SHA1 in question, especially when they contain line
> > > numbers.
> >
> > Hi Al,
> >
> > This is the commit for matching lines:
> >
> > > HEAD commit:    d14b746c6c1c Add linux-next specific files for 20181214
>
> Are you sure?
> what does 20181214 mean?

Yes, I just copy-pasted from the report. "d14b746c6c1c" is the commit
hash. "Add linux-next specific files for 20181214" is the commit
subject.


> Looking at current next code (and several branches) it doesn't
> appear the problem is possible?
>
> > > git tree:       linux-next
>
> But which branch is it really, master (which doesn't match the
> line numbers btw)?

This is d14b746c6c1c commit hash. I don't know if there is a branch
with HEAD pointing to this commit or not, but it seems unimportant.
Tree+commit is the identity of code state.


> > fs/inode.c:1566 points to:
> >
> > void iput(struct inode *inode)
> > {
> >     ...
> >     BUG_ON(inode->i_state & I_CLEAR);
> >
> >
> > The dashboard page provides kernel git repository and commit for each crash.
>
> Those links don't seem to make sense to me ...
>
> Help me out here!

There is git repo name provided and commit hash. It's meant to be
self-explanatory. What exactly is unclear?
