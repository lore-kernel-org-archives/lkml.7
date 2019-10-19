Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B21BCA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 16:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB8521925
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 16:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgIyqCuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfJSQmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 12:42:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35957 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfJSQmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 12:42:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id w18so8782253wrt.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 09:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0bulbVbLFGY/pgLXwzKHTMch+8Jp9lMq9IfLMGu0aYU=;
        b=HgIyqCuUO+e+giNE3pXqdKKKNkzDBd/g7tALz2r5hkQthl3/8yUK+5arjmMrt0O7nR
         koMmynGdv1ZbjNfbEVxCr7dngv4FM5oaZ+hgqvVReIcaoMKpfMly6lBltbyE1kQtgYoF
         XY5hDpI0yXdzWh3LM+xXCymu6CMemw+vwM+slnxnoeNW340l94hK9kFbdBo80TS8bQkR
         aBWxDWy7ANe+niAEN/yPp+gxgHyyXxtTeaKcicBuhuz87s/NiSqS9cXV3xptQZ5RgRgd
         BI0B7i9xUUiowVJCJtVphjcGoje5iyciLfiUFPRH8rZaVSgcTX8eoMJwfMYaKBAykGLI
         LpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0bulbVbLFGY/pgLXwzKHTMch+8Jp9lMq9IfLMGu0aYU=;
        b=P0Nq7K+Wm0/K3qezltUacdYDrpTTaoTPMMKaklsHouogVjy8pSSIar1z3qmGHtXbkh
         h+HOBulB1QS9xvRtHtXNvDkxNPKv70QvmpSoRa4DlKHkaLY4hEBjkyyfsli/g5B6YdjX
         GvS1qw/oi7cuOpvgt73Fcy9v2lfgjgUyDguB7cKbyFEWALnNdEsPHL4Acju0MsZ+0kUd
         Us8/n0ok5MERF/3C+eVoHU3dNl4igrjKdW6poGsYFyNqZBowQKsJOCyZAWSNBxXwstrI
         6SyXPYVI5wZB25lweYv8dsX0QaSbmN+v3elMQVSWHrJKdXbzaxueEAsEvQ6qKF3oUXa5
         vj+Q==
X-Gm-Message-State: APjAAAXoNHbDW/g8Px3+Gg4L1dzqhPDxC64pbgy4WkVXNtAgTj6MpYNM
        3cPL19odTItxyaHBDCjK1Bw=
X-Google-Smtp-Source: APXvYqyM4l9k7cGD3tumxE88d3itrboRb1M11XuIyWc1ueSHSjk92dpIJ8FfpUbXhENTni2Dg7NB2A==
X-Received: by 2002:adf:8567:: with SMTP id 94mr9317417wrh.65.1571503356410;
        Sat, 19 Oct 2019 09:42:36 -0700 (PDT)
Received: from giga-mm ([62.68.26.146])
        by smtp.gmail.com with ESMTPSA id 143sm15047896wmb.33.2019.10.19.09.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 09:42:35 -0700 (PDT)
Date:   Sat, 19 Oct 2019 18:42:34 +0200
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Hubert Feurstein <hubert.feurstein@contec.at>,
        Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH 2/6] ARM: ep93xx: enable SPARSE_IRQ
Message-Id: <20191019184234.4cdb37a735fe632528880d76@gmail.com>
In-Reply-To: <20191018163047.1284736-2-arnd@arndb.de>
References: <20191018163047.1284736-1-arnd@arndb.de>
        <20191018163047.1284736-2-arnd@arndb.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnd,

On Fri, 18 Oct 2019 18:29:15 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> Without CONFIG_SPARSE_IRQ, we rely on mach/irqs.h to define NR_IRQS
> globally. Do the minimal conversion by setting .nr_irqs in each
> machine descriptor.
> 
> Only the vision_ep9307 machine has extra IRQs for GPIOs, so make
> .nr_irqs the original value there, while using the plain NR_EP93XX_IRQS
> everywhere else.

This patch causes multiple problems on EDB9302:

1. WARNINGs during gpiochip registration, for instance:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at kernel/irq/chip.c:1013 __irq_do_set_handler+0x94/0x188
CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.4.0-rc3 #1
Hardware name: Cirrus Logic EDB9302 Evaluation Board
[<c000e878>] (unwind_backtrace) from [<c000d574>] (show_stack+0x10/0x18)
[<c000d574>] (show_stack) from [<c0335e28>] (dump_stack+0x18/0x24)
[<c0335e28>] (dump_stack) from [<c001cf1c>] (__warn+0xa4/0xc8)
[<c001cf1c>] (__warn) from [<c001cfe8>] (warn_slowpath_fmt+0xa8/0xb8)
[<c001cfe8>] (warn_slowpath_fmt) from [<c0055668>] (__irq_do_set_handler+0x94/0x188)
[<c0055668>] (__irq_do_set_handler) from [<c005647c>] (irq_set_chained_handler_and_data+0x48/0x7c)
[<c005647c>] (irq_set_chained_handler_and_data) from [<c01ab440>] (gpiochip_add_data_with_key+0x6d4/0xabc)
[<c01ab440>] (gpiochip_add_data_with_key) from [<c01ab868>] (devm_gpiochip_add_data+0x40/0x88)
[<c01ab868>] (devm_gpiochip_add_data) from [<c01ae554>] (ep93xx_gpio_probe+0x1ac/0x280)
[<c01ae554>] (ep93xx_gpio_probe) from [<c01e0f34>] (platform_drv_probe+0x28/0x6c)
[<c01e0f34>] (platform_drv_probe) from [<c01df588>] (really_probe+0x1c8/0x340)
[<c01df588>] (really_probe) from [<c01ddfe4>] (bus_for_each_drv+0x58/0xc0)
[<c01ddfe4>] (bus_for_each_drv) from [<c01df904>] (__device_attach+0xb4/0x104)
[<c01df904>] (__device_attach) from [<c01de1d4>] (bus_probe_device+0x8c/0x94)
[<c01de1d4>] (bus_probe_device) from [<c01db5e4>] (device_add+0x3d0/0x59c)
[<c01db5e4>] (device_add) from [<c01e16d8>] (platform_device_add+0x100/0x20c)
[<c01e16d8>] (platform_device_add) from [<c03f50b0>] (ep93xx_init_devices+0x16c/0x20c)
[<c03f50b0>] (ep93xx_init_devices) from [<c03f53a0>] (edb93xx_init_machine+0xc/0x84)
[<c03f53a0>] (edb93xx_init_machine) from [<c03f1984>] (customize_machine+0x20/0x38)
[<c03f1984>] (customize_machine) from [<c03f0e54>] (do_one_initcall+0x78/0x1a0)
[<c03f0e54>] (do_one_initcall) from [<c03f1080>] (kernel_init_freeable+0x104/0x1b8)
[<c03f1080>] (kernel_init_freeable) from [<c034c358>] (kernel_init+0x8/0xf8)
[<c034c358>] (kernel_init) from [<c00090d0>] (ret_from_fork+0x14/0x24)
Exception stack(0xc4433fb0 to 0xc4433ff8)
3fa0:                                     00000000 00000000 00000000 00000000
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
---[ end trace 8f9e35e2d6224882 ]---

2. Broken sound (I2S), this looks like below in the log:

ep93xx-i2s ep93xx-i2s: Missing dma channel for stream: 0
 CS4271: ASoC: pcm constructor failed: -22
edb93xx-audio edb93xx-audio: ASoC: can't create pcm CS4271 HiFi :-22

And /proc/interrupts has two entries less. Without patch:

# cat /proc/interrupts
           CPU0       
  7:          0       VIC   7 Edge      i2s-pcm-out
  8:          0       VIC   8 Edge      i2s-pcm-in
 39:          2       VIC   7 Edge      eth0
 51:       7532       VIC  19 Edge      ep93xx timer
 52:        144       VIC  20 Edge      uart-pl010
 53:          4       VIC  21 Edge      ep93xx-spi
 60:          0       VIC  28 Edge      ep93xx-i2s
Err:          0

With patch:

# cat /proc/interrupts 
           CPU0       
 39:        146       VIC   7 Edge      eth0
 51:     162161       VIC  19 Edge      ep93xx timer
 52:        139       VIC  20 Edge      uart-pl010
 53:          4       VIC  21 Edge      ep93xx-spi
 60:          0       VIC  28 Edge      ep93xx-i2s
Err:          0

I will try to look into I2S problem...
 
> ---
> It's been a while since I did this, no idea what else is needed
> here or if this is correct at all.
> 
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Cc: Hubert Feurstein <hubert.feurstein@contec.at>
> Cc: Lukasz Majewski <lukma@denx.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/Kconfig                               | 2 ++
>  arch/arm/mach-ep93xx/adssphere.c               | 1 +
>  arch/arm/mach-ep93xx/edb93xx.c                 | 8 ++++++++
>  arch/arm/mach-ep93xx/gesbc9312.c               | 1 +
>  arch/arm/mach-ep93xx/{include/mach => }/irqs.h | 7 -------
>  arch/arm/mach-ep93xx/micro9.c                  | 4 ++++
>  arch/arm/mach-ep93xx/simone.c                  | 1 +
>  arch/arm/mach-ep93xx/snappercl15.c             | 1 +
>  arch/arm/mach-ep93xx/soc.h                     | 1 +
>  arch/arm/mach-ep93xx/ts72xx.c                  | 3 ++-
>  arch/arm/mach-ep93xx/vision_ep9307.c           | 1 +
>  11 files changed, 22 insertions(+), 8 deletions(-)
>  rename arch/arm/mach-ep93xx/{include/mach => }/irqs.h (94%)

-- 
Alexander Sverdlin.
