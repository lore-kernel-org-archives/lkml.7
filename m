Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C0BC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865A82072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgAHLCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:02:21 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:51023 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgAHLCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:02:20 -0500
Received: from localhost (lfbn-lyo-1-1670-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id A185C240003;
        Wed,  8 Jan 2020 11:02:18 +0000 (UTC)
Date:   Wed, 8 Jan 2020 12:02:18 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: at91: add sama5d3 pmc driver
Message-ID: <20200108110218.GT3040@piout.net>
References: <20191229202907.335931-1-alexandre.belloni@bootlin.com>
 <20200106030905.8643221582@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106030905.8643221582@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2020 19:09:04-0800, Stephen Boyd wrote:
> > +       return;
> > +
> > +err_free:
> > +       pmc_data_free(sama5d3_pmc);
> > +}
> > +CLK_OF_DECLARE_DRIVER(sama5d3_pmc, "atmel,sama5d3-pmc", sama5d3_pmc_setup);
> 
> Any reason this can't be a platform driver?
> 

As for the other PMC driver, we need a few of the peripheral clocks very
early which means that we would have to register most of the clock tree
registered early leaving only a few clocks to be registered by a
platform driver.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
