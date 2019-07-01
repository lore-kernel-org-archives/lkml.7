Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30A2C06511
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64EC213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbfGAKFC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:05:02 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:39969 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfGAKFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:05:02 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 4E933C0009;
        Mon,  1 Jul 2019 10:04:55 +0000 (UTC)
Date:   Mon, 1 Jul 2019 12:04:54 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Piotr Sroka <piotrs@cadence.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Marcel Ziswiler" <marcel.ziswiler@toradex.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stefan Agner <stefan@agner.ch>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] mtd: nand: Add Cadence NAND controller driver
Message-ID: <20190701120454.6c8ac48e@xps13>
In-Reply-To: <20190701095143.GA21903@global.cadence.com>
References: <20190219161406.4340-1-piotrs@cadence.com>
        <20190219161823.22466-1-piotrs@cadence.com>
        <20190305190954.6c38d681@xps13>
        <20190321093356.GA19577@global.cadence.com>
        <20190512142426.11453a6c@xps13>
        <20190606151948.GA10565@global.cadence.com>
        <20190627181542.131aa061@xps13>
        <20190701095143.GA21903@global.cadence.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Piotr,

Piotr Sroka <piotrs@cadence.com> wrote on Mon, 1 Jul 2019 10:51:45
+0100:


[...]
> >> >> >
> >> >> >This driver is way too massive, I am pretty sure it can shrink a
> >> >> >little bit more.
> >> >> >[...]
> >> >> >  
> >> >> I will try to make it shorer but it will be difucult to achive. It is because - there are a lot of calculation needed for PHY      - ECC are interleaved with data (like on marvell-nand or gpmi-nand).
> >> >>    Therefore:    + RAW mode is complicated    + protecting BBM increases number of lines of source code
> >> >> - need to support two DMA engines internal and external (slave) We will see on next patch version what is the result.      That page layout looks:  
> >> >
> >> >Maybe you don't need to support both internal and external DMA?
> >> >
> >> >I am pretty sure there are rooms for size reduction.  
> >>
> >> I describe how it works in general and maybe you help me chose better solution.
> >>
> >> HW controller can work in 3 modes. PIO - can work in master or slave DMA
> >> CDMA - needs Master DMA for accessing command descriptors.
> >> Generic mode - can use only Slave DMA.
> >>
> >> Generic mode is neccessery to implement functions other than page
> >> program, page read, block erase. So it is essential. I cannot avoid
> >> to use Slave DMA.  
> >
> >This deserves a nice comment at the top.  
> Ok I will add the modes description to cover letter. >

Not only to the cover letter: People read the code. Interested people
might also read the commit log which is quite easy to find. The cover
letter however will just disappear in the history of the Internet. I
would rather prefer you explain how the IP works at the top of the
driver.


Thanks,
Miquèl
