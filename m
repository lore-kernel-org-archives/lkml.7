Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98A4C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 17:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7213206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 17:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgABRZK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 12:25:10 -0500
Received: from mailoutvs25.siol.net ([185.57.226.216]:38440 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728112AbgABRZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 12:25:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 64B9C52123C;
        Thu,  2 Jan 2020 18:25:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lQrdYFwcwuWQ; Thu,  2 Jan 2020 18:25:06 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 00D1D520913;
        Thu,  2 Jan 2020 18:25:05 +0100 (CET)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 4EBCD52123C;
        Thu,  2 Jan 2020 18:25:02 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <mripard@kernel.org>,
        Roman Stratiienko <roman.stratiienko@globallogic.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drm/sun4i: Use CRTC size instead of PRIMARY plane size as mixer frame.
Date:   Thu, 02 Jan 2020 18:25:02 +0100
Message-ID: <1837725.8hb0ThOEGa@jernej-laptop>
In-Reply-To: <CAODwZ7uqf4v8XjOLCn=SoUQchst_b96VCNdaunzn9Q21zPcQ7w@mail.gmail.com>
References: <20200101204750.50541-1-roman.stratiienko@globallogic.com> <20200102100832.c5fc4imjdmr7otam@gilmour.lan> <CAODwZ7uqf4v8XjOLCn=SoUQchst_b96VCNdaunzn9Q21zPcQ7w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne četrtek, 02. januar 2020 ob 17:32:07 CET je Roman Stratiienko napisal(a):
> чт, 2 янв. 2020 г., 12:08 Maxime Ripard <mripard@kernel.org>:
> > Hi,
> > 
> > On Wed, Jan 01, 2020 at 10:47:50PM +0200, 
roman.stratiienko@globallogic.com wrote:
> > > From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> > > 
> > > According to DRM documentation the only difference between PRIMARY
> > > and OVERLAY plane is that each CRTC must have PRIMARY plane and
> > > OVERLAY are optional.
> > > 
> > > Allow PRIMARY plane to have dimension different from full-screen.
> > > 
> > > Fixes: 5bb5f5dafa1a ("drm/sun4i: Reorganize UI layer code in DE2")
> > > Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> > 
> > So it applies to all the 4 patches you've sent, but this lacks some
> > context.
> > 
> > There's a few questions that should be answered here:
> >   - Which situation is it fixing?
> 
> Setting primary plane size less than crtc breaks composition. Also
> shifting top left corner also breaks it.

True, HW doesn't have notion of primary plane. It's just one plane which is 
marked as primary, but otherwise it has same capabilities as others, like x,y 
coordinates, size, etc.

> 
> >   - What tool / userspace stack is it fixing?
> 
> I am using Android userspace and drm_hwcomposer HAL.
> 
> @Jernej, you've said that you observed similar issue. Could you share
> what userspace have you used?

I observed it with DE1, but it has exactly the same issue. I noticed this 
problem on Kodi (gbm version). Kodi first searches for plane capable of 
displaying NV12 format (for video) and after that a plane which is capable of 
displaying RGB888 format (for GUI). In DE1 case, first plane is primary and 
also capable of displaying NV12 format. So when video is displayed which 
doesn't cover whole screen, display output is corrupted. However, with such 
fix, video playback is correct. Luc Verhaegen make equivalent fix for DE1, where 
he also claims primary plane doesn't have to be same size as CRTC output:
https://github.com/libv/fosdem-video-linux/commit/
ae3215d37ca2a55642bcae6c83c3612e26275711

> 
> >   - What happens with your fix? Do you set the plane at coordinates
> >   
> >     0,0 (meaning you'll crop the top-lef corner), do you center it? If
> >     the plane is smaller than the CTRC size, what is set on the edges?
> 
> You can put primary plane to any part of the screen and make it as
> small as 8x8 (according to the datasheet) . Background would be filled
> with black color, that is default, but it also could be overridden by
> setting corresponding registers.

Correct, same logic as for overlay planes applies.

Best regards,
Jernej

> 
> > Thanks!
> > Maxime




