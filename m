Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD1BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327C8206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Rf/JZyTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbfDDJpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:45:50 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:48438 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730837AbfDDJpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:45:44 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 532EE54B;
        Thu,  4 Apr 2019 11:45:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1554371142;
        bh=J0rRRri8U7uPMaAxN1CMsB//nXwnULKtdskoS5st3EE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rf/JZyTrIbKcNv+0eNrigPLBPUliwJNUhykCkJLM7Lw/jLJcj2+KE5mABgVwua2kH
         kVQ1yqMa1X8qryFw8+IffNX9JEUS9w+cnBqKt4crtY+DWcOM0qw8yoFMtWlQ7BchMe
         WcLlDxls1A8xHmlC6ttA3BkjQoxNFBM/thuvDAZM=
Date:   Thu, 4 Apr 2019 12:45:31 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     VenkataRajesh.Kalakodima@in.bosch.com
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/8] v4.19.0 Added Color Management Module
Message-ID: <20190404094531.GB5800@pendragon.ideasonboard.com>
References: <1554297284-14009-1-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1554297284-14009-1-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalakodima,

Thank you for the patch.

On Wed, Apr 03, 2019 at 06:44:36PM +0530, VenkataRajesh.Kalakodima@in.bosch.com wrote:
> From: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>
> 
> This patchset adds rcar- display unit color management module (CMM)
> function feature, Which allows correction and adjustment of the
> display data, through updating Look up table (gamma) and  Cubic look
> up table (CTM)  property values 
> 
> Base color management module reference code taken from below link,
> https://github.com/renesas-rcar/du_cmm .
> - In above code, modified variable namingâ€™s and removed un used
>   functionalities.
> - Introduce new functions for queueing cubic look up table and look up
>   table events.
> 
> - Implemented interfaces in color management module to set CLU /LUT
>   table using standard DRM data structures as input.
>   Look up table is a 1D-LUT that converts each of three-color
>   components by using a lookup table. LUT is used for gamma
>   correction.							
>   Cubic look up table is a three-dimensional LUT (3D-LUT) that
>   converts the input three-color-component data into desired three
>   color Components by using a lookup table
> 
> - Implemented atomic check helper functions for enable/disable LUT and
>   CLU (Gamma and Color Transformation Matrix properties).
> - Allocated memory necessary for cubic look up table and look up table
>   and added mode fix up callback function
> - Added update gamma and color transformation matrix properties in
>   commit tail function, If any change in property values.
> 
> kalakodima venkata rajesh (8):
>   drm: Add DU CMM support functions
>   drm: Add DU CMM support boot and clk changes
>   drm: rcar-du: Give a name to clu table samples
>   drm: rcar-du: Refactor the code with new functions
>   drm: rcar-du: Implement interfaces to set clu and lut using drm data
>     structures
>   drm: rcar-du: Implement atomic_check to check for gamma and ctm
>     properties
>   drm: rcar-du: update gamma and ctm properties in commit tail
>   drm: rcar-du: Add shutdown callback function in platform_driver
> 
>  .../boot/dts/renesas/r8a7795-es1-salvator-x.dts    |    5 +
>  arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |    5 +
>  .../arm64/boot/dts/renesas/r8a7795-salvator-xs.dts |    5 +
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi           |   29 +-
>  arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |    6 +-
>  .../arm64/boot/dts/renesas/r8a7796-salvator-xs.dts |    4 +
>  arch/arm64/boot/dts/renesas/r8a7796.dtsi           |   25 +-
>  .../arm64/boot/dts/renesas/r8a77965-salvator-x.dts |    7 +-
>  .../boot/dts/renesas/r8a77965-salvator-xs.dts      |    7 +-
>  arch/arm64/boot/dts/renesas/r8a77965.dtsi          |   27 +-
>  drivers/clk/renesas/r8a7795-cpg-mssr.c             |    4 +
>  drivers/clk/renesas/r8a7796-cpg-mssr.c             |    3 +
>  drivers/clk/renesas/r8a77965-cpg-mssr.c            |  106 +-
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |   35 +
>  drivers/gpu/drm/rcar-du/Makefile                   |    2 +
>  drivers/gpu/drm/rcar-du/rcar_du_cmm.c              | 1470 ++++++++++++++++++++
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c             |   82 ++
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.h             |   28 +
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c              |   85 +-
>  drivers/gpu/drm/rcar-du/rcar_du_drv.h              |   16 +-
>  drivers/gpu/drm/rcar-du/rcar_du_encoder.c          |    2 +-
>  drivers/gpu/drm/rcar-du/rcar_du_encoder.h          |    1 +
>  drivers/gpu/drm/rcar-du/rcar_du_group.c            |    5 +
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c              |   25 +
>  drivers/gpu/drm/rcar-du/rcar_du_regs.h             |   92 ++
>  include/drm/bridge/dw_hdmi.h                       |    1 +
>  include/drm/drm_atomic.h                           |   25 +
>  include/drm/drm_ioctl.h                            |    7 +
>  28 files changed, 2082 insertions(+), 27 deletions(-)
>  create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_cmm.c

First of all, please split changes to DT, to the clock drivers, to the
dw-hdmi driver, to the DRM core and to the R-Car DU driver in separate
patches, with appropriate subject lines prefixes for each of them. As
you're modifying DT bindngs, you also need to update the bindings
documentation, which should go to a patch of its own.

-- 
Regards,

Laurent Pinchart
