Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FC5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B7D2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfC1SUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:20:54 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:35984 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfC1SUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:20:54 -0400
Received: by mail-vk1-f195.google.com with SMTP id v131so4731004vkd.3;
        Thu, 28 Mar 2019 11:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ray+X5oHdLjJvfNIy0bWspEOXOwalHcPPUpZ9zVe/U4=;
        b=mYQX0uTpkQqcPfdEudy+NdZnYm93uy7EU2VwDjYCGneuRVWm9yx0F7bziiOsBNnyD4
         cvTsX0Foz1WufVAdVLP5bNJzCzrNGeR6CIny+Ptil4R6kTDF6/6pN1zhvxeLiS0zJzbT
         x/67xHhs29y3IOR9gnIC38WDOIw7YGphKUXnOYqT/LRygFoWEP27rkqtBL6TKsTbTLyX
         /8ACN35P4/LN6ofCt/v7wc+WkRQjuKm5Lhe+zHJ+ALpnWtntATjY+d4euQecgwu6St6h
         fBh+/QDLZt7BH2xeu6Wjw/OqksyVUrbC692ajTWD0tyTxXZ2Y56d53u4s7g9yguAljl3
         3Pow==
X-Gm-Message-State: APjAAAVNixYjL+OIzlXcvh7c5/DlMxLp+9kO2g9Qmf0K/2id2xzlftKR
        cqQZ6SPNAWoS3NOJKGTJloYM6klB4XapP540OoE=
X-Google-Smtp-Source: APXvYqyk0PP8woeQVEqhTozhr6lluO8bwcjIkkdAgCnGN/RDItweXDKCY77Zm8LND/rOjegaIjZEcPMliWTfIbIN9qo=
X-Received: by 2002:a1f:711:: with SMTP id 17mr27325355vkh.65.1553797252712;
 Thu, 28 Mar 2019 11:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190328131349.18838-1-geert+renesas@glider.be>
 <20190328131349.18838-3-geert+renesas@glider.be> <c7b93076-4016-5413-dc03-0be1965bf498@codeaurora.org>
In-Reply-To: <c7b93076-4016-5413-dc03-0be1965bf498@codeaurora.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Mar 2019 19:20:41 +0100
Message-ID: <CAMuHMdWyG13EXTu6ouk+STJ_b3pAz6cgj7=RDecBRC2aWHzCWA@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: Fix gpiochip_add_data_with_key() error path
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Benoit Parrot <bparrot@ti.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mukesj,

On Thu, Mar 28, 2019 at 4:31 PM Mukesh Ojha <mojha@codeaurora.org> wrote:
> On 3/28/2019 6:43 PM, Geert Uytterhoeven wrote:
> > The err_remove_chip block is too coarse, and may perform cleanup that
> > must not be done.  E.g. if of_gpiochip_add() fails, of_gpiochip_remove()
> > is still called, causing:
> >
> >      OF: ERROR: Bad of_node_put() on /soc/gpio@e6050000
> >      CPU: 1 PID: 20 Comm: kworker/1:1 Not tainted 5.1.0-rc2-koelsch+ #407
> >      Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
> >      Workqueue: events deferred_probe_work_func
> >      [<c020ec74>] (unwind_backtrace) from [<c020ae58>] (show_stack+0x10/0x14)
> >      [<c020ae58>] (show_stack) from [<c07c1224>] (dump_stack+0x7c/0x9c)
> >      [<c07c1224>] (dump_stack) from [<c07c5a80>] (kobject_put+0x94/0xbc)
> >      [<c07c5a80>] (kobject_put) from [<c0470420>] (gpiochip_add_data_with_key+0x8d8/0xa3c)
> >      [<c0470420>] (gpiochip_add_data_with_key) from [<c0473738>] (gpio_rcar_probe+0x1d4/0x314)
> >      [<c0473738>] (gpio_rcar_probe) from [<c052fca8>] (platform_drv_probe+0x48/0x94)
> >
> > and later, if a GPIO consumer tries to use a GPIO from a failed
> > controller:
> >
> >      WARNING: CPU: 0 PID: 1 at lib/refcount.c:156 kobject_get+0x38/0x4c
> >      refcount_t: increment on 0; use-after-free.
> >      Modules linked in:
> >      CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.1.0-rc2-koelsch+ #407
> >      Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
> >      [<c020ec74>] (unwind_backtrace) from [<c020ae58>] (show_stack+0x10/0x14)
> >      [<c020ae58>] (show_stack) from [<c07c1224>] (dump_stack+0x7c/0x9c)
> >      [<c07c1224>] (dump_stack) from [<c0221580>] (__warn+0xd0/0xec)
> >      [<c0221580>] (__warn) from [<c02215e0>] (warn_slowpath_fmt+0x44/0x6c)
> >      [<c02215e0>] (warn_slowpath_fmt) from [<c07c58fc>] (kobject_get+0x38/0x4c)
> >      [<c07c58fc>] (kobject_get) from [<c068b3ec>] (of_node_get+0x14/0x1c)
> >      [<c068b3ec>] (of_node_get) from [<c0686f24>] (of_find_node_by_phandle+0xc0/0xf0)
> >      [<c0686f24>] (of_find_node_by_phandle) from [<c0686fbc>] (of_phandle_iterator_next+0x68/0x154)
> >      [<c0686fbc>] (of_phandle_iterator_next) from [<c0687fe4>] (__of_parse_phandle_with_args+0x40/0xd0)
> >      [<c0687fe4>] (__of_parse_phandle_with_args) from [<c0688204>] (of_parse_phandle_with_args_map+0x100/0x3ac)
> >      [<c0688204>] (of_parse_phandle_with_args_map) from [<c0471240>] (of_get_named_gpiod_flags+0x38/0x380)
> >      [<c0471240>] (of_get_named_gpiod_flags) from [<c046f864>] (gpiod_get_from_of_node+0x24/0xd8)
> >      [<c046f864>] (gpiod_get_from_of_node) from [<c0470aa4>] (devm_fwnode_get_index_gpiod_from_child+0xa0/0x144)
> >      [<c0470aa4>] (devm_fwnode_get_index_gpiod_from_child) from [<c05f425c>] (gpio_keys_probe+0x418/0x7bc)
> >      [<c05f425c>] (gpio_keys_probe) from [<c052fca8>] (platform_drv_probe+0x48/0x94)
> >
> > Fix this by splitting the cleanup block, and adding a missing call to
> > gpiochip_irqchip_remove().
> >
> > Fixes: 28355f81969962cf ("gpio: defer probe if pinctrl cannot be found")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > I'm not so sure about the need for the call to
> > gpiochip_irqchip_remove(), as add/remove are not really symmetrical.
> > Any comments?
> > ---
> >   drivers/gpio/gpiolib.c | 12 ++++++++----
> >   1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index 144af07335815998..ed4da07effe0ac40 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -1379,7 +1379,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
> >
> >       status = gpiochip_add_irqchip(chip, lock_key, request_key);
> >       if (status)
> > -             goto err_remove_chip;
> > +             goto err_free_irqchip_mask;
>
> Name is quite confusing
> this should be
>
> s/err_free_irqchip_mask/err_free_gpiochip_mask

Thanks, makes perfect sense.

> After reviewing back and forth it looks good, apart from the naming.
> Please fix.

Done (locally).

> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
