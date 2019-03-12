Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A3AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A405420842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOkMmeIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfCLDQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:16:10 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35113 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfCLDQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:16:09 -0400
Received: by mail-io1-f65.google.com with SMTP id x4so825991ion.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 20:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qV19cx/no3krlzmu8F5yDuKky1IXJ7hYpJG7hP+/MQE=;
        b=qOkMmeIXQTwzVrXmLtCwTVdqkfw00r25d8WPfM+yNPErcgdYP2/1fHjZHtUXcfSF9a
         aVlYJSEE+g1biH4aKWLMj9KEcyp9R4qEknISUb9Ym7bl6N+hjayp/z0JHo+8FDP+rHdm
         e61TxYJE5/IkI8PGZSvpiF+xpXSO90t08Yg4YRCUbYvMYF/ombPJ4t0N1x9XcSha3/LF
         UxLT1mN62iGr8Z4wsO8IdkeiDUd0xAJsxi8In0sobNqAQQ+O1L4jyOqagbq7K89EHtSZ
         tUd0meJSZf5TsIgT2e/0iYIXIuyK/y5YNMCP/L552WCR17QPFq3kmhHA3nsljTfre4+s
         L9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qV19cx/no3krlzmu8F5yDuKky1IXJ7hYpJG7hP+/MQE=;
        b=ZMEcSgDZ+gUr+gQD0+v/h7bsdr13aVixLr0wYfHRy3j+UEKjeviGQLOqQT79TIviKp
         zikmIRKh+7nn32f0k/DoEPwp1ApC/ecGGygftWhumHXVbotKiD/BZ329OT99z+Jt9pnJ
         YuTeXej2qMXBRQG6msRCHOz5Onmzw5vWtl1JM8G5SBVqzr/bbL6NyTiBC7haxUSL+IBR
         Z4v2qdfEN00mTdaIO+ptFQ3lD7Y0bQDdbeAPPl82J8FnCeRybaTM7HOwVsqZPbe23DpS
         tTgprjz+xpTZI7CCJgtM4LL8mQ9WPzDtxQa++sTEMELBUFmogM1OwZF09/I6AY8B6Avp
         ZTQQ==
X-Gm-Message-State: APjAAAWI2ES1N6tOJUR/XkbJtechspmNdnvwZGGh5EuXXoZCRIqtq4H5
        8my5a5n395NaaSOvO7z+popr4G1GegV4kaM2qaNeNJI=
X-Google-Smtp-Source: APXvYqyGLkx52sdvm/1nndBPCl4OdBJHrcDJBkOf+OO5NeEyHLGp0aMP8K+r+edM61nRY9DLkWISmB+6CVgYGXgstzk=
X-Received: by 2002:a5e:c906:: with SMTP id z6mr18234775iol.47.1552360568282;
 Mon, 11 Mar 2019 20:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190312003243.6712-1-johngong0791@gmail.com> <2405014d-9370-c0d5-7a44-7ec336098c45@arm.com>
In-Reply-To: <2405014d-9370-c0d5-7a44-7ec336098c45@arm.com>
From:   Gong John <johngong0791@gmail.com>
Date:   Tue, 12 Mar 2019 11:15:14 +0800
Message-ID: <CAEg8mkxRj2jQSqnuqY239yDH3a4mkvabg+_6Q8+9Nd=mk+U2pw@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: fix potential bug
To:     =?UTF-8?Q?Andr=C3=A9_Przywara?= <andre.przywara@arm.com>
Cc:     christoffer.dall@arm.com, Shengmin Gong <shengmin.gong@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Jia He <hejianet@gmail.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,
On Tue, Mar 12, 2019 at 9:44 AM Andr=C3=A9 Przywara <andre.przywara@arm.com=
> wrote:
>
> On 12/03/2019 00:32, John Gong wrote:
> Hi,
>
> > Since intid always >=3D VGIC_NR_PRIVATE_IRQS,
>
> How so? The PMU and the arch timer emulation use PPIs, so intid is
> definitely < VGIC_NR_PRIVATE_IRQS there.
>
> > so then even vcpu =3D=3D NULL, it never return -EINVAL.
>
> I am not sure I follow.
> To uniquely identify an SPI interrupt, we just need the interrupt ID
> (which is always >=3D 32). For PPIs and SGIs, we additionally need the
> vCPU ID this private interrupt belongs to, as there are multiple
> interrupts with the same INTID (one per VCPU).
> The VCPU ID passed in for SPIs is just a dummy value (because we use the
> same function to inject private and shared interrupts), so we don't need
> to check for its validity.
>
> Cheers,
> Andre.
>
Thanks for your explanation. It's my fault to not consider the PPIs
and SGIs injection.
Sorry for polluting the mail list.

Cheers,
John Gong
> >
> > Signed-off-by: Shengmin Gong <shengmin.gong@gmail.com>
> > Signed-off-by: John Gong <johngong0791@gmail.com>
> > ---
> >  virt/kvm/arm/vgic/vgic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
> > index abd9c7352677..d3cb1ce880e2 100644
> > --- a/virt/kvm/arm/vgic/vgic.c
> > +++ b/virt/kvm/arm/vgic/vgic.c
> > @@ -424,7 +424,7 @@ int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid,=
 unsigned int intid,
> >               return ret;
> >
> >       vcpu =3D kvm_get_vcpu(kvm, cpuid);
> > -     if (!vcpu && intid < VGIC_NR_PRIVATE_IRQS)
> > +     if (!vcpu)
> >               return -EINVAL;
> >
> >       irq =3D vgic_get_irq(kvm, vcpu, intid);
> >
>
