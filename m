Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9755C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72AFE206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xiGEiKkm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfCEA5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:57:37 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:46604 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfCEA5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=9/HkbvfsZhsGC83D/DHLkvbKCUxRfZZgJRuKR+Q595U=; b=xiGEiKkmcdAcBBb2VB++MWBpyW
        dX0NJP73TjZoiUj/Rlot82LN35fMhqajszUfU9+9JcscN/ylzX9sweGt4eIBt7oUM6Zf1Ch85hrUF
        xlYW9md5tKvw3isq4E2o0xWeR22adTuoOLjge+97eFVINE49U96WmO7p0Nlf0AGcljEI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1h0yOM-00024T-37; Tue, 05 Mar 2019 01:57:10 +0100
Date:   Tue, 5 Mar 2019 01:57:10 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     linux@roeck-us.net, gregory.clement@bootlin.com,
        jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] watchdog: orion_wdt: use timer1 as a pretimeout
Message-ID: <20190305005710.GL26378@lunn.ch>
References: <20190227230707.GA28635@roeck-us.net>
 <20190304225152.26831-1-chris.packham@alliedtelesis.co.nz>
 <20190304225152.26831-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304225152.26831-3-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 11:51:52AM +1300, Chris Packham wrote:
> The orion watchdog can either reset the CPU or generate an interrupt.
> The interrupt would be useful for debugging as it provides panic()
> output about the watchdog expiry, however if the interrupt is used the
> watchdog can't reset the CPU in the event of being stuck in a loop with
> interrupts disabled or if the CPU is prevented from accessing memory
> (e.g. an unterminated DMA).
> 
> All of the orion based CPU cores (at least back as far as Kirkwood) have
> spare timers that aren't currently used by the Linux kernel. We can use
> timer1 to provide a pre-timeout ahead of the watchdog timer and provide
> the possibility of gathering debug before the reset triggers.

Hi Chris

I had a quick look at other drivers implementing pre-timeout. They
seem to call watchdog_notify_pretimeout(). I don't see that here? What
happens when timer1 fires?

> @@ -169,38 +174,46 @@ static int armadaxp_wdt_clock_init(struct platform_device *pdev,
>  	}
>  
>  	/* Enable the fixed watchdog clock input */
> -	atomic_io_modify(dev->reg + TIMER_CTRL,
> -			 WDT_AXP_FIXED_ENABLE_BIT,
> -			 WDT_AXP_FIXED_ENABLE_BIT);
> +	val = WDT_AXP_FIXED_ENABLE_BIT | TIMER1_FIXED_ENABLE_BIT;
> +	atomic_io_modify(dev->reg + TIMER_CTRL, val, val);
>  
>  	dev->clk_rate = clk_get_rate(dev->clk);
> +
> +

One blank line is sufficient,


>  	return 0;
>  }

   Andrew
