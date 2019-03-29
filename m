Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38665C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33E2218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbfC2TSE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 15:18:04 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40010 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729720AbfC2TSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 15:18:04 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h9x0o-0000Pg-Ls; Fri, 29 Mar 2019 20:17:58 +0100
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
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v4 4/7] drm/panel: simple: Use display_timing for Innolux n116bge
Date:   Fri, 29 Mar 2019 20:17:57 +0100
Message-ID: <4434574.6rqfZtZq1D@diego>
In-Reply-To: <20190328171710.31949-5-dianders@chromium.org>
References: <20190328171710.31949-1-dianders@chromium.org> <20190328171710.31949-5-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 28. März 2019, 18:17:07 CET schrieb Douglas Anderson:
> Convert the Innolux n116bge from using a fixed mode to specifying a
> display timing with min/typ/max values.
> 
> Note that the n116bge's datasheet doesn't fit too well into DRM's way
> of specifying things.  Specifically the panel's datasheet just
> specifies the vertical blanking period and horizontal blanking period
> and doesn't break things out.  For now we'll leave everything as a
> fixed value but just allow adjusting the pixel clock.  I've added a
> comment on what the datasheet claims so someone could later expand
> things to fit their needs if they wanted to test other blanking
> periods.
> 
> The goal here is to be able to specify the panel timings in the device
> tree for several rk3288 Chromebooks (like rk3288-veryon-jerry).  These
> Chromebooks have all been running in the downstream kernel with the
> standard porches and sync lengths but just with a slightly slower
> pixel clock because the 76.42 MHz clock is not achievable from the
> fixed PLL that was available.  These Chromebooks only achieve a
> refresh rate of ~58 Hz.  While it's probable that we could adjust the
> timings to achieve 60 Hz it's probably wisest to match what's been
> running on these devices all these years.
> 
> I'll note that though the upstream kernel has always tried to achieve
> 76.42 MHz, it has actually been running at 74.25 MHz also since the
> video processor is parented off the same fixed PLL.
> 
> Changes in v4:
>  - display_timing for Innolux n116bge new for v4.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

on a rk3288-jerry and rk3288-pinky
Tested-by: Heiko Stuebner <heiko@sntech.de>



