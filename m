Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA13C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E305520842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLZD6FDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfCER1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:27:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44622 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfCER1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 12:27:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id a3so6200528pff.11;
        Tue, 05 Mar 2019 09:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ok0zY5DUYYF0T+dRMWW1Nw0S/K2DqLUG9/hAWAE8dHM=;
        b=lLZD6FDKa4+ZqX7gfXiCp3AFF/dt4L/yvUsoPjNltoa9c5T8uTRRL/OjtU2m09RTNw
         dxexDYoAMZ5qlwoFCEavXIzJG6zElaH6juwb64+ytLQJmrza9T82DbI2WTFFujVSpfK1
         5iPi9+r2G8nPgQkAd2GvhctrvFNkBQVPxTGfup/684X4E9Nx9BXpGaP20S3iUccm15tK
         Li2FdLEvOrCiHr3ClkwPMTp1fIxsjmx1esqyg582XutkeceIgOuXjCu0HAWX3G8ovEs6
         7e62tv7REF8jl3yRtBvkjwDtL+x/Tu35iEBil+xdAlelbxq1h7kKAlGn8jd0AWQROHcO
         7pPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ok0zY5DUYYF0T+dRMWW1Nw0S/K2DqLUG9/hAWAE8dHM=;
        b=hXm71z6cqml3iYHzn6UFcWC1eGjIU702mgD2ConHMjlxOHsEz8Hss19hIDhWqsyn6E
         3Ndy1Eg3SFElxnirIBcwt4csbEYXo/srqgXLp1R457orpU0xCvjmU2yVZhRjw4zkGt1B
         hPsy1esunu1OHY42+k6wVjR8V/jqV0ezYaShrTvcCKdWKsIpr+eF2KTimSf1dUyYj01D
         2V6tfZbF1S7s2eHiJTXVdugnhd0VxAEtVKnYuRAfEqNbuzgpNveuZznoySFcdlXtdXaP
         E5QntOKT1FfKtqYrFiudSi0+ELdEsB2LmahJTdtKlsGBMqHA0Byaboz3OtbdBUOmC9IE
         AQ9w==
X-Gm-Message-State: APjAAAXdxx+VQIawGdJv2STxLwqDSdM+hOGnZyWl51b5uX5rZz9LvYgV
        QmZfvZgxb+6ocFfz1tnK6X8=
X-Google-Smtp-Source: APXvYqz8v3MekaACTMmiZRps1by4sAhfub0Pgvg9GZl99/OOlxK1nOMb0kn0R18Ti2dE1mPsIyFffg==
X-Received: by 2002:a63:d70a:: with SMTP id d10mr2348403pgg.286.1551806838386;
        Tue, 05 Mar 2019 09:27:18 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k9sm14760175pfc.57.2019.03.05.09.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 09:27:17 -0800 (PST)
Date:   Tue, 5 Mar 2019 09:27:17 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] watchdog: orion_wdt: use timer1 as a pretimeout
Message-ID: <20190305172716.GB32623@roeck-us.net>
References: <20190227230707.GA28635@roeck-us.net>
 <20190304225152.26831-1-chris.packham@alliedtelesis.co.nz>
 <20190304225152.26831-3-chris.packham@alliedtelesis.co.nz>
 <20190305005710.GL26378@lunn.ch>
 <5605e7b7a0f540a7908a1eb5191bbe5e@svr-chch-ex1.atlnz.lc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5605e7b7a0f540a7908a1eb5191bbe5e@svr-chch-ex1.atlnz.lc>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 01:26:08AM +0000, Chris Packham wrote:
> On 5/03/19 1:57 PM, Andrew Lunn wrote:
> > On Tue, Mar 05, 2019 at 11:51:52AM +1300, Chris Packham wrote:
> >> The orion watchdog can either reset the CPU or generate an interrupt.
> >> The interrupt would be useful for debugging as it provides panic()
> >> output about the watchdog expiry, however if the interrupt is used the
> >> watchdog can't reset the CPU in the event of being stuck in a loop with
> >> interrupts disabled or if the CPU is prevented from accessing memory
> >> (e.g. an unterminated DMA).
> >>
> >> All of the orion based CPU cores (at least back as far as Kirkwood) have
> >> spare timers that aren't currently used by the Linux kernel.
> 
> Actually this appears to be incorrect Kirkwood does configure timer1 as 
> a clockevent timer. So I can't just grab timer1 for all platforms.
> 
If you can't use it unconditionally, can you specify it (and use it)
as clock ?

> >> We can use
> >> timer1 to provide a pre-timeout ahead of the watchdog timer and provide
> >> the possibility of gathering debug before the reset triggers.
> > 
> > Hi Chris
> > 
> > I had a quick look at other drivers implementing pre-timeout. They
> > seem to call watchdog_notify_pretimeout(). I don't see that here? What
> > happens when timer1 fires?
> > 
> 
> It invokes the regular orion_wdt_irq(). On Armada-385 prior to this 
> change the irq was not specified because the reset always kicked in so 
> there was no point.
> 

I would suggest to update that function to actually call
watchdog_notify_pretimeout() if a pretimeout is configured configured.
After all, we do want to support the infrastructure, and that includes
support for the various pretimeout governors (if enabled).

> For correctness I could make the devicetree binding specify 2 
> interrupts. One for the regular watchdog interrupt (which would never 
> usually get hit because the reset would kick in) and one for the 
> pretimeout/timer1.
> 
Yes, if they are different interrupts and orion_wdt_irq() is only supposed
to handle the real timeout.

Thanks,
Guenter

> >> @@ -169,38 +174,46 @@ static int armadaxp_wdt_clock_init(struct platform_device *pdev,
> >>   	}
> >>   
> >>   	/* Enable the fixed watchdog clock input */
> >> -	atomic_io_modify(dev->reg + TIMER_CTRL,
> >> -			 WDT_AXP_FIXED_ENABLE_BIT,
> >> -			 WDT_AXP_FIXED_ENABLE_BIT);
> >> +	val = WDT_AXP_FIXED_ENABLE_BIT | TIMER1_FIXED_ENABLE_BIT;
> >> +	atomic_io_modify(dev->reg + TIMER_CTRL, val, val);
> >>   
> >>   	dev->clk_rate = clk_get_rate(dev->clk);
> >> +
> >> +
> > 
> > One blank line is sufficient,
> > 
> > 
> >>   	return 0;
> >>   }
> > 
> >     Andrew
> > 
> 
