Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4588BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173CA2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfCRLFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:05:18 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:37155 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfCRLFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:05:18 -0400
X-Originating-IP: 90.88.22.102
Received: from aptenodytes (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id F2E3040013;
        Mon, 18 Mar 2019 11:05:12 +0000 (UTC)
Message-ID: <ef0c3061986b7456605a61f835f2a2003cf4c678.camel@bootlin.com>
Subject: Re: [linux-sunxi] Re: [PATCH 04/14] pinctrl: sunxi: v3: really
 introduce support for V3
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     icenowy@aosc.io, linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-clk@vger.kernel.org
Date:   Mon, 18 Mar 2019 12:05:12 +0100
In-Reply-To: <7B6C1341-BAB5-48C5-9E60-11BCEAC3D0CD@aosc.io>
References: <20190312152256.35574-1-icenowy@aosc.io>
         <20190312152256.35574-5-icenowy@aosc.io>
         <20190312153654.25r5orlw7qjtlhbt@flea>
         <7B6C1341-BAB5-48C5-9E60-11BCEAC3D0CD@aosc.io>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mardi 12 mars 2019 à 23:45 +0800, Icenowy Zheng a écrit :
> 
> 于 2019年3月12日 GMT+08:00 下午11:36:54, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
> > On Tue, Mar 12, 2019 at 11:22:46PM +0800, Icenowy Zheng wrote:
> > > Introduce the GPIO pins that is only available on V3 (not on V3s) to
> > the
> > > V3 pinctrl driver.
> > > 
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > ---
> > >  drivers/pinctrl/sunxi/pinctrl-sun8i-v3.c | 291
> > +++++++++++++++++++++--
> > >  drivers/pinctrl/sunxi/pinctrl-sunxi.h    |   2 +
> > >  2 files changed, 275 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-v3.c
> > b/drivers/pinctrl/sunxi/pinctrl-sun8i-v3.c
> > > index 6704ce8e5e3d..54c210871a95 100644
> > > --- a/drivers/pinctrl/sunxi/pinctrl-sun8i-v3.c
> > > +++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-v3.c
> > > @@ -1,5 +1,5 @@
> > >  /*
> > > - * Allwinner V3s SoCs pinctrl driver.
> > > + * Allwinner V3/V3s SoCs pinctrl driver.
> > >   *
> > >   * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.xyz>
> > >   *
> > > @@ -23,7 +23,7 @@
> > >  
> > >  #include "pinctrl-sunxi.h"
> > >  
> > > -static const struct sunxi_desc_pin sun8i_v3s_pins[] = {
> > > +static const struct sunxi_desc_pin sun8i_v3_v3s_pins[] = {
> > 
> > I'm not sure all that remaining is worth it to be honest. It adds a
> > lot of noise for no particular reason (and the same goes for renaming
> > the file itself)
> 
> Maybe keeping names is okay "for historial reasons".
> 
> In fact I want to keep them.

My two cents about this: kernel development is plagued by the unability
to rename and rework things as soon as backward compatibility is
involved. I believe that renaming and reworking things is quite a good
thing to do when it leads to a situation that is easier to understand
and makes more sense.

In this case, I don't see any blockers that would prevent us from doing
this, so I am strongly in favor of it. I really don't see how increased
noise and "historical reasons" make up for better clarity.

Cheers,

Paul

> > Maxime
> 
> -- 
> 使用 K-9 Mail 发送自我的Android设备。
> 
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

