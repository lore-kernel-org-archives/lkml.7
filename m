Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEAEC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3C3206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556308986;
	bh=MFsvDnfrVK3sHArh5k3FT74saEQojAOtl9AUQbsx/48=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=Ml+6yB9O+CZ4wlfYEZL9AdrbMsMuduOA5ul8Z819reMzDGd8MbTaAI8+HaJwFMV36
	 1pOH/ciKCq5cuDPRy8Qv4NJUmzXYy+HjsK6VtL69Uawi6CPcaOVFPmzjLpTQyvnozM
	 VRLvC2/ck9t1v+Z5j+aZHQBPfMc57R17MFz007Bo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfDZUDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 16:03:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfDZUDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 16:03:05 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1F30208CB;
        Fri, 26 Apr 2019 20:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556308984;
        bh=MFsvDnfrVK3sHArh5k3FT74saEQojAOtl9AUQbsx/48=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=a+ypkL0LFB9m7K05kXXBx7yK55lw2jAY8ndWIG7Hqyq3QPXRBkOly+mzOAl9h+3T9
         eMWj6wjmU0pmQttmKwp4R19fEA68MLT6j4P2w1y9g/H6kW+x3Cu1Fg8/oySQBpPFnS
         Jn0jSYqbO2IVzHCfnfwKZaE4l7HZ9lV9zxcePUdo=
Received: by mail-qk1-f169.google.com with SMTP id k189so2657610qkc.0;
        Fri, 26 Apr 2019 13:03:03 -0700 (PDT)
X-Gm-Message-State: APjAAAXSA1jZxK6oL03h33mhga9etedo7KcGDyRegGTUhFzVV3vC00ct
        6S/00VW5b6CCD4KIIeLjbGLu9k2J34e6FUrJkw==
X-Google-Smtp-Source: APXvYqw59w9DDW8H3XE3kRQ09i69KESQMWVGK8gINk/MNesTnNgbjR9TQBMpNBYMi1kRo5LmvWfNwJC8uvX/zvdBqP0=
X-Received: by 2002:a37:5c81:: with SMTP id q123mr20861653qkb.29.1556308983103;
 Fri, 26 Apr 2019 13:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190413165418.27880-1-megous@megous.com> <20190413165418.27880-7-megous@megous.com>
 <20190426182337.GA22245@bogus> <20190426192031.wtoaxctjo2qxxquq@core.my.home>
In-Reply-To: <20190426192031.wtoaxctjo2qxxquq@core.my.home>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 26 Apr 2019 15:02:50 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+o1j6AGL9UnhN1tV150DsFug6pg+UPEJ9EKqBc6rgq_w@mail.gmail.com>
Message-ID: <CAL_Jsq+o1j6AGL9UnhN1tV150DsFug6pg+UPEJ9EKqBc6rgq_w@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] dt-bindings: display: hdmi-connector: Add DDC
 power supply
To:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 2:20 PM Ond=C5=99ej Jirman <megous@megous.com> wrot=
e:
>
> On Fri, Apr 26, 2019 at 01:23:37PM -0500, Rob Herring wrote:
> > On Sat, Apr 13, 2019 at 06:54:15PM +0200, megous@megous.com wrote:
> > > From: Ondrej Jirman <megous@megous.com>
> > >
> > > Some Allwinner SoC using boards (Orange Pi 3 for example) need to ena=
ble
> > > on-board voltage shifting logic for the DDC bus to be usable. Use
> > > ddc-supply on the hdmi-connector to model this.
> > >
> > > Add binding documentation for optional ddc-supply property.
> > >
> > > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > > ---
> > >  .../devicetree/bindings/display/connector/hdmi-connector.txt     | 1=
 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/connector/hdmi=
-connector.txt b/Documentation/devicetree/bindings/display/connector/hdmi-c=
onnector.txt
> > > index 508aee461e0d..33085aeb0bb9 100644
> > > --- a/Documentation/devicetree/bindings/display/connector/hdmi-connec=
tor.txt
> > > +++ b/Documentation/devicetree/bindings/display/connector/hdmi-connec=
tor.txt
> > > @@ -9,6 +9,7 @@ Optional properties:
> > >  - label: a symbolic name for the connector
> > >  - hpd-gpios: HPD GPIO number
> > >  - ddc-i2c-bus: phandle link to the I2C controller used for DDC EDID =
probing
> > > +- ddc-supply: the power supply for the DDC bus
> >
> > It's not just for DDC. It powers the chips in bridge dongles for
> > example. Pretty much every diagram I find just calls it 5V or +5V.
> >
> > So how about '5V-supply' or 'v5V-supply'?
>
> Just to be sure, the schematic that inspired this change looks like this:
>
> https://megous.com/dl/tmp/33b2971de6943e9d.png
>
> HDMI-5V is always on, and what is really being enabled here are mosfets
> connected to DDC_CEC_EN and not the HDMI-5V power supply. So in this case=
 it
> really is just for DDC. It is conceivable that some boards may need both =
to
> enable 5V for HDMI circuitry and some separate power shifting logic for
> DDC bus.

Okay, not what I thought you were defining. DDC_CEC_EN is a GPIO line?
I wouldn't characterize this as a voltage rail, so I don't think it
should be a supply. Perhaps 'ddc-en-gpios'?

We certainly want to make it clear this is not the 5V supply.

Rob
