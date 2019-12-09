Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04A9C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17A32068E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="b2QZylIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLIPcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:32:47 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:36954 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfLIPcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 10:32:47 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C44B6FCF;
        Mon,  9 Dec 2019 16:32:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1575905565;
        bh=0cB0KQ3w+T+YFNjQmKzHnWoA1Lbe2MnHeWDxvrD8lXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b2QZylIm5A2WoRrkTXJACdWQ8pVO3Oc6jF1G0+p6ZZZ5RxitGUqTKPs/gxaeVL5xs
         knCiwQStorSLSz+tdnbQ0oSMO4fc+799n85bSK0hRusxluYigK4T5+5JzphL63NLCZ
         cFkTOH3wYDnQiipsxpDzlK3VP6tXltJ+KHLb+rDw=
Date:   Mon, 9 Dec 2019 17:32:38 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Archit Taneja <architt@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>
Subject: Re: [PATCH RESEND 3/4] dt-bindings: drm/bridge: analogix-anx78xx:
 support bypass GPIO
Message-ID: <20191209153238.GE12841@pendragon.ideasonboard.com>
References: <20191209145016.227784-1-hsinyi@chromium.org>
 <20191209145016.227784-4-hsinyi@chromium.org>
 <20191209145552.GD12841@pendragon.ideasonboard.com>
 <CAJMQK-hNSF-Vu4CfTKiCUdBRmaONf=Lp3NN0-nFor6mxY1seJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJMQK-hNSF-Vu4CfTKiCUdBRmaONf=Lp3NN0-nFor6mxY1seJg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

On Mon, Dec 09, 2019 at 11:09:34PM +0800, Hsin-Yi Wang wrote:
> On Mon, Dec 9, 2019 at 10:55 PM Laurent Pinchart wrote:
> > On Mon, Dec 09, 2019 at 10:50:15PM +0800, Hsin-Yi Wang wrote:
> > > Support optional feature: bypass GPIO.
> > >
> > > Some SoC (eg. mt8173) have a hardware mux that connects to 2 ports:
> > > anx7688 and hdmi. When the GPIO is active, the bridge is bypassed.
> >
> > This doesn't look like the right place to fix this, as the mux is
> > unrelated to the bridge. You would have to duplicate this logic in every
> > bridge driver otherwise.
> >
> > Could you describe the hardware topology in a bit more details ? I can
> > then try to advise on how to best support it.
>
> Hi Laurent,
> 
> The mt8173 layout is:
> 
> MT8173 HDMI bridge-- hardware mux --- HDMI
>                                                    |
>                                                     ------------ anx7688

You may have used a proportional font when writing this, the | doesn't
align with anything using a fixed font. Do I assume correctly that the
hardware multiplexer is actually a demultiplexer with one input and two
outputs ?
                                     +-----------+
+---------+         +------+    /--> | HDMI      |
| MT8173  |  HDMI   |   -->| --/     | Connector |
|  HDMI   | ------> |--/   |         +-----------+
| Encoder |         |    ->| --\     +-----------+      +-----------+
+---------+         +------+    \--> | ANX7688   | ---> | USB-C     |
                                     | Bridge    |      | Connector |
				     +-----------+      +-----------+

> There's a hardware mux that takes mt8173 hdmi as input and has 2
> output port: native hdmi and anx7688 bridge.
> If gpio is active, we would like it to go to HDMI.
> 
> Previous approach is to make hardware mux a generic gpio mux bridge,
> but this is probably a very rare use case that is only for
> mt8173.(https://lore.kernel.org/lkml/57723AD2.8020806@codeaurora.org/)
> We merge the mux and anx7688 to a single bridge and leave this as an
> optional feature in this time.

I think that's a better approach, at least at the DT level. The HDMI
demultiplexer should be represented as a DT node with 3 ports (one input
and two outputs) with a control GPIO.

From a video point of view, the ANX7688 should be represented as a DT
node with 2 ports (one input and one output), regardless of whether it
is used in conjunction with an HDMI switch as shown above, or directly
connected to the output of an HDMI encoder. However, as the ANX7688
supports both DP output and USB-C output, the situation may be slightly
more complex. Please see https://patchwork.kernel.org/patch/11184895/
for a similar discussion, related to the ANX7625.

In any case, I don't think the ANX7688 should care about the GPIO.

-- 
Regards,

Laurent Pinchart
