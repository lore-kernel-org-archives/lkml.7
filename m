Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C64C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 11:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0D220820
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 11:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bfJjSrkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfIVLrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 07:47:32 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:41473 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfIVLrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 07:47:31 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x8MBlGws008977;
        Sun, 22 Sep 2019 20:47:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x8MBlGws008977
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569152837;
        bh=c33RUhQDyA7qTPf1bNP6RgmMg8enhc22BBtjuXN8Qeg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bfJjSrkclHoGzcbaD65NOPYFaDw5jh9vNa4Hucc3Hpzfib0y/P0VLQOibgbQrm6EC
         jWnsMnNwMesC6yNBk4H2Kr4KvSS9tMUJSj7DK6gj4HQebK++FFEClOT1ZGrYpczFoZ
         9VUlkB7m3VKPo4BupkudSNn7clrzYZ1jD4gGaiUgWtbgN7YymNfy2VCP7M6YL4AONV
         GoBTmZSshVgyFTT5TrqkxXL+8DBiJkPg+Z5DvrdXdTD5SkFr+6u8xYaPcjb0Dt6Bbs
         Eq3zuExieFSxRzkOcU2Gpa+DwU5syp/hw8JzQVSkZTwTTaC4sR8ce2lYTVhuDtXmbW
         hb0EejQMK87Bw==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id b123so7628804vsb.5;
        Sun, 22 Sep 2019 04:47:17 -0700 (PDT)
X-Gm-Message-State: APjAAAVzCEC6lhbTEzkfcNj/bLiPca3L79pRnZoUOuwEQumhbXz6Pm6q
        JA5sDVIunlq3M1mZSigGsgryDggZSTYwOWebz10=
X-Google-Smtp-Source: APXvYqw3dTewpaEao15w5tFbkbFX9jEXfG6viAF/I1+GLCE2J9qMR25B6KWYv82e0fVVJFwHDftJ2qo+S/ilfzP/i0s=
X-Received: by 2002:a67:ec09:: with SMTP id d9mr7546079vso.215.1569152836113;
 Sun, 22 Sep 2019 04:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <CADxRZqwizJ2HXdiU7aSH9t=ecBEHnxdVVsQ4wUpTYRpCgdXf=w@mail.gmail.com>
 <CADxRZqzx=8jNQuvi8WN=7U_G5a0f+v_GODHH8q3QJVYmg=n1LA@mail.gmail.com>
In-Reply-To: <CADxRZqzx=8jNQuvi8WN=7U_G5a0f+v_GODHH8q3QJVYmg=n1LA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 22 Sep 2019 20:46:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNASgNh04dAn6Fe4A2Dfhu55Vtk=jeNqC6_HNQHbyNMkoZA@mail.gmail.com>
Message-ID: <CAK7LNASgNh04dAn6Fe4A2Dfhu55Vtk=jeNqC6_HNQHbyNMkoZA@mail.gmail.com>
Subject: Re: latest git kernel (v5.3-11506-gf7c3bf8fa7e5) does not compile
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2019 at 5:33 PM Anatoly Pugachev <matorola@gmail.com> wrote:
>
> On Sun, Sep 22, 2019 at 11:13 AM Anatoly Pugachev <matorola@gmail.com> wrote:
> >
> > Hello!
> >
> > Latest git kernel does not compile for me:
> >
> > ~/linux-2.6$ git desc
> > v5.3-11506-gf7c3bf8fa7e5
> >
> > ~/linux-2.6$ make
> >   CALL    scripts/checksyscalls.sh
> > <stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> >   CALL    scripts/atomic/check-atomics.sh
> >   CHK     include/generated/compile.h
> >   CC      arch/sparc/vdso/vdso32/vclock_gettime.o
> > unrecognized e_machine 18 arch/sparc/vdso/vdso32/vclock_gettime.o
> > arch/sparc/vdso/vdso32/vclock_gettime.o: failed
> > make[2]: *** [scripts/Makefile.build:266:
> > arch/sparc/vdso/vdso32/vclock_gettime.o] Error 1
> > make[2]: *** Deleting file 'arch/sparc/vdso/vdso32/vclock_gettime.o'
> > make[1]: *** [scripts/Makefile.build:509: arch/sparc/vdso] Error 2
> > make: *** [Makefile:1667: arch/sparc] Error
> >
> > but I was able to compile successfully v5.3-10169-g574cc4539762
> >
> > Not sure my bisect log is right, but here it is:
> >
> > $ git bisect good
> > 54b8ae66ae1a3454a7645d159a482c31cd89ab33 is the first bad commit
> > commit 54b8ae66ae1a3454a7645d159a482c31cd89ab33
> > Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Date:   Fri Aug 30 13:34:01 2019 +0900
> >
> >     kbuild: change *FLAGS_<basetarget>.o to take the path relative to $(obj)
> >
> >     Kbuild provides per-file compiler flag addition/removal:
> >
> >       CFLAGS_<basetarget>.o
> >       CFLAGS_REMOVE_<basetarget>.o
> >       AFLAGS_<basetarget>.o
> >       AFLAGS_REMOVE_<basetarget>.o
> >       CPPFLAGS_<basetarget>.lds
> >       HOSTCFLAGS_<basetarget>.o
> >       HOSTCXXFLAGS_<basetarget>.o
> >
> >     The <basetarget> is the filename of the target with its directory and
> >     suffix stripped.
> >
> >     This syntax comes into a trouble when two files with the same basename
> >     appear in one Makefile, for example:
> >
> >       obj-y += foo.o
> >       obj-y += dir/foo.o
> >       CFLAGS_foo.o := <some-flags>
> >
> >     Here, the <some-flags> applies to both foo.o and dir/foo.o
> >
> >     The real world problem is:
> >
> >       scripts/kconfig/util.c
> >       scripts/kconfig/lxdialog/util.c
> >
> >     Both files are compiled into scripts/kconfig/mconf, but only the
> >     latter should be given with the ncurses flags.
> >
> >     It is more sensible to use the relative path to the Makefile, like this:
> >
> >       obj-y += foo.o
> >       CFLAGS_foo.o := <some-flags>
> >       obj-y += dir/foo.o
> >       CFLAGS_dir/foo.o := <other-flags>
> >
> >     At first, I attempted to replace $(basetarget) with $*. The $* variable
> >     is replaced with the stem ('%') part in a pattern rule. This works with
> >     most of cases, but does not for explicit rules.
> >
> >     For example, arch/ia64/lib/Makefile reuses rule_as_o_S in its own
> >     explicit rules, so $* will be empty, resulting in ignoring the per-file
> >     AFLAGS.
> >
> >     I introduced a new variable, target-stem, which can be used also from
> >     explicit rules.
> >
> >     Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >     Acked-by: Marc Zyngier <maz@kernel.org>
> >
> >  arch/arm/kvm/Makefile                         |  5 +++--
> >  arch/x86/entry/vdso/Makefile                  |  3 ++-
> >  drivers/gpu/drm/amd/display/dc/calcs/Makefile |  6 +++---
> >  drivers/gpu/drm/amd/display/dc/dcn20/Makefile |  2 +-
> >  drivers/gpu/drm/amd/display/dc/dml/Makefile   | 17 +++++++----------
> >  drivers/gpu/drm/amd/display/dc/dsc/Makefile   |  7 +++----
> >  drivers/gpu/drm/i915/Makefile                 |  2 +-
> >  scripts/Makefile.host                         | 22 +++++++++++-----------
> >  scripts/Makefile.lib                          | 13 ++++++++-----
> >  scripts/kconfig/Makefile                      |  8 ++++----
> >  10 files changed, 43 insertions(+), 42 deletions(-)
> > mator@ttip:~/linux-2.6$
> >
> >
> > If someone wants to check how kernel compiles on sparc64, could use
> > gcc compile farm machine (gcc202) to try on.
>
> and i cannot test compile 54b8ae66ae1a3454a7645d159a482c31cd89ab33 as well :
>
> ~/linux-2.6$ git checkout 54b8ae66ae1a3454a7645d159a482c31cd89ab33
> HEAD is now at 54b8ae66ae1a kbuild: change *FLAGS_<basetarget>.o to
> take the path relative to $(obj)
>
> ~/linux-2.6$ make -j clean; make -j olddefconfig && nice make -j24
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTCC  scripts/kconfig/confdata.o
>   HOSTCC  scripts/kconfig/expr.o
>   LEX     scripts/kconfig/lexer.lex.c
>   YACC    scripts/kconfig/parser.tab.[ch]
>   HOSTCC  scripts/kconfig/preprocess.o
>   HOSTCC  scripts/kconfig/symbol.o
>   HOSTCC  scripts/kconfig/lexer.lex.o
>   HOSTCC  scripts/kconfig/parser.tab.o
>   HOSTLD  scripts/kconfig/conf
> scripts/kconfig/conf  --olddefconfig Kconfig
> #
> # No change to .config
> #
> scripts/kconfig/conf  --syncconfig Kconfig
> { command -v gcc; } >/dev/null 2>&1 && echo "n" || echo "y": Cannot
> allocate memory
> make[2]: *** [scripts/kconfig/Makefile:73: syncconfig] Error 1
> make[1]: *** [Makefile:584: syncconfig] Error 2
> make: *** [Makefile:695: include/config/auto.conf.cmd] Error 2
> ~/linux-2.6$
>
>
>
> PS: unable to compile kernel makes its bisection impossible =(


I have no idea about this error because this
seems unrelated to commit 54b8ae66ae1a3454a7645d159a482c31cd89ab33

From the error message "Cannot allocate memory",
maybe, your machine was in the memory shortage.

(If you have the steps to reproduce it, please share it.)

Thanks.

-- 
Best Regards
Masahiro Yamada
