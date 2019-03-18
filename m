Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EE7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DCA2133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfCRTTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:19:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbfCRTT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:19:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A96E59455;
        Mon, 18 Mar 2019 19:19:29 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E99AE5D707;
        Mon, 18 Mar 2019 19:19:27 +0000 (UTC)
Date:   Mon, 18 Mar 2019 15:19:26 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Joao Moreira <jmoreira@suse.de>
Cc:     live-patching@vger.kernel.org, mbenes@suse.cz, pmladek@suse.cz,
        jikos@suse.cz, nstange@suse.de, jpoimboe@redhat.com,
        khlebnikov@yandex-team.ru, jeyu@kernel.org, matz@suse.de,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        linux-kbuild@vger.kernel.org, michal.lkml@markovi.net
Subject: Re: [PATCH v2 2/8] kbuild: Support for Symbols.list creation
Message-ID: <20190318191926.GA23138@redhat.com>
References: <20190301141313.15057-1-jmoreira@suse.de>
 <20190301141313.15057-3-jmoreira@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301141313.15057-3-jmoreira@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 18 Mar 2019 19:19:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 11:13:07AM -0300, Joao Moreira wrote:
> For automatic resolution of livepatch relocations, a file called
> Symbols.list is used. This file maps symbols within every compiled
> kernel object allowing the identification of symbols whose name is
> unique, thus relocation can be automatically inferred, or providing
> information that helps developers when code annotation is required for
> solving the matter.
> 
> Add support for creating Symbols.list in the main Makefile. First,
> ensure that built-in is compiled when CONFIG_LIVEPATCH is enabled (as
> required to achieve a complete Symbols.list file). Define the command to
> build Symbols.list (cmd_klp_map) and hook it in the modules rule.
> 
> As it is undesirable to have symbols from livepatch objects inside
> Symbols.list, make livepatches discernible by modifying
> scripts/Makefile.build to create a .livepatch file for each livepatch
> in $(MODVERDIR). This file then used by cmd_klp_map to identify and
> bypass livepatches.
> 
> For identifying livepatches during the build process, a flag variable
> LIVEPATCH_$(basetarget).o is considered in scripts/Makefile.build. This
> way, set this flag for the livepatch sample Makefile in
> samples/livepatch/Makefile.
> 
> Finally, Add a clean rule to ensure that Symbols.list is removed during
> clean.
> 
> Notes:
> 
> To achieve a correct Symbols.list file, all kernel objects must be
> considered, thus, its construction require these objects to be priorly
> built. On the other hand, invoking scripts/Makefile.modpost without
> having a complete Symbols.list in place would occasionally lead to
> in-tree livepatches being post-processed incorrectly. To prevent this
> from becoming a circular dependency, the construction of Symbols.list
> uses non-post-processed kernel objects and such does not cause harm as
> the symbols normally referenced from within livepatches are visible at
> this stage. Also due to these requirements, the spot in-between modules
> compilation and the invocation of scripts/Makefile.modpost was picked
> for hooking cmd_klp_map.
> 
> The approach based on .livepatch files was proposed as an alternative
> to using MODULE_INFO statementes. This approach was originally
                       ^^^^^^^^^^^
nit: s/statementes/statements

> proposed by Miroslav Benes as a workaround for identifying livepathces
                                                             ^^^^^^^^^^^
nit: s/livepathces/livepatches

> without depending on modinfo during the modpost stage. It was moved to
> this patch as the approach also shown to be useful while building
> Symbols.list.
> 
> Signed-off-by: Joao Moreira <jmoreira@suse.de>
> ---
>  .gitignore                 |  1 +
>  Makefile                   | 28 +++++++++++++++++++++++++---
>  samples/livepatch/Makefile |  1 +
>  scripts/Makefile.build     |  6 ++++++
>  4 files changed, 33 insertions(+), 3 deletions(-)
> 
> [ ... snip ... ]
> diff --git a/Makefile b/Makefile
> index 9ef547fc7ffe..b28eba2cad01 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -561,10 +561,13 @@ KBUILD_BUILTIN := 1
>  # If we have only "make modules", don't compile built-in objects.
>  # When we're building modules with modversions, we need to consider
>  # the built-in objects during the descend as well, in order to
> -# make sure the checksums are up to date before we record them.
> +# make sure the checksums are up to date before we record them. The
> +# same applies for building livepatches, as built-in objects may hold
> +# symbols which are referenced from livepatches and are required by
> +# klp-convert post-processing tool for resolving these cases.
>  
>  ifeq ($(MAKECMDGOALS),modules)
> -  KBUILD_BUILTIN := $(if $(CONFIG_MODVERSIONS),1)
> +  KBUILD_BUILTIN := $(if $(or $(CONFIG_MODVERSIONS), $(CONFIG_LIVEPATCH)),1)
>  endif
>  
>  # If we have "make <whatever> modules", compile modules
> @@ -1244,9 +1247,25 @@ all: modules
>  # duplicate lines in modules.order files.  Those are removed
>  # using awk while concatenating to the final file.
>  
> +quiet_cmd_klp_map = KLP	Symbols.list

Nit: the tab between "KLP" and "Symbols.list" doesn't match the same
alignment as other build commands:

  [squash] kbuild: align KLP prefix 
  https://github.com/torvalds/linux/commit/6419a05560731eb1306e441aadcaa2dfd9f9f935

> [ ... snip ... ]
> @@ -1341,7 +1360,10 @@ vmlinuxclean:
>  	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/link-vmlinux.sh clean
>  	$(Q)$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) clean)
>  
> -clean: archclean vmlinuxclean
> +klpclean:
> +	$(Q) rm -f $(objtree)/Symbols.list
> +
> +clean: archclean vmlinuxclean klpclean

Another nit, but the klpclean target doesn't create a klpclean file, so
we should add it to PHONY:

  [squash] kbuild: add klpclean to PHONY 
  https://github.com/torvalds/linux/commit/7a8b0bea2177c8150ead4848c4498a6081b4a5ae

> [ ... snip ... ]
> diff --git a/samples/livepatch/Makefile b/samples/livepatch/Makefile
> index 2472ce39a18d..9705df7f9a86 100644
> --- a/samples/livepatch/Makefile
> +++ b/samples/livepatch/Makefile
> @@ -1,3 +1,4 @@
> +LIVEPATCH_livepatch-sample.o := y
>  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-sample.o
>  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-shadow-mod.o
>  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-shadow-fix1.o

Would this change be better located in [PATCH 6/8] modpost: Add modinfo
flag to livepatch modules?  Or was it needed to test-drive the rest of
this patch?

> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index fd03d60f6c5a..1e28ad21314c 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -247,6 +247,11 @@ cmd_gen_ksymdeps = \
>  	$(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> $(dot-target).cmd
>  endif
>  
> +ifdef CONFIG_LIVEPATCH
> +cmd_livepatch = $(if $(LIVEPATCH_$(basetarget).o),			\
> +	$(shell touch $(MODVERDIR)/$(basetarget).livepatch))
> +endif
> +
>  define rule_cc_o_c
>  	$(call cmd,checksrc)
>  	$(call cmd_and_fixdep,cc_o_c)
> @@ -283,6 +288,7 @@ $(single-used-m): $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) F
>  	$(call if_changed_rule,cc_o_c)
>  	@{ echo $(@:.o=.ko); echo $@; \
>  	   $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
> +	$(call cmd_livepatch)
>  
>  quiet_cmd_cc_lst_c = MKLST   $@
>        cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \

Since cmd_livepatch is only called for single-used-m, does this mean
that we can only klp-convert single object file livepatch modules?

I stumbled upon this when trying to create a self-test module that
incorporated two object files.  I tried adding a $(call cmd_livepatch)
in the recipe for $(obj)/%.o, but that didn't help.  My kbuild foo
wasn't good enough to figure this one out.

-- Joe
