Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DE1C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814872173C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfDKPSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:18:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfDKPSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:18:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD74E70D6B;
        Thu, 11 Apr 2019 15:18:34 +0000 (UTC)
Received: from [10.18.17.208] (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F82C19C58;
        Thu, 11 Apr 2019 15:18:33 +0000 (UTC)
Subject: Re: [PATCH v3 2/9] kbuild: Support for Symbols.list creation
To:     Artem Savkov <asavkov@redhat.com>
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
References: <20190410155058.9437-1-joe.lawrence@redhat.com>
 <20190410155058.9437-3-joe.lawrence@redhat.com>
 <20190411091859.GF4995@shodan.usersys.redhat.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <e794f96e-e6aa-37a1-693c-a998ea4a9c60@redhat.com>
Date:   Thu, 11 Apr 2019 11:18:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411091859.GF4995@shodan.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 11 Apr 2019 15:18:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/19 5:18 AM, Artem Savkov wrote:
> On Wed, Apr 10, 2019 at 11:50:51AM -0400, Joe Lawrence wrote:
>> -clean: archclean vmlinuxclean
>> +klpclean:
>> +	$(Q) rm -f $(objtree)/Symbols.list
> 
> nit: $(SLIST) can be used here.
> 
>> +clean: archclean vmlinuxclean klpclean
>>   
>>   # mrproper - Delete all generated files, including .config
>>   #
>> diff --git a/samples/livepatch/Makefile b/samples/livepatch/Makefile
>> index 2472ce39a18d..8b9b42a258ad 100644
>> --- a/samples/livepatch/Makefile
>> +++ b/samples/livepatch/Makefile
>> @@ -1,3 +1,4 @@
>> +LIVEPATCH_livepatch-sample := y
>>   obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-sample.o
>>   obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-shadow-mod.o
>>   obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-shadow-fix1.o
>> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
>> index 76ca30cc4791..ca76bd2080f0 100644
>> --- a/scripts/Makefile.build
>> +++ b/scripts/Makefile.build
>> @@ -246,6 +246,11 @@ cmd_gen_ksymdeps = \
>>   	$(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> $(dot-target).cmd
>>   endif
>>   
>> +ifdef CONFIG_LIVEPATCH
>> +cmd_livepatch = $(if $(LIVEPATCH_$(basetarget)),		\
>> +	$(shell touch $(MODVERDIR)/$(basetarget).livepatch))
>> +endif
>> +
>>   define rule_cc_o_c
>>   	$(call cmd,checksrc)
>>   	$(call cmd_and_fixdep,cc_o_c)
>> @@ -280,6 +285,7 @@ $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
>>   $(single-used-m): $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
>>   	$(call cmd,force_checksrc)
>>   	$(call if_changed_rule,cc_o_c)
>> +	$(call cmd_livepatch)
> 
> nit: maybe use "cmd,livepatch" to be consistent with the other call of
> this function.
> 

Both of these make sense, thanks Artem.

-- Joe
