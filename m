Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA1DC742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 19:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C62120872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 19:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfGKTfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 15:35:48 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:51218 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbfGKTfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 15:35:47 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 4568880395;
        Thu, 11 Jul 2019 21:35:41 +0200 (CEST)
Date:   Thu, 11 Jul 2019 21:35:39 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Enric =?iso-8859-1?Q?Balletb=F2?= <enric.balletbo@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 0/7] drm/panel: simple: Add mode support to devicetree
Message-ID: <20190711193539.GA5912@ravnborg.org>
References: <20190401171724.215780-1-dianders@chromium.org>
 <CAD=FV=Vi2C7s2oWBDD0n+HK=_SuBYhRM9saMK-y6Qa0+k-g17w@mail.gmail.com>
 <20190628171342.GA2238@ravnborg.org>
 <2169143.hEFa8b2HQR@diego>
 <CAD=FV=U3Wj8vaZcQLmkfX6zgjVFEra+GrHMH3OCs5QQ_-tM4hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=U3Wj8vaZcQLmkfX6zgjVFEra+GrHMH3OCs5QQ_-tM4hw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=5PwMyr1ww-aXvGv-uLAA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dough.

> > So Thierry was able to look at the patches yesterday it seems and has Acked
> > all the relevant ones. As a drm-misc-contributor I could also apply them
> > myself, but now don't want to preempt any additional comments you might
> > have ;-) . So I guess my question would be if you still want to do a review
> > or if I should apply them.
> 
> Hopefully you saw, but I responded to all of your review feedback.  In
> the end, I thought it'd be OK to land the series as-is and I can fix
> up nits in a follow-up series, though I'm waiting for your responses
> to a couple questions first.
> 
> It would be ideal if you could confirm that you're OK with this plan
> even if you don't have time to respond in detail to my emails yet.  I
> think Heiko can land them all through the appropriate channels since
> the patches have all the proper Acks.
My main concern was the bug cocerning override_mode - which turned out to
be me confused.
There is one part about flags that does not yet makes sense but
we can fix it later.

Please resend a series that applies to drm-misc-next so
we can land this.

	Sam
