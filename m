Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0896C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83ABB206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbfDDLcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:32:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:55156 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728543AbfDDLcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:32:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5EE88AE67;
        Thu,  4 Apr 2019 11:31:58 +0000 (UTC)
Date:   Thu, 4 Apr 2019 13:31:57 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     Joao Moreira <jmoreira@suse.de>, live-patching@vger.kernel.org,
        pmladek@suse.cz, jikos@suse.cz, nstange@suse.de,
        jpoimboe@redhat.com, khlebnikov@yandex-team.ru, jeyu@kernel.org,
        matz@suse.de, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com, linux-kbuild@vger.kernel.org,
        michal.lkml@markovi.net
Subject: Re: [PATCH v2 5/8] modpost: Integrate klp-convert
In-Reply-To: <20190322145404.GA31248@redhat.com>
Message-ID: <alpine.LSU.2.21.1904041329400.32428@pobox.suse.cz>
References: <20190301141313.15057-1-jmoreira@suse.de> <20190301141313.15057-6-jmoreira@suse.de> <20190322145404.GA31248@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2019, Joe Lawrence wrote:

> On Fri, Mar 01, 2019 at 11:13:10AM -0300, Joao Moreira wrote:
> > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > 
> > Create cmd_klp_convert and hook it into scripts/Makefile.modpost.
> > cmd_klp_convert invokes klp-convert with the right arguments for the
> > conversion of unresolved symbols inside a livepatch.
> > 
> > [khlebnikov:
> > * save cmd_ld_ko_o into .module.cmd, if_changed_rule doesn't do that
> > * fix bashisms for debian where /bin/sh is a symlink to /bin/dash
> > * rename rule_link_module to rule_ld_ko_o, otherwise arg-check inside
> >   if_changed_rule compares cmd_link_module and cmd_ld_ko_o
> > * check modinfo -F livepatch only if CONFIG_LIVEPATCH is true
> > ]
> > 
> > [mbenes:
> > * remove modinfo call. LIVEPATCH_ in Makefiled
> > ]
> > 
> > [jmoreira:
> > * split up: move the .livepatch file-based scheme for identifying
> > livepatches to a previous patch, as it was required for correctly
> > building Symbols.list there.
> > ]
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> > Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> > Signed-off-by: Joao Moreira <jmoreira@suse.de>
> > ---
> >  scripts/Kbuild.include   |  4 +++-
> >  scripts/Makefile.modpost | 16 +++++++++++++++-
> >  scripts/mod/modpost.c    |  6 +++++-
> >  scripts/mod/modpost.h    |  1 +
> >  4 files changed, 24 insertions(+), 3 deletions(-)
> > 
> >
> > [ ... snip ... ]
> >
> > diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> > index 7d4af0d0accb..da779a185218 100644
> > --- a/scripts/Makefile.modpost
> > +++ b/scripts/Makefile.modpost
> > @@ -125,8 +125,22 @@ quiet_cmd_ld_ko_o = LD [M]  $@
> >                   -o $@ $(filter-out FORCE,$^) ;                         \
> >  	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
> >  
> > +SLIST = $(objtree)/Symbols.list
> > +KLP_CONVERT = scripts/livepatch/klp-convert
> > +quiet_cmd_klp_convert = KLP $@
> > +      cmd_klp_convert = mv $@ $(@:.ko=.klp.o);				\
> > +			$(KLP_CONVERT) $(SLIST) $(@:.ko=.klp.o) $@
> > +
> > +define rule_ld_ko_o
> > +	$(call cmd,ld_ko_o) $(cmd_ld_ko_o) ;				\
>                            ^
> Should there be a ';' semicolon here (and maybe a line-break) between
> $(call cmd,ld_ko_o) and $(cmd_ld_ko_o)?

Probably yes.

Originally there was
	$(call echo-cmd,ld_ko_o) $(cmd_ld_ko_o) ;

but "echo-" disappeared somewhere. Joao?

So maybe even
	$(call cmd,ld_ko_o)
could be enough, because cmd contains echo-cmd, but I'm not good at 
reading scripts/Kbuild.include.
 
> I didn't see this in my x86_64 VM, but on a ppc64le box, I kept getting
> really strange build errors that I traced to this line.  Without a
> semicolon, the build was trying to run a make command with a linker
> command smashed onto the end of it:
> 
>   make -f ./arch/powerpc/Makefile.postlink crypto/xts.ko ld -r  -EL -m elf64lppc -T ./scripts/module-common.lds -T ./arch/powerpc/kernel/module.lds --save-restore-funcs  --build-id  -o crypto/xts.ko crypto/xts.o crypto/xts.mod.o

Miroslav
