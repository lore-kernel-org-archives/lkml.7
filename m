Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88E9C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A2E2245C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="GCisWDnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbfLEOtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:49:47 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:57812 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729396AbfLEOtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:49:47 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47TJTZ2DSpz3c;
        Thu,  5 Dec 2019 15:47:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1575557234; bh=SdhSC4B4qnY5nHTEIulHuGXWpsS6ubKaRhfb6FXv6F0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GCisWDnMuiO3s6XgyfUW7VxaCIffzvteDBYLehPFGJmBQ7sCFAxEo0JlWNfjhUUqB
         qOYihABrLOYXEB5eqOOKRvwBxKW+8aE9+so1fOaxzEaISx5ddWVcoD8aBEzsk6VF4x
         l4Oh96a3/d4OCPJO+UCYI0d9nSYDJT2UaQrBoweb9d0cmTTymjgCFnh+FJQiDi+kQG
         kzX/wobFQGBLP2KPV5HWgAKkv5MRlITMyfEOwAKcOQ3OKxzn/xAZcGDfLbTnPkW4oV
         Zrxt/L+2dADI/MRLaIKI8vcTqYrkEuGzy6VRZvmvJ7VwIjXARVe3owcNtHr0W6uz4S
         Q4Ef4IBICDL8g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Thu, 5 Dec 2019 15:49:41 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     =?iso-8859-2?B?Suly9G1l?= Pouiller <Jerome.Pouiller@silabs.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: wfx: fix reset GPIO polarity
Message-ID: <20191205144941.GA12859@qmqm.qmqm.pl>
References: <f9ebb05f4a13cce4a8724dfb17f8383ec9b2d468.1575478705.git.mirq-linux@rere.qmqm.pl>
 <3343657.nOMI9WY9u8@pc-42>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3343657.nOMI9WY9u8@pc-42>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 02:08:23PM +0000, Jérôme Pouiller wrote:
> On Wednesday 4 December 2019 17:59:46 CET Micha³ Miros³aw wrote:
> > Driver inverts meaning of GPIO_ACTIVE_LOW/HIGH. Fix it to prevent
> > confusion.
> > 
> > Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> > ---
> >  drivers/staging/wfx/bus_spi.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/wfx/bus_spi.c b/drivers/staging/wfx/bus_spi.c
> > index ab0cda1e124f..73d0157a86ba 100644
> > --- a/drivers/staging/wfx/bus_spi.c
> > +++ b/drivers/staging/wfx/bus_spi.c
> > @@ -199,9 +199,9 @@ static int wfx_spi_probe(struct spi_device *func)
> >         if (!bus->gpio_reset) {
> >                 dev_warn(&func->dev, "try to load firmware anyway\n");
> >         } else {
> > -               gpiod_set_value(bus->gpio_reset, 0);
> > -               udelay(100);
> >                 gpiod_set_value(bus->gpio_reset, 1);
> > +               udelay(100);
> > +               gpiod_set_value(bus->gpio_reset, 0);
> >                 udelay(2000);
> >         }
> Hello Micha³,
> 
> I did not find real consensus in kernel code. My personal taste would
> be to keep this gpio "ACTIVE_HIGH" and rename it gpio_nreset. What do
> you think about it?
> 
> (in add, this solution would explicitly change the name of the DT
> attribute instead of changing the semantic of the existing attribute)

As a user (board developer) I would expect that DT describes the
GPIO meaning directly: so when I specify GPIO_ACTIVE_HIGH flag I also
wire up the board so that outputing 1 would match the active state of
the chip's signal (that might be inverted for some reason). I think we
should stick to what is said in Documentation/devicetree/bindings/gpio.txt
(section 1.1).

Since this is a new driver in kernel I would prefer to fix it at the start.
Changing the name of the GPIO would also be ok, but since there is no DT
binding yet, I guess there will come up an issue of 'compatible' string
format that does not match 'vendor,chip' now, so we can use the difference
for backwards compatibility with out-of-tree driver if needed.

Best Regards,
Micha³ Miros³aw
