Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256DEC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56BF206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbfDQMAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:00:06 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:55949 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729522AbfDQMAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:00:06 -0400
X-Originating-IP: 109.212.207.226
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id CA278FF80D;
        Wed, 17 Apr 2019 12:00:02 +0000 (UTC)
Date:   Wed, 17 Apr 2019 14:00:02 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Romain Izard <romain.izard.pro@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 9/9] misc: atmel_tclib: do not probe already used TCBs
Message-ID: <20190417120002.GB12992@piout.net>
References: <20190415150856.9384-1-alexandre.belloni@bootlin.com>
 <20190415150856.9384-10-alexandre.belloni@bootlin.com>
 <20190417114934.GA28520@5WDYG62>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417114934.GA28520@5WDYG62>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2019 13:50:25+0200, Romain Izard wrote:
> On Mon, Apr 15, 2019 at 05:08:56PM +0200, Alexandre Belloni wrote:
> > The TCBs that have children are using the proper DT bindings and don't need
> > to be handled by tclib.
> > 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  drivers/misc/atmel_tclib.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
> > index 194f774ab3a1..c1f5aba1c6f2 100644
> > --- a/drivers/misc/atmel_tclib.c
> > +++ b/drivers/misc/atmel_tclib.c
> > @@ -111,6 +111,9 @@ static int __init tc_probe(struct platform_device *pdev)
> >  	struct resource	*r;
> >  	unsigned int	i;
> >  
> > +	if (of_get_child_count(pdev->dev.of_node))
> > +		return 0;
> > +
> >  	irq = platform_get_irq(pdev, 0);
> >  	if (irq < 0)
> >  		return -EINVAL;
> 
> This lead to a panic during shutdown, as tc_shutdown is called on the
> device that has not been initialized and it has not been designed for
> this.
> 

Yes, I saw that yesterday, the solution is to return -EBUSY instead of
0. That's what I had in my original series and I changed it before
submitting to avoid the error message at boot but this was not a good
idea.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
