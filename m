Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA9FC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC082084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ysZs7YtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfDBEC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:02:29 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36271 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfDBEC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:02:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id d18so7883162lfn.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 21:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mEnHlHFgv3rjZawr7892Gum2foH9J2y5ehxHGPunKSw=;
        b=ysZs7YtLDdKwYHgIMULdyPRkVk1vdmqOZE3l0b8crM1DpxzBCvGZx0MdWa7H1Hnz5X
         0grpbl5LT6wHBSs/Yk/uIEgpXH2/t8qAPmuf8fDLVqILRiVr1i7xDt+AyPNioH4vOkEF
         HOOAkAdJnZWKdsv5daleqF+HKwyhSk9mqf8MlSbU4mPwwDtnlP7M0wURsqFABgpeQV7H
         GGYkeVfZva9e0a9bFaeRxpKi8xoyluObf8KUl7uJviu874kaOJzGXMyKe1dH8Z6ShUBe
         yBDkATvJqkXRCNbC43QA66oxFMTlf9uvFlV78jKASVWmM53Ct499+U8ZlOVhXVPVhbG0
         pJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEnHlHFgv3rjZawr7892Gum2foH9J2y5ehxHGPunKSw=;
        b=lJ4gtFpvtJYlu7FSmc0BlJbVTmNko0Rml3E0+EFhbEFGDBfaUJ8njrduUJoKn6Ew3X
         RInWaISOhI7/RprX3MdAT+JHLwggj6uJga0QVxDrhRVg4tZSIaT2FgYWjWAckJke/QMb
         JLnZrozK5AXZPcFSOP+LWMojlS+aNY97T5/TnB0F8WrsjrqEa95KmEPzXsWGUEINjIDy
         QNibVlp0nFRhi9KGUtBDl9renY1n+BgGpdIZsxjC5Rckz24RvPZfXosNhzZdqAbGU7ht
         MuNcI/WVOFWjRqOJZmIeeOe8iAuf4+d9nPlM9fFKoc7aeBVan6RqvZGIIV1+6ZzIhFH5
         ziWQ==
X-Gm-Message-State: APjAAAUfWO6VPiKa8gnOokug8ffYVpaMAmrREl6L+0rcLwbYUX5q2/Qa
        xUYKPT8nSmDi08VM73KGR3Whwndcm1XyeBMPajF5fQ==
X-Google-Smtp-Source: APXvYqyUnB+fS0V9xSsn/y9S8tEb93Xe13NUHTx1WdFbcbkomDJt31e3HG35QoMMhhXByzBFAReLIyH7jAwwNWl3TSQ=
X-Received: by 2002:ac2:485a:: with SMTP id 26mr34098628lfy.128.1554177744601;
 Mon, 01 Apr 2019 21:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <7509BFB6-36E4-441A-9F16-7A4FEE7F7CF3@goldelico.com>
 <5488EF42-08DB-4273-95FF-49ED31E27472@goldelico.com> <CACRpkdb4URKcdZ-=3aG_np86Bp=1ahs+qztM-7yQkSP18ZkE6A@mail.gmail.com>
 <2286C331-4AFC-46A9-B8C4-8A8BA9CD33C2@goldelico.com>
In-Reply-To: <2286C331-4AFC-46A9-B8C4-8A8BA9CD33C2@goldelico.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Apr 2019 11:02:12 +0700
Message-ID: <CACRpkda4k_Vaoo1qEaZ3nv8bA4tcrPEN6oT-v+n9HRdA6=5Xvg@mail.gmail.com>
Subject: Re: [BUG] gpiolib: spi chip select legacy support breaks modern chip
 select and whitens the GTA04 LCD panel
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Kumar Gala <galak@codeaurora.org>,
        Wolfgang Ocker <weo@reccoware.de>
Cc:     Jan Kotas <jank@cadence.com>, LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(CC Kumar and Wolfgang who came up with spi-active-low, I think.)

On Sun, Mar 24, 2019 at 1:56 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
> > Am 24.03.2019 um 05:15 schrieb Linus Walleij <linus.walleij@linaro.org>:

> > But I fixed it in that case by introducing a spi-cs-high into the DTS file:
> > https://marc.info/?l=linux-arm-kernel&m=155292310015309&w=2
>
> Yes, that of course works and is our temporary solution.
>
> And I see that you also have it on the controller node and not the slave node.

Yes I git it wrong, the slave should have it and another bug of mine
made it look at the controller not (some days I should not write
code in paths that do not get executed).

> > I'm sorry about that, however if you look at the DT binding document:
> > Documentation/devicetree/bindings/spi/spi-bus.txt
>
> Shouldn't it be a property of the slave node and not the controller node?

Indeed.

> > You will see that spi-cs-high is mandatory. So these DTS files are
> > incorrect.
>
> How do you read that it is mandatory from
>
> "All slave nodes can contain the following optional properties:
> - spi-cs-high     - Empty property indicating device requires chip select
>                     active high."
>
> I read it as optional and indicative. Equal priority to cs-gpios.

The basic problem is that spi-cs-high is defined negatively,
so by default a CS GPIO is active low. This clashes with the
default GPIO flag, as GPIO_ACTIVE_HIGH is zero, no flag,
and thus the default if nothing is specified, so if the GPIO flag is
zero it should be active high, but if "spi-active-high" is not on the
slave node it should be active low, so one of them have
to win, they can't both win.

I'd say that spi-cs-high existed before we standardized the GPIO
flags in the DT bindings. So people were relying on it for years before
we came up with the ACTIVE_HIGH/LOW flags.

commit f618ebfcbf9616a0fa9a78f5ecb69762f0fa3c59
Author: Wolfgang Ocker <weo@reccoware.de>
Date:   Wed Oct 15 15:00:47 2008 +0200

    of/spi: Support specifying chip select as active high via device tree

    The patch allows to specify that an SPI device needs an active high chip
    select.

    Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

While the GPIO binding turns up 5 years later:

commit 71fab21fee07fd6d5f1a984db387cc5e4596f3fa
Author: Stephen Warren <swarren@nvidia.com>
Date:   Tue Feb 12 17:22:36 2013 -0700

    ARM: dt: add header to define GPIO flags

    Many GPIO device tree bindings use the same flags. Create a header to
    define those.

    Signed-off-by: Stephen Warren <swarren@nvidia.com>
    Acked-by: Rob Herring <rob.herring@calxeda.com>

And then this guy think it is a good idea to standardize this for
all GPIO phandles two years later:

commit 69d301fdd19635a39cb2b78e53fdd625b7a27924
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Thu Sep 24 15:05:45 2015 -0700

    gpio: add DT bindings for existing consumer flags

    It is customary for GPIO controllers to support open drain/collector
    and open source/emitter configurations. Add standard GPIO line flags
    to account for this and augment the documentation to say that these
    are the most generic bindings.

    Several people approached me to add new flags to the lines, and this
    makes sense, but let's first bind up the most common cases before we
    start to add exotic stuff.

    Thanks to H. Nikolaus Schaller for ideas on how to encode single-ended
    wiring such as open drain/source and open collector/emitter.

    Cc: Tony Lindgren <tony@atomide.com>
    Cc: Grygorii Strashko <grygorii.strashko@ti.com>
    Cc: H. Nikolaus Schaller <hns@goldelico.com>
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

> > This does not work because there are devices that requires spi-cs-high to be
> > respected and the DTS second cell GPIO flag to be ignored.
>
> Then, those should be fixed...

This can't be done because some old systems (mostly powerpc)
added between 2008-2013 do not know about GPIO flags and
have DTBs deployed in firmware that need to keep working.
They cannot be fixed.

> > They might have deployed DTB binaries that need to keep working,
>
> Well, that is a weak argument. What if the GTA04 would have the DTB in FLASH
> and would need it working (fortunately we always reflash kernel + dtbs)?

Usually the definition I use for "deployed DTB" is not
"deployed on my desk" but "deployed by a factory" i.e. someone
producing millions of TV sets or something. For example my monitor
is using a PowerPC CPU and has one of these DTBs in flash,
and expect it to keep working if I upgrade the kernel separately.

> BTW, on which node do these invariable DTBs have the spi-cs-high flag?
> In the controller node (IMHO wrong) or the slave node (according to bindings doc)?

Slave node I hope, the controller thing was just one of my stupid
mistakes.

> I have checked with randomly picked imx51-babbage.dts and it has it in the
> slave node (pmic: mc13892@0). It also seems to be an example where different
> CS lines want different settings.

I'm afraid the consumers of the old powerpc DTS files are not even
maintained inside the Linux kernel, as we sometimes assume. Those
were created and dispersed by vendors at a time when it was assumed
it was OK to maintain your DTS files somewhere out there on the
side (some people still hold this opinion, I don't).

> > I think in this case the oldest binding wins.
>
> Ok, it is the question when such deprecated things are really removed.
> There is no clear answer...

I think the DT bindings people would say never. They are deprecated
but they can never stop working. I guess in theory you could try to
figure out when the last piece of equipment using the old binding and
ever wanting a FW update stops working. That seems hard, but I don't
know much about these powerpc systems.

That is the reason why I try to contain these weirdness things inside
gpiolib-of.c rather than out amongst the different subsystems, so I can
have it under control.

> > I think you simply have to patch these GTA04 DTS files to use
> > spi-cs-high.
>
> Ugly... Well, if DTS maintainers accept that?

I suppose.

> What about a CONFIG to explicitly enable/disable this legacy support?
>
> IMHO it will need to be enabled for les than 1% of the kernel builds and
> therefore also keeps the zImage smaller for all others. And avoids DTB
> changes where the gpio flags are already correct.

Dunno about this, it looks fragile, I would prefer to keep all working.
But I will listen to reason.

I have thought about using of_machine_is_compatible("vendor,foo")
in gpiolib-of.h to whitelist some systems that will just use the
new way, or reversely blacklist some old systems that have to use the
old syntax. What do you think about this?

Yours,
Linus Walleij
