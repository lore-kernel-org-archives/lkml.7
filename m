Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CEFC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85DE214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CYTDu33S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbfLLOgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:36:48 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37360 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729796AbfLLOgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:36:36 -0500
Received: by mail-lj1-f193.google.com with SMTP id u17so2557187lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 06:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFBaysu79yDikUBKmCJOSK+/KcLNsfSxo1Kg6RMTYzo=;
        b=CYTDu33S/uRKGhVT7parvwID0Z4EEkvon8ISEhgQg581I+1vygWkVRJfIX6VyR90IP
         5s90on/IBWtzNCkfiPg7uk+yBQZZgeRl/SRSDr7c+w33usVVyP+MJiAG1YhQEWLjO/Lm
         P/0CD0GARye2OYMRl25h1tC04+CXoKFn2YTnfaKWCVyq0RUQtJskTe7aNXDDUW4mR74/
         t7GoesEcr1oPDRiIJXWl4xt+DmU6FKcdogFEPM7GJ0MbM1/bRU5TyZ/4OU2CRtiJtNg9
         8b733kTi7YVBHa42ZnE/qE1MABlz/YuyRm0mRdXrwoA54K3MFcLxF9VgrBgIm71NLVT5
         m2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFBaysu79yDikUBKmCJOSK+/KcLNsfSxo1Kg6RMTYzo=;
        b=edJBkQf1YRwEF5M4uJWASEhDAoq/7CTZ3HnvJh6U1iEK22INhqYFVa03iPjsrLuTtZ
         BtReFC0PUdj5mU+R+Q6O/EDy0dHwmYyWZL8tB1pLNrG9vNAjmr2QNGxemixam7qZ+0GT
         pBRquvrMIHVYgKyYtcuRKAviruCRKqeXo0krPxcnRHZIfP075OKZnxRR7nzMwnhQI/c+
         KTv1NDbEPKIIBMFWmWxCnkF1spieHDyqkKZy2+e8RF+llbtahgVyI53a16IBQTSDGdZh
         zBAyJZN7HVJx/YDg3whT/RBIjjsBx4fLRiNSO4yUtXxJDagh6SFiHWz+/LF0Bk6vyVu1
         ZWXw==
X-Gm-Message-State: APjAAAWacIYGOrPRCV6FW3PZ5DP2S+h3+ykx4ris9OUWNesbbo1Re3VA
        1FWKH1BgbLkVK7WJcP+h1QjhRoA4UrdN3ykmqXwGFA==
X-Google-Smtp-Source: APXvYqz/zPYVnRmIpLFYccngv9dixRG8YUx2SGeQvmu/20Gvhakgo9h/gmYehDYbcCI+QIDTfrgweSqbzBJTINCecCM=
X-Received: by 2002:a2e:844e:: with SMTP id u14mr6119798ljh.183.1576161394471;
 Thu, 12 Dec 2019 06:36:34 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-3-geert+renesas@glider.be> <CACRpkdYyY0eGipdK6ixZxLtdJ5px=U2mOa79VZb00NEEAEL=6g@mail.gmail.com>
 <CAMuHMdVL2w=DzOHTh-Tq6NZLTNUKxUneMi3wX71Z83mdsy3LTA@mail.gmail.com>
In-Reply-To: <CAMuHMdVL2w=DzOHTh-Tq6NZLTNUKxUneMi3wX71Z83mdsy3LTA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Dec 2019 15:36:22 +0100
Message-ID: <CACRpkdZ0geBk4oBkjb3w9kep-jWMUdpegngspN0yhKRaNY0ZKQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] gpiolib: Add support for gpiochipN-based table lookup
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harish Jenny K N <harish_kandiga@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Alexander Graf <graf@amazon.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Phil Reid <preid@electromag.com.au>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 2:33 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Dec 12, 2019 at 2:20 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Wed, Nov 27, 2019 at 9:43 AM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > > Currently GPIO controllers can only be referred to by label in GPIO
> > > lookup tables.
> > >
> > > Add support for looking them up by "gpiochipN" name, with "N" either the
> > > corresponding GPIO device's ID number, or the GPIO controller's first
> > > GPIO number.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > What the commit message is missing is a rationale, why is this needed?
>
> Right. To be added: so they can be looked up in the GPIO lookup table
> using either the chip's label, or the "gpiochipN" name.

After reading the aggregator/forwarder driver I am not convinced
that this is needed at all and I think this patch can be dropped,
but check my review and see what you think!

Thanks,
Linus Walleij
