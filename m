Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC9EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D50D2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbfCZOlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:41:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:46786 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbfCZOlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:41:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7505FB12C;
        Tue, 26 Mar 2019 14:41:28 +0000 (UTC)
Subject: Re: [PATCH v2 2/8] kbuild: Support for Symbols.list creation
To:     Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>
Cc:     live-patching@vger.kernel.org, pmladek@suse.cz, jikos@suse.cz,
        nstange@suse.de, jpoimboe@redhat.com, khlebnikov@yandex-team.ru,
        jeyu@kernel.org, matz@suse.de, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com, linux-kbuild@vger.kernel.org,
        michal.lkml@markovi.net
References: <20190301141313.15057-1-jmoreira@suse.de>
 <20190301141313.15057-3-jmoreira@suse.de> <20190318191926.GA23138@redhat.com>
 <alpine.LSU.2.21.1903202000470.29796@pobox.suse.cz>
From:   Joao Moreira <jmoreira@suse.de>
Message-ID: <5f615af5-ced7-2361-5b71-71fece8b43c5@suse.de>
Date:   Tue, 26 Mar 2019 11:40:55 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1903202000470.29796@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/20/19 4:08 PM, Miroslav Benes wrote:
>>> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
>>> index fd03d60f6c5a..1e28ad21314c 100644
>>> --- a/scripts/Makefile.build
>>> +++ b/scripts/Makefile.build
>>> @@ -247,6 +247,11 @@ cmd_gen_ksymdeps = \
>>>   	$(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> $(dot-target).cmd
>>>   endif
>>>   
>>> +ifdef CONFIG_LIVEPATCH
>>> +cmd_livepatch = $(if $(LIVEPATCH_$(basetarget).o),			\
>>> +	$(shell touch $(MODVERDIR)/$(basetarget).livepatch))
>>> +endif
>>> +
>>>   define rule_cc_o_c
>>>   	$(call cmd,checksrc)
>>>   	$(call cmd_and_fixdep,cc_o_c)
>>> @@ -283,6 +288,7 @@ $(single-used-m): $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) F
>>>   	$(call if_changed_rule,cc_o_c)
>>>   	@{ echo $(@:.o=.ko); echo $@; \
>>>   	   $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
>>> +	$(call cmd_livepatch)
>>>   
>>>   quiet_cmd_cc_lst_c = MKLST   $@
>>>         cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \
>>
>> Since cmd_livepatch is only called for single-used-m, does this mean
>> that we can only klp-convert single object file livepatch modules?
>>
>> I stumbled upon this when trying to create a self-test module that
>> incorporated two object files.  I tried adding a $(call cmd_livepatch)
>> in the recipe for $(obj)/%.o, but that didn't help.  My kbuild foo
>> wasn't good enough to figure this one out.
> 
> I looked at my original code and it is a bit different there. I placed it
> under rule_cc_o_c right after objtool command. If I remember correctly
> this is the correct recipe for .c->.o. Unfortunately I forgot the details
> and there is of course nothing about it in my notes.
> 
> Does it help?
> 
> Joao, is there a reason you moved it elsewhere?

Hi,

Unfortunately I can't remember why the chunk was moved to where it is in 
this version of the patch, sorry. Yet, I did try to move this into the 
rule cc_o_c and it seemed to work with not damage.

Joe, would you kindly verify and squash properly the patch below, which 
places cmd_livepatch in rule_cc_o_c?

Thank you.

Subject: [PATCH] Move cmd_klp_convert to the right place 

 

Signed-off-by: Joao Moreira <jmoreira@suse.de> 

--- 

  scripts/Makefile.build | 2 +- 

  1 file changed, 1 insertion(+), 1 deletion(-) 

 

diff --git a/scripts/Makefile.build b/scripts/Makefile.build 

index 1e28ad21314c..5f66106a47d6 100644 

--- a/scripts/Makefile.build 

+++ b/scripts/Makefile.build 

@@ -260,6 +260,7 @@ define rule_cc_o_c 

         $(call cmd,objtool) 

         $(call cmd,modversions_c) 

         $(call cmd,record_mcount) 

+       $(call cmd,livepatch) 

  endef 

 

  define rule_as_o_S 

@@ -288,7 +289,6 @@ $(single-used-m): $(obj)/%.o: $(src)/%.c 
$(recordmcount_source) $(objtool_dep) F
         $(call if_changed_rule,cc_o_c) 

         @{ echo $(@:.o=.ko); echo $@; \ 

            $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod) 

-       $(call cmd_livepatch) 

 

  quiet_cmd_cc_lst_c = MKLST   $@ 

        cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \ 

-- 

2.16.4


> 
> Miroslav
> 
