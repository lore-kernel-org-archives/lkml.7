Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DDBC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8F62077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfD0KfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 06:35:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfD0KfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 06:35:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4EF7A30BEEF0;
        Sat, 27 Apr 2019 10:35:08 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20AD765F60;
        Sat, 27 Apr 2019 10:35:07 +0000 (UTC)
Subject: Re: [-next] system hangs likely due to "modules: Only return -EEXIST
 for modules that have finished loading"
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Jessica Yu <jeyu@kernel.org>, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Cathy Avery <cavery@redhat.com>
References: <20190426130736.GB8646@osiris>
 <d4d75ad1-e193-c230-1edc-a93db2b068d7@redhat.com>
 <20190426150741.GD8646@osiris> <20190426160956.GA3827@linux-8ccs>
 <2e047a7e-bf08-be8c-bdd0-429464fa133d@redhat.com>
 <52c293e9-ddfa-426a-a8f1-2106e250e78d@redhat.com>
 <f74996cb-3e0a-ab23-00b9-85ac782583d1@redhat.com>
 <20190427102440.GA28889@osiris>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <3ceb784f-89ec-d208-a5b1-6306f0894217@redhat.com>
Date:   Sat, 27 Apr 2019 06:35:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190427102440.GA28889@osiris>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sat, 27 Apr 2019 10:35:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/19 6:24 AM, Heiko Carstens wrote:
> On Fri, Apr 26, 2019 at 08:20:52PM -0400, Prarit Bhargava wrote:
>> Heiko and Jessica,
>>
>> The issue doesn't appear to be with my patch AFAICT.  The s390_trng fails to
>> load and then the kernel occasionally hangs (as Heiko mentioned) calling
>> synchronize_rcu().
>>
>> The call sequence is
>>
>> module_load()
>> 	do_init_module()
>> 		do_one_initcall(mod->init)
>>
>> which fails.
>>
>> The failure path in do_one_initcall() is entered and we start executing code at
>> kernel/module.c:3541
>>
>> fail_free_freeinit:
>>         kfree(freeinit);
>> fail:
>>         /* Try to protect us from buggy refcounters. */
>>         mod->state = MODULE_STATE_GOING;
>>         synchronize_rcu();
>>
>> ^^^ the kernel hangs here.  Sometimes it's very short and other times it seems
>> to hang.   I've left systems that appear to be hung and come back after 10
>> minutes to find that they've somehow made it through this call.
>>
>> Is there a known issue with RCU on s390 that is making this occur?
> 
> No there is no known issue with RCU on s390. The reason that
> synchronize_rcu() doesn't finish is because a different cpu is within
> an endless loop in add_unformed_module() just like Jessica suspected.
> 
> Note: the kernel is compiled with CONFIG_PREEMPT off - there is no
> kernel preemption that will make the looping cpu ever go over schedule
> and subsequently let synchronize_rcu() finish.
> 
> To confirm Jessicas theory - looking into the dump we have:
> 
> crash> bt 742
> PID: 742    TASK: 1efa6c000         CPU: 7   COMMAND: "systemd-udevd"
>  #0 [3e0043aba30] __schedule at abb25e
>  #1 [3e0043abaa0] schedule at abb6a2
>  #2 [3e0043abac8] schedule_timeout at abf49a
>  #3 [3e0043abb60] wait_for_common at abc396
>  #4 [3e0043abbf0] __wait_rcu_gp at 1c0136
>  #5 [3e0043abc48] synchronize_rcu at 1c72ea
>  #6 [3e0043abc98] do_init_module at 1f10be
>  #7 [3e0043abcf0] load_module at 1f3594
>  #8 [3e0043abdd0] __se_sys_init_module at 1f3af0
>  #9 [3e0043abea8] system_call at ac0766
> 
> Which is the process waiting for synchronize_rcu to finish. Wading
> through the stack frames gives me this struct module:
> 
> struct module {
>   state = MODULE_STATE_GOING,
>   list = {
>     next = 0x3ff80394508,
>     prev = 0xe25090 <modules>
>   },
>   name = "s390_trng\000...
> ...
> 
> Then we have the looping task/cpu:
> 
> PID: 731    TASK: 1e79ba000         CPU: 7   COMMAND: "systemd-udevd"
>  LOWCORE INFO:
>   -psw      : 0x0704c00180000000 0x0000000000ab666a
>   -function : memcmp at ab666a
> ...
>   -general registers:
>      0x0000000000000009 0x0000000000000009
>      0x000003ff80347321 000000000000000000
>      0x000003ff8034f321 000000000000000000
>      0x000000000000001e 0x000003ff8c592708
>      0x000003e0047da900 0x000003ff8034f318
>      0x0000000000000001 0x0000000000000009
>      0x000003ff80347300 0x0000000000ad81b8
>      0x00000000001ee062 0x000003e004357cb0
>  #0 [3e004357cf0] load_module at 1f1eb0
>  #1 [3e004357dd0] __se_sys_init_module at 1f3af0
>  #2 [3e004357ea8] system_call at ac0766
> 
> which is find_module_all() calling memcmp with this string:
> 
> 3ff80347318:  733339305f74726e 6700000000000000   s390_trng.......
> 
> So it all seems to fit. A simple cond_resched() call, which enforces
> an RCU quiescent state for the calliung cpu, fixes the problem for me
> (patch on top of linux-next 20190424 -- c392798a85ab):
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 410eeb7e4f1d..48748cfec991 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3585,6 +3585,7 @@ again:
>  					       finished_loading(mod->name));
>  			if (err)
>  				goto out_unlocked;
> +			cond_resched();

You just beat me to posting this :).  I am testing out this same patch in a loop
on a few systems here in the lab.  Will let you know results on Monday.

P.

>  			goto again;
>  		}
>  		err = -EEXIST;
> 
