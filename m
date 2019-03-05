Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2CAC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FB32082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfCEQgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:36:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39928 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfCEQgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:36:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 01D48C0495A1;
        Tue,  5 Mar 2019 16:36:14 +0000 (UTC)
Received: from treble (ovpn-126-179.rdu2.redhat.com [10.10.126.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5452600D7;
        Tue,  5 Mar 2019 16:36:11 +0000 (UTC)
Date:   Tue, 5 Mar 2019 10:36:09 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
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
Subject: Re: [PATCH 3/3] objtool: move tools/objtool/ to scripts/objtool/
Message-ID: <20190305163609.gz2cvpj7bxrnzdvm@treble>
References: <1551764896-8453-1-git-send-email-yamada.masahiro@socionext.com>
 <1551764896-8453-3-git-send-email-yamada.masahiro@socionext.com>
 <20190305144625.bjmkr6ebufbly5ba@treble>
 <CAK7LNAS=K2Hp+idOsHQBCYwk5YndzSdHL=GmJZRxsF6De3isNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNAS=K2Hp+idOsHQBCYwk5YndzSdHL=GmJZRxsF6De3isNA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 05 Mar 2019 16:36:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 01:08:27AM +0900, Masahiro Yamada wrote:
> > I do see the benefits.  In many ways objtool is a more natural fit in
> > the scripts dir.  But there are also some downsides to this change:
> >
> > - This will make it harder to package objtool as a standalone tool.  It
> >   has a lot of functionality that could be useful to other non-kernel
> >   projects.
> 
> 
> If it is really useful for other projects,
> I'd like to see it as a real standalone tool,
> i.e. split as a separate project.

Fine, but who's going to do it?  I don't have time for creating such a
project anytime soon.  And anyway, moving the code to scripts in the
meantime would just make that harder when we do it eventually.

> > - It shares libsubcmd with perf.  Including the subcmd .c files from
> >   tools is hacky.
> 
> Yes, hacky. We are shifting the ugliness between C and Build system.
> 
> But, this hack can be solved; if subcmd library is useful, you can copy
> only necessary code into the objtool directory. You do not need all
> helpers from libsubcmd.

But then we are duplicating code...

> > - It's disruptive: it will break all the out-of-tree distro kernel
> >   packaging scripts which now look for objtool in tools.
> 
> All artifacts under scripts/ should be contained in the package.
> So, it should work.

It *will* break distro scripts which already expect objtool to be
located at tools/objtool/objtool.

> > You're right that objtool isn't a natural fit in tools, because it's
> > also used as part of the build.  But it's not a natural fit in scripts
> > either.  I think we've resolved most of those issues and it seems to be
> > working well these days.
> >
> > So instead of disrupting everything because "make mrproper" doesn't
> > work, I think I'd rather just do the following:
> >
> > diff --git a/Makefile b/Makefile
> > index ac5ac28a24e9..7e6696c9b862 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1364,7 +1364,7 @@ PHONY += $(mrproper-dirs) mrproper
> >  $(mrproper-dirs):
> >         $(Q)$(MAKE) $(clean)=$(patsubst _mrproper_%,%,$@)
> >
> > -mrproper: clean $(mrproper-dirs)
> > +mrproper: clean $(mrproper-dirs) tools/objtool_clean
> >         $(call cmd,rmdirs)
> >         $(call cmd,rmfiles)
> >
> 
> Works, and the clean log is also brilliant.
> 
> I see the same log even when
> there is nothing to clean.
> 
> 
> masahiro@grover:~/ref/linux$ make mrproper
>   CLEAN   .
>   CLEAN   arch/x86/entry/vdso
>   CLEAN   usr
>   CLEAN   arch/x86/tools
>   CLEAN   .tmp_versions
>   CLEAN   scripts/basic
>   CLEAN   scripts/kconfig
>   CLEAN   scripts/mod
>   CLEAN   scripts/selinux/genheaders
>   CLEAN   scripts/selinux/mdp
>   CLEAN   scripts
>   DESCEND  objtool
>   CLEAN    objtool
>   CLEAN   include/config include/generated arch/x86/include/generated
>   CLEAN   .config
> masahiro@grover:~/ref/linux$ make mrproper
>   DESCEND  objtool
>   CLEAN    objtool
> masahiro@grover:~/ref/linux$ make mrproper
>   DESCEND  objtool
>   CLEAN    objtool

Ok, but I'm sure that could be fixed.  That's hardly a justification to
move objtool.

Anyway I would like to hear what Ingo and Peter think about moving it.

-- 
Josh
