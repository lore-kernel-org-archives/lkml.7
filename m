Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E81C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 02:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870DF20684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 02:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OHcu5bfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfCECKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 21:10:05 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:46675 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfCECKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 21:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fOkL5Bjje29AfHu6pkv5c3gKzk6Q/FW3YHwUB/iVlLk=; b=OHcu5bfFVsg/bgf3U2YCG8Eyd1
        C5CpvJPjabAGGVpx371gDJ5FznHNw8h+NpeljkADx+lBnVgQWKjU932U6kl0ke6bML/9jzBKkx/KU
        KIP5IyBvVb5ucWf7rcwcL1JChsKtPX2hPYvFk1zte9TZmi4DWxRihzMVZ29H55N8dwWo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1h0zWa-0002g2-PV; Tue, 05 Mar 2019 03:09:44 +0100
Date:   Tue, 5 Mar 2019 03:09:44 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "linux@roeck-us.net" <linux@roeck-us.net>,
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
Message-ID: <20190305020944.GN26378@lunn.ch>
References: <20190227230707.GA28635@roeck-us.net>
 <20190304225152.26831-1-chris.packham@alliedtelesis.co.nz>
 <20190304225152.26831-3-chris.packham@alliedtelesis.co.nz>
 <20190305005710.GL26378@lunn.ch>
 <5605e7b7a0f540a7908a1eb5191bbe5e@svr-chch-ex1.atlnz.lc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5605e7b7a0f540a7908a1eb5191bbe5e@svr-chch-ex1.atlnz.lc>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> For correctness I could make the devicetree binding specify 2 
> interrupts. One for the regular watchdog interrupt (which would never 
> usually get hit because the reset would kick in) and one for the 
> pretimeout/timer1.

Hi Chris

If the regular watchdog interrupt would never actually fire because
the SoC gets reset, maybe make the IRQ handler call
watchdog_notify_pretimeout()?

	Andrew
