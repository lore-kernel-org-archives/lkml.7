Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DF0C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D20205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbfFRRX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 13:23:26 -0400
Received: from mailoutvs37.siol.net ([185.57.226.228]:57499 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729325AbfFRRXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:23:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 1EA4E5203EB;
        Tue, 18 Jun 2019 19:23:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SvDg82OCXHri; Tue, 18 Jun 2019 19:23:21 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id A4E9F5223EF;
        Tue, 18 Jun 2019 19:23:21 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id 76FF65203EB;
        Tue, 18 Jun 2019 19:23:18 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        seanpaul@chromium.org, heiko@sntech.de, jonas@kwiboo.se,
        linux-rockchip@lists.infradead.org, narmstrong@baylibre.com,
        dgreid@chromium.org, cychiang@chromium.org,
        David Airlie <airlied@linux.ie>,
        Zheng Yang <zhengyang@rock-chips.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/bridge/synopsys: dw-hdmi: Handle audio for more clock rates
Date:   Tue, 18 Jun 2019 19:23:18 +0200
Message-ID: <6219398.I55JWXAmVF@jernej-laptop>
In-Reply-To: <20190617235558.64571-1-dianders@chromium.org>
References: <20190617235558.64571-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne torek, 18. junij 2019 ob 01:55:58 CEST je Douglas Anderson napisal(a):
> Let's add some better support for HDMI audio to dw_hdmi.
> Specifically:
> 
> 1. For 44.1 kHz audio the old code made the assumption that an N of
> 6272 was right most of the time.  That wasn't true and the new table
> should give better 44.1 kHz audio for many more rates.
> 
> 2. The new table has values from the HDMI spec for 297 MHz and 594
> MHz.
> 
> 3. There is now code to try to come up with a more idea N/CTS for
> clock rates that aren't in the table.  This code is a bit slow because
> it iterates over every possible value of N and picks the best one, but
> it should make a good fallback.
> 
> 4. The new code allows for platforms that know they make a clock rate
> slightly differently to pick different N/CTS values.  For instance on
> rk3288 we can make 25,176,471 Hz instead of 25,174,825.1748... Hz
> (25.2 MHz / 1.001).  A future patch to the rk3288 platform code could
> enable support for this clock rate and specify the N/CTS that would be
> ideal.
> 
> NOTE: the oddest part of this patch comes about because computing the
> ideal N/CTS means knowing the _exact_ clock rate, not a rounded
> version of it.  The drm framework makes this harder by rounding rates
> to kHz, but even if it didn't there might be cases where the ideal
> rate could only be calculated if we knew the real (non-integral) rate.
> This means that in cases where we know (or believe) that the true rate
> is something other than the rate we are told by drm.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Which bus is used for audio transfer on your device? If it is I2S, which is 
commonly used, then please be aware of this patch:
https://lists.freedesktop.org/archives/dri-devel/2019-June/221539.html

It avoids exact N/CTS calculation by enabling auto detection. It is well 
tested on multiple SoCs from Allwinner, Amlogic and Rockchip.

Best regards,
Jernej


