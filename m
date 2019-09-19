Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BD8C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 11:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758432196E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 11:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568892581;
	bh=Pvq/7D6S/KPNrlEap1DoFVldgRv5WRFeFozeTaFRDHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L8EvGfFFYrDhg+hGteGl2k5L5AmLzBmTkeD4H6SgfkVxIopnjiAkcearixAHQKl1W
	 4LWkx8OjKpXJqCyAXWI6oJcBvtRlXZYEPpY2QvHMn1HttE5dzfO9WqDJzBj0R0jRQM
	 PP4znA+622eSzT5ylGvh880ZCl3vUwR7+y2dz7jo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389866AbfISL3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 07:29:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbfISL3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 07:29:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E35AE21929;
        Thu, 19 Sep 2019 11:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568892579;
        bh=Pvq/7D6S/KPNrlEap1DoFVldgRv5WRFeFozeTaFRDHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qBpLSsbreLZ8P7ObI0vUafC3Zi7RQxY9OwwkzxVCH6pRiEhOqYM0Bw7QuQ4DlIleH
         HCmekc88h+oZPkodYg6IGelzTBbrrwYjQ9WL7VJeENOO5X+CCLu0bE7z6+pXroPBUb
         9VQgNh+QcHatnpADmavENZ/htUjNf/TCH8cDzj04=
Date:   Thu, 19 Sep 2019 13:29:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        linux-mtd@lists.infradead.org,
        Allison Randal <allison@lohutok.net>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH] mtd: st_spi_fsm: Use devm_platform_ioremap_resource() in
 stfsm_probe()
Message-ID: <20190919112937.GA3072241@kroah.com>
References: <e1d32aa4-7c82-64e0-b7c4-33c94d9a2769@web.de>
 <20190919111014.6c569cf3@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919111014.6c569cf3@xps13>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 11:10:14AM +0200, Miquel Raynal wrote:
> Hi Markus,
> 
> Markus Elfring <Markus.Elfring@web.de> wrote on Wed, 18 Sep 2019
> 14:50:27 +0200:
> 
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Wed, 18 Sep 2019 14:37:34 +0200
> > 
> > Simplify this function implementation by using a known wrapper function.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >  drivers/mtd/devices/st_spi_fsm.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> > 
> > diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
> > index f4d1667daaf9..5bd1c44ae529 100644
> > --- a/drivers/mtd/devices/st_spi_fsm.c
> > +++ b/drivers/mtd/devices/st_spi_fsm.c
> > @@ -2034,13 +2034,7 @@ static int stfsm_probe(struct platform_device *pdev)
> > 
> >  	platform_set_drvdata(pdev, fsm);
> > 
> > -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	if (!res) {
> > -		dev_err(&pdev->dev, "Resource not found\n");
> > -		return -ENODEV;
> > -	}
> > -
> > -	fsm->base = devm_ioremap_resource(&pdev->dev, res);
> > +	fsm->base = devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(fsm->base)) {
> >  		dev_err(&pdev->dev,
> >  			"Failed to reserve memory region %pR\n", res);
> > --
> > 2.23.0
> > 
> 
> 
> Is this even compiled tested? 'res' is not initialized anymore so you
> can't use it in the error trace. I suppose you should even drop it from
> the stack parameters.

You are responding to a email address/bot that is on a number of kernel
developers "black list" as something to just totally ignore.  I
recommend you do the same if possible...

greg k-h
