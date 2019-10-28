Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20B1CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 19:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F01214B2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 19:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SSO1abYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbfJ1TJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 15:09:41 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39019 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729634AbfJ1TJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 15:09:41 -0400
Received: by mail-ot1-f67.google.com with SMTP id t8so1495399otl.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 12:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L9fhhJYJix/9oZ9QAhDpmrJfpL3vm/qAXK8NaYNkeO4=;
        b=SSO1abYXQmcrUQLxLxUHnQswc1h1eK2cNuHq/UkJMxHVKezK9iRzKFRMwcn0pUt7ap
         /lx1bXQoLgKBjgh1n2lMzVMKf2z+JjVEpw1NmucNCdMuA+JZZlFbhEa57UO1HA2yrkR+
         EDUN2GlgnjT3TlhpXKwsw/rqk3z/9ztSCWHOsextqp/bEYymmCuj/SETil0juFNTCCV+
         lDpIcndd/pmo6SphvZd5MUzV7lUMe8/cf33hDsU0GaO9aDXe132NaR7OVpQF9hb35kbK
         Wap25ib1M/ngsKDlT4IuK/AgaihMVmE4hp7tCPuHrl1edmEYiK3Dl9fZINRml1Onw2iy
         cExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L9fhhJYJix/9oZ9QAhDpmrJfpL3vm/qAXK8NaYNkeO4=;
        b=MnqqDGisupLQNu5p/nIs/E4rdi+6Qs4egXSaN93ti6CMM6VIffEO+PhhcBEnFJXbwW
         pwBIRNcaV7UDykwwjgiF6eqy7LqSthL0aCRW+6rHh98Rr2xzq/o6UgCE1G+2wlhJlkvS
         FWrV5pape02ViQskXV1kVKOFvwAIO/A7amhc6MJ4NwwYR2NN/K7dzPheKJ5fdqDc41K6
         iJd4IjPAw6aAwl9OLF1ACN29N3kFQhMnTi4I8ZDVSGeIIfPta/OqgRuLuNmJJwrMOxmn
         Kx1J4Jn7rr8FSlFkjhtDLJ7ZjfP9VZgGkCrAcKONXIXAlY7BzyFWmB4EC9Rd9xd/6J6c
         Q0Ug==
X-Gm-Message-State: APjAAAXeOSoQHhcptG5oCzZJPTdyf5JrGzqnot8dNGvOv1rAYgiQsr3n
        qvSQhV6Xc0zI3CEnPSa3i3sbGQvJ8RIqQBE92cNXoA==
X-Google-Smtp-Source: APXvYqxLbI2EylQ7IoCHO+JjXBVws10ah+nufVxaGn0hGW6nZfYqhJxvRBgnrBZUceH4TATnjIU+Q3S6EtTWlE1gfDM=
X-Received: by 2002:a9d:37e6:: with SMTP id x93mr2695000otb.183.1572289779979;
 Mon, 28 Oct 2019 12:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
 <CAG48ez3q=BeNcuVTKBN79kJui4vC6nw0Bfq6xc-i0neheT17TA@mail.gmail.com> <20191028172143.4vnnjpdljfnexaq5@wittgenstein>
In-Reply-To: <20191028172143.4vnnjpdljfnexaq5@wittgenstein>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 28 Oct 2019 20:09:13 +0100
Message-ID: <CAG48ez20hn8vToY+=C62nA-rbUfxh=JD6N-f7XVS3_GZOoPjxw@mail.gmail.com>
Subject: Re: For review: documentation of clone3() system call
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 6:21 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Mon, Oct 28, 2019 at 04:12:09PM +0100, Jann Horn wrote:
> > On Fri, Oct 25, 2019 at 6:59 PM Michael Kerrisk (man-pages)
> > <mtk.manpages@gmail.com> wrote:
> > > I've made a first shot at adding documentation for clone3(). You can
> > > see the diff here:
> > > https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=faa0e55ae9e490d71c826546bbdef954a1800969
[...]
> > You might want to note somewhere that its flags can't be
> > seccomp-filtered because they're stored in memory, making it
> > inappropriate to use in heavily sandboxed processes.
>
> Hm, I don't think that belongs on the clone manpage. Granted that
> process creation is an important syscall but so are a bunch of others
> that aren't filterable because of pointer arguments.
> We can probably mention on the seccomp manpage that seccomp can't filter
> on pointer arguments and then provide a list of examples. If you setup a
> seccomp filter and don't know that you can't filter syscalls with
> pointer args that seems pretty bad to begin with.

Fair enough.

[...]
> One thing I never liked about clone() was that userspace had to know
> about stack direction. And there is a lot of ugly code in userspace that
> has nasty clone() wrappers like:
[...]
> where stack + stack_size is addition on a void pointer which usually
> clang and gcc are not very happy about.
> I wanted to bring this up on the mailing list soon: If possible, I don't
> want userspace to need to know about stack direction and just have stack
> point to the beginning and then have the kernel do the + stack_size
> after the copy_clone_args_from_user() if the arch needs it. For example,
> by having a dumb helder similar to copy_thread_tls()/coyp_thread() that
> either does the + stack_size or not. Right now, clone3() is supported on
> parisc and afaict, the stack grows upwards for it. I'm not sure if there
> are obvious reasons why that won't work or it would be a bad idea...

That would mean adding a new clone flag that redefines how those
parameters work and describing the current behavior in the manpage as
the behavior without the flag (which doesn't exist on 5.3), right?
