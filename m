Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7945BC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 01:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3009A2089C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 01:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hksf35rz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfJMBjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 21:39:37 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:44766 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfJMBjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 21:39:36 -0400
Received: by mail-vk1-f196.google.com with SMTP id j21so2879446vki.11
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 18:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Jy22ng6gElVkC1n97JPqljcwN2SsuVr+9pT2+PW3kM=;
        b=hksf35rz1UBBepOScmnh04dme9w8o5PWT+X3OHMGbm0Phggg5ugSKGhSY4/1Lexg3R
         Vs7U4mS6IO4LIcC9lUSgwvVH2QAaidaf+gjcO3lSLxoU8lTER/I6gQyorafxo6YTx+To
         2IagaGKlgphkiUBaCU7NXaK6X954aJsyKcOFV9uWgHzkGqa+58Nsa1YkyqdQIfeFAsqC
         BcgkoXyJu0H/8vrjB8Sz+9ReSDBbG2fNsTO9LDz/HO9shUaFvsQ+Fc23yapN6ayMDi4E
         hdDXLPRxqX/IXcKxXJGi2MemG/mpYhhsCm6z34ux18kA/PgBhRHqjiRu3byS4VDpZOjv
         xh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Jy22ng6gElVkC1n97JPqljcwN2SsuVr+9pT2+PW3kM=;
        b=L4KmFhv7EipKw2mDT1KwDQ6pHG6hm1rTHxRvwd641QgAcA+k62rdBhpFr0e46YylPL
         8cZjf+U+HMzCPn+WlMTdr3Ehi3w7DpvTdzbWwv2W7tuImy2i+5oNPoLAKl4qkdv2v720
         tSPb15E2o4b0t4W2+lWLh0Y3Ui+YVDNquogqJQkRrF1Iv3ZWXwKQwRKfvrs+jiKp2qlK
         9ph+RFiXpXnYZpHMv7B0EBlKvmsb3Co+shD9UtxTOJF1TMrd7EtmQZtrBKes6+LcKMDK
         0LCTZI48erV8JIKPzfWCsgoqtol4S9udn1ExeByI58hlznuIQLqWg00Gy0oBH4jTtkOv
         BqWA==
X-Gm-Message-State: APjAAAWLHefIHPj8h6jDWvh0ilvcKazNLXPKNp/yrd8DK6OQgWE9vuF4
        EWnr0Ht+B3DiKmnYM50FUO5KagSLa+IiT/Bi1b2Aww==
X-Google-Smtp-Source: APXvYqyTUUmlvVBbJx4Vewyis/oJkOUDWCAfTZJ5DwpEkOJBJX7ppCoQmAtYt0YT7RwUQlykm2+emuy8Od5eXMa+OEQ=
X-Received: by 2002:a1f:1ad4:: with SMTP id a203mr12851304vka.81.1570930774956;
 Sat, 12 Oct 2019 18:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-4-dancol@google.com>
 <CALCETrVZHd+csdRL-uKbVN3Z7yeNNtxiDy-UsutMi=K3ZgCiYw@mail.gmail.com>
 <CAKOZuevUqs_Oe1UEwguQK7Ate3ai1DSVSij=0R=vmz9LzX4k6Q@mail.gmail.com> <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
In-Reply-To: <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Sat, 12 Oct 2019 18:38:58 -0700
Message-ID: <CAKOZuesN8jiw7LOAG0uBz1PJmfg-T6+DstirGLQSQgLedCCZcw@mail.gmail.com>
Subject: Re: [PATCH 3/7] Add a UFFD_SECURE flag to the userfaultfd API.
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Emelyanov <xemul@parallels.com>,
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

On Sat, Oct 12, 2019 at 6:14 PM Andy Lutomirski <luto@kernel.org> wrote:
>
..
>
> > But maybe we can go further: let's separate authentication and
> > authorization, as we do in other LSM hooks. Let's split my
> > inode_init_security_anon into two hooks, inode_init_security_anon and
> > inode_create_anon. We'd define the former to just initialize the file
> > object's security information --- in the SELinux case, figuring out
> > its class and SID --- and define the latter to answer the yes/no
> > question of whether a particular anonymous inode creation should be
> > allowed. Normally, anon_inode_getfile2() would just call both hooks.
> > We'd add another anon_inode_getfd flag, ANON_INODE_SKIP_AUTHORIZATION
> > or something, that would tell anon_inode_getfile2() to skip calling
> > the authorization hook, effectively making the creation always
> > succeed. We can then make the UFFD code pass
> > ANON_INODE_SKIP_AUTHORIZATION when it's creating a file object in the
> > fork child while creating UFFD_EVENT_FORK messages.
>
> That sounds like an improvement.  Or maybe just teach SELinux that
> this particular fd creation is actually making an anon_inode that is a
> child of an existing anon inode and that the context should be copied
> or whatever SELinux wants to do.  Like this, maybe:
>
> static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
>                                   struct userfaultfd_ctx *new,
>                                   struct uffd_msg *msg)
> {
>         int fd;
>
> Change this:
>
>         fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, new,
>                               O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS));
>
> to something like:
>
>       fd = anon_inode_make_child_fd(..., ctx->inode, ...);
>
> where ctx->inode is the one context's inode.

Yeah. I figured we could just add a special-purpose hook for this
case. Having a special hook for this one case feels ugly though, and
at copy_mm time, we don't have a PID for the new child yet --- I don't
know whether LSMs would care about that. But maybe this is one of
those "doctor, it hurts when I do this!" situations and this child
process difficulty is just a hint that some other design might work
better.

> Now that you've pointed this mechanism out, it is utterly and
> completely broken and should be removed from the kernel outright or at
> least severely restricted.  A .read implementation MUST NOT ACT ON THE
> CALLING TASK.  Ever.  Just imagine the effect of passing a userfaultfd
> as stdin to a setuid program.
>
> So I think the right solution might be to attempt to *remove*
> UFFD_EVENT_FORK.  Maybe the solution is to say that, unless the
> creator of a userfaultfd() has global CAP_SYS_ADMIN, then it cannot
> use UFFD_FEATURE_EVENT_FORK) and print a warning (once) when
> UFFD_FEATURE_EVENT_FORK is allowed.  And, after some suitable
> deprecation period, just remove it.  If it's genuinely useful, it
> needs an entirely new API based on ioctl() or a syscall.  Or even
> recvmsg() :)

IMHO, userfaultfd should have been a datagram socket from the start.
As you point out, it's a good fit for the UFFD protocol, which
involves FD passing and a fixed message size.

> And UFFD_SECURE should just become automatic, since you don't have a
> problem any more. :-p

Agreed. I'll wait to hear what everyone else has to say.
