Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD90FC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921F321850
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfFMR1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:27:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35448 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfFMR1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 13:27:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id c6so10989158wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 10:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j4UDJkczRpfkTiJNATKEtxOPGJyA2hruwu9S/Srh2+c=;
        b=MW19jZkUHuIDuWM0km39QzT/ahTN8HoEYEerz9ffGEHT6gF/O+fdt0/wSsTtfb5BM3
         ONEXK9IPEqMSOTpSdkDOHFV1krZvAc3IE2gKBM36rp8GDDY7Fk6nvTJOfoXQYiKMm6Om
         dz/A34Re3AsdjmB8L+HT3lGlXj48NIUxALxdjGMH2+1d7brUMv/TOdGlNSH7gRasS7Gs
         6xoS14JS7UBR4RpuuDdLVxp5N0HDIS97+6VwUr29ztpM2Qcqvde8C8cvECa2DLDJprSf
         18/+9M0AAxhDourTDZBqqhFNI7MCK02+zSHVHk3DFu7tpmc/zFaXAqVXxKDPG/NJKJdi
         ermw==
X-Gm-Message-State: APjAAAUZlv3H/hJyz2r5edVYbdgI+KTeekCxMNqjhDb36oLHOpjZptVq
        fT1xf1DvZWi4+PFnSzz0LFnw1Q==
X-Google-Smtp-Source: APXvYqw9HLVdBz0DQ2hcd/Ip/301GllfLIkAeYyNAZN6n3XsWQVMJppwRq6T8Ht1aVh0vnULKFnIww==
X-Received: by 2002:a1c:9d86:: with SMTP id g128mr5010783wme.51.1560446826829;
        Thu, 13 Jun 2019 10:27:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:56e1:adff:fed9:caf0? ([2001:b07:6468:f312:56e1:adff:fed9:caf0])
        by smtp.gmail.com with ESMTPSA id t198sm741299wmt.2.2019.06.13.10.27.05
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 10:27:05 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: clean up conditions for asynchronous page fault
 handling
To:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>
References: <1560423812-51166-1-git-send-email-pbonzini@redhat.com>
 <20190613171220.GA24873@flask>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <309cf0b7-f831-51da-7c2c-3333cd4c4036@redhat.com>
Date:   Thu, 13 Jun 2019 19:27:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190613171220.GA24873@flask>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/19 19:12, Radim Krčmář wrote:
> 2019-06-13 13:03+0200, Paolo Bonzini:
>> Even when asynchronous page fault is disabled, KVM does not want to pause
>> the host if a guest triggers a page fault; instead it will put it into
>> an artificial HLT state that allows running other host processes while
>> allowing interrupt delivery into the guest.
>>
>> However, the way this feature is triggered is a bit confusing.
>> First, it is not used for page faults while a nested guest is
>> running: but this is not an issue since the artificial halt
>> is completely invisible to the guest, either L1 or L2.  Second,
>> it is used even if kvm_halt_in_guest() returns true; in this case,
>> the guest probably should not pay the additional latency cost of the
>> artificial halt, and thus we should handle the page fault in a
>> completely synchronous way.
> 
> The same reasoning would apply to kvm_mwait_in_guest(), so I would
> disable APF with it as well.

True, on the other hand it's not a very sensible condition to have
kvm_mwait_in_guest but not kvm_halt_in_guest.

>> By introducing a new function kvm_can_deliver_async_pf, this patch
>> commonizes the code that chooses whether to deliver an async page fault
>> (kvm_arch_async_page_not_present) and the code that chooses whether a
>> page fault should be handled synchronously (kvm_can_do_async_pf).
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> @@ -9775,6 +9775,36 @@ static int apf_get_user(struct kvm_vcpu *vcpu, u32 *val)
>> +bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu)
>> +{
>> +	if (unlikely(!lapic_in_kernel(vcpu) ||
>> +		     kvm_event_needs_reinjection(vcpu) ||
>> +		     vcpu->arch.exception.pending))
>> +		return false;
>> +
>> +	if (kvm_hlt_in_guest(vcpu->kvm) && !kvm_can_deliver_async_pf(vcpu))
>> +		return false;
>> +
>> +	/*
>> +	 * If interrupts are off we cannot even use an artificial
>> +	 * halt state.
> 
> Can't we?  The artificial halt state would be canceled by the host page
> fault handler.

hlt allows interrupts to be injected, which of course is not possible in
an interrupt-off region.  But, the only difference is that halt_poll is
not obeyed for synchronous page fault handling; either way, the vCPU
thread stays in the kernel but it is scheduled out while the page fault
is being handled.  This is only for lapic_in_kernel so hlt does not
leave KVM_RUN.

>> +	 */
>> +	return kvm_x86_ops->interrupt_allowed(vcpu);
>> @@ -9783,19 +9813,26 @@ void kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
>>  	trace_kvm_async_pf_not_present(work->arch.token, work->gva);
>>  	kvm_add_async_pf_gfn(vcpu, work->arch.gfn);
>>  
>> -	if (!(vcpu->arch.apf.msr_val & KVM_ASYNC_PF_ENABLED) ||
>> -	    (vcpu->arch.apf.send_user_only &&
>> -	     kvm_x86_ops->get_cpl(vcpu) == 0))
>> +	if (!kvm_can_deliver_async_pf(vcpu) ||
>> +	    apf_put_user(vcpu, KVM_PV_REASON_PAGE_NOT_PRESENT)) {
>> +		/*
>> +		 * It is not possible to deliver a paravirtualized asynchronous
>> +		 * page fault, but putting the guest in an artificial halt state
>> +		 * can be beneficial nevertheless: if an interrupt arrives, we
>> +		 * can deliver it timely and perhaps the guest will schedule
>> +		 * another process.  When the instruction that triggered a page
>> +		 * fault is retried, hopefully the page will be ready in the host.
>> +		 */
>>  		kvm_make_request(KVM_REQ_APF_HALT, vcpu);
> 
> A return is missing here, to prevent the delivery of PV APF.
> (I'd probably keep the if/else.)

Fixed in v2 (keeping the if/else but swapping the two arms).

Paolo

> Thanks.
> 
>> -	else if (!apf_put_user(vcpu, KVM_PV_REASON_PAGE_NOT_PRESENT)) {
>> -		fault.vector = PF_VECTOR;
>> -		fault.error_code_valid = true;
>> -		fault.error_code = 0;
>> -		fault.nested_page_fault = false;
>> -		fault.address = work->arch.token;
>> -		fault.async_page_fault = true;
>> -		kvm_inject_page_fault(vcpu, &fault);
> 
>>  	}
>> +
>> +	fault.vector = PF_VECTOR;
>> +	fault.error_code_valid = true;
>> +	fault.error_code = 0;
>> +	fault.nested_page_fault = false;
>> +	fault.address = work->arch.token;
>> +	fault.async_page_fault = true;
>> +	kvm_inject_page_fault(vcpu, &fault);
>>  }
>>  
>>  void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
>> -- 
>> 1.8.3.1
>>

