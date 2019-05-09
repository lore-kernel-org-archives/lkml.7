Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1871C04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA7021479
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfEIIqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 04:46:06 -0400
Received: from gloria.sntech.de ([185.11.138.130]:50396 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfEIIqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 04:46:06 -0400
Received: from we0048.dip.tu-dresden.de ([141.76.176.48] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hOege-00020Z-Rr; Thu, 09 May 2019 10:45:56 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>, hal@halemmerich.com,
        amstan@chromium.org, Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] clk: rockchip: Slightly more accurate math in rockchip_mmc_get_phase()
Date:   Thu, 09 May 2019 10:45:56 +0200
Message-ID: <1830378.zUSKOufHgj@phil>
In-Reply-To: <20190507205742.50835-1-dianders@chromium.org>
References: <20190507205742.50835-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 7. Mai 2019, 22:57:42 CEST schrieb Douglas Anderson:
> There's a bit of math in rockchip_mmc_get_phase() to calculate the
> "fine delay".  This math boils down to:
> 
>  PSECS_PER_SEC = 1000000000000.
>  ROCKCHIP_MMC_DELAY_ELEMENT_PSEC = 60
>  card_clk * ROCKCHIP_MMC_DELAY_ELEMENT_PSEC * 360 * x / PSECS_PER_SEC
> 
> ...but we do it in pieces to avoid overflowing 32-bits.  Right now we
> overdo it a little bit, though, and end up getting less accurate math
> than we could.  Right now we do:
> 
>  DIV_ROUND_CLOSEST((card_clk / 1000000) *
>                    (ROCKCHIP_MMC_DELAY_ELEMENT_PSEC / 10) *
>                    (360 / 10) *
> 		   delay_num,
> 		   PSECS_PER_SEC / 1000000 / 10 / 10)
> 
> This is non-ideal because:
> A) The pins on Rockchip SoCs are rated to go at most 150 MHz, so the
>    max card clock is 150 MHz.  Even ignoring this the maximum SD card
>    clock (for SDR104) would be 208 MHz.  This means you can decrease
>    your division by 100x and still not overflow:
>      hex(208000000 / 10000 * 6 * 36 * 0xff) == 0x44497200
> B) On many Rockchip SoCs we end up with a card clock that is actually
>    148500000 because we parent off the 297 MHz PLL.  That means the
>    math we're actually doing today is less than ideal.  Specifically:
>    148500000 / 1000000 = 148
> 
> Let's fix the math to be slightly more accurate.
> 
> NOTE: no known problems are fixed by this.  It was found simply by
> code inspection.  If you want to see the difference between the old
> and the new on a 148.5 MHz clock, this python can help:
> 
>   old = [x for x in
>          (int(round(148 * 6 * 36 * x / 10000.)) for x in range(256))
> 	 if x < 90]
>   new = [x for x in
>          (int(round(1485 * 6 * 36 * x / 100000.)) for x in range(256))
> 	 if x < 90]
> 
> The only differences are:
>   delay_num=17 54=>55
>   delay_num=22 70=>71
>   delay_num=27 86=>87
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

gave this a spin on multiple socs and all of them still detected a hs200-
card, so I've applied that for 5.3

Thanks
Heiko


