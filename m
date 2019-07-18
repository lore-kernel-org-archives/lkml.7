Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D18C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 02:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2172173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 02:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="s/VtYSLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbfGRCUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 22:20:52 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:51549 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfGRCUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 22:20:52 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x6I2KY5k014174
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 11:20:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x6I2KY5k014174
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563416435;
        bh=tkHvMLjjjDHqsY1NCUmploWB82ITvFQnTe0kWRfY618=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s/VtYSLzYI8pZl0VRgeXLT4YVj2lKkT54FPRnAHyYMnb1IwjXkrAEGQk51yYDcvZR
         ci6S670X0uREaPAWNYuRz9/dT1w0annFJIRdupnNJsZLbh/0Mz7QeDK2N9T3fpuiYN
         guzzZpu3sE/X+h5RwPN87hupPUkbKq/k2mYy+9UWJDga/JCfqv6gBfMrPPOAcy5jqg
         qBUKhs908QTECo00p7NTF4XCndSgyyr5B16nwH0nTlygEM78CNm7otDQxf95/M1pNp
         3Gc6D8tv66TbRR/waBE3GassIOWVZV++ihnyQPtYkXU0NefbrQdwcvQJ0xYSp+NieV
         sEdkVEVS6Koig==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id c4so10508716uad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 19:20:35 -0700 (PDT)
X-Gm-Message-State: APjAAAUNaK8IcQFhUyzB35qjG06Q6SSM64ENlhaTKdPGm4BwHEQh5+Ab
        /NIfSVjQbYeW64YzgYzAE96CVlTka9RJYTmO0eM=
X-Google-Smtp-Source: APXvYqyDs8leywH3J63QVoya2xfCFpz3DtNeYlTeZ0uBmpp+YteurwkLd/rG1cd0yyBPuSLAqAEd7Ze7wSrtjyiiTDM=
X-Received: by 2002:ab0:70d9:: with SMTP id r25mr3602900ual.109.1563416434430;
 Wed, 17 Jul 2019 19:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190713032106.8509-1-yamada.masahiro@socionext.com>
 <20190713124744.GS14074@gate.crashing.org> <20190713131642.GU14074@gate.crashing.org>
 <CAK7LNASBmZxX+U=LS+dgvet96cA3T6Tf_tiAa2vduUV81DEnBw@mail.gmail.com>
 <20190713235430.GZ14074@gate.crashing.org> <87v9w393r5.fsf@concordia.ellerman.id.au>
 <20190715072959.GB20882@gate.crashing.org> <87pnma89ak.fsf@concordia.ellerman.id.au>
 <20190717143811.GL20882@gate.crashing.org> <CAK7LNATesRrJFGZQOkTY+PL7FNyub5FJ0N6NF4s6icdXdPNr+Q@mail.gmail.com>
 <20190717164628.GN20882@gate.crashing.org>
In-Reply-To: <20190717164628.GN20882@gate.crashing.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 18 Jul 2019 11:19:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR7jkq1fAi_=xgsANCkgP2AAej9Yv7RZB3B_cpD7C_71Q@mail.gmail.com>
Message-ID: <CAK7LNAR7jkq1fAi_=xgsANCkgP2AAej9Yv7RZB3B_cpD7C_71Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc: remove meaningless KBUILD_ARFLAGS addition
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 1:46 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Thu, Jul 18, 2019 at 12:19:36AM +0900, Masahiro Yamada wrote:
> > On Wed, Jul 17, 2019 at 11:38 PM Segher Boessenkool
> > <segher@kernel.crashing.org> wrote:
> > >
> > > On Tue, Jul 16, 2019 at 10:15:47PM +1000, Michael Ellerman wrote:
> > > > Segher Boessenkool <segher@kernel.crashing.org> writes:
> > > > And it's definitely calling ar with no flags, eg:
> > > >
> > > >   rm -f init/built-in.a; powerpc-linux-ar rcSTPD init/built-in.a init/main.o init/version.o init/do_mounts.o init/do_mounts_rd.o init/do_mounts_initrd.o init/do_mounts_md.o init/initramfs.o init/init_task.o
> > >
> > > This uses thin archives.  Those will work fine.
> > >
> > > The failing case was empty files IIRC, stuff created from no inputs.
> >
> > Actually, empty files are created everywhere.
>
> >        cmd_ar_builtin = rm -f $@; $(AR) rcSTP$(KBUILD_ARFLAGS) $@
> > $(real-prereqs)
>
> You use thin archives.
>
> Does every config use thin archives always nowadays?

Kbuild always uses thin archives as far as vmlinux is concerned.

But, there are some other call-sites.

masahiro@pug:~/ref/linux$ git grep  '$(AR)' -- :^Documentation :^tools
arch/powerpc/boot/Makefile:    BOOTAR := $(AR)
arch/unicore32/lib/Makefile:    $(Q)$(AR) p $(GNU_LIBC_A) $(notdir $@) > $@
arch/unicore32/lib/Makefile:    $(Q)$(AR) p $(GNU_LIBGCC_A) $(notdir $@) > $@
lib/raid6/test/Makefile:         $(AR) cq $@ $^
scripts/Kbuild.include:ar-option = $(call try-run, $(AR) rc$(1)
"$$TMP",$(1),$(2))
scripts/Makefile.build:      cmd_ar_builtin = rm -f $@; $(AR)
rcSTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
scripts/Makefile.lib:      cmd_ar = rm -f $@; $(AR)
rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)


Probably, you are interested in arch/powerpc/boot/Makefile.
This does not seem a thin archive.


> > BTW, your commit 8995ac8702737147115e1c75879a1a2d75627b9e
> > dates back to 2008.
> >
> > At that time, thin archive was not used.
>
> Yes, I know.  This isn't about built-in.[oa], it is about *other*
> archives we at least *used to* create.  If we *know* we do not anymore,
> then this workaround can of course be removed (and good riddance).

If it is not about built-in.[oa],
which archive are you talking about?

Can you pin-point the one?

masahiro@pug:~/ref/linux$ git log --oneline  -1
8995ac870273 (HEAD) [POWERPC] Specify GNUTARGET on $(AR) invocations
masahiro@pug:~/ref/linux$ git grep '(AR)'
Documentation/kbuild/makefiles.txt:     per-directory options to $(LD)
and $(AR).
arch/powerpc/Makefile:CROSS32AR := GNUTARGET=elf32-powerpc $(AR)
arch/powerpc/Makefile:override AR       := GNUTARGET=elf$(SZ)-powerpc $(AR)
drivers/md/raid6test/Makefile:   $(AR) cq $@ $^
scripts/Makefile.build:               rm -f $@; $(AR) rcs $@)
scripts/Makefile.build:cmd_link_l_target = rm -f $@; $(AR)
$(EXTRA_ARFLAGS) rcs $@ $(lib-y)
masahiro@pug:~/ref/linux$ git grep '(CROSS32AR)'
arch/powerpc/boot/Makefile:      cmd_bootar = $(CROSS32AR) -cr $@.$$$$
$(filter-out FORCE,$^); mv $@.$$$$ $@



> If ar creates an archive file (a real one, not a thin archive), and it
> has no input files, it uses its default object format as destination
> format, if it isn't told to use something else.  And that doesn't work,
> it needs to use some format compatible with what that archive later is
> linked with.

I compile-tested v4.10, which was before the thin-archive migration,
but I did not see any problem for building ppc32/64.

Whether or not it is a thin archive,
an empty archive is always 8-byte file.

masahiro@pug:~/ref/linux$ cat kernel/livepatch/built-in.o
!<arch>

Is there a room for caring about the under-lying architecture?


-- 
Best Regards
Masahiro Yamada
