Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576EDC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6582089E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rjQjG3D4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfEJSkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 14:40:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44217 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfEJSke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 14:40:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id g9so3658023pfo.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 11:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/bithr+kT4zLrY/mH5+1plydNilDrLa+4zibF6uqjAs=;
        b=rjQjG3D4umF3zGdotLHE6MDicxS2CU2lnimitA3OpoAEceOmUOZbpx39PDr6GGLbW+
         bQLX5oe3kL+55KTZSShtzENIrNuzkbJKGjcXnzHzFvKZMbxyAY4l2MsVJQhNIM21rpUe
         /+rhftX3RSV6iErelhAMDsEPbHRRN1guZ8yw+A6K2JsSS7AMAFHmCv89KZR1jzXFc8Ba
         kp3Ci94en175BdmT6VMciziGMyfN9WUmDfaeyeMJs056NBOnieoYAlcARZmYpY4KKs6x
         6Sg8hlvaqdYFZ85ILiWtuKZ/ByHhRFt4fEeDou6Wq02p064TeOKg7vLi8jNobsnJmPl1
         J1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/bithr+kT4zLrY/mH5+1plydNilDrLa+4zibF6uqjAs=;
        b=uRjuTIyYVjKdOXtZQMmm+KQaJ5dEBsNTFVe445PawR8lc+V0srN7iRCeNZ5vfZEidU
         cE4IsFAXtyz0Pd7MRmRLZBA8/t2XPNBZIRnd1RRKNTqD/FJZGm2JGeHlySjsqve930wE
         V6layOwVKFKAPZ1xVGVuogTzKrXbMc/2XVB1a/i+n9zIRxijuAwb3fXlpMthy7AqPzGG
         HFzeyGJLCa1+cohzLizb7tNii4IGOsKGykHOY2ahgE3QHw/hA9Q/SsEittY8n8VbSLT1
         x97rGTWdSYGy+NCAbETCpxpduwtFPaNwSxYGB4exsaSpChKLMG1ReCKJjXsrVcPTBBoB
         qKUg==
X-Gm-Message-State: APjAAAXNUiQrRXypz3N89wViEmQso+IPVFGFelsSEtEt1QtEwb9iadrt
        UHNS+oQ+ay35L+KHRRCjeZpAiQ==
X-Google-Smtp-Source: APXvYqzybYX8uTQwh/fxm4aqj5IsezE3WkmKqX3lmy6cZFK93SOUQOhoZM6socdcz/dZZP0RIDpxtQ==
X-Received: by 2002:a62:414a:: with SMTP id o71mr16867943pfa.240.1557513633072;
        Fri, 10 May 2019 11:40:33 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id e123sm316176pgc.29.2019.05.10.11.40.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 11:40:32 -0700 (PDT)
Subject: Re: [PATCH v3] kernel/module: Reschedule while waiting for modules to
 finish loading
To:     Prarit Bhargava <prarit@redhat.com>, Jessica Yu <jeyu@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Arcari <darcari@redhat.com>
References: <20190430222207.3002-1-prarit@redhat.com>
 <90e18809-2b70-52d8-00b3-9c16768db9ad@redhat.com>
 <20190502094813.GA6690@linux-8ccs>
 <f0bc15a4-0f99-c899-b7d7-2d4db86e287e@redhat.com>
 <4849a5af-b2bb-95ad-6b58-2f0c403c9ebb@redhat.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <be47ac01-a5ac-7be1-d387-5c841007b45f@google.com>
Date:   Fri, 10 May 2019 14:40:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4849a5af-b2bb-95ad-6b58-2f0c403c9ebb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

On 5/2/19 1:46 PM, Prarit Bhargava wrote:
> On 5/2/19 8:41 AM, Prarit Bhargava wrote:
>> On 5/2/19 5:48 AM, Jessica Yu wrote:
>>> +++ Prarit Bhargava [01/05/19 17:26 -0400]:
>>>> On 4/30/19 6:22 PM, Prarit Bhargava wrote:
>>>>> On a s390 z14 LAR with 2 cpus about stalls about 3% of the time while
>>>>> loading the s390_trng.ko module.
>>>>>
>>>>> Add a reschedule point to the loop that waits for modules to complete
>>>>> loading.
>>>>>
>>>>> v3: cleanup Fixes line.
>>>>
>>>> Jessica, even with this additional patch there appears to be some other issues
>>>> in the module code that are causing significant delays in boot up on large
>>>> systems.
>>>
>>> Is this limited to only s390? Or are you seeing this on other arches
>>> as well? And is it limited to specific modules (like s390_trng)?
>>
>> Other arches.  We're seeing a hang on a new 192 CPU x86_64 box & the
>> acpi_cpufreq driver.  The system is MUCH faster than any other x86_64 box I've
>> seen and that's likely why I'm seeing a problem.
>>
>>>
>>>> FWIW, the logic in the original patch is correct.  It's just that there's, as
>>>> Heiko discovered, some poor scheduling, etc., that is impacting the module
>>>> loading code after these changes.
>>>
>>> I am really curious to see what these performance regressions look
>>> like :/ Please update us when you find out more.
>>>
>>
>> I sent Heiko a private v4 RFC last night with this patch (sorry for the
>> cut-and-paste)
>>
>> diff --git a/kernel/module.c b/kernel/module.c
>> index 1c429d8d2d74..a4ef8628f26f 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -3568,12 +3568,12 @@ static int add_unformed_module(struct module *mod)
>> 	mutex_lock(&module_mutex);
>> 	old = find_module_all(mod->name, strlen(mod->name), true);
>> 	if (old != NULL) {
>> -		if (old->state == MODULE_STATE_COMING
>> -		    || old->state == MODULE_STATE_UNFORMED) {
>> +		if (old->state != MODULE_STATE_LIVE) {
>> 			/* Wait in case it fails to load. */
>> 			mutex_unlock(&module_mutex);
>> -			err = wait_event_interruptible(module_wq,
>> -					       finished_loading(mod->name));
>> +			err = wait_event_interruptible_timeout(module_wq,
>> +					       finished_loading(mod->name),
>> +					       HZ / 10000);
>> 			if (err)
>> 				goto out_unlocked;
>> 			goto again;
>>
>> The original module dependency race issue is fixed simply by changing the
>> conditional to checking !MODULE_STATE_LIVE.  This, unfortunately, exposed some
>> other problems within the code.
>>
>> The module_wq is only run when a module fails to load.  It's possible that
>> the time between the module's failed init() call and running module_wq
>> (kernel/module.c:3455) takes a while.  Any thread entering the
>> add_unformed_module() code while the old module is unloading is put to sleep
>> waiting for the module_wq to execute.
>>
>> On the 192 thread box I have noticed that the acpi_cpufreq module attempts
>> to load 392 times (that is not a typo and I am going to try to figure that
>> problem out after this one).  This means 191 cpus are put to sleep, and one
>> cpu is executing the acpi_cpufreq module unload which is executing
>> do_init_module() and is now at
>>
>> fail_free_freeinit:
>>          kfree(freeinit);
>> fail:
>>          /* Try to protect us from buggy refcounters. */
>>          mod->state = MODULE_STATE_GOING;
>>          synchronize_rcu();
>>          module_put(mod);
>>          blocking_notifier_call_chain(&module_notify_list,
>>                                       MODULE_STATE_GOING, mod);
>>          klp_module_going(mod);
>>          ftrace_release_mod(mod);
>>          free_module(mod);
>>          wake_up_all(&module_wq);
>>          return ret;
>> }
>>
>> The 191 threads cannot schedule and the system is effectively stuck.  It *does*
>> eventually free itself but in some cases it takes minutes to do so.
>>
>> A simple fix for this is to, as I've done above, to add a timeout so that
>> the threads can be scheduled which allows other processes to run.
> 
> After taking a much closer look the above patch appears to be correct.  I am not
> seeing any boot failures associated with it anywhere.  I would like to hear from
> Heiko as to whether or not this works for him though.

I think I found the issue here.  The original patch changed the state 
check to "not LIVE", which made it include GOING.  However, the wake 
condition was not changed.  That could lead to a livelock, which I 
experienced.

I have a patch that fixes it, which I'll send out shortly.  With my 
change, I think you won't need any of the scheduler functions 
(cond_resched(), wait timeouts, etc).  Those were probably just papering 
over the issue.

Barret

