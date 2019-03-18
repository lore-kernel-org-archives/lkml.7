Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391C4C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E5420863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PM9OGKhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfCRQ7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:59:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35403 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfCRQ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:59:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id g8so1144886pgf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 09:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1qSGcK0R5KM+dkjWC/kauJx8/g6gKZLlVh+46+vQTpk=;
        b=PM9OGKhXVFOScoA0U0eJfjlATm68hBokDH3xW76dl2UrhKuLtWfcahYPG5tZzJpWHy
         qPRj7SaRW915MTLp3nmMfjCTbwM9k49VLoIXbp7+HUtgJEDn41oJRmFHkmNkl0nGtUoV
         uL6n5VvrW/nx/l25G3MiK/Y64jrg/oh9SDiXRheAs6X+GRPwJ/gs16ooPLZIU4YLCmlF
         cuz29jZ/UPZ9B4rkBDhhfIYLxO4XIPmsS9g8nQNx0IIiabynJxMZ0OMey+jIZbTbZxlh
         G7oAucvMP+3PhykgPsXecAODKhmrvPM7d48t1eWOqIDKXZrebPqEJ53C0aOsLnrMiwEC
         GWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1qSGcK0R5KM+dkjWC/kauJx8/g6gKZLlVh+46+vQTpk=;
        b=AxGpv150QEsIrZ/3wm0po+FT9V/TSAULKFRuEUy0Qfm547BcRShSP2LJVyx4MAowPG
         De+mQCkd1ZgJdT+sI/fJJSnSwPLeWPPHAX4pk1Gdb5X4BkbhYKIcseRUgS2ETwgbhrLl
         a7XuQuP5a8+E7iZRGH1t4qmLQPs7A0i9xTnKxcQ2AZ+Z70a8v23n/w//INEZ/QlnhEdn
         QmU7fwv9v7lnfrO2ULjj5WzyEMFspzTUaa9MoAp8nHnWdGUrOdMsMxHFhYNEJxYoFOZn
         MyHQORpF3yuECIgmZVSITbvTc48ArC3ERcb3oap6e8p2yI3P0HY9pxkqVu1tMwZPQwj5
         3oYw==
X-Gm-Message-State: APjAAAUTENzhrGFQGQqOUR7nq/m5FjK/RtRWEtceT4e27OsHUrBb4QL3
        Zvw8eUQGL4gT2H5e+5VhIrwQIuNwY2S9Sze0odCkxQ==
X-Google-Smtp-Source: APXvYqw/WB6apBZfCC4Z3gtQWYzVAj6LMOzybqti6+WMrkpj4eKj2bUipEWmGt4Rw1lWbJw06V7FSeVN09pOsBX0P44=
X-Received: by 2002:a17:902:8203:: with SMTP id x3mr20736629pln.159.1552928355544;
 Mon, 18 Mar 2019 09:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552679409.git.andreyknvl@google.com> <bf0abceeaf32e6b9cdbc9dde45cc5966b5747ec4.1552679409.git.andreyknvl@google.com>
 <81bc3110-b638-4545-1270-26baec3d59e7@arm.com>
In-Reply-To: <81bc3110-b638-4545-1270-26baec3d59e7@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 18 Mar 2019 17:59:04 +0100
Message-ID: <CAAeHK+yrAPOyuEyLCygrwQxCztb8P-9BBj-6RP6=iG-GGBkkQw@mail.gmail.com>
Subject: Re: [PATCH v11 13/14] arm64: update Documentation/arm64/tagged-pointers.txt
To:     Kevin Brodsky <kevin.brodsky@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 2:26 PM Kevin Brodsky <kevin.brodsky@arm.com> wrote:
>
> On 15/03/2019 19:51, Andrey Konovalov wrote:
> > This patch is a part of a series that extends arm64 kernel ABI to allow to
> > pass tagged user pointers (with the top byte set to something else other
> > than 0x00) as syscall arguments.
> >
> > Document the ABI changes in Documentation/arm64/tagged-pointers.txt.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >   Documentation/arm64/tagged-pointers.txt | 18 ++++++++----------
> >   1 file changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/Documentation/arm64/tagged-pointers.txt b/Documentation/arm64/tagged-pointers.txt
> > index a25a99e82bb1..07fdddeacad0 100644
> > --- a/Documentation/arm64/tagged-pointers.txt
> > +++ b/Documentation/arm64/tagged-pointers.txt
> > @@ -17,13 +17,15 @@ this byte for application use.
> >   Passing tagged addresses to the kernel
> >   --------------------------------------
> >
> > -All interpretation of userspace memory addresses by the kernel assumes
> > -an address tag of 0x00.
> > +The kernel supports tags in pointer arguments (including pointers in
> > +structures) of syscalls, however such pointers must point to memory ranges
> > +obtained by anonymous mmap() or brk().
> >
> > -This includes, but is not limited to, addresses found in:
> > +The kernel supports tags in user fault addresses. However the fault_address
> > +field in the sigcontext struct will contain an untagged address.
> >
> > - - pointer arguments to system calls, including pointers in structures
> > -   passed to system calls,
> > +All other interpretations of userspace memory addresses by the kernel
> > +assume an address tag of 0x00, in particular:
> >
> >    - the stack pointer (sp), e.g. when interpreting it to deliver a
> >      signal,
> > @@ -33,11 +35,7 @@ This includes, but is not limited to, addresses found in:
> >
> >   Using non-zero address tags in any of these locations may result in an
> >   error code being returned, a (fatal) signal being raised, or other modes
> > -of failure.
> > -
> > -For these reasons, passing non-zero address tags to the kernel via
> > -system calls is forbidden, and using a non-zero address tag for sp is
> > -strongly discouraged.
> > +of failure. Using a non-zero address tag for sp is strongly discouraged.
>
> I don't understand why we should keep such a limitation. For MTE, tagging SP is
> something we are definitely considering. This does bother userspace software in some
> rare cases, but I'm not sure in what way it bothers the kernel.

I don't mind allowing tagged sp as well, but it seems that it's
another ABI relaxation that needs to be handled separately. I'm not
sure if we want to include that into this patchset, which is supposed
to allow tagged pointers to be passed to syscalls.

>
> Kevin
>
> >
> >   Programs maintaining a frame pointer and frame records that use non-zero
> >   address tags may suffer impaired or inaccurate debug and profiling
>
