Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DCAC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D16520722
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575303986;
	bh=yldwc/Z6MA1+VHq1mho9ORxlk97SJEe1yTyihqlVpb8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ub91j+EsVeTnu2RQtOXDfFDlRErQVqM+T5h/KneTNTgOYbVBSQfV9lcLVOkSovHnE
	 nb1MJNBVAUinFuh5L+/2OLFAu7gKSwCWoVaADIjMAJV/+R/mgvlvpQvnDgCXETsnyv
	 SC6VFeISIKQnMn8BaS07VlWgG+tqDdaZ8ATNEHtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfLBQ0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 11:26:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:54298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbfLBQ0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 11:26:25 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 144B12073C;
        Mon,  2 Dec 2019 16:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575303984;
        bh=yldwc/Z6MA1+VHq1mho9ORxlk97SJEe1yTyihqlVpb8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fqJ+7zLWZAgiTKrSRyHUV5V0bNtcQm1gNjjnXYlpESE9V6ZrADlt0rtVaNv8PboHD
         HVQyUIrqjDxNUMBeTYHrpWC1yR/Z7pxyQHN4y65J+DslZdEAaFekavSMYzuhwEs5Xk
         1CIlE95uCfuP8sRzTtZ4TAjlXdMnDYvgXLGCDIbc=
Received: by mail-qk1-f181.google.com with SMTP id q28so28530qkn.10;
        Mon, 02 Dec 2019 08:26:24 -0800 (PST)
X-Gm-Message-State: APjAAAUgU5k62SDtdi/6F9lwfBvB3xRID/TYk1iSTNmZQxeYVK9eehKA
        Gp18WdaHP3BSLcV3g9ttSzVyalLzf6XpDkW+Cw==
X-Google-Smtp-Source: APXvYqy+Ji9mce4aB8DbJH5nRjKgp1CutJ2doJc952RWmxbZU8ura3b3pvFQQuFPyXDQLffIiY0xb+L15fjEIsfZvxA=
X-Received: by 2002:a37:81c6:: with SMTP id c189mr33951032qkd.223.1575303983133;
 Mon, 02 Dec 2019 08:26:23 -0800 (PST)
MIME-Version: 1.0
References: <20191113171505.26128-1-miquel.raynal@bootlin.com>
 <20191113171505.26128-4-miquel.raynal@bootlin.com> <20191118221341.GA30937@bogus>
 <20191125151523.0766b3b7@xps13>
In-Reply-To: <20191125151523.0766b3b7@xps13>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 2 Dec 2019 10:26:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJR1OLexi9bArn0ZjNYB+d7eRTYpi4q0-eU93oVcz1AMA@mail.gmail.com>
Message-ID: <CAL_JsqJR1OLexi9bArn0ZjNYB+d7eRTYpi4q0-eU93oVcz1AMA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] dt-bindings: mtd: Describe mtd-concat devices
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bernhard Frauendienst <kernel@nospam.obeliks.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 8:15 AM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Hi Rob,
>
> Rob Herring <robh@kernel.org> wrote on Mon, 18 Nov 2019 16:13:41 -0600:
>
> > On Wed, Nov 13, 2019 at 06:15:04PM +0100, Miquel Raynal wrote:
> > > From: Bernhard Frauendienst <kernel@nospam.obeliks.de>
> > >
> > > The main use case to concatenate MTD devices is probably SPI-NOR
> > > flashes where the number of address bits is limited to 24, which can
> > > access a range of 16MiB. Board manufacturers might want to double the
> > > SPI storage size by adding a second flash asserted thanks to a second
> > > chip selects which enhances the addressing capabilities to 25 bits,
> > > 32MiB. Having two devices for twice the size is great but without mor=
e
> > > glue, we cannot define partition boundaries spread across the two
> > > devices. This is the gap mtd-concat intends to address.
> > >
> > > There are two options to describe concatenated devices:
> > > 1/ One flash chip is described in the DT with two CS;
> > > 2/ Two flash chips are described in the DT with one CS each, a virtua=
l
> > > device is also created to describe the concatenation.
> > >
> > > Solution 1/ presents at least 3 issues:
> > > * The hardware description is abused;
> > > * The concatenation only works for SPI devices (while it could be
> > >   helpful for any MTD);
> > > * It would require a lot of rework in the SPI core as most of the
> > >   logic assumes there is and there always will be only one CS per
> > >   chip.
> >
> > This seems ok if all the devices are identical.
>
> This is not an option for Mark and I agree with him as we are faking
> the reality: the two devices we want to virtually concatenate may be
> two physically different devices. Binding them as one is lying.
>
> > > Solution 2/ also has caveats:
> > > * The virtual device has no hardware reality;
> > > * Possible optimizations at the hardware level will be hard to enable
> > >   efficiently (ie. a common direct mapping abstracted by a SPI
> > >   memories oriented controller).
> >
> > Something like this may be necessary if data is interleaved rather than
> > concatinated.
>
> This is something that is gonna happen too, it is called "dual
> parallel".

Then it would be good to think about how that should look. Maybe
there's overlap or maybe not.

> > Solution 3
> > Describe each device and partition separately and add link(s) from one
> > partition to the next
> >
> > flash0 {
> >   partitions {
> >     compatible =3D "fixed-partitions";
> >     concat-partition =3D <&flash1_partitions>;
> >     ...
> >   };
> > };
> >
> > flash1 {
> >   flash1_partition: partitions {
> >     compatible =3D "fixed-partitions";
> >     ...
> >   };
> > };
>
> I honestly don't see how this is different as solution 2/?

It's a single new property rather than a whole binding for a virtual
device. It's a minimal change to the DT. It would work with existing
bootloaders (and other OSs and older kernels) without change except
for the one concatenated partition.

> In one case
> we describe the partition concatenation in one subnode as a "link", in
> the other we create a separate node to describe the link. Are you
> strongly opposed as solution 2/?

I'd prefer to not have virtual devices without good reason.

> From a pure conceptual point of view,
> is it really different than 3/?
>
>
> Thanks,
> Miqu=C3=A8l
