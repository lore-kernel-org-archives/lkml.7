Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1DCC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51DF20661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlUXLFyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfLCJgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:36:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23007 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbfLCJgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575365806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G7W/BEttJw33HncNG+QW+oMA8U8SyQxme1y4KXgd/4w=;
        b=XlUXLFyfYJq8tfcghw0aIEM/oeb9Q8SMasiHGFHurUwStLn1QrJb4xZW/peEXIgc6LuSIB
        kfvHQi01dxKxKpcjMM8LH5n+sDsRJpGT2zE9HFEbPS7bSANbKzxmWy+NlARLmVmV/eZdGy
        k9RcXcc4W2z4kcNk2C4reIIFR6BSQ2U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-x-yGgPLhNHef__G4rP0G8w-1; Tue, 03 Dec 2019 04:36:45 -0500
Received: by mail-wr1-f71.google.com with SMTP id z14so1488243wrs.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 01:36:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PYrn284OnyQbwOX3aztUCmwgxQvrGOQTIkrwcm0f+tU=;
        b=sXWtX5vHAYjGEDElzWWAxrCSzTZ4u/YhEkw0/4vT709SAkg6Z2eT56OdnCdgfIKzyg
         DYIQBhQpU+XJI4xigVJX83bDVR+vFFpNjgLm3rukRfQIpMutO+/S6UNU8yLq7CeWEa3H
         H1ugkrhqWrMDEeulEkFDZaxGfGK00SDdYVMxG+6Scii9rpR+dfryhA95d8L+rw1FuDj4
         4m6LAQPOnuj6GSK4dGEeFIQZe1ILrTbmQ0eCUbZL0k/LPMSQk0Cmo/CjPT9bABxDXsnw
         13okBjbhF8/4r9QpP3Quhz9twexIpSQgf9OK8Uif8b5DT22JT/yz6oa3zNFo/C350Ebn
         WaZw==
X-Gm-Message-State: APjAAAVKG3XvkUfUvJBHiTG/C85v407abA5KCorSGrAhFAqQlIdwxDhs
        LuPdLZQXpulMQhPuLrlJ7i0Q7yOrI8Uq0HtvqJYrTey3acxueh7nXNt7mRh2T+Tm0RDaZQFvaz8
        d9XnQKMPa2QVcyf8pqLXGbQam
X-Received: by 2002:adf:fc0c:: with SMTP id i12mr4327212wrr.74.1575365804430;
        Tue, 03 Dec 2019 01:36:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqzPFWXKDRpoZf/KCKfb5i8PwcpIMWn5vZ9LAaSrgN4RGhU6QMmDMyKz6URhOnw9kJ41TEjIhQ==
X-Received: by 2002:adf:fc0c:: with SMTP id i12mr4327192wrr.74.1575365804191;
        Tue, 03 Dec 2019 01:36:44 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c136sm2517681wme.23.2019.12.03.01.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 01:36:43 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com
Subject: Re: [PATCH v3 2/5] KVM: X86: Move irrelevant declarations out of ioapic.h
In-Reply-To: <20191202201314.543-3-peterx@redhat.com>
References: <20191202201314.543-1-peterx@redhat.com> <20191202201314.543-3-peterx@redhat.com>
Date:   Tue, 03 Dec 2019 10:36:42 +0100
Message-ID: <8736e1da39.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: x-yGgPLhNHef__G4rP0G8w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> kvm_apic_match_dest() is declared in both ioapic.h and lapic.h.
> Removing the declaration in ioapic.h.
>
> kvm_apic_compare_prio() is declared in ioapic.h but defined in
> lapic.c.  Moving the declaration to lapic.h.
>
> kvm_irq_delivery_to_apic() is declared in ioapic.h but defined in
> irq_comm.c.  Moving the declaration to irq.h.

Nitpicking: 'imperative mode' requested by Sean would be "remove the
declaration", "move the declaration",...

>
> While at it, include irq.h in hyperv.c because it needs to use
> kvm_irq_delivery_to_apic().

"While at it" is being used when you are trying to squeeze in a (small)
unrelated change (fix a typo, rename a variable,...) but here it's not
the case: including irq.h to hyperv.c is mandatory (to not break the
build).

"Include irq.h in hyperv.c to support the change" would do (but honestly
I don't see much value in the statement so I'd rather omit in in the
changelog).

>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/x86/kvm/hyperv.c | 1 +
>  arch/x86/kvm/ioapic.h | 6 ------
>  arch/x86/kvm/irq.h    | 3 +++
>  arch/x86/kvm/lapic.h  | 2 +-
>  4 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 23ff65504d7e..c7d4640b7b1c 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -33,6 +33,7 @@
>  #include <trace/events/kvm.h>
> =20
>  #include "trace.h"
> +#include "irq.h"
> =20
>  #define KVM_HV_MAX_SPARSE_VCPU_SET_BITS DIV_ROUND_UP(KVM_MAX_VCPUS, 64)
> =20
> diff --git a/arch/x86/kvm/ioapic.h b/arch/x86/kvm/ioapic.h
> index ea1a4e0297da..2fb2e3c80724 100644
> --- a/arch/x86/kvm/ioapic.h
> +++ b/arch/x86/kvm/ioapic.h
> @@ -116,9 +116,6 @@ static inline int ioapic_in_kernel(struct kvm *kvm)
>  }
> =20
>  void kvm_rtc_eoi_tracking_restore_one(struct kvm_vcpu *vcpu);
> -bool kvm_apic_match_dest(struct kvm_vcpu *vcpu, struct kvm_lapic *source=
,
> -=09=09int short_hand, unsigned int dest, int dest_mode);
> -int kvm_apic_compare_prio(struct kvm_vcpu *vcpu1, struct kvm_vcpu *vcpu2=
);
>  void kvm_ioapic_update_eoi(struct kvm_vcpu *vcpu, int vector,
>  =09=09=09int trigger_mode);
>  int kvm_ioapic_init(struct kvm *kvm);
> @@ -126,9 +123,6 @@ void kvm_ioapic_destroy(struct kvm *kvm);
>  int kvm_ioapic_set_irq(struct kvm_ioapic *ioapic, int irq, int irq_sourc=
e_id,
>  =09=09       int level, bool line_status);
>  void kvm_ioapic_clear_all(struct kvm_ioapic *ioapic, int irq_source_id);
> -int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
> -=09=09=09     struct kvm_lapic_irq *irq,
> -=09=09=09     struct dest_map *dest_map);
>  void kvm_get_ioapic(struct kvm *kvm, struct kvm_ioapic_state *state);
>  void kvm_set_ioapic(struct kvm *kvm, struct kvm_ioapic_state *state);
>  void kvm_ioapic_scan_entry(struct kvm_vcpu *vcpu,
> diff --git a/arch/x86/kvm/irq.h b/arch/x86/kvm/irq.h
> index 7c6233d37c64..f173ab6b407e 100644
> --- a/arch/x86/kvm/irq.h
> +++ b/arch/x86/kvm/irq.h
> @@ -113,5 +113,8 @@ int apic_has_pending_timer(struct kvm_vcpu *vcpu);
> =20
>  int kvm_setup_default_irq_routing(struct kvm *kvm);
>  int kvm_setup_empty_irq_routing(struct kvm *kvm);
> +int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
> +=09=09=09     struct kvm_lapic_irq *irq,
> +=09=09=09     struct dest_map *dest_map);
> =20
>  #endif
> diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
> index 39925afdfcdc..0b9bbadd1f3c 100644
> --- a/arch/x86/kvm/lapic.h
> +++ b/arch/x86/kvm/lapic.h
> @@ -83,7 +83,7 @@ int kvm_lapic_reg_read(struct kvm_lapic *apic, u32 offs=
et, int len,
>  =09=09       void *data);
>  bool kvm_apic_match_dest(struct kvm_vcpu *vcpu, struct kvm_lapic *source=
,
>  =09=09=09   int short_hand, unsigned int dest, int dest_mode);
> -
> +int kvm_apic_compare_prio(struct kvm_vcpu *vcpu1, struct kvm_vcpu *vcpu2=
);
>  bool __kvm_apic_update_irr(u32 *pir, void *regs, int *max_irr);
>  bool kvm_apic_update_irr(struct kvm_vcpu *vcpu, u32 *pir, int *max_irr);
>  void kvm_apic_update_ppr(struct kvm_vcpu *vcpu);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

--=20
Vitaly

