Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F8EC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47D320661
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlkiDoNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfLDSxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:53:22 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24761 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728664AbfLDSxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575485598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ylffdwtbjoTKiYnhI88q00B3s6s1C9NrFz3gX3cTcXw=;
        b=hlkiDoNOwEGo/9xlSp7uh/a8PITM4qLE30otqZF5uy3y+HaqKClB8vG621a/CSzlBx+v/2
        rG7bUFZZWOn6J9tZgiI6w7c5hwf6sr/TXwNRkR1mDpi3XYw7b4mSNEtpwI3N0S14JOQUd2
        SwMm1dYAepYgriRabBl2LL4w9RJm7t0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-eVLQ74X4N2KxtGvfCetV1g-1; Wed, 04 Dec 2019 13:53:15 -0500
Received: by mail-qv1-f72.google.com with SMTP id g15so438298qvk.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 10:53:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QE7M96G6hP/Dieos/ar87q4l5wVk9fT08cIHBcKEU2o=;
        b=HeeIfdTYHizo2wwPWJEg8X6NALAYmd3h8f0pslAeL2wiTdl0NfRfpNE2kJQJ8LMAAm
         Ah8JTqhGdKG0Cy9juIjgsu7NudesgvXTiQxSx1XKM2ieygwA1UdSfl414/xs4lIYQgPE
         1XMpP5MHdADROLMQp1ucIRl9kNlyyXRwO5ZFk9oejkNe0+b5efJqkV9hkDzMDtHwrMXe
         Y9I1vDcqIoBlFpOaQJPbR0dS42Yl4kpHFqawnLohxz3Q93Pzl0p9wSrWt4iD89aStBCt
         XmJeOtdMfkNbhSTJYOBVS2SvdTM+z28n3lhesKuOMCEnI0TXQjAiRQyfC/dMolpgPuKE
         wwSQ==
X-Gm-Message-State: APjAAAXro32M2ubBiP4larDz5EJsBcA4fJwmSneyC/dFDbQt3OEr/59d
        kYX9m8oMlspA1ZBrszPAWpGBDrnoKCSK9owjAIdB7+C08JhotawP5a8IJZwuJx9PHWsPpiejQnp
        wYNIAkoQ9N41w+38pmOWUhQLi
X-Received: by 2002:a0c:f792:: with SMTP id s18mr4136670qvn.118.1575485595122;
        Wed, 04 Dec 2019 10:53:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqzvwYYBHj/QDu51rlcQf/1bgxIm5FMgSWJmtAUSnpJ5yS/d77kuSitTNjjGdnfb0E7G4R3ekw==
X-Received: by 2002:a0c:f792:: with SMTP id s18mr4136654qvn.118.1575485594857;
        Wed, 04 Dec 2019 10:53:14 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id z6sm4029638qkz.101.2019.12.04.10.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 10:53:14 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:53:13 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] KVM: X86: Conert the last users of "shorthand =
 0" to use macros
Message-ID: <20191204185313.GB19939@xz-x1>
References: <20191203165903.22917-1-peterx@redhat.com>
 <20191203165903.22917-7-peterx@redhat.com>
 <875ziwt6h0.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
In-Reply-To: <875ziwt6h0.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-MC-Unique: eVLQ74X4N2KxtGvfCetV1g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 05:12:43PM +0100, Vitaly Kuznetsov wrote:
> Peter Xu <peterx@redhat.com> writes:
>=20
> > Change the last users of "shorthand =3D 0" to use APIC_DEST_NOSHORT.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  arch/x86/kvm/ioapic.c   | 4 ++--
> >  arch/x86/kvm/irq_comm.c | 2 +-
> >  arch/x86/kvm/x86.c      | 2 +-
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
> > index f53daeaaeb37..77538fd77dc2 100644
> > --- a/arch/x86/kvm/ioapic.c
> > +++ b/arch/x86/kvm/ioapic.c
> > @@ -330,7 +330,7 @@ static void ioapic_write_indirect(struct kvm_ioapic=
 *ioapic, u32 val)
> >  =09=09if (e->fields.delivery_mode =3D=3D APIC_DM_FIXED) {
> >  =09=09=09struct kvm_lapic_irq irq;
> > =20
> > -=09=09=09irq.shorthand =3D 0;
> > +=09=09=09irq.shorthand =3D APIC_DEST_NOSHORT;
> >  =09=09=09irq.vector =3D e->fields.vector;
> >  =09=09=09irq.delivery_mode =3D e->fields.delivery_mode << 8;
> >  =09=09=09irq.dest_id =3D e->fields.dest_id;
> > @@ -379,7 +379,7 @@ static int ioapic_service(struct kvm_ioapic *ioapic=
, int irq, bool line_status)
> >  =09irqe.trig_mode =3D entry->fields.trig_mode;
> >  =09irqe.delivery_mode =3D entry->fields.delivery_mode << 8;
> >  =09irqe.level =3D 1;
> > -=09irqe.shorthand =3D 0;
> > +=09irqe.shorthand =3D APIC_DEST_NOSHORT;
> >  =09irqe.msi_redir_hint =3D false;
> > =20
> >  =09if (irqe.trig_mode =3D=3D IOAPIC_EDGE_TRIG)
> > diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
> > index 7d083f71fc8e..9d711c2451c7 100644
> > --- a/arch/x86/kvm/irq_comm.c
> > +++ b/arch/x86/kvm/irq_comm.c
> > @@ -121,7 +121,7 @@ void kvm_set_msi_irq(struct kvm *kvm, struct kvm_ke=
rnel_irq_routing_entry *e,
> >  =09irq->msi_redir_hint =3D ((e->msi.address_lo
> >  =09=09& MSI_ADDR_REDIRECTION_LOWPRI) > 0);
> >  =09irq->level =3D 1;
> > -=09irq->shorthand =3D 0;
> > +=09irq->shorthand =3D APIC_DEST_NOSHORT;
> >  }
> >  EXPORT_SYMBOL_GPL(kvm_set_msi_irq);
> > =20
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 3b00d662dc14..f6d778436e15 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -7355,7 +7355,7 @@ static void kvm_pv_kick_cpu_op(struct kvm *kvm, u=
nsigned long flags, int apicid)
> >  {
> >  =09struct kvm_lapic_irq lapic_irq;
> > =20
> > -=09lapic_irq.shorthand =3D 0;
> > +=09lapic_irq.shorthand =3D APIC_DEST_NOSHORT;
> >  =09lapic_irq.dest_mode =3D APIC_DEST_PHYSICAL;
> >  =09lapic_irq.level =3D 0;
> >  =09lapic_irq.dest_id =3D apicid;
>=20
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>=20
> And, while on it, and if you're not yet tired I just noticed that
> kvm_apic_match_dest()'s parameter is called 'short_hand' while
> everywhere else we use 'shorthand'. Value the consistency we should :-)

I'll aquash your suggested change into previous patch ("KVM: X86: Fix
callers of kvm_apic_match_dest() to use correct macros") and keep your
r-b for that, otherwise I'm afraid the change could be too trivial to
stand as itself..

Thanks,

--=20
Peter Xu

