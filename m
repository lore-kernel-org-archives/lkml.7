Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9111AC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641922081C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qs55+I47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfEULI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 07:08:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43648 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbfEULI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 07:08:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id r4so18074259wro.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 04:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBS6HWr/GffYzp43R5kVqhTrERprItS/d4aXOx6tYbU=;
        b=qs55+I47fIDia0uwHqXxnq4cQTewSNeUP/6omcb5+qs0nKaYk7oGY6NYOOl8ofDFc6
         OUXvM97JqwtXQwpndLn4H0GRVozTLlSlIJHbGzQOwbI14jhyNOdbr1Zs2EwTVOZBDcyb
         FGcc2nUSDR18jboyFEO6tk/UOxJUEYJsVgv0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBS6HWr/GffYzp43R5kVqhTrERprItS/d4aXOx6tYbU=;
        b=YD8Zvibb0VPfC8IcHm1ZN+ScjLnV4KkVP9aRxEQEph4g5tXh2WAUwxz9HkB5Lhln2U
         OnbQfRBS5/ev5KGQIKIkrFghDGbd43oNFWlDX8f7u5B3DxiRLhNqbCyXrHmjxDZltfOq
         xoRc1Esv26nQYMgHKshdPhycVVyc8uHIGoGyZ+VrzYkgbf4Xr1bDgFh3m/Q+pLPG92B5
         qR5DccsgsjQeNYn/qEbWSJTDmkrmKi2u22BhAcI43gLXW641eyLGufj2mY1QrrkXLdeU
         sn52XZpJXhvIzF4yM7RrDIg0mbyZeLSCryh6JidbSh6MuRYj8uc34Up4UnX2xGD+0kY7
         /IGg==
X-Gm-Message-State: APjAAAWLwCuZL29mfm9dseh+pAKoBjijd5w5TiB4aiLlDw9ra8XBhlLA
        cmw5o3Y8OGm5X1Z+dpazoOfmsNav36z/v5GS12wM5Q==
X-Google-Smtp-Source: APXvYqzVlWiHrmG++c18iLZr+/EeWm5l0AOZnhEmmkXMdNCxfOZ6cpmzHxti9dv2vFcXgV4vwIgiEhUsPm77NDcpFoE=
X-Received: by 2002:adf:8189:: with SMTP id 9mr47758810wra.71.1558436903636;
 Tue, 21 May 2019 04:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190418141658.10868-1-jagan@amarulasolutions.com>
 <20190418145641.q23tupopz2czjzc5@flea> <CAOf5uwn8CtRs8cx0KC-bxNoRP4TiDrHi8F83QfjsZhueLDYFJg@mail.gmail.com>
 <20190521081001.zjq3gnlvyuyexz6m@flea>
In-Reply-To: <20190521081001.zjq3gnlvyuyexz6m@flea>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Tue, 21 May 2019 13:08:09 +0200
Message-ID: <CAOf5uwnhXjur=2NezCydaCxP5d33S+AwdD9WTDtp2EUJr4UTgg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: a64-oceanic-5205-5inmfd: Enable CAN
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Tue, May 21, 2019 at 10:10 AM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Tue, May 21, 2019 at 08:47:02AM +0200, Michael Nazzareno Trimarchi wrote:
> > > > +     };
> > > > +
> > > >  };
> > > >
> > > >  &ehci0 {
> > > > @@ -77,6 +95,31 @@
> > > >       status = "okay";
> > > >  };
> > > >
> > > > +&pio {
> > > > +     can_pins: can-pins {
> > > > +             pins = "PD6",                   /* RX_BUF1_CAN0 */
> > > > +                    "PD7";                   /* RX_BUF0_CAN0 */
> > > > +             function = "gpio_in";
> > > > +     };
> > > > +};
> > >
> > > That isn't needed. What are they used for, you're not tying them to
> > > anything?
> >
> > Mux of their function is correct. They are connected in the schematics
> > but not used right now.
>
> Then describe the whole thing or don't?
>

Ok

> And that's kind of missing my point. If that pin group isn't related
> to any device, the pin muxing will not be changed. So that group, in
> itself, has strictly no effect.
>
> Moreover, you don't need a pin group in the first place to mux pins in
> GPIOs, the GPIO API will make sure that is the case when you request
> it.

This is correct on sunxi. Is this valid for sunxi or in general in all the SoC?
Anyway make sense to have pins configured and place in the right
state, just suppose if the
booting stage is wrong or anything that make those pins in the wrong
configuration

>
> > I can garantee that kernel wlll always configurred in the right way
> > and if I want I can export in userspace
> > for debug purpose

Correct if you start to use it but if you want them right configured
the right place
is in the default state e/o initstate if this can be a problem of the hardware

Default state: the state the pinctrl handle shall be put
 *      into as default, usually this means the pins are up and ready to
 *      be used by the device driver. This state is commonly used by
 *      hogs to configure muxing and pins at boot, and also as a state
 *      to go into when returning from sleep and idle in
 *      .pm_runtime_resume() or ordinary .resume() for example.

Now the pins are connected to the canbus as should be and they are
configured and usually
put in the right state.

+               compatible = "microchip,mcp2515";
+               reg = <0>;
+               spi-max-frequency = <10000000>;
+               pinctrl-names = "default";
+               pinctrl-0 = <&can_pins>;

>
> Yes, because the API does it, not your change
>

Do you prefer to drop the pinmux? or update the commit message

> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
