Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ADAC43215
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 10:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E92620706
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 10:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cr7SwgtW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfKWK34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 05:29:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52672 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726481AbfKWK34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 05:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574504995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=b0nGYW2Evu1Vo0GnMnluFE/WqpJeDuxhq9+fUV8fdR0=;
        b=cr7SwgtWWTHOvPpSFvpyuPd6EDZ3UGQaGytRH5RxnkV7azxYf6ed+Rhehgvfx0az7teAMJ
        TQO35qjcJLK5LcVAyGPzfzIvkUMIpb9R7+hFuHY8J84m9LKGJBxl2ExMIclVQbB6vRSpEM
        SRegruKLFozKYmR+u5Zu3kNL8olaKbQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-3Mx7hR8DPc2yNr3z5Xmu3Q-1; Sat, 23 Nov 2019 05:29:53 -0500
Received: by mail-wr1-f71.google.com with SMTP id p1so4171478wrw.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 02:29:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uatzGgKPx8lrJYeybqBiyYHtN3+XnYuv6IHQKW9rOoU=;
        b=mBjayVjcqCbU1hq7JcgLOWY0k3lfj8tXq135KImGPt1G/YJ6Ve3C5Ng13CBORoPXtc
         A5OSQlBWeyfP/QBJbv4NJts0jbcD4q3k8OmQu36rGvtqngrZ+yGRh+Bdi5C8OV0fTSKv
         t0RsgV0UfOc0Sjw8aZNhlMXiYNHnyUlS9AVw9nBlwfB1O2yskZPew0bxTwI4ElDuvnel
         G2f+GmAyyTyxe9W9QnFkx2yNGn2O//5k5+UA5MqNJCD7WsQUgXW0o14V/FX8ynbR1ZV1
         Fiun6rRwpzgWOlzcEY4oCfY0d+rd9T1wzgk0H2MroelALf9vSgUr1rWsbfpKDx9lOS4B
         c4mg==
X-Gm-Message-State: APjAAAUaqUkm+lk40o/5wRR/HgPl0Tv1I4dJPniIAzYskCDVrfCiu442
        RCRwntcyE9v5EigLaGrXrm89DI1CyGzAqhdlLPuLP+75OR3fMie3zzpVXa/we8JPeGb4l7bms4+
        OQz8HeDokJKLlr6Y3B2L5v/Ob
X-Received: by 2002:adf:9e92:: with SMTP id a18mr21907550wrf.34.1574504992003;
        Sat, 23 Nov 2019 02:29:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqx+4o6q2BbPnhDhJn1tGwzLvr3ecTKLY+jm2sk7KVnT27GBJ6mTTIvSgxETvX2M0dih9qBbcg==
X-Received: by 2002:adf:9e92:: with SMTP id a18mr21907527wrf.34.1574504991741;
        Sat, 23 Nov 2019 02:29:51 -0800 (PST)
Received: from [192.168.42.104] (mob-109-112-4-118.net.vodafone.it. [109.112.4.118])
        by smtp.gmail.com with ESMTPSA id f140sm1460892wme.21.2019.11.23.02.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2019 02:29:51 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: Open code shared_msr_update() in its only
 caller
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191122200450.26239-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9e0038a3-dd57-353f-f176-edea48491174@redhat.com>
Date:   Sat, 23 Nov 2019 11:29:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191122200450.26239-1-sean.j.christopherson@intel.com>
Content-Language: en-US
X-MC-Unique: 3Mx7hR8DPc2yNr3z5Xmu3Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/19 21:04, Sean Christopherson wrote:
> Fold shared_msr_update() into its sole user to eliminate its pointless
> bounds check, its godawful printk, its misleading comment (it's called
> under a global lock), and its woefully inaccurate name.
>=20
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/x86.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
>=20
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a256e09f321a..35b571c769bd 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -262,23 +262,6 @@ static void kvm_on_user_return(struct user_return_no=
tifier *urn)
>  =09}
>  }
> =20
> -static void shared_msr_update(unsigned slot, u32 msr)
> -{
> -=09u64 value;
> -=09unsigned int cpu =3D smp_processor_id();
> -=09struct kvm_shared_msrs *smsr =3D per_cpu_ptr(shared_msrs, cpu);
> -
> -=09/* only read, and nobody should modify it at this time,
> -=09 * so don't need lock */
> -=09if (slot >=3D shared_msrs_global.nr) {
> -=09=09printk(KERN_ERR "kvm: invalid MSR slot!");
> -=09=09return;
> -=09}
> -=09rdmsrl_safe(msr, &value);
> -=09smsr->values[slot].host =3D value;
> -=09smsr->values[slot].curr =3D value;
> -}
> -
>  void kvm_define_shared_msr(unsigned slot, u32 msr)
>  {
>  =09BUG_ON(slot >=3D KVM_NR_SHARED_MSRS);
> @@ -290,10 +273,16 @@ EXPORT_SYMBOL_GPL(kvm_define_shared_msr);
> =20
>  static void kvm_shared_msr_cpu_online(void)
>  {
> -=09unsigned i;
> +=09unsigned int cpu =3D smp_processor_id();
> +=09struct kvm_shared_msrs *smsr =3D per_cpu_ptr(shared_msrs, cpu);
> +=09u64 value;
> +=09int i;
> =20
> -=09for (i =3D 0; i < shared_msrs_global.nr; ++i)
> -=09=09shared_msr_update(i, shared_msrs_global.msrs[i]);
> +=09for (i =3D 0; i < shared_msrs_global.nr; ++i) {
> +=09=09rdmsrl_safe(shared_msrs_global.msrs[i], &value);
> +=09=09smsr->values[i].host =3D value;
> +=09=09smsr->values[i].curr =3D value;
> +=09}
>  }
> =20
>  int kvm_set_shared_msr(unsigned slot, u64 value, u64 mask)
>=20

Queued, thanks.

Paolo

