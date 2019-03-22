Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549B5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239E821900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfCVQhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:37:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:40754 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727143AbfCVQho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:37:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 39113AC9C;
        Fri, 22 Mar 2019 16:37:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 22 Mar 2019 13:37:40 -0300
From:   Joao Moreira <jmoreira@suse.de>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     live-patching@vger.kernel.org, mbenes@suse.cz, pmladek@suse.cz,
        jikos@suse.cz, nstange@suse.de, jpoimboe@redhat.com,
        khlebnikov@yandex-team.ru, jeyu@kernel.org, matz@suse.de,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        linux-kbuild@vger.kernel.org, michal.lkml@markovi.net,
        live-patching-owner@vger.kernel.org
Subject: Re: [PATCH v2 5/8] modpost: Integrate klp-convert
In-Reply-To: <20190322145404.GA31248@redhat.com>
References: <20190301141313.15057-1-jmoreira@suse.de>
 <20190301141313.15057-6-jmoreira@suse.de>
 <20190322145404.GA31248@redhat.com>
Message-ID: <48deaa61c7bd81e40df445ba80825ad7@suse.de>
X-Sender: jmoreira@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-22 11:54, Joe Lawrence wrote:
> On Fri, Mar 01, 2019 at 11:13:10AM -0300, Joao Moreira wrote:
>> From: Josh Poimboeuf <jpoimboe@redhat.com>
>> 
>> Create cmd_klp_convert and hook it into scripts/Makefile.modpost.
>> cmd_klp_convert invokes klp-convert with the right arguments for the
>> conversion of unresolved symbols inside a livepatch.
>> 
>> [khlebnikov:
>> * save cmd_ld_ko_o into .module.cmd, if_changed_rule doesn't do that
>> * fix bashisms for debian where /bin/sh is a symlink to /bin/dash
>> * rename rule_link_module to rule_ld_ko_o, otherwise arg-check inside
>>   if_changed_rule compares cmd_link_module and cmd_ld_ko_o
>> * check modinfo -F livepatch only if CONFIG_LIVEPATCH is true
>> ]
>> 
>> [mbenes:
>> * remove modinfo call. LIVEPATCH_ in Makefiled
>> ]
>> 
>> [jmoreira:
>> * split up: move the .livepatch file-based scheme for identifying
>> livepatches to a previous patch, as it was required for correctly
>> building Symbols.list there.
>> ]
>> 
>> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
>> Signed-off-by: Joao Moreira <jmoreira@suse.de>
>> ---
>>  scripts/Kbuild.include   |  4 +++-
>>  scripts/Makefile.modpost | 16 +++++++++++++++-
>>  scripts/mod/modpost.c    |  6 +++++-
>>  scripts/mod/modpost.h    |  1 +
>>  4 files changed, 24 insertions(+), 3 deletions(-)
>> 
>> 
>> [ ... snip ... ]
>> 
>> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
>> index 7d4af0d0accb..da779a185218 100644
>> --- a/scripts/Makefile.modpost
>> +++ b/scripts/Makefile.modpost
>> @@ -125,8 +125,22 @@ quiet_cmd_ld_ko_o = LD [M]  $@
>>                   -o $@ $(filter-out FORCE,$^) ;                       
>>   \
>>  	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
>> 
>> +SLIST = $(objtree)/Symbols.list
>> +KLP_CONVERT = scripts/livepatch/klp-convert
>> +quiet_cmd_klp_convert = KLP $@
>> +      cmd_klp_convert = mv $@ $(@:.ko=.klp.o);				\
>> +			$(KLP_CONVERT) $(SLIST) $(@:.ko=.klp.o) $@
>> +
>> +define rule_ld_ko_o
>> +	$(call cmd,ld_ko_o) $(cmd_ld_ko_o) ;				\
>                            ^
> Should there be a ';' semicolon here (and maybe a line-break) between
> $(call cmd,ld_ko_o) and $(cmd_ld_ko_o)?
> 
> I didn't see this in my x86_64 VM, but on a ppc64le box, I kept getting
> really strange build errors that I traced to this line.  Without a
> semicolon, the build was trying to run a make command with a linker
> command smashed onto the end of it:
> 
>   make -f ./arch/powerpc/Makefile.postlink crypto/xts.ko ld -r  -EL -m
> elf64lppc -T ./scripts/module-common.lds -T
> ./arch/powerpc/kernel/module.lds --save-restore-funcs  --build-id  -o
> crypto/xts.ko crypto/xts.o crypto/xts.mod.o
> 
> 
> Now, klp-convert looks like will need some ppc64le work as well, as 
> it's
> confused about .TOC. symbols:
> 
>     CC      samples/livepatch/livepatch-annotated-sample.mod.o
>     CC      samples/livepatch/livepatch-callbacks-busymod.mod.o
>     CC      samples/livepatch/livepatch-callbacks-demo.mod.o
>     CC      samples/livepatch/livepatch-callbacks-mod.mod.o
>     CC      samples/livepatch/livepatch-sample.mod.o
>     CC      samples/livepatch/livepatch-shadow-fix1.mod.o
>     CC      samples/livepatch/livepatch-shadow-fix2.mod.o
>     CC      samples/livepatch/livepatch-shadow-mod.mod.o
>     LD [M]  samples/livepatch/livepatch-annotated-sample.ko
>     LD [M]  samples/livepatch/livepatch-callbacks-demo.ko
>     KLP     samples/livepatch/livepatch-annotated-sample.ko
>     LD [M]  samples/livepatch/livepatch-callbacks-mod.ko
>     KLP     samples/livepatch/livepatch-callbacks-demo.ko
>     LD [M]  samples/livepatch/livepatch-sample.ko
>     LD [M]  samples/livepatch/livepatch-shadow-fix1.ko
>   klp-convert: Define KLP_SYMPOS for the symbol: .TOC.
>   Valid KLP_SYMPOS for symbol .TOC.:
> 
>   [ ... snip listing of all .TOC's across the kernel ... ]
> 
> but we can save that for another day.
> 

Hi Joe, first of all, thank you for you in-depth review. I did not have 
the time to go through everything yet, and I'll reply properly to the 
other comments soon. Yet, I would like to add a quick note here, since 
you are testing ppc64le. ppc64le is exactly one of the things I have 
been dealing with in the last two days, specifically the .TOC. symbols 
(there is also another bug related to converting relocations of symbols 
with index 0, but this one is architecture agnostic).

If you would like to take a look, the fix is in the latest commit here:
- https://github.com/SUSE/klp-convert/tree/fixppc64le

I would be very glad if you have any comment or input on that, and I 
guess that if the fix is that simple, I can manage to squash it into v3.

Thanks,
João

> 
> -- Joe

