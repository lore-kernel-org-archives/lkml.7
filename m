Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F191EC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8513218AE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e1rffzcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387857AbfKGJJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:09:53 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42160 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbfKGJJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:09:52 -0500
Received: by mail-lf1-f66.google.com with SMTP id z12so982170lfj.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 01:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AqA01GmNXxOIqmKayDqMHICE140SmncdgO3v076ZB7M=;
        b=e1rffzcB/YxOOOMnwqrZJesi/tvKRrsHLKDm7hBclx75Uy4vnec54LTKDCDmeGbxLX
         ywJtFeBABHA2JWtFfXuhIA9T6KoJLckldeSEgkzM41VFxRhmu5dFjDJeO/qdXvwz70bM
         xTG46dhWbhTkRBTnJYoYMt28eGJfDJKh9g6gUOX9VOuydasSdGVlhbdFstZqqEtihxeK
         g2GbliMhnxmK+23pDp5kaNzH3+35Wu2lzqresRNH8I4E4Rea6WeU4rcLDWjAt6E5WA9t
         ilO2/9YI/XjQkBVrJvI+6DEyjGMETc6hnU0RgK1PjZIE/2rdbL1mhuXTb+kWtBIHDXqd
         zmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AqA01GmNXxOIqmKayDqMHICE140SmncdgO3v076ZB7M=;
        b=F/gxBKfY0vaVBeolI14zTjQcKOkv10ymWJnQcNEi2AUN7tTb/CL+JTgpG1O1hRBtlB
         v5o42Syj6pu1TAR/9ct6b67DXZpRHxAibawLgwhLDvgOntxuN8utI9dtbv1k9Tzfk46L
         skS54F1Y3bvSR1X5u2jJp04F/11a4S74MJtDMyAZ7+A13iw7cWGPlFeT2kLDV5b8fG+d
         kMVBCPm9QsjYPVrPm0Mw/znN9uk/rrREdC5GFswAsSRywAIw1hsVurfYiiOU6z+Ox+m3
         HKQFoeePKMLBkZXZa+DUG0V2waCDozHWFlK5LzCHRXTg18rN/ATzlFpRJJ5SZ/9CK6pq
         turA==
X-Gm-Message-State: APjAAAXXk0bJGybdODKCrM5Av+pKJ0ZpYma4aL1Bl2sw7nDpDd1/dSAi
        HzomUAhIsIVR1C6g8bYSSDt4kAiQNHTYUhRb0kr9Kw==
X-Google-Smtp-Source: APXvYqxPdpHoDKQ+cbGzqAEy6IBEIt8P+sfO6dFt7eB3y8XbNYOaax86566DZUKRxXfZrrORDwfC5tpAMymbTbgGp38=
X-Received: by 2002:ac2:51dd:: with SMTP id u29mr1587920lfm.135.1573117790204;
 Thu, 07 Nov 2019 01:09:50 -0800 (PST)
MIME-Version: 1.0
References: <20191104100908.10880-1-amelie.delaunay@st.com>
 <CACRpkdb1c-NHXDQXYS78VTcGPnJApmxjzZbF_cM8SUknhDiQ4Q@mail.gmail.com> <64f8096f-cec6-fef1-5a4e-ddca3bf8c73d@st.com>
In-Reply-To: <64f8096f-cec6-fef1-5a4e-ddca3bf8c73d@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Nov 2019 10:09:38 +0100
Message-ID: <CACRpkdbK=aB84hW0FtuMBtzqi3ftKBxedXEpqmnJhbN_vJWx2Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] pinctrl: stmfx: fix valid_mask init sequence
To:     Amelie DELAUNAY <amelie.delaunay@st.com>
Cc:     Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 4:14 PM Amelie DELAUNAY <amelie.delaunay@st.com> wrote:
> On 11/5/19 3:32 PM, Linus Walleij wrote:
> > On Mon, Nov 4, 2019 at 11:09 AM Amelie Delaunay <amelie.delaunay@st.com>
> > wrote:
> >
> >> With stmfx_pinctrl_gpio_init_valid_mask callback, gpio_valid_mask was used
> >> to initialize gpiochip valid_mask for gpiolib. But gpio_valid_mask was not
> >> yet initialized. gpio_valid_mask required gpio-ranges to be registered,
> >> this is the case after gpiochip_add_data call. But init_valid_mask
> >> callback is also called under gpiochip_add_data. gpio_valid_mask
> >> initialization cannot be moved before gpiochip_add_data because
> >> gpio-ranges are not registered.
> >
> > Sorry but this doesn't add up, look at this call graph:
> >
> > gpiochip_add_data()
> >    gpiochip_add_data_with_key()
> >      gpiochip_alloc_valid_mask()
> >      of_gpiochip_add()
> >      of_gpiochip_add_pin_range()
> >      gpiochip_init_valid_mask()
> >
> > So the .initi_valid_mask() is clearly called *after*
> > of_gpiochip_add_pin_range() so this cannot be the real reason,
> > provided that the ranges come from the device tree. AFAICT that
> > is the case with the stmfx.
> >
> > Can you check and see if the problem is something else?
> >
>
> stmfx_pinctrl_gpio_init_valid_mask uses pctl->gpio_valid_mask to
> initialize gpiochip valid_mask.
>
> pctl->gpio_valid_mask is initialized in
> stmfx_pinctrl_gpio_function_enable depending on gpio ranges.
>
> stmfx_pinctrl_gpio_function_enable is called after gpiochip_add_data
> because it requires gpio ranges to be registered.
>
> So, in stmfx driver the call graph is
>
> stmfx_pinctrl_probe
>    gpiochip_add_data()
>      gpiochip_add_data_with_key()
>        gpiochip_alloc_valid_mask()
>        of_gpiochip_add()
>        of_gpiochip_add_pin_range()
>        gpiochip_init_valid_mask()
>          stmfx_pinctrl_gpio_init_valid_mask (but pctl->gpio_valid_mask
> is not yet initialized so gpiochip valid_mask is wrong)
>    stmfx_pinctrl_gpio_function_enable (pctl->gpio_valid_mask is going to
> be initialized thanks to gpio ranges)
>
> When consumer tries to take a pin (it is the case for the joystick on
> stm32mp157c-ev1), it gets the following issue:
> [    3.347391] irq: :soc:i2c@40013000:stmfx@42:stmfx-pin-controller
> didn't like hwirq-0x0 to VIRQ92 mapping (rc=-6)
> [    3.356418] irq: :soc:i2c@40013000:stmfx@42:stmfx-pin-controller
> didn't like hwirq-0x1 to VIRQ92 mapping (rc=-6)
> [    3.366512] irq: :soc:i2c@40013000:stmfx@42:stmfx-pin-controller
> didn't like hwirq-0x2 to VIRQ92 mapping (rc=-6)
> [    3.376671] irq: :soc:i2c@40013000:stmfx@42:stmfx-pin-controller
> didn't like hwirq-0x3 to VIRQ92 mapping (rc=-6)
> [    3.387169] irq: :soc:i2c@40013000:stmfx@42:stmfx-pin-controller
> didn't like hwirq-0x4 to VIRQ92 mapping (rc=-6)
> [    3.397065] gpio-keys joystick: Found button without gpio or irq
> [    3.403041] gpio-keys: probe of joystick failed with error -22
>
> I can reword the commit message to make it clearer.

No need I understand it now, thanks for explaining!

We need to populate the valid mask some other way if you
want to safeguard this, I don't know if the existing
gpio-reserved-ranges would work? But it feels a bit unsafe
if you actually determine this some other way.

Yours,
Linus Walleij
