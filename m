Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A46C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B579920863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mZdIOVyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfCRQ6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:58:23 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40265 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfCRQ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:58:22 -0400
Received: by mail-it1-f194.google.com with SMTP id l139so22417996ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 09:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=timxIiuZ6C5qXFE9PGZ2nUTtUi+iw25UcWJsW0Veig0=;
        b=mZdIOVyIRzqr8nvsAQGZKbjCIA0qKeZookwiMc+1aWtmDD/qot3TPqxL67NY653tcf
         JS6eJANN1oPYsvP1OzWukNP+19gLzc5pPixehx0gQJsoVxk4BlPCOsWthUu6wBEDd6aP
         2B05SOS4UwEuk7D97WUsbiLuXs2K/NOjX+NOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=timxIiuZ6C5qXFE9PGZ2nUTtUi+iw25UcWJsW0Veig0=;
        b=uiXTfmTrkAgVZknG2Y8xc7aAWdISJ5uET7D8C44rCvmqhXmGLHDVF2H3/tkPWU2+Qp
         nYZC8O6FplxmNiMA9/PEnhum+KqyITXYpm/kKdTHWjP2MmuG3+wfLatAj/HV1GhBgspd
         LAFxhHktY2dPQ0A6I5f+pA7xOlaWVwJBN9KbIuALmLCQXj+dRO7mhLshIjZCbBtcHAB2
         Ce4FAqVaxgbQ15H8GK3Z+0MYNdQ1FZ9gDTf/hRbr/Z5J14J6n5Dlv7CW9mGE3ImtgRLf
         g/68ksiJFifcodUeiPfA79fu+YK3jbknBepQSBCm89SJ/0IFydUYYpR2Ge4z+/GcRNVQ
         59AA==
X-Gm-Message-State: APjAAAWeRTl4BsgJ92Ix8D0WrHiy+JVX+z9Ng45V8+B9DhBIESBjMRhY
        lYcx024OXy4rVEVLtNRETumLU30kKUzgKABX/5cD1Q==
X-Google-Smtp-Source: APXvYqzOu0dIeGY9CvPAIgV/jvPre6u/O5i4VXqu/6iOchwtUidekLQTm1n2WCNK7JksE/hGLbuFl9AulVlgRy2maQY=
X-Received: by 2002:a05:660c:252:: with SMTP id t18mr11519805itk.173.1552928301904;
 Mon, 18 Mar 2019 09:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190315130825.9005-1-jagan@amarulasolutions.com>
 <20190315130825.9005-5-jagan@amarulasolutions.com> <20190315133414.5zwc5qtrivrbrzow@flea>
In-Reply-To: <20190315133414.5zwc5qtrivrbrzow@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 18 Mar 2019 22:28:10 +0530
Message-ID: <CAMty3ZBn=MjB-VxwadkEDaM_==hGu1pzTv2A47cKitv0Vb5VXw@mail.gmail.com>
Subject: Re: [PATCH 4/6] dt-bindings: display: bridge: Add ICN6211 MIPI-DSI to
 RGB convertor bridge
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 7:04 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Mar 15, 2019 at 06:38:23PM +0530, Jagan Teki wrote:
> > ICN6211 is MIPI-DSI/RGB converter bridge from chipone.
> > It has a flexible configuration of MIPI DSI signal input
> > and produce RGB565, RGB666, RGB888 output format.
> >
> > Add dt-bingings for it.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  .../display/bridge/chipone,icn6211.txt        | 36 +++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt
> > new file mode 100644
> > index 000000000000..7f13efd7ee7f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt
> > @@ -0,0 +1,36 @@
> > +Chipone ICN6211 MIPI-DSI to RGB Convertor Bridge
> > +
> > +ICN6211 is MIPI-DSI/RGB converter bridge from chipone.
> > +It has a flexible configuration of MIPI DSI signal input
> > +and produce RGB565, RGB666, RGB888 output format.
> > +
> > +Required properties for RGB:
> > +- compatible: must be "chipone,icn6211" and one of:
> > +  * "bananapi,icn6211"
>
> Why is that compatible needed?

chipone,icn6211 - generic compatible bridge controller IC
bananapi,icn6211 -  compatible for icn6211 bridge using on bananapi panel

I hope this would be proper bindings in terms of controller IC with
associate device, anything wrong? Infact I used similar reference from
Ilitek Bananapi panel from here
Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt

This is what I understood based on dt-binding, correct if I'm wrong.

ilitek,ili9881c - generic ilitek,ili9881c compatable
bananapi,lhr050h41 - compatible for bananapi panel associated with
this ilitek IC

>
> > +- reg: the virtual channel number of a DSI peripheral
> > +- reset-gpios: a GPIO phandle for the reset pin
> > +
> > +The device node can contain following 'port' child nodes,
> > +according to the OF graph bindings defined in [1]:
> > +  0: DSI Input, not required, if the bridge is DSI controlled
> > +  1: RGB Output, mandatory
>
> Your example doesn't have that input port

Yes, I intentionally did this by referring existing bridge binding.
Documentation/devicetree/bindings/display/bridge/toshiba,tc35876*.txt

Do we really need? since the input port can be part of panel binding.
