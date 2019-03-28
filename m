Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA10C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BC520823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n7q19ugh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfC1REI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:04:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36998 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1REH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:04:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id v13so18334073ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 10:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uLZsTr1ZnTtx8y2x536cBQAkY40/zZXg6Grv3og8mQs=;
        b=n7q19ughZ/g5f03Nqh4DI3xmKH0uyuLkPbSLWrEZQRDrrHwKMpI4s1lx9HJ0rZzDdm
         z387yDRP9yKJOPNACC35e0UK3rVQfmzkyyehunleGozGGO4XT88l+zzQifYHLJlx2jPN
         sqXaozyu3lw7K6OmLB81qWMFXWlH7EHSg8VMY9UEoolTJN+RkZvEUm71cfz3w3hSCQKT
         6Dlovt8Dxu/+h68jk3dqHLYET2zeuPOhbJOyV8H2LTaPoF+4q7txp8U2xavtYGOIG4Rc
         ZIeTBx4+HYgzQ+mzMX0uiwLDE2DWpCaUUlaOaJ9uDgsLWefER+bxfMGjB8kNy6q941ds
         j21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uLZsTr1ZnTtx8y2x536cBQAkY40/zZXg6Grv3og8mQs=;
        b=mihB3zfCSaZco5FAOUbnnSPHn9Ist5jGxwGQLUVDp0W/Q0Bun7G0K95EjI+Hnkx3eR
         2lK0ZnvR2SIB7spuOSNn7khwtnx09uoUO3UNjkgoWAe6oMx8Ipl8WeL2XWCOGGYoE+/V
         mRL2d3reBTcWt9ts4aoTYei2inIlyj7B/Qiu/peolYcXVuTdv/wTZYIL8pdq5m4ovxkD
         9R3HJM4wuM82ybi8gun9R6D0Nrm2ysWqE0Qy4+ACH1v0kfJUqF8eSJ9qMWROH8bK7XEH
         s4C4ftIESdcxWhpV0sH5PFYh6q9AdCU4WIXkPauy+vs/G2xu8dyIVUW5a1Gc9KP3S0KA
         BvOg==
X-Gm-Message-State: APjAAAXFQvOZDMoyMcIXTuRoXtqe9SbAWv1+aa1HMmQI4RyFepARIYEy
        diHo63586qFjOTIwvUkyJ6NP4vhH3uDQcd5up/5uvQ==
X-Google-Smtp-Source: APXvYqzaHgdXOx03DXy/lZfAerud/mXHIs/1scH64XW4VKtJeeuMPejyv+8ba7QkfjNTyrnLgfLD0dFus9QmS0xn3ew=
X-Received: by 2002:a2e:7d19:: with SMTP id y25mr9437871ljc.126.1553792645453;
 Thu, 28 Mar 2019 10:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190328131349.18838-1-geert+renesas@glider.be> <20190328131349.18838-3-geert+renesas@glider.be>
In-Reply-To: <20190328131349.18838-3-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Mar 2019 18:03:53 +0100
Message-ID: <CACRpkdZrpmmWzodWuvwAYMbH9ttzStyX0gFiu6evPsMyU72Myw@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: Fix gpiochip_add_data_with_key() error path
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Benoit Parrot <bparrot@ti.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 2:13 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The err_remove_chip block is too coarse, and may perform cleanup that
> must not be done.  E.g. if of_gpiochip_add() fails, of_gpiochip_remove()
> is still called, causing:
>
>     OF: ERROR: Bad of_node_put() on /soc/gpio@e6050000
>     CPU: 1 PID: 20 Comm: kworker/1:1 Not tainted 5.1.0-rc2-koelsch+ #407
>     Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
>     Workqueue: events deferred_probe_work_func
>     [<c020ec74>] (unwind_backtrace) from [<c020ae58>] (show_stack+0x10/0x14)
>     [<c020ae58>] (show_stack) from [<c07c1224>] (dump_stack+0x7c/0x9c)
>     [<c07c1224>] (dump_stack) from [<c07c5a80>] (kobject_put+0x94/0xbc)
>     [<c07c5a80>] (kobject_put) from [<c0470420>] (gpiochip_add_data_with_key+0x8d8/0xa3c)
>     [<c0470420>] (gpiochip_add_data_with_key) from [<c0473738>] (gpio_rcar_probe+0x1d4/0x314)
>     [<c0473738>] (gpio_rcar_probe) from [<c052fca8>] (platform_drv_probe+0x48/0x94)
>
> and later, if a GPIO consumer tries to use a GPIO from a failed
> controller:
>
>     WARNING: CPU: 0 PID: 1 at lib/refcount.c:156 kobject_get+0x38/0x4c
>     refcount_t: increment on 0; use-after-free.
>     Modules linked in:
>     CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.1.0-rc2-koelsch+ #407
>     Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
>     [<c020ec74>] (unwind_backtrace) from [<c020ae58>] (show_stack+0x10/0x14)
>     [<c020ae58>] (show_stack) from [<c07c1224>] (dump_stack+0x7c/0x9c)
>     [<c07c1224>] (dump_stack) from [<c0221580>] (__warn+0xd0/0xec)
>     [<c0221580>] (__warn) from [<c02215e0>] (warn_slowpath_fmt+0x44/0x6c)
>     [<c02215e0>] (warn_slowpath_fmt) from [<c07c58fc>] (kobject_get+0x38/0x4c)
>     [<c07c58fc>] (kobject_get) from [<c068b3ec>] (of_node_get+0x14/0x1c)
>     [<c068b3ec>] (of_node_get) from [<c0686f24>] (of_find_node_by_phandle+0xc0/0xf0)
>     [<c0686f24>] (of_find_node_by_phandle) from [<c0686fbc>] (of_phandle_iterator_next+0x68/0x154)
>     [<c0686fbc>] (of_phandle_iterator_next) from [<c0687fe4>] (__of_parse_phandle_with_args+0x40/0xd0)
>     [<c0687fe4>] (__of_parse_phandle_with_args) from [<c0688204>] (of_parse_phandle_with_args_map+0x100/0x3ac)
>     [<c0688204>] (of_parse_phandle_with_args_map) from [<c0471240>] (of_get_named_gpiod_flags+0x38/0x380)
>     [<c0471240>] (of_get_named_gpiod_flags) from [<c046f864>] (gpiod_get_from_of_node+0x24/0xd8)
>     [<c046f864>] (gpiod_get_from_of_node) from [<c0470aa4>] (devm_fwnode_get_index_gpiod_from_child+0xa0/0x144)
>     [<c0470aa4>] (devm_fwnode_get_index_gpiod_from_child) from [<c05f425c>] (gpio_keys_probe+0x418/0x7bc)
>     [<c05f425c>] (gpio_keys_probe) from [<c052fca8>] (platform_drv_probe+0x48/0x94)
>
> Fix this by splitting the cleanup block, and adding a missing call to
> gpiochip_irqchip_remove().
>
> Fixes: 28355f81969962cf ("gpio: defer probe if pinctrl cannot be found")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> I'm not so sure about the need for the call to
> gpiochip_irqchip_remove(), as add/remove are not really symmetrical.
> Any comments?

I need to think about this.

Also Mukesh had some comments on naming.

I will try to read through the code closer for v2 and
figure out if it is what we want to do. But I think we need it.

Yours,
Linus Walleij
