Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB0AC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38FB215E5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h01fvv2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfLBJSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 04:18:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28254 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725977AbfLBJSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 04:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575278286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=npff6qkaiVVRvv7tuPNtj+wwmibAXzAwdtk2EuB02Og=;
        b=h01fvv2duL2yeNWSzqFbqghjq9ceLcP03KIdQaxCJwX38dh0XZ/vmlxUscdDhoUBhy19bX
        otGDPAac7Lg3PqoiWUb9EVZ+70mi31zdgIdx2jJ0G3mG+FFA8ZQv6tC7nY209MLdkHtQsG
        zfAXk4BtnurO1/fI3u+/MlaZApDs94k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-SXq89VQnOBGq3TC1VlgEjQ-1; Mon, 02 Dec 2019 04:18:04 -0500
Received: by mail-wr1-f70.google.com with SMTP id b13so5995053wrx.22
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 01:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=R6aPR3UqicHf4GsiWrf0zN37cxh4xgoEfGHaIlgH6C0=;
        b=jcXtDa0RcCMRptiYJPCPQIRywXewDCGc/XgW0LCM/pJnLFW4GIWjhFcQ1/lmNJt3Oi
         EZzICLkoRGu4OZFrDdV0DrWNQoKLVDYA5lOzPClBvKSDX3ztar65uSFP7pVQgIa6iPAd
         YAQuscjWG7lehRvRWEh4Ghc8uRKkJRmKOWhVeWxDuv7Mpns8MEcjHkWDFjA6ThbLWVP0
         ymP4ZXTLN1KtNQrwMhd/wo2+P8dk5/gzYeb8drHvgsF1KV8k/yDVrdlgiGC+ePJQO8FX
         1BQHSJd9shHv48t+0rVHoQcKhoLU0zu5Hk1aWCJZTUop+i3Jx811gPuETYrSDL6y6IjS
         nwNg==
X-Gm-Message-State: APjAAAXJhT68ivpK6i44rvSae/UaFM0Ac/L/4ICIdJZLAgkGseTjsBDk
        atpsUNzNPCxeqobqKjzhjjHAgqvWANWUUzUYHnmjM83AFo0kEQzYRRRCMMbhsWrSgfodDPegBeq
        O9gbUTgsiDoueqtmY/EtjiAGj
X-Received: by 2002:a7b:cd82:: with SMTP id y2mr25285016wmj.58.1575278283803;
        Mon, 02 Dec 2019 01:18:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqx8JcZBBXm6dvSYhQNB14AMzV0OR34nUmyvp0qHHFqNiqcWeXkqzbmRcx4EvUNVoQ4Qfvpdbw==
X-Received: by 2002:a7b:cd82:: with SMTP id y2mr25284991wmj.58.1575278283477;
        Mon, 02 Dec 2019 01:18:03 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t81sm23770468wmg.6.2019.12.02.01.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 01:18:02 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com
Subject: Re: [PATCH v2 3/3] KVM: X86: Fixup kvm_apic_match_dest() dest_mode parameter
In-Reply-To: <20191129163234.18902-4-peterx@redhat.com>
References: <20191129163234.18902-1-peterx@redhat.com> <20191129163234.18902-4-peterx@redhat.com>
Date:   Mon, 02 Dec 2019 10:18:00 +0100
Message-ID: <87mucbcchj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: SXq89VQnOBGq3TC1VlgEjQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> The problem is the same as the previous patch on that we've got too
> many ways to define a dest_mode, but logically we should only pass in
> APIC_DEST_* macros for this helper.

Using 'the previous patch' in changelog is OK until it comes to
backporting as the order can change. I'd suggest to spell out "KVM: X86:
Use APIC_DEST_* macros properly" explicitly.

>
> To make it easier, simply define dest_mode of kvm_apic_match_dest() to
> be a boolean to make it right while we can avoid to touch the callers.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/x86/kvm/lapic.c | 5 +++--
>  arch/x86/kvm/lapic.h | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index cf9177b4a07f..80732892c709 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -791,8 +791,9 @@ static u32 kvm_apic_mda(struct kvm_vcpu *vcpu, unsign=
ed int dest_id,
>  =09return dest_id;
>  }
> =20
> +/* Set dest_mode to true for logical mode, false for physical mode */
>  bool kvm_apic_match_dest(struct kvm_vcpu *vcpu, struct kvm_lapic *source=
,
> -=09=09=09   int short_hand, unsigned int dest, int dest_mode)
> +=09=09=09   int short_hand, unsigned int dest, bool dest_mode)
>  {
>  =09struct kvm_lapic *target =3D vcpu->arch.apic;
>  =09u32 mda =3D kvm_apic_mda(vcpu, dest, source, target);
> @@ -800,7 +801,7 @@ bool kvm_apic_match_dest(struct kvm_vcpu *vcpu, struc=
t kvm_lapic *source,
>  =09ASSERT(target);
>  =09switch (short_hand) {
>  =09case APIC_DEST_NOSHORT:
> -=09=09if (dest_mode =3D=3D APIC_DEST_PHYSICAL)
> +=09=09if (dest_mode =3D=3D false)

I must admit this seriously harm the readability of the code for
me. Just look at the=20

 if (dest_mode =3D=3D false)

line without a context and try to say what's being checked. I can't.

I see to solutions:
1) Adhere to the APIC_DEST_PHYSICAL/APIC_DEST_LOGICAL (basically - just
check against "dest_mode =3D=3D APIC_DEST_LOGICAL" in the else branch)
2) Rename the dest_mode parameter to 'dest_mode_is_phys' or something
like that.

>  =09=09=09return kvm_apic_match_physical_addr(target, mda);
>  =09=09else
>  =09=09=09return kvm_apic_match_logical_addr(target, mda);
> diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
> index 19b36196e2ff..c0b472ed87ad 100644
> --- a/arch/x86/kvm/lapic.h
> +++ b/arch/x86/kvm/lapic.h
> @@ -82,7 +82,7 @@ int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg=
, u32 val);
>  int kvm_lapic_reg_read(struct kvm_lapic *apic, u32 offset, int len,
>  =09=09       void *data);
>  bool kvm_apic_match_dest(struct kvm_vcpu *vcpu, struct kvm_lapic *source=
,
> -=09=09=09   int short_hand, unsigned int dest, int dest_mode);
> +=09=09=09   int short_hand, unsigned int dest, bool dest_mode);
>  int kvm_apic_compare_prio(struct kvm_vcpu *vcpu1, struct kvm_vcpu *vcpu2=
);
>  int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
>  =09=09=09     struct kvm_lapic_irq *irq,

--=20
Vitaly

