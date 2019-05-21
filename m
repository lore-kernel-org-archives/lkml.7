Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8930C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 03:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B98721479
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 03:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Tip/FqOi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfEUDtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 23:49:06 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:34287 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfEUDtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 23:49:06 -0400
Received: by mail-vk1-f194.google.com with SMTP id d7so4455744vkf.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 20:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1VJfytKtR9301TV4yIigfBHhzzdmP/kCJaWly5NeECw=;
        b=Tip/FqOiERotBvWP2/5JdfK5MKgkhbOetw5IpnGG6GB1rCsnDF4eLROn4GeoYTMCSg
         dEugoOTBsKD2q3zQZ3GPRZMxCRNPWm7AA811r/wN7dy3L+ZGu04kVRLLfu3zStBqr+EV
         HSiqCWR2bmAQpBSUDlTc/RiYF+ctH2wm1aFsi5c3JJ5XrpNTgyjQHbYDOF9r6Va9z6YM
         N94YjJOiv2urqeIs7ORU0FStujqPeKkLb/QcVTJZgoPj7Z4I8GExrb25Ba0XaA1A0KiE
         uztqjl3nwthDFJ0BseEzxoCQ7073q0I1Mi7pPu3O6lAb5EdhVPGK+jC/nitcmkHtsqdr
         j2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1VJfytKtR9301TV4yIigfBHhzzdmP/kCJaWly5NeECw=;
        b=fIwKrqjqw5b7E7nv4I8GqEmJrLyFeq0zPw0tOnCg8mXKvnukpNQcxh54kmvjNlAp1j
         Sb9DfuWrk6CwozpFMy1v7ljeyoncGjsc2ZCZmQZoekw5AnbjbzI5FJ1day09DXl7d/hg
         sU5OPARgrItVV3CVAbEhauzsD1u1WwWaRKbg8ZwIvdPd3qr/AxqSYdtpstcP4eXGZkfY
         ekQ0c/QCWPq8vwg7dYRRdtvpZEBIDctSb2EgPJJu6eIF3TRnnB8ZX3eP4oDsI9mQEG/5
         pR78ltm7qzzUNGxLheMrlcN8vYyQSe1yrDxn2ilKKk/a6JZVaBlXaGF09kw19CMXuivm
         czNw==
X-Gm-Message-State: APjAAAWGarNdLZc49d1Syj83UOoyfJxzSlaPRrQ0j/v3qct/JCTvJHFi
        QVVPeUn2yH7/+4g8NvVfgRe6ojn0KKYEfxrgEGYOsA==
X-Google-Smtp-Source: APXvYqwQ65FRNGritwePEx9wWUtaVGZcdGrhdKHmI16kPdoGImAc/AQd+++yJLNFjIZklQ1Umq8LWsXocXHX7KpUscE=
X-Received: by 2002:a1f:ae4b:: with SMTP id x72mr9339745vke.10.1558410545214;
 Mon, 20 May 2019 20:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <1558361478-4381-1-git-send-email-sagar.kadam@sifive.com>
 <1558361478-4381-2-git-send-email-sagar.kadam@sifive.com> <CAL_Jsq+6uL+wqi=5cp1X9JdBfmLDzGz5UjwfqKCCESyhsemnhQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+6uL+wqi=5cp1X9JdBfmLDzGz5UjwfqKCCESyhsemnhQ@mail.gmail.com>
From:   Sagar Kadam <sagar.kadam@sifive.com>
Date:   Tue, 21 May 2019 09:18:53 +0530
Message-ID: <CAARK3HkkjOzubSQzHc5aMy8yyZaBwn6AuFJ-yMLdQDK6Vh7vdw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: i2c: extend existing opencore bindings.
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
        peter@korsgaard.com, devicetree@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


On Mon, May 20, 2019 at 8:07 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, May 20, 2019 at 9:12 AM Sagar Shrikant Kadam
> <sagar.kadam@sifive.com> wrote:
> >
> > Add FU540-C000 specific device tree bindings to already
> > available i2-ocores file. This device is available on
> > HiFive Unleashed Rev A00 board. Move interrupt and interrupt
> > parents under optional property list as these can be optional.
> >
> > The FU540-C000 SoC from sifive, has an Opencore's I2C block
> > reimplementation.
> >
> > The DT compatibility string for this IP is present in HDL and available at.
> > https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/i2c/I2C.scala#L73
> >
> > Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> > ---
> >  Documentation/devicetree/bindings/i2c/i2c-ocores.txt | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
> > index 17bef9a..b73960e 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
> > @@ -2,8 +2,11 @@ Device tree configuration for i2c-ocores
> >
> >  Required properties:
> >  - compatible      : "opencores,i2c-ocores" or "aeroflexgaisler,i2cmst"
> > +                    "sifive,fu540-c000-i2c" or "sifive,i2c0".
>
> It's not an OR because both are required. Please reformat to 1 valid
> combination per line.
Yes, will rectify it in V6.

> > +                   for Opencore based I2C IP block reimplemented in
> > +                   FU540-C000 SoC.Please refer sifive-blocks-ip-versioning.txt
> > +                   for additional details.
> >  - reg             : bus address start and address range size of device
> > -- interrupts      : interrupt number
> >  - clocks          : handle to the controller clock; see the note below.
> >                      Mutually exclusive with opencores,ip-clock-frequency
> >  - opencores,ip-clock-frequency: frequency of the controller clock in Hz;
> > @@ -12,6 +15,8 @@ Required properties:
> >  - #size-cells     : should be <0>
> >
> >  Optional properties:
> > +- interrupt-parent: handle to interrupt controller.
>
> Drop this. interrupt-parent is implied.
>
Sure, will exclude it in v6.

> > +- interrupts      : interrupt number.
> >  - clock-frequency : frequency of bus clock in Hz; see the note below.
> >                      Defaults to 100 KHz when the property is not specified
> >  - reg-shift       : device register offsets are shifted by this value
> > --
> > 1.9.1
> >
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Thanks,
Sagar
