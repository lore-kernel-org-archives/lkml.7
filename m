Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED06CC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7192070B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieLYqrPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLBJ17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 04:27:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45901 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726350AbfLBJ17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 04:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575278877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QaCZCXd2HgeicnibG2e0/DBhCQFuCGC7oBz0idwJvWA=;
        b=ieLYqrPpfmSSv7k5UWQ8qOG64bVSBwoXceI+wS7BgIoLFqbZ7kWTWZHNgqb/6oIh9dPrWv
        TIUohZ1yLTIvrY+Y3drNoDP0bk9qfTOaj9KGdVqb/fDRNTtwWEQyAb7andfGLEIKe2bx9R
        5M60ZS9cH1hTHlqMQDr6tPxX1ZK8rwM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-A-DGO3kLM-yoSWn6a65Ztw-1; Mon, 02 Dec 2019 04:27:54 -0500
Received: by mail-wm1-f71.google.com with SMTP id g78so1954622wme.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 01:27:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=vgHH2a1OT0NMgZksryaJf2xpAssyppt0wYhnBpLFJQ4=;
        b=c/LVQ6Vj5dG5CDZWhMse2c8nNENnHvrnnYyx1Bh7alZnGTCEHWtE5hfrmuQg0kr4T9
         LVRUdPCZXb9rRbmqyx+N4ADyPh4bkDg4PRCc9nf5w8+jismF117XxP11IU7dbiWLZ1oc
         IqB3a9viUauaeIndsx7GqU2gSlLNJgH6lgzW6SVeIBWsOPvHEL6r9VCEvcm6gjOwLL3S
         oX9RfaMsRNY79XvPCXLUKjxXU2lYV8T1iHECoa89vN42dZ6ypCy2a0DxjntUyTiJbALG
         PdhSnKFGFYuWqbOjPs312BWEPx5W2zp/oA0fJiTmXpMzRLS6ypgPvtA113jZ1kwfwTGb
         65nw==
X-Gm-Message-State: APjAAAUW05isrHbGxiPY3oWL2pvG1olmPlMH0HEWiVXduzFu9VcXyQzs
        Haasx8biBziCtGUUsdMhQZ4Gcke+1dZQMho/eGsBN6HUEYpuviUYp7bHxDXdVbf6LQnxFSdOEpn
        oLlB1nxCUmePHuOgh9CMNZKbm
X-Received: by 2002:a5d:4749:: with SMTP id o9mr20167479wrs.242.1575278873545;
        Mon, 02 Dec 2019 01:27:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqyLdwtzLUtjqSAyp2lCwjwT9ld8h7mox2t+QqoPx46JxPjRuxzf3FAKdqulvZj0qJanZG3+7g==
X-Received: by 2002:a5d:4749:: with SMTP id o9mr20167459wrs.242.1575278873316;
        Mon, 02 Dec 2019 01:27:53 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id r6sm26080924wrv.40.2019.12.02.01.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 01:27:52 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com
Subject: Re: [PATCH v2 1/3] KVM: X86: Some cleanups in ioapic.h/lapic.h
In-Reply-To: <20191129163234.18902-2-peterx@redhat.com>
References: <20191129163234.18902-1-peterx@redhat.com> <20191129163234.18902-2-peterx@redhat.com>
Date:   Mon, 02 Dec 2019 10:27:51 +0100
Message-ID: <87k17fcc14.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: A-DGO3kLM-yoSWn6a65Ztw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> Both kvm_apic_match_dest() and kvm_irq_delivery_to_apic() should
> probably suite more to lapic.h comparing to ioapic.h, moving.
>
> kvm_apic_match_dest() is defined twice, once in each of the header.
> Removing the one defined in ioapic.h.
>

kvm_apic_match_dest()'s implementation lives in lapic.c so moving the
declaration to lapic.h makes perfect sense. kvm_irq_delivery_to_apic()'s
body is, however, in irq_comm.c and declarations for it are usually
found in asm/kvm_host.h. I'm not sure but maybe it would make sense to
move kvm_irq_delivery_to_apic()'s body to lapic.c too.

(Personally, I'd also greatly appreciate if functions working with lapic
exclusively would have 'lapic' instead of 'apic' in their names. But
this is unrelated to the patch.)

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/x86/kvm/ioapic.h | 6 ------
>  arch/x86/kvm/lapic.h  | 5 ++++-
>  2 files changed, 4 insertions(+), 7 deletions(-)
>
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
> diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
> index 39925afdfcdc..19b36196e2ff 100644
> --- a/arch/x86/kvm/lapic.h
> +++ b/arch/x86/kvm/lapic.h
> @@ -83,7 +83,10 @@ int kvm_lapic_reg_read(struct kvm_lapic *apic, u32 off=
set, int len,
>  =09=09       void *data);
>  bool kvm_apic_match_dest(struct kvm_vcpu *vcpu, struct kvm_lapic *source=
,
>  =09=09=09   int short_hand, unsigned int dest, int dest_mode);
> -
> +int kvm_apic_compare_prio(struct kvm_vcpu *vcpu1, struct kvm_vcpu *vcpu2=
);
> +int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
> +=09=09=09     struct kvm_lapic_irq *irq,
> +=09=09=09     struct dest_map *dest_map);
>  bool __kvm_apic_update_irr(u32 *pir, void *regs, int *max_irr);
>  bool kvm_apic_update_irr(struct kvm_vcpu *vcpu, u32 *pir, int *max_irr);
>  void kvm_apic_update_ppr(struct kvm_vcpu *vcpu);

--=20
Vitaly

