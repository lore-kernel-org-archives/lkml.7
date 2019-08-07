Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7398C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BB021922
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387534AbfHGLRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 07:17:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55115 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbfHGLRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 07:17:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so81388670wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 04:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=XOg+QHIo96GAzDA0CD3aVidRwvkjCkQ5NKE8IAqCCgI=;
        b=juhmuiCtgJqpxtHPz44tLsKPmZYPojkhXzbFsuhDvSIc4shHnRAVvX109AYqZbB5j8
         IzSwc6Fg/NIS0venrqoeYvCZWaohwPSK9RIu9icedMUOJtRb1p0OCwG3GE9H2ctYUsD2
         B/GEXFnicP1uBf9YRIzuevdRO1lXPNABKXX39zUiBvsQISf5vYaVYGvDRxANdqqjyw4C
         8xJpOElNDqRxD1pqpT5dpjmC1duu8Sl7hC7FwakQGWTamRIzq+n3/7o1eGu71F7swiia
         nL6ZNBuSu5QOZemuBV6qYiL6AhizY1P/nUSj4hjpR51Fz9/zR5biEil8TE9L+hKgXsZh
         biyQ==
X-Gm-Message-State: APjAAAVRebjDvsBwtP8qSd2a91vo1Hpx3feJWfzg9YsOZw4d0xH/twfS
        v/LFhgAp2DdrhXz9UBDKBMSO/A==
X-Google-Smtp-Source: APXvYqxsoLykxcat2Ef7ObrQdb4zx24l0amhPhyKmBxACCVunXkLBsZ2cHced6gaEKmdUh3wtWpxVw==
X-Received: by 2002:a1c:c542:: with SMTP id v63mr9999539wmf.97.1565176630200;
        Wed, 07 Aug 2019 04:17:10 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id l8sm177977630wrg.40.2019.08.07.04.17.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 04:17:09 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH v2 2/5] x86: KVM: svm: avoid flooding logs when skip_emulated_instruction() fails
In-Reply-To: <20190806154033.GD27766@linux.intel.com>
References: <20190806060150.32360-1-vkuznets@redhat.com> <20190806060150.32360-3-vkuznets@redhat.com> <20190806154033.GD27766@linux.intel.com>
Date:   Wed, 07 Aug 2019 13:17:08 +0200
Message-ID: <87blx1dy2z.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Tue, Aug 06, 2019 at 08:01:47AM +0200, Vitaly Kuznetsov wrote:
>> When we're unable to skip instruction with kvm_emulate_instruction() we
>> will not advance RIP and most likely the guest will get stuck as
>> consequitive attempts to execute the same instruction will likely result
>> in the same behavior.
>> 
>> As we're not supposed to see these messages under normal conditions, switch
>> to pr_err_once().
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Reviewed-by: Jim Mattson <jmattson@google.com>
>> ---
>>  arch/x86/kvm/svm.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
>> index 7e843b340490..80f576e05112 100644
>> --- a/arch/x86/kvm/svm.c
>> +++ b/arch/x86/kvm/svm.c
>> @@ -782,7 +782,8 @@ static void skip_emulated_instruction(struct kvm_vcpu *vcpu)
>>  	if (!svm->next_rip) {
>>  		if (kvm_emulate_instruction(vcpu, EMULTYPE_SKIP) !=
>>  				EMULATE_DONE)
>> -			printk(KERN_DEBUG "%s: NOP\n", __func__);
>> +			pr_err_once("KVM: %s: unable to skip instruction\n",
>> +				    __func__);
>
> IMO the proper fix would be to change skip_emulated_instruction() to
> return an int so that emulation failure can be reported back up the stack.
> It's a relatively minor change as there are a limited number of call sites
> to skip_emulated_instruction() in SVM and VMX.
>

(I'm always wondering when is the right time to add "plus a bunch of
miscellaneous fixes all over" to the PATCH0's Subject line :-)

Will do in the next version, thanks!

>>  		return;
>>  	}
>>  	if (svm->next_rip - kvm_rip_read(vcpu) > MAX_INST_SIZE)
>> -- 
>> 2.20.1
>> 

-- 
Vitaly
