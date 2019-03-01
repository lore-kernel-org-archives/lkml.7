Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCB6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08FB20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732829AbfCAMdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 07:33:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:41316 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbfCAMdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 07:33:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7D287AF1B;
        Fri,  1 Mar 2019 12:33:06 +0000 (UTC)
Date:   Fri, 1 Mar 2019 13:33:04 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Arseny Maslennikov <ar@cs.msu.ru>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ulf Magnusson <ulfalizer@gmail.com>
Subject: Re: [PATCH] scripts/kconfig/Makefile: use KCONFIG_CONFIG if set
Message-ID: <20190301123304.GA2318@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190221215901.23970-1-ar@cs.msu.ru>
 <20190221215901.23970-2-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221215901.23970-2-ar@cs.msu.ru>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseny,

> In a kernel source tree:

> % make mrproper
> % make KCONFIG_CONFIG=.myconfig kvmconfig'
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTCC  scripts/kconfig/confdata.o
>   HOSTCC  scripts/kconfig/expr.o
>   HOSTCC  scripts/kconfig/symbol.o
>   HOSTCC  scripts/kconfig/preprocess.o
>   LEX     scripts/kconfig/zconf.lex.c
>   YACC    scripts/kconfig/zconf.tab.h
>   HOSTCC  scripts/kconfig/zconf.lex.o
>   YACC    scripts/kconfig/zconf.tab.c
>   HOSTCC  scripts/kconfig/zconf.tab.o
>   HOSTLD  scripts/kconfig/conf
> The base file '.config' does not exist.  Exit.
> make[1]: *** [scripts/kconfig/Makefile:96: kvm_guest.config] Error 1
> make: *** [Makefile:538: kvmconfig] Error 2

> Essentially `make kvmconfig' (and probably other similar targets)
> did ignore KCONFIG_CONFIG set to a different filename.

> If KCONFIG_CONFIG is set, use it; otherwise behave as if it was set
> to `.config'.

> Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>

Good catch :).
Yes, many targets are affected to it: xenconfig, tinyconfig + archs:
rm -f .config; make ARCH=arm KCONFIG_CONFIG=.myconfig dram_0xd0000000.config

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>


Kind regards,
Petr
> ---
>  scripts/kconfig/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index 181973509a05..1c7ac07def4d 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -93,7 +93,7 @@ configfiles=$(wildcard $(srctree)/kernel/configs/$@ $(srctree)/arch/$(SRCARCH)/c

>  %.config: $(obj)/conf
>  	$(if $(call configfiles),, $(error No configuration exists for this target on this architecture))
> -	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh -m .config $(configfiles)
> +	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh -m $(KCONFIG_CONFIG) $(configfiles)
>  	+$(Q)yes "" | $(MAKE) -f $(srctree)/Makefile oldconfig

>  PHONY += kvmconfig
