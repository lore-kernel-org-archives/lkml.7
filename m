Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66956C2D0C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE7D205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zrhJ0jrk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbfLLKhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:37:51 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42201 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfLLKhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:37:50 -0500
Received: by mail-lj1-f195.google.com with SMTP id e28so1685923ljo.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 02:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5SqIcgl9aAE6TWcTOYOiDMyzk/mR4NkfrL+RLRJKD3A=;
        b=zrhJ0jrk8v5e2O4535/tOC22kazrIMievOQeaiWJ+BlR4UVjsChlFbVD0HUP/xerlF
         3wBn6gl7CtLZNMLO+hWHrUxx7TlUMy+HaBVNYdFSjUevwA+HgtpDaR/FfWiBn+H3/er1
         Ir1JZ0uUzRwlVBp6+6TflpQV+NyONx/CUx6PfVtw8pha+1yrolweS7xYIjv4DlMP0k1P
         XOhV11uS5VZMIYGGOzwg0tu3/fO6zs+rszwaXK1aYekYsMbWaPyrGtTq3LYaH/mvE5iQ
         s9UeDa5n1umu6QM/E8cUVmJXwoUnqEmMp8bLHfDq9VdNK4nvCsZsWa5Hwgkt0RCw1ijh
         DpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5SqIcgl9aAE6TWcTOYOiDMyzk/mR4NkfrL+RLRJKD3A=;
        b=ZvSXvm/ZalVh5ssnnAYLcLyoh0Sm/l2uQEM3FqkSpzcjngOaQlxRibH+Hxq4w75Btn
         A4y5zl6HXWZNfmO9FxMZcOIZRGnPct0AsUVY7oW1b2u0/RXDK6Qg2HeXbgNQTVxFzyIc
         G/58bjj0uM5VvjP3KV4aJfL78ZxUdBTvj/4JuyZFkefJA5xNK1dkZpMsiEm0wDZcinFa
         hoNK0T7EtXzIhrsr4XirrMpqyHLpFiYMtMgDMpP1WK3RwlbLkti1NcuceXQdIDe7v+zS
         BJfC1xR7fo9P9ougAXotFUbHbLMgeVWKQR4Ebx6eA+nJZlSMtpr8zwbsjmiy/RNITlAq
         HZOw==
X-Gm-Message-State: APjAAAVqpO/mW9iWzHyDOxUX04CEeaOjy5Ea8BDQp3nf2LSrRRGo0Edv
        BwcRidUt+PAZu1y0jSE06NnZYK0RtGaQOoN83EVj0g==
X-Google-Smtp-Source: APXvYqxXDWfApEe5saT3On7j10fORvpRuprInc2tRlPoCQ/N7PszanwFYUgT0kGoFWH15AGjzElKuVlkyQcfwIG8L6U=
X-Received: by 2002:a2e:844e:: with SMTP id u14mr5366826ljh.183.1576147068543;
 Thu, 12 Dec 2019 02:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be> <20191127084253.16356-2-geert+renesas@glider.be>
In-Reply-To: <20191127084253.16356-2-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Dec 2019 11:37:37 +0100
Message-ID: <CACRpkdY18k7EXb_oMAYXM44jz4Oc+AtcNWZfStPBZ4K1TnZ6mw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] gpiolib: Add GPIOCHIP_NAME definition
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
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

On Wed, Nov 27, 2019 at 9:43 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The string literal "gpiochip" is used in several places.
> Add a definition for it, and use it everywhere, to make sure everything
> stays in sync.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - New.

This is a good patch on its own merits so I have applied
this with the ACKs. (Haven't looked at the rest yet...)

Yours,
Linus Walleij
