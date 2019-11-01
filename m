Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BDECA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8833120650
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I1/WHsVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfKAO6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 10:58:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36680 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbfKAO6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 10:58:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id j22so6663502pgh.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 07:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o3PotZZzGd3n0vtfT41UhnCQaaRUmL4E0PRscYzEIDo=;
        b=I1/WHsVyWQVAH+7YIQ9FJxjw/3+UZ4eJ1j/SDFWtIEofNsreSoGawixnCPLXHfjS4I
         xlDwa3u66eEwoOJUAPlHK0dUeT0aet3AJF7Hh7vmKlsgkC0XBk6UfewUnoYtCFXoeX5g
         7fSank49zBRoLLYkoib3osby1hKIjugYLT3XialA5XwBx2NicKvLZ0AL8HaA0MYN2gGJ
         6I7li89dPySlSyjub59Y1gl2eGkUAndynwIHLXQ4f01kEq7g1XzQ0k9tdlQaGRx6v+Xw
         shsJV6s6wDw/l6GpKrmsUj23FJcOIaobHKjzfOKXCDKJMXhdUTkbzBcGYz4z5yGtH0e+
         thcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o3PotZZzGd3n0vtfT41UhnCQaaRUmL4E0PRscYzEIDo=;
        b=cy6/my/ahAKhz6h+k4czrObjXeb6NzrO8zNiTw3VgrXQBpAIj9w1NgDI/7uqjU6j39
         f/wBI4e33tflqQhnDopwbMh5jKfMSBPTsj8Z4TF4LsuOtmDygRElhIkK1P+Wnfirua2x
         fcRI7TLv+PQTxpeHi4YHGacLo57qhHQyeAfOjpE8hE4QkGjTNkQzp3brEMCMeofCD+Rp
         oIpuC4q0Zr9XKxxAlH+wNBx9htj4nmP9TXn4bYt+vK6+PsaNseq9LO3qp47jmQPwZMsL
         4K+JRRiJtZy3XGWmPQzV144JWYq5t3ujQtVnk0rkcnNiMnpjFeKDE8+TQjPZZEnOfN4N
         nyFg==
X-Gm-Message-State: APjAAAX8zwlbDlLOdmLdwFUh0WhMhjJNL0ovnClczQs9Lxn5BV2Zd253
        BHj+Nt6YvnmTXofWOb9+lXe3
X-Google-Smtp-Source: APXvYqyyHMBHWz8vbhnckMVAipVVWfbs6zJpy+GNzFBfp8NvRJbt08PIocOSMFo+vTjHOv8EaNNmig==
X-Received: by 2002:a05:6a00:51:: with SMTP id i17mr14214665pfk.8.1572620297826;
        Fri, 01 Nov 2019 07:58:17 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6413:fc8c:9538:d2ea:eab:d2c0])
        by smtp.gmail.com with ESMTPSA id z21sm6644869pfa.119.2019.11.01.07.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Nov 2019 07:58:17 -0700 (PDT)
Date:   Fri, 1 Nov 2019 20:28:06 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Tudor.Ambarus@microchip.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        darshak.patel@einfochips.com, prajose.john@einfochips.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, marek.vasut@gmail.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 4/4] mtd: spi-nor: Add support for w25q256jw
Message-ID: <20191101145806.GB13101@Mani-XPS-13-9360>
References: <20191030090124.24900-1-manivannan.sadhasivam@linaro.org>
 <20191030090124.24900-5-manivannan.sadhasivam@linaro.org>
 <87e0b459-8dbf-26cc-611f-1b1b5266aa55@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87e0b459-8dbf-26cc-611f-1b1b5266aa55@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

On Fri, Nov 01, 2019 at 01:48:17PM +0000, Tudor.Ambarus@microchip.com wrote:
> 
> 
> On 10/30/2019 11:01 AM, Manivannan Sadhasivam wrote:
> > External E-Mail
> > 
> > 
> > Add MTD support for w25q256jw SPI NOR chip from Winbond. This chip
> > supports dual/quad I/O mode with 512 blocks of memory organized in
> > 64KB sectors. In addition to this, there is also small 4KB sectors
> > available for flexibility. The device has been validated using Thor96
> > board.
> > 
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
> 
> Can we keep Darshak's authorship? We usually change the author if we feel that
> we made a significant change to what was originally published.
> 
> If it's just about cosmetics, cleaning or rebase, you can specify what you did
> after the author's S-o-b tag and then add your S-o-b, as you did above.
> 

I'd suggest to keep Darshak's authorship since he did the actual change in
the bsp. I have to clean it up before submitting upstream and I mentioned
the same above.

> The patch looks good.
> 

Thanks,
Mani

> Cheers,
> ta
> 
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
