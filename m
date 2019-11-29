Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3575C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 16:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BCF215A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 16:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkVSqFMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfK2QRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 11:17:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45463 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726926AbfK2QRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 11:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575044257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nC165XAf8z00FQicFMdRB+X/C3ivNyex6DQHQvlQ96g=;
        b=YkVSqFMs0LKFEXrHQeM+lMJAcJ5XA/4dycudI3984ExRHETSLP1htK1WRndWuu855eB46d
        1rd1zUj8gZ23hA4HhdV9qD5JjvELXk+Zt6nxg28xBEny4SH7rPqXyS6ndSd02+3tYJZf4J
        xlMYshu6QLELZP38/lO39hUavHG1yMs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-Ouu_ULEANAqAu0kxjPn-9A-1; Fri, 29 Nov 2019 11:17:34 -0500
Received: by mail-qv1-f70.google.com with SMTP id g6so2168654qvp.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 08:17:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dpdSr67eMWMTe1/gd1Elve1qWOHBB45CAiQGfKTczRs=;
        b=h7Ard8WQaHCTzxHHKgoo5/Zu5EMsVXUi6GLnlSa40JtnyMeF3d7eCSruhz8gyzFdnB
         xtYyPmjbWhq+AE4lXRudUCmkW5lbQWCYIwGXKKV6MTY5GZMpUY8oHn6/bNfvdI9X6J7+
         6vNqcJxis92JpN9PVeADQSoQzcGKQEhShXIAKuatQF/i2gTznydE/ROBerpSXfrQCINx
         aeeXpgjRnobN54HdwHL/rTZBgUC+6P7Lo2gYgm/tGLDRsaV7OUesAnSN4+U5tOSizQu+
         Lgqmi5cOXnf5Bzp9jriGVqvoeGHnsqjtSETsdINRaIZANLfPd7dMtB8TSWiMT9zKRJLw
         OBZg==
X-Gm-Message-State: APjAAAU4dlUXqrOFVK+ynpqFMHDC/+x23jv9lcrGLa1Ivo09iZW6X6L+
        VplY3jnnjS4/GYHfBa0D9JTgJxLFxAfElfDHPw7Zrp5hktefRPWU+3luZ5Oyaj/lbSVkzWHZkic
        tSrF7jnL+FwACq3aSYBr09ByF
X-Received: by 2002:a37:644:: with SMTP id 65mr207925qkg.309.1575044254124;
        Fri, 29 Nov 2019 08:17:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqxDehW4hUYvXxXhA6Tkbmu/WkHPLEM1tjU0+eNrpPeUNpji9CurY+4OO6JTb02J5LdbVaJVTA==
X-Received: by 2002:a37:644:: with SMTP id 65mr207883qkg.309.1575044253788;
        Fri, 29 Nov 2019 08:17:33 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id l17sm10222892qkl.21.2019.11.29.08.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 08:17:32 -0800 (PST)
Date:   Fri, 29 Nov 2019 11:17:31 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>
Subject: Re: [PATCH] KVM: X86: Use APIC_DEST_* macros properly
Message-ID: <20191129161731.GB9292@xz-x1>
References: <20191128193211.32684-1-peterx@redhat.com>
 <87sgm6damv.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
In-Reply-To: <87sgm6damv.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-MC-Unique: Ouu_ULEANAqAu0kxjPn-9A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 03:23:36PM +0100, Vitaly Kuznetsov wrote:
> Peter Xu <peterx@redhat.com> writes:
>=20
> > Previously we were using either APIC_DEST_PHYSICAL|APIC_DEST_LOGICAL
> > or 0|1 to fill in kvm_lapic_irq.dest_mode, and it's done in an adhoc
> > way.  It's fine imho only because in most cases when we check against
> > dest_mode it's against APIC_DEST_PHYSICAL (which equals to 0).
> > However, that's not consistent, majorly because APIC_DEST_LOGICAL does
> > not equals to 1, so if one day we check irq.dest_mode against
> > APIC_DEST_LOGICAL we'll probably always get a false returned.
> >
> > This patch replaces the 0/1 settings of irq.dest_mode with the macros
> > to make them consistent.
> >
> > CC: Paolo Bonzini <pbonzini@redhat.com>
> > CC: Sean Christopherson <sean.j.christopherson@intel.com>
> > CC: Vitaly Kuznetsov <vkuznets@redhat.com>
> > CC: Nitesh Narayan Lal <nitesh@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  arch/x86/kvm/ioapic.c   | 9 ++++++---
> >  arch/x86/kvm/irq_comm.c | 7 ++++---
> >  arch/x86/kvm/x86.c      | 2 +-
> >  3 files changed, 11 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
> > index 9fd2dd89a1c5..1e091637d5d5 100644
> > --- a/arch/x86/kvm/ioapic.c
> > +++ b/arch/x86/kvm/ioapic.c
> > @@ -331,7 +331,8 @@ static void ioapic_write_indirect(struct kvm_ioapic=
 *ioapic, u32 val)
> >  =09=09=09irq.vector =3D e->fields.vector;
> >  =09=09=09irq.delivery_mode =3D e->fields.delivery_mode << 8;
> >  =09=09=09irq.dest_id =3D e->fields.dest_id;
> > -=09=09=09irq.dest_mode =3D e->fields.dest_mode;
> > +=09=09=09irq.dest_mode =3D e->fields.dest_mode ?
> > +=09=09=09    APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
> >  =09=09=09bitmap_zero(&vcpu_bitmap, 16);
> >  =09=09=09kvm_bitmap_or_dest_vcpus(ioapic->kvm, &irq,
> >  =09=09=09=09=09=09 &vcpu_bitmap);
> > @@ -343,7 +344,8 @@ static void ioapic_write_indirect(struct kvm_ioapic=
 *ioapic, u32 val)
> >  =09=09=09=09 * keep ioapic_handled_vectors synchronized.
> >  =09=09=09=09 */
> >  =09=09=09=09irq.dest_id =3D old_dest_id;
> > -=09=09=09=09irq.dest_mode =3D old_dest_mode;
> > +=09=09=09=09irq.dest_mode =3D old_dest_mode ?
> > +=09=09=09=09    APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
> >  =09=09=09=09kvm_bitmap_or_dest_vcpus(ioapic->kvm, &irq,
> >  =09=09=09=09=09=09=09 &vcpu_bitmap);
> >  =09=09=09}
> > @@ -369,7 +371,8 @@ static int ioapic_service(struct kvm_ioapic *ioapic=
, int irq, bool line_status)
> > =20
> >  =09irqe.dest_id =3D entry->fields.dest_id;
> >  =09irqe.vector =3D entry->fields.vector;
> > -=09irqe.dest_mode =3D entry->fields.dest_mode;
> > +=09irqe.dest_mode =3D entry->fields.dest_mode ?
> > +=09    APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
> >  =09irqe.trig_mode =3D entry->fields.trig_mode;
> >  =09irqe.delivery_mode =3D entry->fields.delivery_mode << 8;
> >  =09irqe.level =3D 1;
> > diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
> > index 8ecd48d31800..673b6afd6dbf 100644
> > --- a/arch/x86/kvm/irq_comm.c
> > +++ b/arch/x86/kvm/irq_comm.c
> > @@ -52,8 +52,8 @@ int kvm_irq_delivery_to_apic(struct kvm *kvm, struct =
kvm_lapic *src,
> >  =09unsigned long dest_vcpu_bitmap[BITS_TO_LONGS(KVM_MAX_VCPUS)];
> >  =09unsigned int dest_vcpus =3D 0;
> > =20
> > -=09if (irq->dest_mode =3D=3D 0 && irq->dest_id =3D=3D 0xff &&
> > -=09=09=09kvm_lowest_prio_delivery(irq)) {
> > +=09if (irq->dest_mode =3D=3D APIC_DEST_PHYSICAL &&
> > +=09    irq->dest_id =3D=3D 0xff && kvm_lowest_prio_delivery(irq)) {
> >  =09=09printk(KERN_INFO "kvm: apic: phys broadcast and lowest prio\n");
> >  =09=09irq->delivery_mode =3D APIC_DM_FIXED;
> >  =09}
> > @@ -114,7 +114,8 @@ void kvm_set_msi_irq(struct kvm *kvm, struct kvm_ke=
rnel_irq_routing_entry *e,
> >  =09=09irq->dest_id |=3D MSI_ADDR_EXT_DEST_ID(e->msi.address_hi);
> >  =09irq->vector =3D (e->msi.data &
> >  =09=09=09MSI_DATA_VECTOR_MASK) >> MSI_DATA_VECTOR_SHIFT;
> > -=09irq->dest_mode =3D (1 << MSI_ADDR_DEST_MODE_SHIFT) & e->msi.address=
_lo;
> > +=09irq->dest_mode =3D (1 << MSI_ADDR_DEST_MODE_SHIFT) & e->msi.address=
_lo ?
> > +=09    APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
> >  =09irq->trig_mode =3D (1 << MSI_DATA_TRIGGER_SHIFT) & e->msi.data;
> >  =09irq->delivery_mode =3D e->msi.data & 0x700;
> >  =09irq->msi_redir_hint =3D ((e->msi.address_lo
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 3ed167e039e5..3b00d662dc14 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -7356,7 +7356,7 @@ static void kvm_pv_kick_cpu_op(struct kvm *kvm, u=
nsigned long flags, int apicid)
> >  =09struct kvm_lapic_irq lapic_irq;
> > =20
> >  =09lapic_irq.shorthand =3D 0;
> > -=09lapic_irq.dest_mode =3D 0;
> > +=09lapic_irq.dest_mode =3D APIC_DEST_PHYSICAL;
> >  =09lapic_irq.level =3D 0;
> >  =09lapic_irq.dest_id =3D apicid;
> >  =09lapic_irq.msi_redir_hint =3D false;
>=20
> dest_mode is being passed to kvm_apic_match_dest() where we do:
>=20
> =09case APIC_DEST_NOSHORT:
> =09=09if (dest_mode =3D=3D APIC_DEST_PHYSICAL)
> =09=09=09return kvm_apic_match_physical_addr(target, mda);
> =09=09else
> =09=09=09return kvm_apic_match_logical_addr(target, mda);
>=20
> I'd suggest we fix this too then (and BUG() in case it's neither).

That's true.  Let me add another patch to fix it (probably easier by
changing the type of dest_mode param in kvm_apic_match_dest from int
to bool).

Thanks,

--=20
Peter Xu

