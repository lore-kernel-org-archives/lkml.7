Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B33C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7181A2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWSPCu7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfDOQaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:30:23 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42070 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfDOQaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:30:22 -0400
Received: by mail-yw1-f67.google.com with SMTP id e76so6226921ywa.9;
        Mon, 15 Apr 2019 09:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jmJTeCCNuzsXQTWNvvDVEtGTkZad8yB68DhpEubY4qk=;
        b=MWSPCu7eLnGKKYiQD5ba21pFh91Etdf3EyCl5G7cT1fVJpEO5a1oftiaJSKMyRnoTg
         pcuIHqe5+2dHQ0tXKadW2d8Jb/2yZGciRmPeDME0uknwJ6skDaKhrWfxeX+vvR//os30
         yO2JvHpaoO6Ct0T+IViPzDNgDBOvhy5yt1HY1+V0amPV36REVzPaUB4SbSfFqSag8mfe
         YOcIl24x70JaoGDevKey/iaddERvCF89eCJoWDkx8csw7niyxYMKTGJlSwTw+QWeYUxt
         rtV8+AxUTLgMyIa8jtjFZOndbot3IqRYputHiepGx4fz90w4yyh3zDhfembExVgMy9uW
         85hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jmJTeCCNuzsXQTWNvvDVEtGTkZad8yB68DhpEubY4qk=;
        b=VISzeWfZ5b9/03H41B+HBdr1+/f0IeMTNt0fpPR/HuU0ql80XPEYqokeTL3oZBF7su
         7lHJx3tTltgwnY9oLdZU8crihGIwCSedkGBv+WPERbpVQqWruUsjQixX6oPbKl0eCoHL
         vAztbriYGiKRk73t140dWapR8TgHNKwIJw++n7RHp99loVoi5eQwwgeeZ8ISzchL3jbS
         iZmm9fwVE2w2KpuZaVuu0S4BV1Ptg1q+Ya9REtg9Ej+u0iaFyXsn0O4fo5jzTRWomxZv
         5XcAZdPFGHawoQuxf3s8jnj9gO4uZ+/nh0QE3UIOFhPQ7MCl6IJwSNtTiPCnxPXDJz24
         UITQ==
X-Gm-Message-State: APjAAAVaMLHKoLZCrvQJCJBFqeJJmZcnXANGjqgDyUHD2PSY5IN0/nGo
        dlKN1ffey4ymGIoBXtKpWbVefaoI4oX1kzFx/Jc=
X-Google-Smtp-Source: APXvYqxRT9bwHk1Prfzd3DmiP5H71iF+NNsQ/ei+bA5QUHeQYxO1F20xhpn/FWltbUK+cwayhtkrVlntNYTh+xx4uQo=
X-Received: by 2002:a81:7509:: with SMTP id q9mr60379351ywc.216.1555345821706;
 Mon, 15 Apr 2019 09:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190411214422.2267-1-peron.clem@gmail.com> <20190411214422.2267-2-peron.clem@gmail.com>
 <20190415080443.frubh4ln4agrdsfe@flea> <CAJiuCcc0Q8rh8u_30gKi8o07k0+e35UR99ZBHtCjx-DPkJEtdw@mail.gmail.com>
 <20190415081816.2pay4pioc5d4mojf@flea> <CAJiuCcedNF0xYSa_+Zfwj-vqYsbjfEpRqisOhEvuitYALMsyjw@mail.gmail.com>
 <20190415145135.fjbcaldwy7w3eqcs@flea>
In-Reply-To: <20190415145135.fjbcaldwy7w3eqcs@flea>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 15 Apr 2019 18:30:10 +0200
Message-ID: <CAJiuCcdrQ64jC8UH1eDKKhFdcOtk=bkWTAzoYOQ1ut3He+j2GQ@mail.gmail.com>
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

On Mon, 15 Apr 2019 at 16:51, Maxime Ripard <maxime.ripard@bootlin.com> wro=
te:
>
> On Mon, Apr 15, 2019 at 10:30:38AM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > On Mon, 15 Apr 2019 at 10:18, Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> > >
> > > On Mon, Apr 15, 2019 at 10:09:11AM +0200, Cl=C3=A9ment P=C3=A9ron wro=
te:
> > > > Hi,
> > > >
> > > > On Mon, 15 Apr 2019 at 10:04, Maxime Ripard <maxime.ripard@bootlin.=
com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Thu, Apr 11, 2019 at 11:44:19PM +0200, Cl=C3=A9ment P=C3=A9ron=
 wrote:
> > > > > > Allwinner H6 has a SPDIF controller with an increase of the fif=
o
> > > > > > size and the possibility to output the master clock.
> > > > > > However it's still compatible with the already existing driver =
for
> > > > > > Allwiner H3.
> > > > > >
> > > > > > Add this compatible in the device-tree bindings documentation.
> > > > >
> > > > > How was this tested?
> > > >
> > > > Using Alsa utils on a Beelink GS1 and I check correct output sound =
on
> > > > my home cinema.
> > > >
> > > > > After looking at the datasheet, it looks like it's still signific=
antly
> > > > > different. In particular:
> > > > >
> > > > >   - The MCLK divider isn't at the same offset
> > > >
> > > > We don't use the MCLK
> > > >
> > > > >   - The bits to flush the FIFO aren't at the same offset
> > > > >   - The FIFO trigger levels aren't at the same offset
> > > > >   - The FIFO status register layout is almost entirely different
> > > >
> > > > We use DMA not FIFO
> > >
> > > Well, DMA still uses the FIFOs. And even then, you're kind of missing
> > > the point. The device tree's compatible is about whether a particular
> > > device can be used as another one. How you are using it in the driver
> > > is completely irrelevant.
> >
> > Sorry I meant " We use DMA not PIO".
>
> I'm still not quite sure what you mean. Both DMA and PIO would be
> using the FIFOs.

Just correcting myself but yes we use FIFO with the DMA.

>
> > I didn't change the driver and the SPDIF is working what's irrelevant
> > in declaring the driver as compatible ?
>
> It's working by accident.
>
> This won't work for example:
> https://elixir.bootlin.com/linux/latest/source/sound/soc/sunxi/sun4i-spdi=
f.c#L181
>
> > If some feature are missing they can be introduce later as there is a
> > special binding for H6 no ?
>
> Again, that's irrelevant. The only question you need to ask yourself
> is whether, if you take an imaginary source code that would support
> all the H3 SPDIF features and run it on an H6, it works just as well.
>
> The examples above that it's not the case, so you can't claim that the
> device is compatible.

Is it ok if I fix the TX Fifo flush bit and remove the compatible with H3 ?
(Looking at the driver this is the only bit used that is incompatible with =
H6)

Or should I send a new driver with the correct mapping ?

Thanks
Cl=C3=A9ment


>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
