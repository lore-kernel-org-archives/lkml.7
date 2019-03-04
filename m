Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C38C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0618C2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfCDSOE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:14:04 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:46027 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfCDSOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:14:04 -0500
Received: from xps13 (136.87.136.77.rev.sfr.net [77.136.87.136])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 84F80240003;
        Mon,  4 Mar 2019 18:13:56 +0000 (UTC)
Date:   Mon, 4 Mar 2019 19:13:49 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        "Richard Weinberger" <richard@nod.at>,
        Schrempf Frieder <frieder.schrempf@kontron.De>,
        Marek Vasut <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>
Subject: Re: [EXT] Re: [PATCH 2/2] mtd: spinand: micron: Support for all
 Micron SPI NAND flashes
Message-ID: <20190304191349.71f8b147@xps13>
In-Reply-To: <MN2PR08MB5951EE4ACB78BAD12EDA5F76B8710@MN2PR08MB5951.namprd08.prod.outlook.com>
References: <MN2PR08MB5951FD3B8244ABBA72FF7430B86D0@MN2PR08MB5951.namprd08.prod.outlook.com>
        <20190204190151.2c7987b7@bbrezillon>
        <MN2PR08MB5951EE4ACB78BAD12EDA5F76B8710@MN2PR08MB5951.namprd08.prod.outlook.com>
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

"Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com> wrote on
Mon, 4 Mar 2019 13:29:21 +0000:

> Hi Boris,
> 
> > -----Original Message-----
> > From: Boris Brezillon <bbrezillon@kernel.org>
> > Sent: Monday, February 4, 2019 7:02 PM
> > To: Shivamurthy Shastri (sshivamurthy) <sshivamurthy@micron.com>
> > Cc: Miquel Raynal <miquel.raynal@bootlin.com>; linux-
> > mtd@lists.infradead.org; linux-kernel@vger.kernel.org; Chuanhong Guo
> > <gch981213@gmail.com>; Richard Weinberger <richard@nod.at>; Schrempf
> > Frieder <frieder.schrempf@kontron.De>; Marek Vasut
> > <marek.vasut@gmail.com>; Frieder Schrempf
> > <frieder.schrempf@exceet.de>; Brian Norris
> > <computersforpeace@gmail.com>; David Woodhouse
> > <dwmw2@infradead.org>; Bean Huo (beanhuo) <beanhuo@micron.com>
> > Subject: [EXT] Re: [PATCH 2/2] mtd: spinand: micron: Support for all Micron
> > SPI NAND flashes
> > 
> > Hi Shivamurthy,
> > 
> > On Mon, 4 Feb 2019 11:17:51 +0000
> > "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com> wrote:
> >   
> > > Driver is redesigned using parameter page to support all the Micron
> > > SPI NAND flashes.  
> > 
> > Do all Micron SPI NANDs really expose a valid ONFI param page? If
> > that's not the case, then relying on ONFi parsing only sounds like a
> > bad idea.  
> 
> Micron SPI NAND datasheet does not confirm to be as ONFI standard.
> However, they all expose parameter page, which I used for development.
> 
> >   
> > >
> > > Parameter page of Micron flashes is similar to ONFI parameter table and
> > > functionality is same, so copied some of the common functions like crc16
> > > and bit_wise_majority from nand_onfi.c.  
> > 
> > Most of the code is generic and does not depend on the spinand layer,
> > plus, we already have ONFI param page parsing code in
> > drivers/mtd/nand/raw/ which you're intentionally duplicating in a
> > version that will not be re-usable by the raw NAND layer even after
> > converting it to use the generic NAND layer.
> > 
> > Please move ONFi parsing code to drivers/mtd/nand/onfi.c and make it
> > generic.  
> 
> As I said before, it is not compliant to ONFI standard, I think it is better not 
> to make it generic.

For what I see it is too similar to copy all that code. I agree with
Boris. If there are some specificities that are not in the ONFI
standard you can do some late changes in the parameter page from
Micron's driver I guess?


Thanks,
Miquèl
