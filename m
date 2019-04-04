Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61658C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247EB2133D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YfPok6IO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfDDDlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:41:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40396 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDDDlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:41:18 -0400
Received: by mail-lj1-f193.google.com with SMTP id q66so735299ljq.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1n3vNyf2Cpl+mI4a9w2n20PNikLsfrphaPgu96srNGI=;
        b=YfPok6IO8vKE7hBaL71PCRaGkCdMagS7QR2HypB6bqjTMLbGbXxs8V0p6VvgYogGLM
         nOBuBEYbEMW+50hO3gog9keaK1s+oz2Z4RmUOn21ajca+Ssrqe5QL1w0skk/Bzoh55ia
         Y/VKKRb+CPVtFLrLlInFm6X9mvTL0cwfewk02uDwnjLO/D9GBUE6g4Z7OfWkPIlrNjI6
         pHtcDDNWQjNan+XGuFvtGDf9J+iofDu9O2KtR2xW32ByOuc2nmltR4n0GnXbeGiFtcmv
         5fRAUaKKG0cTArcF9nR2pRbjH8rfRn1nQyVDbHj9PUuV6QZgn073JSXjLC0EJKNdkG9b
         mOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1n3vNyf2Cpl+mI4a9w2n20PNikLsfrphaPgu96srNGI=;
        b=JKUgBwHT5DHqUhi807DFvg9/f807tIV0K6s3bOYHwcMbcof0hFaKmB7vyhJW9MoNnz
         W7tRrzGBkq2H2WIhfvyz/icb+16sT8vhYiVKgE5/zzKrqpBmeaxe5fcTO7vJL06wdnVI
         Ybr+LIKIUDjuusBhSbofHZch8XqKuNS5WPAh4N71g5ieg2+2bbb2yzScPezw8I3LP4y3
         u3gQnEd7FoB+PENeJ3CXDZUn1aH7k4Or7/2OBpx7lj4AbZTzaXS/V3VjhRWtzBUUTIB/
         oon3LyUyHtOyh98ynTKvvhoYCvBFcY9jsDEsxcHcLen7Y7L4lJBWknD3NWILO4pzlNZu
         Xx2w==
X-Gm-Message-State: APjAAAXOL/A7I81zQOX7Y7hx+mMibB69xz7psgLvVm14jOkf3kAtswMx
        vw6E/rjRGJRn0QWkL327AzVOP8b3KKX8bXHeUkBDgQ==
X-Google-Smtp-Source: APXvYqwq6cI/I6as+O2M5gIyEEVWrjmp5qU7fGuvVIEo6BxhMR39ALKTiLBEMv59FXhB5GSdUDq24O2JVfsCMiPRMcU=
X-Received: by 2002:a2e:9d12:: with SMTP id t18mr1778098lji.163.1554349276108;
 Wed, 03 Apr 2019 20:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190314163725.7918-1-jbrunet@baylibre.com>
In-Reply-To: <20190314163725.7918-1-jbrunet@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Apr 2019 10:41:04 +0700
Message-ID: <CACRpkdYdRfm=OLmfzZeJEXpfOdnxg=YE+yAexHTh_-EePBtxaA@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: meson: add g12a drive strength support
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Guillaume La Roque <glaroque@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 11:37 PM Jerome Brunet <jbrunet@baylibre.com> wrote:

> Now the slightly annoying part :(
> The value achievable by the SoC are 0.5mA, 2.5mA, 3mA and 4mA and the DT property
> 'drive-strength' is expressed in mA.
>
> 1) Rounding down the value, we could be requesting a 0mA drive strength.
>    That would look weird.
> 2) Rounding up, we can't distinguish between 2.5mA and 3mA
>
> To solve this issue in this in this v1, we chose to document that, on Amlogic,
> drive-strength is expressed in uA instead of mA.
> It works well and there is no impact on the other platforms but I'm not sure this
> is really OK with the DT rules ?

I want the DT people to say what they think about this.

> Linus, if this is not OK with you, here are 2 other options we are
> considering. We would be very interested to get your opinion on the matter:
>
> 1) instead the generic 'drive-strength' property, we could add an amlogic
> specific property, 'amlogic,drive-strength'. It would be expressed in uA
> and parsed in amlogic specific code.
> I think this option is kind of overkill. Expressing drive strength in uA is
> not really amlogic specific so it does not make much sense, but it would
> work ...
>
> 2) Add another generic property "drive-strength-uA". The change to do so
> would be minimal and could be benefit to other platforms later on.

I would go for 2).

But we really need input from bindings people on this.

Yours,
Linus Walleij
