Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D35C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E5420663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="H6hDKzNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfFXIml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 04:42:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39180 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfFXImk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 04:42:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id m10so20581946edv.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 01:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=X9V0I0rT3Iuwr77W2nr5FjsCxhtOBnuvS2mOp7LZweg=;
        b=H6hDKzNtCd7adLn/KUBkZ0Uf2qlQpq1e/fO+KMsRaIbR2iE4bsUAvqEWLCCKkI31mH
         YP899xwf3+kMbVMVar5LTtE7bcbyuc0PfsTEJY5W1Eky85kgxv7nHvMGPjLYXxRqmfKB
         YQEWgFzlolfDhKKUejA5VspYHSu33zngw0UEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=X9V0I0rT3Iuwr77W2nr5FjsCxhtOBnuvS2mOp7LZweg=;
        b=R0cXhYZuFS4nPudFLTij6cDagROi60AWLlQV7rqtOYRsVKj0u+nkH2KJpAyhtg23L8
         v5s/8iXSE6souAaQYivXy7kixNoCdMLPmsYs49EQhjWcttNyc1aRMFXunr0aOhchpyNx
         i3TtEK2Aq1NdcFAWSuh+iQB5ebThzKkvZy1bOytsGO6G3GJMzS6hnH1YH4XFXCa7EuPi
         lGzi0LFimlus0JyvAB+AlkVshmoido9Ra8A4Kb9OiVTPBOaipMICObb4HPO6yJL6XmWe
         wiZa61zR3nE3hsTfG8XYGt4vgLzCt5jzMW+udI3UDsTYdv8vo9LcN5gNp8/Y/7LbkjTA
         CbKg==
X-Gm-Message-State: APjAAAXCUKFzFFuKeXKqJzIVl7WKb+XHZxlX7wV61ti36qmdqNmV5OyA
        kl4wjUsTySfRaIVPWNk4xdHClA==
X-Google-Smtp-Source: APXvYqwjxUt5EgAa2KN9wJES9BzXYjxnZlRD+K5nF0JIffYSpNBVeb7k63n+bBOh0BkltvgY/14EWw==
X-Received: by 2002:a17:906:d797:: with SMTP id pj23mr80092489ejb.223.1561365758561;
        Mon, 24 Jun 2019 01:42:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id l10sm1778061ejh.53.2019.06.24.01.42.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 01:42:37 -0700 (PDT)
Date:   Mon, 24 Jun 2019 10:42:35 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "zhengyang@rock-chips.com" <zhengyang@rock-chips.com>
Subject: Re: [PATCH 0/4] drm/bridge: dw-hdmi: Add support for HDR metadata
Message-ID: <20190624084235.GN12905@phenom.ffwll.local>
Mail-Followup-To: Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "zhengyang@rock-chips.com" <zhengyang@rock-chips.com>
References: <VI1PR03MB420621617DDEAB3596700DE0AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
 <085dc3be-20e5-b2fe-4c02-bf4a4d1473da@baylibre.com>
 <20190621090125.GX12905@phenom.ffwll.local>
 <20190623233017.GI6124@pendragon.ideasonboard.com>
 <58243243-fbd8-e67b-a050-baa9757be43e@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58243243-fbd8-e67b-a050-baa9757be43e@baylibre.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 10:19:34AM +0200, Neil Armstrong wrote:
> Hi Daniel, Laurent, Andrzej,
> 
> On 24/06/2019 01:30, Laurent Pinchart wrote:
> > On Fri, Jun 21, 2019 at 11:01:25AM +0200, Daniel Vetter wrote:
> >> On Thu, Jun 20, 2019 at 04:40:12PM +0200, Neil Armstrong wrote:
> >>> Hi Andrzej,
> >>>
> >>> Gentle ping, could you review the dw-hdmi changes here ?
> >>
> >> btw not sure you absolutely need review from Andrzej, we're currently a
> >> bit undersupplied with bridge reviewers I think ... Better to ramp up
> >> more.
> > 
> > I try to review DRM bridge patches when possible, but dw-hdmi is a
> > special case. I was told by the supplier of an SoC datasheet that
> > contains the HDMI encoder IP core documentation that Synopsys required
> > them to route all contributions made based on that documentation through
> > Synopsys' internal legal review before publishing them. I thus decided
> > to not contribute to the driver anymore, at least for areas that require
> > access to documentation.
> 
> I'd like to propose myself as co-maintainer of the DRM bridge subsystem if
> everybody agrees, following the excellent work Laurent and Andrzej did.
> I have a very little knowledge of DSI, & other bridge drivers, but I'll do
> my best.

Yay volunteers!

Make MAINTAINERS patch to add you, cc relevant people, get acks, merge,
tag you're it :-) Ok, co-it, the point is to have teams as much as
possible.

Cheers, Daniel
> 
> For the dw-hdmi driver, we have a big roadmap including :
> - HDR (this patchset)
> - HDCP 1/2
> - YUV420, YUV422, YUV44, 10bit/12bit/16bit HDMI output
> - Enhanced audio support and ELD notification to ASoC
> ...
> 
> Having a more active maintainer/reviewer team would be needed, at least for
> the dw-hdmi bridge.
> 
> I'll also propose Jonas Karlman <jonas@kwiboo.se> as reviewer since he is very
> active for the multimedia support on RockChip, Allwinner and Amlogic SoCs.
> I'll also propose Jernej Skrabec@siol.net <jernej.skrabec@siol.net>, if he wants,
> as reviewer since he is very active on the Allwinner SoCs side.
> 
> Neil
> 
> > 
> >>> On 26/05/2019 23:18, Jonas Karlman wrote:
> >>>> Add support for HDR metadata using the hdr_output_metadata connector property,
> >>>> configure Dynamic Range and Mastering InfoFrame accordingly.
> >>>>
> >>>> A drm_infoframe flag is added to dw_hdmi_plat_data that platform drivers
> >>>> can use to signal when Dynamic Range and Mastering infoframes is supported.
> >>>> This flag is needed because Amlogic GXBB and GXL report same DW-HDMI version,
> >>>> and only GXL support DRM InfoFrame.
> >>>>
> >>>> The first patch add functionality to configure DRM InfoFrame based on the
> >>>> hdr_output_metadata connector property.
> >>>>
> >>>> The remaining patches sets the drm_infoframe flag on some SoCs supporting
> >>>> Dynamic Range and Mastering InfoFrame.
> >>>>
> >>>> Note that this was based on top of drm-misc-next and Neil Armstrong's
> >>>> "drm/meson: Add support for HDMI2.0 YUV420 4k60" series at [1]
> >>>>
> >>>> [1] https://patchwork.freedesktop.org/series/58725/#rev2
> >>>>
> >>>> Jonas Karlman (4):
> >>>>   drm/bridge: dw-hdmi: Add Dynamic Range and Mastering InfoFrame support
> >>>>   drm/rockchip: Enable DRM InfoFrame support on RK3328 and RK3399
> >>>>   drm/meson: Enable DRM InfoFrame support on GXL, GXM and G12A
> >>>>   drm/sun4i: Enable DRM InfoFrame support on H6
> >>>>
> >>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c   | 109 ++++++++++++++++++++
> >>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h   |  37 +++++++
> >>>>  drivers/gpu/drm/meson/meson_dw_hdmi.c       |   5 +
> >>>>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c |   2 +
> >>>>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c       |   2 +
> >>>>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h       |   1 +
> >>>>  include/drm/bridge/dw_hdmi.h                |   1 +
> >>>>  7 files changed, 157 insertions(+)
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
