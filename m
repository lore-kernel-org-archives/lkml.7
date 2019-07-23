Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E698C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7592239E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387516AbfGWIiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 04:38:54 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:43510 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbfGWIiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:38:54 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id BF6A080480;
        Tue, 23 Jul 2019 10:38:48 +0200 (CEST)
Date:   Tue, 23 Jul 2019 10:38:47 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-fbdev@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/4] video: of: display_timing: Adjust err printing of
 of_get_display_timing()
Message-ID: <20190723083847.GA32268@ravnborg.org>
References: <20190722182439.44844-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722182439.44844-1-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8
        a=7gkXJVJtAAAA:8 a=j5P04vaaSkZOzqOPo0QA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dough.

On Mon, Jul 22, 2019 at 11:24:35AM -0700, Douglas Anderson wrote:
> As reported by Sam Ravnborg [1], after commit b8a2948fa2b3
> ("drm/panel: simple: Add ability to override typical timing") we now
> see a pointless error message printed on every boot for many systems.
> Let's fix that by adjusting who is responsible for printing error
> messages when of_get_display_timing() is used.
> 
> Most certainly we can bikeshed the topic about whether this is the
> right fix or we should instead add logic to panel_simple_probe() to
> avoid calling of_get_display_timing() in the case where there is no
> "panel-timing" sub-node.  If there is consensus that I should move the
> fix to panel_simple_probe() I'm happy to spin this series.  In that
> case we probably should _remove_ the extra prints that were already
> present in the other two callers of of_get_display_timing().
> 
> While at it, fix a missing of_node_put() found by code inspection.
> 
> NOTE: amba-clcd and panel-lvds were only compile-tested.
> 
> [1] https://lkml.kernel.org/r/20190721093815.GA4375@ravnborg.org
> 
> 
> Douglas Anderson (4):
>   video: of: display_timing: Add of_node_put() in
>     of_get_display_timing()
>   video: of: display_timing: Don't yell if no timing node is present
>   drm: panel-lvds: Spout an error if of_get_display_timing() gives an
>     error
>   video: amba-clcd: Spout an error if of_get_display_timing() gives an
>     error

Series looks good - thanks.
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

You could consider silencing display_timing as the last patch, but thats
a very small detail.

How do we apply these fixes - to drm-misc-next? Bartlomiej?

No need to go in via drm-misc-fixes as the offending commit is only in
drm-misc-next.

	Sam
