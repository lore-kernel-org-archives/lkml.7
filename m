Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48684C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CD020855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfDDN4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:56:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:54402 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727333AbfDDN4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:56:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 46E5DB12B;
        Thu,  4 Apr 2019 13:56:05 +0000 (UTC)
Subject: Re: [PATCH v2 5/8] modpost: Integrate klp-convert
To:     Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>
Cc:     live-patching@vger.kernel.org, pmladek@suse.cz, jikos@suse.cz,
        nstange@suse.de, jpoimboe@redhat.com, khlebnikov@yandex-team.ru,
        jeyu@kernel.org, matz@suse.de, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com, linux-kbuild@vger.kernel.org,
        michal.lkml@markovi.net
References: <20190301141313.15057-1-jmoreira@suse.de>
 <20190301141313.15057-6-jmoreira@suse.de> <20190322145404.GA31248@redhat.com>
 <alpine.LSU.2.21.1904041329400.32428@pobox.suse.cz>
From:   Joao Moreira <jmoreira@suse.de>
Message-ID: <a2428af1-2b58-5e33-adaa-ef4427b5d62f@suse.de>
Date:   Thu, 4 Apr 2019 10:55:57 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1904041329400.32428@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/19 8:31 AM, Miroslav Benes wrote:
> On Fri, 22 Mar 2019, Joe Lawrence wrote:
> 
>> On Fri, Mar 01, 2019 at 11:13:10AM -0300, Joao Moreira wrote:
>>> From: Josh Poimboeuf <jpoimboe@redhat.com>
>>>
>>> Create cmd_klp_convert and hook it into scripts/Makefile.modpost.
>>> cmd_klp_convert invokes klp-convert with the right arguments for the
>>> conversion of unresolved symbols inside a livepatch.
>>>
>>> [khlebnikov:
>>> * save cmd_ld_ko_o into .module.cmd, if_changed_rule doesn't do that
>>> * fix bashisms for debian where /bin/sh is a symlink to /bin/dash
>>> * rename rule_link_module to rule_ld_ko_o, otherwise arg-check inside
>>>    if_changed_rule compares cmd_link_module and cmd_ld_ko_o
>>> * check modinfo -F livepatch only if CONFIG_LIVEPATCH is true
>>> ]
>>>
>>> [mbenes:
>>> * remove modinfo call. LIVEPATCH_ in Makefiled
>>> ]
>>>
>>> [jmoreira:
>>> * split up: move the .livepatch file-based scheme for identifying
>>> livepatches to a previous patch, as it was required for correctly
>>> building Symbols.list there.
>>> ]
>>>
>>> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
>>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>>> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
>>> Signed-off-by: Joao Moreira <jmoreira@suse.de>
>>> ---
>>>   scripts/Kbuild.include   |  4 +++-
>>>   scripts/Makefile.modpost | 16 +++++++++++++++-
>>>   scripts/mod/modpost.c    |  6 +++++-
>>>   scripts/mod/modpost.h    |  1 +
>>>   4 files changed, 24 insertions(+), 3 deletions(-)
>>>
>>>
>>> [ ... snip ... ]
>>>
>>> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
>>> index 7d4af0d0accb..da779a185218 100644
>>> --- a/scripts/Makefile.modpost
>>> +++ b/scripts/Makefile.modpost
>>> @@ -125,8 +125,22 @@ quiet_cmd_ld_ko_o = LD [M]  $@
>>>                    -o $@ $(filter-out FORCE,$^) ;                         \
>>>   	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
>>>   
>>> +SLIST = $(objtree)/Symbols.list
>>> +KLP_CONVERT = scripts/livepatch/klp-convert
>>> +quiet_cmd_klp_convert = KLP $@
>>> +      cmd_klp_convert = mv $@ $(@:.ko=.klp.o);				\
>>> +			$(KLP_CONVERT) $(SLIST) $(@:.ko=.klp.o) $@
>>> +
>>> +define rule_ld_ko_o
>>> +	$(call cmd,ld_ko_o) $(cmd_ld_ko_o) ;				\
>>                             ^
>> Should there be a ';' semicolon here (and maybe a line-break) between
>> $(call cmd,ld_ko_o) and $(cmd_ld_ko_o)?
> 
> Probably yes.
> 
> Originally there was
> 	$(call echo-cmd,ld_ko_o) $(cmd_ld_ko_o) ;
> 
> but "echo-" disappeared somewhere. Joao?

Hi,

I just verified my sources and the echo-cmd got lost in between the v2 
rebases. I believe it must have happened while I was manually fixing a 
conflict, or something. Sorry.

Here is a piece of the original snippet, as it was supposed to be:

define rule_ld_ko_o 

        $(call echo-cmd,ld_ko_o) $(cmd_ld_ko_o) ; 
\
        $(call save-cmd,ld_ko_o) ; 
\
        $(if $(CONFIG_LIVEPATCH),                                       \

Joe, do you mind fixing it for v3?

Thanks for spotting it.

> 
> So maybe even
> 	$(call cmd,ld_ko_o)
> could be enough, because cmd contains echo-cmd, but I'm not good at
> reading scripts/Kbuild.include.
>   
>> I didn't see this in my x86_64 VM, but on a ppc64le box, I kept getting
>> really strange build errors that I traced to this line.  Without a
>> semicolon, the build was trying to run a make command with a linker
>> command smashed onto the end of it:
>>
>>    make -f ./arch/powerpc/Makefile.postlink crypto/xts.ko ld -r  -EL -m elf64lppc -T ./scripts/module-common.lds -T ./arch/powerpc/kernel/module.lds --save-restore-funcs  --build-id  -o crypto/xts.ko crypto/xts.o crypto/xts.mod.o
> 
> Miroslav
> 
