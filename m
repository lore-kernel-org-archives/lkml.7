Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE18C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85AAA2077C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfDWKRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:17:54 -0400
Received: from gloria.sntech.de ([185.11.138.130]:60302 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfDWKRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:17:54 -0400
Received: from p57b772a1.dip0.t-ipconnect.de ([87.183.114.161] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hIsUl-0001mB-1B; Tue, 23 Apr 2019 12:17:47 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caesar Wang <caesar.wang@rock-chips.com>,
        linux-rockchip@lists.infradead.org, mka@chromium.org,
        ryandcase@chromium.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] clk: rockchip: undo several noc and special clocks as critical on rk3288
Date:   Tue, 23 Apr 2019 12:17:46 +0200
Message-ID: <3726336.aAcGqF7Y7P@phil>
In-Reply-To: <20190412161747.107107-1-dianders@chromium.org>
References: <20190412161747.107107-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 12. April 2019, 18:17:47 CEST schrieb Douglas Anderson:
> This is mostly a revert of commit 55bb6a633c33 ("clk: rockchip: mark
> noc and some special clk as critical on rk3288") except that we're
> keeping "pmu_hclk_otg0" as critical still.
> 
> NOTE: turning these clocks off doesn't seem to do a whole lot in terms
> of power savings (checking the power on the logic rail).  It appears
> to save maybe 1-2mW.  ...but still it seems like we should turn the
> clocks off if they aren't needed.
> 
> About "pmu_hclk_otg0" (the one clock from the original commit we're
> still keeping critical) from an email thread:
> 
> > pmu ahb clock
> >
> > Function: Clock to pmu module when hibernation and/or ADP is
> > enabled. Must be greater than or equal to 30 MHz.
> >
> > If the SOC design does not support hibernation/ADP function, only have
> > hclk_otg, this clk can be switched according to the usage of otg.
> > If the SOC design support hibernation/ADP, has two clocks, hclk_otg and
> > pmu_hclk_otg0.
> > Hclk_otg belongs to the closed part of otg logic, which can be switched
> > according to the use of otg.
> >
> > pmu_hclk_otg0 belongs to the always on part.
> >
> > As for whether pmu_hclk_otg0 can be turned off when otg is not in use,
> > we have not tested. IC suggest make pmu_hclk_otg0 always on.
> 
> For the rest of the clocks:
> 
> atclk: No documentation about this clock other than that it goes to
> the CPU.  CPU functions fine without it on.  Maybe needed for JTAG?
> 
> jtag: Presumably this clock is only needed if you're debugging with
> JTAG.  It doesn't seem like it makes sense to waste power for every
> rk3288 user.  In any case to do JTAG you'd need private patches to
> adjust the pinctrl the mux the JTAG out anyway.
> 
> pclk_dbg, pclk_core_niu: On veyron Chromebooks we turn these two
> clocks on only during kernel panics in order to access some coresight
> registers.  Since nothing in the upstream kernel does this we should
> be able to leave them off safely.  Maybe also needed for JTAG?
> 
> hsicphy12m_xin12m: There is no indication of why this clock would need
> to be turned on for boards that don't use HSIC.
> 
> pclk_ddrupctl[0-1], pclk_publ0[0-1]: On veyron Chromebooks we turn
> these 4 clocks on only when doing DDR transitions and they are off
> otherwise.  I see no reason why they'd need to be on in the upstream
> kernel which doesn't support DDRFreq.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied for 5.2

Thanks
Heiko


