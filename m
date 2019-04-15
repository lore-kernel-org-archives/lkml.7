Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECC6C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC70B2146E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfDOOOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:14:33 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:54003 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfDOOOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:14:33 -0400
X-Originating-IP: 109.212.207.226
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id B2F95FF81F;
        Mon, 15 Apr 2019 14:14:28 +0000 (UTC)
Date:   Mon, 15 Apr 2019 16:14:28 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 04/12] clocksource/drivers/tcb_clksrc: stop depending on
 atmel_tclib
Message-ID: <20190415141428.GE3578@piout.net>
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
 <20190403141120.32754-5-alexandre.belloni@bootlin.com>
 <7ce7342d-7fa2-d2b0-621d-2c47a0e5cdba@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ce7342d-7fa2-d2b0-621d-2c47a0e5cdba@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2019 18:19:34+0200, Daniel Lezcano wrote:
> > +	tc.clk[0] = t0_clk;
> > +	tc.clk[1] = of_clk_get_by_name(node->parent, "t1_clk");
> > +	if (IS_ERR(tc.clk[1]))
> > +		tc.clk[1] = t0_clk;
> > +	tc.clk[2] = of_clk_get_by_name(node->parent, "t2_clk");
> > +	if (IS_ERR(tc.clk[2]))
> > +		tc.clk[2] = t0_clk;
> > +	tc.irq[0] = irq;
> > +	tc.irq[1] = of_irq_get(node->parent, 1);
> > +	if (tc.irq[1] <= 0)
> > +		tc.irq[1] = irq;
> > +	tc.irq[2] = of_irq_get(node->parent, 2);
> > +	if (tc.irq[2] <= 0)
> > +		tc.irq[2] = irq;
> 
> Why are clk[1/2] and irq[1/2] defaulting back to t0 in case of error?
> 

This is how the DT binding is madewhen the same IRQ/clk is used for all
the channels of the TCB, then it is only specified once. Unfortunately,
this has to be kept to keep backward DT compatibility. Still, I'm
reworking the irq paring as the driver only needs the irq for channel 2.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
