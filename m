Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6F0C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9572B2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521942;
	bh=fpaCt0GYwvbYwJ3eh6N+PCq5xTQcRR4ff/NnakrUkAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=feLGhxBThOVvaJNOofSqQ2VuOjd/xRhmh4HBuExgxZK/0g5j4b4YaxaDv0o7kf8k2
	 lgYJzbYhehR8g0qLmYdy7A9v+UT1u5+N+/Ujx+fGgb078A1/69trJD3xcHKEngfl4c
	 euTa+H52xlXuC3y7/B6+Kmbt/SsDtWSlvvMQyxH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfLPSpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:45:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:56248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfLPSpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:45:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67990206A5;
        Mon, 16 Dec 2019 18:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576521938;
        bh=fpaCt0GYwvbYwJ3eh6N+PCq5xTQcRR4ff/NnakrUkAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u2lJ/upO8pc5vU1W1k3LwrOjCXrYbiPDcHR42ey+AuN6WlF3gHneTNxagBNrs0egb
         lfvXXxf8xoYmlw2vGmTq0sTYsgwjKMZLyp3jaAUdwd96rtR3fFAAfYHQoLxkPBpwbk
         twPfXANYfK27HEOZMrfhwcOacLxa94BZOu8Y2y5o=
Date:   Mon, 16 Dec 2019 19:45:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrea Merello <andrea.merello@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 4.19 106/140] iio: ad7949: kill pointless
 "readback"-handling code
Message-ID: <20191216184536.GB2411653@kroah.com>
References: <20191216174747.111154704@linuxfoundation.org>
 <20191216174815.749524432@linuxfoundation.org>
 <CAN8YU5NrEbJx3yxBNoRWnwUiAYWffDp6gEcCcGUK+g4zjbHwEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN8YU5NrEbJx3yxBNoRWnwUiAYWffDp6gEcCcGUK+g4zjbHwEg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 07:31:31PM +0100, Andrea Merello wrote:
> Something nasty seems happening here: it looks like the commit message
> and the actual diff have nothing to do one wrt the other; the commit
> message is from one of my patches, the diff is against some unrelated
> file.
> 
> Il giorno lun 16 dic 2019 alle ore 19:05 Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> ha scritto:
> >
> > From: Meng Li <Meng.Li@windriver.com>
> >
> > [ Upstream commit c270bbf7bb9ddc4e2a51b3c56557c377c9ac79bc ]
> >
> > The device could be configured to spit out also the configuration word
> > while reading the AD result value (in the same SPI xfer) - this is called
> > "readback" in the device datasheet.
> >
> > The driver checks if readback is enabled and it eventually adjusts the SPI
> > xfer length and it applies proper shifts to still get the data, discarding
> > the configuration word.
> >
> > The readback option is actually never enabled (the driver disables it), so
> > the said checks do not serve for any purpose.
> >
> > Since enabling the readback option seems not to provide any advantage (the
> > driver entirely sets the configuration word without relying on any default
> > value), just kill the said, unused, code.
> >
> > Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> > Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  drivers/edac/altera_edac.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> > index 56de378ad13dc..c9108906bcdc0 100644
> > --- a/drivers/edac/altera_edac.c
> > +++ b/drivers/edac/altera_edac.c
> > @@ -600,6 +600,7 @@ static const struct regmap_config s10_sdram_regmap_cfg = {
> >         .reg_read = s10_protected_reg_read,
> >         .reg_write = s10_protected_reg_write,
> >         .use_single_rw = true,
> > +       .fast_io = true,
> >  };
> >
> >  static int altr_s10_sdram_probe(struct platform_device *pdev)
> > --
> > 2.20.1
> >
> >
> >

Wow, something went wrong.

Sasha, can you look into this?

thanks,

greg k-h
