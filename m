Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A556C010A3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B41C206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388765AbfKEKhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:37:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388297AbfKEKhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:37:50 -0500
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C6F73DD47
        for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2019 10:37:50 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id e25so12142102wra.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 02:37:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5cw8GDJPXQLnatGSID8Q9w4LNZL4p4hbxD6vnBr55xg=;
        b=ju3qpR2vAx8lRT8grQzNs6qnzDmD2qDUCtoSyHEQ/2UUDPSh2uYHfpmlr3wg4UbdII
         uBeNex6TqXtXOyVFNzp4HnG0IgilsS6li5koKvAUX4G9HfvoaLN54R0kveCCh5LJ70TV
         20xv9VY/4+8akmOY+wXObnkdm1mcL9ZItJvLguTmWDo1jwpeEn3vBgPl3N8Hgfi9Jz5U
         uvqR7p9Yrk1snQZzV5HDCDE/V5BnWjYC0rYedJQJlPyYIlYe7DpF/LMBk0ndxGOrGVmb
         WXj+z4UED9G6OoIls2vt2N2DL+8eUPGfdPWg85li/iUmDPGZwo14hyabNJpq2VzHwthv
         g8/Q==
X-Gm-Message-State: APjAAAUo4PARajz2wmH58ZwIy67fxWRu+tDHZQf61x5XodgtQprnfe8m
        S9M1Dcw3fzrmHojBS2ddgpheq/x6LYHXcKFztVcOvafX+u0nOhONV1bSBcGKvft2UXBnmKGConP
        mTcvZQYd0UxN7luw1OcPDXcIr
X-Received: by 2002:a7b:c94f:: with SMTP id i15mr3748236wml.31.1572950268971;
        Tue, 05 Nov 2019 02:37:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqxF5epxLQok+brbRRt0k9QSuXdiKu5CG4toGSZdQQ703//pOdWltPeXeEv9m1cS09wsZvQ7Zg==
X-Received: by 2002:a7b:c94f:: with SMTP id i15mr3748207wml.31.1572950268637;
        Tue, 05 Nov 2019 02:37:48 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id g8sm7670330wmk.23.2019.11.05.02.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 02:37:48 -0800 (PST)
Subject: Re: [PATCH 03/13] kvm: monolithic: fixup x86-32 build
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20191104230001.27774-1-aarcange@redhat.com>
 <20191104230001.27774-4-aarcange@redhat.com>
 <6ed4a5cd-38b1-04f8-e3d5-3327a1bd5d87@redhat.com>
Message-ID: <678358c1-0621-3d2a-186e-b60742b2a286@redhat.com>
Date:   Tue, 5 Nov 2019 11:37:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6ed4a5cd-38b1-04f8-e3d5-3327a1bd5d87@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/19 11:04, Paolo Bonzini wrote:
> On 04/11/19 23:59, Andrea Arcangeli wrote:
>> kvm_x86_set_hv_timer and kvm_x86_cancel_hv_timer needs to be defined
>> to succeed the 32bit kernel build, but they can't be called.
>>
>> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
>> ---
>>  arch/x86/kvm/vmx/vmx.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index bd17ad61f7e3..1a58ae38c8f2 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -7195,6 +7195,17 @@ void kvm_x86_cancel_hv_timer(struct kvm_vcpu *vcpu)
>>  {
>>  	to_vmx(vcpu)->hv_deadline_tsc = -1;
>>  }
>> +#else
>> +int kvm_x86_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
>> +			 bool *expired)
>> +{
>> +	BUG();
>> +}
>> +
>> +void kvm_x86_cancel_hv_timer(struct kvm_vcpu *vcpu)
>> +{
>> +	BUG();
>> +}
>>  #endif
>>  
>>  void kvm_x86_sched_in(struct kvm_vcpu *vcpu, int cpu)
>>
> 
> I'll check for how long this has been broken.  It may be the proof that
> we can actually drop 32-bit KVM support.

Ah no, I was confused because this series is not bisectable (in addition
to doing two things at a same time, namely the monolithic kvm.ko and the
retpoline eliminations).

I have picked up the patches that are independent of the monolithic
kvm.ko work or can be considered bugfixes.

For the rest, please do this before posting again:

- ensure that everything is bisectable

- look into how to remove the modpost warnings.  A simple (though
somewhat ugly) way is to keep a kvm.ko module that includes common
virt/kvm/ code as well as, for x86 only, page_track.o.  A few functions,
such as kvm_mmu_gfn_disallow_lpage and kvm_mmu_gfn_allow_lpage, would
have to be moved into mmu.h, but that's not a big deal.

- provide at least some examples of replacing the NULL kvm_x86_ops
checks with error codes in the function (or just early "return"s).  I
can help with the others, but remember that for the patch to be merged,
kvm_x86_ops must be removed completely.

Thanks,

Paolo
