Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CE5C33C9A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 14:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F69B207FD
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 14:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgAEOFk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 09:05:40 -0500
Received: from gloria.sntech.de ([185.11.138.130]:37252 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgAEOFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 09:05:39 -0500
Received: from p508fce23.dip0.t-ipconnect.de ([80.143.206.35] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1io6X0-0007kM-Qo; Sun, 05 Jan 2020 15:05:26 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/11] Add PX30 LVDS support
Date:   Sun, 05 Jan 2020 15:05:26 +0100
Message-ID: <1885398.klecWcqSHf@phil>
In-Reply-To: <20191224143900.23567-1-miquel.raynal@bootlin.com>
References: <20191224143900.23567-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 24. Dezember 2019, 15:38:49 CET schrieb Miquel Raynal:
> Hello,
> 
> This series aims at supporting LVDS on PX30.
> 
> A first couple of patches update the documentation with the new
> compatible and the presence of a PHY. Then, the existing Rockchip
> driver is cleaned and extended to support PX30 specificities. Finally,
> the PX30 DTSI is updated with CRTC routes, the DSI DPHY and the LVDS
> IP itself.
> 
> Cheers,
> Miquèl
> 
> Changes since v1:
> * Added Rob's Ack.
> * Used "must" instead of "should" in the bindings.
> * Precised that phy-names is an optional property in the case of
>   PX30.
> * Renamed the WRITE_EN macro into HIWORD_UPDATE to be aligned with
>   other files.
> * Removed extra configuration, not needed for generic panels (see
>   Sandy Huang answer).
> * Dropped the display-subsystem routes (useless).
> * Merged two patches to avoid phandle interdependencies in graphs and
>   intermediate build errors.
> 
> Miquel Raynal (11):
>   dt-bindings: display: rockchip-lvds: Declare PX30 compatible
>   dt-bindings: display: rockchip-lvds: Document PX30 PHY
>   drm/rockchip: lvds: Fix indentation of a #define
>   drm/rockchip: lvds: Harmonize function names
>   drm/rockchip: lvds: Change platform data
>   drm/rockchip: lvds: Create an RK3288 specific probe function
>   drm/rockchip: lvds: Helpers should return decent values
>   drm/rockchip: lvds: Pack functions together

applied patches 1-8 to drm-misc-next

>   drm/rockchip: lvds: Add PX30 support

drm-misc-next is currently still at 5.4-rc4, so I'll need to find out how
to get newer kernel changes in there, as right now we're missing
the PHY_MODE_LVDS constant.


Heiko

>   arm64: dts: rockchip: Add PX30 DSI DPHY
>   arm64: dts: rockchip: Add PX30 LVDS
> 
>  .../display/rockchip/rockchip-lvds.txt        |   4 +
>  arch/arm64/boot/dts/rockchip/px30.dtsi        |  48 ++
>  drivers/gpu/drm/rockchip/rockchip_lvds.c      | 486 ++++++++++++------
>  drivers/gpu/drm/rockchip/rockchip_lvds.h      |  19 +-
>  4 files changed, 401 insertions(+), 156 deletions(-)
> 
> 




