Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D809BCA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45E620663
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GJ40qGJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390568AbfJ1PMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:12:38 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43009 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731098AbfJ1PMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:12:38 -0400
Received: by mail-oi1-f195.google.com with SMTP id s5so6139930oie.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 08:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wXxhu/tmc9YP1XTfcQJ3HjAvQlCmqGJP256WPTj2XSc=;
        b=GJ40qGJD7TtbIgudDFm2N7LHOQ6aSoOljrrxXlqEik+9bXO7yJallt9amumZdHCmjG
         27n00ClQMzIia2m9uAlnK3x919OrGWy4dvA3Xp1pJJUzxWBIIZwvxmBpryE3+luDzYyq
         b8x8CaYNpg/Ya0dz6dBgKfc41xtBqIwIUMNVHhp1ncWHdN0rxm/9FplrQ64sV3AsycdO
         AkAmBf3pHs9hUKE9iRHFo5EEM1vKHq/iolqALxq8JXvSyZB1rgKMDHS+teXambVzbsnp
         7zLsscjgNQF6ZVIJu3TXD+HhwdAbPJfVw1QH9JGup9MKa3Ac8UhSRm3Yn7ZX6LRxdZYj
         8L7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wXxhu/tmc9YP1XTfcQJ3HjAvQlCmqGJP256WPTj2XSc=;
        b=OAoZ7RF9cl6h24eI7bNTlpE85kYIWdpf9kRbRn4kluGeIXZpiNkEvfmTgon8aaZ4Uz
         r1pqu5sSNXhb0nBDFRvwkF4l5i2HWRWUN8hTCbMhUs6hTe7QNMpgD9Ot9/e579nB8h8t
         9xIBGHhIN8SaP2g+04X3mC8WHmdpk/WjNj4xS9KbFYO+ppbkx41Uxd9iKBwAsn6w9rMA
         bJ1P2bpjP0GGteTUiEYfszD4ssIKqSjQ/JEpH6nneI3mo7pYTxb+miCvdJPjuWjFSkqF
         WQlmzIPDhUVUh3VLOLGKqrELeOlPKGgFs9OTwL8uJTkfmGV63N56/MfJFD3GZlMxuMpX
         Z5TA==
X-Gm-Message-State: APjAAAXMN6bx5WEM+tZY0yOCsY6LGrh/1pKYBB10AJV4f3o22j0qIw7G
        98kzXCrjaDAoDpM2wab3+02xuUpj6d0KOqTDSo6HaA==
X-Google-Smtp-Source: APXvYqxIzAhUAQY2YqVi0DY+JV//TbVaQUHYNtEBARj1hmmiyo+CWdT7zgmtQj1uFTHVHbc9HcDYJREjaSWSkiT75mw=
X-Received: by 2002:a05:6808:b30:: with SMTP id t16mr367143oij.157.1572275556022;
 Mon, 28 Oct 2019 08:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
In-Reply-To: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 28 Oct 2019 16:12:09 +0100
Message-ID: <CAG48ez3q=BeNcuVTKBN79kJui4vC6nw0Bfq6xc-i0neheT17TA@mail.gmail.com>
Subject: Re: For review: documentation of clone3() system call
To:     Michael Kerrisk-manpages <mtk.manpages@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 6:59 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> I've made a first shot at adding documentation for clone3(). You can
> see the diff here:
> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=3D=
faa0e55ae9e490d71c826546bbdef954a1800969
[...]
>    clone3()
>        The  clone3() system call provides a superset of the functionality
>        of the older clone() interface.  It also provides a number of  API
>        improvements,  including: space for additional flags bits; cleaner
>        separation in the use of various arguments;  and  the  ability  to
>        specify the size of the child's stack area.

You might want to note somewhere that its flags can't be
seccomp-filtered because they're stored in memory, making it
inappropriate to use in heavily sandboxed processes.

>            struct clone_args {
>                u64 flags;        /* Flags bit mask */
>                u64 pidfd;        /* Where to store PID file descriptor
>                                     (int *) */
>                u64 child_tid;    /* Where to store child TID,
>                                     in child's memory (int *) */
>                u64 parent_tid;   /* Where to store child TID,
>                                     in parent's memory (int *) */
>                u64 exit_signal;  /* Signal to deliver to parent on
>                                     child termination */
>                u64 stack;        /* Pointer to lowest byte of stack */
>                u64 stack_size;   /* Size of stack */
>                u64 tls;          /* Location of new TLS */
>            };
>
>        The size argument that is supplied to clone3() should be  initial=
=E2=80=90
>        ized  to  the  size of this structure.  (The existence of the size
>        argument permits future extensions to the clone_args structure.)
>
>        The stack for the child process is  specified  via  cl_args.stack,
>        which   points   to  the  lowest  byte  of  the  stack  area,  and

Here and in the comment in the struct above, you say that .stack
"points to the lowest byte of the stack area", but isn't that
architecture-dependent? For most architectures, I think it should
instead be "is the initial stack pointer", with the exception of IA64
(and maybe others, I'm not sure). For example, on X86, when launching
a thread with an initially empty stack, it points directly *after* the
end of the stack area.

>        cl_args.stack_size, which specifies  the  size  of  the  stack  in
>        bytes.   In the case where the CLONE_VM flag (see below) is speci=
=E2=80=90

stack_size is ignored on most architectures.

>        fied, a stack must be explicitly allocated and specified.   Other=
=E2=80=90
>        wise,  these  two  fields  can  be  specified as NULL and 0, which
>        causes the child to use the same stack area as the parent (in  the
>        child's own virtual address space).
[...]
>    Equivalence between clone() and clone3() arguments
>        Unlike  the  older  clone()  interface, where arguments are passed
>        individually, in the newer clone3() interface  the  arguments  are
>        packaged  into  the clone_args structure shown above.  This struc=
=E2=80=90
>        ture allows for a superset  of  the  information  passed  via  the
>        clone() arguments.
>
>        The following table shows the equivalence between the arguments of
>        clone() and the fields in  the  clone_args  argument  supplied  to
>        clone3():
>
>               clone()         clone(3)        Notes
>                               cl_args field
>               flags & ~0xff   flags
>               parent_tid      pidfd           See CLONE_PIDFD
>               child_tid       child_tid       See CLONE_CHILD_SETTID
>               parent_tid      parent_tid      See CLONE_PARENT_SETTID
>               flags & 0xff    exit_signal
>               stack           stack
>
>               ---             stack_size

(except that on ia64, stack_size also exists in clone2(), and if
you're not on ia64, stack_size doesn't do anything, at least on X86,
so showing them side by side like this doesn't really make sense)
