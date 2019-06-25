Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE84C48BD7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C2320645
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbfFYRC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 13:02:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38022 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729327AbfFYRC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:02:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id d18so18744404wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 10:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=liXiXOTbkoDp/qbfnFrNt8qM6Q8788YsTYQ3Fw/+ziQ=;
        b=Fvpfb755H5NEV43jqobZKfmcvYUFJHmMESv/jj3JwKK2iWoLoSav4JVifrlLsR1/2B
         wdYHmiDPBHkNcbDWEJ7TXuNKIaKHYsPTQF+mG6SzyJtyNy+AThX+OmhN2xOLVb9n3jl6
         aqRqVhs+BtFGiqdS2z53SyicwZRS/svz5Hj5NAAy4wXkqyn0hEx3DxTLUfvHXAqXsyo+
         5wmhDJiQVgSQvIPynYtsWjcchcACXOTKTM58bDe3A0PyGLACkqOPWRbaq3aL5xfgkqja
         nUltkuoSuCcifIXM5MTLItsqbx6h2DFQAoxo17gxps8kPs/3El5LlamRvKijYT7p1mqn
         DeNA==
X-Gm-Message-State: APjAAAWsb7qzMxm6XcBVY3hjpEBfMR2VB6/k8+vq9LvqozKdqORad0Iy
        89YAVgxpZy4VregUCKcUkuSOzA==
X-Google-Smtp-Source: APXvYqynijDDjrlgLFhNccoXXK3ZOajwfNB7FlRvmffo16bxHDbONazKhQlofKadU5ak+LxpLapCbA==
X-Received: by 2002:a5d:5286:: with SMTP id c6mr103308120wrv.118.1561482176939;
        Tue, 25 Jun 2019 10:02:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:61c1:6d8f:e2c4:2d5c? ([2001:b07:6468:f312:61c1:6d8f:e2c4:2d5c])
        by smtp.gmail.com with ESMTPSA id x16sm2000115wmj.4.2019.06.25.10.02.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 10:02:55 -0700 (PDT)
Subject: Re: [PATCH v4 2/5] KVM: LAPIC: inject lapic timer interrupt by posted
 interrupt
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1560770687-23227-1-git-send-email-wanpengli@tencent.com>
 <1560770687-23227-3-git-send-email-wanpengli@tencent.com>
 <20190618133541.GA3932@amt.cnet>
 <CANRm+Cz0v1VfDaCCWX+5RzCusTV7g9Hwr+OLGDRijeyqFx=Kzw@mail.gmail.com>
 <20190619210346.GA13033@amt.cnet>
 <CANRm+Cwxz7rR3o2m1HKg0-0z30B8-O-i4RrVC6EMG1jgBRxWPg@mail.gmail.com>
 <20190621214205.GA4751@amt.cnet>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <61e43444-f91c-3181-1f59-12a3634bf043@redhat.com>
Date:   Tue, 25 Jun 2019 19:02:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190621214205.GA4751@amt.cnet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/19 23:42, Marcelo Tosatti wrote:
> On Fri, Jun 21, 2019 at 09:42:39AM +0800, Wanpeng Li wrote:
>> On Thu, 20 Jun 2019 at 05:04, Marcelo Tosatti <mtosatti@redhat.com> wrote:
>>>
>>> Hi Li,
>>>
>>> On Wed, Jun 19, 2019 at 08:36:06AM +0800, Wanpeng Li wrote:
>>>> On Tue, 18 Jun 2019 at 21:36, Marcelo Tosatti <mtosatti@redhat.com> wrote:
>>>>>
>>>>> On Mon, Jun 17, 2019 at 07:24:44PM +0800, Wanpeng Li wrote:
>>>>>> From: Wanpeng Li <wanpengli@tencent.com>
>>>>>>
>>>>>> Dedicated instances are currently disturbed by unnecessary jitter due
>>>>>> to the emulated lapic timers fire on the same pCPUs which vCPUs resident.
>>>>>> There is no hardware virtual timer on Intel for guest like ARM. Both
>>>>>> programming timer in guest and the emulated timer fires incur vmexits.
>>>>>> This patch tries to avoid vmexit which is incurred by the emulated
>>>>>> timer fires in dedicated instance scenario.
>>>>>>
>>>>>> When nohz_full is enabled in dedicated instances scenario, the emulated
>>>>>> timers can be offload to the nearest busy housekeeping cpus since APICv
>>>>>> is really common in recent years. The guest timer interrupt is injected
>>>>>> by posted-interrupt which is delivered by housekeeping cpu once the emulated
>>>>>> timer fires.
>>>>>>
>>>>>> The host admin should fine tuned, e.g. dedicated instances scenario w/
>>>>>> nohz_full cover the pCPUs which vCPUs resident, several pCPUs surplus
>>>>>> for busy housekeeping, disable mwait/hlt/pause vmexits to keep in non-root
>>>>>> mode, ~3% redis performance benefit can be observed on Skylake server.
>>>>>>
>>>>>> w/o patch:
>>>>>>
>>>>>>             VM-EXIT  Samples  Samples%  Time%   Min Time  Max Time   Avg time
>>>>>>
>>>>>> EXTERNAL_INTERRUPT    42916    49.43%   39.30%   0.47us   106.09us   0.71us ( +-   1.09% )
>>>>>>
>>>>>> w/ patch:
>>>>>>
>>>>>>             VM-EXIT  Samples  Samples%  Time%   Min Time  Max Time         Avg time
>>>>>>
>>>>>> EXTERNAL_INTERRUPT    6871     9.29%     2.96%   0.44us    57.88us   0.72us ( +-   4.02% )
>>>>>>
>>>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>>>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>>>>>> Cc: Marcelo Tosatti <mtosatti@redhat.com>
>>>>>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>>>>>> ---
>>>>>>  arch/x86/kvm/lapic.c            | 33 ++++++++++++++++++++++++++-------
>>>>>>  arch/x86/kvm/lapic.h            |  1 +
>>>>>>  arch/x86/kvm/vmx/vmx.c          |  3 ++-
>>>>>>  arch/x86/kvm/x86.c              |  5 +++++
>>>>>>  arch/x86/kvm/x86.h              |  2 ++
>>>>>>  include/linux/sched/isolation.h |  2 ++
>>>>>>  kernel/sched/isolation.c        |  6 ++++++
>>>>>>  7 files changed, 44 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
>>>>>> index 87ecb56..9ceeee5 100644
>>>>>> --- a/arch/x86/kvm/lapic.c
>>>>>> +++ b/arch/x86/kvm/lapic.c
>>>>>> @@ -122,6 +122,13 @@ static inline u32 kvm_x2apic_id(struct kvm_lapic *apic)
>>>>>>       return apic->vcpu->vcpu_id;
>>>>>>  }
>>>>>>
>>>>>> +bool posted_interrupt_inject_timer(struct kvm_vcpu *vcpu)
>>>>>> +{
>>>>>> +     return pi_inject_timer && kvm_vcpu_apicv_active(vcpu) &&
>>>>>> +             kvm_hlt_in_guest(vcpu->kvm);
>>>>>> +}
>>>>>> +EXPORT_SYMBOL_GPL(posted_interrupt_inject_timer);
>>>>>
>>>>> Paolo, can you explain the reasoning behind this?
>>>>>
>>>>> Should not be necessary...
>>
>> https://lkml.org/lkml/2019/6/5/436  "Here you need to check
>> kvm_halt_in_guest, not kvm_mwait_in_guest, because you need to go
>> through kvm_apic_expired if the guest needs to be woken up from
>> kvm_vcpu_block."
> 
> Ah, i think he means that a sleeping vcpu (in kvm_vcpu_block) must
> be woken up, if it receives a timer interrupt.

Yes, this is true.

Paolo

> But your patch will go through:
> 
> kvm_apic_inject_pending_timer_irqs
> __apic_accept_irq -> 
> vmx_deliver_posted_interrupt ->
> kvm_vcpu_trigger_posted_interrupt returns false
> (because vcpu->mode != IN_GUEST_MODE) ->
> kvm_vcpu_kick
> 
> Which will wakeup the vcpu.
> 
> Apart from this oops, which triggers when running:
> taskset -c 1 ./cyclictest -D 3600 -p 99 -t 1 -h 30 -m -n  -i 50000 -b 40
> 
> Timer interruption from housekeeping vcpus is normal to me 
> (without requiring kvm_hlt_in_guest).
> 
> [ 1145.849646] BUG: kernel NULL pointer dereference, address:
> 0000000000000000
> [ 1145.850481] #PF: supervisor instruction fetch in kernel mode
> [ 1145.851161] #PF: error_code(0x0010) - not-present page
> [ 1145.851772] PGD 80000002a9fa5067 P4D 80000002a9fa5067 PUD 2abcbb067
> PMD 0 
> [ 1145.852578] Oops: 0010 [#1] PREEMPT SMP PTI
> [ 1145.853066] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.2.0-rc1+ #11
> [ 1145.853809] Hardware name: Red Hat KVM, BIOS 1.11.0-2.el7 04/01/2014
> [ 1145.854554] RIP: 0010:0x0
> [ 1145.854879] Code: Bad RIP value.
> [ 1145.855270] RSP: 0018:ffffc90001903e68 EFLAGS: 00010013
> [ 1145.855902] RAX: 0000010ac9f60043 RBX: ffff8882b58a8320 RCX:
> 00000000c526b7c4              
> [ 1145.856726] RDX: 0000000000000000 RSI: ffffffff820d9640 RDI:
> ffff8882b58a8320              
> [ 1145.857560] RBP: ffffffff820d9640 R08: 00000000c526b7c4 R09:
> 0000000000000832              
> [ 1145.858390] R10: 0000000000000000 R11: 0000000000000000 R12:
> 0000000000000000              
> [ 1145.859222] R13: ffffffff820d9658 R14: ffff8881063b2880 R15:
> 0000000000000002              
> [ 1145.860047] FS:  0000000000000000(0000) GS:ffff8882b5880000(0000)
> knlGS:0000000000000000   
> [ 1145.860994] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033                              
> [ 1145.861692] CR2: ffffffffffffffd6 CR3: 00000002ab1de001 CR4:
> 0000000000160ee0              
> [ 1145.862570] Call Trace:                                                                    
> [ 1145.862877]  cpuidle_enter_state+0x7c/0x3e0                                                
> [ 1145.863392]  cpuidle_enter+0x29/0x40                                                       
> 
> 
>> I think we can still be woken up from kvm_vcpu_block() if pir is set.
> 
> Exactly.
> 

