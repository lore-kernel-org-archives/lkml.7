Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C108C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B06C20857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfCSJYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:24:49 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:50733 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfCSJYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 05:24:48 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 060C440003;
        Tue, 19 Mar 2019 09:24:43 +0000 (UTC)
Date:   Tue, 19 Mar 2019 10:24:38 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nicolas.Ferre@microchip.com
Cc:     sboyd@kernel.org, linux-clk@vger.kernel.org,
        Ludovic.Desroches@microchip.com, Claudiu.Beznea@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, matthias.wieloch@few-bauer.de,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] clk: at91: fix programmable clock for sama5d2
Message-ID: <20190319092438.GC29054@piout.net>
References: <20190318105045.26943-1-nicolas.ferre@microchip.com>
 <155293884206.20095.9858756917267939797@swboyd.mtv.corp.google.com>
 <dd4a32fe-4942-83a8-a2c4-336e3c6e55b3@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd4a32fe-4942-83a8-a2c4-336e3c6e55b3@microchip.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2019 08:28:40+0000, Nicolas Ferre wrote:
> > Ok. I can apply this clk-fixes. I presume that things are real bad and
> > it can't wait until v5.2?
> 
> To be perfectly clear, it's not a regression.
> But as we're at the very beginning of the '-rc' phase and as it's a bug, 
> I was thinking about adding it now. But you to choose, no problem either 
> way.
> 
> >> @@ -60,10 +68,18 @@ static int clk_programmable_determine_rate(struct clk_hw *hw,
> >>                          continue;
> >>   
> >>                  parent_rate = clk_hw_get_rate(parent);
> >> -               for (shift = 0; shift < PROG_PRES_MASK; shift++) {
> >> -                       tmp_rate = parent_rate >> shift;
> >> -                       if (tmp_rate <= req->rate)
> >> -                               break;
> >> +               if (layout->is_pres_direct) {
> >> +                       for (shift = 0; shift <= layout->pres_mask; shift++) {
> >> +                               tmp_rate = parent_rate / (shift + 1);
> >> +                               if (tmp_rate <= req->rate)
> >> +                                       break;
> >> +                       }
> >> +               } else {
> >> +                       for (shift = 0; shift < layout->pres_mask; shift++) {
> >> +                               tmp_rate = parent_rate >> shift;
> >> +                               if (tmp_rate <= req->rate)
> >> +                                       break;
> >> +                       }
> > 
> > This looks like a lot of copy paste when the if statement could have been
> > pulled into the for loop instead of duplicating the loops and
> > surrounding if condition check for tmp_rate.
> 
> Stop condition of loops not being the same made me separate them instead 
> of adding artificial test conditions for shift == layout->pres_mask. I'm 
> not sure the other way around is more obvious then...
> 

I also tried different ways (e.g. setting up a different determine_rate
for the sama5d2) but this ended up being the more concise one.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
