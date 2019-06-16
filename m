Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F8BC31E53
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 13:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAA42147A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 13:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfFPNle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 09:41:34 -0400
Received: from gloria.sntech.de ([185.11.138.130]:60012 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfFPNle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 09:41:34 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hcVPP-0006LO-9I; Sun, 16 Jun 2019 15:41:23 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Sandy Huang <hjc@rock-chips.com>, seanpaul@chromium.org,
        linux-rockchip@lists.infradead.org, urjaman@gmail.com,
        Yakir Yang <ykk@rock-chips.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/2] drm/rockchip: Properly adjust to a true clock in adjusted_mode
Date:   Sun, 16 Jun 2019 15:41:22 +0200
Message-ID: <2111307.tjTOxoAehH@diego>
In-Reply-To: <20190614224730.98622-1-dianders@chromium.org>
References: <20190614224730.98622-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 15. Juni 2019, 00:47:29 CEST schrieb Douglas Anderson:
> When fixing up the clock in vop_crtc_mode_fixup() we're not doing it
> quite correctly.  Specifically if we've got the true clock 266666667 Hz,
> we'll perform this calculation:
>    266666667 / 1000 => 266666
> 
> Later when we try to set the clock we'll do clk_set_rate(266666 *
> 1000).  The common clock framework won't actually pick the proper clock
> in this case since it always wants clocks <= the specified one.
> 
> Let's solve this by using DIV_ROUND_UP.
> 
> Fixes: b59b8de31497 ("drm/rockchip: return a true clock rate to adjusted_mode")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Reviewed-by: Yakir Yang <ykk@rock-chips.com>

I gave both patches a testrun on rk3288, rk3328 and rk3399 and
applied them to drm-misc-next thereafter


Thanks
Heiko



