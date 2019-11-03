Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664ADCA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 13:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7D22084D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 13:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfKCN1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 08:27:49 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52296 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfKCN1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 08:27:48 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9D80A28A619;
        Sun,  3 Nov 2019 13:27:46 +0000 (GMT)
Date:   Sun, 3 Nov 2019 14:27:41 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org,
        Jeff Kletsky <git-commits@allycomm.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Stefan Roese <sr@denx.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] mtd: spinand: fix detection of GD5FxGQ4xA flash
Message-ID: <20191103142741.7b2a2bf0@collabora.com>
In-Reply-To: <CAJsYDVJgwRfg2kfmuG4P-NCEAZ4box+=Yb53d0J+rAjLRpc3Ww@mail.gmail.com>
References: <20191016013845.23508-1-gch981213@gmail.com>
        <20191028174131.65c3d580@xps13>
        <CAJsYDVJgwRfg2kfmuG4P-NCEAZ4box+=Yb53d0J+rAjLRpc3Ww@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2019 20:03:21 +0800
Chuanhong Guo <gch981213@gmail.com> wrote:

> Hi!
> 
> On Tue, Oct 29, 2019 at 12:41 AM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> >
> > Hello,
> >
> > Chuanhong Guo <gch981213@gmail.com> wrote on Wed, 16 Oct 2019 09:38:24
> > +0800:
> >  
> > > GD5FxGQ4xA didn't follow the SPI spec to keep MISO low while slave is
> > > reading, and instead MISO is kept high. As a result, the first byte
> > > of id becomes 0xFF.
> > > Since the first byte isn't supposed to be checked at all, this patch
> > > just removed that check.
> > >
> > > While at it, redo the comment above to better explain what's happening.
> > >
> > > Fixes: cfd93d7c908e ("mtd: spinand: Add support for GigaDevice GD5F1GQ4UFxxG")
> > > Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> > > CC: Jeff Kletsky <git-commits@allycomm.com>
> > > ---
> > > RFC:
> > > I doubt whether this patch is a proper fix for the underlying problem:
> > > The actual problem is that we have two different implementation of read id
> > > command: One replies immediately after master sending 0x9f and the other
> > > need to send 0x9f and an offset byte (found in winbond and early GD flashes.)  
> 
> Correction: Only early GigaDevice nand chips uses this implementation.
> Winbond chips uses a dummy byte instead of an address byte so there's
> no problem for Winbond chips.
> 
> > > Current code only works if SPI master is properly implemented (i.e. keep MOSI
> > > low while reading.)  
> >
> > I am not entirely against the fix, but this is a SPI host controller
> > issue, right? Can you try to fix the controller driver instead?  
> 
> I think this is a spi nand framework issue. GigaDevice uses an unusual
> READ ID implementation, and as a result, both host controller and chip
> are reading during the first byte after 0x9f command: chip is reading
> the address/offset byte and host is expecting the first ID byte.
> Here lies two problems:
> 1. According to the sequence diagram in their datasheet, MISO pin is
> in High-Z state during the 0x9f command and the offset byte, and host
> could read anything during this time instead of a fixed 0x0 or 0xff
> byte, so the check of first byte should be removed. This is what this
> patch is doing.
> 2. If there's a buggy SPI host controller that didn't keep MOSI low
> during reading operation, the chip will get 0xff as ID offset, causing
> the read vendor/device ID to be swapped. I never met such a controller
> so far, but if there is one, it will be a silicon bug that can't be
> fixed by software. To fix this one, we'll have to make a second
> read-id implementation in spi nand framework.

I realize how fragile this ID-based detection is when manufacturers
decide to not follow the standard READID semantic (one 0x9f command byte
followed by 1 or more input cycles encoding the ID). Let's imagine you
have a valid manuf ID byte in ID[0], and the device ID (ID[1]) matches
the Winbond or Gigadevice manufacturer ID, and ID[3] (extended Device ID
byte?) matches a valid Winbond/Gigadevice device ID. If you skip the
check on ID[0] you might erroneously detect a Winbond or Gigadevice
NAND, while it's actually something else.

Note that I don't really have a solution to make this detection more
robust.

> 
> The second problem only exist in theory, so my preference is to apply
> this patch and fix only the first problem for now.

I think we should fix that problem now. Maybe by doing a 3 steps
detection:

1/ READID + ID[]
2/ READID + DUMMY + ID[]
3/ READID + ADDR + ID[]

At each step we would check if the returned ID matches a valid NAND,
and if it does, stop there.
