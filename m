Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9EAC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B94206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfH0HPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:15:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfH0HPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:15:22 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 14D252A09D8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 07:15:22 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id t9so10990882wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 00:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ItBFnvOskiXPWW/tXExRRVa7JatdCAplFcozPV+0gNM=;
        b=pArIYyjFTlasBP/7xU6w3qqkd2ZbzINaw0Z+NnQWaTmdBOomDgTSb92EWmvegZo9/4
         yiigaFHdZZE+VpKouWL+nJ0Avm66iX9gnmEkjBGXzo/UOGObZgirAjGtewHSFeAiIr+R
         YlSEBUGc6NeC94apyCyLdXNaNkUci2z9XAzKaUY63r67JIfuU7xEteppIdk2wM+gRuhH
         n2tVLcQ7DL7Rdqc8M2yqZVZdrRrpfL+Jy7Q9z8L8teP+aJd2C9VjRArc+l8xuZ3nrg8G
         nUB/D6jywctYOfhXbhr0CRFzYwQmSfuq4sTA30t+yrIBNG2B4US0Uytp3b2tiEgWM6iq
         haSg==
X-Gm-Message-State: APjAAAVsjSPOybeg28DS2n/nFAwZ8T1yb72Jelc5VMYYSzwVF+YAIBZU
        XXjSHOWk5sGnEYM4p7OQ2Pefw2Dhjw+PEf4rq3u/u3UsLr11UdMQrcFTUg+5krkNjon8SVPueg9
        PDj3wAlkNvwFaxYGsH2PeYL8T
X-Received: by 2002:a1c:200a:: with SMTP id g10mr24606058wmg.160.1566890120716;
        Tue, 27 Aug 2019 00:15:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyawJTYbThIhs4NIo/tFME/qKqKlPHsP0+de4dcTQWRABs/Kb5yLEx6SvcczfmV6yic/7VhIg==
X-Received: by 2002:a1c:200a:: with SMTP id g10mr24606018wmg.160.1566890120434;
        Tue, 27 Aug 2019 00:15:20 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-161-20.net.upcbroadband.cz. [89.176.161.20])
        by smtp.gmail.com with ESMTPSA id a203sm1958111wme.11.2019.08.27.00.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 00:15:19 -0700 (PDT)
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
Subject: Re: [PATCH v2 01/15] kvm: x86: Modify kvm_x86_ops.get_enable_apicv() to use struct kvm parameter
In-Reply-To: <1565886293-115836-2-git-send-email-suravee.suthikulpanit@amd.com>
References: <1565886293-115836-1-git-send-email-suravee.suthikulpanit@amd.com> <1565886293-115836-2-git-send-email-suravee.suthikulpanit@amd.com>
Date:   Tue, 27 Aug 2019 09:15:18 +0200
Message-ID: <87d0grm649.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com> writes:

> Generally, APICv for all vcpus in the VM are enable/disable in the same
> manner. So, get_enable_apicv() should represent APICv status of the VM
> instead of each VCPU.
>
> Modify kvm_x86_ops.get_enable_apicv() to take struct kvm as parameter
> instead of struct kvm_vcpu.
>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 2 +-
>  arch/x86/kvm/svm.c              | 5 +++--
>  arch/x86/kvm/vmx/vmx.c          | 2 +-
>  arch/x86/kvm/x86.c              | 2 +-
>  4 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 26d1eb8..56bc702 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1077,7 +1077,7 @@ struct kvm_x86_ops {
>  	void (*enable_nmi_window)(struct kvm_vcpu *vcpu);
>  	void (*enable_irq_window)(struct kvm_vcpu *vcpu);
>  	void (*update_cr8_intercept)(struct kvm_vcpu *vcpu, int tpr, int irr);
> -	bool (*get_enable_apicv)(struct kvm_vcpu *vcpu);
> +	bool (*get_enable_apicv)(struct kvm *kvm);
>  	void (*refresh_apicv_exec_ctrl)(struct kvm_vcpu *vcpu);
>  	void (*hwapic_irr_update)(struct kvm_vcpu *vcpu, int max_irr);
>  	void (*hwapic_isr_update)(struct kvm_vcpu *vcpu, int isr);
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index ccd5aa6..6851bce 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -384,6 +384,7 @@ struct amd_svm_iommu_ir {
>  static void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
>  static void svm_flush_tlb(struct kvm_vcpu *vcpu, bool invalidate_gpa);
>  static void svm_complete_interrupts(struct vcpu_svm *svm);
> +static bool svm_get_enable_apicv(struct kvm *kvm);

Why is this forward declaration needed [in this patch]?

>  
>  static int nested_svm_exit_handled(struct vcpu_svm *svm);
>  static int nested_svm_intercept(struct vcpu_svm *svm);
> @@ -5124,9 +5125,9 @@ static void svm_set_virtual_apic_mode(struct kvm_vcpu *vcpu)
>  	return;
>  }
>  
> -static bool svm_get_enable_apicv(struct kvm_vcpu *vcpu)
> +static bool svm_get_enable_apicv(struct kvm *kvm)
>  {
> -	return avic && irqchip_split(vcpu->kvm);
> +	return avic && irqchip_split(kvm);
>  }
>  
>  static void svm_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr)
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index d98eac3..18a4b94 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -3610,7 +3610,7 @@ void pt_update_intercept_for_msr(struct vcpu_vmx *vmx)
>  	}
>  }
>  
> -static bool vmx_get_enable_apicv(struct kvm_vcpu *vcpu)
> +static bool vmx_get_enable_apicv(struct kvm *kvm)
>  {
>  	return enable_apicv;
>  }
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index fafd81d..7daf0dd 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9150,7 +9150,7 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
>  		goto fail_free_pio_data;
>  
>  	if (irqchip_in_kernel(vcpu->kvm)) {
> -		vcpu->arch.apicv_active = kvm_x86_ops->get_enable_apicv(vcpu);
> +		vcpu->arch.apicv_active = kvm_x86_ops->get_enable_apicv(vcpu->kvm);
>  		r = kvm_create_lapic(vcpu, lapic_timer_advance_ns);
>  		if (r < 0)
>  			goto fail_mmu_destroy;

With the above question answered (or declaration moved to the patch
where it's actually needed)

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly
