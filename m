Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084EDC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C179721925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VESCX9ht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfKLXIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 18:08:41 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36601 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfKLXIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:08:41 -0500
Received: by mail-lf1-f65.google.com with SMTP id m6so272697lfl.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 15:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7iPt2rUGE9oXmWDbb5Mzz6gCglZjGlXKjc0N0FJgr8A=;
        b=VESCX9htKvXucVZ4uo677xnET43HPTrwRFinSr8yYsMOyID8DcMqxCyKdPfxBIKlb7
         1FZGC7CUFwXqoKPSGosA0OCK3m+7a8id42mHZfZCG51/sH5qEVabfMz2KW6cJ0bDkMB/
         9GQrgcE2+69wCQaJCwZ3MoHkk3BbUsPFax1V4MGIukmfzenMuI/4mr+/f2gAspA/Eb9Q
         EjCGrKPzL/RJDjofUtzwVXv7eIGv+u+fCVT/0V04C09DEcSxDB828noJ5H2t4RR1angQ
         7Y85E5Grg3PMytFxORplnBRYtI4rh79JwWTcJGS32GOEiCxsS8wiygdy5vzdg6iykA3Y
         ooWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7iPt2rUGE9oXmWDbb5Mzz6gCglZjGlXKjc0N0FJgr8A=;
        b=WCbq+JI2FHWKChntMtw7eXQ+BBNkzt3jx9O0KMobiubfOOyr/b5F/4+pg7+jmLFHbp
         x6XdxL7g7LdrQaexdDuKqxULTeL9I7PtD9m3KYnbRtR2PDodpUF7jHZgFNBmRSR2Nzvr
         p9o7cPe0mI38qvM+pmztCiKZUDXTqfyqZPABBtn42AG5D+a9TAtTrWaVtt9ZLUXaS9cN
         HMEIgNNYMpFeeKZaQIOgHJbAlvyH3H1fM+oOljczXHeOvI6SJPqEtySUjsgECcfyAFKQ
         s7Arzm1UlaElfY2TA6Pultj/SUpogyildEWKQV6c159DHNo++uCJN9WdFJGlF9LWJDeR
         5uUA==
X-Gm-Message-State: APjAAAVfVJLmcl2mq7Coo5YrGvowgf/e2aK/AVNc0+fNcpLyWURg2UPH
        a/XfBPN/v5NkW6njMh4DpEUNVkZFItu8Tb8ZBsnChQ==
X-Google-Smtp-Source: APXvYqwwn5KlBJ/5YzKW7ZDtv0CalFfKJ2BTyT/0LuFHJqo6GSPerg2cMm+VJjA8unR9awvojWdi/k03Yd2vXSgkp7M=
X-Received: by 2002:ac2:51dd:: with SMTP id u29mr225596lfm.135.1573600117684;
 Tue, 12 Nov 2019 15:08:37 -0800 (PST)
MIME-Version: 1.0
References: <20191105055015.23656-1-erosca@de.adit-jv.com> <CACRpkdbO6df3OKn4wnz9LMjf4i94jQPs9n_Cdzv7boWMZDCovA@mail.gmail.com>
 <20191111222502.GA717@vmlxhi-102.adit-jv.com>
In-Reply-To: <20191111222502.GA717@vmlxhi-102.adit-jv.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Nov 2019 00:08:25 +0100
Message-ID: <CACRpkdY=n6gofV-N7_HFVtn=CYO4xDnXabEYySLrkgW=78XWLQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add 'fixed-emmc-driver-type-hs{200,400}'
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Mathieu Malaterre <malat@debian.org>,
        Pavel Machek <pavel@ucw.cz>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugeniu,

On Mon, Nov 11, 2019 at 11:25 PM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:

> This matches my view with below amendments:
>  - Your passage seems to describe a single-duplex communication (one end
>    is always a sender and the other one is always a receiver). Since the
>    CMD and DAT[0-7] eMMC lines are bidirectional (carrying half-duplex
>    data transfers), this is what seems to justify the
>    "drive(r) strength/type" feature/setting to be present on both host
>    controller and eMMC device ends (which does happen in real life).
>  - I am unsure whether to endorse the "totempole output" as being the
>    usual foundation for how "drive strength" is really implemented in
>    the modern CMOS ICs, based on the following:
>    - All eMMC Jedec specs mention "push-pull" for CMD/DAT[0-7]
>    - All eMMC device datasheets I could find reference "push pull"
>      and none mentions "totem pole" for CMD/DAT[0-7]
>    - The "totem pole" topology seems to originate from and be much more
>      popular in the TTL/BJT world, where it tries to harness the
>      symmetry of two NPN transistors, replacing the PNP-NPN pair used
>      in the bipolar "push-pull" configuration [1-2].
>    - Jedec calls totem-pole "a bipolar output" (i.e. TTL/BJT) [3]
>    - Jedec claims [3] that "vanilla" tottempole doesn't support
>      tristate/hi-Z outputs, making it impossible to connect several such
>      circuits in parallel, while we assume the latter to be a hard
>      prerequisite for sourcing programmable amounts of current.
>    - Some users say that "CMOS outputs are generally push-pull" [4]
>    - TI states [5] that the "MOSFET equivalent of the bipolar totempole
>      driver [..] is rarely implemented"
>
> Abstracting from the above, I agree that a programmable "drive strength"
> is likely achieved by connecting several tristate-capable output
> circuits in a "wired OR", as exemplified for Raspberry Pi in [6].

OK that's established. I am sorry for using the TTL "totempole"
term here, it is out of place for CMOS indeed.

Very nice detailing and references, I read them all :)

> > Usually selection of drive strength is done with the pin control
> > framework, so this would need to be backed by code (not in this
> > patch set) that select pin control states that reconfigure the
> > SoC pad drivers to use the requested strength.
>
> That's true. In the same context of overcoming HS400 issues, our SoC
> vendor suggested adjusting the "drive-strength" binding, added in:
>  - 7db9af4b6e41be ("pinctrl: add function to parse generic pinconfig
>    properties from a dt node")
>  - 3caa7d8c3f03ad ("pinctrl: sh-pfc: Add drive strength support")

OK so the pin controller will act as back-end for this and the
drivers are expected to use that.

I suppose you are defining new HSxxx-specific pin control
states for them? I suppose it would be good to see how it
works end-to-end. (But fine, I get it so far.)

> > Alternatively, the (e)MMC block would implement this control
> > directly, but I doubt it.
>
> There _is_ a "drive strength" specific to eMMC device and the
> justification for it to exist has been made above.
>
> According to JESD84-B50.1 spec, the host controller is able to find
> the "drive strength" values supported by a particular eMMC device by
> reading the DRIVER_STRENGTH field of the Extended CSD. The host then
> may (if needed), make use of this value to set the "Driver Strength"
> parameter in the HS_TIMING field of the Extended CSD register.

So the operating system reads the ext CSD and uses that
information to set the drive strength using pin control in the
Linux case.

What is the unit of this driver strength field in the ext CSD?

And consequently this:

+  fixed-emmc-driver-type-hs200:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 4
+    description:
+      Same as "fixed-emmc-driver-type", but specific to HS200 mode.
+      If defined, overrides "fixed-emmc-driver-type" in HS200 mode.

This thing that is 0,1,2,3,4, what unit is that?

If we established it is the number of push-pull stages OR:ed
together we should document it. Since it is supposed to be
used with different host controllers, it certainly cannot be
unitless or "vendor specific" since you have two sides to
it, the card ext CSD and this, and then the pin controller
side. (I'm not a standards person buy certainly JEDEC
must have thought of that?)

> Essentially, current series gives the host controller a chance to limit
> the drive strength value written to HS_TIMING, if eMMC vendor decides
> that some of the values advertised in DRIVER_STRENGTH are forbidden
> or should be avoided in a specific bus speed mode (HS200/HS400).

OK this text should really be in the commit message and the
bindings because this isn't clear from context.

It confused me so it will confuse others.

I still don't quite get it, sorry if I'm dumb :/

Do you mean that the eMMC advertise some drive strengths in
the ext CSD and the device tree properties are there to mitigate
or override these and disallow them because of limitations in the
host controller or associated electronics? That sounds more
like something the system integrator/manufacturer decide than
the eMMC vendor.

Or it it a bug in the ext CSD so that the eMMC advertise strengths
it shouldn't? Then we should use a quirk for the card ID
rather than a DT property.

> As explained above, this series allows to customize the eMMC-specific
> drive strength. The eMMC vendor did not ask to make the SoC-side
> drive strength dependent on bus speed mode and that was not needed in
> the testing performed by the customer.

I think I understand this now! Some nice details above
makes it clear what these values are for.

> > So to me it seems these DT properties are just introduced to
> > hammer down a certain usecase instead of letting the code with the
> > help of DT speed capabilities flags determine what speed is to be used
> > and select the appropriate drive strength.
>
> Does this mean that the "fixed-emmc-driver-type" binding which
> pre-exists my series falls under the same sentence? Or is this only
> when customizing Wolfram's binding to HS200/HS400 bus speed mode?

Now that it's clear that this is to restrict the drive strengths
used I understand it better!

> Note that there is no other objective in this series but to allow Linux
> to run on hardware which doesn't strictly follow its specification [7].
> If you have any alternative ideas of how to follow the eMMC vendor's
> recommendation quoted in the description of this patch, I will happily
> review those.

I'm a bit confused. This "recommendation" sounds like some
errata actually.

If the case is that eMMC vendor has recommended certain stuff
in the ext CSD and you need to augment that with the device tree
config, that sounds like the wrong approach. It is a bug in that
eMMCs ext CSD is it not?

Why can't we use code for this and just add a per-card quirk
instead if there are errors in the drive strengths recommended
in the ext CSD? Like the other stuff in drivers/mmc/core/quirks.h.

That makes the same card work on any other host without any
device tree special properties, hopefully.

Yours,
Linus Walleij
