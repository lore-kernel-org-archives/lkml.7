Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A25C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C0D2073C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbHsJhVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfLCWP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:15:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49534 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727685AbfLCWPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575411324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UB9ZgJL0LVBzrXVO1r53wgN22JyrmkJoVoxYbTbg3SQ=;
        b=NbHsJhVsA9xgu0LvXk6RY3qBPyzJOq+jWSFblzWdN3Ho8mMI8WsqIx9DgA+6Iko3vkdh1+
        Kcx05PSV49cK5hjEa+Hj16+txEdmu41hHl48UTtVSb1Lj+ZB4960/sJE1GBqEp8TOJkhKH
        WNTcgBT1IvDgEmEb+A8Rssgpwvt6yoo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-AuHI1W9jOBur9-edB6vhtw-1; Tue, 03 Dec 2019 17:15:21 -0500
Received: by mail-qk1-f197.google.com with SMTP id q13so3266964qke.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 14:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AGVWQ+zcL2dkslOU05yng1/kP9NdpE2IIhQuBq0pSNQ=;
        b=rrISzdii3jH4zIF7POlxIdFhGL0vw6mvbcoWZ2q6Q6M3UuZTJBsQmZ+oOd9eh+bHZ3
         l46ZMsEnvVLQM20lT+Cpn9udSgCSNvVJJlBhTWsEu7/Z17RGviCxdeXs7BQ6epjLzAr/
         qJqZ6Z2VSM/t6Q20ydKyA+Y5o71gulyLVSqow+QyWi3CAh5h1jCTiUS4BVjc4CCX/3zZ
         +1NAJYG+7AJWw6oWqnc2xL8xnBBWO3lGPMuI5F0Gb6qJh+ViZM12uI1nn7lykWIZsm1u
         WyO4iScNaLP+mrj3OzLHuy0Xz+MIiLOeEeP5Da8K5LBTdDSHoT5Q9Duo6ZEsf+YEADyW
         UAyQ==
X-Gm-Message-State: APjAAAU6cBkgvHDGeWZdaaXj8OsIN32rB7j1jXSfsYFKpPJ1QsZ4U8i+
        qBb3WV5e22+q2ISxhMx62cJSGW57gCA7uTJqWCUutYEBp/XPK4u4PGsResG2VseUUQxYaiQZkKx
        +l5J/KtwvC0r2s+OVm0ANGpp2
X-Received: by 2002:a0c:8d4b:: with SMTP id s11mr7535031qvb.244.1575411321335;
        Tue, 03 Dec 2019 14:15:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqwyElI3oc9o+5c3AsYFu76g1QaYQ/qoQbRk2qDd+XapFm+qrMHvx3ukErPnA/Xvv6EKAiYsKQ==
X-Received: by 2002:a0c:8d4b:: with SMTP id s11mr7534988qvb.244.1575411321019;
        Tue, 03 Dec 2019 14:15:21 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id f6sm2543737qkk.12.2019.12.03.14.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 14:15:20 -0800 (PST)
Date:   Tue, 3 Dec 2019 17:15:19 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v4 3/6] KVM: X86: Use APIC_DEST_* macros properly in
 kvm_lapic_irq.dest_mode
Message-ID: <20191203221519.GI17275@xz-x1>
References: <20191203165903.22917-1-peterx@redhat.com>
 <20191203165903.22917-4-peterx@redhat.com>
 <20191203220752.GJ19877@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191203220752.GJ19877@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-MC-Unique: AuHI1W9jOBur9-edB6vhtw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 02:07:52PM -0800, Sean Christopherson wrote:
> On Tue, Dec 03, 2019 at 11:59:00AM -0500, Peter Xu wrote:
> > We were using either APIC_DEST_PHYSICAL|APIC_DEST_LOGICAL or 0|1 to
> > fill in kvm_lapic_irq.dest_mode.  It's fine only because in most cases
> > when we check against dest_mode it's against APIC_DEST_PHYSICAL (which
> > equals to 0).  However, that's not consistent.  We'll have problem
> > when we want to start checking against APIC_DEST_LOGICAL, which does
> > not equals to 1.
> >=20
> > This patch firstly introduces kvm_lapic_irq_dest_mode() helper to take
> > any boolean of destination mode and return the APIC_DEST_* macro.
> > Then, it replaces the 0|1 settings of irq.dest_mode with the helper.
> >=20
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h | 5 +++++
> >  arch/x86/kvm/ioapic.c           | 9 ++++++---
> >  arch/x86/kvm/irq_comm.c         | 7 ++++---
> >  arch/x86/kvm/x86.c              | 2 +-
> >  4 files changed, 16 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm=
_host.h
> > index b79cd6aa4075..f815c97b1b57 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -1022,6 +1022,11 @@ struct kvm_lapic_irq {
> >  =09bool msi_redir_hint;
> >  };
> > =20
> > +static inline u16 kvm_lapic_irq_dest_mode(bool dest_mode)
> > +{
> > +=09return dest_mode ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
>=20
> IMO this belongs in ioapic.c as it's specifically provided for converting
> an I/O APIC redirection entry into a local APIC destination mode.  Withou=
t
> the I/O APIC context, %true=3D=3DAPIC_DEST_LOGICAL looks like a completel=
y
> arbitrary decision.  And if it's in ioapic.c, it can take the union
> of a bool, which avoids the casting and shortens the callers.  E.g.:
>=20
> static u64 ioapic_to_lapic_dest_mode(union kvm_ioapic_redirect_entry *e)
> {
> =09return e->fields.dest_mode ?  APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
> }
>=20
> The other option would be to use the same approach as delivery_mode and
> open code the shift.

It's also used for MSI address encodings, please see below [1].

The thing is that no matter how external protocols define destination
mode, it's always a boolean no matter where it resides, or at which bit.

Thanks,

[...]

> > @@ -114,7 +114,8 @@ void kvm_set_msi_irq(struct kvm *kvm, struct kvm_ke=
rnel_irq_routing_entry *e,
> >  =09=09irq->dest_id |=3D MSI_ADDR_EXT_DEST_ID(e->msi.address_hi);
> >  =09irq->vector =3D (e->msi.data &
> >  =09=09=09MSI_DATA_VECTOR_MASK) >> MSI_DATA_VECTOR_SHIFT;
> > -=09irq->dest_mode =3D (1 << MSI_ADDR_DEST_MODE_SHIFT) & e->msi.address=
_lo;
> > +=09irq->dest_mode =3D kvm_lapic_irq_dest_mode(
> > +=09    !!((1 << MSI_ADDR_DEST_MODE_SHIFT) & e->msi.address_lo));

[1]

> >  =09irq->trig_mode =3D (1 << MSI_DATA_TRIGGER_SHIFT) & e->msi.data;
> >  =09irq->delivery_mode =3D e->msi.data & 0x700;
> >  =09irq->msi_redir_hint =3D ((e->msi.address_lo

--=20
Peter Xu

