Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D26C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D555206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dlycYGQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbfCZRvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:51:53 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43648 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731571AbfCZRvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:51:52 -0400
Received: by mail-ot1-f66.google.com with SMTP id u15so12283185otq.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KiyDnkWhWYhRYjoDxQyl0o/A0cZU/6OscXmEkWKnEdc=;
        b=dlycYGQfTv5Zr19s97fmpUasNL2/gYxa6SYOkwdLgkPtmTvCUHYcBpx9uycBofbrpt
         nHz5/YZiqrSZFZAOc9VSWSBeCGuLtQT7U+m/EjCSyeOdLhWSErGMf5yjZr2wRSXgE517
         XgR1/0Lh3YvBUNuFCfBQJ+HXIXBRHJcIJYPeoSD3HTIB4uGO+1e29V3HhKGQdCh75OXi
         zIcP13mQ6ToDjyvs2i2bpsAW1SHuHZp4otnNRqo39DUEcD46gq7XYL9mPZylg7cFAXcn
         wCDxpiItUGdKYtWvtJKlLlEbcNDF27EldgSDZRbzGzasMpBIMcTgpKSU+GkPNfmUbmlb
         d36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KiyDnkWhWYhRYjoDxQyl0o/A0cZU/6OscXmEkWKnEdc=;
        b=j+HBsDjkYC+5dE3m/DYku4ESw8gP1ySrg2TtMeIGnu9lOvf6Fw/DKV4Q9e6vlFPgTM
         yyvou15gyhZOpgDff0x84DL4oEWIZ2Cs8RdR8tn5dZ62+UhY513RBQJuMhcW8NVHZ2UU
         J+4p4HcmwuFMBux7eM6lPot12sxppNfpc5TtUCuUqJnsWxXwGiCVl6YCtcJl8HxXkJ5T
         wAVYA1dJsgcj2qPqiKDerSmrfuje2vmvTP6Wq+ZoPSk9KPPQxUO8HPOSwrF7SsdxskCM
         mPyEFIMNGGp1hg49D9ia31L8RkTNYy+a5YjUHBF1NcYGMjPTFA4tQ5BS0eJDvuSUNIgI
         s5IA==
X-Gm-Message-State: APjAAAWwxcRAqnuxUh8EQCSe/LZ6FZUWUouzKIzMpDJsuF9O7shgjpY3
        3wysQUVSdFokgdZPXRm9FalzrPNXUSq28424hWebVQ==
X-Google-Smtp-Source: APXvYqwdIX8vBgMvstULYIlGSnL1Qq/4XrxxEmBox67OQUZZ9d5LNIzOXjxf40SrtfjuPhiMMFzoXxdhYormFUfsva4=
X-Received: by 2002:a9d:7342:: with SMTP id l2mr23661446otk.56.1553622711983;
 Tue, 26 Mar 2019 10:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190322133105.5945-1-brgl@bgdev.pl> <20190322133105.5945-2-brgl@bgdev.pl>
 <CAHCN7xJj_aA8XFR6=ZxO-WrfkJRY5fS6NgjHbeqpdfhUnn1apA@mail.gmail.com>
In-Reply-To: <CAHCN7xJj_aA8XFR6=ZxO-WrfkJRY5fS6NgjHbeqpdfhUnn1apA@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 26 Mar 2019 18:51:41 +0100
Message-ID: <CAMpxmJVBTny7kzADSZHQXk_ZUjnRaNWu0Ly3WC8v+zPmR8Dizg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ARM: davinci: fix cpufreq registration on da850-evm
To:     Adam Ford <aford173@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 26 mar 2019 o 15:00 Adam Ford <aford173@gmail.com> napisa=C5=82(a):
>
> On Fri, Mar 22, 2019 at 8:31 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > The system_rev variable is never set on davinci and is always 0, so
> > we're using the default max operating point of 300MHz. The cvdd supply
> > comes from the tps6507 pmic and the voltage can go all the way to 1.3V
> > so the maximum supported rate should be 456MHz.
>
> My understanding is that only certain revisions of the silicon can go
> to 456MHz.   The L138's Datasheet lists both a 456 and 375 version.  I
> cannot find a way to read a register to determine which version of the
> silicon is available. Maybe Sekhar can confirm.
>

Commit 28bd2c341120 ("davinci: am18x/da850/omap-l138 evm: add support
for higher speed grades") mentions the following:

---
U-Boot on the EVM sets up ATAG_REVISION to inform the OS
regarding the speed grade supported by the silicon. We use
this information to pass on the speed grade information to
the SoC code.
---

Should the system_rev somehow reflect that revision? Any way I can check it=
?

Bart

> adam
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  arch/arm/mach-davinci/board-da850-evm.c | 12 +-----------
> >  1 file changed, 1 insertion(+), 11 deletions(-)
> >
> > diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-da=
vinci/board-da850-evm.c
> > index 1fdc9283a8c5..58b2a485b527 100644
> > --- a/arch/arm/mach-davinci/board-da850-evm.c
> > +++ b/arch/arm/mach-davinci/board-da850-evm.c
> > @@ -1155,17 +1155,7 @@ static struct edma_rsv_info *da850_edma_rsv[2] =
=3D {
> >  #ifdef CONFIG_CPU_FREQ
> >  static __init int da850_evm_init_cpufreq(void)
> >  {
> > -       switch (system_rev & 0xF) {
> > -       case 3:
> > -               da850_max_speed =3D 456000;
> > -               break;
> > -       case 2:
> > -               da850_max_speed =3D 408000;
> > -               break;
> > -       case 1:
> > -               da850_max_speed =3D 372000;
> > -               break;
> > -       }
> > +       da850_max_speed =3D 456000;
> >
> >         return da850_register_cpufreq("pll0_sysclk3");
> >  }
> > --
> > 2.20.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
