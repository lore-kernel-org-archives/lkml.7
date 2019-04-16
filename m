Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F27C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963192087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="unclPDCb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfDPIbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:31:10 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38342 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbfDPIbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:31:10 -0400
Received: by mail-yw1-f68.google.com with SMTP id m207so7008577ywd.5;
        Tue, 16 Apr 2019 01:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eEQlaTx6a1IPdLBFUL3ec/4/KOcVjAAWb+qjQ9zGK6o=;
        b=unclPDCbaqBZ9Iifn/XUyMiM32ZaskXphXsggrN9YgRk9CHhWkosTO7G62ax+/sUx3
         9f3OAzbtAG7p1Su36iQ3NwUzGbANiZYwUJJZpccAQCl66I6H2rgzuGeTD6AhNVBw/YLY
         e0b1bP3nH6IhAaQaKb+lfpAAGLeAN9R3ScwnvEiMS9dz7hGprgHT4Ebjk8c5S6GtDtqf
         1VLTWKjpMPlbttTs1qMhQbIKX813hYvnqt/Nuj5XgEDv4Vx0qVc/PWYFFLYazFA0QKg5
         aucDiiB5X4i9D0DJogzQaNS8doTw/coZcXilc5P/KwOybLu9Luz7LEuHGfUlxDH8xK2X
         /nRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eEQlaTx6a1IPdLBFUL3ec/4/KOcVjAAWb+qjQ9zGK6o=;
        b=TSXzNLYDzDBYq9hfLuBFz3hgY9G4IdiqyWPibwtWmrZRNVRGVNvMBvTRvlYtp+ZSAO
         3b6ldU9Pgh2YHs7bvS8OvRqW5sdJA6PGxgQezWlyFqCQc7/vfXoZx/YTAwQ3dkibGAlB
         UhLtGzyPJQcAxdCBAN4fqwCh10As/JJ6OzRGJEu7W1ayHaCPVRq2A8UkJDOFfi7Z2MtL
         vv+JFev3cWDYAgzEL13hpk3v1uaoZtl5NyW84nBriXyWXzRkJ57N2UE0WaF5eFBv5cHa
         PmrnPsUA9Ulap7DXAZs54VVuLg5gZya4uqeIyuQ7z9VibhbaC/2G4Kz5UaSB6xZBn5om
         kOeg==
X-Gm-Message-State: APjAAAVkL/OlwKAEJRLD5eC9hpM/DWbMYZEgJvQsQVdYP3WF1ANvTBau
        AdZCYkDn8oGrZM/p5ZNYTD7NP8g9UZoMjrD9k/U/NEakkK4=
X-Google-Smtp-Source: APXvYqyxB4ImeU4B6QxiA4vY6IOIKSax8gnqSPIvfOjJ9SVtgtxsRssrvYiT2u4CBIsFGDXzQqUHmBsM7qjW0muKa2k=
X-Received: by 2002:a81:7895:: with SMTP id t143mr63428396ywc.156.1555403468795;
 Tue, 16 Apr 2019 01:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190411214422.2267-1-peron.clem@gmail.com> <20190411214422.2267-2-peron.clem@gmail.com>
 <20190415080443.frubh4ln4agrdsfe@flea> <CAJiuCcc0Q8rh8u_30gKi8o07k0+e35UR99ZBHtCjx-DPkJEtdw@mail.gmail.com>
 <20190415081816.2pay4pioc5d4mojf@flea> <CAJiuCcedNF0xYSa_+Zfwj-vqYsbjfEpRqisOhEvuitYALMsyjw@mail.gmail.com>
 <20190415145135.fjbcaldwy7w3eqcs@flea> <CAJiuCcdrQ64jC8UH1eDKKhFdcOtk=bkWTAzoYOQ1ut3He+j2GQ@mail.gmail.com>
 <20190416073449.qzl3uyjgvjgd3tai@flea>
In-Reply-To: <20190416073449.qzl3uyjgvjgd3tai@flea>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 16 Apr 2019 10:30:58 +0200
Message-ID: <CAJiuCcdXeaXPD9k8QTL3C+CYnMhSgrx-We=s0pVBhS2rprcDNw@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: sound: sun4i-spdif: Add Allwinner H6 compatible
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 16 Apr 2019 at 09:34, Maxime Ripard <maxime.ripard@bootlin.com> wro=
te:
>
> On Mon, Apr 15, 2019 at 06:30:10PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > > > I didn't change the driver and the SPDIF is working what's irreleva=
nt
> > > > in declaring the driver as compatible ?
> > >
> > > It's working by accident.
> > >
> > > This won't work for example:
> > > https://elixir.bootlin.com/linux/latest/source/sound/soc/sunxi/sun4i-=
spdif.c#L181
> > >
> > > > If some feature are missing they can be introduce later as there is=
 a
> > > > special binding for H6 no ?
> > >
> > > Again, that's irrelevant. The only question you need to ask yourself
> > > is whether, if you take an imaginary source code that would support
> > > all the H3 SPDIF features and run it on an H6, it works just as well.
> > >
> > > The examples above that it's not the case, so you can't claim that th=
e
> > > device is compatible.
> >
> > Is it ok if I fix the TX Fifo flush bit and remove the compatible with =
H3 ?
> > (Looking at the driver this is the only bit used that is incompatible w=
ith H6)
>
> Sure
>
> > Or should I send a new driver with the correct mapping ?
>
> No, we definitely don't want to duplicate a driver just for a single
> bit offset that changes.

Thanks for the advice, I will try to submit a new version with this fix.
Clement

>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
