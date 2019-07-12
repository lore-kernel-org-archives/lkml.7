Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77CFC742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A074B20651
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hN7ksNSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfGLQ7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 12:59:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33962 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfGLQ7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 12:59:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so4565357pfo.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 09:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=srwfPJxVIL0yVnmYxIpxeAMujgHX4vNSJddm4DFEsWo=;
        b=hN7ksNSGpVqBceDvB2fsZpnYmytEV8LVEWDebyG7vs4k54fF4OPGRf5u7CYoDhcqEe
         wGFMF6Jp9O/aTWM5vgjVnl+XxL5gv1G7nNpWjt2wl5Ta7VyslP/i+9WT8SiHBKUbzske
         97eWusbfL3KQEzNKMBTRarRDSP3yuAJNMTvI7jXB5iBrENdjSh6rTHRkpwn9h20bO7tE
         uHlY9wKQlyFIuHBU/A8pLkreSF1nj3mid79atVCeOrngnDFJl/YovkBTYIkklEtSpXyg
         aa1m2Y6nXaNXfb0EW8o24Ds4VTWgosCrkFCWsPPXsoM2K1e9kCZGEon36azBOpKsPHNC
         /29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=srwfPJxVIL0yVnmYxIpxeAMujgHX4vNSJddm4DFEsWo=;
        b=uPtkcwubm3pkNZvsVyD/bI+Mc2DnOl7Lmy9T4yPkqfjGUph5v3Vnq5lsAWmoOYt42q
         tn8hoJR63g+tOfr9PvI4CsrJwSJ5YgUa8cJ7ZmdCX7ZgrHMbwEteEbDtcRg4cOOpFw6Z
         RDX4si3pzjUov0e4M47wuhF7kl7ZAJqtmOymRXpeVX6vnI+pYlU9QavXXy7QHggp3s0+
         DdvE1FPN2+TM8eLTBgDwoaz+qADB8Qe657+7Zjqdp0k2XRiIw4pglRTFy/7SoNmYT4vR
         mczMOI7T08QI3Kezrte6PSMMI5B3LolpUfcS5ne0SV1TXTJ590DZ5ffsg9gYMT+0EhaI
         s9XQ==
X-Gm-Message-State: APjAAAVUQgHGjBWYfPADRUFvg1zgZfBJmso69QCgsqw3AtfveBudu/lo
        gu5g4CJ/66IHqj54mALEAbQxhpdhQoBRo1z7+AYZ1g==
X-Google-Smtp-Source: APXvYqxN/4Rm7ZGojSkIhkUN/KUbT9vJn3ihUUxagWwDqOi1vRMbH7PEUYZfqqfszMRvOV+Zd/mST/XJZJzN6vux6Lc=
X-Received: by 2002:a17:90a:2488:: with SMTP id i8mr12659243pje.123.1562950753587;
 Fri, 12 Jul 2019 09:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2beBPP+KX4zTfSfFPwo+7ksWZLqZzpP9BJ80iPecg3zA@mail.gmail.com>
 <20190711172621.a7ab7jorolicid3z@treble> <CAK8P3a0iOMpMW-dXUY6g75HGC4mUe3P3=gv447WZOW8jmw2Vgg@mail.gmail.com>
 <CAG48ez3ipuPHLxbqqc50=Kn4QuoNczkd7VqEoLPVd3WWLk2s+Q@mail.gmail.com>
 <CAK8P3a2=SJQp7Jvyf+BX-7XsUr8bh6eBMo6ue2m8FW4aYf=PPw@mail.gmail.com>
 <CAK8P3a1_8kjzamn6_joBbZTO8NeGn0E3O+MZ+bcOQ0HkkRHXRQ@mail.gmail.com>
 <20190712135755.7qa4wxw3bfmwn5rp@treble> <CAK8P3a13QFN59o9xOMce6K64jGnz+Cf=o3R_ORMo7j-65F5i8A@mail.gmail.com>
 <20190712142928.gmt6gibikdjmkppm@treble>
In-Reply-To: <20190712142928.gmt6gibikdjmkppm@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 12 Jul 2019 09:59:02 -0700
Message-ID: <CAKwvOdnOpgo9rEctZZR9Y9rEc60FCthbPtp62UsdMtkGDF5nUg@mail.gmail.com>
Subject: Re: objtool crashes on clang output (drivers/hwmon/pmbus/adm1275.o)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 7:29 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, Jul 12, 2019 at 04:19:02PM +0200, Arnd Bergmann wrote:
> > On Fri, Jul 12, 2019 at 3:57 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > On Fri, Jul 12, 2019 at 09:51:35AM +0200, Arnd Bergmann wrote:
> > > > I no longer see any of the "can't find switch jump table" in last
> > > > nights randconfig
> > > > builds. I do see one other rare warning, see attached object file:
> > > >
> > > > fs/reiserfs/do_balan.o: warning: objtool: replace_key()+0x158: stack
> > > > state mismatch: cfa1=7+40 cfa2=7+56
> > > > fs/reiserfs/do_balan.o: warning: objtool: balance_leaf()+0x2791: stack
> > > > state mismatch: cfa1=7+176 cfa2=7+192
> > > > fs/reiserfs/ibalance.o: warning: objtool: balance_internal()+0xe8f:
> > > > stack state mismatch: cfa1=7+240 cfa2=7+248
> > > > fs/reiserfs/ibalance.o: warning: objtool:
> > > > internal_move_pointers_items()+0x36f: stack state mismatch: cfa1=7+152
> > > > cfa2=7+144
> > > > fs/reiserfs/lbalance.o: warning: objtool:
> > > > leaf_cut_from_buffer()+0x58b: stack state mismatch: cfa1=7+128
> > > > cfa2=7+112
> > > > fs/reiserfs/lbalance.o: warning: objtool:
> > > > leaf_copy_boundary_item()+0x7a9: stack state mismatch: cfa1=7+104
> > > > cfa2=7+96
> > > > fs/reiserfs/lbalance.o: warning: objtool:
> > > > leaf_copy_items_entirely()+0x3d2: stack state mismatch: cfa1=7+120
> > > > cfa2=7+128
> > > >
> > > > I suspect this comes from the calls to the __reiserfs_panic() noreturn function,
> > > > but have not actually looked at the object file.
> > >
> > > Looking at one of the examples:
> > >
> > >     2346:       0f 85 6a 01 00 00       jne    24b6 <leaf_copy_items_entirely+0x3a8>
> > >     ...
> > >     23b1:       e9 2a 01 00 00          jmpq   24e0 <leaf_copy_items_entirely+0x3d2>
> > >     ...
> > >     24b6:       31 ff                   xor    %edi,%edi
> > >     24b8:       48 c7 c6 00 00 00 00    mov    $0x0,%rsi
> > >                         24bb: R_X86_64_32S      .rodata.str1.1
> > >     24bf:       48 c7 c2 00 00 00 00    mov    $0x0,%rdx
> > >                         24c2: R_X86_64_32S      .rodata.str1.1+0x127b
> > >     24c6:       48 c7 c1 00 00 00 00    mov    $0x0,%rcx
> > >                         24c9: R_X86_64_32S      .rodata.str1.1+0x1679
> > >     24cd:       41 b8 90 01 00 00       mov    $0x190,%r8d
> > >     24d3:       49 c7 c1 00 00 00 00    mov    $0x0,%r9
> > >                         24d6: R_X86_64_32S      .rodata.str1.1+0x127b
> > >     24da:       b8 00 00 00 00          mov    $0x0,%eax
> > >     24df:       55                      push   %rbp
> > >     24e0:       41 52                   push   %r10
> > >     24e2:       e8 00 00 00 00          callq  24e7 <leaf_item_bottle>
> > >                         24e3: R_X86_64_PC32     __reiserfs_panic-0x4
> > >
> > > Objtool is correct this time: There *is* a stack state mismatch at
> > > 0x24e0.  The stack size is different at 0x24e0, depending on whether it
> > > came from 0x2346 or from 0x23b1.
> > >
> > > In this case it's not a problem for code flow, because the basic block
> > > is a dead end.
> > >
> > > But it *is* a problem for unwinding.  The location of the previous stack
> > > frame is nondeterministic.
> > >
> > > And that's extra important for calls to noreturn functions, because they
> > > often dump the stack before exiting.
> > >
> > > So it looks like a compiler bug to me.
> >
> > The change below would shut up the warnings, and presumably avoid
> > the unwinding problem as well. Should I submit that for inclusion,
> > or should we try to fix clang first?
>
> That should work, though I guess it's up to the reiserfs maintainers.
>
> The issue still needs to get fixed in clang regardless.  There are other
> noreturn functions in the kernel and this problem could easily pop back
> up.

Sure, thanks for the report.  Arnd, can you help us get a more minimal
test case to understand the issue better?
-- 
Thanks,
~Nick Desaulniers
