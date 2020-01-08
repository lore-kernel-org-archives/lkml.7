Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB20C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B752070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="DA+TRyMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgAHOUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:20:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42443 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbgAHOUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:20:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id q6so3532033wro.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 06:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UNEVB0IbcLubIcT7KASuWF617xfGG+pPUETe7tDmmuw=;
        b=DA+TRyMm0KdyEb4fLOrfBWsgpvoL9TKJ1ThoqOWM7OQfVXExWS+/gOgbfXHahqt6q1
         X85IAnRmo2S5bYVvTUuHZ8wAp+QDmzCq8ratpkKSHB5M5D5GHsHsqoGjefsavgROKxuN
         WYJEF1M1kKCTBNCL9tsnEINUDkTZqS924W1hit7XVaq3Ns7r80bW0XbYzeNOBC7XzAS6
         kyVBoGSyFDoCvxcLaTrhXo/IfzGMLG5Kj1tof0/dWr7bcCMTSKcbEZ/Kxch7tAoFPGmE
         zZ55UebtQ6ByOXs9BSgpp4+rThqUVl+YMAhlMogp6uzYoLLUVtrOXMIfw7pNBcVnyIWa
         l1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UNEVB0IbcLubIcT7KASuWF617xfGG+pPUETe7tDmmuw=;
        b=ICDMdlhPNfZY8Q3NuMDK3GUT4beeXX1ZBy7Hfyw+19NHpQh95oXwuUjlZw4CzCXjDO
         Br/1f/Dq3zxwaKRg2rFiPMwoX7sL1RDoE+FpiVKijzPdOa3CK9o3dEfAy/vdG7nYgqUB
         Xe5oZ1OsQ0WQjfUp/LF3hxIsddXEvs6fDMazo2GfGrqvDiFJHHu/EHRXTNMGaguXCf+a
         ZRMEHcNtctKkCTypCNOekGpfKmFUw16bA81h5+VA7fh1AtCnvhYudrsDRbNm1oM5epgm
         4+v8zYVAQfPKQ0nMohmDfPGrC9W7rpoRtSni6qHI6zeCjPXnFVCxby3+NdIm+WtWnv7E
         +Gsg==
X-Gm-Message-State: APjAAAXvTjTqFnXSuxOvjFTHK2rwNhfR1m3RLHxd1iMMr4FQSRAsDuII
        SKjXhaa9UFZlZvGCMBbGpE4DPRXL/6VVhnd9Eepk/P6M4mw=
X-Google-Smtp-Source: APXvYqw0BEmAIR/kDvuo7EWWRYEiMT/Z/muqEccIZHzlByYud6Aq2jOCKpVAw8xwH84vX/zCIW/OP+bEQWBlmZuGz7U=
X-Received: by 2002:a5d:44cd:: with SMTP id z13mr4943064wrr.104.1578493235547;
 Wed, 08 Jan 2020 06:20:35 -0800 (PST)
MIME-Version: 1.0
References: <20f6ae784e058aaa136a61456fe4784330255ce5.1571828230.git.michal.simek@xilinx.com>
In-Reply-To: <20f6ae784e058aaa136a61456fe4784330255ce5.1571828230.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Wed, 8 Jan 2020 15:20:24 +0100
Message-ID: <CAHTX3dLpGhOxxX1++GKq-U1Emd01R=iuqm9uMgicjmEhjRg-3Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: zynq: use physical cpuid in zynq_slcr_cpu_stop/start
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>,
        Quanyang Wang <quanyang.wang@windriver.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

st 23. 10. 2019 v 12:57 odes=C3=ADlatel Michal Simek
<michal.simek@xilinx.com> napsal:
>
> From: Quanyang Wang <quanyang.wang@windriver.com>
>
> When kernel booting, it will create a cpuid map between the logical cpus
> and physical cpus. In a normal boot, the cpuid map is as below:
>
>     Physical      Logical
>         0    =3D=3D>     0
>         1    =3D=3D>     1
>
> But in kdump, there is a condition that the crash happens at the
> physical cpu1, and the crash kernel will run at the physical cpu1 too,
> so the cpuid map in crash kernel is as below:
>
>     Physical      Logical
>         1    =3D=3D>     0
>         0    =3D=3D>     1
>
> The functions zynq_slcr_cpu_stop/start is to stop/start the physical
> cpus, the parameter cpu should be the physical cpuid. So use
> cpu_logical_map to translate the logical cpuid to physical cpuid.
> Or else the logical cpu0(physical cpu1) will stop itself and
> the processor will hang.
>
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  arch/arm/mach-zynq/platsmp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
> index a10085be9073..68ec303fa278 100644
> --- a/arch/arm/mach-zynq/platsmp.c
> +++ b/arch/arm/mach-zynq/platsmp.c
> @@ -15,6 +15,7 @@
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <asm/cacheflush.h>
> +#include <asm/smp_plat.h>
>  #include <asm/smp_scu.h>
>  #include <linux/irqchip/arm-gic.h>
>  #include "common.h"
> @@ -30,6 +31,7 @@ int zynq_cpun_start(u32 address, int cpu)
>  {
>         u32 trampoline_code_size =3D &zynq_secondary_trampoline_end -
>                                                 &zynq_secondary_trampolin=
e;
> +       u32 phy_cpuid =3D cpu_logical_map(cpu);
>
>         /* MS: Expectation that SLCR are directly map and accessible */
>         /* Not possible to jump to non aligned address */
> @@ -39,7 +41,7 @@ int zynq_cpun_start(u32 address, int cpu)
>                 u32 trampoline_size =3D &zynq_secondary_trampoline_jump -
>                                                 &zynq_secondary_trampolin=
e;
>
> -               zynq_slcr_cpu_stop(cpu);
> +               zynq_slcr_cpu_stop(phy_cpuid);
>                 if (address) {
>                         if (__pa(PAGE_OFFSET)) {
>                                 zero =3D ioremap(0, trampoline_code_size)=
;
> @@ -68,7 +70,7 @@ int zynq_cpun_start(u32 address, int cpu)
>                         if (__pa(PAGE_OFFSET))
>                                 iounmap(zero);
>                 }
> -               zynq_slcr_cpu_start(cpu);
> +               zynq_slcr_cpu_start(phy_cpuid);
>
>                 return 0;
>         }
> --
> 2.17.1
>

Tested-by: Michal Simek <michal.simek@xilinx.com>

Applied,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
