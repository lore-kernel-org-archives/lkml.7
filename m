Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B17FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113512082F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbfCZSNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:13:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:58054 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732064AbfCZSNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:13:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A1BD4AFD3;
        Tue, 26 Mar 2019 18:13:37 +0000 (UTC)
Subject: Re: [PATCH v2 2/8] kbuild: Support for Symbols.list creation
To:     Joe Lawrence <joe.lawrence@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     live-patching@vger.kernel.org, pmladek@suse.cz, jikos@suse.cz,
        nstange@suse.de, jpoimboe@redhat.com, khlebnikov@yandex-team.ru,
        jeyu@kernel.org, matz@suse.de, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com, linux-kbuild@vger.kernel.org,
        michal.lkml@markovi.net
References: <20190301141313.15057-1-jmoreira@suse.de>
 <20190301141313.15057-3-jmoreira@suse.de> <20190318191926.GA23138@redhat.com>
 <alpine.LSU.2.21.1903202000470.29796@pobox.suse.cz>
 <5f615af5-ced7-2361-5b71-71fece8b43c5@suse.de>
 <ae018181-fd8a-03b2-69bf-e9302172bfeb@redhat.com>
From:   Joao Moreira <jmoreira@suse.de>
Message-ID: <699e78da-36ba-8217-c509-2e9b443bd380@suse.de>
Date:   Tue, 26 Mar 2019 15:13:29 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <ae018181-fd8a-03b2-69bf-e9302172bfeb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/26/19 1:15 PM, Joe Lawrence wrote:
> On 3/26/19 10:40 AM, Joao Moreira wrote:
>>
>>
>> On 3/20/19 4:08 PM, Miroslav Benes wrote:
>>>>> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
>>>>> index fd03d60f6c5a..1e28ad21314c 100644
>>>>> --- a/scripts/Makefile.build
>>>>> +++ b/scripts/Makefile.build
>>>>> @@ -247,6 +247,11 @@ cmd_gen_ksymdeps = \
>>>>>        $(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> 
>>>>> $(dot-target).cmd
>>>>>    endif
>>>>> +ifdef CONFIG_LIVEPATCH
>>>>> +cmd_livepatch = $(if $(LIVEPATCH_$(basetarget).o),            \
>>>>> +    $(shell touch $(MODVERDIR)/$(basetarget).livepatch))
>>>>> +endif
>>>>> +
>>>>>    define rule_cc_o_c
>>>>>        $(call cmd,checksrc)
>>>>>        $(call cmd_and_fixdep,cc_o_c)
>>>>> @@ -283,6 +288,7 @@ $(single-used-m): $(obj)/%.o: $(src)/%.c 
>>>>> $(recordmcount_source) $(objtool_dep) F
>>>>>        $(call if_changed_rule,cc_o_c)
>>>>>        @{ echo $(@:.o=.ko); echo $@; \
>>>>>           $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
>>>>> +    $(call cmd_livepatch)
>>>>>    quiet_cmd_cc_lst_c = MKLST   $@
>>>>>          cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \
>>>>
>>>> Since cmd_livepatch is only called for single-used-m, does this mean
>>>> that we can only klp-convert single object file livepatch modules?
>>>>
>>>> I stumbled upon this when trying to create a self-test module that
>>>> incorporated two object files.  I tried adding a $(call cmd_livepatch)
>>>> in the recipe for $(obj)/%.o, but that didn't help.  My kbuild foo
>>>> wasn't good enough to figure this one out.
>>>
>>> I looked at my original code and it is a bit different there. I 
>>> placed it
>>> under rule_cc_o_c right after objtool command. If I remember correctly
>>> this is the correct recipe for .c->.o. Unfortunately I forgot the 
>>> details
>>> and there is of course nothing about it in my notes.
>>>
>>> Does it help?
>>>
>>> Joao, is there a reason you moved it elsewhere?
>>
>> Hi,
>>
>> Unfortunately I can't remember why the chunk was moved to where it is in
>> this version of the patch, sorry. Yet, I did try to move this into the
>> rule cc_o_c and it seemed to work with not damage.
>>
>> Joe, would you kindly verify and squash properly the patch below, which
>> places cmd_livepatch in rule_cc_o_c?
>>
>> Thank you.
>>
>> Subject: [PATCH] Move cmd_klp_convert to the right place
>>
>>
>> Signed-off-by: Joao Moreira <jmoreira@suse.de>
>>
>> ---
>>
>>    scripts/Makefile.build | 2 +-
>>
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>
>> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
>> index 1e28ad21314c..5f66106a47d6 100644
>> --- a/scripts/Makefile.build
>> +++ b/scripts/Makefile.build
>> @@ -260,6 +260,7 @@ define rule_cc_o_c
>>           $(call cmd,objtool)
>>           $(call cmd,modversions_c)
>>           $(call cmd,record_mcount)
>> +       $(call cmd,livepatch)
>>    endef
>>    define rule_as_o_S
>> @@ -288,7 +289,6 @@ $(single-used-m): $(obj)/%.o: $(src)/%.c
>> $(recordmcount_source) $(objtool_dep) F
>>           $(call if_changed_rule,cc_o_c)
>>           @{ echo $(@:.o=.ko); echo $@; \
>>              $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
>> -       $(call cmd_livepatch)
>>    quiet_cmd_cc_lst_c = MKLST   $@
>>          cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \
> 
> Hi Joao,
> 
> This change seems to work okay for (again) single object modules, but 
> I'm having issues with multi-object modules.
> 

Hi Joe, thanks for the sources, this made everything much easier in my 
side :)

In the patch below I change a little bit the interface used to inform 
kbuild that a module is a livepatch. Instead of defining the flag 
LIVEPATCH_ per .o file, we define it per module (what actually makes 
much more sense). We later use $(basetarget) in the Makefile for 
checking the flags. By doing so, and invoking cmd_livepatch both from 
the $(single-used-m) and $(multi-used-m) we ensure that the .livepatch 
file is created for each module, what later in the pipeline flags the 
invocation of klp-convert.

I tested the following patch with the sources you provided (with little 
modifications, removing the .o from the LIVEPATCH_ definitions and using 
the module name instead of the object names), achieving successful 
compilation and conversion. I also tested against the sample 
livepatches, thus I think it might be ok now.

Do you think we can go this way to solve the problem in v3?

-- PATCH --

Subject: [PATCH] Fix cmd_livepatch for multi-object modules 

 

Signed-off-by: Joao Moreira <jmoreira@suse.de> 

--- 

  samples/livepatch/Makefile | 10 +++++----- 

  scripts/Makefile.build     |  5 +++-- 

  2 files changed, 8 insertions(+), 7 deletions(-) 

 

diff --git a/samples/livepatch/Makefile b/samples/livepatch/Makefile 

index 93725c434f4f..dea530840725 100644 

--- a/samples/livepatch/Makefile 

+++ b/samples/livepatch/Makefile 

@@ -1,8 +1,8 @@ 

-LIVEPATCH_livepatch-sample.o := y 

-LIVEPATCH_livepatch-shadow-fix1.o := y 

-LIVEPATCH_livepatch-shadow-fix2.o := y 

-LIVEPATCH_livepatch-callbacks-demo.o := y 

-LIVEPATCH_livepatch-annotated-sample.o := y 

+LIVEPATCH_livepatch-sample := y 

+LIVEPATCH_livepatch-shadow-fix1 := y 

+LIVEPATCH_livepatch-shadow-fix2 := y 

+LIVEPATCH_livepatch-callbacks-demo := y 

+LIVEPATCH_livepatch-annotated-sample := y 

 

  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-sample.o 

  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-shadow-mod.o 

diff --git a/scripts/Makefile.build b/scripts/Makefile.build 

index dba89e605eab..52e69b4084d5 100644 

--- a/scripts/Makefile.build 

+++ b/scripts/Makefile.build 

@@ -250,7 +250,7 @@ cmd_gen_ksymdeps = \ 

  endif 

 

  ifdef CONFIG_LIVEPATCH 

-cmd_livepatch = $(if $(LIVEPATCH_$(basetarget).o), 
\
+cmd_livepatch = $(if $(LIVEPATCH_$(basetarget)), 
\
         $(shell touch $(MODVERDIR)/$(basetarget).livepatch)) 

  endif 

 

@@ -288,9 +288,9 @@ $(obj)/%.o: $(src)/%.c $(recordmcount_source) 
$(objtool_dep) FORCE
  $(single-used-m): $(obj)/%.o: $(src)/%.c $(recordmcount_source) 
$(objtool_dep) FORCE
         $(call cmd,force_checksrc) 

         $(call if_changed_rule,cc_o_c) 

+       $(call cmd,livepatch) 

         @{ echo $(@:.o=.ko); echo $@; \ 

            $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod) 

-       $(call cmd_livepatch) 

 

  quiet_cmd_cc_lst_c = MKLST   $@ 

        cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \ 

@@ -469,6 +469,7 @@ cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ 
$(filter %.o,$^) $(cmd_secanalysis
 

  $(multi-used-m): FORCE 

         $(call if_changed,link_multi-m) 

+       $(call cmd,livepatch) 

         @{ echo $(@:.o=.ko); echo $(filter %.o,$^); \ 

            $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod) 

  $(call multi_depend, $(multi-used-m), .o, -objs -y -m) 

-- 

2.16.4
