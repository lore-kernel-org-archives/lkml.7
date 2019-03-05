Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07996C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA51520842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfCEOqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 09:46:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbfCEOqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 09:46:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7CD19307D987;
        Tue,  5 Mar 2019 14:46:38 +0000 (UTC)
Received: from treble (ovpn-126-179.rdu2.redhat.com [10.10.126.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D94685C1A1;
        Tue,  5 Mar 2019 14:46:28 +0000 (UTC)
Date:   Tue, 5 Mar 2019 08:46:25 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        Robin Meijboom <robin@meijboom.info>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH 3/3] objtool: move tools/objtool/ to scripts/objtool/
Message-ID: <20190305144625.bjmkr6ebufbly5ba@treble>
References: <1551764896-8453-1-git-send-email-yamada.masahiro@socionext.com>
 <1551764896-8453-3-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1551764896-8453-3-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 05 Mar 2019 14:46:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 02:48:16PM +0900, Masahiro Yamada wrote:
> Tools that are globally needed for building the kernel are supposed to
> be put in the scripts/ directory, but objtool is the exceptional one.
> 
> People were confused by objtool's Makefile since most of tools run on
> the target whereas objtool runs on the host machine. Some time ago,
> Douglas Anderson suggested to move tools/objtool/ to scripts/tools/
> (https://patchwork.kernel.org/patch/9983535/#20996057), but we did
> not go as far as submitting a patch at that time.
> 
> Recently, Robin Meijboom reported that the generated files for objtool
> were never cleaned up. (https://patchwork.kernel.org/patch/10813797/)
> 
> So, I looked into this to fix the distortion. Move tools/objtool/ to
> scripts/objtool/, and rewrite Makefiles in the Kbuild-ish manner.
> 
> I also cleaned up the top-level Makefile by moving the libelf check
> scripts/objtool/Makefile.
>
> I see some benefits in this.
> 
> [1] generated files under scripts/ are cleaned up by 'make mrproper'
> 
> Currently, the generated files under tools/objtool/ are not cleaned up
> since the build system under tools/ is a complete different world.
> 
> If we want to clean them up, it should be done by 'make mrproper'
> instead of 'make clean' since objtool is needed for building external
> modules.
> 
> This commit naturally solves the issue since Kbuild cleans under
> scripts/ by 'make mrproper'.

Yes, but this can be solved instead with a one-line patch.

> [2] build log looks nicer
> 
> Currently, the build log under tools/objtool/ shows absolute paths, and
> displays 'DESCEND  objtool' every time for incremental building.
> 
> Switching over to the standard Kbuild scheme will improve the log.
> 
>   Before:
> 
>   DESCEND  objtool
>   HOSTCC   /home/masahiro/workspace/linux/tools/objtool/fixdep.o
>   HOSTLD   /home/masahiro/workspace/linux/tools/objtool/fixdep-in.o
>   LINK     /home/masahiro/workspace/linux/tools/objtool/fixdep
>   CC       /home/masahiro/workspace/linux/tools/objtool/exec-cmd.o
>   CC       /home/masahiro/workspace/linux/tools/objtool/help.o
>   CC       /home/masahiro/workspace/linux/tools/objtool/pager.o
>   CC       /home/masahiro/workspace/linux/tools/objtool/parse-options.o
>   CC       /home/masahiro/workspace/linux/tools/objtool/run-command.o
>   CC       /home/masahiro/workspace/linux/tools/objtool/sigchain.o
>   CC       /home/masahiro/workspace/linux/tools/objtool/subcmd-config.o
>   LD       /home/masahiro/workspace/linux/tools/objtool/libsubcmd-in.o
>   AR       /home/masahiro/workspace/linux/tools/objtool/libsubcmd.a
>   GEN      /home/masahiro/workspace/linux/tools/objtool/arch/x86/lib/inat-tables.c
>   CC       /home/masahiro/workspace/linux/tools/objtool/arch/x86/decode.o
>   LD       /home/masahiro/workspace/linux/tools/objtool/arch/x86/objtool-in.o
>   CC       /home/masahiro/workspace/linux/tools/objtool/builtin-check.o
>   CC       /home/masahiro/workspace/linux/tools/objtool/builtin-orc.o
>   CC       /home/masahiro/workspace/linux/tools/objtool/check.o
>   CC       /home/masahiro/workspace/linux/tools/objtool/orc_gen.o
>   CC       /home/masahiro/workspace/linux/tools/objtool/orc_dump.o
>   CC       /home/masahiro/workspace/linux/tools/objtool/elf.o
>   CC       /home/masahiro/workspace/linux/tools/objtool/special.o
>   CC       /home/masahiro/workspace/linux/tools/objtool/objtool.o
>   CC       /home/masahiro/workspace/linux/tools/objtool/libstring.o
>   CC       /home/masahiro/workspace/linux/tools/objtool/str_error_r.o
>   LD       /home/masahiro/workspace/linux/tools/objtool/objtool-in.o
>   LINK     /home/masahiro/workspace/linux/tools/objtool/objtool
> 
>   After:
> 
>   HOSTCC  scripts/objtool/builtin-check.o
>   HOSTCC  scripts/objtool/builtin-orc.o
>   HOSTCC  scripts/objtool/check.o
>   HOSTCC  scripts/objtool/orc_gen.o
>   HOSTCC  scripts/objtool/orc_dump.o
>   HOSTCC  scripts/objtool/elf.o
>   HOSTCC  scripts/objtool/special.o
>   HOSTCC  scripts/objtool/objtool.o
>   HOSTCC  scripts/objtool/libstring.o
>   HOSTCC  scripts/objtool/str_error_r.o
>   HOSTCC  scripts/objtool/exec-cmd.o
>   HOSTCC  scripts/objtool/pager.o
>   HOSTCC  scripts/objtool/parse-options.o
>   HOSTCC  scripts/objtool/run-command.o
>   HOSTCC  scripts/objtool/sigchain.o
>   HOSTCC  scripts/objtool/subcmd-config.o
>   AWK     scripts/objtool/arch/x86/lib/inat-tables.c
>   HOSTCC  scripts/objtool/arch/x86/decode.o
>   HOSTLD  scripts/objtool/objtool

That does look better.

> [3] simplify distro package script
> 
> The special handling in scripts/package/buildeb is no longer needed
> since all host programs are copied to linux-headers packages.

I do see the benefits.  In many ways objtool is a more natural fit in
the scripts dir.  But there are also some downsides to this change:

- This will make it harder to package objtool as a standalone tool.  It
  has a lot of functionality that could be useful to other non-kernel
  projects.

- It shares libsubcmd with perf.  Including the subcmd .c files from
  tools is hacky.

- It's disruptive: it will break all the out-of-tree distro kernel
  packaging scripts which now look for objtool in tools.

You're right that objtool isn't a natural fit in tools, because it's
also used as part of the build.  But it's not a natural fit in scripts
either.  I think we've resolved most of those issues and it seems to be
working well these days.

So instead of disrupting everything because "make mrproper" doesn't
work, I think I'd rather just do the following:

diff --git a/Makefile b/Makefile
index ac5ac28a24e9..7e6696c9b862 100644
--- a/Makefile
+++ b/Makefile
@@ -1364,7 +1364,7 @@ PHONY += $(mrproper-dirs) mrproper
 $(mrproper-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _mrproper_%,%,$@)
 
-mrproper: clean $(mrproper-dirs)
+mrproper: clean $(mrproper-dirs) tools/objtool_clean
 	$(call cmd,rmdirs)
 	$(call cmd,rmfiles)
 
