Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24045C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 09:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEBE42085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 09:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfGUJiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 05:38:21 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:32799 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGUJiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 05:38:20 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 752D820067;
        Sun, 21 Jul 2019 11:38:16 +0200 (CEST)
Date:   Sun, 21 Jul 2019 11:38:15 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH] drm/panel: simple: Doxygenize 'struct panel_desc';
 rename a few functions
Message-ID: <20190721093815.GA4375@ravnborg.org>
References: <20190712163333.231884-1-dianders@chromium.org>
 <20190717173317.GA4862@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717173317.GA4862@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8
        a=cm27Pg_UAAAA:8 a=Ou5vyIR7_VdEBx-5QFgA:9 a=CjuIK1q_8ugA:10
        a=E9Po1WZjFZOl8hwRPBS3:22 a=xmb-EsYY8bH0VWELuYED:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug.

On Wed, Jul 17, 2019 at 07:33:17PM +0200, Sam Ravnborg wrote:
> Hi Doug.
> 
> On Fri, Jul 12, 2019 at 09:33:33AM -0700, Douglas Anderson wrote:
> > This attempts to address outstanding review feedback from commit
> > b8a2948fa2b3 ("drm/panel: simple: Add ability to override typical
> > timing").  Specifically:
> > 
> > * It was requested that I document (in the structure definition) that
> >   the device tree override had no effect if 'struct drm_display_mode'
> >   was used in the panel description.  I have provided full Doxygen
> >   comments for 'struct panel_desc' to accomplish that.
> > * panel_simple_get_fixed_modes() was thought to be a confusing name,
> >   so it has been renamed to panel_simple_get_display_modes().
> > * panel_simple_parse_override_mode() was thought to be better named as
> >   panel_simple_parse_panel_timing_node().
> > 
> > Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> 
> Thanks.
> 
> I updated the $subject to:
>     drm/panel: simple: document panel_desc; rename a few functions
> 
> And pushed out to drm-misc-next.

I see the following error printed at each boot:

    /panel: could not find node 'panel-timing'

The error originates from this snip (from panel-simple.c):

       if (!of_get_display_timing(dev->of_node, "panel-timing", &dt))
                panel_simple_parse_panel_timing_node(dev, panel, &dt);

of_get_display_timing() returns -2 (-ENOENT).

In the setup I use there is no panel-timing node as the timing specified
in panel-simple.c is fine.
This is the typical setup - and there should not in the normal case
be printed error messages like this during boot.

Will you please take a look at this.

	Sam
