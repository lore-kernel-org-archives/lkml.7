Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFE8C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 03:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7E0222BE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 03:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfJCD72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 23:59:28 -0400
Received: from hermes.aosc.io ([199.195.250.187]:42161 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727953AbfJCD72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 23:59:28 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 418CA82E31;
        Thu,  3 Oct 2019 03:59:24 +0000 (UTC)
Message-ID: <cf49bbf518b10b0f5b27b0d5e866b60e174fec4a.camel@aosc.io>
Subject: Re: [PATCH 0/3] drm/sun4i: dsi: misc timing fixes
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Date:   Thu, 03 Oct 2019 11:58:42 +0800
In-Reply-To: <20191002103642.jlbs44v4kwnxhrge@gilmour>
References: <20191001080253.6135-1-icenowy@aosc.io>
         <20191002103642.jlbs44v4kwnxhrge@gilmour>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019-10-02三的 12:36 +0200，Maxime Ripard写道：
> Hi,
> 
> On Tue, Oct 01, 2019 at 04:02:50PM +0800, Icenowy Zheng wrote:
> > This patchset fixes some portion of timing calculation in
> > sun6i_mipi_dsi
> > driver according to the BSP driver.
> > 
> > Two of the patches are reverting, one is fixing some misread of the
> > BSP
> > source code, another is fixing a wrong refactor that actually
> > breaks the
> > formula.
> > 
> > The other non-reverting patch is fixing a porch error which is
> > usually
> > seen in the original driver commit. Most of porch errors are then
> > fixed,
> > but this one gets ignored.
> > 
> > By applying these patches, several DSI panels are tested to be
> > driven
> > properly by the timing provided by the vendor, including the LCD
> > panel
> > of PinePhone "Don't Be Evil" DevKit, the final PinePhone panel and
> > the
> > panel on PineTab. Without these patches they need dirty timing
> > hacks to
> > work.
> 
> Thanks for going after that issue. Can you provide references to the
> BSP on the various patches?

For patch 1: [1] for setting delay 1 in DSI controller, [2] for setting
real delay in TCON controller.

For patch 2: [3]

Patch 3 is reverting a breaking change, so I didn't check it in the
BSP. It can be verified by mathmatical calculation.

[1] 
https://github.com/ayufan-pine64/linux-pine64/blob/my-hacks-1.2-with-drm/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c#L730

[2] 
https://github.com/ayufan-pine64/linux-pine64/blob/my-hacks-1.2-with-drm/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_lcd.c#L369

[3] 
https://github.com/ayufan-pine64/linux-pine64/blob/my-hacks-1.2-with-drm/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c#L780

> 
> Ideally, having the panel drivers, and the panel datasheet would
> help.
> 
> Thanks!
> Maxime
> 
> PS: where can we get one of those devices?

