Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F484C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AC721019
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfELRkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 13:40:45 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:34489 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfELRkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:40:45 -0400
X-Originating-IP: 46.193.9.130
Received: from localhost (cust-west-pareq2-46-193-9-130.wb.wifirst.net [46.193.9.130])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 9D7A3C0006;
        Sun, 12 May 2019 17:40:34 +0000 (UTC)
Date:   Sun, 12 May 2019 19:40:33 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     "U.Mutlu" <um@mutluit.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Chen-Yu Tsai <wens@csie.org>,
        linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        u-boot@lists.denx.de, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Pablo Greco <pgreco@centosproject.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oliver Schinagl <oliver@schinagl.nl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        FUKAUMI Naoki <naobsd@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [RFC PATCH] drivers: ata: ahci_sunxi: Increased SATA/AHCI DMA
 TX/RX FIFOs
Message-ID: <20190512174033.znvtaa5yvhpcmnna@flea>
References: <20190510192550.17458-1-um@mutluit.com>
 <20190512121245.l3cvg4std6yanwix@flea>
 <5CD844F3.5080103@mutluit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5CD844F3.5080103@mutluit.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, May 12, 2019 at 06:08:19PM +0200, U.Mutlu wrote:
> Hi Maxime & Others,
>
> what follows is a somewhat lengthy technical story behind this patch;
> you can just skip it and jump to the end.
>
>
> As can be seen in the ahci_sunxi.c, the port used in this patch
> is this one (32bit):
>   #define AHCI_P0DMACR    0x0170
> It's a so called "Vendor Specific Port" according to the SATA/AHCI specs by Intel.
> The data behind it is actually a struct, consisting of 4 fields,
> each 4bits long, plus a 16bits long field that is marked as Reserved
> in secondary literature (see below):
>
> struct AHCI_P0DMACR_t
> {
>   unsigned TXTS  : 4,
>            RXTS  : 4,
>            TXABL : 4,
>            RXABL : 4,
>            Res1  : 16;
> };
>
> This struct is just my creation for my own tests as it's not part of the
> driver source. The patch touches only the first 2 fields: TXTS and RXTS.
>
> See this similar product documentation by Texas Instruments for the above struct:
> https://www.ti.com/lit/ug/sprugj8c/sprugj8c.pdf
> TMS320C674x/OMAP-L1x Processor, Serial ATA (SATA) Controller, User's Guide,
> Literature Number: SPRUGJ8C, March 2011,
> Page 68, Chapter 4.33 "Port DMA Control Register (P0DMACR)"
>
> The above TI document describes the two fields as follows:
>
> TXTS:
>   Transmit Transaction Size (TX_TRANSACTION_SIZE). This field defines the
> DMA transaction size in
>   DWORDs for transmit (system bus read, device write) operation. [...]
>
> RXTS:
>   Receive Transaction Size (RX_TRANSACTION_SIZE). This field defines the
> Port DMA transaction size
>   in DWORDs for receive (system bus write, device read) operation. [...]
>
>
> So, in my patch the fields TXTS and RXTS are set to 3 each.
> Without the patch, these fields seem to have some random content
> (I'vee seen 5 and 6, 4 and 4, and 0 and 0 on different devices),
> as the previous code doesn't touch these 2 fields (ie. these two fields
> are not within the used old mask of 0xff00; cf. ahci_sunxi.c, function
> ahci_sunxi_start_engine(...)).
>
>
> Some background story in my hunt for obtaining product documentation:
>
> I couldn't find any product documentation for the SATA/AHCI
> in these SoCs by Allwinner Technology (allwinnertech.com),
> unlike with such products from other such companies.
>
> I asked Allwinner, but they just said that the A20 of my SBC
> would (allegedly) no more be actual and that the support for it
> has ended (but this statement somehow cannot be true as the
> A20 SoC is still continued being marketed at their website).
> They instead sent me a bunch of really irrelevant PDFs which have
> nothing to do with SATA/AHCI.
>
> So, the company Allwinner Technology unfortunately was not cooperative
> to provide me information on their SATA/AHCI-implementation in their SoCs :-(
> Even the ports used in the actual ahci_sunxi.c in the linux tree are undocumented;
> it is even commented with "/* This magic is from the original code */"
> and below it many ports are used for which no documentation is available,
> or at least I couldn't find any on the Internet. And the initial programmer
> in 2014 and prior was Daniel Wang (danielwang@allwinnertech.com),
> but email to that address bounces.
>
> So, I was forced to research secondary literature from other vendors
> like Texas Instruments (thanks TI !) and Intel, and also studying
> very old source codes in the old Linux repositories (as it differs
> much from the current version) going back to the year 2014, and had
> to do many (blind) experiments until I found this solution.
>
> The above given User's Guide by Texas Instruments (and their such
> documents for their newer such products) helped me much to find the solution.
> It's of course not really the correct documentation for the Allwinner SoCs,
> but still better than nothing.
>
> If I only had the right documentation, then I for sure could try
> to further improve that already achieved result by this patch,
> as with SATA-II upto 300 MiB/s is possible.
>
>
> Yes, I'll resend the patch with some appropriate comments.

That's awesome research and explanation, thanks! :)

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
