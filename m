Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6733C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932712072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgAFTCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:02:41 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:57068 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgAFTCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:02:41 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 7ABA180566;
        Mon,  6 Jan 2020 20:02:36 +0100 (CET)
Date:   Mon, 6 Jan 2020 20:02:34 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Claudiu.Beznea@microchip.com
Cc:     alexandre.belloni@bootlin.com, airlied@linux.ie,
        Nicolas.Ferre@microchip.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com,
        lee.jones@linaro.org, peda@axentia.se,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 5/6] drm: atmel-hlcdc: prefer a lower pixel-clock than
 requested
Message-ID: <20200106190234.GA15881@ravnborg.org>
References: <1576672109-22707-1-git-send-email-claudiu.beznea@microchip.com>
 <1576672109-22707-6-git-send-email-claudiu.beznea@microchip.com>
 <20200102090848.GC29446@ravnborg.org>
 <20200104171205.GA8724@ravnborg.org>
 <4f8603b2-9ae6-97bf-73c0-1b204595dce1@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f8603b2-9ae6-97bf-73c0-1b204595dce1@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XYAwZIGsAAAA:8
        a=NYWZX5WbLEMB8WfXhvMA:9 a=CjuIK1q_8ugA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu.
On Mon, Jan 06, 2020 at 09:25:40AM +0000, Claudiu.Beznea@microchip.com wrote:
> 
> 
> On 04.01.2020 19:12, Sam Ravnborg wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Hi Claudiu
> > 
> > On Thu, Jan 02, 2020 at 10:08:48AM +0100, Sam Ravnborg wrote:
> >> On Wed, Dec 18, 2019 at 02:28:28PM +0200, Claudiu Beznea wrote:
> >>> From: Peter Rosin <peda@axentia.se>
> >>>
> >>> The intention was to only select a higher pixel-clock rate than the
> >>> requested, if a slight overclocking would result in a rate significantly
> >>> closer to the requested rate than if the conservative lower pixel-clock
> >>> rate is selected. The fixed patch has the logic the other way around and
> >>> actually prefers the higher frequency. Fix that.
> >>>
> >>> Fixes: f6f7ad323461 ("drm/atmel-hlcdc: allow selecting a higher pixel-clock than requested")
> >> The id is wrong here - the right one is: 9946a3a9dbedaaacef8b7e94f6ac144f1daaf1de
> >> The wrong id above was used before - so I think it is a copy'n'paste
> >> thing.
> >>
> >> Hint: try "dim fixes 9946a3a9dbedaaacef8b7e94f6ac144f1daaf1de"
> >>
> >> If I get a quick response from Lee I can fix it up while applying.
> >>
> >>       Sam
> >>
> >>> Reported-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> >>> Tested-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> >>> Signed-off-by: Peter Rosin <peda@axentia.se>
> > 
> > One other detail.
> > The patch has passed through your hands, so you have to add your s-o-b
> > to document this.
> > The chain of s-o-b shall document the path the patch has taken towards
> > the kernel.
> > 
> > In this case:
> > Peter => Claudiu => Sam => Applied.
> > 
> > Please resend or reply where you say OK that I add your s-o-b.
> 
> Sure! Please add my Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Thanks - all four DRM patches pushed to drm-misc-next.
I used "dim fixes" so we could Cc relevant stable versions.

	Sam
