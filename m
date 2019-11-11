Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C15C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0862821D7F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BP7+Bkdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfKKO4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:56:04 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33825 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfKKO4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:56:03 -0500
Received: by mail-ot1-f66.google.com with SMTP id t4so11489052otr.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 06:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lFd9QgXHtlAAGLyAHn/OxQGBQG3M9vesrmYO8xOMHoM=;
        b=BP7+BkdjiK2/+DzxZLMF4OWcq+cRxwzGeFcLF7It+OsxMVvOjdL9wZmktEWUCYdChM
         FKtqwwh4KJYzY8pihfF6DNgymNipK813O4fvTgJe4wIoHcpokv1yQ4x+3fx5ehmb6SUT
         2z8kM+HvyOlJSOUauByBIDmATfcJvoJyqsVPSeR7GfNEcKgvqSNhS05wsmU942cgN5HC
         1Hwgm0atXLwTzkALMNcMh3rFwaz1qiTlJyiVeIKnBWajTpVseCqxnJ1FHzHiBX0RXvdb
         HIyPeavTnKiDH4+zz0WrHKvp/je+osxUryWha3EOHeUXzbdRia0UelWH7Gk62ZV+pbcD
         dkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lFd9QgXHtlAAGLyAHn/OxQGBQG3M9vesrmYO8xOMHoM=;
        b=ubV3FIPoHBE48w/+yl5nw7tPwl01OqiPpmNBDN1op4FETZmAieMODLIY2pdN1rJ5m9
         yrf8PC8cWq+AZd0RBOWGX+Tin6FmqlB1BO4nfeMULMSctYcH6Ha9SCsP30SVXDDW97pK
         0xCacxfCzOgl7Qw07nHkJhi7RMOqem71KrsM5pEXFL7z0BeindjkUK7uyq50A9XZbuY3
         8aR3qFuJ61eXcWKyZnLbU/Sl/uTKwJTSdelIstAsKCFBJCi1v0ZWx2K3Z388uQRBMe0R
         xV1pI0kUkxB6q0PlkJV9uW36dQTjOhkYxDtka7s2hkC6tT5IPEajCHkn37kaHIcvT6jU
         FUZA==
X-Gm-Message-State: APjAAAV4wdzs6dJPOozP8dVTh1mE6li1gmu0u4B0c/G9S3/PCebaxQTe
        ERJdGUKKd55QBmyoJtYxgyeKYPpfx+NWgtH880j8aA==
X-Google-Smtp-Source: APXvYqyWH6HotinOqdFmaBjC5eneRB4r8cL58DmW2B908LWeWn/aSruzOt/1Wjp51sUtGHVs64LcswG5aeLsENuK5DU=
X-Received: by 2002:a9d:7e8a:: with SMTP id m10mr2125174otp.180.1573484162476;
 Mon, 11 Nov 2019 06:56:02 -0800 (PST)
MIME-Version: 1.0
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
 <20191107151941.dw4gtul5lrtax4se@wittgenstein> <2eb2ab4c-b177-29aa-cdc4-420b24cfd7b3@gmail.com>
In-Reply-To: <2eb2ab4c-b177-29aa-cdc4-420b24cfd7b3@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 11 Nov 2019 15:55:35 +0100
Message-ID: <CAG48ez2of684J6suPZpko7JFV6hg5KQsrP0KAn8B8-C3PM9OfQ@mail.gmail.com>
Subject: Re: For review: documentation of clone3() system call
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 9, 2019 at 9:10 AM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
[...]
> On 11/7/19 4:19 PM, Christian Brauner wrote:
> > On Fri, Oct 25, 2019 at 06:59:31PM +0200, Michael Kerrisk (man-pages) w=
rote:
[...]
> >>        The stack argument specifies the location of the stack used by =
the
> >>        child process.  Since the child and calling process may share m=
em=E2=80=90
> >>        ory,  it  is  not possible for the child process to execute in =
the
> >>        same stack as the  calling  process.   The  calling  process  m=
ust
> >>        therefore  set  up  memory  space  for  the child stack and pas=
s a
> >>        pointer to this space to clone().  Stacks  grow  downward  on  =
all
> >
> > It might be a good idea to advise people to use mmap() to create a
> > stack. The "canonical" way of doing this would usually be something lik=
e
> >
> > #define DEFAULT_STACK_SIZE (4 * 1024 * 1024) /* 8 MB usually on Linux *=
/
> > void *stack =3D mmap(NULL, DEFAULT_STACK_SIZE, PROT_READ | PROT_WRITE, =
MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
> >
> > (Yes, the MAP_STACK is usally a noop but people should always include i=
t
> >  in case some arch will have weird alignment requirement in which case
> >  this flag can be changed to actually do something...)
>
> So, I'm getting a little bit of an education here, and maybe you are
> going to further educate me. Long ago, I added the documentation of
> MAP_STACK to mmap(2), but I never quite connected the dots.
>
> However, you say MAP_STACK is *usually* a noop. As far as I can see,
> in current kernels it is *always* a noop. And AFAICS, since it was first
> added in 2.6.27 (2008), it has always been a noop.
>
> I wonder if it will always be a noop.
[...]
> So, my understanding from the above is that MAP_STACK was added to
> allow a possible fix on some old architectures, should anyone decide it
> was worth doing the work of implementing it. But so far, after 12 years,
> no one did. It kind of looks like no one ever will (since those old
> architectures become less and less relevant).
>
> So, AFAICT, while it's not wrong to tell people to use mmap(MAP_STACKED),
> it doesn't provide any benefit (and perhaps never will), and it is a
> more clumsy than plain old malloc().
>
> But, it could well be that there's something I still don't know here,
> and I'd be interested to get further education.

Not on Linux, but on OpenBSD, they do use MAP_STACK now AFAIK; this
was announced here:
<http://openbsd-archive.7691.n7.nabble.com/stack-register-checking-td338238=
.html>.
Basically they periodically check whether the userspace stack pointer
points into a MAP_STACK region, and if not, they kill the process. So
even if it's a no-op on Linux, it might make sense to advise people to
use the flag to improve portability? I'm not sure if that's something
that belongs in Linux manpages.

Another reason against malloc() is that when setting up thread stacks
in proper, reliable software, you'll probably want to place a guard
page (in other words, a 4K PROT_NONE VMA) at the bottom of the stack
to reliably catch stack overflows; and you probably don't want to do
that with malloc, in particular with non-page-aligned allocations.
