Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04240C2D0C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6472464B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vtnt2/7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfLLJnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 04:43:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30887 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728512AbfLLJnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576143830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8WYueCqZllh/g3kIvXk2fqY+m/Wf+jDC76k8N31CSUs=;
        b=Vtnt2/7EipLZumGR0KtT4zwhP4F0NYq0184L6xE8cZy15ywLjkXjPlR7UYlAVCllqyNzax
        985OjywVyjJlbrW/LtrlFGLcNvDFaw1buemUjihLqBk/BzGqNkx4TAXvikRaIxiOtol2KL
        6mSglYGebYqBw+xso2gyakJJ0LFG01k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-22Qk8rvcP--Z5uhhkuEbYA-1; Thu, 12 Dec 2019 04:43:49 -0500
X-MC-Unique: 22Qk8rvcP--Z5uhhkuEbYA-1
Received: by mail-wr1-f72.google.com with SMTP id k18so815040wrw.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 01:43:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=8WYueCqZllh/g3kIvXk2fqY+m/Wf+jDC76k8N31CSUs=;
        b=B+mftk0W7jLFQKCnzoSMPXxU+H7b+J72XPI/uOIPPQr2HAy+DJOVs9NYj4yHdRsolz
         4mnxadwQj/JvzHAh8qcGTuqKBgOrSdj2lbYWZqF4WQTvzdRSsEV6+hkcfrk7+8fvXeEd
         BvsTsNSH2Lgs7CgwKC0UDjSPFmPlPAn2pZqxU6SvT77+QXYVHaaMf+ruRvRquMmwPQ5q
         W0KdYk0KjB+BiJebTCorzSPGurbqY3OtH9hAMBrNq4aeJZ4/PX+87YJAVBJbgtY+5JEF
         ZP/FNfNol9XuKBHFO3amUc2B+r0hAM3ec/xndkXuztuQM8mSczzVokdMBe47XWSMyAyg
         Bp5g==
X-Gm-Message-State: APjAAAUkqkGTbjxl46m2SfG8dsv1+Vr5FnNmTnPXXh1qu2EmWp8r+T+W
        5WVZ6bDBqgZYh8jjzYsIz51ZNw6pdSvMSBXG1fBUS+tARgvfFbrG/8I3EGQrrJXvF4RueD2C81z
        3AJjac0zgcpNFIdyFDyoIeUiK
X-Received: by 2002:a1c:96c4:: with SMTP id y187mr5588716wmd.112.1576143827953;
        Thu, 12 Dec 2019 01:43:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqw08Vc/KqRo1P4kmQTeLxX+2WddiEmM7nSrw2R/9MgOOiC1YM2hfPCQ2hrrNXWGVLE5ckSEWg==
X-Received: by 2002:a1c:96c4:: with SMTP id y187mr5588680wmd.112.1576143827696;
        Thu, 12 Dec 2019 01:43:47 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5sm5529138wrh.5.2019.12.12.01.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 01:43:47 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Marios Pomonis <pomonis@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Finco <nifi@google.com>, Andrew Honig <ahonig@google.com>,
        Marios Pomonis <pomonis@google.com>, stable@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 02/13] KVM: x86: Protect kvm_hv_msr_[get|set]_crash_data() from Spectre-v1/L1TF attacks
In-Reply-To: <20191211204753.242298-3-pomonis@google.com>
References: <20191211204753.242298-1-pomonis@google.com> <20191211204753.242298-3-pomonis@google.com>
Date:   Thu, 12 Dec 2019 10:43:47 +0100
Message-ID: <87eex9c20c.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marios Pomonis <pomonis@google.com> writes:

> This fixes Spectre-v1/L1TF vulnerabilities in kvm_hv_msr_get_crash_data()
> and kvm_hv_msr_set_crash_data().
> These functions contain index computations that use the
> (attacker-controlled) MSR number.

Just to educate myself,

in both cases 'index' is equal to 'msr - HV_X64_MSR_CRASH_P0' where
'msr' is constrained:
  case HV_X64_MSR_CRASH_P0 ... HV_X64_MSR_CRASH_P4:
         ....

and moreover, kvm_hv_{get,set}_msr_common() is only being called for a
narrow set of MSRs. How can an atacker overcome these limitations?

>
> Fixes: commit e7d9513b60e8 ("kvm/x86: added hyper-v crash msrs into kvm hyperv context")
>
> Signed-off-by: Nick Finco <nifi@google.com>
> Signed-off-by: Marios Pomonis <pomonis@google.com>
> Reviewed-by: Andrew Honig <ahonig@google.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/kvm/hyperv.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 23ff65504d7e..26408434b9bc 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -809,11 +809,12 @@ static int kvm_hv_msr_get_crash_data(struct kvm_vcpu *vcpu,
>  				     u32 index, u64 *pdata)
>  {
>  	struct kvm_hv *hv = &vcpu->kvm->arch.hyperv;
> +	size_t size = ARRAY_SIZE(hv->hv_crash_param);
>  
> -	if (WARN_ON_ONCE(index >= ARRAY_SIZE(hv->hv_crash_param)))
> +	if (WARN_ON_ONCE(index >= size))
>  		return -EINVAL;
>  
> -	*pdata = hv->hv_crash_param[index];
> +	*pdata = hv->hv_crash_param[array_index_nospec(index, size)];
>  	return 0;
>  }
>  
> @@ -852,11 +853,12 @@ static int kvm_hv_msr_set_crash_data(struct kvm_vcpu *vcpu,
>  				     u32 index, u64 data)
>  {
>  	struct kvm_hv *hv = &vcpu->kvm->arch.hyperv;
> +	size_t size = ARRAY_SIZE(hv->hv_crash_param);
>  
> -	if (WARN_ON_ONCE(index >= ARRAY_SIZE(hv->hv_crash_param)))
> +	if (WARN_ON_ONCE(index >= size))
>  		return -EINVAL;
>  
> -	hv->hv_crash_param[index] = data;
> +	hv->hv_crash_param[array_index_nospec(index, size)] = data;
>  	return 0;
>  }

-- 
Vitaly

