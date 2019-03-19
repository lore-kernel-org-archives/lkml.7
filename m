Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A10C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 07:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32BC20989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 07:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jFML4Hgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfCSHsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 03:48:35 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36458 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCSHse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 03:48:34 -0400
Received: by mail-it1-f193.google.com with SMTP id h9so3330086itl.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 00:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g+xr/SOAxOJeQKx7fzIkY/QbRd/ireuzdXNkxy00mmQ=;
        b=jFML4HgkEkwOMNvHtm7ji3p51vOwO6uKXoGBk0r8ig/O/Sm1TtvluNX7fCjJjj9YRn
         Nyq8Js0Ab9tl2ZEaHM+vmc8f86FwLizix+FgFgUt8c5zPFz5gq45ULqhw3EDXucrwSyQ
         hKN4qFaULzAubwq1yavDSu2Oia6xbCHLqJ+ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+xr/SOAxOJeQKx7fzIkY/QbRd/ireuzdXNkxy00mmQ=;
        b=JQk9DZmp4d5fw5Z9HlIVhMfna9BiqzsSA0TCJ07lRDORPFMHDS2Xk9u4MJ2SUIpPgm
         UpmDCNdyiSY/5wXSwFGjVumu8WuuTPWH82ok3sXtYveMQ1b2KGyJjedTE3MFWcI443pp
         mH010B3BPG1MmYt75It1fKe/yF9ybvq9fhT3Nlr0IMwxxuR8xrG51ptaz35DqyTp7C+f
         J+a3Nc6K1f8Czd2tR5AIP+TXwM5o4VrJ+LiJbjy7xSfo2oMN2L1xCkGENQK+eMAmvKG/
         brFgX84BQFP4ww4o1vO4echo6KKOTQEw1KzNI3D4mebi6c1PwwJVIsPTdSV8ImzNvHX2
         2Pcg==
X-Gm-Message-State: APjAAAWr3yN9/n7ervCV3ekiOViT6wq4uXhR3YybG3TijMBG8uR+7ssf
        Q2oq7ipjUmnNiMFgQzbVVsv/dcI0yaFuAtK+U0W8LA==
X-Google-Smtp-Source: APXvYqyb68UUVVNyi4p1YGb2ynJmkDsaofw4xmpWiajE+2dNzUY9v+BKcOX/KIp+Gz0HiLYofu/c2C0OiozRYPV1Hzs=
X-Received: by 2002:a05:660c:252:: with SMTP id t18mr545368itk.173.1552981712770;
 Tue, 19 Mar 2019 00:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190315130825.9005-1-jagan@amarulasolutions.com>
 <20190315130825.9005-5-jagan@amarulasolutions.com> <20190315133414.5zwc5qtrivrbrzow@flea>
 <CAMty3ZBn=MjB-VxwadkEDaM_==hGu1pzTv2A47cKitv0Vb5VXw@mail.gmail.com> <CAGb2v66mkSTxhR_p4iRYR-hqzxw2QFK9iv3WsQ7NOQ2mT2mSiw@mail.gmail.com>
In-Reply-To: <CAGb2v66mkSTxhR_p4iRYR-hqzxw2QFK9iv3WsQ7NOQ2mT2mSiw@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 19 Mar 2019 13:18:21 +0530
Message-ID: <CAMty3ZCB6MV+dyOM71mAP7=+KVb8Ym12Y-j8FFZf4YknLKhc4A@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 4/6] dt-bindings: display: bridge: Add
 ICN6211 MIPI-DSI to RGB convertor bridge
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
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

On Tue, Mar 19, 2019 at 8:29 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Tue, Mar 19, 2019 at 12:58 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > On Fri, Mar 15, 2019 at 7:04 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Fri, Mar 15, 2019 at 06:38:23PM +0530, Jagan Teki wrote:
> > > > ICN6211 is MIPI-DSI/RGB converter bridge from chipone.
> > > > It has a flexible configuration of MIPI DSI signal input
> > > > and produce RGB565, RGB666, RGB888 output format.
> > > >
> > > > Add dt-bingings for it.
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > ---
> > > >  .../display/bridge/chipone,icn6211.txt        | 36 +++++++++++++++++++
> > > >  1 file changed, 36 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt
> > > > new file mode 100644
> > > > index 000000000000..7f13efd7ee7f
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt
> > > > @@ -0,0 +1,36 @@
> > > > +Chipone ICN6211 MIPI-DSI to RGB Convertor Bridge
> > > > +
> > > > +ICN6211 is MIPI-DSI/RGB converter bridge from chipone.
> > > > +It has a flexible configuration of MIPI DSI signal input
> > > > +and produce RGB565, RGB666, RGB888 output format.
> > > > +
> > > > +Required properties for RGB:
> > > > +- compatible: must be "chipone,icn6211" and one of:
> > > > +  * "bananapi,icn6211"
> > >
> > > Why is that compatible needed?
> >
> > chipone,icn6211 - generic compatible bridge controller IC
> > bananapi,icn6211 -  compatible for icn6211 bridge using on bananapi panel
> >
> > I hope this would be proper bindings in terms of controller IC with
> > associate device, anything wrong? Infact I used similar reference from
> > Ilitek Bananapi panel from here
> > Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt
> >
> > This is what I understood based on dt-binding, correct if I'm wrong.
> >
> > ilitek,ili9881c - generic ilitek,ili9881c compatable
> > bananapi,lhr050h41 - compatible for bananapi panel associated with
> > this ilitek IC
>
> ili9881c is an LCD driver chip with a MIPI DSI interface. It directly
> drives the LCD panel, not outputting some RGB stuff. So it is a binding
> and driver for a panel, not a bridge in your case.
>
> > >
> > > > +- reg: the virtual channel number of a DSI peripheral
> > > > +- reset-gpios: a GPIO phandle for the reset pin
> > > > +
> > > > +The device node can contain following 'port' child nodes,
> > > > +according to the OF graph bindings defined in [1]:
> > > > +  0: DSI Input, not required, if the bridge is DSI controlled
> > > > +  1: RGB Output, mandatory
> > >
> > > Your example doesn't have that input port
> >
> > Yes, I intentionally did this by referring existing bridge binding.
> > Documentation/devicetree/bindings/display/bridge/toshiba,tc35876*.txt
> >
> > Do we really need? since the input port can be part of panel binding.
>
> How could the input port of _your_ _bridge_ be part of the panel binding?

Here the panel is from another vendor say bananapi, so the binding of
that part could be already covered ie is what I mean.

Since I mentioned I took the reference binding from another bridge. It
has similar structure of binding / example.
arch/arm/boot/dts/exynos5250-arndale.dts
Bridge example binding:
Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
Panel example binding mentioned here
Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
