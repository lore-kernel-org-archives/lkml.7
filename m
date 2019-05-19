Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12725C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 23:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5113206BF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 23:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T6NKMFeM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfESXzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 19:55:00 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33437 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfESXy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 19:54:59 -0400
Received: by mail-qt1-f196.google.com with SMTP id m32so14405521qtf.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 16:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0al1JPf1p4k1Xk2X9+xnd+opR9sCtlA9+Q7CGf2wkdc=;
        b=T6NKMFeM174EdWJEdEKuDliPahKZ9qUMazWV6/jMf/XLDI7pD39ukI1sK8O2e85XBf
         RYmOIOG+XLoy0h+NvsmkaHjgqQudFNjBk9hLgPr4DUNG6sIXuHOUJzKZLbYApGEko7an
         wAzAzUXOS9ZogWkCbeW5ONopU7yGZXHpJl2lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0al1JPf1p4k1Xk2X9+xnd+opR9sCtlA9+Q7CGf2wkdc=;
        b=qyYvISYuBEVII6O6dOfZy1k3/DkkHeMM4DPtKhz9KSGskcZj2BLgTGGOSj6ztKgP+E
         a3+0bQKWm4QbkrOZ6yPY9Xi4jIrEqOSGJ9OVJ25UXsA3xTciX5ymkRB/49TaJgDc+VNT
         Qq1/+p7NZ+Gyh+HgqbTqdbQtp1dmJek6Kx0heK1yy6Aj9Q1C8oSnetgGcArJ0+mq39Cj
         9xOtTWrkJcI1M18pDUbX4H4SEK2G+L0UciIkRoI6z+wMZLVjHFFPaicsnm7r92tQlEC+
         JT8pWQ4Y0OTE8coD1qUxfntRY0M3vrS2IKjikDEEZZOm8W1H4vVhlQDnt+16hd15x3h6
         s/Fg==
X-Gm-Message-State: APjAAAVpAAdjW30tGU5jArab6XIBcMF/4wPtrtrNXyKBA3aLzHEIL7X1
        CS3SDUVyJXzqKODXO6Vh57iBcaDfcDpuA/FivoTwzQ==
X-Google-Smtp-Source: APXvYqwuM2OlEjQTosUkdQ68MTbdvXpkAnX3zKDv4qbIHQN0OW9swG37cfTJhaHqVK/SMXwdbTye4hUKW1XJUQSuGbI=
X-Received: by 2002:ac8:3524:: with SMTP id y33mr59412515qtb.159.1558310098407;
 Sun, 19 May 2019 16:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190519160446.320-1-hsinyi@chromium.org> <20190519160446.320-2-hsinyi@chromium.org>
In-Reply-To: <20190519160446.320-2-hsinyi@chromium.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 20 May 2019 07:54:47 +0800
Message-ID: <CANMq1KB7sh=UXaM4sMm_THjZ_wV3Thgr6_ona-TJFqA2QQHALA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] fdt: add support for rng-seed
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 1:09 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Introducing a chosen node, rng-seed, which is an entropy that can be
> passed to kernel called very early to increase initial device
> randomness. Bootloader should provide this entropy and the value is
> read from /chosen/rng-seed in DT.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> change log v2->v4:
> * v3 abandoned
> * fix doc error
> ---
>  Documentation/devicetree/bindings/chosen.txt | 14 ++++++++++++++
>  drivers/of/fdt.c                             | 10 ++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
> index 45e79172a646..678e81bc4383 100644
> --- a/Documentation/devicetree/bindings/chosen.txt
> +++ b/Documentation/devicetree/bindings/chosen.txt
> @@ -28,6 +28,20 @@ mode) when EFI_RNG_PROTOCOL is supported, it will be overwritten by
>  the Linux EFI stub (which will populate the property itself, using
>  EFI_RNG_PROTOCOL).
>
> +rng-seed
> +-----------
> +
> +This property serves as an entropy to add device randomness. It is parsed
> +as a byte array, e.g.
> +
> +/ {
> +       chosen {
> +               rng-seed = <0x31 0x95 0x1b 0x3c 0xc9 0xfa 0xb3 ...>;
> +       };
> +};
> +
> +This random value should be provided by bootloader.
> +
>  stdout-path
>  -----------
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index de893c9616a1..7f3d72921b23 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -24,6 +24,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/serial_core.h>
>  #include <linux/sysfs.h>
> +#include <linux/random.h>

Alphabetical order.

>
>  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>  #include <asm/page.h>
> @@ -1079,6 +1080,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>  {
>         int l;
>         const char *p;
> +       const void *rng_seed;
>
>         pr_debug("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
>
> @@ -1113,6 +1115,14 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>
>         pr_debug("Command line is: %s\n", (char*)data);
>
> +       rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
> +       if (rng_seed && l > 0) {
> +               add_device_randomness(rng_seed, l);
> +
> +               /* try to clear seed so it won't be found. */
> +               fdt_delprop(initial_boot_params, node, "rng-seed");

I'm a little bit concerned about this, as we really want the rng-seed
value to be wiped, and not kept in memory (even if it's hard to
access).

IIUC, fdt_delprop splices the device tree, so it'll override
"rng-seed" property with whatever device tree entries follow it.
However, if rng-seed is the last property (or if the entries that
follow are smaller than rng-seed), the seed will stay in memory (or
part of it).

fdt_nop_property in v2 would erase it for sure. I don't know if there
is a way to make sure that rng-seed is removed for good while still
deleting the property (maybe modify fdt_splice_ to do a memset(.., 0)
of the moved chunk?).


> +       }
> +
>         /* break now */
>         return 1;
>  }
> --
> 2.20.1
>
