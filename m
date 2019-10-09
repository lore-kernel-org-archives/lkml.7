Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5C8ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B19206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbfJIU7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 16:59:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732074AbfJIU7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 16:59:14 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D4AE51F0C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 20:59:14 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id v17so1646297wru.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 13:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mQUedDk5IixQtgNfS/LbVr5OQ+GLG6+7GAPgfU7Balo=;
        b=PE7REVi48/5wZGzR2N1CyLDz6/34sgPK6ZSgn3oEOhW7O/UU3gZvNrHnnIRwy7QJdB
         sYGDsUnGUHNeXOtFgyevG7cxyccdTTYHsRTfGMMd4I7eia0QsJd+iuW3ivQI2WIlPBzO
         fRZTTEQRUlUsK9wrsI3lye2A2elRYpog2qY9PCL2kt1NrJyk2GXzTnekIEy36wdp8cZL
         rZcrW+3r2YLThMd4iQSuvseeGWRpi1SdTVZpUDbWsZS8B56Mbo/gh46LIetSkVWHlMBt
         u/fLKsQ+E2hLx8R60VdPcL9K7K2bOk1ykPXJu8ir0842CaiXIRaNf+uVeck/W0Vm9UNr
         XS/A==
X-Gm-Message-State: APjAAAUfY7AEz96ZalRGWy5w/42dvJrfeS/Dj9Rk4PZwarNpr4RpqZHI
        pTMt0cKndGVuvWY484+YTx8/hqZUT+/V9V7sJigYyQjWFofTwt9KqfQ0ITcbjfq+vyjrzkUjbw1
        acHz4PtFWur+65ghWP/kJS1w7
X-Received: by 2002:adf:814d:: with SMTP id 71mr4751157wrm.193.1570654752767;
        Wed, 09 Oct 2019 13:59:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwFpbepWq2DgiU7FbUtX4DjIcH80wAx7fxPJyEtr3o5Gr/tTJ/GeqM1ydfUzo9JztLIaY4Lpg==
X-Received: by 2002:adf:814d:: with SMTP id 71mr4751141wrm.193.1570654752460;
        Wed, 09 Oct 2019 13:59:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1032:7ea1:7f8f:1e5? ([2001:b07:6468:f312:1032:7ea1:7f8f:1e5])
        by smtp.gmail.com with ESMTPSA id g11sm3881984wmh.45.2019.10.09.13.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 13:59:11 -0700 (PDT)
Subject: Re: [PATCH v2 4/8] KVM: VMX: Optimize vmx_set_rflags() for
 unrestricted guest
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reto Buerki <reet@codelabs.ch>,
        Liran Alon <liran.alon@oracle.com>
References: <20190927214523.3376-1-sean.j.christopherson@intel.com>
 <20190927214523.3376-5-sean.j.christopherson@intel.com>
 <99e57095-d855-99d7-e10e-a415c6ef13b2@redhat.com>
 <20191009163835.GB19952@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aee0fe86-6a5a-680a-4147-3b68fc3718c9@redhat.com>
Date:   Wed, 9 Oct 2019 22:59:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009163835.GB19952@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/19 18:38, Sean Christopherson wrote:
> On Wed, Oct 09, 2019 at 12:40:53PM +0200, Paolo Bonzini wrote:
>> On 27/09/19 23:45, Sean Christopherson wrote:
>>> Rework vmx_set_rflags() to avoid the extra code need to handle emulation
>>> of real mode and invalid state when unrestricted guest is disabled.  The
>>> primary reason for doing so is to avoid the call to vmx_get_rflags(),
>>> which will incur a VMREAD when RFLAGS is not already available.  When
>>> running nested VMs, the majority of calls to vmx_set_rflags() will occur
>>> without an associated vmx_get_rflags(), i.e. when stuffing GUEST_RFLAGS
>>> during transitions between vmcs01 and vmcs02.
>>>
>>> Note, vmx_get_rflags() guarantees RFLAGS is marked available.
>>
>> Slightly nicer this way:
>>
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index 8de9853d7ab6..62ab19d65efd 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -1431,9 +1431,17 @@ unsigned long vmx_get_rflags(struct kvm_vcpu *vcpu)
>>  void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
>>  {
>>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>> -	unsigned long old_rflags = vmx_get_rflags(vcpu);
>> +	unsigned long old_rflags;
>> +
>> +	if (enable_unrestricted_guest) {
>> +		__set_bit(VCPU_EXREG_RFLAGS, (ulong *)&vcpu->arch.regs_avail);
>> +		vmx->rflags = rflags;
>> +		vmcs_writel(GUEST_RFLAGS, rflags);
>> +		return;
>> +	}
>> +
>> +	old_rflags = vmx_get_rflags(vcpu);
>>  
>> -	__set_bit(VCPU_EXREG_RFLAGS, (ulong *)&vcpu->arch.regs_avail);
>>  	vmx->rflags = rflags;
>>  	if (vmx->rmode.vm86_active) {
>>  		vmx->rmode.save_rflags = rflags;
> 
> Works for me.  Do you want me to spin a v3 to incorporate this and remove
> the open coding of the RIP/RSP accessors?  Or are you planning on squashing
> the changes as you apply?

If it's okay for you I can squash it.

Paolo

