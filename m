Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0ABFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 19:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C61521835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 19:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TY3TajZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407162AbfJQTOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 15:14:06 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:51862 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfJQTOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 15:14:05 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 99907500;
        Thu, 17 Oct 2019 21:14:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1571339643;
        bh=T8QQ+jvwcbYP+lrdGA0O9pZdbwxhTK5RoFxJAWwUBPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TY3TajZBX4fjw741T+diLe6XUhE1h7+4ch7BZjIZ2DXjuGVRj+zMFmPY4s6E0oWOV
         P5q7A9OQolmzTi/nz9dEP5SYKlDjViHDDIY+H6+JeI/tMfV3haJ5cofbDjOFpbjC1S
         NWSjbcUdkV8F0JzwCmAX8vFEbmw/7QI4+2a5ccks=
Date:   Thu, 17 Oct 2019 22:14:00 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc:     kieran.bingham+renesas@ideasonboard.com, geert@linux-m68k.org,
        horms@verge.net.au, uli+renesas@fpond.eu, airlied@linux.ie,
        daniel@ffwll.ch, linux-renesas-soc@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/8] drm: rcar-du: Add Color Management Module (CMM)
Message-ID: <20191017191400.GH4901@pendragon.ideasonboard.com>
References: <20191016085548.105703-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191016085548.105703-1-jacopo+renesas@jmondi.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

Thank you for your work.

On Wed, Oct 16, 2019 at 10:55:40AM +0200, Jacopo Mondi wrote:
> Minimal increment to the CMM series, this time should really be the last one.
> 
> Just missing Rob's ack on [1/8] and Laurent's one on [5/8].
> 
> Changelog is minimal:
> CMM
> - Remove the cmm_config.enable flag. The cmm_config.table field validity is
>   used to enable/disable the LUT operations
> - Expand comments as suggested by Laurent
> 
> CRTC
> - use drm_color_lut_size() to check the LUT table size
> - Inline calls to rcar_cmm_enable()/disable()
> - Add TODO entries as suggested by Laurent
> 
> For the record, the full series changelog is available at:
> https://paste.debian.net/1107427/
> 
> v5 from yesterday with informations on testing is available at:
> https://lkml.org/lkml/2019/10/15/337
> 
> Geert will you collect for DTS patches for the next release?
> I assume the DU changes go through Laurent instead ?

I've taken patch 1/8 to 6/8 and 8/8 in my tree. I expected Geert to take
7/8.

> Jacopo Mondi (8):
>   dt-bindings: display: renesas,cmm: Add R-Car CMM documentation
>   dt-bindings: display, renesas,du: Document cmms property
>   drm: rcar-du: Add support for CMM
>   drm: rcar-du: kms: Initialize CMM instances
>   drm: rcar-du: crtc: Control CMM operations
>   drm: rcar-du: crtc: Register GAMMA_LUT properties
>   arm64: dts: renesas: Add CMM units to Gen3 SoCs
>   drm: rcar-du: kms: Expand comment in vsps parsing routine
> 
>  .../bindings/display/renesas,cmm.yaml         |  67 ++++++
>  .../bindings/display/renesas,du.txt           |   5 +
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi      |  39 ++++
>  arch/arm64/boot/dts/renesas/r8a7796.dtsi      |  31 ++-
>  arch/arm64/boot/dts/renesas/r8a77965.dtsi     |  31 ++-
>  arch/arm64/boot/dts/renesas/r8a77990.dtsi     |  21 ++
>  arch/arm64/boot/dts/renesas/r8a77995.dtsi     |  21 ++
>  drivers/gpu/drm/rcar-du/Kconfig               |   7 +
>  drivers/gpu/drm/rcar-du/Makefile              |   1 +
>  drivers/gpu/drm/rcar-du/rcar_cmm.c            | 212 ++++++++++++++++++
>  drivers/gpu/drm/rcar-du/rcar_cmm.h            |  58 +++++
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c        |  65 ++++++
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.h        |   2 +
>  drivers/gpu/drm/rcar-du/rcar_du_drv.h         |   2 +
>  drivers/gpu/drm/rcar-du/rcar_du_group.c       |  10 +
>  drivers/gpu/drm/rcar-du/rcar_du_group.h       |   2 +
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c         |  82 ++++++-
>  drivers/gpu/drm/rcar-du/rcar_du_regs.h        |   5 +
>  18 files changed, 658 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/renesas,cmm.yaml
>  create mode 100644 drivers/gpu/drm/rcar-du/rcar_cmm.c
>  create mode 100644 drivers/gpu/drm/rcar-du/rcar_cmm.h
> 

-- 
Regards,

Laurent Pinchart
