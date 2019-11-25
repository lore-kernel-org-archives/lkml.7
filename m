Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CD8C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBB320740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfKYOP2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:15:28 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:37333 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbfKYOP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:15:28 -0500
X-Originating-IP: 90.76.211.102
Received: from xps13 (lfbn-1-2154-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 992E44000D;
        Mon, 25 Nov 2019 14:15:24 +0000 (UTC)
Date:   Mon, 25 Nov 2019 15:15:23 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-mtd@lists.infradead.org, Mark Brown <broonie@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bernhard Frauendienst <kernel@nospam.obeliks.de>
Subject: Re: [PATCH v4 3/4] dt-bindings: mtd: Describe mtd-concat devices
Message-ID: <20191125151523.0766b3b7@xps13>
In-Reply-To: <20191118221341.GA30937@bogus>
References: <20191113171505.26128-1-miquel.raynal@bootlin.com>
        <20191113171505.26128-4-miquel.raynal@bootlin.com>
        <20191118221341.GA30937@bogus>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Rob Herring <robh@kernel.org> wrote on Mon, 18 Nov 2019 16:13:41 -0600:

> On Wed, Nov 13, 2019 at 06:15:04PM +0100, Miquel Raynal wrote:
> > From: Bernhard Frauendienst <kernel@nospam.obeliks.de>
> > 
> > The main use case to concatenate MTD devices is probably SPI-NOR
> > flashes where the number of address bits is limited to 24, which can
> > access a range of 16MiB. Board manufacturers might want to double the
> > SPI storage size by adding a second flash asserted thanks to a second
> > chip selects which enhances the addressing capabilities to 25 bits,
> > 32MiB. Having two devices for twice the size is great but without more
> > glue, we cannot define partition boundaries spread across the two
> > devices. This is the gap mtd-concat intends to address.
> > 
> > There are two options to describe concatenated devices:
> > 1/ One flash chip is described in the DT with two CS;
> > 2/ Two flash chips are described in the DT with one CS each, a virtual
> > device is also created to describe the concatenation.
> > 
> > Solution 1/ presents at least 3 issues:
> > * The hardware description is abused;
> > * The concatenation only works for SPI devices (while it could be
> >   helpful for any MTD);
> > * It would require a lot of rework in the SPI core as most of the
> >   logic assumes there is and there always will be only one CS per
> >   chip.  
> 
> This seems ok if all the devices are identical.

This is not an option for Mark and I agree with him as we are faking
the reality: the two devices we want to virtually concatenate may be
two physically different devices. Binding them as one is lying.

> > Solution 2/ also has caveats:
> > * The virtual device has no hardware reality;
> > * Possible optimizations at the hardware level will be hard to enable
> >   efficiently (ie. a common direct mapping abstracted by a SPI
> >   memories oriented controller).  
> 
> Something like this may be necessary if data is interleaved rather than 
> concatinated.

This is something that is gonna happen too, it is called "dual
parallel".

> Solution 3
> Describe each device and partition separately and add link(s) from one 
> partition to the next 
> 
> flash0 {
>   partitions {
>     compatible = "fixed-partitions";
>     concat-partition = <&flash1_partitions>;
>     ...
>   };
> };
> 
> flash1 {
>   flash1_partition: partitions {
>     compatible = "fixed-partitions";
>     ...
>   };
> };

I honestly don't see how this is different as solution 2/? In one case
we describe the partition concatenation in one subnode as a "link", in
the other we create a separate node to describe the link. Are you
strongly opposed as solution 2/? From a pure conceptual point of view,
is it really different than 3/?
 

Thanks,
Miquèl
