Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64909C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E41721850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfDKJTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:19:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfDKJTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:19:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6796A80F98;
        Thu, 11 Apr 2019 09:19:03 +0000 (UTC)
Received: from shodan.usersys.redhat.com (unknown [10.43.17.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C2FF1001E89;
        Thu, 11 Apr 2019 09:19:00 +0000 (UTC)
Received: by shodan.usersys.redhat.com (Postfix, from userid 1000)
        id EFA072C1729; Thu, 11 Apr 2019 11:18:59 +0200 (CEST)
Date:   Thu, 11 Apr 2019 11:18:59 +0200
From:   Artem Savkov <asavkov@redhat.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Joao Moreira <jmoreira@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Matz <matz@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        Nicolai Stange <nstange@suse.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 2/9] kbuild: Support for Symbols.list creation
Message-ID: <20190411091859.GF4995@shodan.usersys.redhat.com>
References: <20190410155058.9437-1-joe.lawrence@redhat.com>
 <20190410155058.9437-3-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190410155058.9437-3-joe.lawrence@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 11 Apr 2019 09:19:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 11:50:51AM -0400, Joe Lawrence wrote:
> -clean: archclean vmlinuxclean
> +klpclean:
> +	$(Q) rm -f $(objtree)/Symbols.list

nit: $(SLIST) can be used here.

> +clean: archclean vmlinuxclean klpclean
>  
>  # mrproper - Delete all generated files, including .config
>  #
> diff --git a/samples/livepatch/Makefile b/samples/livepatch/Makefile
> index 2472ce39a18d..8b9b42a258ad 100644
> --- a/samples/livepatch/Makefile
> +++ b/samples/livepatch/Makefile
> @@ -1,3 +1,4 @@
> +LIVEPATCH_livepatch-sample := y
>  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-sample.o
>  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-shadow-mod.o
>  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-shadow-fix1.o
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 76ca30cc4791..ca76bd2080f0 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -246,6 +246,11 @@ cmd_gen_ksymdeps = \
>  	$(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> $(dot-target).cmd
>  endif
>  
> +ifdef CONFIG_LIVEPATCH
> +cmd_livepatch = $(if $(LIVEPATCH_$(basetarget)),		\
> +	$(shell touch $(MODVERDIR)/$(basetarget).livepatch))
> +endif
> +
>  define rule_cc_o_c
>  	$(call cmd,checksrc)
>  	$(call cmd_and_fixdep,cc_o_c)
> @@ -280,6 +285,7 @@ $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
>  $(single-used-m): $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
>  	$(call cmd,force_checksrc)
>  	$(call if_changed_rule,cc_o_c)
> +	$(call cmd_livepatch)

nit: maybe use "cmd,livepatch" to be consistent with the other call of
this function.

>  	@{ echo $(@:.o=.ko); echo $@; \
>  	   $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
>  
> @@ -456,6 +462,7 @@ cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(filter %.o,$^) $(cmd_secanalysis
>  
>  $(multi-used-m): FORCE
>  	$(call if_changed,link_multi-m)
> +	$(call cmd,livepatch)
>  	@{ echo $(@:.o=.ko); echo $(filter %.o,$^); \
>  	   $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
>  $(call multi_depend, $(multi-used-m), .o, -objs -y -m)
> -- 
> 2.20.1
> 

-- 
 Artem
