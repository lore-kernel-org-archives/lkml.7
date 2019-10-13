Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB00C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 01:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772B72089C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 01:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570929279;
	bh=3xDRpdl064Rv8+CvOD+mJcU6GdSI4NTD1UERO31D1Ak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rBRJ12BKF8BOvl/MWJFL5XkJfvEf8xXfUUdKFT/kxAQk/L9SInyOdr1o8G9R+7G3D
	 CaYCeHAaReHiNU9j4KvEcDyx1cDoqLo8RYsdsEsjhY/8n2LteUgIuIb+eo8S+H0JyX
	 j6oUAWxnaAX98JXYeB7Lc3x41FupkFnw/7CSVqqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfJMBOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 21:14:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbfJMBOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 21:14:38 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD6CF21D7D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 01:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570929277;
        bh=3xDRpdl064Rv8+CvOD+mJcU6GdSI4NTD1UERO31D1Ak=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QtCMdkpvxygrRyMv8M+mDlo166M+x7UrRSx4A/0VrHWFd6c9l2DKhRQbG2tE1UBRN
         LZe4bo7o88hpiwZpcg3IR55rufL14M2f/Hb4s9yf5mHPvTKeSfPluiSxP9OsCo9dLC
         /156Nfqx8HDV5no2dXiSho0Xn9fwnVrHU6e1NN40=
Received: by mail-wm1-f49.google.com with SMTP id v17so13393451wml.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 18:14:36 -0700 (PDT)
X-Gm-Message-State: APjAAAWjMnitr7VTlo0fudbrr6vU7U0f+OH5thQvY+/mXzoybEv1t336
        9VApmCFCzMIVSQQk07AoHar5sprumO3+IYNyw0riyg==
X-Google-Smtp-Source: APXvYqzB8K9RUyJEZ3nofhGwLYruOYHYt4KjQE7yT2PNJ6aVpDZNbTYQcrCyzwZoUiIlxpbJUTfTSvaJAyWY3DEZK1U=
X-Received: by 2002:a1c:a556:: with SMTP id o83mr9747603wme.0.1570929275028;
 Sat, 12 Oct 2019 18:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-4-dancol@google.com>
 <CALCETrVZHd+csdRL-uKbVN3Z7yeNNtxiDy-UsutMi=K3ZgCiYw@mail.gmail.com> <CAKOZuevUqs_Oe1UEwguQK7Ate3ai1DSVSij=0R=vmz9LzX4k6Q@mail.gmail.com>
In-Reply-To: <CAKOZuevUqs_Oe1UEwguQK7Ate3ai1DSVSij=0R=vmz9LzX4k6Q@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 12 Oct 2019 18:14:23 -0700
X-Gmail-Original-Message-ID: <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
Message-ID: <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
Subject: Re: [PATCH 3/7] Add a UFFD_SECURE flag to the userfaultfd API.
To:     Daniel Colascione <dancol@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Emelyanov <xemul@parallels.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding more people because this is going to be an ABI break, sigh]

On Sat, Oct 12, 2019 at 5:52 PM Daniel Colascione <dancol@google.com> wrote:
>
> On Sat, Oct 12, 2019 at 4:10 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Sat, Oct 12, 2019 at 12:16 PM Daniel Colascione <dancol@google.com> wrote:
> > >
> > > The new secure flag makes userfaultfd use a new "secure" anonymous
> > > file object instead of the default one, letting security modules
> > > supervise userfaultfd use.
> > >
> > > Requiring that users pass a new flag lets us avoid changing the
> > > semantics for existing callers.
> >
> > Is there any good reason not to make this be the default?
> >
> >
> > The only downside I can see is that it would increase the memory usage
> > of userfaultfd(), but that doesn't seem like such a big deal.  A
> > lighter-weight alternative would be to have a single inode shared by
> > all userfaultfd instances, which would require a somewhat different
> > internal anon_inode API.
>
> I'd also prefer to just make SELinux use mandatory, but there's a
> nasty interaction with UFFD_EVENT_FORK. Adding a new UFFD_SECURE mode
> which blocks UFFD_EVENT_FORK sidesteps this problem. Maybe you know a
> better way to deal with it.

...

> But maybe we can go further: let's separate authentication and
> authorization, as we do in other LSM hooks. Let's split my
> inode_init_security_anon into two hooks, inode_init_security_anon and
> inode_create_anon. We'd define the former to just initialize the file
> object's security information --- in the SELinux case, figuring out
> its class and SID --- and define the latter to answer the yes/no
> question of whether a particular anonymous inode creation should be
> allowed. Normally, anon_inode_getfile2() would just call both hooks.
> We'd add another anon_inode_getfd flag, ANON_INODE_SKIP_AUTHORIZATION
> or something, that would tell anon_inode_getfile2() to skip calling
> the authorization hook, effectively making the creation always
> succeed. We can then make the UFFD code pass
> ANON_INODE_SKIP_AUTHORIZATION when it's creating a file object in the
> fork child while creating UFFD_EVENT_FORK messages.

That sounds like an improvement.  Or maybe just teach SELinux that
this particular fd creation is actually making an anon_inode that is a
child of an existing anon inode and that the context should be copied
or whatever SELinux wants to do.  Like this, maybe:

static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
                                  struct userfaultfd_ctx *new,
                                  struct uffd_msg *msg)
{
        int fd;

Change this:

        fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, new,
                              O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS));

to something like:

      fd = anon_inode_make_child_fd(..., ctx->inode, ...);

where ctx->inode is the one context's inode.

*** HOWEVER *** !!!

Now that you've pointed this mechanism out, it is utterly and
completely broken and should be removed from the kernel outright or at
least severely restricted.  A .read implementation MUST NOT ACT ON THE
CALLING TASK.  Ever.  Just imagine the effect of passing a userfaultfd
as stdin to a setuid program.

So I think the right solution might be to attempt to *remove*
UFFD_EVENT_FORK.  Maybe the solution is to say that, unless the
creator of a userfaultfd() has global CAP_SYS_ADMIN, then it cannot
use UFFD_FEATURE_EVENT_FORK) and print a warning (once) when
UFFD_FEATURE_EVENT_FORK is allowed.  And, after some suitable
deprecation period, just remove it.  If it's genuinely useful, it
needs an entirely new API based on ioctl() or a syscall.  Or even
recvmsg() :)

And UFFD_SECURE should just become automatic, since you don't have a
problem any more. :-p

--Andy
