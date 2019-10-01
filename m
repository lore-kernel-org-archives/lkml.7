Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D679C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168C0215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IVRg4ziD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfJASyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:54:13 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44230 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJASyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:54:13 -0400
Received: by mail-ot1-f66.google.com with SMTP id 21so12484282otj.11;
        Tue, 01 Oct 2019 11:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=57yXlV8OeF+0A0WSjdRw1RAKAtRQrYraqmnbKpxC2+Y=;
        b=IVRg4ziD4+m3AGA84oC1PB6cVSjQE841td4dJj4H4TiI3uRrXjHOY9tPNPttnsefSC
         O/wQGnPrIVk5CYD/e2mKINg3Q9+Yy0hbKRD0kBjE/FWb0Js9aQWEhYi8cLeZE+aj7NQl
         POude1xddiy+mipI/Z8vyxQ2Ci0pft9aGW0k8y+xS9rO7CiKlVYoHiVaVYvpjUkT1EFr
         sjZzKdCsSP34UG2KoUoAMGSvdzPdAY8JNUJKcWxRaeW1HICJNne7GtoR0XM0XGTuBYc5
         RXprE73Olm5ge/vMWloiBAjGfX8Yqgz/h6BiG3uuZQDIP202qRtjoFHMRgtBQPYPRMgw
         0FRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=57yXlV8OeF+0A0WSjdRw1RAKAtRQrYraqmnbKpxC2+Y=;
        b=py/tU6jJ+wE6pKHe9lNJaHr5fhNTv10cd+MT2wL8U1F0n9pkMRAFI027Z/Qy0+sMnG
         XzkF9/bjV68uRaME6zxttu+tcQY9h0kAQY3TdiGvBuWQgN9NeZYOuBhLQ6JuOtTO1pIG
         Qo7YXQQ2dsiZwF7+BDPugmT3gc5j146pLaK1x4U3icaTFkWvtqn0BN0WaFoCOzTOk2N+
         sHXsf5Yz7yJTCTP4o2ZHZLldyuWF+jSDTP/LTdYa44MaIC0eQMKRIUQ0qMmgEIlHkwDu
         g8HygdtyUNVPSGOVdEPtDy7bY23gJ+eA2yKiklwpl4XFa7OfhCmL4XqUNYG/yb7C5iE7
         pRhw==
X-Gm-Message-State: APjAAAW3QGEkIo8osOtJ4t25374dKMHN5Eur6CN7m8BS1S7rtaMneGfp
        VZDEg34gyu8/MI7G/FHy9ryd3G9azdPAI9A+6kAujbdB
X-Google-Smtp-Source: APXvYqxLEQLgzH4uct9tKZ1G7O2LATrGxjQXO5VcuOdLMA8/sRylhq0Z66fDA037/nvoHjZZHwt1o+5IEgjEjGZQuWM=
X-Received: by 2002:a05:6830:150d:: with SMTP id k13mr11986095otp.98.1569956050467;
 Tue, 01 Oct 2019 11:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190921151835.770263-1-martin.blumenstingl@googlemail.com>
 <20190921151835.770263-3-martin.blumenstingl@googlemail.com> <1jftkcr3uy.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jftkcr3uy.fsf@starbuckisacylon.baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 1 Oct 2019 20:53:59 +0200
Message-ID: <CAFBinCCED4YWYkdtrfrC80C8WLE=fyMJdjTa3wFNMJgC1OsoOA@mail.gmail.com>
Subject: Re: [PATCH 2/6] clk: meson: add a driver for the Meson8/8b/8m2 DDR
 clock controller
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

thank you for taking the time to go through this!

On Tue, Oct 1, 2019 at 3:29 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
[...]
> > +#include <linux/platform_device.h>
> > +#include <linux/mfd/syscon.h>
>
> syscon is not used in the driver
oops, good catch - thank you

[...]
> > +static struct clk_hw_onecell_data meson8_ddr_clk_hw_onecell_data = {
> > +     .hws = {
> > +             [DDR_CLKID_DDR_PLL_DCO]         = &meson8_ddr_pll_dco.hw,
> > +             [DDR_CLKID_DDR_PLL]             = &meson8_ddr_pll.hw,
>
> I wonder if onecell is not overkill for this driver. We won't expose the
> DCO, so only the post divider remains
>
> Do you expect this provider to have more than one leaf clock ?
> If not, maybe you could use of_clk_hw_simple_get() instead ?
there's some more clock bits in DDR_CLK_CNTL - the public A311D
datasheet has a description for these bits but I'm not sure they do
the same on Meson8/Meson8b/Meson8m2
all I know is that some magic bytes are written to DDR_CLK_CNTL in the
old u-boot code

that's why I don't want to make any assumptions and play safe here (by
using a onecell clock provider)

> > +     },
> > +     .num = 2,
> > +};
> > +
> > +static struct clk_regmap *const meson8_ddr_clk_regmaps[] = {
> > +     &meson8_ddr_pll_dco,
> > +     &meson8_ddr_pll,
> > +};
> > +
> > +static const struct regmap_config meson8_ddr_clkc_regmap_config = {
> > +     .reg_bits = 8,
> > +     .val_bits = 32,
> > +     .reg_stride = 4,
> > +     .fast_io = true,
>
> I think fast_io will default to true with memory based register.
> Setting the max_register would be nice
good point - I'll take care of this when sending v2


Martin
