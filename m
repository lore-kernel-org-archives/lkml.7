Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B67C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5FB2166E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfENUBm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 16:01:42 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:42899 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfENUBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:01:41 -0400
X-Originating-IP: 46.193.9.130
Received: from xps13 (cust-west-pareq2-46-193-9-130.wb.wifirst.net [46.193.9.130])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 8B2F240005;
        Tue, 14 May 2019 20:01:38 +0000 (UTC)
Date:   Tue, 14 May 2019 22:01:36 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Jeff Kletsky <lede@allycomm.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spinand: Add support for GigaDevice GD5F1GQ4UFxxG
Message-ID: <20190514220136.5f4624ee@xps13>
In-Reply-To: <e53a0569-6eca-4385-007d-baffc3f5c7ea@kontron.de>
References: <20190510121727.29834-1-lede@allycomm.com>
        <3cb32209-f246-e562-2aee-fdf566a60b30@kontron.de>
        <1023ba21-b188-1dcc-3ecc-c563d4cb8a67@allycomm.com>
        <e53a0569-6eca-4385-007d-baffc3f5c7ea@kontron.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Schrempf,

Schrempf Frieder <frieder.schrempf@kontron.de> wrote on Tue, 14 May
2019 16:11:28 +0000:

> Hi Jeff,
> 
> On 14.05.19 17:42, Jeff Kletsky wrote:
> > On 5/13/19 6:56 AM, Schrempf Frieder wrote:
> >   
> >> Hi Jeff,
> >>
> >> I just noticed I hit the wrong button and my previous reply was only
> >> sent to the MTD list, so I'm resending with fixed recipients...
> >>
> >> On 10.05.19 14:17,lede@allycomm.com  wrote:  
> >>> From: Jeff Kletsky<git-commits@allycomm.com>
> >>>
> >>> The GigaDevice GD5F1GQ4UFxxG SPI NAND is in current production devices
> >>> and, while it has the same logical layout as the E-series devices,
> >>> it differs in the SPI interfacing in significant ways.
> >>>
> >>> To accommodate these changes, this patch also:
> >>>
> >>>     * Adds support for two-byte manufacturer IDs
> >>>     * Adds #define-s for three-byte addressing for read ops
> >>>
> >>> http://www.gigadevice.com/datasheet/gd5f1gq4xfxxg/
> >>>
> >>> Signed-off-by: Jeff Kletsky<git-commits@allycomm.com>  
> >> Maybe it would be better to split this patch into three parts:
> >> * Add support for two-byte device IDs
> >> * Add #define-s for three-byte addressing for read ops
> >> * Add support for GD5F1GQ4UFxxG
> >>
> >> Anyway the content looks good to me, so:
> >>
> >> Reviewed-by: Frieder Schrempf<frieder.schrempf@kontron.de>
> >>
> >> [...]  
> > 
> > Thanks for the time in review and good words!  
> 
> You're welcome!
> 
> > My apologies for an incomplete git-send-email config that left
> > me nameless in the headers.  
> 
> No problem, I guessed your name from the Signed-off-by tag ;)
> 
> > I wasn't sure if that was direction to submit as three patches
> > at this time, but would be happy to do so if the consensus is
> > that it the direction to follow.  
> 
> I think it's common to separate logical different changes. This makes it 
> easier to read.
> Also the preparation changes only touch the SPI NAND core. I guess 
> that's another reason why they should be separated from the 
> chip-specific changes.
> 
> > At least for me, I feel that the other two don't really stand
> > on their own without the context for their need.  
> 
> I don't think that's a problem. Just add a note to the commit message 
> that these core changes are needed to prepare for the GD5F1GQ4UFxxG support.
> 
> Thanks,
> Frieder

I agree with Frieder, if you don't mind, please split this commit in
three.

Thanks,
Miquèl
