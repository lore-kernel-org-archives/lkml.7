Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2646FC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 07:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4352084D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 07:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfJGHhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 03:37:12 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36677 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfJGHhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 03:37:11 -0400
Received: by mail-oi1-f195.google.com with SMTP id k20so10842452oih.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 00:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+us/Xs6/VVlDCI76333iuj0kxSnoyHeX7/Xe8GXVnkA=;
        b=THtKpxDnalOqFCniZaROXCRdxk88qqieOSecsHr6gPnt2lmqabi9oMSaCERXRB+tPf
         l1A8tfbsEV/Z+bb4QPGBeZYa6Ry/lIwnguoJRXRtqV3dDod1Xar+QXGAxMZcq14V6btv
         Dckc1wKZNHE+QemGIivjJz90AMni4pnfWY1Zib0bifOk5djA/47u5FRsNcuc+WWD+T0W
         U65Xu0QJV1evuhE/nAe12KvtM65IokNIH6x4igVjV+qC7BZF6rSSjiCgJ8XeLL28a+VA
         cfrfhEWnst74lmlZb+KuZLdGts6QC0NqzQLTjsVtRkM3zEhmu2oEhW1LWjY4eeWoJCm8
         6ZLA==
X-Gm-Message-State: APjAAAXrPIEFacm/PM3lotf3CFlki6+ikHT5dCq5Dk9bgZPMQc+UCE+8
        NOg/Fn+3vQguevXkP5xCtMCYCNwK3atBZ299ams=
X-Google-Smtp-Source: APXvYqxq36XWyxkQ9gcPIVxb/ThXzx6LUjEmdGwIUR9xlMWYjhvk50sOp7YdGQZpBaj9xPfNWdZH7FS8QwQzudC1XBI=
X-Received: by 2002:aca:cdc7:: with SMTP id d190mr16426258oig.148.1570433830528;
 Mon, 07 Oct 2019 00:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191005053317.7856-1-andrew.smirnov@gmail.com> <20191005082534.GA12308@lst.de>
In-Reply-To: <20191005082534.GA12308@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Oct 2019 09:36:59 +0200
Message-ID: <CAMuHMdWCtX5GsNMXhDkJxTPsrcTHRuHZDCjkTEB5GLLhXFA8Ag@mail.gmail.com>
Subject: Re: [PATCH] dma-mapping: fix false positivse warnings in dma_common_free_remap()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 5, 2019 at 10:25 AM Christoph Hellwig <hch@lst.de> wrote:
> thanks for the patch.  I think it would be much easier to just
> use the original open coded check in dma_common_free_remap instead
> of adding a new helper.  What do you think of the version below?
>
> ---
> From 2cf2aa6a69db0b17b3979144287af8775c1c1534 Mon Sep 17 00:00:00 2001
> From: Andrey Smirnov <andrew.smirnov@gmail.com>
> Date: Sat, 5 Oct 2019 10:23:30 +0200
> Subject: dma-mapping: fix false positivse warnings in dma_common_free_remap()
>
> Commit 5cf4537975bb ("dma-mapping: introduce a dma_common_find_pages
> helper") changed invalid input check in dma_common_free_remap() from:
>
>     if (!area || !area->flags != VM_DMA_COHERENT)
>
> to
>
>     if (!area || !area->flags != VM_DMA_COHERENT || !area->pages)
>
> which seem to produce false positives for memory obtained via
> dma_common_contiguous_remap()
>
> This triggers the following warning message when doing "reboot" on ZII
> VF610 Dev Board Rev B:
>
> WARNING: CPU: 0 PID: 1 at kernel/dma/remap.c:112 dma_common_free_remap+0x88/0x8c
> trying to free invalid coherent area: 9ef82980
> Modules linked in:
> CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 5.3.0-rc6-next-20190820 #119
> Hardware name: Freescale Vybrid VF5xx/VF6xx (Device Tree)
> Backtrace:
> [<8010d1ec>] (dump_backtrace) from [<8010d588>] (show_stack+0x20/0x24)
>  r7:8015ed78 r6:00000009 r5:00000000 r4:9f4d9b14
> [<8010d568>] (show_stack) from [<8077e3f0>] (dump_stack+0x24/0x28)
> [<8077e3cc>] (dump_stack) from [<801197a0>] (__warn.part.3+0xcc/0xe4)
> [<801196d4>] (__warn.part.3) from [<80119830>] (warn_slowpath_fmt+0x78/0x94)
>  r6:00000070 r5:808e540c r4:81c03048
> [<801197bc>] (warn_slowpath_fmt) from [<8015ed78>] (dma_common_free_remap+0x88/0x8c)
>  r3:9ef82980 r2:808e53e0
>  r7:00001000 r6:a0b1e000 r5:a0b1e000 r4:00001000
> [<8015ecf0>] (dma_common_free_remap) from [<8010fa9c>] (remap_allocator_free+0x60/0x68)
>  r5:81c03048 r4:9f4d9b78
> [<8010fa3c>] (remap_allocator_free) from [<801100d0>] (__arm_dma_free.constprop.3+0xf8/0x148)
>  r5:81c03048 r4:9ef82900
> [<8010ffd8>] (__arm_dma_free.constprop.3) from [<80110144>] (arm_dma_free+0x24/0x2c)
>  r5:9f563410 r4:80110120
> [<80110120>] (arm_dma_free) from [<8015d80c>] (dma_free_attrs+0xa0/0xdc)
> [<8015d76c>] (dma_free_attrs) from [<8020f3e4>] (dma_pool_destroy+0xc0/0x154)
>  r8:9efa8860 r7:808f02f0 r6:808f02d0 r5:9ef82880 r4:9ef82780
> [<8020f324>] (dma_pool_destroy) from [<805525d0>] (ehci_mem_cleanup+0x6c/0x150)
>  r7:9f563410 r6:9efa8810 r5:00000000 r4:9efd0148
> [<80552564>] (ehci_mem_cleanup) from [<80558e0c>] (ehci_stop+0xac/0xc0)
>  r5:9efd0148 r4:9efd0000
> [<80558d60>] (ehci_stop) from [<8053c4bc>] (usb_remove_hcd+0xf4/0x1b0)
>  r7:9f563410 r6:9efd0074 r5:81c03048 r4:9efd0000
> [<8053c3c8>] (usb_remove_hcd) from [<8056361c>] (host_stop+0x48/0xb8)
>  r7:9f563410 r6:9efd0000 r5:9f5f4040 r4:9f5f5040
> [<805635d4>] (host_stop) from [<80563d0c>] (ci_hdrc_host_destroy+0x34/0x38)
>  r7:9f563410 r6:9f5f5040 r5:9efa8800 r4:9f5f4040
> [<80563cd8>] (ci_hdrc_host_destroy) from [<8055ef18>] (ci_hdrc_remove+0x50/0x10c)
> [<8055eec8>] (ci_hdrc_remove) from [<804a2ed8>] (platform_drv_remove+0x34/0x4c)
>  r7:9f563410 r6:81c4f99c r5:9efa8810 r4:9efa8810
> [<804a2ea4>] (platform_drv_remove) from [<804a18a8>] (device_release_driver_internal+0xec/0x19c)
>  r5:00000000 r4:9efa8810
> [<804a17bc>] (device_release_driver_internal) from [<804a1978>] (device_release_driver+0x20/0x24)
>  r7:9f563410 r6:81c41ed0 r5:9efa8810 r4:9f4a1dac
> [<804a1958>] (device_release_driver) from [<804a01b8>] (bus_remove_device+0xdc/0x108)
> [<804a00dc>] (bus_remove_device) from [<8049c204>] (device_del+0x150/0x36c)
>  r7:9f563410 r6:81c03048 r5:9efa8854 r4:9efa8810
> [<8049c0b4>] (device_del) from [<804a3368>] (platform_device_del.part.2+0x20/0x84)
>  r10:9f563414 r9:809177e0 r8:81cb07dc r7:81c78320 r6:9f563454 r5:9efa8800
>  r4:9efa8800
> [<804a3348>] (platform_device_del.part.2) from [<804a3420>] (platform_device_unregister+0x28/0x34)
>  r5:9f563400 r4:9efa8800
> [<804a33f8>] (platform_device_unregister) from [<8055dce0>] (ci_hdrc_remove_device+0x1c/0x30)
>  r5:9f563400 r4:00000001
> [<8055dcc4>] (ci_hdrc_remove_device) from [<805652ac>] (ci_hdrc_imx_remove+0x38/0x118)
>  r7:81c78320 r6:9f563454 r5:9f563410 r4:9f541010
> [<8056538c>] (ci_hdrc_imx_shutdown) from [<804a2970>] (platform_drv_shutdown+0x2c/0x30)
> [<804a2944>] (platform_drv_shutdown) from [<8049e4fc>] (device_shutdown+0x158/0x1f0)
> [<8049e3a4>] (device_shutdown) from [<8013ac80>] (kernel_restart_prepare+0x44/0x48)
>  r10:00000058 r9:9f4d8000 r8:fee1dead r7:379ce700 r6:81c0b280 r5:81c03048
>  r4:00000000
> [<8013ac3c>] (kernel_restart_prepare) from [<8013ad14>] (kernel_restart+0x1c/0x60)
> [<8013acf8>] (kernel_restart) from [<8013af84>] (__do_sys_reboot+0xe0/0x1d8)
>  r5:81c03048 r4:00000000
> [<8013aea4>] (__do_sys_reboot) from [<8013b0ec>] (sys_reboot+0x18/0x1c)
>  r8:80101204 r7:00000058 r6:00000000 r5:00000000 r4:00000000
> [<8013b0d4>] (sys_reboot) from [<80101000>] (ret_fast_syscall+0x0/0x54)
> Exception stack(0x9f4d9fa8 to 0x9f4d9ff0)
> 9fa0:                   00000000 00000000 fee1dead 28121969 01234567 379ce700
> 9fc0: 00000000 00000000 00000000 00000058 00000000 00000000 00000000 00016d04
> 9fe0: 00028e0c 7ec87c64 000135ec 76c1f410
>
> Restore original invalid input check in dma_common_free_remap() to
> avoid this problem.
>
> Fixes: 5cf4537975bb ("dma-mapping: introduce a dma_common_find_pages helper")
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> [hch: just revert the offending hunk instead of creating a new helper]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
