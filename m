Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647B5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B352133D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbfDDALO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:11:14 -0400
Received: from muru.com ([72.249.23.125]:44282 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfDDALN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:11:13 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 55FFA803A;
        Thu,  4 Apr 2019 00:11:27 +0000 (UTC)
Date:   Wed, 3 Apr 2019 17:11:09 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Pavel Machek <pavel@ucw.cz>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv6 4/4] drm/omap: add support for manually updated displays
Message-ID: <20190404001109.GZ49658@atomide.com>
References: <20190403195413.djfrgzuj7povdksi@earth.universe>
 <20190403201326.3127-1-sebastian.reichel@collabora.com>
 <20190403201326.3127-5-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403201326.3127-5-sebastian.reichel@collabora.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.com> [190403 20:14]:
> This adds the required infrastructure for manually updated displays,
> such as DSI command mode panels. While those panels often support
> partial updates we currently always do a full refresh.
> 
> The display will be refreshed when something calls the dirty callback,
> such as libdrm's drmModeDirtyFB(). This is currently being done at least
> by the kernel console and Xorg (with modesetting driver) in their
> default configuration. Weston does not implement this and the fbdev
> backend does not work (display will not update). Weston's DRM backend
> uses double buffering and the page flip will also trigger a display
> refresh.

I've tested this with Linux next and the latest lm3532
patches and it works fine as long as we leave out the
backlight = <&lcd_backlight> entry from dts like I
replied in the lm3532 tread. So as far as I'm concerned,
we're good to go:

Tested-by: Tony Lindgren <tony@atomide.com>
