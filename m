Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5788DC742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 21:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC3D21019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 21:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfGKV2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 17:28:19 -0400
Received: from gloria.sntech.de ([185.11.138.130]:36214 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbfGKV2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 17:28:19 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hlgbu-0006n4-SN; Thu, 11 Jul 2019 23:28:14 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Enric =?ISO-8859-1?Q?Balletb=F2?= <enric.balletbo@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, mka@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 7/7] ARM: dts: rockchip: Specify rk3288-veyron-minnie's display timings
Date:   Thu, 11 Jul 2019 23:28:14 +0200
Message-ID: <10427933.3dknIRnSiX@diego>
In-Reply-To: <20190401171724.215780-8-dianders@chromium.org>
References: <20190401171724.215780-1-dianders@chromium.org> <20190401171724.215780-8-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 1. April 2019, 19:17:24 CEST schrieb Douglas Anderson:
> Just like we did for rk3288-veyron-chromebook, we want to be able to
> use one of the fixed PLLs in the system to make the pixel clock for
> minnie.
> 
> Specifying these timings matches us with how the display is used on
> the downstream Chrome OS kernel.  See https://crrev.com/c/323211.
> 
> Unlike what we did for rk3288-veyron-chromebook, this CL actually
> changes the timings (though not the pixel clock) that is used when
> using the upstream kernel.  Booting up a minnie shows that it ended up
> with a 66.67 MHz pixel clock but it was still using the
> porches/blankings it would have wanted for a 72.5 MHz pixel clock.
> 
> NOTE: compared to the downstream kernel, this seems to cause a
> slightly different result reported in the 'modetest' command on a
> Chromebook.  The downstream kernel shows:
>   1280x800 60 1280 1298 1330 1351 800 804 822 830 66667
> 
> With this patch we have:
>   1280x800 59 1280 1298 1330 1351 800 804 822 830 66666
> 
> Specifically modetest was reporting 60 Hz on the downstream kernel but
> the upstream kernel does the math and comesup with 59 (because we
> actually achieve 59.45 Hz).  Also upstream doesn't round the Hz up
> when converting to kHz--it seems to truncate.
> 
> ALSO NOTE: when I look at the EDID from the datasheet, I see:
>   -hsync -vsync
> ...but it seems like we've never actually run with that so I've
> continued leaving that out.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied for 5.4

Thanks
Heiko


