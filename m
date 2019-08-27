Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A729AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B07206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfH0HWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:22:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfH0HWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:22:54 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 216123C93
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 07:22:53 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id b11so671984wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 00:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=pzHviUK3atqXhQXnPVoHHHqmzFOi+zrzBFXLMguzsmQ=;
        b=Mc2i4zQh+MqsdXIcWlVq056KjPEUy/bSzbLMVAW8h0FX5RyJoclZKMPhKPRWEncAWd
         gM/wi9Cb3h+iP9oEmQHna0EIJxHOb63Pjc1rVcqlQ6cnb0tOD6fzg6jHkkwFzM+OahX+
         HlH3KDUAkgRBk/y+psdnQ/uEf1GMaUlhvAEodoaXlXSaWRuvn+8waZkjUW35ZK6WzgRB
         6qGfX/+RGgPBCiNYEuvrYYMEadXJS6FG+/xoOqKPn+rIguMtPl4pFxsiotws5LTQZ4yO
         CuPQyi2wuq65FB2HgXO1i56m/BflYAFtZIBja/feu+v7rR3nQfMiNj8AkNewk92ucQ6h
         R75g==
X-Gm-Message-State: APjAAAV5lBL5wgXQOUnvLrLw4d7PLACuZKMyGK1j/dE0Dh5s501bL18z
        +erAc+yt8w5ePXnTi/LFhhPGGw9WzLWxYQrryzVGu6wzWhvdcFQR1mVN0VM/LYjxcx3A9NJ/yci
        k3lV9Xhpca6qCz1hNYGF5vtxW
X-Received: by 2002:a5d:4b05:: with SMTP id v5mr27160280wrq.208.1566890571861;
        Tue, 27 Aug 2019 00:22:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz815ouJgJL1bqVreLWWsWgyzkebpEQJyMyRKKuLdX2UXpOSf2gDYTBZHr3gTlZ0ShYqwGXGQ==
X-Received: by 2002:a5d:4b05:: with SMTP id v5mr27160234wrq.208.1566890571484;
        Tue, 27 Aug 2019 00:22:51 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-161-20.net.upcbroadband.cz. [89.176.161.20])
        by smtp.gmail.com with ESMTPSA id f7sm18038767wrf.8.2019.08.27.00.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 00:22:51 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Suthikulpanit\, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     "pbonzini\@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar\@redhat.com" <rkrcmar@redhat.com>,
        "joro\@8bytes.org" <joro@8bytes.org>,
        "graf\@amazon.com" <graf@amazon.com>,
        "jschoenh\@amazon.de" <jschoenh@amazon.de>,
        "karahmed\@amazon.de" <karahmed@amazon.de>,
        "rimasluk\@amazon.com" <rimasluk@amazon.com>,
        "Grimm\, Jon" <Jon.Grimm@amd.com>,
        "Suthikulpanit\, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm\@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 05/15] kvm: lapic: Introduce APICv update helper function
In-Reply-To: <1565886293-115836-6-git-send-email-suravee.suthikulpanit@amd.com>
References: <1565886293-115836-1-git-send-email-suravee.suthikulpanit@amd.com> <1565886293-115836-6-git-send-email-suravee.suthikulpanit@amd.com>
Date:   Tue, 27 Aug 2019 09:22:50 +0200
Message-ID: <87a7bvm5rp.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com> writes:

> Re-factor code into a helper function for setting lapic parameters when
> activate/deactivate APICv, and export the function for subsequent usage.
>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  arch/x86/kvm/lapic.c | 22 +++++++++++++++++-----
>  arch/x86/kvm/lapic.h |  1 +
>  2 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 4dabc31..90f79ca 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2153,6 +2153,21 @@ void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u64 value)
>  
>  }
>  
> +void kvm_apic_update_apicv(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_lapic *apic = vcpu->arch.apic;
> +
> +	if (vcpu->arch.apicv_active) {
> +		/* irr_pending is always true when apicv is activated. */
> +		apic->irr_pending = true;
> +		apic->isr_count = 1;
> +	} else {
> +		apic->irr_pending = (apic_search_irr(apic) != -1);
> +		apic->isr_count = count_vectors(apic->regs + APIC_ISR);
> +	}
> +}
> +EXPORT_SYMBOL(kvm_apic_update_apicv);

EXPORT_SYMBOL_GPL please.

> +
>  void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
>  {
>  	struct kvm_lapic *apic = vcpu->arch.apic;
> @@ -2197,8 +2212,7 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
>  		kvm_lapic_set_reg(apic, APIC_ISR + 0x10 * i, 0);
>  		kvm_lapic_set_reg(apic, APIC_TMR + 0x10 * i, 0);
>  	}
> -	apic->irr_pending = vcpu->arch.apicv_active;
> -	apic->isr_count = vcpu->arch.apicv_active ? 1 : 0;
> +	kvm_apic_update_apicv(vcpu);
>  	apic->highest_isr_cache = -1;
>  	update_divide_count(apic);
>  	atomic_set(&apic->lapic_timer.pending, 0);
> @@ -2468,9 +2482,7 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
>  	apic_manage_nmi_watchdog(apic, kvm_lapic_get_reg(apic, APIC_LVT0));
>  	update_divide_count(apic);
>  	start_apic_timer(apic);
> -	apic->irr_pending = true;
> -	apic->isr_count = vcpu->arch.apicv_active ?
> -				1 : count_vectors(apic->regs + APIC_ISR);
> +	kvm_apic_update_apicv(vcpu);
>  	apic->highest_isr_cache = -1;
>  	if (vcpu->arch.apicv_active) {
>  		kvm_x86_ops->apicv_post_state_restore(vcpu);
> diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
> index d6d049b..3892d50 100644
> --- a/arch/x86/kvm/lapic.h
> +++ b/arch/x86/kvm/lapic.h
> @@ -90,6 +90,7 @@ bool kvm_apic_match_dest(struct kvm_vcpu *vcpu, struct kvm_lapic *source,
>  int kvm_apic_set_irq(struct kvm_vcpu *vcpu, struct kvm_lapic_irq *irq,
>  		     struct dest_map *dest_map);
>  int kvm_apic_local_deliver(struct kvm_lapic *apic, int lvt_type);
> +void kvm_apic_update_apicv(struct kvm_vcpu *vcpu);
>  
>  bool kvm_irq_delivery_to_apic_fast(struct kvm *kvm, struct kvm_lapic *src,
>  		struct kvm_lapic_irq *irq, int *r, struct dest_map *dest_map);

-- 
Vitaly
