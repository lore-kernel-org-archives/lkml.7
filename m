Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A96C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9D02253D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SipAHkPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgACSZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 13:25:12 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38928 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbgACSZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 13:25:12 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so16372457plp.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 10:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qW83qsxpwf2/UZcSK+rVXwz9u16IUPoBDgWO6FkrDOc=;
        b=SipAHkPek4LSECCncIfZjoX69+G+fklKFs+PgfunA7KEM8mTXKyE8b38CLrrMCLm6I
         RAhBytnJED1/yanNGg7MAKRr6/o+QaZBaPQeltRDJq4RfPB1MzihPr1BYLktqdAFe/6f
         1uM0QGWsDXTkngXx0ZyBDn0WNvqTQSxAFabRgZAp6ch4J3oVCcONiIn30pGSOjJf3blB
         ny8TX9HbNMLXSnZCtmX6K4KdMT2Nh/JY3NfeWxV5k2mGwhFjHCcITTLi/mrS0hrBZOEb
         +SCCgHGMujpor6+kk9E0zQTlPlyxzmSUn4efiUStGOiMEmi3QreatlGEUUQq4xbRwKyG
         9ADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qW83qsxpwf2/UZcSK+rVXwz9u16IUPoBDgWO6FkrDOc=;
        b=huXo73D5J/oorItmAEPUnX9DaGh+CUHZtnJaU/9Sx9Jcsqew4g+s217HqvG/GQmdtr
         Yif7HijJOyYfA4aSRR9v1kY4F9NIdNeywUOb8DEUyvmAC4xdGhzM03jUblGLmZhd+/TO
         aBPWj6W8CKnTAumVJMsDOA2l75ty0edz4aeAiZJlYkJlq0XAqkxFjr+CU0MUtHwg4R9c
         9eeD+x2R5nmcbnjhv/fDKCrQrzmTWMN6phWSXW/I4jAyejO3ITV6zf9HLF35UT8vthq+
         f/kGMVXMH5teYNPKkBpiMU1OuKgHLC7TNjxqcwaFLw3TzhdO5OJF8hNirLDZ6lmj/zX+
         DRmA==
X-Gm-Message-State: APjAAAXwZlbuj8yzqn7/0clQzr/duMZXGn39/4mGLErE0fzs2f73eYdR
        Lp5ksSxJ+32kiReIVVYkt1k=
X-Google-Smtp-Source: APXvYqwsZQKqtyEyj2LOAt7A+rTqD0fBPwGrTf/wve3kKW4OAwb5MIup6B8yu2JOby9GpsDWJZnu0Q==
X-Received: by 2002:a17:902:7c0f:: with SMTP id x15mr53728214pll.267.1578075911549;
        Fri, 03 Jan 2020 10:25:11 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id r8sm15054771pjo.22.2020.01.03.10.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 10:25:11 -0800 (PST)
Date:   Fri, 3 Jan 2020 10:25:09 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: atmel: switch to using
 devm_fwnode_gpiod_get()
Message-ID: <20200103182509.GF8314@dtor-ws>
References: <20200103012238.GA3648@dtor-ws>
 <20200103090704.GG3040@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103090704.GG3040@piout.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Fri, Jan 03, 2020 at 10:07:04AM +0100, Alexandre Belloni wrote:
> Hi,
> 
> On 02/01/2020 17:22:38-0800, Dmitry Torokhov wrote:
> > devm_fwnode_get_index_gpiod_from_child() is going away as the name is
> > too unwieldy, let's switch to using the new devm_fwnode_gpiod_get().
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/mtd/nand/raw/atmel/nand-controller.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> > index 8d6be90a6fe8a..849bd5f16492d 100644
> > --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> > +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> > @@ -1578,9 +1578,8 @@ static struct atmel_nand *atmel_nand_create(struct atmel_nand_controller *nc,
> >  
> >  	nand->numcs = numcs;
> >  
> > -	gpio = devm_fwnode_get_index_gpiod_from_child(nc->dev, "det", 0,
> > -						      &np->fwnode, GPIOD_IN,
> > -						      "nand-det");
> > +	gpio = devm_fwnode_gpiod_get(nc->dev, of_fwnode_hanlde(np),
> 
> Shouldn't that be of_fwnode_handle(np)?

:( You are right. Apparently I did not actually enable the driver when
trying to compile this. I'll update and repost this shortly.

-- 
Dmitry
