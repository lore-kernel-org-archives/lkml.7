Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719D2C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5087A206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbfFTMYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 08:24:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52023 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730886AbfFTMYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 08:24:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so2896630wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 05:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5dPUDytz4IHsrt4HYIoJmhPV1jOibNAisfb09TzZWs4=;
        b=svMbOW8zhq89ITB+PqY+yIks+vGvezHTxtw2dTJwcLXRvqfCbKA8FrV+PPeuKi+CQk
         iKNuvgtAh1g1KC++s0Ns5S1fQ4cBKTw55OLKh16lJID1SBC2elbTvspov9dcmoZSnPvh
         /xIW9YQ79pnOUqypP9frHfRzUgUE/CC5dRzpnbq/WTj97sDfkzd/uaMaNh+e1WwnnYqj
         sbsJtJVyr6OHnuRJeNwR+6AwG8qT1VtTm4DIFLjMAoMrYMUVII/ZAsNEckQAgykiTSth
         8PVq8nVHFbyuwpQiXYd2mAWjzzni8hXQL0eDrrVFu9wl3Iqu959mr/K8xFnbhgOYtStk
         jBww==
X-Gm-Message-State: APjAAAUOsMqGLOZ6ruPEzogpgPrfPc5o5s+8rij+ecjChsv0i1ccVMZe
        6EQnRQYx+F9F05qtV90GGJLnqg==
X-Google-Smtp-Source: APXvYqzgimEo6ibd0AM8NET58DzmkKCmc3/Py9BLmVylkWd+XkkzG+fMIDsvillt2rA6F8tNYPvqFw==
X-Received: by 2002:a1c:b6d4:: with SMTP id g203mr2730214wmf.19.1561033474676;
        Thu, 20 Jun 2019 05:24:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7822:aa18:a9d8:39ab? ([2001:b07:6468:f312:7822:aa18:a9d8:39ab])
        by smtp.gmail.com with ESMTPSA id f2sm29685141wrq.48.2019.06.20.05.24.33
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 05:24:34 -0700 (PDT)
Subject: Re: [PATCH] KVM: VMX: Raise #GP when guest read/write forbidden
 IA32_XSS
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        stable@vger.kernel.org
References: <1561021202-13789-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ed08acd-6427-cb34-65b8-6d850eee1683@redhat.com>
Date:   Thu, 20 Jun 2019 14:24:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1561021202-13789-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/19 11:00, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Raise #GP when guest read/write forbidden IA32_XSS.  
> 
> Fixes: 203000993de5 (kvm: vmx: add MSR logic for XSAVES) 
> Reported-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
> Reported-by: Tao Xu <tao3.xu@intel.com>
> Cc: Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>

Queued, thanks.

Paolo

> ---
>  arch/x86/kvm/vmx/vmx.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index b939a68..d174b62 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1732,7 +1732,10 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		return vmx_get_vmx_msr(&vmx->nested.msrs, msr_info->index,
>  				       &msr_info->data);
>  	case MSR_IA32_XSS:
> -		if (!vmx_xsaves_supported())
> +		if (!vmx_xsaves_supported() ||
> +			(!msr_info->host_initiated &&
> +			!(guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
> +			guest_cpuid_has(vcpu, X86_FEATURE_XSAVES))))
>  			return 1;
>  		msr_info->data = vcpu->arch.ia32_xss;
>  		break;
> @@ -1962,7 +1965,10 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  			return 1;
>  		return vmx_set_vmx_msr(vcpu, msr_index, data);
>  	case MSR_IA32_XSS:
> -		if (!vmx_xsaves_supported())
> +		if (!vmx_xsaves_supported() ||
> +			(!msr_info->host_initiated &&
> +			!(guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
> +			guest_cpuid_has(vcpu, X86_FEATURE_XSAVES))))
>  			return 1;
>  		/*
>  		 * The only supported bit as of Skylake is bit 8, but
> -- 2.7.4
> 

