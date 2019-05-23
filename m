Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319CFC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F7C21773
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Xy4kUdm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbfEWHvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:51:00 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:39268 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfEWHu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:50:59 -0400
Received: from pendragon.ideasonboard.com (85-76-106-214-nat.elisa-mobile.fi [85.76.106.214])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 80B99337;
        Thu, 23 May 2019 09:50:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1558597857;
        bh=zsNCBZECQ0yrfz5b/Kf0LR+UbT6mYeay0fy5WNOd/V8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xy4kUdm69ph8GVhZbB3CiV/q9G0tNbpnq3bRoGsAzYQTqFj9QRoCeEk6+5pPuK8zt
         gk3ivrjSTiQ90/iwbUmZ2kErM4nCl6COVNX1ZPkLEVFqbjaQGiUBIeiPIBxSVAL5ra
         PYkGxHqqP33p+t7/trbNc4aJp7/wa3mZ9K4L9RXg=
Date:   Thu, 23 May 2019 10:50:35 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Torsten Duwe <duwe@lst.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] drm/bridge: extract some Analogix I2C DP common code
Message-ID: <20190523075035.GA5971@pendragon.ideasonboard.com>
References: <20190523065013.2719D68B05@newverein.lst.de>
 <20190523065352.8FD7668B05@newverein.lst.de>
 <CAGb2v66+1+goJfnY7nWTGN2fupqMUm5o+gkPdUW6nxcwQEDwog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGb2v66+1+goJfnY7nWTGN2fupqMUm5o+gkPdUW6nxcwQEDwog@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 03:40:25PM +0800, Chen-Yu Tsai wrote:
> On Thu, May 23, 2019 at 2:54 PM Torsten Duwe <duwe@lst.de> wrote:
> >
> > From: Icenowy Zheng <icenowy@aosc.io>
> >
> > Some code can be shared within different DP bridges by Analogix.
> >
> > Extract them to a new module.
> >
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > Signed-off-by: Torsten Duwe <duwe@suse.de>
> > ---
> >  drivers/gpu/drm/bridge/analogix/Kconfig            |   4 +
> >  drivers/gpu/drm/bridge/analogix/Makefile           |   2 +
> >  drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 146 +-----------------
> >  .../gpu/drm/bridge/analogix/analogix-i2c-dptx.c    | 169 +++++++++++++++++++++
> >  .../gpu/drm/bridge/analogix/analogix-i2c-dptx.h    |   2 +
> >  5 files changed, 178 insertions(+), 145 deletions(-)
> >  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c
> >
> 
> ...
> 
> >  static int anx78xx_set_hpd(struct anx78xx *anx78xx)
> > diff --git a/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c b/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c
> > new file mode 100644
> > index 000000000000..9cb30962032e
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c
> > @@ -0,0 +1,169 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright(c) 2017 Icenowy Zheng <icenowy@aosc.io>
> > + *
> > + * Based on analogix-anx78xx.c, which is:
> > + *   Copyright(c) 2016, Analogix Semiconductor. All rights reserved.
> 
> If this was simple code movement, then the original copyright still applies.
> A different copyright notice should not be used. I suppose the same applies
> to the module author.

And likely to patch 2/6 too.

-- 
Regards,

Laurent Pinchart
