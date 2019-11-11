Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EB8C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3145621655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gezhLtqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfKKOjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:39:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55065 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726908AbfKKOjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:39:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573483150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=wirKbU/8Cv2mgoDz4OmhWHmf28SB8MLFquOJWJpWCPc=;
        b=gezhLtqesh55OuDgYLITz/7Szuc/xJB+M/Wgcvz3C+NCJ3fd/c5iOlZfmqjK2kJFCnUJhB
        qGCdc9gWbymZ8AZAXFz5inenfxDJcevrk/90y2/WqZelO1AiOo06n10CrwK5eW8fWu6AJM
        3b+01WAqfqK8ADK4uIXUZElAmgMQVm0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-6N1VGOxBMCeiM_l3S0F-Dw-1; Mon, 11 Nov 2019 09:39:08 -0500
Received: by mail-wm1-f71.google.com with SMTP id f11so8484708wmc.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 06:39:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2vUuMLzRqkGHHf2+2jVwfNEqVzFHxRKuojcVRTT5wvM=;
        b=cTy+qI9O8L6hSCEfENSWUBNrIb8iP6mbubuC/iYBzUX2zhyoVjWSwOq8O3UsxtetTc
         i5640hZS43Loal+mwzh/c6kpb/ukIIriIBZlaEnupnALAWWj5ye9Ltq7YWGC/3/D07eZ
         p3xb3cigyaIgpzMI0tb/zBnhzM4Emp0rCWneErsbgn9W5BM25qZiVeQ5yNoan2VqcbXa
         GSRfqNh03xzaH0njoM5VD7O/F6w/Id0tKYoAqzgx1oaDNlSaWcMV2ZKuzDFZE2dzLjOt
         tEjFeYQDjxNnHy5mTZLsGtZCIhI8MfuYAqVYbxcTKeSco7kUawU4FJBBzrKKpLpp3CkE
         N2cw==
X-Gm-Message-State: APjAAAXZw7rH46A4NSbRJzrx/ddcWegpCt3rq5fk4pzr/ccLjKEv3JCT
        k0MqksF1qOs4D6Em4qtbM0mnqNZtBkmcEYCRUeWULLhQ3amVbHUra8OPzBKYA0tWtCSYReYe9RA
        9hrWJemIgReglBwOtg3RH5bDU
X-Received: by 2002:a7b:c1d0:: with SMTP id a16mr22013155wmj.127.1573483146363;
        Mon, 11 Nov 2019 06:39:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqxJ8FeEElSu3YUeqierkfd/csj/UTEuloo6RjxvUSLwq82HJNOJS+SokLC3HuL5PAhxFuoEYw==
X-Received: by 2002:a7b:c1d0:: with SMTP id a16mr22013123wmj.127.1573483146026;
        Mon, 11 Nov 2019 06:39:06 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a0f7:472a:1e7:7ef? ([2001:b07:6468:f312:a0f7:472a:1e7:7ef])
        by smtp.gmail.com with ESMTPSA id j63sm22130103wmj.46.2019.11.11.06.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 06:39:05 -0800 (PST)
Subject: Re: [PATCH v1 2/3] KVM: VMX: Do not change PID.NDST when loading a
 blocked vCPU
To:     Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Liran Alon <liran.alon@oracle.com>,
        Jag Raman <jag.raman@oracle.com>
References: <20191106175602.4515-1-joao.m.martins@oracle.com>
 <20191106175602.4515-3-joao.m.martins@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <15c8c821-25ff-eb62-abd3-8d7d69650744@redhat.com>
Date:   Mon, 11 Nov 2019 15:39:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191106175602.4515-3-joao.m.martins@oracle.com>
Content-Language: en-US
X-MC-Unique: 6N1VGOxBMCeiM_l3S0F-Dw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/19 18:56, Joao Martins wrote:
> When vCPU enters block phase, pi_pre_block() inserts vCPU to a per pCPU
> linked list of all vCPUs that are blocked on this pCPU. Afterwards, it
> changes PID.NV to POSTED_INTR_WAKEUP_VECTOR which its handler
> (wakeup_handler()) is responsible to kick (unblock) any vCPU on that
> linked list that now has pending posted interrupts.
>=20
> While vCPU is blocked (in kvm_vcpu_block()), it may be preempted which
> will cause vmx_vcpu_pi_put() to set PID.SN.  If later the vCPU will be
> scheduled to run on a different pCPU, vmx_vcpu_pi_load() will clear
> PID.SN but will also *overwrite PID.NDST to this different pCPU*.
> Instead of keeping it with original pCPU which vCPU had entered block
> phase on.
>=20
> This results in an issue because when a posted interrupt is delivered,
> the wakeup_handler() will be executed and fail to find blocked vCPU on
> its per pCPU linked list of all vCPUs that are blocked on this pCPU.
> Which is due to the vCPU being placed on a *different* per pCPU
> linked list than the original pCPU that it had entered block phase.
>=20
> The regression is introduced by commit c112b5f50232 ("KVM: x86:
> Recompute PID.ON when clearing PID.SN"). Therefore, partially revert
> it and reintroduce the condition in vmx_vcpu_pi_load() responsible for
> avoiding changing PID.NDST when loading a blocked vCPU.
>=20
> Fixes: c112b5f50232 ("KVM: x86: Recompute PID.ON when clearing PID.SN")
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>

Something wrong in the SoB line?

Otherwise looks good.

Paolo

> ---
>  arch/x86/kvm/vmx/vmx.c | 14 ++++++++++++++
>  arch/x86/kvm/vmx/vmx.h |  6 ++++++
>  2 files changed, 20 insertions(+)
>=20
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 18b0bee662a5..75d903455e1c 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1274,6 +1274,18 @@ static void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu=
, int cpu)
>  =09if (!pi_test_sn(pi_desc) && vcpu->cpu =3D=3D cpu)
>  =09=09return;
> =20
> +=09/*
> +=09 * If the 'nv' field is POSTED_INTR_WAKEUP_VECTOR, do not change
> +=09 * PI.NDST: pi_post_block is the one expected to change PID.NDST and =
the
> +=09 * wakeup handler expects the vCPU to be on the blocked_vcpu_list tha=
t
> +=09 * matches PI.NDST. Otherwise, a vcpu may not be able to be woken up
> +=09 * correctly.
> +=09 */
> +=09if (pi_desc->nv =3D=3D POSTED_INTR_WAKEUP_VECTOR || vcpu->cpu =3D=3D =
cpu) {
> +=09=09pi_clear_sn(pi_desc);
> +=09=09goto after_clear_sn;
> +=09}
> +
>  =09/* The full case.  */
>  =09do {
>  =09=09old.control =3D new.control =3D pi_desc->control;
> @@ -1289,6 +1301,8 @@ static void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu,=
 int cpu)
>  =09} while (cmpxchg64(&pi_desc->control, old.control,
>  =09=09=09   new.control) !=3D old.control);
> =20
> +after_clear_sn:
> +
>  =09/*
>  =09 * Clear SN before reading the bitmap.  The VT-d firmware
>  =09 * writes the bitmap and reads SN atomically (5.2.3 in the
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index bee16687dc0b..1e32ab54fc2d 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -373,6 +373,12 @@ static inline void pi_clear_on(struct pi_desc *pi_de=
sc)
>  =09=09(unsigned long *)&pi_desc->control);
>  }
> =20
> +static inline void pi_clear_sn(struct pi_desc *pi_desc)
> +{
> +=09clear_bit(POSTED_INTR_SN,
> +=09=09(unsigned long *)&pi_desc->control);
> +}
> +
>  static inline int pi_test_on(struct pi_desc *pi_desc)
>  {
>  =09return test_bit(POSTED_INTR_ON,
>=20

