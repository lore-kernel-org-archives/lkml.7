Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EABC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AF0218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfGZNQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:16:14 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:36466 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbfGZNQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:16:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 77030FB03;
        Fri, 26 Jul 2019 15:16:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id u3_bPs4b8AVr; Fri, 26 Jul 2019 15:16:11 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 58A3546AA1; Fri, 26 Jul 2019 15:16:11 +0200 (CEST)
Date:   Fri, 26 Jul 2019 15:16:11 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Purism Kernel Team <kernel@puri.sm>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] drm/panel: jh057n00900: Move dsi init sequence to
 prepare
Message-ID: <20190726131611.GA13619@bogon.m.sigxcpu.org>
References: <cover.1564132646.git.agx@sigxcpu.org>
 <20190726102529.GB15658@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190726102529.GB15658@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,
On Fri, Jul 26, 2019 at 12:25:29PM +0200, Sam Ravnborg wrote:
> Hi Guido.
> 
> On Fri, Jul 26, 2019 at 11:21:40AM +0200, Guido Günther wrote:
> > If the panel is wrapped in a panel_bridge it gets prepar()ed before the
> > upstream DSI bridge which can cause hangs (e.g. with imx-nwl since clocks
> > are not enabled yet). To avoid this move the panel's first DSI access to
> > enable() so the upstream bridge can prepare the DSI host controller in
> > it's pre_enable().
> > 
> > The second patch makes the disable() call symmetric to the above and the third
> > one just eases debugging.
> > 
> > Guido Günther (3):
> >   drm/panel: jh057n00900: Move panel DSI init to enable()
> >   drm/panel: jh057n00900: Move mipi_dsi_dcs_set_display_off to disable()
> >   drm/panel: jh057n00900: Print error code on all DRM_DEV_ERROR()s
> 
> Patch 1 + 3 are both:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> 
> See comment on patch 2.

Fixed in v2.

> 
> While you are touching this driver can you make an extra patch?
> 
> Today the driver calls the internal prepare,enable,disable,unprepare
> functions.
> The right way to do it is to use the
> drm_panel_(prepare,enable,disable,unprepare) variants.

I hope I got this right in v2 but...

> 
> The benefit is that we can move a little logic to these functions
> and the drivers will then benefit from this.
> 
> Two things I have in my local queue:
> - Move bool for prepared/enabled
>   (to protect that we do not prepare/enable twice)
> - backlight support

...i hope so since what you have planned here would eliminate lots of
code duplication in the panel drivers.
Cheers and thanks for having a look!
 -- Guido

> 
> This driver will benefit form both and this little modification will
> make it simpler to introduce.
> I can also prepare the patch if you prefer.
> 
> 	Sam
> 
