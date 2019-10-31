Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51066CA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29969208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfJaOw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:52:28 -0400
Received: from verein.lst.de ([213.95.11.211]:51479 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbfJaOw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:52:28 -0400
Received: by verein.lst.de (Postfix, from userid 2005)
        id 0102D68BE1; Thu, 31 Oct 2019 15:52:24 +0100 (CET)
Date:   Thu, 31 Oct 2019 15:52:24 +0100
From:   Torsten Duwe <duwe@lst.de>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/7] dt-bindings: Add ANX6345 DP/eDP transmitter
 binding
Message-ID: <20191031145224.GA5973@lst.de>
References: <20191029153815.C631668C4E@verein.lst.de> <20191029153953.8EE9B68D04@verein.lst.de> <20191031125100.qprbdaaysg3tmhif@hendrix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031125100.qprbdaaysg3tmhif@hendrix>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 01:51:00PM +0100, Maxime Ripard wrote:
> On Tue, Oct 29, 2019 at 01:16:57PM +0100, Torsten Duwe wrote:
> > +
> > +  ports:
> > +    anyOf:
> > +      - port@0:
> > +        description: Video port for LVTTL input
> > +      - port@1:
> > +        description: Video port for eDP output (panel or connector).
> > +                     May be omitted if EDID works reliably.
> > +    required:
> > +      - port@0
> 
> Have you tried to validate those two ports in a DT?

Yes, it validates as expected, like I wrote. Various sources told me that
json-schema is not always straightforward so I assumed anyOf was OK.

> I'm not quite sure what you wanted to express with that anyOf, but if
> it was something like port@0 is mandatory, and port@1 is optional, it
> should be something like this:
> 
> properties:
> 
>   ...
> 
>   ports:
>     type: object
> 
>     properties:
>       port@0:
>         type: object
>         description: |
> 	  Video port for LVTTL input
> 
>       port@1:
>         type: object
>         description: |
> 	  Video port for eDP output (..)
> 
>     required:
>       - port@0
> 
> This way, you express that both port@0 and port@1 must by nodes, under
> a node called ports, and port@0 is mandatory.

That validates, too. Looks better, admittedly. I don't have a strong
opinion here. It's just that Rob wrote in
<CAL_JsqKAU3WG3L=KP8A8u4vW=q_BQWPN-m_c+ADOwTioJ2-cmg@mail.gmail.com>:

| For this case specifically, we do need to define a common graph
| schema, but haven't yet. You can assume we do and only really need to    
| capture what Maxime said above.
(your points back then were port@N descriptions and neccessity for port@0)

Are you sure that "object" is specific enough?

> You should even push this a bit further by adding
> additionalProperties: false to prevent a DT from having undocumented
> properties and children for the main node and ports node.

You mean like

| jsonschema.exceptions.SchemaError: Additional properties are not allowed ('unevaluatedProperties' was unexpected)
[...]
| On schema:
|    {'$id': 'http://devicetree.org/schemas/watchdog/allwinner,sun4i-a10-wdt.yaml#',
[...]
|      'unevaluatedProperties': False}

? ;-)

But yes, this patch series passes even with additionalProperties: false.

In which form would you like to receive the update?

	Torsten

