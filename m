Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCE7C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92742190F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+PBH9ro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKKOG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:06:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46392 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKOG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:06:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id b3so14734913wrs.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 06:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+/Y2KrElV7WuOlbhVtVkPVZzokBiLzkE9XqPZHWAkRo=;
        b=V+PBH9roG+uCAcjxBMg9abG2Rixd7T7rZJTeWi9rlCB3JwgOQW4JDoCm2FnJR/rHCK
         +TvvQeJmjCyuQeWjVuVij10wQ4Wf8Tp5b8DocHurl5bczScO2d+flwcuFF8LkRVSmbnJ
         tNEj3i+Z66lJ/gTERRJTsH80ffpfkkhw56HPEelAat/7df5znfFS7yvmnIF4YUpfrk1E
         hditUWupkBjHbji9Z/fBaHwT5adp89U4Nael8+gfx8p9H22WClNyYhsDp7dP3THgQiFJ
         WqjIg5TLN9F+f6mpS2zVxKnbYrZUJS2Z/9iWC95blO74NM8BpduPtKWwDHzW8quXr92n
         hoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+/Y2KrElV7WuOlbhVtVkPVZzokBiLzkE9XqPZHWAkRo=;
        b=j1M8B8z1RzOnySYBjLVZSpg0xDAUJ9GSUgI4OJnzDalu3+roC1ADEzEpHniYJtm2KJ
         VIhuKyOChwjqjE71tTjeYiAR1sI8GHXYtZgbkFuw+UdO+nHANv/kWeQdtPJwu628NYab
         3TvD7MZLafgtDNAFxL0NHcKOg0aSkLCQoE6RTLd9tiX2Gsxsq7EKJ8mvyA7FeSmt36xT
         ncoR63CRuJG7W/xmPsAAjonOFy7CJAH8ZaZ0OxZUyzewmcFQxwxqKGB7AP7OFgytxkDd
         GL9FtyXcD6WC0Z0LoC6OUFq1b35eIGOKEjidEqx70GJVKl16n4HrQqp/T8kMFjdYFncI
         1qNw==
X-Gm-Message-State: APjAAAVxTkxsxR+V0hmgVxItC+gDOu0UhchhayKVjW92wf2WtOjz1SBC
        wu0kOE+EvikqNOF3VUSOhWMLL+gXkogT8M8Egi5Uv1uc
X-Google-Smtp-Source: APXvYqzJmR6xKNzmrAO5WakZhRYkbTzcJJBSgDfP/W5waJggUNc7WXU+ecqQovItkxBWOSgNvjzjSKKyRU6lPNvOkeQ=
X-Received: by 2002:adf:c641:: with SMTP id u1mr21451436wrg.361.1573481184040;
 Mon, 11 Nov 2019 06:06:24 -0800 (PST)
MIME-Version: 1.0
References: <20191111133421.14390-1-anup.patel@wdc.com> <MN2PR04MB60612DF0F3191A8240F71F458D740@MN2PR04MB6061.namprd04.prod.outlook.com>
In-Reply-To: <MN2PR04MB60612DF0F3191A8240F71F458D740@MN2PR04MB6061.namprd04.prod.outlook.com>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Mon, 11 Nov 2019 16:05:40 +0200
Message-ID: <CAEn-LTpLu0ht=_HpK11Sa=frSvQt_1Nz48M3XZero=CJPidxDg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Enable SYSCON reboot and poweroff drivers
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 3:43 PM Anup Patel <Anup.Patel@wdc.com> wrote:
>
> Correct Palmer's email address
>
> > -----Original Message-----
> > From: Anup Patel
> > Sent: Monday, November 11, 2019 7:05 PM
> > To: Palmer Dabbelt <palmer@sifive.com>; Paul Walmsley
> > <paul.walmsley@sifive.com>
> > Cc: Atish Patra <Atish.Patra@wdc.com>; Alistair Francis
> > <Alistair.Francis@wdc.com>; Christoph Hellwig <hch@lst.de>; Anup Patel
> > <anup@brainfault.org>; linux-riscv@lists.infradead.org; linux-
> > kernel@vger.kernel.org; Anup Patel <Anup.Patel@wdc.com>
> > Subject: [PATCH] RISC-V: Enable SYSCON reboot and poweroff drivers
> >
> > We can use SYSCON reboot and poweroff drivers for the SiFive test device
> > found on QEMU virt machine and SiFive SOCs.
> >
> > This patch enables SYSCON reboot and poweroff drivers in RV64 and RV32
> > defconfigs.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  arch/riscv/configs/defconfig      | 4 ++++
> >  arch/riscv/configs/rv32_defconfig | 4 ++++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> > index 420a0dbef386..73a6ee31a7d2 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -63,6 +63,10 @@ CONFIG_HW_RANDOM_VIRTIO=y  CONFIG_SPI=y
> > CONFIG_SPI_SIFIVE=y  # CONFIG_PTP_1588_CLOCK is not set
> > +CONFIG_POWER_RESET=y

Why not to add

    select POWER_RESET

to arch/riscv/Kconfig ?

This seems to be a popular choice (?). I went this path recently while
enabling gpio-restart on SiFive Unleashed on a private branch.

[..]
arch/arm/mach-exynos/Kconfig:   select POWER_RESET
arch/arm/mach-exynos/Kconfig:   select POWER_RESET_SYSCON
arch/arm/mach-exynos/Kconfig:   select POWER_RESET_SYSCON_POWEROFF
arch/arm/mach-gemini/Kconfig:   select POWER_RESET
arch/arm/mach-gemini/Kconfig:   select POWER_RESET_GEMINI_POWEROFF
arch/arm/mach-gemini/Kconfig:   select POWER_RESET_SYSCON
arch/arm/mach-hisi/Kconfig:     select POWER_RESET
arch/arm/mach-hisi/Kconfig:     select POWER_RESET_HISI
arch/arm/mach-integrator/Kconfig:       select POWER_RESET
arch/arm/mach-integrator/Kconfig:       select POWER_RESET_VERSATILE
arch/arm/mach-realview/Kconfig: select POWER_RESET
arch/arm/mach-realview/Kconfig: select POWER_RESET_VERSATILE
arch/arm/mach-versatile/Kconfig:        select POWER_RESET
arch/arm/mach-versatile/Kconfig:        select POWER_RESET_VERSATILE
arch/arm/mach-vexpress/Kconfig: select POWER_RESET
arch/arm/mach-vexpress/Kconfig: select POWER_RESET_VEXPRESS
arch/arm64/Kconfig:     select POWER_RESET
[..]

> > +CONFIG_POWER_RESET_SYSCON=y
> > +CONFIG_POWER_RESET_SYSCON_POWEROFF=y
> > +CONFIG_SYSCON_REBOOT_MODE=y
> >  CONFIG_DRM=y
> >  CONFIG_DRM_RADEON=y
> >  CONFIG_DRM_VIRTIO_GPU=y
> > diff --git a/arch/riscv/configs/rv32_defconfig
> > b/arch/riscv/configs/rv32_defconfig
> > index 87ee6e62b64b..1429e1254295 100644
> > --- a/arch/riscv/configs/rv32_defconfig
> > +++ b/arch/riscv/configs/rv32_defconfig
> > @@ -61,6 +61,10 @@ CONFIG_VIRTIO_CONSOLE=y
> > CONFIG_HW_RANDOM=y  CONFIG_HW_RANDOM_VIRTIO=y  #
> > CONFIG_PTP_1588_CLOCK is not set
> > +CONFIG_POWER_RESET=y
> > +CONFIG_POWER_RESET_SYSCON=y
> > +CONFIG_POWER_RESET_SYSCON_POWEROFF=y
> > +CONFIG_SYSCON_REBOOT_MODE=y
> >  CONFIG_DRM=y
> >  CONFIG_DRM_RADEON=y
> >  CONFIG_DRM_VIRTIO_GPU=y
> > --
> > 2.17.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
