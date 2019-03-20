Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB0CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCF720850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfCTTII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:08:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:52182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726006AbfCTTIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:08:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5FB7AAE3C;
        Wed, 20 Mar 2019 19:08:06 +0000 (UTC)
Date:   Wed, 20 Mar 2019 20:08:05 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     Joao Moreira <jmoreira@suse.de>, live-patching@vger.kernel.org,
        pmladek@suse.cz, jikos@suse.cz, nstange@suse.de,
        jpoimboe@redhat.com, khlebnikov@yandex-team.ru, jeyu@kernel.org,
        matz@suse.de, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com, linux-kbuild@vger.kernel.org,
        michal.lkml@markovi.net
Subject: Re: [PATCH v2 2/8] kbuild: Support for Symbols.list creation
In-Reply-To: <20190318191926.GA23138@redhat.com>
Message-ID: <alpine.LSU.2.21.1903202000470.29796@pobox.suse.cz>
References: <20190301141313.15057-1-jmoreira@suse.de> <20190301141313.15057-3-jmoreira@suse.de> <20190318191926.GA23138@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index fd03d60f6c5a..1e28ad21314c 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -247,6 +247,11 @@ cmd_gen_ksymdeps = \
> >  	$(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> $(dot-target).cmd
> >  endif
> >  
> > +ifdef CONFIG_LIVEPATCH
> > +cmd_livepatch = $(if $(LIVEPATCH_$(basetarget).o),			\
> > +	$(shell touch $(MODVERDIR)/$(basetarget).livepatch))
> > +endif
> > +
> >  define rule_cc_o_c
> >  	$(call cmd,checksrc)
> >  	$(call cmd_and_fixdep,cc_o_c)
> > @@ -283,6 +288,7 @@ $(single-used-m): $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) F
> >  	$(call if_changed_rule,cc_o_c)
> >  	@{ echo $(@:.o=.ko); echo $@; \
> >  	   $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
> > +	$(call cmd_livepatch)
> >  
> >  quiet_cmd_cc_lst_c = MKLST   $@
> >        cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \
> 
> Since cmd_livepatch is only called for single-used-m, does this mean
> that we can only klp-convert single object file livepatch modules?
> 
> I stumbled upon this when trying to create a self-test module that
> incorporated two object files.  I tried adding a $(call cmd_livepatch)
> in the recipe for $(obj)/%.o, but that didn't help.  My kbuild foo
> wasn't good enough to figure this one out.

I looked at my original code and it is a bit different there. I placed it 
under rule_cc_o_c right after objtool command. If I remember correctly 
this is the correct recipe for .c->.o. Unfortunately I forgot the details 
and there is of course nothing about it in my notes.

Does it help?

Joao, is there a reason you moved it elsewhere?

Miroslav
