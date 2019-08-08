Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CDFC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694A7218B8
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbfHHH7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:59:02 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34551 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731588AbfHHH7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:59:01 -0400
Received: by mail-ot1-f66.google.com with SMTP id n5so115171636otk.1;
        Thu, 08 Aug 2019 00:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DVhpQNMzq05tycScJr2r1xV1Y0LJT9ZISA62PMeb6GU=;
        b=bZld0Hc13YbAaBD3UHAnCgxZtM3hpnIdwFHXheCeyKB4J1WMWzrXWY07rU4yMnO936
         YgGI68RhpFYSAp2AHedTfo9xViwRElccjB0FonxO/7n2FwhTsXWSE6WJWA7R0EMJ+oFV
         ScPxf8/HWF2SHx0xdL9ViNi3DK23gYXsH4QSihQa563XYeAIcfeiXriXGyVPXTSmCZAZ
         G+/1cDpXe3qLB0SiO3m1ZQXAStKjwV00e73I70hOL97j8RNsxJfuXhgZdK/XuEKdFCex
         BtMRtEYj6Xt4W0ZKWx1Gcium685nFwrXMB426HBA8DqEP7MvgUfFQU4h0rPs78XPNUj8
         rGWg==
X-Gm-Message-State: APjAAAUpZ9jfQ/mlw4EVdCEoXsc4LV0wHv8U0xyfjzxchULQNq2YE21i
        p6x0qgknz3VzT1KJZXJtVXvFMPX82IgSnucpRBk=
X-Google-Smtp-Source: APXvYqwlUMzu6TevJKiMfj8xo6e/mWVNrZN8y01RcAxyf4Q1QHT8l2IIDmz1X54nHYhX19Jsj0cvXqwMo6uNXI3FKqA=
X-Received: by 2002:a9d:5c11:: with SMTP id o17mr11036525otk.107.1565251140765;
 Thu, 08 Aug 2019 00:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190730181557.90391-1-swboyd@chromium.org> <20190730181557.90391-30-swboyd@chromium.org>
In-Reply-To: <20190730181557.90391-30-swboyd@chromium.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 8 Aug 2019 09:58:49 +0200
Message-ID: <CAMuHMdVMTAQ7oiRd443qLfY42cwd21x1nJM0yhKLtoqKjHDLQg@mail.gmail.com>
Subject: Re: [PATCH v6 29/57] mmc: Remove dev_err() usage after platform_get_irq()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Jul 30, 2019 at 10:58 PM Stephen Boyd <swboyd@chromium.org> wrote:
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
>
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
>
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
>
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
>
> While we're here, remove braces on if statements that only have one
> statement (manually).
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Please apply directly to subsystem trees
>
>  drivers/mmc/host/bcm2835.c       | 1 -
>  drivers/mmc/host/jz4740_mmc.c    | 1 -
>  drivers/mmc/host/meson-gx-mmc.c  | 1 -
>  drivers/mmc/host/mxcmmc.c        | 4 +---
>  drivers/mmc/host/s3cmci.c        | 1 -
>  drivers/mmc/host/sdhci-msm.c     | 2 --
>  drivers/mmc/host/sdhci-pltfm.c   | 1 -
>  drivers/mmc/host/sdhci-s3c.c     | 4 +---
>  drivers/mmc/host/sdhci_f_sdh30.c | 4 +---
>  drivers/mmc/host/uniphier-sd.c   | 4 +---
>  10 files changed, 4 insertions(+), 19 deletions(-)

Failed to catch:

drivers/mmc/host/sh_mmcif.c:    irq[0] = platform_get_irq(pdev, 0);
drivers/mmc/host/sh_mmcif.c:    irq[1] = platform_get_irq(pdev, 1);
drivers/mmc/host/sh_mmcif.c-    if (irq[0] < 0) {
drivers/mmc/host/sh_mmcif.c-            dev_err(dev, "Get irq error\n");
drivers/mmc/host/sh_mmcif.c-            return -ENXIO;
drivers/mmc/host/sh_mmcif.c-    }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
