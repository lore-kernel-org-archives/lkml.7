Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425E6C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219FB20675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfLDKR5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 05:17:57 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:52007 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbfLDKR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:17:57 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B85C14000B;
        Wed,  4 Dec 2019 10:17:52 +0000 (UTC)
Date:   Wed, 4 Dec 2019 11:17:51 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-mtd@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Bernhard Frauendienst <kernel@nospam.obeliks.de>
Subject: Re: [PATCH v5 4/4] mtd: Add driver for concatenating devices
Message-ID: <20191204111751.5383b426@xps13>
In-Reply-To: <690065a2-619d-3f97-30c6-5dea76896d78@ti.com>
References: <20191127105522.31445-1-miquel.raynal@bootlin.com>
        <20191127105522.31445-5-miquel.raynal@bootlin.com>
        <690065a2-619d-3f97-30c6-5dea76896d78@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

Vignesh Raghavendra <vigneshr@ti.com> wrote on Wed, 4 Dec 2019 15:28:46
+0530:

> Hi Miquel,
> 
> On 27/11/19 4:25 pm, Miquel Raynal wrote:
> > Introduce a generic way to define concatenated MTD devices. This may
> > be very useful in the case of ie. stacked SPI-NOR. Partitions to
> > concatenate are described in an additional property of the partitions
> > subnode:
> > 
> >         flash0 {
> >                 partitions {
> >                         compatible = "fixed-partitions";
> >                         part-concat = <&flash0_part1>, <&flash1_part0>;
> > 
> > 			part0@0 {
> > 				label = "part0_0";
> > 				reg = <0x0 0x800000>;
> > 			};
> > 
> > 			flash0_part1: part1@800000 {
> > 				label = "part0_1";
> > 				reg = <0x800000 0x800000>;
> > 			};
> >                 };
> >         };  
> 
> IIUC flash0 and flash1 are subnodes of a SPI master node?
> And I believe flash0 node's compatible is "jedec,spi-nor"?

Indeed this is one possibility (probably the most common) but in theory
this should work for any kind of MTD device, hence I voluntarily
dropped the hardware-specific properties to focus on the partitions
description here.

> 
> 
> > 
> >         flash1 {
> >                 partitions {
> >                         compatible = "fixed-partitions";
> > 
> > 			flash0_part1: part1@0 {  
> 
> s/flash0_part1/flash1_part0?

Right!

> 
> > 				label = "part1_0";
> > 				reg = <0x0 0x800000>;
> > 			};
> > 
> > 			part0@800000 {
> > 				label = "part1_1";
> > 				reg = <0x800000 0x800000>;
> > 			};
> >                 };
> >         };
> >   
> 
> For my understanding, how many /dev/mtdX entries would this create?

If the master is retained (Kconfig option) and thanks to the common
partitioning scheme, we would have:
* flash0 (mtd0)
*   part0_0 (mtd1)
*   part0_1 (mtd2)
* flash1 (mtd3)
*   part1_0 (mtd4)
*   part1_1 (mtd5)

If we enable this driver, we would also get an additional device:
* mtd2-mtd4-concat (or part0_1-part1_0-concat, I don't recall the exact
  name) being mtd6.


Thanks,
Miquèl
