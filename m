Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08E7C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C6B2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389214AbfGRIeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 04:34:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54488 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfGRIeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 04:34:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so24654059wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 01:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oyQnxgvW48MflIIGvDKgphM3U+A4nQhpaY8n8J3JEU8=;
        b=IGlNY68r6mjDPg5fK/Fzlt8tpPoBZn1wFWpmDjNzUY96U07/D5JH4jqsfuEqATIPAW
         WD/hZzFuM++6rpCppgArb3MMYB02ykee9lCu/F+6/gVXMbM8e9H/FyNJbYLbFSvsxFt3
         4k/wHVOdL/5+98T1o2flFctTZMh2+M1wbtW6WvUxRCUSiv3jDAjAsOvB5lPa8QlAZw5Z
         8KwTIIUOv2tRf9H+drjmnISF/B48tXWa1pT5AcrKjgvbXas9ReCi6C3I8a0RdzjvgQs2
         aSUR1R4zAMw/BZpK5mSj8X0CPoRfCq3BvUUhCxbAoz5K125cu6HSmtRcLkYA0fcii0fd
         /yTQ==
X-Gm-Message-State: APjAAAUu1jojVFJ6Pwcy8kDf6Gsuk/exkM869bv+GrVKqV5hBg7mZnzY
        KGg+UkeVmF3qTLPEn0FVBvHkHXJgTunwzw==
X-Google-Smtp-Source: APXvYqxkdaslaXuIOrStTxZXg88Np8F8FRCcSBEQh5L+2SsEztfofLT+uhyL1VDV8EDLffiZ4NpMUg==
X-Received: by 2002:a1c:44d7:: with SMTP id r206mr42116191wma.164.1563438846134;
        Thu, 18 Jul 2019 01:34:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2? ([2001:b07:6468:f312:e427:3beb:1110:dda2])
        by smtp.gmail.com with ESMTPSA id p18sm24776435wrm.16.2019.07.18.01.34.05
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 01:34:05 -0700 (PDT)
Subject: Re: [PATCH RESEND] KVM: Boosting vCPUs that are delivering interrupts
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1562915730-9490-1-git-send-email-wanpengli@tencent.com>
 <f95fbf72-090f-fb34-3c20-64508979f251@redhat.com>
 <db74a3a8-290e-edff-10ad-f861c60fbf8e@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e31024e4-f437-becd-a9e3-e1ea8cd2e0c7@redhat.com>
Date:   Thu, 18 Jul 2019 10:34:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <db74a3a8-290e-edff-10ad-f861c60fbf8e@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/19 10:15, Christian Borntraeger wrote:
> 
> 
> On 18.07.19 09:59, Paolo Bonzini wrote:
>> On 12/07/19 09:15, Wanpeng Li wrote:
>>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>>> index b4ab59d..2c46705 100644
>>> --- a/virt/kvm/kvm_main.c
>>> +++ b/virt/kvm/kvm_main.c
>>> @@ -2404,8 +2404,10 @@ void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
>>>  	int me;
>>>  	int cpu = vcpu->cpu;
>>>  
>>> -	if (kvm_vcpu_wake_up(vcpu))
>>> +	if (kvm_vcpu_wake_up(vcpu)) {
>>> +		vcpu->preempted = true;
>>>  		return;
>>> +	}
>>>  
>>>  	me = get_cpu();
>>>  	if (cpu != me && (unsigned)cpu < nr_cpu_ids && cpu_online(cpu))
>>>
>>
>> Who is resetting vcpu->preempted to false in this case?  This also
>> applies to s390 in fact.
> 
> Isnt that done by the sched_in handler?

I am a bit confused because, if it is done by the sched_in later, I
don't understand why the sched_out handler hasn't set vcpu->preempted
already.

The s390 commit message is not very clear, but it talks about "a former
sleeping cpu" that "gave up the cpu voluntarily".  Does "voluntarily"
that mean it is in kvm_vcpu_block?  But then at least for x86 it would
be after vcpu_load so the preempt notifiers have been registered, and
for s390 too (kvm_arch_vcpu_ioctl_run -> __vcpu_run -> vcpu_post_run ->
kvm_handle_sie_intercept etc.).

Paolo
