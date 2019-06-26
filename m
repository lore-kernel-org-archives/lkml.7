Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F7EC48BD8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F4420663
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bTKfyPyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfFZMYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:24:23 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35641 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZMYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:24:23 -0400
Received: by mail-vs1-f66.google.com with SMTP id u124so1445927vsu.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 05:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CT1Gv4AMdpnoqpjWY2ev6cLuFa53kAL9ZaegsrQDcUw=;
        b=bTKfyPyfUWE9WU0gz42tUqzN3p/2GZckP1UIz2ihopb0QhJTKc9oVGpLDVMmBppyV3
         hnAYcdI355svogcdqWz54JU3DaO7EH24gjLL+UCxBU2NIlFAt7f/oxGPBvLVtfG9nb/k
         nqqoqY6aEuY6mUy6yJ8kDNCKsMDGFYbH+HZisj3GW5vVixuY+8k/9yvhdiofbqivC6iT
         gb3ITTI/wslLqxGkcW7XPYXyoTOYOLx99TAYUDFmhrzkEEsT/K4pAK7WIhl3O5ww6kzW
         D5lFxw+6Ts9Iz9lViwcpz0cSUfzEDMh41S5zgdcU0+mIH/dCxRGE4r3zWrylNOCvXkEU
         G55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CT1Gv4AMdpnoqpjWY2ev6cLuFa53kAL9ZaegsrQDcUw=;
        b=EK2Az47ZpyfLgqxG7sZz0sgS8QOFGY3iVnZcG0HC1WlvLd8PAGARQYtb6D/4KIRxSa
         MzoK8ErDNr589gFtTF8rnDaBexrp5TOKbFdhArMoTWRvG21DJM+0fdX7c3b71t1S4MmD
         Mif6LW33Bkb0qIGA/q2F22rzHo+wiYZExKeRVPKSoM/N17MRo+s6Kgo0oKG/VTAIE7mQ
         ekT7SuHrfJTqpqWQBCZ2xg134YZ0AP+l1UEn7Mr4/hNSvwIhuaIHASFnsP9cCOaojKlr
         8TS2wVE5KGV0G3QPWaUZvfJxZCc+HKQ2WhqxPbTKxipj7FafK/wUrgfg0tLgtZ4psIho
         ThCg==
X-Gm-Message-State: APjAAAUgOnIV/MQzqUGCF9eX5k0Bi6tdouav/ihIJSWVXBKsDr67dCbI
        17XFM+hOT4juXv3jMOjcYVttDx1AT6tOiIpGnry5KQ==
X-Google-Smtp-Source: APXvYqwWhfJFPRJFZc3jcdaHqCNzTd8XU5d9G89vRba9t/r3cKI/rxrN4UtcGcnp3FAa/7lrDQENl0r1gvkUOqZENvw=
X-Received: by 2002:a67:11c1:: with SMTP id 184mr2726115vsr.217.1561551861586;
 Wed, 26 Jun 2019 05:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <1561551539-18251-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1561551539-18251-1-git-send-email-pbonzini@redhat.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 26 Jun 2019 14:24:10 +0200
Message-ID: <CAG_fn=UdN-nPHGBT_t7Dco3287=kGhy5VUOwvKJo4mFY2RZ8Fw@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: degrade WARN to pr_warn_ratelimited
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 2:19 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> This warning can be triggered easily by userspace, so it should certainly=
 not
> cause a panic if panic_on_warn is set.
>
Can you please also add the Reported-by tag here?

Reported-by: syzbot+c03f30b4f4c46bdf8575@syzkaller.appspotmail.com
> Suggested-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Alexander Potapenko <glider@google.com>
> ---
>  arch/x86/kvm/x86.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 83aefd759846..66585cf42d7f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1557,7 +1557,7 @@ static int set_tsc_khz(struct kvm_vcpu *vcpu, u32 u=
ser_tsc_khz, bool scale)
>                         vcpu->arch.tsc_always_catchup =3D 1;
>                         return 0;
>                 } else {
> -                       WARN(1, "user requested TSC rate below hardware s=
peed\n");
> +                       pr_warn_ratelimited("user requested TSC rate belo=
w hardware speed\n");
>                         return -1;
>                 }
>         }
> @@ -1567,8 +1567,8 @@ static int set_tsc_khz(struct kvm_vcpu *vcpu, u32 u=
ser_tsc_khz, bool scale)
>                                 user_tsc_khz, tsc_khz);
>
>         if (ratio =3D=3D 0 || ratio >=3D kvm_max_tsc_scaling_ratio) {
> -               WARN_ONCE(1, "Invalid TSC scaling ratio - virtual-tsc-khz=
=3D%u\n",
> -                         user_tsc_khz);
> +               pr_warn_ratelimited("Invalid TSC scaling ratio - virtual-=
tsc-khz=3D%u\n",
> +                                   user_tsc_khz);
>                 return -1;
>         }
>
> --
> 1.8.3.1
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
