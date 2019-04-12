Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32D0C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910C320663
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u4Cy4/Ez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfDLSls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:41:48 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36736 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDLSls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 14:41:48 -0400
Received: by mail-it1-f193.google.com with SMTP id y10so17286642itc.1;
        Fri, 12 Apr 2019 11:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mIbNeCXu/LdCT/cLP2TcZCktfE6Iop/eAvDTGl1i36k=;
        b=u4Cy4/EzP9o8IwAAXyMmBTlG3Ptk9YGNYSgPC/Q+D9SgdqdOhIGx8dbL1pcdeYi/lZ
         zIHGrhFRiUzkZ9Aw4rw06iDJ2VdUx813pkq5YsDHD7LAYjrb9rRBinbzKQNdItqQ0M4K
         XOVxgZmMS2/cGxTa88447OhOsnsYoKtYVL3Lb/b1R+/wfeP6Mt/FIpc5aWQEQ173N9+C
         zzDqLfOBTzMj5OjRDaB+iHcTG1TkbklOy6F1hwdrTUfIgDjWDFkPQAx0kGNt+ot+uxes
         /J17602+uEtL3yorfsxOa+w/Qg6KTMYid2vTiy2bshAS96snKYq4Dsv6B0dO9xTdGTKY
         U03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mIbNeCXu/LdCT/cLP2TcZCktfE6Iop/eAvDTGl1i36k=;
        b=MwxWFEbQPJWoxNYaBLIxRfwbgCeTzy3UeEz+IhTpsNiJJAKTR1jZNjPF/WRmLhOIZ9
         b0H1X9iyU5+VUCUU+bnQs3sp3VbpzoCTouWHvwnKMJmofI9IEA6Nawc4dhpQDU7eeCkq
         zfqxlyN6NHfm9gzfgVPECkZ0/Ux0XzJKeFxuPrZvAinXGC/6PYJeRIpezm2szcHjS9Go
         5zVPWIGqln/iZ/8PYz85vXPWAyNN8CJ9QbvAhvweykE55lnjviqNkLm6p+Z7Xys0FSK2
         REvRaIenCPjwDyzIsSbkRAWjpUmU+vu9pjLsqgL1p7K3Sc5pOddfA0If23MxjBCz6MA1
         Dz+w==
X-Gm-Message-State: APjAAAUR3D5z4JsoNv963HT/DMWPS4Lvqgo61nfgxuXGuT+ee9TNnj2T
        +D3meJwGjvIAdcoiYw9AO/OcVto9U53meaCTk+c=
X-Google-Smtp-Source: APXvYqx+nW+QHcsFD3i9vJEF9/4nRgoQs4nDxjoV9ZO2WO0LMLwHVLZAkr1M38WVntrKFGd//ROlO53aqaTtooYpyyU=
X-Received: by 2002:a24:4acd:: with SMTP id k196mr14854009itb.101.1555094507488;
 Fri, 12 Apr 2019 11:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190411205144.43557-1-jeffrey.l.hugo@gmail.com> <20190412180142.GZ1843@tuxbook-pro>
In-Reply-To: <20190412180142.GZ1843@tuxbook-pro>
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date:   Fri, 12 Apr 2019 12:41:36 -0600
Message-ID: <CAOCk7NrRb=CZiZp6LKmP9yFZzWTO6AaRt4aZ5dyoVxBw4ZA9_w@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: Add Lenovo Miix 630
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, David Brown <david.brown@linaro.org>,
        robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 12:01 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 11 Apr 13:51 PDT 2019, Jeffrey Hugo wrote:
> > diff --git a/arch/arm64/boot/dts/qcom/msm8998-clam.dtsi b/arch/arm64/boot/dts/qcom/msm8998-clam.dtsi
> [..]
> > +&tlmm {
> > +     gpio-reserved-ranges = <0 4>, <81 4>;
>
> Did you double check that you actually need these? (Iirc boot testing is
> enough)

Yes, still needed.

>
> > +
> > +     touchpad: touchpad {
> > +             config {
> > +                     pins = "gpio123";
> > +                     bias-pull-up;           /* pull up */
> > +             };
> > +     };
> > +};
> [..]
> > diff --git a/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts b/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
> [..]
> > +/ {
> > +     model = "Lenovo Miix 630";
> > +     compatible = "qcom,msm8998-clam";
>
> compatible = "lenovo,miix-630", "qcom,msm8998";

Thanks for the suggestion.  Will do.

>
> > +
> > +     /* bootloader doesn't understand DT, so no qcom,board-id */
>
> You can omit this comment, as I don't think people will miss these
> non-standard properties.

Makes sense.  Will do.
