Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D589FC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0E520861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfFQMRI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:17:08 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:43201 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFQMRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:17:07 -0400
X-Originating-IP: 90.88.23.150
Received: from xps13 (aaubervilliers-681-1-81-150.w90-88.abo.wanadoo.fr [90.88.23.150])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C2D7D1BF20C;
        Mon, 17 Jun 2019 12:16:59 +0000 (UTC)
Date:   Mon, 17 Jun 2019 14:16:59 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: rawnand: ingenic: fix ingenic_ecc dependency
Message-ID: <20190617141659.376c0271@xps13>
In-Reply-To: <CAK8P3a28NrvLP1nE7TQUCqwYXVwrSnVUJoH0yTSqRpz93f4g2Q@mail.gmail.com>
References: <20190617111110.2103786-1-arnd@arndb.de>
        <1560770644.1774.0@crapouillou.net>
        <CAK8P3a28NrvLP1nE7TQUCqwYXVwrSnVUJoH0yTSqRpz93f4g2Q@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Arnd Bergmann <arnd@arndb.de> wrote on Mon, 17 Jun 2019 14:12:48 +0200:

> On Mon, Jun 17, 2019 at 1:24 PM Paul Cercueil <paul@crapouillou.net> wrote:
> 
> > I think there's a better way to fix it, only in Kconfig.
> >
> > * Add a bool symbol MTD_NAND_INGENIC_USE_HW_ECC
> > * Have the three ECC/BCH drivers select this symbol instead of
> >   MTD_NAND_INGENIC_ECC
> > * Add the following to the MTD_NAND_JZ4780 config option:
> >   "select MTD_NAND_INGENIC_ECC if MTD_NAND_INGENIC_USE_HW_ECC"  
> 
> I don't see much difference to my approach here, but if you want
> to submit that version with 'Reported-by: Arnd Bergmann <arnd@arndb.de>',
> please do so.
> 
> Yet another option would be to use Makefile code to link both
> files into one module, and remove the EXPORT_SYMBOL statements:
> 
> obj-$(CONFIG_MTD_NAND_JZ4780) += jz4780_nand.o
> jz4780_nand-y += ingenic_nand.o
> jz4780_nand-$(CONFIG_MTD_NAND_INGENIC_ECC) += ingenic_ecc.o
> 

I personally have a preference for this one.

Thanks,
Miquèl
