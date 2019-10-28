Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C83BCA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D5F208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="irsXVZVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390126AbfJ1Oda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:33:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34009 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390052AbfJ1Od3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:33:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id b128so7011191pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 07:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jRXui8mziHn1dHv5sVSn9Ol454G9W6p0Jp5i7su5XVo=;
        b=irsXVZVgMMIM/IxRyTrk/qvcpBGoyEqBd5lsDi83dqdq4Ij85W6nXIMi6d68nrg5mP
         m6dlG15ZtcjLhwSGfAy8IBHJm0XFBTuLkMkcujDc+Jz1uFwMhqmA7fHXnnoH/eWLwHO6
         e9l/L2TkOw6FadXSJL0Je2cED/hKn7LLI0rEqqOzKqUSSuDmRm3Y94/BFnNdOFgvlK/u
         r6m3dcKiBjkSkA+6OC//ADulFoKMPfhnqdWnsN6mlCplwyHpgndtLX09a4EKzsqzZNF5
         inPLg24/mKcrAVmYDM9nEN9k7aOUFGcU2NUl/TD0RloUuibGiFYlPXJ91nIEUl6FoBJN
         QFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jRXui8mziHn1dHv5sVSn9Ol454G9W6p0Jp5i7su5XVo=;
        b=WW5cymnnTjuqn8sc2C8NAo14YJxdM59QVaYv2NlkCxUwePXY2E64DVc+x+Qh7eWW1a
         aAifYeGHBNMyFH4P5iJASQWx1R2ECM4wd+9myZQfBItydq4LAS1pQZFfKVshZ5eKZdaZ
         /IBCIYiUmIqjmfMrrpN3wy/uKIBl9NA4GxWGCfelHyIgTM1NGu3PGfxPnQVTPUiKEtY1
         4scnfcXJG6aGtwEpF2Wu5GlOR/UpfyP1jd8QeL596L7cwMM53lHZWRcMHQcYllgZhFtF
         n7yiptr9RVX9arj+TzsiBamy+2mgIPKg55nB6ng4+xMMs3VMzz/bU3j+cCcvVfF++d3J
         cWag==
X-Gm-Message-State: APjAAAUbWRMblL0nSBB/C1J5WvLfz5ZpQldo31fghmHaa8p759uOFTXA
        e1IWUmA0dhbEvnffH8iFmPWN
X-Google-Smtp-Source: APXvYqzGnQ3oWUKcqs6cX+pDXEkapuTymujVJwAUXj1ZSC41/Q+HtHirj1nbVtMWKAisgsEBnI8rUA==
X-Received: by 2002:a63:4553:: with SMTP id u19mr20936350pgk.436.1572273208969;
        Mon, 28 Oct 2019 07:33:28 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6004:d1fe:706d:952a:57bd:23b6])
        by smtp.gmail.com with ESMTPSA id o7sm5154561pjo.7.2019.10.28.07.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 07:33:28 -0700 (PDT)
Date:   Mon, 28 Oct 2019 20:03:17 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        darshak.patel@einfochips.com, prajose.john@einfochips.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 3/3] mtd: spi-nor: Add support for w25q256jw
Message-ID: <20191028143317.GB29312@Mani-XPS-13-9360>
References: <20191024144235.3182-1-manivannan.sadhasivam@linaro.org>
 <20191024144235.3182-4-manivannan.sadhasivam@linaro.org>
 <bf435b43-f118-f3cb-73ed-5fa67905c4aa@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf435b43-f118-f3cb-73ed-5fa67905c4aa@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

On Mon, Oct 28, 2019 at 05:20:40PM +0530, Vignesh Raghavendra wrote:
> Hi,
> 
> On 24/10/19 8:12 PM, Manivannan Sadhasivam wrote:
> > Add MTD support for w25q256jw SPI NOR chip from Winbond. This chip
> > supports dual/quad I/O mode with 512 blocks of memory organized in
> > 4KB sectors. 
> 
> 512 blocks of memory organized into 64KB sector, right? In additional
> flash also supports 4KB small sector.
> 

Yeah, the wording is wrong here. Will fix it.

Thanks,
Mani

> Regards
> Vignesh
> 
> > The device has been validated using Thor96 board.
> 
> 
> > Cc: Marek Vasut <marek.vasut@gmail.com>
> > Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Cc: Brian Norris <computersforpeace@gmail.com>
> > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > Cc: Richard Weinberger <richard@nod.at>
> > Cc: Vignesh Raghavendra <vigneshr@ti.com>
> > Cc: linux-mtd@lists.infradead.org
> > Signed-off-by: Darshak Patel <darshak.patel@einfochips.com>
> > [Mani: cleaned up for upstream]
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/mtd/spi-nor/spi-nor.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> > index 1d8621d43160..2c25b371d9f0 100644
> > --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -2482,6 +2482,8 @@ static const struct flash_info spi_nor_ids[] = {
> >  	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> >  	{ "w25q256jvm", INFO(0xef7019, 0, 64 * 1024, 512,
> >  			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > +	{ "w25q256jw", INFO(0xef6019, 0, 64 * 1024, 512,
> > +			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> >  	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024,
> >  			SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
> >  
> > 
