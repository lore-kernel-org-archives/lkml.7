Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12922C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 14:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA3121736
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 14:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKV95w7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfK2OXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 09:23:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28701 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726808AbfK2OXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 09:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575037421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BjGu5Y9IqwjrSunQ/XOztUtwME2j3+eRCCCFohsV410=;
        b=fKV95w7/7UPka8z3Z94AqsEcG2ErfThraHRzE+fgV0UdmpCmziFME2bqPkHSrDEhrooHFC
        A8QgzzVLufu/frib6Q0NjAttlssFU78kpsE4vCS6NjbwVxvIb9vm8CjphUNHqQzhdiNlPI
        cfIq7lGu5vSBiRDwKvQoI+PJwfxgBwE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-WGPFx22UOli37gEh2klPbw-1; Fri, 29 Nov 2019 09:23:40 -0500
Received: by mail-wr1-f69.google.com with SMTP id b2so14297827wrj.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 06:23:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kaxeE+6S8sCxKLrCWJSud3mrPDlPxV80NahWl909qwo=;
        b=uVy+K5Kw+xqO6rZKAckL39a6abXt4nONOdmRiSWL8lJpK8ZNLN4oU7nS7x7YSywznr
         zwgMJYAXTGCFblJsF2HIuWB3iowsQE82EZPH4hET8x9/R7jROnFe5gbWEEVcUVgOPnqf
         4gyCRi6o4DjjX00ZOcB9xw4nq660OS+byLIm7b1DOrvDkzt7qKLv0c+Sfywi3tp/Q3RA
         isqhqs5HQjyw+fKKWln1xp7CEvmZA4upY2Yu45/FxR6qZjtoWE7k+W624jpFhz92QXc4
         7zNO6ZaLpy73nbemFqL/GQnEgcP85QW0XMLIlWzMpnSUzSIyitmnmD982B/OJqNqci3b
         BB3A==
X-Gm-Message-State: APjAAAVMhj4/s8rZP0H1Bh5BHDPxrbptclYMDUUCalEfsSD0mJgS+ViE
        acg0dQBZ7IgNTxfPm9EljyiHhAmEiWv4j9B0pjpg3xH1K5jI2pTyl77FdCtwB32YBQEhxlC472A
        bugKZ4fecAlE+SZpERY90al5W
X-Received: by 2002:adf:f5c2:: with SMTP id k2mr54051079wrp.118.1575037418920;
        Fri, 29 Nov 2019 06:23:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqyVv1y+4A+y/39GNkVZoElT6z5O0Pek/hv4gLlJdL8U5Xgc64spiRBOkAodEg1rJHQ8THPcgg==
X-Received: by 2002:adf:f5c2:: with SMTP id k2mr54051050wrp.118.1575037418670;
        Fri, 29 Nov 2019 06:23:38 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b17sm3023411wrx.15.2019.11.29.06.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 06:23:37 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>
Subject: Re: [PATCH] KVM: X86: Use APIC_DEST_* macros properly
In-Reply-To: <20191128193211.32684-1-peterx@redhat.com>
References: <20191128193211.32684-1-peterx@redhat.com>
Date:   Fri, 29 Nov 2019 15:23:36 +0100
Message-ID: <87sgm6damv.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: WGPFx22UOli37gEh2klPbw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> Previously we were using either APIC_DEST_PHYSICAL|APIC_DEST_LOGICAL
> or 0|1 to fill in kvm_lapic_irq.dest_mode, and it's done in an adhoc
> way.  It's fine imho only because in most cases when we check against
> dest_mode it's against APIC_DEST_PHYSICAL (which equals to 0).
> However, that's not consistent, majorly because APIC_DEST_LOGICAL does
> not equals to 1, so if one day we check irq.dest_mode against
> APIC_DEST_LOGICAL we'll probably always get a false returned.
>
> This patch replaces the 0/1 settings of irq.dest_mode with the macros
> to make them consistent.
>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Sean Christopherson <sean.j.christopherson@intel.com>
> CC: Vitaly Kuznetsov <vkuznets@redhat.com>
> CC: Nitesh Narayan Lal <nitesh@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/x86/kvm/ioapic.c   | 9 ++++++---
>  arch/x86/kvm/irq_comm.c | 7 ++++---
>  arch/x86/kvm/x86.c      | 2 +-
>  3 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
> index 9fd2dd89a1c5..1e091637d5d5 100644
> --- a/arch/x86/kvm/ioapic.c
> +++ b/arch/x86/kvm/ioapic.c
> @@ -331,7 +331,8 @@ static void ioapic_write_indirect(struct kvm_ioapic *=
ioapic, u32 val)
>  =09=09=09irq.vector =3D e->fields.vector;
>  =09=09=09irq.delivery_mode =3D e->fields.delivery_mode << 8;
>  =09=09=09irq.dest_id =3D e->fields.dest_id;
> -=09=09=09irq.dest_mode =3D e->fields.dest_mode;
> +=09=09=09irq.dest_mode =3D e->fields.dest_mode ?
> +=09=09=09    APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
>  =09=09=09bitmap_zero(&vcpu_bitmap, 16);
>  =09=09=09kvm_bitmap_or_dest_vcpus(ioapic->kvm, &irq,
>  =09=09=09=09=09=09 &vcpu_bitmap);
> @@ -343,7 +344,8 @@ static void ioapic_write_indirect(struct kvm_ioapic *=
ioapic, u32 val)
>  =09=09=09=09 * keep ioapic_handled_vectors synchronized.
>  =09=09=09=09 */
>  =09=09=09=09irq.dest_id =3D old_dest_id;
> -=09=09=09=09irq.dest_mode =3D old_dest_mode;
> +=09=09=09=09irq.dest_mode =3D old_dest_mode ?
> +=09=09=09=09    APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
>  =09=09=09=09kvm_bitmap_or_dest_vcpus(ioapic->kvm, &irq,
>  =09=09=09=09=09=09=09 &vcpu_bitmap);
>  =09=09=09}
> @@ -369,7 +371,8 @@ static int ioapic_service(struct kvm_ioapic *ioapic, =
int irq, bool line_status)
> =20
>  =09irqe.dest_id =3D entry->fields.dest_id;
>  =09irqe.vector =3D entry->fields.vector;
> -=09irqe.dest_mode =3D entry->fields.dest_mode;
> +=09irqe.dest_mode =3D entry->fields.dest_mode ?
> +=09    APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
>  =09irqe.trig_mode =3D entry->fields.trig_mode;
>  =09irqe.delivery_mode =3D entry->fields.delivery_mode << 8;
>  =09irqe.level =3D 1;
> diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
> index 8ecd48d31800..673b6afd6dbf 100644
> --- a/arch/x86/kvm/irq_comm.c
> +++ b/arch/x86/kvm/irq_comm.c
> @@ -52,8 +52,8 @@ int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kv=
m_lapic *src,
>  =09unsigned long dest_vcpu_bitmap[BITS_TO_LONGS(KVM_MAX_VCPUS)];
>  =09unsigned int dest_vcpus =3D 0;
> =20
> -=09if (irq->dest_mode =3D=3D 0 && irq->dest_id =3D=3D 0xff &&
> -=09=09=09kvm_lowest_prio_delivery(irq)) {
> +=09if (irq->dest_mode =3D=3D APIC_DEST_PHYSICAL &&
> +=09    irq->dest_id =3D=3D 0xff && kvm_lowest_prio_delivery(irq)) {
>  =09=09printk(KERN_INFO "kvm: apic: phys broadcast and lowest prio\n");
>  =09=09irq->delivery_mode =3D APIC_DM_FIXED;
>  =09}
> @@ -114,7 +114,8 @@ void kvm_set_msi_irq(struct kvm *kvm, struct kvm_kern=
el_irq_routing_entry *e,
>  =09=09irq->dest_id |=3D MSI_ADDR_EXT_DEST_ID(e->msi.address_hi);
>  =09irq->vector =3D (e->msi.data &
>  =09=09=09MSI_DATA_VECTOR_MASK) >> MSI_DATA_VECTOR_SHIFT;
> -=09irq->dest_mode =3D (1 << MSI_ADDR_DEST_MODE_SHIFT) & e->msi.address_l=
o;
> +=09irq->dest_mode =3D (1 << MSI_ADDR_DEST_MODE_SHIFT) & e->msi.address_l=
o ?
> +=09    APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
>  =09irq->trig_mode =3D (1 << MSI_DATA_TRIGGER_SHIFT) & e->msi.data;
>  =09irq->delivery_mode =3D e->msi.data & 0x700;
>  =09irq->msi_redir_hint =3D ((e->msi.address_lo
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 3ed167e039e5..3b00d662dc14 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7356,7 +7356,7 @@ static void kvm_pv_kick_cpu_op(struct kvm *kvm, uns=
igned long flags, int apicid)
>  =09struct kvm_lapic_irq lapic_irq;
> =20
>  =09lapic_irq.shorthand =3D 0;
> -=09lapic_irq.dest_mode =3D 0;
> +=09lapic_irq.dest_mode =3D APIC_DEST_PHYSICAL;
>  =09lapic_irq.level =3D 0;
>  =09lapic_irq.dest_id =3D apicid;
>  =09lapic_irq.msi_redir_hint =3D false;

dest_mode is being passed to kvm_apic_match_dest() where we do:

=09case APIC_DEST_NOSHORT:
=09=09if (dest_mode =3D=3D APIC_DEST_PHYSICAL)
=09=09=09return kvm_apic_match_physical_addr(target, mda);
=09=09else
=09=09=09return kvm_apic_match_logical_addr(target, mda);

I'd suggest we fix this too then (and BUG() in case it's neither).

--=20
Vitaly

