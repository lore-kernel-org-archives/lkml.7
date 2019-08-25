Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D963C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 12:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4490920850
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 12:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfHYMvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 08:51:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38268 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfHYMvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 08:51:46 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B932C28A1AB;
        Sun, 25 Aug 2019 13:51:44 +0100 (BST)
Date:   Sun, 25 Aug 2019 14:51:41 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] mtd: spi-nor: Split spi_nor_init_params()
Message-ID: <20190825145141.71a647ab@collabora.com>
In-Reply-To: <78202b39-1c40-dbaa-3ebc-3481ecbe4643@microchip.com>
References: <20190824120027.14452-1-tudor.ambarus@microchip.com>
        <20190824120027.14452-5-tudor.ambarus@microchip.com>
        <20190825140302.21ca2623@collabora.com>
        <78202b39-1c40-dbaa-3ebc-3481ecbe4643@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Aug 2019 12:23:45 +0000
<Tudor.Ambarus@microchip.com> wrote:

> On 08/25/2019 03:03 PM, Boris Brezillon wrote:
> > External E-Mail
> > 
> > 
> > On Sat, 24 Aug 2019 12:00:43 +0000
> > <Tudor.Ambarus@microchip.com> wrote:
> >   
> >> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> >>
> >> Add functions to delimit what the chunks of code do:
> >>
> >> static void spi_nor_init_params()
> >> {
> >> 	spi_nor_legacy_init_params()
> >> 	spi_nor_manufacturer_init_params()
> >> 	spi_nor_sfdp_init_params()
> >> }
> >>
> >> Add descriptions to all methods.
> >>
> >> spi_nor_init_params() becomes of type void, as all its children
> >> return void.
> >>
> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> >> ---
> >>  drivers/mtd/spi-nor/spi-nor.c | 83 ++++++++++++++++++++++++++++++++-----------
> >>  1 file changed, 63 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> >> index c9514dfd7d6d..93424f914159 100644
> >> --- a/drivers/mtd/spi-nor/spi-nor.c
> >> +++ b/drivers/mtd/spi-nor/spi-nor.c
> >> @@ -4186,7 +4186,34 @@ static void spi_nor_manufacturer_init_params(struct spi_nor *nor)
> >>  		nor->info->fixups->default_init(nor);
> >>  }
> >>  
> >> -static int spi_nor_init_params(struct spi_nor *nor)
> >> +/**
> >> + * spi_nor_sfdp_init_params() - Initialize the flash's parameters and settings
> >> + * based on JESD216 SFDP standard.
> >> + * @nor:	pointer to a 'struct spi-nor'.
> >> + *
> >> + * The method has a roll-back mechanism: in case the SFDP parsing fails, the
> >> + * legacy flash parameters and settings will be restored.
> >> + */
> >> +static void spi_nor_sfdp_init_params(struct spi_nor *nor)
> >> +{
> >> +	struct spi_nor_flash_parameter sfdp_params;
> >> +
> >> +	memcpy(&sfdp_params, &nor->params, sizeof(sfdp_params));
> >> +
> >> +	if (spi_nor_parse_sfdp(nor, &sfdp_params)) {
> >> +		nor->addr_width = 0;
> >> +		nor->flags &= ~SNOR_F_4B_OPCODES;
> >> +	} else {
> >> +		memcpy(&nor->params, &sfdp_params, sizeof(nor->params));
> >> +	}
> >> +}
> >> +
> >> +/**
> >> + * spi_nor_legacy_init_params() - Initialize the flash's parameters and settings
> >> + * based on nor->info data.
> >> + * @nor:	pointer to a 'struct spi-nor'.
> >> + */
> >> +static void spi_nor_legacy_init_params(struct spi_nor *nor)  
> > 
> > Nitpick: hm, I'm not a big fan of the 'legacy' term here as I'm not sure
> > it reflects the reality. I guess this function will stay around, and
> > even new NORs are not guaranteed to provide SFDP tables. How about
> > spi_nor_set_default_params() or spi_nor_info_init_params()?  
> 
> I can rename it to spi_nor_info_init_params() to be in sync with
>                    spi_nor_manufacturer_init_params() and
>                    spi_nor_sfdp_init_params()
> 
> or I can rename all to:
> spi_nor_set_params()
> spi_nor_set_default_params()
> spi_nor_set_manufacturer_params()
> spi_nor_set_sfdp_params()
> 
> Both are ok, but the second option seems better. What would you choose?

Both sound good, pick the one you prefer.
