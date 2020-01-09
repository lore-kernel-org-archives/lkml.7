Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3C2C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5098520721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgAIVlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:41:32 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:59947 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgAIVlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:41:32 -0500
X-Originating-IP: 90.65.92.102
Received: from localhost (lfbn-lyo-1-1913-102.w90-65.abo.wanadoo.fr [90.65.92.102])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id B26101C0003;
        Thu,  9 Jan 2020 21:41:29 +0000 (UTC)
Date:   Thu, 9 Jan 2020 22:41:28 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: at91: add sama5d3 pmc driver
Message-ID: <20200109214128.GB1027187@piout.net>
References: <20191229202907.335931-1-alexandre.belloni@bootlin.com>
 <20200106030905.8643221582@mail.kernel.org>
 <20200108110218.GT3040@piout.net>
 <20200109181910.59B2B206ED@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109181910.59B2B206ED@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2020 10:19:09-0800, Stephen Boyd wrote:
> Quoting Alexandre Belloni (2020-01-08 03:02:18)
> > On 05/01/2020 19:09:04-0800, Stephen Boyd wrote:
> > > > +       return;
> > > > +
> > > > +err_free:
> > > > +       pmc_data_free(sama5d3_pmc);
> > > > +}
> > > > +CLK_OF_DECLARE_DRIVER(sama5d3_pmc, "atmel,sama5d3-pmc", sama5d3_pmc_setup);
> > > 
> > > Any reason this can't be a platform driver?
> > > 
> > 
> > As for the other PMC driver, we need a few of the peripheral clocks very
> > early which means that we would have to register most of the clock tree
> > registered early leaving only a few clocks to be registered by a
> > platform driver.
> > 
> 
> What peripheral clks? Can you add a comment to the code?
> 

The TCB is used as the clocksource so its clock is needed. Its parent is
the master clock which has UTMI, PLLA, the mainclock and the slow clock
as parents so by that point, most of the tree is registered.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
