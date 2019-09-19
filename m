Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8619C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8927D21907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUMy0gQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391376AbfISPmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:42:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47790 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389646AbfISPmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568907724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=jtOOTxtBSH0XScdrTXtYNsOa16spVRV1/m7O55QYuzg=;
        b=jUMy0gQ8/mVPTz2Ib5EUA10pvBOKrCyIP7ZwsamO3Zx+YCJgaQAJfG3ErQhC2k1B0n+pj1
        aTw3JJ2hv3bMiA6/8em4xtv5dJg8G9myzy7c/sevGboLFpW8dAsvtgMd0FjZO7xvygAjuF
        ZvP0aAp74aC31grTfvqat1DA6hSSx28=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-DkEixw0iMGqyYQCATYbj-Q-1; Thu, 19 Sep 2019 11:41:56 -0400
Received: by mail-wm1-f70.google.com with SMTP id n3so1999307wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 08:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bAINjjRSlbUTjobcIGuJ8vNAwyPobHG3I1/jgsCdgXw=;
        b=fbN0lmI9qB6FUKRhQMpbBGhDQymC/j+5d8njAkjjs6+w+IrCMNYKdrKHf+wQnGZMBO
         XSwN5lEBrPXmJ8u6Wu0Tp9H3OIKX2FAJayokDawbC1IU5JbeaErN6/0eEcOw/pDPl/DK
         8OcktscDDqDovVEKXZ2iXSQAChBNBpgbqJORNIe+FP5b51D02+0xM2WKaYxZYgd+D8II
         0SH9KDQtbTcOaAhT6VvZ17m7c6L+XXJPCQ2bRvDU211HJDfaRv2//wj12QV9uKhaZi1a
         jGeVN7tJPT9PJ+tSIcLAhY2A2g9CTpu1fmuZdw0nHd0C3r9JGsWyMa508eGyAZpxKWPk
         XXAA==
X-Gm-Message-State: APjAAAWaTKsn1ZSMf/Ybbl12JSr8tYeRw00J+t4ZgwJhb0osqE4FOIZX
        GR8P/YPncbB0OUgMIlZuR+t6bUX23Cv2OojpTmcyas7xKqhWDCRhcsVycnZrQxZYjkyAuF31yBa
        9MC+VRrUpCLlymF5kTOKYB9wm
X-Received: by 2002:adf:e488:: with SMTP id i8mr7375473wrm.20.1568907653242;
        Thu, 19 Sep 2019 08:40:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwR9KVma4Xblc47G5SpP/XvO6PKkeiTk0NhW+haXvKEfP9pKSHtsHzJm0BanCJIZYw+ZParUA==
X-Received: by 2002:adf:e488:: with SMTP id i8mr7375450wrm.20.1568907652977;
        Thu, 19 Sep 2019 08:40:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8? ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
        by smtp.gmail.com with ESMTPSA id t6sm9820328wmf.8.2019.09.19.08.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 08:40:52 -0700 (PDT)
Subject: Re: [RFC patch 15/15] x86/kvm: Use GENERIC_EXIT_WORKPENDING
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20190919150314.054351477@linutronix.de>
 <20190919150809.964620570@linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ef1145d8-01af-57d2-1065-cf12db16e422@redhat.com>
Date:   Thu, 19 Sep 2019 17:40:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919150809.964620570@linutronix.de>
Content-Language: en-US
X-MC-Unique: DkEixw0iMGqyYQCATYbj-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/19 17:03, Thomas Gleixner wrote:
> Use the generic infrastructure to check for and handle pending work befor=
e
> entering into guest mode.
>=20
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Subject should be "x86/kvm: use exit_to_guestmode".

Paolo

> ---
>  arch/x86/kvm/x86.c |   17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>=20
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -52,6 +52,7 @@
>  #include <linux/irqbypass.h>
>  #include <linux/sched/stat.h>
>  #include <linux/sched/isolation.h>
> +#include <linux/entry-common.h>
>  #include <linux/mem_encrypt.h>
> =20
>  #include <trace/events/kvm.h>
> @@ -7984,8 +7985,8 @@ static int vcpu_enter_guest(struct kvm_v
>  =09if (kvm_lapic_enabled(vcpu) && vcpu->arch.apicv_active)
>  =09=09kvm_x86_ops->sync_pir_to_irr(vcpu);
> =20
> -=09if (vcpu->mode =3D=3D EXITING_GUEST_MODE || kvm_request_pending(vcpu)
> -=09    || need_resched() || signal_pending(current)) {
> +=09if (vcpu->mode =3D=3D EXITING_GUEST_MODE || kvm_request_pending(vcpu)=
 ||
> +=09    exit_to_guestmode_work_pending()) {
>  =09=09vcpu->mode =3D OUTSIDE_GUEST_MODE;
>  =09=09smp_wmb();
>  =09=09local_irq_enable();
> @@ -8178,17 +8179,9 @@ static int vcpu_run(struct kvm_vcpu *vcp
> =20
>  =09=09kvm_check_async_pf_completion(vcpu);
> =20
> -=09=09if (signal_pending(current)) {
> -=09=09=09r =3D -EINTR;
> -=09=09=09vcpu->run->exit_reason =3D KVM_EXIT_INTR;
> -=09=09=09++vcpu->stat.signal_exits;
> +=09=09r =3D exit_to_guestmode(kvm, vcpu);
> +=09=09if (r)
>  =09=09=09break;
> -=09=09}
> -=09=09if (need_resched()) {
> -=09=09=09srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
> -=09=09=09cond_resched();
> -=09=09=09vcpu->srcu_idx =3D srcu_read_lock(&kvm->srcu);
> -=09=09}
>  =09}
> =20
>  =09srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
>=20
>=20

