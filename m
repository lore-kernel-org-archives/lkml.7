Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB35DC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 12:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0DE2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 12:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgAFMPz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 07:15:55 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:52757 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgAFMPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 07:15:55 -0500
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id C40CF200008;
        Mon,  6 Jan 2020 12:15:50 +0000 (UTC)
Date:   Mon, 6 Jan 2020 13:15:49 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
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
Message-ID: <20200106131549.52909d08@xps13>
In-Reply-To: <2064471.Uj1soXtvLx@diego>
References: <20191224143900.23567-1-miquel.raynal@bootlin.com>
        <1885398.klecWcqSHf@phil>
        <2064471.Uj1soXtvLx@diego>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

Heiko Stübner <heiko@sntech.de> wrote on Mon, 06 Jan 2020 12:09:19
+0100:

> Am Sonntag, 5. Januar 2020, 15:05:26 CET schrieb Heiko Stuebner:
> > Am Dienstag, 24. Dezember 2019, 15:38:49 CET schrieb Miquel Raynal:  
> > > Hello,
> > > 
> > > This series aims at supporting LVDS on PX30.
> > > 
> > > A first couple of patches update the documentation with the new
> > > compatible and the presence of a PHY. Then, the existing Rockchip
> > > driver is cleaned and extended to support PX30 specificities. Finally,
> > > the PX30 DTSI is updated with CRTC routes, the DSI DPHY and the LVDS
> > > IP itself.
> > > 
> > > Cheers,
> > > Miquèl
> > > 
> > > Changes since v1:
> > > * Added Rob's Ack.
> > > * Used "must" instead of "should" in the bindings.
> > > * Precised that phy-names is an optional property in the case of
> > >   PX30.
> > > * Renamed the WRITE_EN macro into HIWORD_UPDATE to be aligned with
> > >   other files.
> > > * Removed extra configuration, not needed for generic panels (see
> > >   Sandy Huang answer).
> > > * Dropped the display-subsystem routes (useless).
> > > * Merged two patches to avoid phandle interdependencies in graphs and
> > >   intermediate build errors.
> > > 
> > > Miquel Raynal (11):
> > >   dt-bindings: display: rockchip-lvds: Declare PX30 compatible
> > >   dt-bindings: display: rockchip-lvds: Document PX30 PHY
> > >   drm/rockchip: lvds: Fix indentation of a #define
> > >   drm/rockchip: lvds: Harmonize function names
> > >   drm/rockchip: lvds: Change platform data
> > >   drm/rockchip: lvds: Create an RK3288 specific probe function
> > >   drm/rockchip: lvds: Helpers should return decent values
> > >   drm/rockchip: lvds: Pack functions together  
> > 
> > applied patches 1-8 to drm-misc-next
> >   
> > >   drm/rockchip: lvds: Add PX30 support  
> > 
> > drm-misc-next is currently still at 5.4-rc4, so I'll need to find out how
> > to get newer kernel changes in there, as right now we're missing
> > the PHY_MODE_LVDS constant.  
> 
> applied now to drm-misc-next as well, after drm-misc maintainers did the
> requested back-merge to get that constant.

Great! Thanks a lot for your time!

Miquèl
