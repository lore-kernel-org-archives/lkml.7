Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FF6C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E91021835
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgABKyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 05:54:19 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39736 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgABKyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 05:54:18 -0500
Received: by mail-ed1-f65.google.com with SMTP id t17so38753171eds.6;
        Thu, 02 Jan 2020 02:54:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5QD3mTV0W/4zMKZocFG2xAVC0EzZ6xiQOGVc8d10hMw=;
        b=S+U7xkEw+bqPzZmbmdh+tFL67EajwW7M34T/aen1+CtS0ON9YLJi+5mZBou3brI/C6
         Yy5KCJ1zG6N6M78+E4eEq0UBhK3Wd7/f6EU77YCikiUJlEiXTz4zrzrAuKMikcN+Fmoi
         ZUhQ8mHVhrF1pSO/apYfnc3ZU3T3taTcA0+WK7r8RoOJTqZBvpsvDq9O+tmDK4pe+0z+
         uEwV8ivxIoyHecRFEAgfwUfQB33SJgGQup9mxf7Uu3NW2uZSrxs3ZbmwYaQAQ/2myJ4f
         2vB07V+kY434npKQC33NLoCOFIJPqRl2dApl2QjE3vSRb12Jo3dPFv+OwVuYmGk0BRx4
         cJqQ==
X-Gm-Message-State: APjAAAVsm22bv3n3lvRj4PWOZm6H0e4GJUX7vzb1Y4AXvgMg9vaXa3Xm
        OOc/tui0h7s/wh2Wjj8dgEAA5BNvbBw=
X-Google-Smtp-Source: APXvYqzz5gGaRZ5SpweHJJpRtc5QyhClxDSYFnxZcB03h4DC4ZvDH0owLNHWcpVfuQJN0E8CPn2Nxw==
X-Received: by 2002:a17:906:1653:: with SMTP id n19mr42595798ejd.3.1577962455932;
        Thu, 02 Jan 2020 02:54:15 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id q3sm7344294eju.88.2020.01.02.02.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 02:54:15 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id j42so38782440wrj.12;
        Thu, 02 Jan 2020 02:54:15 -0800 (PST)
X-Received: by 2002:adf:81e3:: with SMTP id 90mr81083838wra.23.1577962455125;
 Thu, 02 Jan 2020 02:54:15 -0800 (PST)
MIME-Version: 1.0
References: <20200102012657.9278-1-andre.przywara@arm.com> <20200102012657.9278-4-andre.przywara@arm.com>
 <20200102095711.dkd2cnbyitz6mvyx@gilmour.lan> <20200102104158.06d9baa0@donnerap.cambridge.arm.com>
In-Reply-To: <20200102104158.06d9baa0@donnerap.cambridge.arm.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 2 Jan 2020 18:54:03 +0800
X-Gmail-Original-Message-ID: <CAGb2v65TtEVcwD9RZda7Fja0Z4EZSyV06tAkJG147Hb7_nXq3A@mail.gmail.com>
Message-ID: <CAGb2v65TtEVcwD9RZda7Fja0Z4EZSyV06tAkJG147Hb7_nXq3A@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: sun8i: R40: Add SPI controllers nodes and pinmuxes
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 2, 2020 at 6:42 PM Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Thu, 2 Jan 2020 10:57:11 +0100
> Maxime Ripard <mripard@kernel.org> wrote:
>
> Hi Maxime,
>
> thanks for having a look!
>
> > On Thu, Jan 02, 2020 at 01:26:57AM +0000, Andre Przywara wrote:
> > > The Allwinner R40 SoC contains four SPI controllers, using the newer
> > > sun6i design (but at the legacy addresses).
> > > The controller seems to be fully compatible to the A64 one, so no driver
> > > changes are necessary.
> > > The first three controller can be used on two sets of pins, but SPI3 is
> > > only routed to one set on Port A.
> > >
> > > Tested by connecting a SPI flash to a Bananapi M2 Berry on the SPI0
> > > PortC header pins.
> > >
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > ---
> > >  arch/arm/boot/dts/sun8i-r40.dtsi | 89 ++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 89 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > index 8dcbc4465fbb..af437391dcf4 100644
> > > --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > @@ -418,6 +418,41 @@
> > >                             bias-pull-up;
> > >                     };
> > >
> > > +                   spi0_pc_pins: spi0-pc-pins {
> > > +                           pins = "PC0", "PC1", "PC2", "PC23";
> > > +                           function = "spi0";
> > > +                   };
> > > +
> > > +                   spi0_pi_pins: spi0-pi-pins {
> > > +                           pins = "PI10", "PI11", "PI12", "PI13", "PI14";
> > > +                           function = "spi0";
> > > +                   };
> >
> > This split doesn't really work though :/
> >
> > The PC pins group has MOSI, MISO, CLK and CS0, while the PI pins group
> > has CS0, CLK, MOSI, MISO and CS1.
> >
> > Meaning that if a board uses a GPIO CS pin, we can't really express
> > that
>
> Does that actually work? I dimly remember checking our sunxi driver a while ago and I wasn't sure that would be functional there.
>
> > and any board using the PI pins for its SPI bus will try to
> > claim CS0 and CS1, no matter how many devices are connected on the bus
> > (and if there's one, there might be something else connected to PI14).
>
> True.
>
> > And you can't have a board using CS1 with the PC signals either.
> >
> > You should split away the CS pins into separate groups, like we're
> > doing with the A20 for example.
>
> Ah, yeah, makes sense, thanks for the pointer.
>
> > And please add /omit-if-no-ref/ to those groups.
>
> I was a bit reluctant to do this:
> First there does not seem to be any good documentation about it, neither in the official DT spec nor in dtc, even though I think I understand what it does ;-)
> Second it seems to break in U-Boot atm. Looks like applying your dtc patch fixes that, though. Do you know if U-Boot allows cherry-picking dtc patches? If yes, I could post your patch.
>
> But more importantly: what are the guidelines for using this tag? I understand the desire to provide every possible pin description on one hand, but wanting to avoid having *all of them* in *each* .dtb on the other.

I believe it would be nice to have them for all pin descriptions, but
having them
for the peripherals that only have one muxing option probably wouldn't have any
effect, as they would be set and referenced by default in the dtsi.

> But how does this play along with overlays? Shouldn't at least those interface pins that are exposed on headers stay in each .dtb? Can we actually make this decision in the SoC .dtsi file?

In upstream dtc, I sent a patch to make it ignore the flag if you
compile the dts
with overlay support, i.e. with the -@ flag.

> And should there be a dtc command line option to ignore those tags, or even to apply this tag (virtually) to every node?

That would probably end up trimming peripherals out, even enabled ones?

ChenYu
