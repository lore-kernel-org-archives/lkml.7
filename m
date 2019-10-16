Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5801AFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371162067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393743AbfJPRHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 13:07:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44850 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388161AbfJPRHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 13:07:00 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 345B788313
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 17:07:00 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id g67so1233483wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 10:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gs7j7P97MguiwVXLFd4gwkovHtcAde4RLohzpgnXT0M=;
        b=BMr0FShOnwe1mN1IYVDgVOpD2RgspUr/O0JVXNCIwuE7flP5WwHyx9tNvLUNRQ5EAq
         IOx3EalrmZ+Sph8nyoJsxp/keqSJ7Ok/ZIf1p2YMSmXrq9X7ccprkNxzfSgbCPpgP8fC
         yw2frzJgqcB72bYEBVZpxatuCEXrRdBUzsgFd4vwu5dx1OEXy7Eod9Ec9Gk/ieQfP+lT
         BJV7RFu7Qxvh9HOdsGDJBKFYNqOmynJunQxdNiDou4o2BBaJ8CbFaXxPlFvmKPblBbdG
         dzQ863r2LYHs+Xz60G/jTCQAqWc5Sr5vNst8Frhe2IhTqrwjuKuFFeEyVmE/3m0bMoW4
         YW6w==
X-Gm-Message-State: APjAAAVMYDbPXLi5NyPLLLl9u7prIkY5ry2G+bCa6zQQkYDKXVWKkfOJ
        rNzGPJmmx3aOxcoti8LL0uc3vZaI8YpZvXZNboTMrzx7nvkq8pIu+HliG3DHNO6xGqTWmTp4cAk
        C7br4Ma5ZcJkkzgVx7o4+Yc/D
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr4584935wma.44.1571245618930;
        Wed, 16 Oct 2019 10:06:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyTOPCffn6fos0yiy5ZNrUHWqJEU8VeKDXOXKziUzRHJm9s4opmF4QO5ABHTLAraHwRok8b9A==
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr4584913wma.44.1571245618706;
        Wed, 16 Oct 2019 10:06:58 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e18sm35106204wrv.63.2019.10.16.10.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 10:06:58 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     suleiman@google.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] kvm: clear kvmclock MSR on reset
In-Reply-To: <1570704617-32285-1-git-send-email-pbonzini@redhat.com>
References: <1570704617-32285-1-git-send-email-pbonzini@redhat.com>
Date:   Wed, 16 Oct 2019 19:06:57 +0200
Message-ID: <87wod439hq.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> After resetting the vCPU, the kvmclock MSR keeps the previous value but it is
> not enabled.  This can be confusing, so fix it.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index f26f8be4e621..a55252c69118 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2533,6 +2533,7 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
>  static void kvmclock_reset(struct kvm_vcpu *vcpu)
>  {
>  	vcpu->arch.pv_time_enabled = false;
> +	vcpu->arch.time = 0;
>  }
>  
>  static void kvm_vcpu_flush_tlb(struct kvm_vcpu *vcpu, bool invalidate_gpa)
> @@ -2698,8 +2699,6 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_KVM_SYSTEM_TIME: {
>  		struct kvm_arch *ka = &vcpu->kvm->arch;
>  
> -		kvmclock_reset(vcpu);
> -
>  		if (vcpu->vcpu_id == 0 && !msr_info->host_initiated) {
>  			bool tmp = (msr == MSR_KVM_SYSTEM_TIME);
>  
> @@ -2713,14 +2712,13 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
>  
>  		/* we verify if the enable bit is set... */
> +		vcpu->arch.pv_time_enabled = false;
>  		if (!(data & 1))
>  			break;
>  
>  		if (kvm_gfn_to_hva_cache_init(vcpu->kvm,
>  		     &vcpu->arch.pv_time, data & ~1ULL,
>  		     sizeof(struct pvclock_vcpu_time_info)))
> -			vcpu->arch.pv_time_enabled = false;
> -		else
>  			vcpu->arch.pv_time_enabled = true;

Hm, are you sure you didn't want to write !kvm_gfn_to_hva_cache_init()?

>  
>  		break;

-- 
Vitaly
