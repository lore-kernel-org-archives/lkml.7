Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A6AC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89383206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbfDYUbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:31:43 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:39857 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730805AbfDYUbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:31:43 -0400
X-Originating-IP: 90.66.53.80
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A9448E000E;
        Thu, 25 Apr 2019 20:31:39 +0000 (UTC)
Date:   Thu, 25 Apr 2019 22:31:39 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] clk: at91: add sam9x60 pmc driver
Message-ID: <20190425203139.GO14604@piout.net>
References: <20190402125056.21509-1-alexandre.belloni@bootlin.com>
 <20190402125056.21509-8-alexandre.belloni@bootlin.com>
 <155622113579.15276.15900194435736283135@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155622113579.15276.15900194435736283135@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2019 12:38:55-0700, Stephen Boyd wrote:
> Quoting Alexandre Belloni (2019-04-02 05:50:56)
> > diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
> > new file mode 100644
> > index 000000000000..22bf51c55bdc
> > --- /dev/null
> > +++ b/drivers/clk/at91/sam9x60.c
> > @@ -0,0 +1,307 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/clk-provider.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/slab.h>
> > +
> > +#include <dt-bindings/clock/at91.h>
> > +
> > +#include "pmc.h"
> > +
> > +DEFINE_SPINLOCK(pmc_pll_lock);
> > +
> > +static const struct clk_master_characteristics mck_characteristics = {
> > +       .output = { .min = 140000000, .max = 200000000 },
> > +       .divisors = { 1, 2, 4, 3 },
> > +       .have_div3_pres = 1,
> > +};
> > +
> > +static const struct clk_master_layout sam9x60_master_layout = {
> > +       .mask = 0x373,
> > +       .pres_shift = 4,
> > +       .offset = 0x28,
> > +};
> > +
> > +static struct clk_range plla_outputs[] = {
> 
> const?
> 

Right, can you fix that up or should I send a new version?

> > +       { .min = 300000000, .max = 600000000 },
> > +};
> [...]
> > +
> > +}
> > +
> > +CLK_OF_DECLARE_DRIVER(sam9x60_pmc, "microchip,sam9x60-pmc", sam9x60_pmc_setup);
> > -- 
> 
> Can't be platform device?
> 

IIRC two clocks are used by the clocksource and having it as a platform
device make the clocksource driver fail with -EPROBE_DEFER.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
