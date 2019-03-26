Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5811C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DFB20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732151AbfCZQPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:15:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfCZQPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:15:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 87A205946F;
        Tue, 26 Mar 2019 16:15:30 +0000 (UTC)
Received: from [10.18.17.208] (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C1E65C231;
        Tue, 26 Mar 2019 16:15:28 +0000 (UTC)
Subject: Re: [PATCH v2 2/8] kbuild: Support for Symbols.list creation
To:     Joao Moreira <jmoreira@suse.de>, Miroslav Benes <mbenes@suse.cz>
Cc:     live-patching@vger.kernel.org, pmladek@suse.cz, jikos@suse.cz,
        nstange@suse.de, jpoimboe@redhat.com, khlebnikov@yandex-team.ru,
        jeyu@kernel.org, matz@suse.de, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com, linux-kbuild@vger.kernel.org,
        michal.lkml@markovi.net
References: <20190301141313.15057-1-jmoreira@suse.de>
 <20190301141313.15057-3-jmoreira@suse.de> <20190318191926.GA23138@redhat.com>
 <alpine.LSU.2.21.1903202000470.29796@pobox.suse.cz>
 <5f615af5-ced7-2361-5b71-71fece8b43c5@suse.de>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <ae018181-fd8a-03b2-69bf-e9302172bfeb@redhat.com>
Date:   Tue, 26 Mar 2019 12:15:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <5f615af5-ced7-2361-5b71-71fece8b43c5@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 26 Mar 2019 16:15:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/19 10:40 AM, Joao Moreira wrote:
> 
> 
> On 3/20/19 4:08 PM, Miroslav Benes wrote:
>>>> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
>>>> index fd03d60f6c5a..1e28ad21314c 100644
>>>> --- a/scripts/Makefile.build
>>>> +++ b/scripts/Makefile.build
>>>> @@ -247,6 +247,11 @@ cmd_gen_ksymdeps = \
>>>>    	$(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> $(dot-target).cmd
>>>>    endif
>>>>    
>>>> +ifdef CONFIG_LIVEPATCH
>>>> +cmd_livepatch = $(if $(LIVEPATCH_$(basetarget).o),			\
>>>> +	$(shell touch $(MODVERDIR)/$(basetarget).livepatch))
>>>> +endif
>>>> +
>>>>    define rule_cc_o_c
>>>>    	$(call cmd,checksrc)
>>>>    	$(call cmd_and_fixdep,cc_o_c)
>>>> @@ -283,6 +288,7 @@ $(single-used-m): $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) F
>>>>    	$(call if_changed_rule,cc_o_c)
>>>>    	@{ echo $(@:.o=.ko); echo $@; \
>>>>    	   $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
>>>> +	$(call cmd_livepatch)
>>>>    
>>>>    quiet_cmd_cc_lst_c = MKLST   $@
>>>>          cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \
>>>
>>> Since cmd_livepatch is only called for single-used-m, does this mean
>>> that we can only klp-convert single object file livepatch modules?
>>>
>>> I stumbled upon this when trying to create a self-test module that
>>> incorporated two object files.  I tried adding a $(call cmd_livepatch)
>>> in the recipe for $(obj)/%.o, but that didn't help.  My kbuild foo
>>> wasn't good enough to figure this one out.
>>
>> I looked at my original code and it is a bit different there. I placed it
>> under rule_cc_o_c right after objtool command. If I remember correctly
>> this is the correct recipe for .c->.o. Unfortunately I forgot the details
>> and there is of course nothing about it in my notes.
>>
>> Does it help?
>>
>> Joao, is there a reason you moved it elsewhere?
> 
> Hi,
> 
> Unfortunately I can't remember why the chunk was moved to where it is in
> this version of the patch, sorry. Yet, I did try to move this into the
> rule cc_o_c and it seemed to work with not damage.
> 
> Joe, would you kindly verify and squash properly the patch below, which
> places cmd_livepatch in rule_cc_o_c?
> 
> Thank you.
> 
> Subject: [PATCH] Move cmd_klp_convert to the right place
> 
>   
> 
> Signed-off-by: Joao Moreira <jmoreira@suse.de>
> 
> ---
> 
>    scripts/Makefile.build | 2 +-
> 
>    1 file changed, 1 insertion(+), 1 deletion(-)
> 
>   
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 1e28ad21314c..5f66106a47d6 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -260,6 +260,7 @@ define rule_cc_o_c
>           $(call cmd,objtool)
>           $(call cmd,modversions_c)
>           $(call cmd,record_mcount)
> +       $(call cmd,livepatch)
>    endef
>   
>    define rule_as_o_S
> @@ -288,7 +289,6 @@ $(single-used-m): $(obj)/%.o: $(src)/%.c
> $(recordmcount_source) $(objtool_dep) F
>           $(call if_changed_rule,cc_o_c)
>           @{ echo $(@:.o=.ko); echo $@; \
>              $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
> -       $(call cmd_livepatch)
>   
>    quiet_cmd_cc_lst_c = MKLST   $@
>          cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \

Hi Joao,

This change seems to work okay for (again) single object modules, but 
I'm having issues with multi-object modules.

Here are my sources:

% head -n100 *
==> Makefile <==
KDIR := /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)

LIVEPATCH_test_mod_a.o := y
LIVEPATCH_test_mod_b.o := y

obj-m += test_mod.o

test_mod-y := \
         test_mod_a.o \
         test_mod_b.o

default:
         $(MAKE) -C $(KDIR) M=$(PWD)
clean:
         @rm -rf .tmp_versions/
         @rm -f .*.cmd *.o *.mod.* *.ko modules.order Module.symvers

==> test_mod_a.c <==
#include <linux/module.h>
__used static void function(void) { }
MODULE_LICENSE("GPL");

==> test_mod_b.c <==
__used static void function(void) { }



But when I build, I don't see klp-convert invoked for any of the object 
files:

% make
make -C /lib/modules/5.0.0+/build M=/home/cloud-user/klp-convert-modtest
make[1]: Entering directory '/home/cloud-user/disk/linux'
   CC [M]  /home/cloud-user/klp-convert-modtest/test_mod_a.o
   CC [M]  /home/cloud-user/klp-convert-modtest/test_mod_b.o
   LD [M]  /home/cloud-user/klp-convert-modtest/test_mod.o
   Building modules, stage 2.
   MODPOST 1 modules
   CC      /home/cloud-user/klp-convert-modtest/test_mod.mod.o
   LD [M]  /home/cloud-user/klp-convert-modtest/test_mod.ko
make[1]: Leaving directory '/home/cloud-user/disk/linux'

However, if I modify the Makefile to build test_mod_a.o into its own 
module, I see "KLP 
/home/cloud-user/klp-convert-modtest/test_mod_a.ko" in the build output.

-- Joe
