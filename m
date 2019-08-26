Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC707C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0252070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbfHZMFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:05:55 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:35794 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731225AbfHZMFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:05:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 8A080FB03;
        Mon, 26 Aug 2019 14:05:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9toa2EE2R_0o; Mon, 26 Aug 2019 14:05:49 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 8F2B949200; Mon, 26 Aug 2019 14:05:48 +0200 (CEST)
Date:   Mon, 26 Aug 2019 14:05:48 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/15] Improvements and fixes for mxsfb DRM driver
Message-ID: <20190826120548.GA14316@bogon.m.sigxcpu.org>
References: <1566382555-12102-1-git-send-email-robert.chiras@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1566382555-12102-1-git-send-email-robert.chiras@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Wed, Aug 21, 2019 at 01:15:40PM +0300, Robert Chiras wrote:
> This patch-set improves the use of eLCDIF block on iMX 8 SoCs (like 8MQ, 8MM
> and 8QXP). Following, are the new features added and fixes from this
> patch-set:

I've applied this whole series on top of my NWL work and it looks good
with a DSI panel. Applying the whole series also fixes an issue where
after unblank the output was sometimes shifted about half a screen width
to the right (which didn't happen with DCSS). So at least from the parts
I could test:

  Tested-by: Guido Günther <agx@sigxcpu.org> 

for the whole thing.
Cheers,
 -- Guido
> 
> 1. Add support for drm_bridge
> On 8MQ and 8MM, the LCDIF block is not directly connected to a parallel
> display connector, where an LCD panel can be attached, but instead it is
> connected to DSI controller. Since this DSI stands between the display
> controller (eLCDIF) and the physical connector, the DSI can be implemented
> as a DRM bridge. So, in order to be able to connect the mxsfb driver to
> the DSI driver, the support for a drm_bridge was needed in mxsfb DRM
> driver (the actual driver for the eLCDIF block).
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
> v3:
> - Removed the max-res property patches and added support for
>   max-memory-bandwidth property, as it is also implemented in other drivers
> - Removed unnecessary drm_vblank_off in probe
> 
> v2:
> - Collected Tested-by from Guido
> - Split the first patch, which added more than one feature into relevant
>   patches, explaining each feature added
> - Also split the second patch into more patches, to differentiate between
>   the feature itself (additional pixel formats support) and the cleanup
>   of the register definitions for a better representation (guido)
> - Included a patch submitted by Guido, while he was testing my patch-set
> 
> Guido Günther (1):
>   drm/mxsfb: Read bus flags from bridge if present
> 
> Mirela Rabulea (1):
>   drm/mxsfb: Signal mode changed when bpp changed
> 
> Robert Chiras (13):
>   drm/mxsfb: Update mxsfb to support a bridge
>   drm/mxsfb: Add defines for the rest of registers
>   drm/mxsfb: Reset vital registers for a proper initialization
>   drm/mxsfb: Update register definitions using bit manipulation defines
>   drm/mxsfb: Update mxsfb with additional pixel formats
>   drm/mxsfb: Fix the vblank events
>   drm/mxsfb: Add max-memory-bandwidth property for MXSFB
>   dt-bindings: display: Add max-memory-bandwidth property for mxsfb
>   drm/mxsfb: Update mxsfb to support LCD reset
>   drm/mxsfb: Improve the axi clock usage
>   drm/mxsfb: Clear OUTSTANDING_REQS bits
>   drm/mxsfb: Add support for horizontal stride
>   drm/mxsfb: Add support for live pixel format change
> 
>  .../devicetree/bindings/display/mxsfb.txt          |   5 +
>  drivers/gpu/drm/mxsfb/mxsfb_crtc.c                 | 287 ++++++++++++++++++---
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c                  | 203 +++++++++++++--
>  drivers/gpu/drm/mxsfb/mxsfb_drv.h                  |  12 +-
>  drivers/gpu/drm/mxsfb/mxsfb_out.c                  |  26 +-
>  drivers/gpu/drm/mxsfb/mxsfb_regs.h                 | 193 +++++++++-----
>  6 files changed, 589 insertions(+), 137 deletions(-)
> 
> -- 
> 2.7.4
> 
