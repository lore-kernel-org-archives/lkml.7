Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71FAC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D2921721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbfJHMMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:12:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731105AbfJHMLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:11:24 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0069244BD1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2019 12:11:24 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id n3so1296978wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 05:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XC+l+JGNpdezIfgQgjgQjgcBhVIbmx5T2yywcc/3dIc=;
        b=qIXljDXW85qD9CPClz+PItVYDpgRkJyoNfZQ/aUKp9gcY51o0D/QDEGou8ZX0dvEj8
         7ocBZZeuDRGeymvdyqXQeIAyJ89ANJnQNNEFdmIrummoWwfyzbKKHw6gtbQZUgEP8iWI
         OdkrDu/ARH4viTqc6U+JcPtZrARdznq7iimSxMy8k13qpPPpsvvO0nYike4StKlYOpc7
         uy5e+m2TzBu0aLDQ6NMua3ejzMhKBgRURDv/dpnRIP4D47gUGrxHBnLdusNkF7jM61bM
         KFXjwNg/+/SMfA2X3iA1FItaSdSegv8XcK4TGM5DuSK+qzCnJekjMQMkSbDMdelhR7VR
         qcJw==
X-Gm-Message-State: APjAAAWbbTXK28+qZ4vh4VxTiWRE7rs/KOWue2ejTZT3lUcwH8tssKg+
        wduGoUTPQI4gn5VvKmaSnGJbD8LSx+KYKEvCTjYL9CUzfUZSmfFBYtn59tIQkBhMXJuDMt+2Asm
        GTEChjQi4vM5g38V6F1TZ4hiq
X-Received: by 2002:a05:6000:45:: with SMTP id k5mr24156923wrx.259.1570536682666;
        Tue, 08 Oct 2019 05:11:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxVOLNmOG55qRmpeZcOk9E693639E92Lk3u+fEJ6vxxVUor4lqnEMXs6hNuOIi96Wl4hyTPMw==
X-Received: by 2002:a05:6000:45:: with SMTP id k5mr24156902wrx.259.1570536682402;
        Tue, 08 Oct 2019 05:11:22 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id t83sm5002990wmt.18.2019.10.08.05.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 05:11:21 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: Don't shrink/grow vCPU halt_poll_ns if host side
 polling is disabled
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
References: <1569719216-32080-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a0f940ba-7bc9-8695-c233-0d82858fb91d@redhat.com>
Date:   Tue, 8 Oct 2019 14:11:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1569719216-32080-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/19 03:06, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Don't waste cycles to shrink/grow vCPU halt_poll_ns if host 
> side polling is disabled.
> 
> Acked-by: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v1 -> v2: 
>  * fix coding style
> 
>  virt/kvm/kvm_main.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index e6de315..9d5eed9 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2359,20 +2359,23 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>  	kvm_arch_vcpu_unblocking(vcpu);
>  	block_ns = ktime_to_ns(cur) - ktime_to_ns(start);
>  
> -	if (!vcpu_valid_wakeup(vcpu))
> -		shrink_halt_poll_ns(vcpu);
> -	else if (halt_poll_ns) {
> -		if (block_ns <= vcpu->halt_poll_ns)
> -			;
> -		/* we had a long block, shrink polling */
> -		else if (vcpu->halt_poll_ns && block_ns > halt_poll_ns)
> +	if (!kvm_arch_no_poll(vcpu)) {
> +		if (!vcpu_valid_wakeup(vcpu)) {
>  			shrink_halt_poll_ns(vcpu);
> -		/* we had a short halt and our poll time is too small */
> -		else if (vcpu->halt_poll_ns < halt_poll_ns &&
> -			block_ns < halt_poll_ns)
> -			grow_halt_poll_ns(vcpu);
> -	} else
> -		vcpu->halt_poll_ns = 0;
> +		} else if (halt_poll_ns) {
> +			if (block_ns <= vcpu->halt_poll_ns)
> +				;
> +			/* we had a long block, shrink polling */
> +			else if (vcpu->halt_poll_ns && block_ns > halt_poll_ns)
> +				shrink_halt_poll_ns(vcpu);
> +			/* we had a short halt and our poll time is too small */
> +			else if (vcpu->halt_poll_ns < halt_poll_ns &&
> +				block_ns < halt_poll_ns)
> +				grow_halt_poll_ns(vcpu);
> +		} else {
> +			vcpu->halt_poll_ns = 0;
> +		}
> +	}
>  
>  	trace_kvm_vcpu_wakeup(block_ns, waited, vcpu_valid_wakeup(vcpu));
>  	kvm_arch_vcpu_block_finish(vcpu);
> 

Queued, thanks.

Paolo
