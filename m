Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A60C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8C620674
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfDLLWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:22:42 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38862 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfDLLWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:22:42 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hEuGO-00057v-KS; Fri, 12 Apr 2019 13:22:32 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jonas Karlman <jonas@kwiboo.se>, Tomasz Figa <tfiga@chromium.org>,
        Randy Li <ayaka@soulik.info>,
        Ziyuan Xu <xzy.xu@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        ryandcase@chromium.org, Elaine Zhang <zhangqing@rock-chips.com>,
        mka@chromium.org, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] clk: rockchip: Fix video codec clocks on rk3288
Date:   Fri, 12 Apr 2019 13:22:31 +0200
Message-ID: <7155822.nnOPNdQpWs@diego>
In-Reply-To: <20190411135555.235625-1-dianders@chromium.org>
References: <20190411135555.235625-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 11. April 2019, 15:55:55 CEST schrieb Douglas Anderson:
> It appears that there is a typo in the rk3288 TRM.  For
> GRF_SOC_CON0[7] it says that 0 means "vepu" and 1 means "vdpu".  It's
> the other way around.
> 
> How do I know?  Here's my evidence:
> 
> 1. Prior to commit 4d3e84f99628 ("clk: rockchip: describe aclk_vcodec
>    using the new muxgrf type on rk3288") we always pretended that we
>    were using "aclk_vdpu" and the comment in the code said that this
>    matched the default setting in the system.  In fact the default
>    setting is 0 according to the TRM and according to reading memory
>    at bootup.  In addition rk3288-based Chromebooks ran like this and
>    the video codecs worked.
> 2. With the existing clock code if you boot up and try to enable the
>    new VIDEO_ROCKCHIP_VPU as a module (and without "clk_ignore_unused"
>    on the command line), you get errors like "failed to get ack on
>    domain 'pd_video', val=0x80208".  After flipping vepu/vdpu things
>    init OK.
> 3. If I export and add both the vepu and vdpu to the list of clocks
>    for RK3288_PD_VIDEO I can get past the power domain errors, but now
>    I freeze when the vpu_mmu gets initted.
> 4. If I just mark the "vdpu" as IGNORE_UNUSED then everything boots up
>    and probes OK showing that somehow the "vdpu" was important to keep
>    enabled.  This is because we were actually using it as a parent.
> 5. After this change I can hack "aclk_vcodec_pre" to parent from
>    "aclk_vepu" using assigned-clocks and the video codec still probes
>    OK.
> 6. Rockchip has said so on the mailing list [1].
> 
> ...so let's fix it.
> 
> Let's also add CLK_SET_RATE_PARENT to "aclk_vcodec_pre" as suggested
> by Jonas Karlman.  Prior to the same commit you could do
> clk_set_rate() on "aclk_vcodec" and it would change "aclk_vdpu".
> That's because "aclk_vcodec" was a simple gate clock (always gets
> CLK_SET_RATE_PARENT) and its direct parent was "aclk_vdpu".  After
> that commit "aclk_vcodec_pre" gets in the way so we need to add
> CLK_SET_RATE_PARENT to it too.
> 
> [1] https://lkml.kernel.org/r/1d17b015-9e17-34b9-baf8-c285dc1957aa@rock-chips.com
> 
> Fixes: 4d3e84f99628 ("clk: rockchip: describe aclk_vcodec using the new muxgrf type on rk3288")
> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> Suggested-by: Randy Li <ayaka@soulik.info>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied for 5.2

Thanks
Heiko


