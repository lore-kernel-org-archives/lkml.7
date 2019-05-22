Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44947C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA6B20815
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="duXL9btW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbfEVMBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:01:24 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:34236 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfEVMBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:01:23 -0400
Received: by mail-it1-f195.google.com with SMTP id g23so5342468iti.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 05:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a0sgS6JiPQaMdmqr0pmDguVAsGhTr/YF3Eo5mOXHScw=;
        b=duXL9btWJwwi+wIeMidO21e/PYLqCPnvpseC4tuFVlunBET+P86h4wWHns03Omsey+
         auG5o28oXmMSQ9x0BMuI3HHM1tShs0xrJtA92QfB05yn529qjxCxysO3pRt0cPknUezE
         tPS80c1NMwufr3mogOJ/7VZPgFMc7CGvw/ad8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0sgS6JiPQaMdmqr0pmDguVAsGhTr/YF3Eo5mOXHScw=;
        b=O5VXFb4mDO3Xy8ddhLwvl0Iy3zC4X3BZjv5s94w/l6Jphqq+1UFMRegFEzNWfBY9JC
         Gr2E87ScVctloEvEzxCpJjEx+HIJzMv2F/clAHtD4pkHWS4aLrIweguejWz61Y59RIJh
         gvuyhwmBTVPZqbwNbs0/ST0H/uGe0CTnQFTqTg8bmJnc7lhxN/SNjlDew2NWCs2iBK+4
         KOUmB00XOd2NHk913KRj/l3f7TfHIlV+INQ52nv2blEj1xNBm+mM6ExCKtsjNI3bI7KA
         mv3iUXIlLjnE56m7J6Je++hnuoHFECCWdFHzpxgHZrf04LR+ppJ4vXBNjWRH+0bX5Rbw
         hSbA==
X-Gm-Message-State: APjAAAUvPou7DSg/E0Y7LJnT7LIQkwPOmm9FHtGp2oZcexvvpYsP7Q+v
        G+VSW8fDOuEjUrhO/kW3Z7H6SHZbYKLYKprZMh9TGw==
X-Google-Smtp-Source: APXvYqxmTssug6sa7NiW2YWZql6kODBlYCZUD1kCFBempFTb+E4be0jz47x+9V2Yy9CA5auFDdC4/zjMd5z+PrC42vU=
X-Received: by 2002:a24:590f:: with SMTP id p15mr7744336itb.12.1558526482322;
 Wed, 22 May 2019 05:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190315130825.9005-1-jagan@amarulasolutions.com>
 <20190315130825.9005-4-jagan@amarulasolutions.com> <c232d5620d6a3272a6064ce9ccdec5c86a3a7950.camel@bootlin.com>
In-Reply-To: <c232d5620d6a3272a6064ce9ccdec5c86a3a7950.camel@bootlin.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 22 May 2019 17:31:10 +0530
Message-ID: <CAMty3ZC=cLNbJAeDBGCyYrknB5LWriL-pisk7j=jXQ54bse7XQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 3/6] drm/sun4i: dsi: Add bridge support
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
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
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul and Maxime,

On Fri, Mar 15, 2019 at 7:03 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi,
>
> On Fri, 2019-03-15 at 18:38 +0530, Jagan Teki wrote:
> > Some display panels would come up with a non-DSI output which
> > can have an option to connect DSI interface by means of bridge
> > convertor.
> >
> > This DSI to non-DSI bridge convertor would require a bridge
> > driver that would communicate the DSI controller for bridge
> > functionalities.
> >
> > So, add support for bridge functionalities in Allwinner DSI
> > controller.
>
> See a few comments below.
>
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 65 +++++++++++++++++++-------
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  1 +
> >  2 files changed, 49 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > index 0960b96b62cc..64d74313b842 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -781,6 +781,9 @@ static void sun6i_dsi_encoder_enable(struct drm_encoder *encoder)
> >       if (!IS_ERR(dsi->panel))
> >               drm_panel_prepare(dsi->panel);
> >
> > +     if (!IS_ERR(dsi->bridge))
> > +             drm_bridge_pre_enable(dsi->bridge);
> > +
> >       /*
> >        * FIXME: This should be moved after the switch to HS mode.
> >        *
> > @@ -796,6 +799,9 @@ static void sun6i_dsi_encoder_enable(struct drm_encoder *encoder)
> >       if (!IS_ERR(dsi->panel))
> >               drm_panel_enable(dsi->panel);
> >
> > +     if (!IS_ERR(dsi->bridge))
> > +             drm_bridge_enable(dsi->bridge);
> > +
> >       sun6i_dsi_start(dsi, DSI_START_HSC);
> >
> >       udelay(1000);
> > @@ -812,6 +818,9 @@ static void sun6i_dsi_encoder_disable(struct drm_encoder *encoder)
> >       if (!IS_ERR(dsi->panel)) {
> >               drm_panel_disable(dsi->panel);
> >               drm_panel_unprepare(dsi->panel);
> > +     } else if (!IS_ERR(dsi->bridge)) {
> > +             drm_bridge_disable(dsi->bridge);
> > +             drm_bridge_post_disable(dsi->bridge);
> >       }
> >
> >       phy_power_off(dsi->dphy);
> > @@ -973,11 +982,16 @@ static int sun6i_dsi_attach(struct mipi_dsi_host *host,
> >       struct sun6i_dsi *dsi = host_to_sun6i_dsi(host);
> >
> >       dsi->device = device;
> > -     dsi->panel = of_drm_find_panel(device->dev.of_node);
> > -     if (IS_ERR(dsi->panel))
> > -             return PTR_ERR(dsi->panel);
> >
> > -     dev_info(host->dev, "Attached device %s\n", device->name);
> > +     dsi->bridge = of_drm_find_bridge(device->dev.of_node);
> > +     if (!dsi->bridge) {
>
> You are using IS_ERR to check that the bridge is alive in the changes
> above, but switch to checking that it's non-NULL at this point.
>
> Are both guaranteed to be interchangeable?
>
> > +             dsi->panel = of_drm_find_panel(device->dev.of_node);
> > +             if (IS_ERR(dsi->panel))
> > +                     return PTR_ERR(dsi->panel);
> > +     }
>
> You should probably use drm_of_find_panel_or_bridge instead of
> duplicating the logic here.

True, In-fact I did try this API. but pipeline were unable to bound.
Usually the panel and bridge were attached first and then the pipeline
bound would start from front-end (in A33) But in my below cases I have
seen only panel or bridge attached but no pipeline bound at all.

And I'm using drm_of_find_panel_or_bridge(host->dev->of_node, 1, 0,
&dsi->panel, &dsi->bridge); in dsi attach API.

Case-1, panel:

&dsi {
    vcc-dsi-supply = <&reg_dcdc1>;        /* VCC3V3-DSI */
    status = "okay";

    ports {
        dsi_out: port@1 {
            reg = <1>;

            dsi_out_panel: endpoint {
                remote-endpoint = <&panel_out_dsi>;
            };
        };
    };

    panel@0 {
        compatible = "bananapi,s070wv20-ct16-icn6211";
        reg = <0>;
        enable-gpios = <&pio 1 7 GPIO_ACTIVE_HIGH>; /* LCD-PWR-EN: PB7 */
        reset-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* LCD-RST: PL5 */
        backlight = <&backlight>;

        port {
            panel_out_dsi: endpoint {
                remote-endpoint = <&dsi_out_panel>;
            };
        };
    };
};

Case-2, bridge:

    panel {
        compatible = "bananapi,s070wv20-ct16", "simple-panel";
        enable-gpios = <&pio 1 7 GPIO_ACTIVE_HIGH>; /* LCD-PWR-EN: PB7 */
        backlight = <&backlight>;

        port {

            panel_out_bridge: endpoint {
                remote-endpoint = <&bridge_out_panel>;
            };
        };
    };

&dsi {
    vcc-dsi-supply = <&reg_dcdc1>;        /* VCC-DSI */
    status = "okay";

    ports {
        dsi_out: port@1 {
            reg = <1>;

            dsi_out_bridge: endpoint {
                remote-endpoint = <&bridge_out_dsi>;
            };
        };
    };

    bridge@0 {
        reg = <0>;
        compatible = "bananapi,icn6211", "chipone,icn6211";
        reset-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* LCD-RST: PL5 */
        #address-cells = <1>;
        #size-cells = <0>;

        ports {
            #address-cells = <1>;
            #size-cells = <0>;

            bridge_in: port@0 {
                reg = <0>;

                bridge_out_dsi: endpoint {
                    remote-endpoint = <&dsi_out_bridge>;
                };
            };

            bridge_out: port@1 {
                reg = <1>;

                bridge_out_panel: endpoint {
                    remote-endpoint = <&panel_out_bridge>;
                };
            };
        };
    };
};

I think, I'm sure about the pipeline connections as per my
understanding. but something loosely missed here or in the code.
Please do let me know for any suggestions.

Jagan.
