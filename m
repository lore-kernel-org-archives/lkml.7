Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94312ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7291720872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387822AbfJOU3M convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 16:29:12 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39494 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbfJOU3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 16:29:11 -0400
Received: from remote.shanghaihotelholland.com ([46.44.148.63] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iKTRI-00086W-DK; Tue, 15 Oct 2019 22:29:04 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        kernel-janitors@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: clk: rockchip: Checking a kmemdup() call in rockchip_clk_register_pll()
Date:   Tue, 15 Oct 2019 22:29:03 +0200
Message-ID: <5173392.uhhkXBHGmO@phil>
In-Reply-To: <45588ab8-2a6c-3f29-61ff-bccf8d6fb291@web.de>
References: <e96505a8-b554-f61e-3940-0b9e9c7850ff@web.de> <2588953.0pqkEXWxhN@phil> <45588ab8-2a6c-3f29-61ff-bccf8d6fb291@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 14. Oktober 2019, 09:26:41 CEST schrieb Markus Elfring:
> > The other option would be to panic, but the kernel should not
> > panic if other options are available - and continuing with a static
> > pll frequency is less invasive in the error case.
> 
> I would like to point out that this function implementation contains
> the following source code already.
> 
> …
> 	/* name the actual pll */
> 	snprintf(pll_name, sizeof(pll_name), "pll_%s", name);
> 
> 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> 	if (!pll)
> 		return ERR_PTR(-ENOMEM);
> …
> 
> 
> 
> …
> > +++ b/drivers/clk/rockchip/clk-pll.c
> > @@ -909,14 +909,16 @@ struct clk *rockchip_clk_register_pll(struct rockchip_clk_provider *ctx,
> …
> > -		pll->rate_count = len;
> >  		pll->rate_table = kmemdup(rate_table,
> >  					pll->rate_count *
> >  					sizeof(struct rockchip_pll_rate_table),
> >  					GFP_KERNEL);
> > -		WARN(!pll->rate_table,
> > -			"%s: could not allocate rate table for %s\n",
> > -			__func__, name);
> > +
> > +		/*
> > +		 * Set num rates to 0 if kmemdup fails. That way the clock
> > +		 * at least can report its rate and stays usable.
> > +		 */
> > +		pll->rate_count = pll->rate_table ? len : 0;
> 
> Can an other error handling strategy make sense occasionally?
>
> 
> …
> 		if (!pll->rate_table) {
> 			clk_unregister(mux_clk);
> 			mux_clk = ERR_PTR(-ENOMEM);
> 			goto err_mux;
> 		}
> …
> 
> 
> Would you like to adjust such exception handling another bit?

Nope.

The big difference is that clocks rely heavily on their names to establish
the clock tree parentship. So the PLL cannot work without the name
but can provide some means of functionality without the rate-table
especially as bootloaders do generally initialize a PLL to some form of
sane frequency.

Heiko


