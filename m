Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE16C2D0DD
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 18:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B79206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 18:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H0PFzSeq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfLaSo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 13:44:59 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38951 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfLaSo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 13:44:59 -0500
Received: by mail-vs1-f66.google.com with SMTP id y125so12584196vsb.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 10:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d6cLOy9QnNkqPgXa2Ezsb9iiMWSyWe0a3ouJ2T5tkB4=;
        b=H0PFzSeqntD/Hv7LYk3frEd/P6wJB6jbPZyz5Oco/Vlf4sjhQ8DDAYZqcZdO6Z6jCA
         q439TKwr/TdeRFKeyZS+a3hX1F4Y9R00m/mxLSrVkj1ySolbO74AsF4lnjZ44Tejj9Tq
         sRmkdMiv/dvGL4/T88FbgZkI8QjEjbCD6133fhIkLQrwsQXoe05lhj7ppCcEp2OOs/1L
         sj2x3jTX1GmrtJDLVMc9e5cWSIHrX03Q2nA9SRJAX+p5SatDvTbfa2oS90xh4kgQcPZP
         MzI27F8KuICqIOJbLp0Qfvf6TWNiMWH9OFIqr2FNa0Nxs0QxCRxzUXHrDtpmh+jT551/
         m6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6cLOy9QnNkqPgXa2Ezsb9iiMWSyWe0a3ouJ2T5tkB4=;
        b=ChdBxdXlkK4YrHjF8xWPFHv5Ro1iwt/i7+XC2MON4SXfzr+eSKv1IaDJ1xClag7wSS
         50/lwoJQmiLK90iX4jloNYzAR/FKudO4EA6bqvtFuyKLdlxqqgr8sMcGkRV1m291TR0m
         J0qMuG29Urds9qy/DqETOZg7yW5wSeibvijHAQ5b55BjUb1BckbO2dSP9WM4ZgIcp0Bt
         4MZd8E5/BbGWBn4pPbfVdmcEd23j7kKGFsU/c4dqql5LNbq34118E7FR2gkyJZXSs2GO
         MIrBQI9cSIsYiq6UXVpTIqyGyIFCMWYB5u16Rdlq/TVBRI46AXW+bZCA6erh+n3RFMm/
         bYJg==
X-Gm-Message-State: APjAAAWa9lbGJznmOROHDtyDTDecV2t9HN7/9i9QLLrTEBbCmL8P08iM
        WXZfwmv6O0ZfExMRCo4V/rX0H2A56+yluEJ0bepimQ==
X-Google-Smtp-Source: APXvYqwN0cl8CWWyvPT5IA5YDxvXHTq8AEet83oy71NUwKLR2lk3hd+tluQBsno3dTDkR3iYkniKP6IxDCqwxp1taRw=
X-Received: by 2002:a05:6102:375:: with SMTP id f21mr4531364vsa.115.1577817898024;
 Tue, 31 Dec 2019 10:44:58 -0800 (PST)
MIME-Version: 1.0
References: <20191107224254.15712-1-robh@kernel.org>
In-Reply-To: <20191107224254.15712-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 31 Dec 2019 19:44:46 +0100
Message-ID: <CACRpkdY0ex_svj97Ri=HjGFqv55n6nk9kgd-J-44X_HUvMri2w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: Convert generic pin mux and config
 properties to schema
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hm it appears the following reply was stuck (no SMTP response or something):

On Thu, Nov 7, 2019 at 11:42 PM Rob Herring <robh@kernel.org> wrote:

> As pinctrl bindings have a flexible structure and no standard child node
> naming convention, creating a single pinctrl schema doesn't work. Instead,
> create schemas for the pin mux and config nodes which device pinctrl schema
> can reference.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Patch applied. I am a big fan of schemas.

I still feel like swimming in deep waters sometimes when using it
and like I "fake it til I make it", I suppose one day I will grok the
inner transcendental meaning of this notation. Maybe.

> We're starting to see pinctrl schema doing their own definitions for
> generic properties, so we need to get something in place to reference.

ACK.

> Maybe this could be combined into a single schema? Spliting it was
> easier in order to just copy over the existing documentation.

We can surely do that later.

> Reading thru pinctrl-bindings.txt, I'm wondering if some of it is out
> of date. Do we let new bindings not use the generic muxing properties?
> Do we really need to be so flexible for child node structure?

The bindings are quite flexible because we simply could not agree
on a single semantic. Initially AT91, i.MX and pinctrl-single used the
strategy of just storing u32's in the tree to be poked into registers
to set up a certain muxing rather than strings to identify groups and
functions.

I tried to push and define the generic string-based muxing of functions
with groups and also using strings for pin configuration.

The downside of this approach is that pins need to be bundled into
groups based on use case. This is not perfect: sometimes we get
the wrong groups because all use cases can not be predicted when
writing a driver. A typical example would be that a UART group
would be four pins  [RX TX CTS RTS]. Late the author realized
that systems actually want two groups [RX TX] [CTS RTS] so they
can punt out the [CTS RTS] group and reuse that for e.g. GPIO
when only RX and TX is in use.

At some point I was pretty heavily pushed by
some contributors who thought the idea to define groups
for all use cases was vain and wanted to use enumed numerals to define
all their settings on a per-pin basis and who felt the generic
muxing (and generic config) was inappropriate for their use cases.

This goes especially for STM32 and Rockchip IIRC but I could be
wrong. TI followed this pattern with the k3 and dra drivers.

This was something like 50% of the pin control community at the
time, not a vocal minority but a vocal 50%.

So I caved in and merged them. I could not really stand in the way
for this vital piece of infrastructure as it essentially stops the systems
from even booting a mainline kernel. I assumed it was the lesser
evil.

The fact of the day is that a significant portion of the pin control
authors like the magic numbers from defined in <dt-bindings/pinctrl/*.h>
files (sometimes corresponding to register values) and the case
is rather lost: these will be around and there will likely also be
more of them.

I personally prefer the string based configuration (functions muxed
to groups and abstract standard strings for configs) as the higher
abstraction gives a better fit with the ambitions of the device tree.

But it is not like the per-pin and magic numbers lack merit.

Yours,
Linus Walleij
