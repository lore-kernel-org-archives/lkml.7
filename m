Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E739C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6C6206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Q8nfKFUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfCEQJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:09:19 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:55003 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbfCEQJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:09:19 -0500
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x25G94Ge004459;
        Wed, 6 Mar 2019 01:09:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x25G94Ge004459
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551802145;
        bh=lL/vr7WzFFbs3ehKX38udeZ0q4oD/E4sPcEzYdBZiyk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q8nfKFUQesJvO4QspW2yHd/hBZUylauPnGDvMFNJ73U47+MvWczMGFJUybTBoCR8Z
         wS8+b6uR8gNWck6Vy/fN3PHbcqOV2FFiqK3uoN56M8GSKQ8K2CEGcj9YjS83RD0ZG/
         9eBJRhbANuIYH7wmtAIePua51HiUAbzcSBGEprfPXvE7z985jVEyBkg82o7jvbPS2R
         rMLRQ1mUGoonWQ7iRu8FVOdi9JOH9mPEQ+YaD8vpPPWr7hnJcce6+Plh7hAf+aCSs6
         PefkvgvuYMeeFTa/86ap0uU6f8wy26GBw/YJoLpJiKi0JQevz6pSvi61U/D/CZYUFR
         GJ2Rdlm5d0sXA==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id i15so343728vsd.10;
        Tue, 05 Mar 2019 08:09:04 -0800 (PST)
X-Gm-Message-State: APjAAAVYvbIKBQjN9iosNvyqxNrBaCpmdj2C5nmAMnEs3zQaNvkKZ+2o
        FOHH+pcEZZi6zyklNfgdM0CY8sVkxe6xQ8fgSCE=
X-Google-Smtp-Source: APXvYqx2B4fMD6+4xitLEYGw7uKdI+tZasbfe7++mJtnhcFJVM0Cy73NRLMmTTCe9Xq+HKf7ZCvHq5TWyIP6qK4KSSY=
X-Received: by 2002:a67:7c04:: with SMTP id x4mr1515164vsc.155.1551802143472;
 Tue, 05 Mar 2019 08:09:03 -0800 (PST)
MIME-Version: 1.0
References: <1551764896-8453-1-git-send-email-yamada.masahiro@socionext.com>
 <1551764896-8453-3-git-send-email-yamada.masahiro@socionext.com> <20190305144625.bjmkr6ebufbly5ba@treble>
In-Reply-To: <20190305144625.bjmkr6ebufbly5ba@treble>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 6 Mar 2019 01:08:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS=K2Hp+idOsHQBCYwk5YndzSdHL=GmJZRxsF6De3isNA@mail.gmail.com>
Message-ID: <CAK7LNAS=K2Hp+idOsHQBCYwk5YndzSdHL=GmJZRxsF6De3isNA@mail.gmail.com>
Subject: Re: [PATCH 3/3] objtool: move tools/objtool/ to scripts/objtool/
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        Robin Meijboom <robin@meijboom.info>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 11:46 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Tue, Mar 05, 2019 at 02:48:16PM +0900, Masahiro Yamada wrote:
> > Tools that are globally needed for building the kernel are supposed to
> > be put in the scripts/ directory, but objtool is the exceptional one.
> >
> > People were confused by objtool's Makefile since most of tools run on
> > the target whereas objtool runs on the host machine. Some time ago,
> > Douglas Anderson suggested to move tools/objtool/ to scripts/tools/
> > (https://patchwork.kernel.org/patch/9983535/#20996057), but we did
> > not go as far as submitting a patch at that time.
> >
> > Recently, Robin Meijboom reported that the generated files for objtool
> > were never cleaned up. (https://patchwork.kernel.org/patch/10813797/)
> >
> > So, I looked into this to fix the distortion. Move tools/objtool/ to
> > scripts/objtool/, and rewrite Makefiles in the Kbuild-ish manner.
> >
> > I also cleaned up the top-level Makefile by moving the libelf check
> > scripts/objtool/Makefile.
> >
> > I see some benefits in this.
> >
> > [1] generated files under scripts/ are cleaned up by 'make mrproper'
> >
> > Currently, the generated files under tools/objtool/ are not cleaned up
> > since the build system under tools/ is a complete different world.
> >
> > If we want to clean them up, it should be done by 'make mrproper'
> > instead of 'make clean' since objtool is needed for building external
> > modules.
> >
> > This commit naturally solves the issue since Kbuild cleans under
> > scripts/ by 'make mrproper'.
>
> Yes, but this can be solved instead with a one-line patch.
>
> > [2] build log looks nicer
> >
> > Currently, the build log under tools/objtool/ shows absolute paths, and
> > displays 'DESCEND  objtool' every time for incremental building.
> >
> > Switching over to the standard Kbuild scheme will improve the log.
> >
> >   Before:
> >
> >   DESCEND  objtool
> >   HOSTCC   /home/masahiro/workspace/linux/tools/objtool/fixdep.o
> >   HOSTLD   /home/masahiro/workspace/linux/tools/objtool/fixdep-in.o
> >   LINK     /home/masahiro/workspace/linux/tools/objtool/fixdep
> >   CC       /home/masahiro/workspace/linux/tools/objtool/exec-cmd.o
> >   CC       /home/masahiro/workspace/linux/tools/objtool/help.o
> >   CC       /home/masahiro/workspace/linux/tools/objtool/pager.o
> >   CC       /home/masahiro/workspace/linux/tools/objtool/parse-options.o
> >   CC       /home/masahiro/workspace/linux/tools/objtool/run-command.o
> >   CC       /home/masahiro/workspace/linux/tools/objtool/sigchain.o
> >   CC       /home/masahiro/workspace/linux/tools/objtool/subcmd-config.o
> >   LD       /home/masahiro/workspace/linux/tools/objtool/libsubcmd-in.o
> >   AR       /home/masahiro/workspace/linux/tools/objtool/libsubcmd.a
> >   GEN      /home/masahiro/workspace/linux/tools/objtool/arch/x86/lib/inat-tables.c
> >   CC       /home/masahiro/workspace/linux/tools/objtool/arch/x86/decode.o
> >   LD       /home/masahiro/workspace/linux/tools/objtool/arch/x86/objtool-in.o
> >   CC       /home/masahiro/workspace/linux/tools/objtool/builtin-check.o
> >   CC       /home/masahiro/workspace/linux/tools/objtool/builtin-orc.o
> >   CC       /home/masahiro/workspace/linux/tools/objtool/check.o
> >   CC       /home/masahiro/workspace/linux/tools/objtool/orc_gen.o
> >   CC       /home/masahiro/workspace/linux/tools/objtool/orc_dump.o
> >   CC       /home/masahiro/workspace/linux/tools/objtool/elf.o
> >   CC       /home/masahiro/workspace/linux/tools/objtool/special.o
> >   CC       /home/masahiro/workspace/linux/tools/objtool/objtool.o
> >   CC       /home/masahiro/workspace/linux/tools/objtool/libstring.o
> >   CC       /home/masahiro/workspace/linux/tools/objtool/str_error_r.o
> >   LD       /home/masahiro/workspace/linux/tools/objtool/objtool-in.o
> >   LINK     /home/masahiro/workspace/linux/tools/objtool/objtool
> >
> >   After:
> >
> >   HOSTCC  scripts/objtool/builtin-check.o
> >   HOSTCC  scripts/objtool/builtin-orc.o
> >   HOSTCC  scripts/objtool/check.o
> >   HOSTCC  scripts/objtool/orc_gen.o
> >   HOSTCC  scripts/objtool/orc_dump.o
> >   HOSTCC  scripts/objtool/elf.o
> >   HOSTCC  scripts/objtool/special.o
> >   HOSTCC  scripts/objtool/objtool.o
> >   HOSTCC  scripts/objtool/libstring.o
> >   HOSTCC  scripts/objtool/str_error_r.o
> >   HOSTCC  scripts/objtool/exec-cmd.o
> >   HOSTCC  scripts/objtool/pager.o
> >   HOSTCC  scripts/objtool/parse-options.o
> >   HOSTCC  scripts/objtool/run-command.o
> >   HOSTCC  scripts/objtool/sigchain.o
> >   HOSTCC  scripts/objtool/subcmd-config.o
> >   AWK     scripts/objtool/arch/x86/lib/inat-tables.c
> >   HOSTCC  scripts/objtool/arch/x86/decode.o
> >   HOSTLD  scripts/objtool/objtool
>
> That does look better.
>
> > [3] simplify distro package script
> >
> > The special handling in scripts/package/buildeb is no longer needed
> > since all host programs are copied to linux-headers packages.
>
> I do see the benefits.  In many ways objtool is a more natural fit in
> the scripts dir.  But there are also some downsides to this change:
>
> - This will make it harder to package objtool as a standalone tool.  It
>   has a lot of functionality that could be useful to other non-kernel
>   projects.


If it is really useful for other projects,
I'd like to see it as a real standalone tool,
i.e. split as a separate project.


> - It shares libsubcmd with perf.  Including the subcmd .c files from
>   tools is hacky.

Yes, hacky. We are shifting the ugliness between C and Build system.

But, this hack can be solved; if subcmd library is useful, you can copy
only necessary code into the objtool directory. You do not need all
helpers from libsubcmd.


> - It's disruptive: it will break all the out-of-tree distro kernel
>   packaging scripts which now look for objtool in tools.

All artifacts under scripts/ should be contained in the package.
So, it should work.


> You're right that objtool isn't a natural fit in tools, because it's
> also used as part of the build.  But it's not a natural fit in scripts
> either.  I think we've resolved most of those issues and it seems to be
> working well these days.
>
> So instead of disrupting everything because "make mrproper" doesn't
> work, I think I'd rather just do the following:
>
> diff --git a/Makefile b/Makefile
> index ac5ac28a24e9..7e6696c9b862 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1364,7 +1364,7 @@ PHONY += $(mrproper-dirs) mrproper
>  $(mrproper-dirs):
>         $(Q)$(MAKE) $(clean)=$(patsubst _mrproper_%,%,$@)
>
> -mrproper: clean $(mrproper-dirs)
> +mrproper: clean $(mrproper-dirs) tools/objtool_clean
>         $(call cmd,rmdirs)
>         $(call cmd,rmfiles)
>

Works, and the clean log is also brilliant.

I see the same log even when
there is nothing to clean.


masahiro@grover:~/ref/linux$ make mrproper
  CLEAN   .
  CLEAN   arch/x86/entry/vdso
  CLEAN   usr
  CLEAN   arch/x86/tools
  CLEAN   .tmp_versions
  CLEAN   scripts/basic
  CLEAN   scripts/kconfig
  CLEAN   scripts/mod
  CLEAN   scripts/selinux/genheaders
  CLEAN   scripts/selinux/mdp
  CLEAN   scripts
  DESCEND  objtool
  CLEAN    objtool
  CLEAN   include/config include/generated arch/x86/include/generated
  CLEAN   .config
masahiro@grover:~/ref/linux$ make mrproper
  DESCEND  objtool
  CLEAN    objtool
masahiro@grover:~/ref/linux$ make mrproper
  DESCEND  objtool
  CLEAN    objtool



-- 
Best Regards
Masahiro Yamada
