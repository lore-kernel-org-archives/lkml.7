Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D53C7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 02:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73EA217D6
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 02:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UGHkk32a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfG0CEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 22:04:53 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:52650 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfG0CEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 22:04:53 -0400
Received: from pendragon.ideasonboard.com (om126200118163.15.openmobile.ne.jp [126.200.118.163])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AD2869B1;
        Sat, 27 Jul 2019 04:04:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1564193090;
        bh=vVlrigtV/4n1LRYGHmQgWdMF36/DcZ6Ryvzw8aTcvZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UGHkk32aSXSYBC9k0S8TYWWPJ71pvNcd6rc7G1goNemIr54JKb6ChRFqMrEYDjHb8
         Ax+tke8BzXReGpoaoSFuTNo8DxEGkVvLBj7qIvWKmH4ja72XH3ZfC5jBJr3uqTV1Ws
         Gglj4E5HHE/FjKncIgOJFdHhCU6i5Z9wAK7g4w18=
Date:   Sat, 27 Jul 2019 05:04:44 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Lee Jones <lee.jones@linaro.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH 3/3] drm/bridge: Add NWL MIPI DSI host controller support
Message-ID: <20190727020444.GC4902@pendragon.ideasonboard.com>
References: <cover.1563983037.git.agx@sigxcpu.org>
 <3158f4f8c97c21f98c394e5631d74bc60d796522.1563983037.git.agx@sigxcpu.org>
 <CAOMZO5BRbV_1du1b9eJqcBvvXSE2Mon3yxSPJxPpZgBqYNjBSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5BRbV_1du1b9eJqcBvvXSE2Mon3yxSPJxPpZgBqYNjBSg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jul 26, 2019 at 05:01:52PM -0300, Fabio Estevam wrote:
> Hi Guido,
> 
> Thanks for your work on this driver!
> 
> On Wed, Jul 24, 2019 at 12:52 PM Guido Günther <agx@sigxcpu.org> wrote:
> 
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/imx-nwl/Kconfig
> > @@ -0,0 +1,15 @@
> > +config DRM_IMX_NWL_DSI
> > +       tristate "Support for Northwest Logic MIPI DSI Host controller"
> > +       depends on DRM && (ARCH_MXC || ARCH_MULTIPLATFORM || COMPILE_TEST)
> 
> This IP could potentially be found on other SoCs, so no need to make
> it depend on ARCH_MXC.

I'd go even further and not use the prefix imx in the driver name or
anywhere in the code.

[snip]

-- 
Regards,

Laurent Pinchart
