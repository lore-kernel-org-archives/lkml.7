Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADDBC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 10:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F35520706
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 10:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sd1Q4x5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfKWKag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 05:30:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28105 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726751AbfKWKag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 05:30:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574505030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=tHyeSpJ7sLWR615t3plMuZ1Vpdg4QSPNuIYfcXROw50=;
        b=Sd1Q4x5s6ciudludsjDCAyOyLq2I1s8r1hNe7oFnt5GYU5sCwze9D6mTb7D+JGw/sSiOn6
        DdugcRlBtvWWCHTsYKQPVXsBSXREWsi5B5NFgxw5YOdaRC8yYSpYKVf9w8QgJRJ/vBLI68
        C7cTWxaxmkd/KZa/lSQucTZcnwgn308=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-tYR6w5KNM0GeinVZfjJS1w-1; Sat, 23 Nov 2019 05:30:29 -0500
Received: by mail-wr1-f70.google.com with SMTP id 92so5282582wro.14
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 02:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BRL5/jsrsyTQSajOcuwfnNoj7FhSqXMj7k6xT9W7NjM=;
        b=ZM7GXW2y5NMFiMvK2xoZICfHOa+Inuf8yn0AFtjGGHibAMv2NnWK3JFNRotGC1qQD9
         ipBFeaDLsNt6YMelK82ha2wz9ZZsZmq04DYfTQ4qevBiAFXSK3u0BiM/GNIFDr2Zs3tq
         hXPKNJv7kz030+d1UhATgpoDQZJL7l5fN/veffVx299aUKeT527r4taxtxh1VGJn/rJv
         yhoPnZAzxRSKIPnAG4yWLNIMARsdSJSiWVK6rnr3tKB4I+MCy+JDum4+/PEvYvxkpL9p
         QRdyi9YXCgAbOpXgwQfzeyujCZZsTI+SS8iNG2w1MkUZGXYFzBCHR60k+obzCUg2zko5
         7RUg==
X-Gm-Message-State: APjAAAUrDDGYyi3KOjUJ2SHhDbMNkow1+lQZ5rjvSkVitSkCObazXqkc
        ah2jegSU+AgXHD6E0vlucQyeu7Whg6b3JI++VWqEUdLn8AgaKTOUiGp7/qGd8rrlTBXIWphzdyQ
        gdtICa4e/e5Xu+vOWXcB6UhFb
X-Received: by 2002:adf:e70d:: with SMTP id c13mr22019397wrm.248.1574505027790;
        Sat, 23 Nov 2019 02:30:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqyX7pfwLVRrAs6l9HErfSL8jhQ+C723kbyi9INcb8d3bySq/LiKuZ3Ia7YM04sulC0Eoma4Zg==
X-Received: by 2002:adf:e70d:: with SMTP id c13mr22019367wrm.248.1574505027378;
        Sat, 23 Nov 2019 02:30:27 -0800 (PST)
Received: from [192.168.42.104] (mob-109-112-4-118.net.vodafone.it. [109.112.4.118])
        by smtp.gmail.com with ESMTPSA id w4sm1433126wmk.29.2019.11.23.02.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2019 02:30:26 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: Grab KVM's srcu lock when setting nested state
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191122165818.32558-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6b07bcb9-a640-7ffe-36cf-370702f20d4b@redhat.com>
Date:   Sat, 23 Nov 2019 11:30:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191122165818.32558-1-sean.j.christopherson@intel.com>
Content-Language: en-US
X-MC-Unique: tYR6w5KNM0GeinVZfjJS1w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/19 17:58, Sean Christopherson wrote:
> Acquire kvm->srcu for the duration of ->set_nested_state() to fix a bug
> where nVMX derefences ->memslots without holding ->srcu or ->slots_lock.
>=20
> The other half of nested migration, ->get_nested_state(), does not need
> to acquire ->srcu as it is a purely a dump of internal KVM (and CPU)
> state to userspace.
>=20
> Detected as an RCU lockdep splat that is 100% reproducible by running
> KVM's state_test selftest with CONFIG_PROVE_LOCKING=3Dy.  Note that the
> failing function, kvm_is_visible_gfn(), is only checking the validity of
> a gfn, it's not actually accessing guest memory (which is more or less
> unsupported during vmx_set_nested_state() due to incorrect MMU state),
> i.e. vmx_set_nested_state() itself isn't fundamentally broken.  In any
> case, setting nested state isn't a fast path so there's no reason to go
> out of our way to avoid taking ->srcu.
>=20
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>   WARNING: suspicious RCU usage
>   5.4.0-rc7+ #94 Not tainted
>   -----------------------------
>   include/linux/kvm_host.h:626 suspicious rcu_dereference_check() usage!
>=20
>                other info that might help us debug this:
>=20
>   rcu_scheduler_active =3D 2, debug_locks =3D 1
>   1 lock held by evmcs_test/10939:
>    #0: ffff88826ffcb800 (&vcpu->mutex){+.+.}, at: kvm_vcpu_ioctl+0x85/0x6=
30 [kvm]
>=20
>   stack backtrace:
>   CPU: 1 PID: 10939 Comm: evmcs_test Not tainted 5.4.0-rc7+ #94
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/20=
15
>   Call Trace:
>    dump_stack+0x68/0x9b
>    kvm_is_visible_gfn+0x179/0x180 [kvm]
>    mmu_check_root+0x11/0x30 [kvm]
>    fast_cr3_switch+0x40/0x120 [kvm]
>    kvm_mmu_new_cr3+0x34/0x60 [kvm]
>    nested_vmx_load_cr3+0xbd/0x1f0 [kvm_intel]
>    nested_vmx_enter_non_root_mode+0xab8/0x1d60 [kvm_intel]
>    vmx_set_nested_state+0x256/0x340 [kvm_intel]
>    kvm_arch_vcpu_ioctl+0x491/0x11a0 [kvm]
>    kvm_vcpu_ioctl+0xde/0x630 [kvm]
>    do_vfs_ioctl+0xa2/0x6c0
>    ksys_ioctl+0x66/0x70
>    __x64_sys_ioctl+0x16/0x20
>    do_syscall_64+0x54/0x200
>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
>   RIP: 0033:0x7f59a2b95f47
>=20
> Fixes: 8fcc4b5923af5 ("kvm: nVMX: Introduce KVM_CAP_NESTED_STATE")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/x86.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 5d530521f11d..656878a9802e 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4421,6 +4421,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  =09case KVM_SET_NESTED_STATE: {
>  =09=09struct kvm_nested_state __user *user_kvm_nested_state =3D argp;
>  =09=09struct kvm_nested_state kvm_state;
> +=09=09int idx;
> =20
>  =09=09r =3D -EINVAL;
>  =09=09if (!kvm_x86_ops->set_nested_state)
> @@ -4444,7 +4445,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  =09=09    && !(kvm_state.flags & KVM_STATE_NESTED_GUEST_MODE))
>  =09=09=09break;
> =20
> +=09=09idx =3D srcu_read_lock(&vcpu->kvm->srcu);
>  =09=09r =3D kvm_x86_ops->set_nested_state(vcpu, user_kvm_nested_state, &=
kvm_state);
> +=09=09srcu_read_unlock(&vcpu->kvm->srcu, idx);
>  =09=09break;
>  =09}
>  =09case KVM_GET_SUPPORTED_HV_CPUID: {
>=20

Queued, thanks.

Paolo

