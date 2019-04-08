Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2B2C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88AC821473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9TU8KgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfDHQOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:14:11 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34220 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbfDHQOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:14:11 -0400
Received: by mail-it1-f194.google.com with SMTP id z17so362908itc.1;
        Mon, 08 Apr 2019 09:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/tGx6xAR3YCjanY8oQehQa0QqUSHh/RTqgaBS7JAGck=;
        b=F9TU8KgGQs2jcdOWKFua1MEy03htztSYf3L/ZwY9nkEuCCpcUU4ltKBVzMsgyqX+Hs
         5ojxcfbr1JhR4QoWFJjfRbnj37gsG5awLuQc8xs7luC7MjPS5ab85tu0oQI3WcnvAoiv
         QO7bdB9syGjXy2lUUp4eBrnjDo9uD7h1sVNy9y9I3n7eX8XAdOmCCDH9g+kcdMJ2kz8B
         u3i3k7KWVcJRq46ZEgCrgnkyN1SrDVOm/52xSCP6PnHrZ5xuGrsgv9OandFKGD8fuSZs
         rWjPCA/ht7Nt3q4CqupA3CU7V15CU0h4bvfnqq2igiPG8A0Av+6RV6qUSd5xqpxwTSi/
         VN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/tGx6xAR3YCjanY8oQehQa0QqUSHh/RTqgaBS7JAGck=;
        b=thwQd5frNu2tbuutesvEQ1e+GVtl/GiUhTvRdzyeI0uYcJy/AH04vShBE9UF30boTG
         4TuefwU0IxxECdORA2dMzCOF+s4uwXGgyMchS4HBzmECufAed7paf+mUMuysnafe3psQ
         4b7PxS69NXyfFytW0XK77fCcsA1MCYGcji2fM3NjkIbYa/1vO/8DGGbNd1fF0vmC/eTB
         EX1CJOulhgK7BgZ0HiYaR9aKe6iXoBUpG4n+ZYjHkabKTzMsTAuFg/q+fy/I0tar/NF5
         k3tww6wj00y3u9uNLuXdmEpb82aqcV5Z3fSwDwerwe5yNnyLR+D0nJqmNnFeK/V44YQU
         ASJA==
X-Gm-Message-State: APjAAAWZdcwP1ne4/XcyiAaM1T/cqvmaMHhbCuAxASj3shWXMJKnAWWp
        sjQfx5ZbYrP/MBlz48npRTV33RBusZJzHps5y0A=
X-Google-Smtp-Source: APXvYqx6M8eQx9p9BYMoe6Qv9uywuoTe6QWpJe8brWgXjWRdFDqOoitU9vZ565qRUD6e2XnLh44p2mTpTR3P1m0yE/I=
X-Received: by 2002:a24:e346:: with SMTP id d67mr3028631ith.42.1554740049908;
 Mon, 08 Apr 2019 09:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190405102455.15311-1-tiny.windzz@gmail.com> <20190405102455.15311-3-tiny.windzz@gmail.com>
 <20190405145532.cstvbv3mxbzrmpxp@flea>
In-Reply-To: <20190405145532.cstvbv3mxbzrmpxp@flea>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 9 Apr 2019 00:13:58 +0800
Message-ID: <CAEExFWuDjD2Ur6UuCPD_m=hvUYJj7Z=NqQ7KXXR+tmnVtDqfbQ@mail.gmail.com>
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

On Fri, Apr 5, 2019 at 10:55 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> On Fri, Apr 05, 2019 at 06:24:55AM -0400, Yangtao Li wrote:
> > Allwinner Process Voltage Scaling Tables defines the voltage and
> > frequency value  based on the speedbin blown in the efuse combination.
> > The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> > provide the OPP framework with required information.
> > This is used to determine the voltage and frequency value for each
> > OPP of operating-points-v2 table when it is parsed by the OPP framework.
> >
> > This change adds documentation for the DT bindings.
> > The "operating-points-v2-sunxi-cpu" DT extends the "operating-points-v2"
> > with following parameters:
> > - nvmem-cells (NVMEM area containig the speedbin information)
> > - opp-supported-hw: A single 32 bit bitmap value,
> >   representing compatible HW:
> >                       0:      speedbin 0
> >                       1:      speedbin 1
> >                       2:      speedbin 2
> >                       3-31:   unused
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  .../bindings/opp/sunxi-nvmem-cpufreq.txt      | 235 ++++++++++++++++++
> >  1 file changed, 235 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> >
> > diff --git a/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> > new file mode 100644
> > index 000000000000..80201d4e5147
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
> > @@ -0,0 +1,235 @@
> > +Allwinner Technologies, Inc. NVMEM CPUFreq and OPP bindings
> > +===================================
> > +
> > +For some SoCs, the CPU frequency subset and voltage value of each OPP
> > +varies based on the silicon variant in use. Allwinner Process Voltage
> > +Scaling Tables defines the voltage and frequency value  based on the
> > +speedbin blown in the efuse combination. The sunxi-cpufreq-nvmem driver
> > +reads the efuse value from the SoC to provide the OPP framework with
> > +required information.
> > +
> > +Required properties:
> > +--------------------
> > +In 'cpus' nodes:
> > +- operating-points-v2: Phandle to the operating-points-v2 table to use.
> > +
> > +In 'operating-points-v2' table:
> > +- compatible: Should be
> > +     - 'operating-points-v2-sunxi-cpu'.
> > +- nvmem-cells: A phandle pointing to a nvmem-cells node representing the
> > +             efuse registers that has information about the
> > +             speedbin that is used to select the right frequency/voltage
> > +             value pair.
> > +             Please refer the for nvmem-cells
> > +             bindings Documentation/devicetree/bindings/nvmem/nvmem.txt
> > +             and also examples below.
> > +
> > +In every OPP node:
> > +- opp-supported-hw: A single 32 bit bitmap value, representing compatible HW.
> > +                 Bitmap:
> > +                     0:      speedbin 0
> > +                     1:      speedbin 1
> > +                     2:      speedbin 2
> > +                     3-31:   unused
>
> I'm wondering if that's the right approach.
>
> I guess we could also have three different OPP tables, and pass them
> all three through a phandle array, and have the kernel code select
> which one is relevant based on the SID content

It's ok. But why not use the way we already have?
Is it necessary to introduce new helper?

>
> Another option would be to use the OF_DYNAMIC code to fill
> operating-points-v2 at kernel boot, before (or when) cpufreq kicks in.

My thought is to keep the same with others. And this situation may
make thingis complex though it works.

Hi  vireshk,

I want to hear from you.

Yours,
Yangtao

>
> ATF could also do that work.
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
