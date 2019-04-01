Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60990C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F8720896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbfDAGiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 02:38:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:59766 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726836AbfDAGiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 02:38:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 505E3AD27;
        Mon,  1 Apr 2019 06:38:15 +0000 (UTC)
Subject: Re: [PATCH] x86/paravirt: Guard against invalid cpu # in
 pv_vcpu_is_preempted()
To:     Waiman Long <longman@redhat.com>,
        Alok Kataria <akataria@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20190325155706.26987-1-longman@redhat.com>
 <e01da674-cbf0-22f1-7aba-6041f892b689@suse.com>
 <5a48f5fb-799e-84f8-1fa7-eda851878d50@redhat.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ad016e8f-acb5-6685-b7b6-de801c002dc6@suse.com>
Date:   Mon, 1 Apr 2019 08:38:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <5a48f5fb-799e-84f8-1fa7-eda851878d50@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2019 19:03, Waiman Long wrote:
> On 03/25/2019 12:40 PM, Juergen Gross wrote:
>> On 25/03/2019 16:57, Waiman Long wrote:
>>> It was found that passing an invalid cpu number to pv_vcpu_is_preempted()
>>> might panic the kernel in a VM guest. For example,
>>>
>>> [    2.531077] Oops: 0000 [#1] SMP PTI
>>>   :
>>> [    2.532545] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
>>> [    2.533321] RIP: 0010:__raw_callee_save___kvm_vcpu_is_preempted+0x0/0x20
>>>
>>> To guard against this kind of kernel panic, check is added to
>>> pv_vcpu_is_preempted() to make sure that no invalid cpu number will
>>> be used.
>>>
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>>  arch/x86/include/asm/paravirt.h | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
>>> index c25c38a05c1c..4cfb465dcde4 100644
>>> --- a/arch/x86/include/asm/paravirt.h
>>> +++ b/arch/x86/include/asm/paravirt.h
>>> @@ -671,6 +671,12 @@ static __always_inline void pv_kick(int cpu)
>>>  
>>>  static __always_inline bool pv_vcpu_is_preempted(long cpu)
>>>  {
>>> +	/*
>>> +	 * Guard against invalid cpu number or the kernel might panic.
>>> +	 */
>>> +	if (WARN_ON_ONCE((unsigned long)cpu >= nr_cpu_ids))
>>> +		return false;
>>> +
>>>  	return PVOP_CALLEE1(bool, lock.vcpu_is_preempted, cpu);
>>>  }
>> Can this really happen without being a programming error?
> 
> This shouldn't happen without a programming error, I think. In my case,
> it was caused by a race condition leading to use-after-free of the cpu
> number. However, my point is that error like that shouldn't cause the
> kernel to panic.
> 
>> Basically you'd need to guard all percpu area accesses to foreign cpus
>> this way. Why is this one special?
> 
> It depends. If out-of-bound access can only happen with obvious
> programming error, I don't think we need to guard against them. In this
> case, I am not totally sure if the race condition that I found may
> happen with existing code or not. To be prudent, I decide to send this
> patch out.
> 
> The race condition that I am looking at is as follows:
> 
>   CPU 0                         CPU 1
>   -----                         -----
> up_write:
>   owner = NULL;
>   <release-barrier>
>   count = 0;
> 
> <rcu-free task structure>
>  
>                           rwsem_can_spin_on_owner:
>                             rcu_read_lock();
>                             read owner;
>                               :
>                             vcpu_is_preempted(owner->cpu);
>                               :
>                             rcu_read_unlock()
> 
> When I tried to merge the owner into the count (clear the owner after
> the barrier), I can reproduce the crash 100% when booting up the kernel
> in a VM guest. However, I am not sure if the configuration above is safe
> and is just very hard to reproduce.
> 
> Alternatively, I can also do the cpu check before calling
> vcpu_is_preempted().

I think I'd prefer that.


Juergen

