Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC60CC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DFB206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgAHKIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:08:40 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:45684 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgAHKIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:08:40 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id C7B5C80566;
        Wed,  8 Jan 2020 11:08:32 +0100 (CET)
Date:   Wed, 8 Jan 2020 11:08:31 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/drm_panel: fix export of drm_panel_of_backlight, try
 #3
Message-ID: <20200108100831.GA23308@ravnborg.org>
References: <20200107203231.920256-1-arnd@arndb.de>
 <87zheyqnla.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zheyqnla.fsf@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Vt2AcnKqAAAA:8
        a=QyXUC8HyAAAA:8 a=4k1t4WDYj-Gm4IL4ZnQA:9 a=CjuIK1q_8ugA:10
        a=v10HlyRyNeVhbzM4Lqgd:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jani.

On Wed, Jan 08, 2020 at 11:55:29AM +0200, Jani Nikula wrote:
> On Tue, 07 Jan 2020, Arnd Bergmann <arnd@arndb.de> wrote:
> > Making this IS_REACHABLE() was still wrong, as that just determines
> > whether the lower-level backlight code would be reachable from the panel
> > driver. However, with CONFIG_DRM=y and CONFIG_BACKLIGHT_CLASS_DEVICE=m,
> > the drm_panel_of_backlight is left out of drm_panel.o but the condition
> > tells the driver that it is there, leading to multiple link errors such as
> >
> > ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-sitronix-st7701.ko] undefined!
> > ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-sharp-ls043t1le01.ko] undefined!
> > ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-seiko-43wvf1g.ko] undefined!
> > ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-ronbo-rb070d30.ko] undefined!
> > ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-rocktech-jh057n00900.ko] undefined!
> > ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.ko] undefined!
> > ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.ko] undefined!
> >
> > Change the condition to check for whether the function was actually part
> > of the drm module. This version of the patch survived a few hundred
> > randconfig builds, so I have a good feeling this might be the last
> > one for the export.
> 
> Broken record, this will still be wrong, even if it builds and links. No
> backlight support for panel despite expectations.
> 
> See http://mid.mail-archive.com/87d0cnynst.fsf@intel.com
> 
> All of this is just another hack until the backlight config usage is
> fixed for good. Do we really want to make this the example to copy paste
> wherever we hit the issue next?
> 
> I'm not naking, but I'm not acking either.

I will try to take a look at your old BACKLIGHT_CLASS_DEVICE patch this
weekend. I think we need that one fixed - and then we can have this mess
with "drm_panel_of_backlight" fixed in the right way.

Sigh...

	Sam
