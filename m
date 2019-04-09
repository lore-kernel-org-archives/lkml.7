Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42F4C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996772077C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQigrRqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfDIRtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:49:36 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38964 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfDIRtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:49:36 -0400
Received: by mail-it1-f194.google.com with SMTP id 139so6401119ita.4;
        Tue, 09 Apr 2019 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MoFB4KGbO5bnWW9b0d3DZz7QfAbAO0D02d4oxMDK29s=;
        b=nQigrRqVGbbEZU1twqk9nfPDh5fO2Jx6vhF5F6LsXrIvZHq5QQy99HLun0wTRKbkMJ
         c6D7rNW3M0boELO6iIg6SE99EYX9QNa0CBFzyvDfUkdHzWQlZq3x/DIVViKeBekr0Pua
         dUy+YQNo4g7xBgn3IzAglR0k5s1OAmjBW3Z8lXYAfQjHQJyQyILmMSukLrtMz2hGZPh2
         MrjPGmhWCqS92OiQm8OBEPTVbBh4YqQuOKJ1zA1n/Hrhe59LHjmzhjWF/RGfi7Amk66H
         n7b722aQ/SNS+FU1QHYRxtPGKmqKJL+9RIEolwPjQ0bMGM6NIQcDKYibScmeaVyUkC+4
         MDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MoFB4KGbO5bnWW9b0d3DZz7QfAbAO0D02d4oxMDK29s=;
        b=i5N2LeCOEp2ofN0u21syGyPL5FflXfbbwxp05pJgZfDVAEbbSA48Oklff/yHoDQbR9
         nb2LuqBIg2TagubnFqlFOKmjNEpmgQuElYEjXR8vAd3IYStilG4bmOxKsn4NNNjpA/Aq
         9vA6NIXcd+cmnOI7qWnGMjQQlY1j2RBel9KBkKrywIqIONY/fFR7boTyZj20c2Xfqbnz
         aQTRN0R9mb8LakgWxoXvxDwG3aWMh2uBLw52YYDAdIBhUIt/NvJFkrOzk+g0nKzui+4N
         x7snCPH36SE+teduwAfE6p0HsZqVYFL6Z9BrSeo7Ojz38UqRT9DoulbIt2JGOk1t1pth
         eT0g==
X-Gm-Message-State: APjAAAUkP+vNvai4Lzrme5q0/sFLIQFe9gpqo+toLG/QjQm5t/kElOGQ
        66gMKjjqq4QjKhg/gH+0hLjpS9UjAndPNDtnaV8=
X-Google-Smtp-Source: APXvYqxxttc5uh6VUStni4vuoLdqP9WDh1iFM4CNn54DM6JOU3WpVNQZ5ka9SimkO2DUdHY1bBjlffvS+R50V1ry3L8=
X-Received: by 2002:a05:6638:110:: with SMTP id x16mr27724565jao.75.1554832174769;
 Tue, 09 Apr 2019 10:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190405102455.15311-1-tiny.windzz@gmail.com> <20190405102455.15311-3-tiny.windzz@gmail.com>
 <20190405145532.cstvbv3mxbzrmpxp@flea> <CAEExFWuDjD2Ur6UuCPD_m=hvUYJj7Z=NqQ7KXXR+tmnVtDqfbQ@mail.gmail.com>
 <20190409080931.5x36pgtwhdjh2lkq@flea>
In-Reply-To: <20190409080931.5x36pgtwhdjh2lkq@flea>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Wed, 10 Apr 2019 01:49:23 +0800
Message-ID: <CAEExFWs8jn1-Ht6Rq0ukL=Kz0sTwgf+kJzxw3Js=6hX+2OjYTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: cpufreq: Document operating-points-v2-sunxi-cpu
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Chen-Yu Tsai <wens@csie.org>, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.ferre@microchip.com, Linux PM <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 4:10 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Apr 09, 2019 at 12:13:58AM +0800, Frank Lee wrote:
> > On Fri, Apr 5, 2019 at 10:55 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > Hi,
> > >
> > > On Fri, Apr 05, 2019 at 06:24:55AM -0400, Yangtao Li wrote:
> > > > Allwinner Process Voltage Scaling Tables defines the voltage and
> > > > frequency value  based on the speedbin blown in the efuse combination.
> > > > The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> > > > provide the OPP framework with required information.
> > > > This is used to determine the voltage and frequency value for each
> > > > OPP of operating-points-v2 table when it is parsed by the OPP framework.
> > > >
> > > > This change adds documentation for the DT bindings.
> > > > The "operating-points-v2-sunxi-cpu" DT extends the "operating-points-v2"
> > > > with following parameters:
> > > > - nvmem-cells (NVMEM area containig the speedbin information)
> > > > - opp-supported-hw: A single 32 bit bitmap value,
> > > >   representing compatible HW:
> > > >                       0:      speedbin 0
> > > >                       1:      speedbin 1
> > > >                       2:      speedbin 2
> > > >                       3-31:   unused
> > > >
> > > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > > ---
> > > >  .../bindings/opp/sunxi-nvmem-cpufreq.txt      | 235 ++++++++++++++++++
> > > >  1 file changed, 235 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> > > > new file mode 100644
> > > > index 000000000000..80201d4e5147
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> > > > @@ -0,0 +1,235 @@
> > > > +Allwinner Technologies, Inc. NVMEM CPUFreq and OPP bindings
> > > > +===================================
> > > > +
> > > > +For some SoCs, the CPU frequency subset and voltage value of each OPP
> > > > +varies based on the silicon variant in use. Allwinner Process Voltage
> > > > +Scaling Tables defines the voltage and frequency value  based on the
> > > > +speedbin blown in the efuse combination. The sunxi-cpufreq-nvmem driver
> > > > +reads the efuse value from the SoC to provide the OPP framework with
> > > > +required information.
> > > > +
> > > > +Required properties:
> > > > +--------------------
> > > > +In 'cpus' nodes:
> > > > +- operating-points-v2: Phandle to the operating-points-v2 table to use.
> > > > +
> > > > +In 'operating-points-v2' table:
> > > > +- compatible: Should be
> > > > +     - 'operating-points-v2-sunxi-cpu'.
> > > > +- nvmem-cells: A phandle pointing to a nvmem-cells node representing the
> > > > +             efuse registers that has information about the
> > > > +             speedbin that is used to select the right frequency/voltage
> > > > +             value pair.
> > > > +             Please refer the for nvmem-cells
> > > > +             bindings Documentation/devicetree/bindings/nvmem/nvmem.txt
> > > > +             and also examples below.
> > > > +
> > > > +In every OPP node:
> > > > +- opp-supported-hw: A single 32 bit bitmap value, representing compatible HW.
> > > > +                 Bitmap:
> > > > +                     0:      speedbin 0
> > > > +                     1:      speedbin 1
> > > > +                     2:      speedbin 2
> > > > +                     3-31:   unused
> > >
> > > I'm wondering if that's the right approach.
> > >
> > > I guess we could also have three different OPP tables, and pass them
> > > all three through a phandle array, and have the kernel code select
> > > which one is relevant based on the SID content
> >
> > It's ok. But why not use the way we already have?
> > Is it necessary to introduce new helper?
>
> My main concern is that it becomes quite difficult to differentiate
> the various OPPs, and to which bin a particular OPP is belonging to,
> while the more traditional OPPv2 makes it much more obvious.
Hi Maxime,

How about the newer patch ?
I think it is clearer. Just add a printk and people will know the opp
information used.

Yangtao
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
