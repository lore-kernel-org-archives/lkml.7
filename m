Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245B6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8A020830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R/lcHZcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbfDJMkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:40:04 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52303 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729434AbfDJMkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:40:04 -0400
Received: by mail-it1-f196.google.com with SMTP id x132so3102571itf.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 05:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H7HycFV5eguHxueKTMnfEUqCK1L2jTgkP9kPDUvxAEw=;
        b=R/lcHZcOfLx9DNPLCxwsYN4o0Bg8Gc0jtQhWAsmzMEW+XHTDuWPTFQQ7oxIC8aVZtr
         Hr7J/go2re+mK4/+UBEYtmw/X9mgruHRWFwT9pOAI5/5dGhpXVxm+YVtJdi79TT0lNP/
         yVAKV9sFBjHj4hnK7t0jrRnWsDqn5YLNShgcCAUyFH57SMplA+kI3Zew8Oyoa1zuq19m
         Sowifkvt3lyDLUVchE8HVQJ2n3s1ivR595ZRs1u94IJC5DiHWW3TiGcc+4Q6g/iaNtq0
         IM7TtkKIrzzoUjKhJHORJQ5Eh9v6cIlVxyL1jsWfUug7dSFDuRKz5egmEiaPcfABFeRr
         RmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7HycFV5eguHxueKTMnfEUqCK1L2jTgkP9kPDUvxAEw=;
        b=kUexReI5bbansrEUDHW3n92qt7jy2qcIqs/dclXP26nxiXyaGLwbc1gVTxNof9c2Hq
         78pwMCr+CGEJ5fU7I2Awl4HQ2VLSdhB7IduTAxg/yODNc8w/s4vYMM0Z+CITDGEUdQLf
         yzOlSQ+pdIOJ8MPwHg+9H/XVlJvrT3b9h15Afh+qZH339paNBKyfj3CB7TujLxSaMbUh
         5gysx6v8KIqH5T7MTR8FNoqpROibRSgLGJB7b9LFqSY1Xl2uzB7qLqnm+mbzn8Xq5t1v
         JlZpQ6wj+vSTpRjYJBXAXfqoCh3PAoeSK0LVKWAxIUoTxcOFuY0ooghUfIY3mUp8hjGJ
         zFKw==
X-Gm-Message-State: APjAAAWsaboanG3jaV5JzbmucySwvblS+K7xaCrkdTErYRbbCBR4pDs+
        UhqTsZLhujDGRfCwzKGgBk2VD55lPheYt1bSLv9bdw==
X-Google-Smtp-Source: APXvYqzadXyz32hZ5VZq+as+T0Xtn2sUtu8y4hoYgRuNR81erGIYEeu0PwcmxgKxAnMPKfJQ00P4WYLVX1wTjMnRdR8=
X-Received: by 2002:a24:3d8f:: with SMTP id n137mr2870417itn.96.1554900002479;
 Wed, 10 Apr 2019 05:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000051e9c2057d31a563@google.com> <00000000000036a4a9058619dff3@google.com>
 <20190410002603.GS2217@ZenIV.linux.org.uk> <CACT4Y+YurDDxvvd2MbOf8pGyA0B+W_EFB34oVAcHXyv-ApKC7Q@mail.gmail.com>
 <eb223b47641df91a56fd200188a65d2c0ca4abe1.camel@themaw.net>
 <CACT4Y+YdaDdDbRvQZzvqbPofMD6F9cPtGFzcW+db-etJayfaJw@mail.gmail.com>
 <5c581e6eadc946b965e3138c9daffda75b1fba56.camel@themaw.net> <1f1d3b95189b6b8acfdf61dd05a804744791d313.camel@themaw.net>
In-Reply-To: <1f1d3b95189b6b8acfdf61dd05a804744791d313.camel@themaw.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Apr 2019 14:39:51 +0200
Message-ID: <CACT4Y+ZukMzwkMGRekjQmBd1OWwNyPmL=CtPnJJCmUKF=4tw6Q@mail.gmail.com>
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

On Wed, Apr 10, 2019 at 2:07 PM Ian Kent <raven@themaw.net> wrote:
>
> On Wed, 2019-04-10 at 19:57 +0800, Ian Kent wrote:
> > On Wed, 2019-04-10 at 13:40 +0200, Dmitry Vyukov wrote:
> > > On Wed, Apr 10, 2019 at 12:35 PM Ian Kent <raven@themaw.net> wrote:
> > > >
> > > > On Wed, 2019-04-10 at 10:27 +0200, Dmitry Vyukov wrote:
> > > > > On Wed, Apr 10, 2019 at 2:26 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > > > >
> > > > > > On Tue, Apr 09, 2019 at 07:36:00AM -0700, syzbot wrote:
> > > > > > > Bisection is inconclusive: the first bad commit could be any of:
> > > > > >
> > > > > > [snip the useless pile]
> > > > > >
> > > > > > > bisection log:
> > > > > > > https://syzkaller.appspot.com/x/bisect.txt?x=15e1fc2b200000
> > > > > > > start commit:   [unknown
> > > > > > > git tree:       linux-next
> > > > > > > dashboard link:
> > > > > > > https://syzkaller.appspot.com/bug?extid=5399ed0832693e29f392
> > > > > > > syz repro:
> > > > > > > https://syzkaller.appspot.com/x/repro.syz?x=101032b3400000
> > > > > > > C reproducer:
> > > > > > > https://syzkaller.appspot.com/x/repro.c?x=16534063400000
> > > > > > >
> > > > > > > For information about bisection process see:
> > > > > > > https://goo.gl/tpsmEJ#bisection
> > > > > >
> > > > > > If I'm not misreading the "crash report" there, it has injected an
> > > > > > allocation
> > > > > > failure in dentry allocation in d_make_root() from autofs_fill_super()
> > > > > > (
> > > > > >         root_inode = autofs_get_inode(s, S_IFDIR | 0755);
> > > > > >         root = d_make_root(root_inode);
> > > > > > ) which has triggered iput() on the inode passed to d_make_root() (as
> > > > > > it
> > > > > > ought
> > > > > > to).  At which point it stepped into some BUG_ON() in fs/inode.c, but
> > > > > > I've
> > > > > > no idea which one it is - line numbers do not match anything in linux-
> > > > > > next
> > > > > > or in mainline.  Reported line 1566 is
> > > > > >                 if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME))
> > > > > > {
> > > > > > in all of them; as the matter of fact, the diff in fs/inode.c between
> > > > > > -next and mainline is empty.
> > > > > >
> > > > > > There is a BUG_ON() several lines prior, and in 4.20 it used to be
> > > > > > line
> > > > > > 1566,
> > > > > > so _probably_ that's what it is.  With that assumption, it's
> > > > > >         BUG_ON(inode->i_state & I_CLEAR);
> > > > > > IOW, we'd got I_CLEAR in the inode passed to d_make_root()
> > > > > > there.  Which
> > > > > > should not happen - the inode must have come from new_inode(), which
> > > > > > gets it from new_inode_pseudo(), which zeroes ->i_state.  And I_CLEAR
> > > > > > is set only in clear_inode().  For autofs inodes that can come only
> > > > > > from autofs_evict_inode(), called as ->evict() from evict_inode().
> > > > > > Which should never ever be called for inode with positive ->i_count...
> > > > > >
> > > > > > It might be memory corruption; it might be a dangling inode pointer
> > > > > > somewhere, it might be something else.
> > > > > >
> > > > > > To get any further we really need a confirmation of the identity of
> > > > > > triggered BUG_ON().
> > > > > >
> > > > > > As an aside, your "sample crash reports" would've been much more
> > > > > > useful
> > > > > > if
> > > > > > they went with commit SHA1 in question, especially when they contain
> > > > > > line
> > > > > > numbers.
> > > > >
> > > > > Hi Al,
> > > > >
> > > > > This is the commit for matching lines:
> > > > >
> > > > > > HEAD commit:    d14b746c6c1c Add linux-next specific files for
> > > > > > 20181214
> > > >
> > > > Are you sure?
> > > > what does 20181214 mean?
> > >
> > > Yes, I just copy-pasted from the report. "d14b746c6c1c" is the commit
> > > hash. "Add linux-next specific files for 20181214" is the commit
> > > subject.
> > >
> > >
> > > > Looking at current next code (and several branches) it doesn't
> > > > appear the problem is possible?
> > > >
> > > > > > git tree:       linux-next
> > > >
> > > > But which branch is it really, master (which doesn't match the
> > > > line numbers btw)?
> > >
> > > This is d14b746c6c1c commit hash. I don't know if there is a branch
> > > with HEAD pointing to this commit or not, but it seems unimportant.
> > > Tree+commit is the identity of code state.
> > >
> > >
> > > > > fs/inode.c:1566 points to:
> > > > >
> > > > > void iput(struct inode *inode)
> > > > > {
> > > > >     ...
> > > > >     BUG_ON(inode->i_state & I_CLEAR);
> > > > >
> > > > >
> > > > > The dashboard page provides kernel git repository and commit for each
> > > > > crash.
> > > >
> > > > Those links don't seem to make sense to me ...
> > > >
> > > > Help me out here!
> > >
> > > There is git repo name provided and commit hash. It's meant to be
> > > self-explanatory. What exactly is unclear?
> >
> > I'm unable to find a branch matching the line numbers.
> >
> > Given that, on the face of it, the scenario is impossible I'm
> > seeking clarification on what linux-next to look at for the
> > sake of accuracy.
> >
> > So I'm wondering if this testing done using the master branch
> > or one of the daily branches one would use to check for conflicts
> > before posting?
>
> Sorry those are tags not branches.
>
> On a newly updated linux-next I get:
> [raven@pluto linux-next.git]$ git show d14b746c6c1c
> fatal: ambiguous argument 'd14b746c6c1c': unknown revision or path not in the
> working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
>
> So I guess I'm confused ...
>
> Are you sure some thing's not amiss somewhere here?

\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

> > I somehow have d14b746c6c1c locally, but if you don't have it you may
> > need to fetch git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git
> > with tags. That's linux-next specifics.
>
> Here it is:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git/commit/?id=d14b746c6c1c
