Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF38C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 07:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E322077C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 07:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfGQHzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 03:55:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41086 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfGQHzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 03:55:31 -0400
Received: from pc-375.home (2a01cb0c88d94a005820d607da339aae.ipv6.abo.wanadoo.fr [IPv6:2a01:cb0c:88d9:4a00:5820:d607:da33:9aae])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id AD5B2261FA0;
        Wed, 17 Jul 2019 08:55:28 +0100 (BST)
Date:   Wed, 17 Jul 2019 09:55:25 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        Srikanth Vemula <svemula@xilinx.com>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>
Subject: Re: [LINUX PATCH v18 1/2] mtd: rawnand: nand_micron: Do not over
 write driver's read_page()/write_page()
Message-ID: <20190717095525.6e2e9730@pc-375.home>
In-Reply-To: <DM6PR02MB4779307E32670683AE9F60D6AFC90@DM6PR02MB4779.namprd02.prod.outlook.com>
References: <20190716053051.11282-1-naga.sureshkumar.relli@xilinx.com>
        <20190716093137.3d8e8c1f@pc-375.home>
        <20190716094450.122ba6e7@pc-375.home>
        <DM6PR02MB4779307E32670683AE9F60D6AFC90@DM6PR02MB4779.namprd02.prod.outlook.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2019 05:33:35 +0000
Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:

> Hi Boris,
> 
> > -----Original Message-----
> > From: Boris Brezillon <boris.brezillon@collabora.com>
> > Sent: Tuesday, July 16, 2019 1:15 PM
> > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > Cc: miquel.raynal@bootlin.com; bbrezillon@kernel.org; richard@nod.at;
> > dwmw2@infradead.org; computersforpeace@gmail.com; marek.vasut@gmail.com;
> > vigneshr@ti.com; yamada.masahiro@socionext.com; linux-mtd@lists.infradead.org; linux-
> > kernel@vger.kernel.org; Michal Simek <michals@xilinx.com>; Srikanth Vemula
> > <svemula@xilinx.com>; nagasuresh12@gmail.com
> > Subject: Re: [LINUX PATCH v18 1/2] mtd: rawnand: nand_micron: Do not over write
> > driver's read_page()/write_page()
> > 
> > On Tue, 16 Jul 2019 09:31:37 +0200
> > Boris Brezillon <boris.brezillon@collabora.com> wrote:
> >   
> > > On Mon, 15 Jul 2019 23:30:51 -0600
> > > Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:
> > >  
> > > > Add check before assigning chip->ecc.read_page() and
> > > > chip->ecc.write_page()
> > > >
> > > > Signed-off-by: Naga Sureshkumar Relli
> > > > <naga.sureshkumar.relli@xilinx.com>
> > > > ---
> > > > Changes in v18
> > > >  - None
> > > > ---
> > > >  drivers/mtd/nand/raw/nand_micron.c | 7 +++++--
> > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/mtd/nand/raw/nand_micron.c
> > > > b/drivers/mtd/nand/raw/nand_micron.c
> > > > index cbd4f09ac178..565f2696c747 100644
> > > > --- a/drivers/mtd/nand/raw/nand_micron.c
> > > > +++ b/drivers/mtd/nand/raw/nand_micron.c
> > > > @@ -500,8 +500,11 @@ static int micron_nand_init(struct nand_chip *chip)
> > > >  		chip->ecc.size = 512;
> > > >  		chip->ecc.strength = chip->base.eccreq.strength;
> > > >  		chip->ecc.algo = NAND_ECC_BCH;
> > > > -		chip->ecc.read_page = micron_nand_read_page_on_die_ecc;
> > > > -		chip->ecc.write_page = micron_nand_write_page_on_die_ecc;
> > > > +		if (!chip->ecc.read_page)
> > > > +			chip->ecc.read_page = micron_nand_read_page_on_die_ecc;
> > > > +
> > > > +		if (!chip->ecc.write_page)
> > > > +			chip->ecc.write_page = micron_nand_write_page_on_die_ecc;
> > > >  
> > >
> > > Seriously?! I told you this was inappropriate and you keep sending
> > > this patch. So let's make it clear:
> > >
> > > Nacked-by: Boris Brezillon <boris.brezillon@collabora.com>
> > >
> > > Fix your controller driver instead of adding hacks to the Micron logic!  
> > 
> > Not even going to review the other patch: if you have to do that, that means the driver is
> > broken. On a side note, this patch series is still not threaded as it should be and it's a v18 for a
> > damn NAND controller driver! Sorry but you reached the limit of my patience. Please find
> > someone to help you with that task.  
> My intention is not to resend this 1/2 again. Sorry for that.
> We already had some discussion on [v17 1/2], https://lkml.org/lkml/2019/6/26/430
> And there we didn't conclude that raw_read()/writes().

Yes, looks like I never replied to that one, but I think my previous
explanation were clear enough to not argue on that aspect any longer/

> So I thought that, will send updated driver along with this patch, then will get more information about
> The issue on the latest driver review.

More on that topic. I don't think you ever tested on-die ECC on a
Micron NAND, otherwise you would have noticed that your solution
completely bypasses the on-die ECC logic (and this will clearly break
existing on-die ECC users). See, that's what I'm complaining about,
Looks like you don't really understand what you're doing.

> There is nothing like keep on sending this patch, As you people are experts in the driver review, 
> if this patch is a hack, then we will definitely fix that in controller driver. I will find a way to do that.
> 
> But in this flow of patch sending, if the work I did hurts you, then I am really sorry for that.

I'm not offended, just tired going through the same driver over and
over again, reporting things that are wrong/inappropriate to then
realize you only addressed of a tiny portion of it in the following
version. My last reviews were rather incomplete because of that, and
now I'm giving up.

> Will fix this issue in the controller driver and will send the updated one.

How? You say you'll fix the issue but I'm not even sure you understand
what the issue is? Clearly, the patch you've posted doesn't fix
anything, it's just papering over the fact that your controller driver
is not supporting raw accesses (or at least, not supporting it
properly).

Have you even looked at the datasheet you pointed to in patch 2 [1]?
Just went through it, and found a field that's supposed to control the
ECC engine activation: ecc_memcfg.ecc_mode. I don't see anything
changing that field in your code, so I guess raw accesses are actually
not really happening with the ECC engine disabled... 

> Could you please let me know if this is OK.

You can send a new version, I'm just saying I won't spend time
reviewing it.

> 
> I will send the series as threaded one from next time onwards.
> 
> Thanks,
> pcieNaga Sureshkumar Relli

[1]http://infocenter.arm.com/help/topic/com.arm.doc.ddi0380g/DDI0380G_smc_pl350_series_r2p1_trm.pdf
