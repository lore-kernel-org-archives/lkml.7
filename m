Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E60EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F76820675
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gU/PQQqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfLCQ1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:27:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52676 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbfLCQ1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:27:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575390473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+WnczAKQed6YpiIJYxujDrMx6sZk/yhl75EFdTgUL8M=;
        b=gU/PQQqitQMNJbnfstjf3S59SCgxsGdrOXj5zM7UBHeoOdNIfjcdS0dq1v39FFt4EB7gtd
        XSQ6K1eMJgUAbbdw2zp5789/fNM8HfuQqH1W9XIunoYGbfXNOwavwHNzfpTC3ELONYDmIA
        l1U69YS3cesN4Nb6QEeUCMLxIdmExMk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-EULFcBTAO264UuNegn3lSQ-1; Tue, 03 Dec 2019 11:27:51 -0500
Received: by mail-qt1-f199.google.com with SMTP id d9so2789803qtq.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 08:27:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZSHaj65Ct3ZOf9flXzApJ7gvW4At2V+yKIUimhT/dHk=;
        b=i1tLuA4E1UH3wJh3Su/udLVewrV+m9/qep2HRg9BtGxyuq7NfVwvVbYVxy19kfQVPw
         i0rF1Ln/evCJZCSw7csQ2ZkVTHh8VsvBcfHwfVOQJKzqHsUjD6me/jsrl3OSs2hGCC6m
         xaUYyp13CyCzbUzN8gFBkcLfW185iHgXUEKhmWFD8mNWDyqNw5pXFM+WGTMWGfaxSfVn
         UaolaeBzTImYwXZfMt1vK0ehvblJCJPKcdbnd9EWatEoZMMnKZoKUv1pj0mYPSSsfBiI
         JDq131TrnGs1MmVnS4zxd7e81b0FVpe6gBYYj/JDLuQYP5aSiU2l0mHqDoTy2XzgleXO
         Nzzg==
X-Gm-Message-State: APjAAAVd0mVhgHGNFzxhO5zCcan4L057sko0/yYw4Ek8FJUP8JgW3MVI
        mTjWU6PlZ4dXCf+FbG5s2Ds9tDfF6fIg1aJ5VlTy3spDydC4sm0CULizNhTvLNfl2khzkn2ZOT3
        69L/S4YtMUnU7QnMUNw5KwvXw
X-Received: by 2002:a37:9485:: with SMTP id w127mr3842680qkd.128.1575390470031;
        Tue, 03 Dec 2019 08:27:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqyKKy4GZEoSBTWv3SIwooKspLWb4cJDbiCQx+onygw7OYAriklZioQoVK71vPsrpm59rrXIhA==
X-Received: by 2002:a37:9485:: with SMTP id w127mr3842643qkd.128.1575390469634;
        Tue, 03 Dec 2019 08:27:49 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id k50sm2086333qtc.90.2019.12.03.08.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 08:27:48 -0800 (PST)
Date:   Tue, 3 Dec 2019 11:27:47 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] KVM: X86: Fix callers of kvm_apic_match_dest() to
 use correct macros
Message-ID: <20191203162747.GD17275@xz-x1>
References: <20191202201314.543-1-peterx@redhat.com>
 <20191202201314.543-6-peterx@redhat.com>
 <87r21lbl0c.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
In-Reply-To: <87r21lbl0c.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-MC-Unique: EULFcBTAO264UuNegn3lSQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 02:23:47PM +0100, Vitaly Kuznetsov wrote:
> Peter Xu <peterx@redhat.com> writes:
>=20
> > Callers of kvm_apic_match_dest() should always pass in APIC_DEST_*
> > macros for either dest_mode and short_hand parameters.  Fix up all the
> > callers of kvm_apic_match_dest() that are not following the rule.
> >
> > Reported-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  arch/x86/kvm/ioapic.c   | 11 +++++++----
> >  arch/x86/kvm/irq_comm.c |  3 ++-
> >  2 files changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
> > index 901d85237d1c..1082ca8d11e5 100644
> > --- a/arch/x86/kvm/ioapic.c
> > +++ b/arch/x86/kvm/ioapic.c
> > @@ -108,8 +108,9 @@ static void __rtc_irq_eoi_tracking_restore_one(stru=
ct kvm_vcpu *vcpu)
> >  =09union kvm_ioapic_redirect_entry *e;
> > =20
> >  =09e =3D &ioapic->redirtbl[RTC_GSI];
> > -=09if (!kvm_apic_match_dest(vcpu, NULL, 0,=09e->fields.dest_id,
> > -=09=09=09=09e->fields.dest_mode))
> > +=09if (!kvm_apic_match_dest(vcpu, NULL, APIC_DEST_NOSHORT,
> > +=09=09=09=09 e->fields.dest_id,
> > +=09=09=09=09 kvm_lapic_irq_dest_mode(e->fields.dest_mode)))
> >  =09=09return;
> > =20
> >  =09new_val =3D kvm_apic_pending_eoi(vcpu, e->fields.vector);
> > @@ -237,6 +238,7 @@ void kvm_ioapic_scan_entry(struct kvm_vcpu *vcpu, u=
long *ioapic_handled_vectors)
> >  =09struct dest_map *dest_map =3D &ioapic->rtc_status.dest_map;
> >  =09union kvm_ioapic_redirect_entry *e;
> >  =09int index;
> > +=09u16 dm;
> > =20
> >  =09spin_lock(&ioapic->lock);
> > =20
> > @@ -250,8 +252,9 @@ void kvm_ioapic_scan_entry(struct kvm_vcpu *vcpu, u=
long *ioapic_handled_vectors)
> >  =09=09if (e->fields.trig_mode =3D=3D IOAPIC_LEVEL_TRIG ||
> >  =09=09    kvm_irq_has_notifier(ioapic->kvm, KVM_IRQCHIP_IOAPIC, index)=
 ||
> >  =09=09    index =3D=3D RTC_GSI) {
> > -=09=09=09if (kvm_apic_match_dest(vcpu, NULL, 0,
> > -=09=09=09             e->fields.dest_id, e->fields.dest_mode) ||
> > +=09=09=09dm =3D kvm_lapic_irq_dest_mode(e->fields.dest_mode);
>=20
> Nit: you could've defined 'dm' right here in the block (after '{') but
> in any case I'd suggest to stick to 'dest_mode' and not shorten it to
> 'dm' for consistency.
>=20
> > +=09=09=09if (kvm_apic_match_dest(vcpu, NULL, APIC_DEST_NOSHORT,
> > +=09=09=09=09=09=09e->fields.dest_id, dm) ||
> >  =09=09=09    kvm_apic_pending_eoi(vcpu, e->fields.vector))
> >  =09=09=09=09__set_bit(e->fields.vector,
> >  =09=09=09=09=09  ioapic_handled_vectors);
> > diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
> > index 5f59e5ebdbed..e89c2160b39f 100644
> > --- a/arch/x86/kvm/irq_comm.c
> > +++ b/arch/x86/kvm/irq_comm.c
> > @@ -417,7 +417,8 @@ void kvm_scan_ioapic_routes(struct kvm_vcpu *vcpu,
> > =20
> >  =09=09=09kvm_set_msi_irq(vcpu->kvm, entry, &irq);
> > =20
> > -=09=09=09if (irq.level && kvm_apic_match_dest(vcpu, NULL, 0,
> > +=09=09=09if (irq.level &&
> > +=09=09=09    kvm_apic_match_dest(vcpu, NULL, APIC_DEST_NOSHORT,
> >  =09=09=09=09=09=09irq.dest_id, irq.dest_mode))
> >  =09=09=09=09__set_bit(irq.vector, ioapic_handled_vectors);
> >  =09=09}
>=20
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

I'll move the declaration in with your r-b.  'dm' is a silly trick of
mine to avoid the 80-char line limit.  Thanks,

--=20
Peter Xu

