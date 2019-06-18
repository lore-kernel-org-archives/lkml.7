Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6629C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79B0206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbfFRJz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:55:26 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:34991 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfFRJzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:55:25 -0400
X-Originating-IP: 92.137.69.152
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 95FB3FF81A;
        Tue, 18 Jun 2019 09:55:22 +0000 (UTC)
Date:   Tue, 18 Jun 2019 11:55:21 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu.Beznea@microchip.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        Nicolas.Ferre@microchip.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        claudiu.beznea@gmail.com
Subject: Re: [PATCH 0/7] clk: at91: sckc: improve error path
Message-ID: <20190618095521.GE23549@piout.net>
References: <1560440205-4604-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560440205-4604-1-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2019 15:37:06+0000, Claudiu.Beznea@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Hi,
> 
> This series tries to improve error path for slow clock registrations
> by adding functions to free resources and using them on failures.
> 

Does the platform even boot when the slow clock is not available? 

The TCB clocksource would fail at:

        tc.slow_clk = of_clk_get_by_name(node->parent, "slow_clk");
        if (IS_ERR(tc.slow_clk))
                return PTR_ERR(tc.slow_clk);


> It is created on top of patch series at [1].
> 
> Thank you,
> Claudiu Beznea
> 
> [1] https://lore.kernel.org/lkml/1558433454-27971-1-git-send-email-claudiu.beznea@microchip.com/
> 
> Claudiu Beznea (7):
>   clk: at91: sckc: add support to free slow oscillator
>   clk: at91: sckc: add support to free slow rc oscillator
>   clk: at91: sckc: add support to free slow clock osclillator
>   clk: at91: sckc: improve error path for sam9x5 sck register
>   clk: at91: sckc: remove unnecessary line
>   clk: at91: sckc: improve error path for sama5d4 sck registration
>   clk: at91: sckc: use dedicated functions to unregister clock
> 
>  drivers/clk/at91/sckc.c | 122 ++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 86 insertions(+), 36 deletions(-)
> 
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
