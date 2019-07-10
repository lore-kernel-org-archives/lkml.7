Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D522DC74A2D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3EE620651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfGJOga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:36:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34376 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJOga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:36:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so2759875wrm.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 07:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jU1Lfk6OjWPt1W0Knkmr5mFgCh06/6H5avDsE2z0wQ8=;
        b=rLHwDkJuoFbwbEVAmDX2Zwh530gl+wf+0FgxuokfmR9B6GUTm25++qmFIbN4v/sTEo
         F1B80G56hdetKuhrhL6bHEJXHC/SZyjCa7vej82E3G9Mgl4TlCE231rN14eQCRkUorJ8
         ncrl0AQrCwmQ4biQC3eke7Hbp8Xl5J+2TS+WY22xeLkB1QrEWNBuvHn+FZ2YO90dMQI3
         lKIQKA+61VzHtcZS3nOl55pioN/rkFwEAYJPp0LqZh7XRlKXPpKT+b2NBIs+vf5gbKPG
         Q4Bb2mFBsbAnSiYKo91f0haukvXGxFo15Ob65/IQ7m1yEgiGvMK5dHhDkeUXWa1m4BLJ
         TZHg==
X-Gm-Message-State: APjAAAXJLdmPNuD5g0OtWQCptfLgTqph/um6hxDXiS6b6X0geMjrW9Z1
        Ke352YP2eQym/0DZzs3sjk9rlQ==
X-Google-Smtp-Source: APXvYqzQhyug9OgaM+b/ELg1LsI1mmSl1B6S4pe76D4zNtbEoUok90dLBWoYlbFq5Oq1Pc4htcSVPg==
X-Received: by 2002:adf:80e6:: with SMTP id 93mr4732532wrl.298.1562769388205;
        Wed, 10 Jul 2019 07:36:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab? ([2001:b07:6468:f312:d066:6881:ec69:75ab])
        by smtp.gmail.com with ESMTPSA id d10sm2943088wro.18.2019.07.10.07.36.27
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 07:36:27 -0700 (PDT)
Subject: Re: [PATCH v2] kvm: x86: Fix -Wmissing-prototypes warnings
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        sean.j.christopherson@intel.com, up2wing@gmail.com,
        wang.liang82@zte.com.cn
References: <1562718243-46068-1-git-send-email-wang.yi59@zte.com.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <26226194-e123-dd92-4b70-4d93390752d4@redhat.com>
Date:   Wed, 10 Jul 2019 16:36:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562718243-46068-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/19 02:24, Yi Wang wrote:
> We get a warning when build kernel W=1:
> 
> arch/x86/kvm/../../../virt/kvm/eventfd.c:48:1: warning: no previous prototype for ‘kvm_arch_irqfd_allowed’ [-Wmissing-prototypes]
>  kvm_arch_irqfd_allowed(struct kvm *kvm, struct kvm_irqfd *args)
>  ^
> 
> The reason is kvm_arch_irqfd_allowed() is declared in arch/x86/kvm/irq.h,
> which is not included by eventfd.c. Considering kvm_arch_irqfd_allowed()
> is a weakly defined function in eventfd.c, remove the declaration to
> kvm_host.h can fix this.
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
> v2: add comments about the reason.
> ---
>  arch/x86/kvm/irq.h       | 1 -
>  include/linux/kvm_host.h | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/irq.h b/arch/x86/kvm/irq.h
> index d6519a3..7c6233d 100644
> --- a/arch/x86/kvm/irq.h
> +++ b/arch/x86/kvm/irq.h
> @@ -102,7 +102,6 @@ static inline int irqchip_in_kernel(struct kvm *kvm)
>  	return mode != KVM_IRQCHIP_NONE;
>  }
>  
> -bool kvm_arch_irqfd_allowed(struct kvm *kvm, struct kvm_irqfd *args);
>  void kvm_inject_pending_timer_irqs(struct kvm_vcpu *vcpu);
>  void kvm_inject_apic_timer_irqs(struct kvm_vcpu *vcpu);
>  void kvm_apic_nmi_wd_deliver(struct kvm_vcpu *vcpu);
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index d1ad38a..5f04005 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -990,6 +990,7 @@ void kvm_unregister_irq_ack_notifier(struct kvm *kvm,
>  				   struct kvm_irq_ack_notifier *kian);
>  int kvm_request_irq_source_id(struct kvm *kvm);
>  void kvm_free_irq_source_id(struct kvm *kvm, int irq_source_id);
> +bool kvm_arch_irqfd_allowed(struct kvm *kvm, struct kvm_irqfd *args);
>  
>  /*
>   * search_memslots() and __gfn_to_memslot() are here because they are
> 

Queued, thanks.

Paolo
