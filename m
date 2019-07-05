Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5647EC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3051A218A3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfGEN0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 09:26:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33632 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbfGEN0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 09:26:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so9974787wru.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 06:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5QNK02sutwjpQD4Kojggq80G41ltWM2v/J3VAs0y3RE=;
        b=O+EEYG0pjdc0hPLSoCUHNWNBNvf/0TVifqb+Js8kayiBkew4vVncHooSlwNVVkjJbo
         cQy6dyEUa0rREmn8lQccd2tSBJmbxWSo8bIhnjvUnv8A8keFGNvBHTEV6u9m3u7teyML
         VTTuto7wyBGNkOTxyxLY1IRVw0dBKQHPMpOc9h+KynYT2YsM1NIA119dGVU/5rdpGCx6
         d2YDSwlbl19G01H5j64QHgndsoz6+tqPPAxOe/HDx3u6GbaD0YNPzF2lpSWZ89wk0BHA
         P1TRnXKn/i+2Fb8F8QRJK0DN0+a2zVoSD7WAHt+If9b2dxQWmy7HYGzY2qs2zxDY3um4
         V6FA==
X-Gm-Message-State: APjAAAX3B7n+BUuy4K4Bq4MK5tbpdKvoN+MRiybjaVyclD3RW72XXZzz
        GkmBa7t4+LYzZMjnTvQ2pGtWAw==
X-Google-Smtp-Source: APXvYqzKhj5sL/IxIleuiZ5IX5haQeq0M7D55wlrZJL3O4fo1x/nntdB9V+CG2PaHhNPuAuvfVvc+A==
X-Received: by 2002:a5d:5510:: with SMTP id b16mr4165583wrv.267.1562333163572;
        Fri, 05 Jul 2019 06:26:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e943:5a4e:e068:244a? ([2001:b07:6468:f312:e943:5a4e:e068:244a])
        by smtp.gmail.com with ESMTPSA id y7sm3656457wmm.19.2019.07.05.06.26.02
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 06:26:03 -0700 (PDT)
Subject: Re: [PATCH v5 4/4] KVM: LAPIC: Don't inject already-expired timer via
 posted interrupt
To:     Wanpeng Li <wanpeng.li@hotmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
References: <1561110002-4438-1-git-send-email-wanpengli@tencent.com>
 <1561110002-4438-5-git-send-email-wanpengli@tencent.com>
 <67fad01b-8a77-5892-d963-77a3d321bb65@redhat.com>
 <HK2PR02MB4145B13227997511174DBFA480F50@HK2PR02MB4145.apcprd02.prod.outlook.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <847fc9bd-c0b9-0f7b-f029-9a5499f2c74e@redhat.com>
Date:   Fri, 5 Jul 2019 15:26:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <HK2PR02MB4145B13227997511174DBFA480F50@HK2PR02MB4145.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/19 15:11, Wanpeng Li wrote:
> On 7/5/19 8:40 PM, Paolo Bonzini wrote:
> 
>> On 21/06/19 11:40, Wanpeng Li wrote:
>>> From: Wanpeng Li <wanpengli@tencent.com>
>>>
>>> already-expired timer interrupt can be injected to guest when vCPU who
>>> arms the lapic timer re-vmentry, don't posted inject in this case.
>>>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>>> Cc: Marcelo Tosatti <mtosatti@redhat.com>
>>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>>> ---
>>>   arch/x86/kvm/lapic.c | 14 +++++++-------
>>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
>>> index ae575c0..7cd95ea 100644
>>> --- a/arch/x86/kvm/lapic.c
>>> +++ b/arch/x86/kvm/lapic.c
>>> @@ -1452,7 +1452,7 @@ static void kvm_apic_inject_pending_timer_irqs(struct kvm_lapic *apic)
>>>   	}
>>>   }
>>>   
>>> -static void apic_timer_expired(struct kvm_lapic *apic)
>>> +static void apic_timer_expired(struct kvm_lapic *apic, bool can_pi_inject)
>>>   {
>>>   	struct kvm_vcpu *vcpu = apic->vcpu;
>>>   	struct swait_queue_head *q = &vcpu->wq;
>>> @@ -1464,7 +1464,7 @@ static void apic_timer_expired(struct kvm_lapic *apic)
>>>   	if (apic_lvtt_tscdeadline(apic) || ktimer->hv_timer_in_use)
>>>   		ktimer->expired_tscdeadline = ktimer->tscdeadline;
>>>   
>>> -	if (posted_interrupt_inject_timer(apic->vcpu)) {
>>> +	if (can_pi_inject && posted_interrupt_inject_timer(apic->vcpu)) {
>> Perhaps it should use a posted interrupt if kvm_arch_should_kick(vcpu),
>> i.e. just add kvm_arch_vcpu_should_kick(apic->vcpu) to
>> posted_interrupt_inject_timer?
> 
> So do you mean not nohz_full setup? An external interrupt is incurred 
> here and preemption timer is better.

No, I mean instead of adding can_pi_inject, just test
kvm_arch_should_kick in posted_interrupt_inject_timer, skipping the PI
if the vCPU is not running.  Instead just go down the normal path and
the guest will get the interrupt by checking the timer-pending flag.

Paolo
