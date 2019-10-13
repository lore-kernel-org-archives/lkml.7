Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975EBC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 21:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757E420815
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 21:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbfJMVuL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 17:50:11 -0400
Received: from gloria.sntech.de ([185.11.138.130]:50466 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728982AbfJMVuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 17:50:10 -0400
Received: from i59f7e0c5.versanet.de ([89.247.224.197] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iJlkV-0004sv-Rh; Sun, 13 Oct 2019 23:50:00 +0200
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
Date:   Sun, 13 Oct 2019 23:49:54 +0200
Message-ID: <2588953.0pqkEXWxhN@phil>
In-Reply-To: <29d12079-d888-e090-da5a-c407c13d696b@web.de>
References: <e96505a8-b554-f61e-3940-0b9e9c7850ff@web.de> <5801053.xxhhKtLrcJ@diego> <29d12079-d888-e090-da5a-c407c13d696b@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 13. Oktober 2019, 10:45:09 CEST schrieb Markus Elfring:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/rockchip/clk-pll.c?id=1c0cc5f1ae5ee5a6913704c0d75a6e99604ee30a#n913
> >> https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/clk/rockchip/clk-pll.c#L913
> >>
> >> * Do you find the usage of the format string “%s: could not allocate
> >>   rate table for %s\n” still appropriate at this place?
> >
> > If there is an internal "no-memory" output from inside kmemdup now,
> > I guess the one in the clock driver would be a duplicate and could go away.
> 
> How do you think about to recheck information sources around
> the Linux allocation failure report?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=da94001239cceb93c132a31928d6ddc4214862d5#n878
> 
> 
> >> * Is there a need to adjust the error handling here?
> >
> > There is no need for additional error handling.
> 
> If you would like to omit the macro call “WARN”, I would expect also
> to express a corresponding null pointer check.

So I guess we want something like the change at the bottom.


> > Like if the rate-table could not be duplicated,
> > the clock will still report the correct clockrate
> > you can just not set a new rate.
> 
> How much will a different system configuration matter finally?
> (Do you really want to treat this setting as “optional”?)
> 
> > And for a system it's always better to have the clock driver present
> > than for all device-drivers to fail probing. Especially as this start as
> > core clock driver, so there is no deferring possible.
> 
> I imagine that such a view can be clarified further.

The core soc clock driver gets initialized through CLK_OF_DECLARE(),
aka real early during boot. So if the kmemdup fails there can not be
any -EPROBE_DEFER, as there is no kernel-driver-model running yet.

All other components of the system of course depend on the clock-
controller being available, so that way the system can at least come
up further so that people might be able to debug their issue further.

The other option would be to panic, but the kernel should not
panic if other options are available - and continuing with a static
pll frequency is less invasive in the error case.

Heiko

------ 8< -------
diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index 198417d56300..17bfac611e79 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -909,14 +909,16 @@ struct clk *rockchip_clk_register_pll(struct rockchip_clk_provider *ctx,
 		for (len = 0; rate_table[len].rate != 0; )
 			len++;
 
-		pll->rate_count = len;
 		pll->rate_table = kmemdup(rate_table,
 					pll->rate_count *
 					sizeof(struct rockchip_pll_rate_table),
 					GFP_KERNEL);
-		WARN(!pll->rate_table,
-			"%s: could not allocate rate table for %s\n",
-			__func__, name);
+
+		/*
+		 * Set num rates to 0 if kmemdup fails. That way the clock
+		 * at least can report its rate and stays usable.
+		 */
+		pll->rate_count = pll->rate_table ? len : 0;
 	}
 
 	switch (pll_type) {



