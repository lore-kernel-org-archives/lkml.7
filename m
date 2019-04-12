Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B816FC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F67E2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d3es35FN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfDLLEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:04:41 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52308 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfDLLEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:04:40 -0400
Received: by mail-it1-f196.google.com with SMTP id x132so14978846itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 04:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+O3b/2z1GkrPkPW5QZ+VECwgd8qDwmX7byvt1f+7hRs=;
        b=d3es35FNZso6ey1AqacsFE4oVeDdCp4s34s0dyV9unFWa2oqTY04xi/wHGPbAD7yay
         WC+gXaD8K/rCXv8tUNOemfZgK67DYUcEPBLLFTctQPKBhlfMd7ig2EbtpcEcqVHsYdEp
         HdRf8wGRmNuxESgvLsCJfEis9FOqzDR0h6CuiaTKYIL/9nt4GKvbh2DHmbOoxUnQ0rzf
         MFxbXRY4b1455WjPrGUS3E2VOa4U+6r81UiS/e1WTpkHP4C+ETqJBqIJfw71Jx6MH01s
         JiPegrNTArocqZLjf73OlUVdlWjvJPIb4jPS7Kzk/mBO/aqry9xZwpUo9Dui8h93Byeo
         VmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+O3b/2z1GkrPkPW5QZ+VECwgd8qDwmX7byvt1f+7hRs=;
        b=e1XhbLu+GKTcwBYOMxap7qqhk4oNa5qTCi7sFeVS9q0/EogXZ6h0A5sN3GQQ+xgZbO
         Q70+TB9ia/TNfLa2TNORfXGPl1RW9+OPUDfGZwTM2qKEcRvJwyBupdXInGNHFjFg+k1s
         y4WPzNHWPs7xfmSxmwVROX73K7Vh8b1Cfxdrt4fXcS0mAWGrzmpZdczpDOP9lS0ZU3Go
         OCrirN0n5zht4W4KKSjexx/MGNKGN+a2g+C4yS927kCjNO3ozhPQkhksaab3LsMjrYhb
         r8uz3WbskpNSCxWQvTb5KEjqIGDZImtmvEHBy/UWG18N1lGyrdy1a747X4vxF6zq+uuB
         fxVA==
X-Gm-Message-State: APjAAAXgcU0Az9VZjWzCMs4T3N1ummqIeI2TlOErem5frATrdS7hotuF
        xB74uuVTJCFZlOzyOTXuapSPb83ERSinuL51thrHIQ==
X-Google-Smtp-Source: APXvYqykBEFstfLZtvA1T3wtkG9DiCRpDImfN/YTGY4cJg1d89vwKaPUpwClNqzALzmgoYTW0heWLDsgjIPtQayBPRE=
X-Received: by 2002:a24:3d8f:: with SMTP id n137mr11731392itn.96.1555067079018;
 Fri, 12 Apr 2019 04:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000036a4a9058619dff3@google.com> <20190410002603.GS2217@ZenIV.linux.org.uk>
 <CACT4Y+YurDDxvvd2MbOf8pGyA0B+W_EFB34oVAcHXyv-ApKC7Q@mail.gmail.com>
 <eb223b47641df91a56fd200188a65d2c0ca4abe1.camel@themaw.net>
 <CACT4Y+YdaDdDbRvQZzvqbPofMD6F9cPtGFzcW+db-etJayfaJw@mail.gmail.com>
 <5c581e6eadc946b965e3138c9daffda75b1fba56.camel@themaw.net>
 <1f1d3b95189b6b8acfdf61dd05a804744791d313.camel@themaw.net>
 <20190410121159.GY2217@ZenIV.linux.org.uk> <CACT4Y+bc=A=djKChMkJGwXYbZ7UXuxmRu5Z0Y1BEXAFH1-Z6Kw@mail.gmail.com>
 <ed84e67c9cb55e91daf0d090152b3a9e2e06fe0b.camel@themaw.net> <20190411022257.GB2217@ZenIV.linux.org.uk>
In-Reply-To: <20190411022257.GB2217@ZenIV.linux.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 12 Apr 2019 13:04:27 +0200
Message-ID: <CACT4Y+ZYyAYuy_dB1jx1MW7S1RowbLhd0s-OJjkRCo0UG7_BEA@mail.gmail.com>
Subject: Re: kernel BUG at fs/inode.c:LINE!
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ian Kent <raven@themaw.net>, Dmitry Vyukov <dvyukov@google.com>,
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

On Thu, Apr 11, 2019 at 4:23 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Apr 11, 2019 at 08:50:17AM +0800, Ian Kent wrote:
> > On Wed, 2019-04-10 at 14:41 +0200, Dmitry Vyukov wrote:
> > > On Wed, Apr 10, 2019 at 2:12 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > >
> > > > On Wed, Apr 10, 2019 at 08:07:15PM +0800, Ian Kent wrote:
> > > >
> > > > > > I'm unable to find a branch matching the line numbers.
> > > > > >
> > > > > > Given that, on the face of it, the scenario is impossible I'm
> > > > > > seeking clarification on what linux-next to look at for the
> > > > > > sake of accuracy.
> > > > > >
> > > > > > So I'm wondering if this testing done using the master branch
> > > > > > or one of the daily branches one would use to check for conflicts
> > > > > > before posting?
> > > > >
> > > > > Sorry those are tags not branches.
> > > >
> > > > FWIW, that's next-20181214; it is what master had been in mid-December
> > > > and master is rebased every day.  Can it be reproduced with the current
> > > > tree?
> > >
> > > From the info on the dashboard we know that it happened only once on
> > > d14b746c (the second one is result of reproducing the first one). So
> > > it was either fixed or just hard to trigger.
> >
> > Looking at the source of tag next-20181214 in linux-next-history I see
> > this is mistake I made due to incorrect error handling which I fixed
> > soon after (there was in fact a double iput()).
>
> Right - "autofs: fix possible inode leak in autofs_fill_super()" had been
> broken (and completely pointless), leading to double iput() in that failure
> case.  And yes, double iput() can trigger that BUG_ON(), and with non-zero
> odds do so with that stack trace.
>
> As far as I'm concerned, case closed - bug had been in a misguided "fix"
> for inexistent leak (coming from misreading the calling conventions for
> d_make_root()), introduced in -next at next-20181130 and kicked out of
> there in next-20181219.  Dropped by Ian's request in
> Message-ID: <66d497c00cffb3e4109ca0d5287c8277954d7132.camel@themaw.net>
> which has fixed that crap.  Moreover, that posting had been in reply to
> that very syzcaller report, AFAICS.
>
> I don't know how to tell the bot to STFU and close the report in this
> situation; up to you, folks.


Please see the following for this:

> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  syzbot.

There are just 3 operations: mark as fixed by a commit, mark as
invalid, mark as duplicate.
I won't be always around. Tracking statuses of bug reports is in the
interests of kernel quality.



> As an aside, the cause of that bug is that d_make_root() calling conventions
> are insufficiently documented.  All we have is
>
> ||[mandatory]
> ||        d_alloc_root() is gone, along with a lot of bugs caused by code
> ||misusing it.  Replacement: d_make_root(inode).  The difference is,
> ||d_make_root() drops the reference to inode if dentry allocation fails.
>
> in Documentation/filesystems/porting, and that's not good enough.  Anyone
> willing to take a shot at that?  FWIW, the calling conventions are:
>
>         d_make_root(inode) normally allocates and returns a new dentry.
> On failure NULL is returned.  A reference to inode is consumed in all
> cases (on success it is transferred to new dentry, on failure it is
> dropped), so failure handling does not need anything done to inode.
> d_make_root(NULL) quietly returns NULL, which further simplifies the
> error handling in typical caller.  Usually it's something like
>         inode = foofs_new_inode(....);
>         s->s_root = d_make_inode(inode);
>         if (!s->s_root)
>                 bugger off, no need to undo inode allocation
>         success
> We do not need to check if foofs_new_inode() has returned NULL and we
> do not need any special cleanups in case of failure - not for the
> undoing the inode allocation.
>
> If anyone cares to convert that into coherent (and printable) documentation,
> patches are welcome...
