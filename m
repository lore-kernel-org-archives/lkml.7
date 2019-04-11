Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA30C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AFA2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfDKPyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:54:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfDKPyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:54:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D7B27308950C;
        Thu, 11 Apr 2019 15:54:35 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 767A41001E66;
        Thu, 11 Apr 2019 15:54:34 +0000 (UTC)
Date:   Thu, 11 Apr 2019 11:54:32 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Joao Moreira <jmoreira@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Matz <matz@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        Nicolai Stange <nstange@suse.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 5/9] modpost: Integrate klp-convert
Message-ID: <20190411155432.GA5224@redhat.com>
References: <20190410155058.9437-1-joe.lawrence@redhat.com>
 <20190410155058.9437-6-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410155058.9437-6-joe.lawrence@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 11 Apr 2019 15:54:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 11:50:54AM -0400, Joe Lawrence wrote:
> 
> [ ... snip ... ]
> 
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 6b7f354f189a..1e8bb7442689 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -124,8 +124,22 @@ quiet_cmd_ld_ko_o = LD [M]  $@
>                   -o $@ $(real-prereqs) ;                                \
>  	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
>  
> +SLIST = $(objtree)/Symbols.list
> +KLP_CONVERT = scripts/livepatch/klp-convert
> +quiet_cmd_klp_convert = KLP     $@
> +      cmd_klp_convert = mv $@ $(@:.ko=.klp.o);				\
> +			$(KLP_CONVERT) $(SLIST) $(@:.ko=.klp.o) $@
> +
> +define rule_ld_ko_o
> +	$(call echo-cmd,ld_ko_o) $(cmd_ld_ko_o) ;			\
> +	$(call save-cmd,ld_ko_o) ;					\
> +	$(if $(CONFIG_LIVEPATCH),					\
> +	  $(if $(wildcard $(MODVERDIR)/$(basetarget).livepatch),	\
> +	    $(call echo-cmd,klp_convert) $(cmd_klp_convert) ))
> +endef
> +
>  $(modules): %.ko :%.o %.mod.o FORCE
> -	+$(call if_changed,ld_ko_o)
> +	+$(call if_changed_rule,ld_ko_o)
>  
>  targets += $(modules)

I just noticed that rule_ld_ko_o produces verbose output when linking
modules:

  % make
  ...
  echo '  LD [M]  drivers/ata/ata_generic.ko'; ld -r -m elf_x86_64  -z max-page-size=0x200000 -T ./scripts/module-common.lds  --build-id  -o drivers/ata/ata_generic.ko drivers/ata/ata_generic.o drivers/ata/ata_generic.mod.o ;  true ; printf '%s\n' 'cmd_drivers/ata/ata_generic.ko := ld -r -m elf_x86_64  -z max-page-size=0x200000 -T ./scripts/module-common.lds  --build-id  -o drivers/ata/ata_generic.ko drivers/ata/ata_generic.o drivers/ata/ata_generic.mod.o ;  true' > drivers/ata/.ata_generic.ko.cmd ;  
    LD [M]  drivers/ata/ata_generic.ko

so I think we need to use the $(Q) macro to respect the KBUILD_VERBOSE
and V kbuild settings.

Masahiro, does something like this look correct?


Thanks,

-- Joe

-->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8--

From 5c8a2c58c7be98c0a9156155f201b88cc61bf0bd Mon Sep 17 00:00:00 2001
From: Joe Lawrence <joe.lawrence@redhat.com>
Date: Thu, 11 Apr 2019 11:32:37 -0400
Subject: [PATCH] [squash] modpost: fix rule_ld_ko_o verbosity

Note: squash with ("modpost: Integrate klp-convert")

rule_ld_ko_o should include $(Q) to honor build verbosity setting.
Cargo-cult-stolen from 70923bd26c73 ("perf tools: Make flex/bison calls
honour V=1").

[joe: quiet down rule_ld_ko_o]

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 scripts/Makefile.modpost | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 9fe4c5760aca..f2aee6b8dcfd 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -135,11 +135,11 @@ KLP_CONVERT = scripts/livepatch/klp-convert
 quiet_cmd_klp_convert = KLP     $@
       cmd_klp_convert = mv $@ $(@:.ko=.klp.o);				\
 			$(KLP_CONVERT) $(SLIST) $(@:.ko=.klp.o) $@
 
 define rule_ld_ko_o
-	$(call echo-cmd,ld_ko_o) $(cmd_ld_ko_o) ;			\
+	$(Q)$(call echo-cmd,ld_ko_o) $(cmd_ld_ko_o) ;			\
 	$(call save-cmd,ld_ko_o) ;					\
 	$(if $(CONFIG_LIVEPATCH),					\
 	  $(if $(wildcard $(MODVERDIR)/$(basetarget).livepatch),	\
 	    $(call echo-cmd,klp_convert) $(cmd_klp_convert) ))
 endef
-- 
2.20.1

