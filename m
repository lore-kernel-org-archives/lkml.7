Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE10ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFFD214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732859AbfJVQsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:48:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732072AbfJVQsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:48:02 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 428B485537
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 16:48:01 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id 4so5281198wrf.19
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 09:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6IUllQdC1JcBo53l0feki9O911eimyikofYh28oSUZI=;
        b=gV1X2VMfUs24p7BsFb3OoeeCQDi8ZNcQh9R/o6sOF87NEooIRfv861s4t9tkqTh39+
         1uXI84LjqEyvv4ZTl2nbpyHMG6rLTvf0aaxE72AO6/eVxbYYZjEDK//I1LDIAEbzniKz
         WOMs+iiba9IQ69t+amBQvVNbUW7F4njGwPtflPrzwFaX+3jlFpWBxXd1JbbvXaMQ8isT
         1q4TrH9E7igMA6eyRpPoEQQxrRGNK7AkNbtojznXU2gXDF7uLP1xaoT0KGtsZ+9ETDhy
         A6xOrYpKrBH1C4rV+MYltJpubA24RQfrGdbEDSWIhA9fVb3GgG5kIGLy7AvqxVRwWbYE
         zJ3w==
X-Gm-Message-State: APjAAAUboxbYscTdhZBWMuIx6hyewLUH52Y/FuBeUs9IsTK8bRITVNNn
        bvtK04ik6O3+YQqbD/iMyqILwwnoWZnb3nKeCToUQGTRHDUcI1SYgZMLZWPkIWKj00xZJypHXvG
        3SFzWgLR/vI1Sey/XUBn3ATPI
X-Received: by 2002:adf:f58b:: with SMTP id f11mr4198175wro.85.1571762879787;
        Tue, 22 Oct 2019 09:47:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw5g3AibMbcuSwNUHwkkYHksej37syxRcre3u394uyNZoNjuqSAg5WvCAysQIXg0CChJznj0Q==
X-Received: by 2002:adf:f58b:: with SMTP id f11mr4198151wro.85.1571762879474;
        Tue, 22 Oct 2019 09:47:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c0e4:dcf4:b543:ce19? ([2001:b07:6468:f312:c0e4:dcf4:b543:ce19])
        by smtp.gmail.com with ESMTPSA id f143sm34080587wme.40.2019.10.22.09.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2019 09:47:58 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: SVM: Fix potential wrong physical id in
 avic_handle_ldr_update
To:     Miaohe Lin <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingfangsen@huawei.com
References: <1571367031-6844-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <696ae8db-fe41-4710-483c-0f30a06bdd32@redhat.com>
Date:   Tue, 22 Oct 2019 18:47:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1571367031-6844-1-git-send-email-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/19 04:50, Miaohe Lin wrote:
> Guest physical APIC ID may not equal to vcpu->vcpu_id in some case.
> We may set the wrong physical id in avic_handle_ldr_update as we
> always use vcpu->vcpu_id. Get physical APIC ID from vAPIC page
> instead.
> Export and use kvm_xapic_id here and in avic_handle_apic_id_update
> as suggested by Vitaly.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/lapic.c | 5 -----
>  arch/x86/kvm/lapic.h | 5 +++++
>  arch/x86/kvm/svm.c   | 6 +++---
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 87b0fcc23ef8..b29d00b661ff 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -111,11 +111,6 @@ static inline int apic_enabled(struct kvm_lapic *apic)
>  	(LVT_MASK | APIC_MODE_MASK | APIC_INPUT_POLARITY | \
>  	 APIC_LVT_REMOTE_IRR | APIC_LVT_LEVEL_TRIGGER)
>  
> -static inline u8 kvm_xapic_id(struct kvm_lapic *apic)
> -{
> -	return kvm_lapic_get_reg(apic, APIC_ID) >> 24;
> -}
> -
>  static inline u32 kvm_x2apic_id(struct kvm_lapic *apic)
>  {
>  	return apic->vcpu->vcpu_id;
> diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
> index 2aad7e226fc0..1f5014852e20 100644
> --- a/arch/x86/kvm/lapic.h
> +++ b/arch/x86/kvm/lapic.h
> @@ -242,4 +242,9 @@ static inline enum lapic_mode kvm_apic_mode(u64 apic_base)
>  	return apic_base & (MSR_IA32_APICBASE_ENABLE | X2APIC_ENABLE);
>  }
>  
> +static inline u8 kvm_xapic_id(struct kvm_lapic *apic)
> +{
> +	return kvm_lapic_get_reg(apic, APIC_ID) >> 24;
> +}
> +
>  #endif
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index f8ecb6df5106..ca200b50cde4 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -4591,6 +4591,7 @@ static int avic_handle_ldr_update(struct kvm_vcpu *vcpu)
>  	int ret = 0;
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  	u32 ldr = kvm_lapic_get_reg(vcpu->arch.apic, APIC_LDR);
> +	u32 id = kvm_xapic_id(vcpu->arch.apic);
>  
>  	if (ldr == svm->ldr_reg)
>  		return 0;
> @@ -4598,7 +4599,7 @@ static int avic_handle_ldr_update(struct kvm_vcpu *vcpu)
>  	avic_invalidate_logical_id_entry(vcpu);
>  
>  	if (ldr)
> -		ret = avic_ldr_write(vcpu, vcpu->vcpu_id, ldr);
> +		ret = avic_ldr_write(vcpu, id, ldr);
>  
>  	if (!ret)
>  		svm->ldr_reg = ldr;
> @@ -4610,8 +4611,7 @@ static int avic_handle_apic_id_update(struct kvm_vcpu *vcpu)
>  {
>  	u64 *old, *new;
>  	struct vcpu_svm *svm = to_svm(vcpu);
> -	u32 apic_id_reg = kvm_lapic_get_reg(vcpu->arch.apic, APIC_ID);
> -	u32 id = (apic_id_reg >> 24) & 0xff;
> +	u32 id = kvm_xapic_id(vcpu->arch.apic);
>  
>  	if (vcpu->vcpu_id == id)
>  		return 0;
> 

Queued, thanks.

Paolo
