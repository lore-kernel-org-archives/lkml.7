Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826B5C74A54
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6297921537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbfGKPEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 11:04:08 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:34798 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbfGKPEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:04:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 6BEB8FB03;
        Thu, 11 Jul 2019 17:04:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vble_Z4Bb27E; Thu, 11 Jul 2019 17:04:04 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id D10E042CB4; Thu, 11 Jul 2019 17:04:03 +0200 (CEST)
Date:   Thu, 11 Jul 2019 17:04:03 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/10] Improvements and fixes for mxsfb DRM driver
Message-ID: <20190711150403.GB23195@bogon.m.sigxcpu.org>
References: <1561555938-21595-1-git-send-email-robert.chiras@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561555938-21595-1-git-send-email-robert.chiras@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,
On Wed, Jun 26, 2019 at 04:32:08PM +0300, Robert Chiras wrote:
> This patch-set improves the use of eLCDIF block on iMX 8 SoCs (like 8MQ, 8MM
> and 8QXP). Following, are the new features added and fixes from this
> patch-set:
> 
> 1. Add support for drm_bridge
> On 8MQ and 8MM, the LCDIF block is not directly connected to a parallel
> display connector, where an LCD panel can be attached, but instead it is
> connected to DSI controller. Since this DSI stands between the display
> controller (eLCDIF) and the physical connector, the DSI can be implemented
> as a DRM bridge. So, in order to be able to connect the mxsfb driver to
> the DSI driver, the support for a drm_bridge was needed in mxsfb DRM
> driver (the actual driver for the eLCDIF block).

So I wanted to test this but with both my somewhat cleaned up nwl
driver¹ and the nwl driver forward ported from the nxp vendor tree I'm
looking at a black screen with current mainline - while my dcss forward
port gives me nice output on mipi dsi. Do you have a tree that uses mipi
dsi on imx8mq where I could look at to check for differences?

Cheers,
 -- Guido

> 
> 2. Add support for additional pixel formats
> Some of the pixel formats needed by Android were not implemented in this
> driver, but they were actually supported. So, add support for them.
> 
> 3. Add support for horizontal stride
> Having support for horizontal stride allows the use of eLCDIF with a GPU
> (for example) that can only output resolution sizes multiple of a power of
> 8. For example, 1080 is not a power of 16, so in order to support 1920x1080
> output from GPUs that can produce linear buffers only in sizes multiple to 16,
> this feature is needed.
> 
> 3. Few minor features and bug-fixing
> The addition of max-res DT property was actually needed in order to limit
> the bandwidth usage of the eLCDIF block. This is need on systems where
> multiple display controllers are presend and the memory bandwidth is not
> enough to handle all of them at maximum capacity (like it is the case on
> 8MQ, where there are two display controllers: DCSS and eLCDIF).
> The rest of the patches are bug-fixes.
> 
> Mirela Rabulea (1):
>   drm/mxsfb: Signal mode changed when bpp changed
> 
> Robert Chiras (9):
>   drm/mxsfb: Update mxsfb to support a bridge
>   drm/mxsfb: Update mxsfb with additional pixel formats
>   drm/mxsfb: Fix the vblank events
>   dt-bindings: display: Add max-res property for mxsfb
>   drm/mxsfb: Add max-res property for MXSFB
>   drm/mxsfb: Update mxsfb to support LCD reset
>   drm/mxsfb: Improve the axi clock usage
>   drm/mxsfb: Clear OUTSTANDING_REQS bits
>   drm/mxsfb: Add support for horizontal stride
> 
>  .../devicetree/bindings/display/mxsfb.txt          |   6 +
>  drivers/gpu/drm/mxsfb/mxsfb_crtc.c                 | 290 ++++++++++++++++++---
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c                  | 189 +++++++++++---
>  drivers/gpu/drm/mxsfb/mxsfb_drv.h                  |  10 +-
>  drivers/gpu/drm/mxsfb/mxsfb_out.c                  |  26 +-
>  drivers/gpu/drm/mxsfb/mxsfb_regs.h                 | 128 ++++++---
>  6 files changed, 531 insertions(+), 118 deletions(-)
> 
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

¹ https://lists.freedesktop.org/archives/dri-devel/2019-March/209685.html
