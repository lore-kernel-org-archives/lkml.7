Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CE2C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F8922ADA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfGZNPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:15:12 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:36254 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfGZNPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:15:12 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 1C3B480502;
        Fri, 26 Jul 2019 15:15:07 +0200 (CEST)
Date:   Fri, 26 Jul 2019 15:15:06 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     "dbasehore ." <dbasehore@chromium.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Paul <sean@poorly.run>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 2/4] drm/panel: set display info in panel attach
Message-ID: <20190726131506.GB17801@ravnborg.org>
References: <20190710021659.177950-1-dbasehore@chromium.org>
 <20190710021659.177950-3-dbasehore@chromium.org>
 <20190723091945.GD787@ravnborg.org>
 <CAGAzgsonxAcOLxPSoP6Swab+AFPxWaxmC_tg87J=6Nes_awACg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGAzgsonxAcOLxPSoP6Swab+AFPxWaxmC_tg87J=6Nes_awACg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8
        a=VwQbUJbxAAAA:8 a=CPKLS5VrouiAa9iZAqIA:9 a=CjuIK1q_8ugA:10
        a=E9Po1WZjFZOl8hwRPBS3:22 a=AjGcO6oz07-iQ99wixmX:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Derek.

On Wed, Jul 24, 2019 at 03:15:19PM -0700, dbasehore . wrote:
> Hi Sam, thanks for pointing out the potential conflict.
> 
> On Tue, Jul 23, 2019 at 2:19 AM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Hi Derek.
> >
> > On Tue, Jul 09, 2019 at 07:16:57PM -0700, Derek Basehore wrote:
> > > Devicetree systems can set panel orientation via a panel binding, but
> > > there's no way, as is, to propagate this setting to the connector,
> > > where the property need to be added.
> > > To address this, this patch sets orientation, as well as other fixed
> > > values for the panel, in the drm_panel_attach function. These values
> > > are stored from probe in the drm_panel struct.
> >
> > This approch seems to conflict with work done by Laurent where the
> > ownership/creation of the connector will be moved to the display controller.
> >
> > If I understand it correct then there should not be a 1:1 relation
> > between a panel and a connector anymore.
> 
> 
> Can you point me to this work?
Please take a look at the series with subject:
"[PATCH 00/60] drm/omap: Replace custom display drivers with drm_bridge
and drm_panel"
Link: https://patchwork.kernel.org/cover/11034175/

Laurent has done a great job explaining the background,
If you look into the patched you will see the idea is that a drm_panel
no longer get attached to a drm_controller - it will be an argument to
get_modes().

	Sam
