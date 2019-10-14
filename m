Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4935EECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CAB520854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BTLGihW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387900AbfJNQEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:04:51 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34956 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732906AbfJNQEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:04:51 -0400
Received: by mail-oi1-f195.google.com with SMTP id x3so14198389oig.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 09:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1/oA4GHUe8fryr8ogyJYGS6yhaGsA/XmoYYSjCn5tG8=;
        b=BTLGihW/wv2eV8aWLaXAVOYXato+DzxslEWCR5heglTYrXl+jI4hPaIoSH3kOBgJmA
         x8Pb0mSiFMK6BK/4u7lkzo63BHz4/wCrWJbqaxFaCIwHJnx/wUEwiSjI8TeYQXX8Rikq
         2nudpNpEZyLND2Iil3SoZtJqHd0tcSPoS3AL7KVyUl830l7RaWy/YfZDlPSxoztcwSo/
         47jRyNacS9iNk9zSxk1nef8kjTs12q1rGV2++B624mMUtpT3B/xyUyB2xZ74KB1JniQ0
         MQo3UcmfRiAoIpkqML8//EDr3SaPPuu4JSwn2AJOM13TmQ0KUqPOwmNW5W77upXOY5X3
         FZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1/oA4GHUe8fryr8ogyJYGS6yhaGsA/XmoYYSjCn5tG8=;
        b=ZCE8lMUNYvkJgqwtDs0mxnsIhYsE14q/8n+Cu9psv84NuZay7huG8Wa4cilZmQb+SJ
         oan5CUghdEqSEXlgiBHTS1jZLgprDyfxLz/xjk61RC+OMkMWDQy9mkKNFUosN8mL6G+/
         2tXmKnw1ZsXpHtQwlK5zn6WFRnLGhMHslA21ySsqf5846pI3xDy5qgiBjx0JJHLDBSkb
         zxbc+QBLusAmpindPExwsuGF3UlTQ3YxqJQ+p59mAaJPheugrqF/2QeH9BaFzL3ewW7u
         zSNK5qwdvMIe9wFLlEo4y91T4vN1r0DjLenQVDkqA5G2jAug5aLBqGW6A+BxBZD/A1iY
         oV/g==
X-Gm-Message-State: APjAAAW0nVWGUCDYfTckMd5aaLWdAsWWIKxJFeZVXfoYRhLbVCZGLwyN
        FbzFpBwjwgRNvSfKN6eHoXfz0umFhufQ1zLO7+Ajpg==
X-Google-Smtp-Source: APXvYqxXR3roLEhM1Q1pM7JBpKepo96dBtV/cwrCg3P9n58AzmtIzESZTptd3g+9Psex6LMGksnCpsKWDzYzpyzvh7s=
X-Received: by 2002:a05:6808:95:: with SMTP id s21mr25291295oic.68.1571069089126;
 Mon, 14 Oct 2019 09:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-4-dancol@google.com>
 <CALCETrVZHd+csdRL-uKbVN3Z7yeNNtxiDy-UsutMi=K3ZgCiYw@mail.gmail.com>
 <CAKOZuevUqs_Oe1UEwguQK7Ate3ai1DSVSij=0R=vmz9LzX4k6Q@mail.gmail.com> <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
In-Reply-To: <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 14 Oct 2019 18:04:22 +0200
Message-ID: <CAG48ez3P27-xqdjKLqfP_0Q_v9K92CgEjU4C=kob2Ax7=NoZbA@mail.gmail.com>
Subject: Re: [PATCH 3/7] Add a UFFD_SECURE flag to the userfaultfd API.
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Daniel Colascione <dancol@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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

On Sun, Oct 13, 2019 at 3:14 AM Andy Lutomirski <luto@kernel.org> wrote:
> [adding more people because this is going to be an ABI break, sigh]
> On Sat, Oct 12, 2019 at 5:52 PM Daniel Colascione <dancol@google.com> wrote:
> > On Sat, Oct 12, 2019 at 4:10 PM Andy Lutomirski <luto@kernel.org> wrote:
> > > On Sat, Oct 12, 2019 at 12:16 PM Daniel Colascione <dancol@google.com> wrote:
> > > > The new secure flag makes userfaultfd use a new "secure" anonymous
> > > > file object instead of the default one, letting security modules
> > > > supervise userfaultfd use.
> > > >
> > > > Requiring that users pass a new flag lets us avoid changing the
> > > > semantics for existing callers.
> > >
> > > Is there any good reason not to make this be the default?
> > >
> > >
> > > The only downside I can see is that it would increase the memory usage
> > > of userfaultfd(), but that doesn't seem like such a big deal.  A
> > > lighter-weight alternative would be to have a single inode shared by
> > > all userfaultfd instances, which would require a somewhat different
> > > internal anon_inode API.
> >
> > I'd also prefer to just make SELinux use mandatory, but there's a
> > nasty interaction with UFFD_EVENT_FORK. Adding a new UFFD_SECURE mode
> > which blocks UFFD_EVENT_FORK sidesteps this problem. Maybe you know a
> > better way to deal with it.
[...]
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

FWIW, <https://codesearch.debian.net/search?q=UFFD_FEATURE_EVENT_FORK&literal=1>
just shows the kernel, kernel selftests, and strace code for decoding
syscall arguments. CRIU uses it though (probably for postcopy live
migration / lazy migration?), I guess that code isn't in debian for
some reason.
