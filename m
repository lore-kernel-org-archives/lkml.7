Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5434AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271ED205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrK7GVhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfLCNTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:19:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25126 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726074AbfLCNTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:19:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575379162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RsqTwzDz1hPQy7QgqBrZxDGgK8E7PuyP6TQRTEXbU4o=;
        b=IrK7GVhTS9T+7FP8gbG/V+F9O4OdcpFZgQi9GfUkC2D/uorbMIG3sWz8cMo5eKdTcW/NQw
        7tCgcEtI16nc0/Hy5ZSK1Bx6ajb/B0KRUEZUVBi+NgYocN9IdrOsYkHDsvCJzMS72Ptc1y
        1ZRzsvRXC4rgWTkRFJj8oahfWj7Zu4I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-59VCwmrdNnaCFSpFKBRdSw-1; Tue, 03 Dec 2019 08:19:21 -0500
Received: by mail-wm1-f71.google.com with SMTP id o135so971005wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 05:19:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=R+4oYdpXVhG27DrGdRFr0rgKSjpFlrL/zqNo6puEy68=;
        b=GchSU7bKxowxpq/SLZNituK73WtbJnHvz0nrvFanE8JSy7WpD9F6Omrj7g3ZmxN0EK
         w258t/Y+13znH8AnKm9z4T302nizkPVUBNytVPRetyRTW6i37j4i6z54u8fwax+fi4WS
         C1ovczK4KFG4nn2CaxS3pNUJtvaYPY90j6+ZMMgkiA2NiuXmxXLi4djKbBC+rnxVuZF1
         eWySGnUb0+ZSTpUr7/rkEEMz+dPE/3EsEEMx6b9jN/S/w/+BmgY0jsV281YCrZpNVYlJ
         IcMKD0fNCE0UExexIDHVebWtjffnO3nW7+v/NmCvtly3UJI+14Q7bSzTzttYeHVVjJ/M
         sxZw==
X-Gm-Message-State: APjAAAVwNZ6sowkLUc0zajkmVqEOZf3PmyJEVSM4QEvLAw/Ee0FAuudl
        +MMCSuv6/hs2o3B1/WmoLb7+tYBjhN6EIYfEAdQxmE0zZQT7TqklIXUdD7150EL2OKGKEuhhbzP
        e/ia/GO8f4HB6Nsez+alMDp+J
X-Received: by 2002:a05:600c:54b:: with SMTP id k11mr17828552wmc.63.1575379158962;
        Tue, 03 Dec 2019 05:19:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqz9ey1HX98M6op+nW7G5+PeaFJJEIB66tjCaDd5HPacoO8E3rkc9kHYHItztc2JTgSAWe0t6Q==
X-Received: by 2002:a05:600c:54b:: with SMTP id k11mr17828539wmc.63.1575379158731;
        Tue, 03 Dec 2019 05:19:18 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z64sm3195018wmg.30.2019.12.03.05.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 05:19:16 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] KVM: X86: Drop KVM_APIC_SHORT_MASK and KVM_APIC_DEST_MASK
In-Reply-To: <20191202201314.543-5-peterx@redhat.com>
References: <20191202201314.543-1-peterx@redhat.com> <20191202201314.543-5-peterx@redhat.com>
Date:   Tue, 03 Dec 2019 14:19:16 +0100
Message-ID: <87tv6hbl7v.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: 59VCwmrdNnaCFSpFKBRdSw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> We have both APIC_SHORT_MASK and KVM_APIC_SHORT_MASK defined for the
> shorthand mask.  Similarly, we have both APIC_DEST_MASK and
> KVM_APIC_DEST_MASK defined for the destination mode mask.
>
> Drop the KVM_APIC_* macros and replace the only user of them to use
> the APIC_DEST_* macros instead.  At the meantime, move APIC_SHORT_MASK
> and APIC_DEST_MASK from lapic.c to lapic.h.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/x86/kvm/lapic.c | 3 ---
>  arch/x86/kvm/lapic.h | 5 +++--
>  arch/x86/kvm/svm.c   | 4 ++--
>  3 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 1eabe58bb6d5..805c18178bbf 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -56,9 +56,6 @@
>  #define APIC_VERSION=09=09=09(0x14UL | ((KVM_APIC_LVT_NUM - 1) << 16))
>  #define LAPIC_MMIO_LENGTH=09=09(1 << 12)
>  /* followed define is not in apicdef.h */
> -#define APIC_SHORT_MASK=09=09=090xc0000
> -#define APIC_DEST_NOSHORT=09=090x0
> -#define APIC_DEST_MASK=09=09=090x800
>  #define MAX_APIC_VECTOR=09=09=09256
>  #define APIC_VECTORS_PER_REG=09=0932
> =20
> diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
> index 0b9bbadd1f3c..5a9f29ed9a4b 100644
> --- a/arch/x86/kvm/lapic.h
> +++ b/arch/x86/kvm/lapic.h
> @@ -10,8 +10,9 @@
>  #define KVM_APIC_SIPI=09=091
>  #define KVM_APIC_LVT_NUM=096
> =20
> -#define KVM_APIC_SHORT_MASK=090xc0000
> -#define KVM_APIC_DEST_MASK=090x800
> +#define APIC_SHORT_MASK=09=09=090xc0000
> +#define APIC_DEST_NOSHORT=09=090x0
> +#define APIC_DEST_MASK=09=09=090x800
> =20
>  #define APIC_BUS_CYCLE_NS       1
>  #define APIC_BUS_FREQUENCY      (1000000000ULL / APIC_BUS_CYCLE_NS)
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 362e874297e4..65a27a7e9cb1 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -4519,9 +4519,9 @@ static int avic_incomplete_ipi_interception(struct =
vcpu_svm *svm)
>  =09=09 */
>  =09=09kvm_for_each_vcpu(i, vcpu, kvm) {
>  =09=09=09bool m =3D kvm_apic_match_dest(vcpu, apic,
> -=09=09=09=09=09=09     icrl & KVM_APIC_SHORT_MASK,
> +=09=09=09=09=09=09     icrl & APIC_SHORT_MASK,
>  =09=09=09=09=09=09     GET_APIC_DEST_FIELD(icrh),
> -=09=09=09=09=09=09     icrl & KVM_APIC_DEST_MASK);
> +=09=09=09=09=09=09     icrl & APIC_DEST_MASK);
> =20
>  =09=09=09if (m && !avic_vcpu_is_running(vcpu))
>  =09=09=09=09kvm_vcpu_wake_up(vcpu);

Personal taste but I would've preserved KVM_ prefix. The patch itself
looks correct, so

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

--=20
Vitaly

