Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C77DC282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6836E2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfDLKGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:06:54 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37758 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbfDLKGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:06:53 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hEt54-0004eM-CE; Fri, 12 Apr 2019 12:06:46 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>, dbasehore@chromium.org,
        amstan@chromium.org, linux-rockchip@lists.infradead.org,
        briannorris@chromium.org, mka@chromium.org, ryandcase@chromium.org,
        Chris Zhong <zyw@rock-chips.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] clk: rockchip: Turn on "aclk_dmac1" for suspend
Date:   Fri, 12 Apr 2019 12:06:45 +0200
Message-ID: <17495106.TRDjcDkMKC@diego>
In-Reply-To: <20190411232157.55125-1-dianders@chromium.org>
References: <20190411232157.55125-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 12. April 2019, 01:21:53 CEST schrieb Douglas Anderson:
> Experimentally it can be seen that going into deep sleep (specifically
> setting PMU_CLR_DMA and PMU_CLR_BUS in RK3288_PMU_PWRMODE_CON1)
> appears to fail unless "aclk_dmac1" is on.  The failure is that the
> system never signals that it made it into suspend on the GLOBAL_PWROFF
> pin and it just hangs.
> 
> NOTE that it's confirmed that it's the actual suspend that fails, not
> one of the earlier calls to read/write registers.  Specifically if you
> comment out the "PMU_GLOBAL_INT_DISABLE" setting in
> rk3288_slp_mode_set() and then comment out the "cpu_do_idle()" call in
> rockchip_lpmode_enter() then you can exercise the whole suspend path
> without any crashing.
> 
> This is currently not a problem with suspend upstream because there is
> no current way to exercise the deep suspend code.  However, anyone
> trying to make it work will run into this issue.
> 
> This was not a problem on shipping rk3288-based Chromebooks because
> those devices all ran on an old kernel based on 3.14.  On that kernel
> "aclk_dmac1" appears to be left on all the time.
> 
> There are several ways to skin this problem.
> 
> A) We could add "aclk_dmac1" to the list of critical clocks and that
> apperas to work, but presumably that wastes power.
> 
> B) We could keep a list of "struct clk" objects to enable at suspend
> time in clk-rk3288.c and use the standard clock APIs.
> 
> C) We could make the rk3288-pmu driver keep a list of clocks to enable
> at suspend time.  Presumably this would require a dts and bindings
> change.
> 
> D) We could just whack the clock on in the existing syscore suspend
> function where we whack a bunch of other clocks.  This is particularly
> easy because we know for sure that the clock's only parent
> ("aclk_cpu") is a critical clock so we don't need to do anything more
> than ungate it.
> 
> In this case I have chosen D) because it seemed like the least work,
> but any of the other options would presumably also work fine.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied for 5.2 with Elaine's rb

Thanks
Heiko


