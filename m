Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB77C010A3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD04217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388445AbfKEKWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:22:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388224AbfKEKWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:22:49 -0500
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4324B1C13C5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2019 10:22:48 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id c2so5455465wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 02:22:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YBVh0Q0FQpGu1wxG4fQf09T3nf67n77DWG5mfPvNWJI=;
        b=C2gpXzwg9s6mNHsO1QZa3npuF+/ycz8trpgvx4j2lsvTwIBgyN5JIIVrz660CcVCCt
         C3X0KeyDYi3RrhkMLDgwOf3wyKa/qNRdMyuIeIyo6/8sY/iwy/OJzKSRaU2ODnOhxJfj
         89PePdgy/VWtC4ch4n+M/7+KawhNPOSxmNwBaBJ63KV44tIjKV05nuZaHyruhKFLCcjK
         GfHV74vdnPMYT/B7rKD/FME4TrwkfMDjmv3NnRwcJ1SIE6O0QAWDm8/x7Gs4QWD7xvjf
         U2z9w3GBADeDa7d0XSnlzv8BZvw7d0BhIMXYh1vyadHY+VxWertHLuj2g1/Li/BcMljo
         5qKQ==
X-Gm-Message-State: APjAAAUelnOm+1+d6E/0sEzWSk2LBBn5HPHA220/qPvFmDf6zgHLEL4v
        ioPPEQ+StOckJzzE5YaHU4otDQeMvQ6UZfpflAqNRmBGM0Y7Rxb72K+J9I4JYT4ihLEJqA9Uiqx
        6t1b9UsJNWL1+Pdl3td3f6mfC
X-Received: by 2002:adf:f44e:: with SMTP id f14mr26168415wrp.56.1572949366905;
        Tue, 05 Nov 2019 02:22:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqy9SYxmOaejXMxfGfmZ/5V1utDQAFfW554v2shot8/5xTWsThuesqZvWtP731Z0rsryf0sqmA==
X-Received: by 2002:adf:f44e:: with SMTP id f14mr26168388wrp.56.1572949366567;
        Tue, 05 Nov 2019 02:22:46 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id w17sm20505631wra.34.2019.11.05.02.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 02:22:46 -0800 (PST)
Subject: Re: [PATCH 10/13] KVM: x86: optimize more exit handlers in vmx.c
To:     Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20191104230001.27774-1-aarcange@redhat.com>
 <20191104230001.27774-11-aarcange@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5f512823-531b-6c17-f8f4-f11870e2e4a2@redhat.com>
Date:   Tue, 5 Nov 2019 11:20:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191104230001.27774-11-aarcange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/19 23:59, Andrea Arcangeli wrote:
> Eliminate wasteful call/ret non RETPOLINE case and unnecessary fentry
> dynamic tracing hooking points.
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 30 +++++-------------------------
>  1 file changed, 5 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 222467b2040e..a6afa5f4a01c 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4694,7 +4694,7 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
>  	return 0;
>  }
>  
> -static int handle_external_interrupt(struct kvm_vcpu *vcpu)
> +static __always_inline int handle_external_interrupt(struct kvm_vcpu *vcpu)
>  {
>  	++vcpu->stat.irq_exits;
>  	return 1;
> @@ -4965,21 +4965,6 @@ void kvm_x86_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
>  	vmcs_writel(GUEST_DR7, val);
>  }
>  
> -static int handle_cpuid(struct kvm_vcpu *vcpu)
> -{
> -	return kvm_emulate_cpuid(vcpu);
> -}
> -
> -static int handle_rdmsr(struct kvm_vcpu *vcpu)
> -{
> -	return kvm_emulate_rdmsr(vcpu);
> -}
> -
> -static int handle_wrmsr(struct kvm_vcpu *vcpu)
> -{
> -	return kvm_emulate_wrmsr(vcpu);
> -}
> -
>  static int handle_tpr_below_threshold(struct kvm_vcpu *vcpu)
>  {
>  	kvm_apic_update_ppr(vcpu);
> @@ -4996,11 +4981,6 @@ static int handle_interrupt_window(struct kvm_vcpu *vcpu)
>  	return 1;
>  }
>  
> -static int handle_halt(struct kvm_vcpu *vcpu)
> -{
> -	return kvm_emulate_halt(vcpu);
> -}
> -
>  static int handle_vmcall(struct kvm_vcpu *vcpu)
>  {
>  	return kvm_emulate_hypercall(vcpu);
> @@ -5548,11 +5528,11 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu) = {
>  	[EXIT_REASON_IO_INSTRUCTION]          = handle_io,
>  	[EXIT_REASON_CR_ACCESS]               = handle_cr,
>  	[EXIT_REASON_DR_ACCESS]               = handle_dr,
> -	[EXIT_REASON_CPUID]                   = handle_cpuid,
> -	[EXIT_REASON_MSR_READ]                = handle_rdmsr,
> -	[EXIT_REASON_MSR_WRITE]               = handle_wrmsr,
> +	[EXIT_REASON_CPUID]                   = kvm_emulate_cpuid,
> +	[EXIT_REASON_MSR_READ]                = kvm_emulate_rdmsr,
> +	[EXIT_REASON_MSR_WRITE]               = kvm_emulate_wrmsr,
>  	[EXIT_REASON_PENDING_INTERRUPT]       = handle_interrupt_window,
> -	[EXIT_REASON_HLT]                     = handle_halt,
> +	[EXIT_REASON_HLT]                     = kvm_emulate_halt,
>  	[EXIT_REASON_INVD]		      = handle_invd,
>  	[EXIT_REASON_INVLPG]		      = handle_invlpg,
>  	[EXIT_REASON_RDPMC]                   = handle_rdpmc,
> 

Queued, thanks.

Paolo
