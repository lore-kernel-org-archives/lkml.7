Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A14FFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5D32067B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tsZg08CY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388759AbfJPMF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:05:28 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42406 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfJPMF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:05:27 -0400
Received: by mail-lf1-f66.google.com with SMTP id c195so17255620lfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 05:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1lgzvy+YBsjp8TqyBMT1f57Vy5UY6TJqL/3/rtY6CCA=;
        b=tsZg08CYSu9U7QMMHAV/L/3H4qD8TVH1FP0EVjQ2VibIOBTO/NhQ6vAUOFp+GBgG5U
         NFzDX98f6laZrG6QuCJtGv9Px7J6uIJRw5O8sxuoehgEIdNnQbKDEjcqkce39nr0r/aQ
         OM7nEKT/ZjS1p8UpjKK4QkfrUAmOgrKoSWZW/dLJXux/OHn6SRe6wHPAK0X+vawesW5z
         jjl/7AI6fKYVlR2XCKW/2R9xY04XbWNIMWPG31Cqh8M7C6/At72hqtJJLvItrB4wtHBz
         pD9B8dQg1pA8wXveuGCMk9G0cR6D3fDVznRLtQ4bFYwgHCVT8WaHnvVuhoAa5Xc+aDcY
         Zsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1lgzvy+YBsjp8TqyBMT1f57Vy5UY6TJqL/3/rtY6CCA=;
        b=m0Xtg4+MdxE7eb8uwi2bp6YGS/3tYGU1DdfxWDcQEM4d113TcFPmmhj43baOX3s8cM
         3B0HW6VllJZPNo9mazR9NsFCBj0fBFNH1V1pXRdQcolaI5RRf1YuCfAQBk31pyc8+Epw
         NKwMwmwlEzHqcpWCp3wqCAxoXFeK9QLCivAP8jddweQLFVouWhITi/K6JOT1p0TmUGoy
         EtCiZAI3InEJ86D2qkyBvaxeuVXHP/HtugR+xmqzl5jJE5iFh/ZjkXBAwWb4PVpz2KRK
         r/7GTChQl1wZrskhAmHQ2Klzt7/cHmSFJk3H0vIj6VtkI7CQ+uf6MkP6ThgvWBCPPpUu
         m+GA==
X-Gm-Message-State: APjAAAW5CL0nqmSYR1TsdH+7cLD2WysFUy9dQABnvJKOX5ORgOVXURp2
        6I9r9+5tO9shvy+gdua9Bki8Yfits/wf2zEYLx4Ikw==
X-Google-Smtp-Source: APXvYqxGRhrVxtU32F5Zq/TVBo0846dyytMuOUvb1dZY2mOZsVy3P2HV6Dq97F/HSFJq7W5/iOGwluUUDPICS163Jpk=
X-Received: by 2002:a19:c505:: with SMTP id w5mr24686046lfe.115.1571227525264;
 Wed, 16 Oct 2019 05:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568274587.git.rahul.tanwar@linux.intel.com>
 <65898579e78b4b3bb5db9ddc884a818046c1eb4c.1568274587.git.rahul.tanwar@linux.intel.com>
 <CACRpkdbFDTR140_a1FabyjCP2MnBTg-xo2BWnchEvCP161cFLw@mail.gmail.com> <f4cf3553-be3b-ffed-e801-ecb698309a63@linux.intel.com>
In-Reply-To: <f4cf3553-be3b-ffed-e801-ecb698309a63@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Oct 2019 14:05:12 +0200
Message-ID: <CACRpkdZHKm_f04X16w6=Gfa20DVXTWV_KaHO-Esw7RAEKd5pjw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] pinctrl: Add pinmux & GPIO controller driver for
 new SoC
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 6:35 AM Tanwar, Rahul
<rahul.tanwar@linux.intel.com> wrote:

> My understanding is
> that GPIO_GENERIC can support a max of 64 consecutive bits representing
> GPIO lines.

Correct, it also demand that all GPIOs are accessed in a single
register of 8, 16, 32 or 64 bits.

> We have more than 100 GPIO's and they are spread out across
> 4 different banks with non consecutive registers i.e. DATA_IN_0~31@offset0x0,
> DATA_IN_32~63@offset0x100 and so on. In other words, i think we can not
> support memory mapped GPIO controller.

But why can't you just create one device and thus one gpio_chip
per bank?

This is what most drivers do, it also often makes things easier.

The main reason for not doing this is usually something like
that some registers are shared inbetween the banks, or their
registers are mingled in the same MMIO region or so.

If they are just in different memory chunks then create
one device per bank, and all gets much simpler.

> As mentioned above, we cannot use GPIO_GENERIC. And there was no specific
> reason/motivation for us to use regmap-mmio because most of the driver's
> that we referenced were using readl()/write(). Do you recommend us to remove
> readl()/writel() and switch to regmap-mmio based design ?

I don't really know, usually whatever makes for the simplest
code. But check if you can use GPIO_GENERIC first.

> Just to clarify, we have 4 different GPIO banks and each GPIO bank is
> implemented as a separate gpio_chip. So we have 4 instances of gpio_desc
> each one having its own gpio_chip. What i mean to say is that gpio_desc
> is actually not a per-line state container, its a per gpio_chip container.

As you're already creating one gpio_chip per bank using GPIO_GENERIC
should be simple.

Just reference the memory cells directly when calling bgpio_init() for each
mmio address, you're already half done.

Yours,
Linus Walleij
