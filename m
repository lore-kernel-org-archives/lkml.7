Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17FEC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FDF20870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbfIEIbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 04:31:18 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38316 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfIEIbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 04:31:18 -0400
Received: by mail-qk1-f194.google.com with SMTP id x5so1317186qkh.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 01:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HfKuAxk9/bRoioSR+a2a8fhqX2PF1AL0BOFS3W9OiGc=;
        b=TYlMCHyNppXd/fmqOeDLNbnmaWov9AS4NpfzVVy+GxmOpswB4PIM+mKVKGz77kmaXM
         btNKqrVZsVDAtuxlKVXVkI2bMorvsyrlG8vYEABMyHg08sN/Tmfui7w3t2m1vGzTNC6g
         WUj4r06jM0tUM34wtpl+5OUpxNpTzLw0mU8VC1Rim8M1JvfI06csLKPcAJS7dsIQQTX+
         u/3X+XVASIKiN5IDjdSLUG+Mhi6cz8KXi6rI0I9i/Rs/EAbE3CNMrkQkrIoxPJxGvx4b
         mw7weezLQepE4mCE7ycqcFEg9ndABysecXHMGNcJTAGciwyt9Afm0ODt/Tc2DSkSfneq
         VLLg==
X-Gm-Message-State: APjAAAXUwV9mIA6fx5v82pDMDVMPbaQTc8MHRsBeKB0es09klELfrYl1
        viOlJATcIzwJ5hP/vbvaw4E2veBklXBegdvk9Lo=
X-Google-Smtp-Source: APXvYqwJP0cESRmEZHpkjp58dScikbAuglfHxNNCW2CGpnwyPfyt43xGIybh72k+p4oPPZxz8/N0O2S7OWaot+tNSmQ=
X-Received: by 2002:a37:4051:: with SMTP id n78mr1599585qka.138.1567672276936;
 Thu, 05 Sep 2019 01:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190905054647.1235-1-james.tai@realtek.com>
In-Reply-To: <20190905054647.1235-1-james.tai@realtek.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 5 Sep 2019 10:31:00 +0200
Message-ID: <CAK8P3a13=VBZnj6E=s7mZk0o7Q3XkMHgcsL12s-3psuOWsfOtQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: Add support for Realtek SOC
To:     jamestai.sky@gmail.com
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nico@fluxnic.net>,
        Thierry Reding <treding@nvidia.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Rob Herring <robh@kernel.org>, CY_Huang <cy.huang@realtek.com>,
        Phinex Hung <phinex@realtek.com>,
        "james.tai" <james.tai@realtek.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 7:48 AM <jamestai.sky@gmail.com> wrote:
>
> From: "james.tai" <james.tai@realtek.com>
>
> This patch adds the basic machine file for
> the Realtek RTD16XX platform.
>
> Signed-off-by: james.tai <james.tai@realtek.com>

Hi James,

Thanks a lot for your submission! I'm glad to see interest in upstream
support for this SoC family. I have a few small comments on
details, mostly where I would either like to see an explanation
in the patch description, or things that looks like they can be
left out from the patch.

> index 33b00579beff..c7c9a3662eb7 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -836,6 +836,8 @@ source "arch/arm/mach-zx/Kconfig"
>
>  source "arch/arm/mach-zynq/Kconfig"
>
> +source "arch/arm/mach-realtek/Kconfig"
> +
> diff --git a/arch/arm/mach-realtek/Kconfig b/arch/arm/mach-realtek/Kconfig
> @@ -225,6 +226,7 @@ machine-$(CONFIG_ARCH_VT8500)               += vt8500
>  machine-$(CONFIG_ARCH_W90X900)         += w90x900
>  machine-$(CONFIG_ARCH_ZX)              += zx
>  machine-$(CONFIG_ARCH_ZYNQ)            += zynq
> +machine-$(CONFIG_ARCH_REALTEK)         += realtek
>  machine-$(CONFIG_PLAT_SPEAR)           += spear
>
>  # Platform directory name.  This list is sorted alphanumerically

Please keep these lists in alphabetical order.

>  # ARMv7-M architecture
>  config ARCH_EFM32
>         bool "Energy Micro efm32"
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index c3624ca6c0bc..1f0926449d47 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -148,6 +148,7 @@ endif
>  textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
>  textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
>  textofs-$(CONFIG_ARCH_MESON) := 0x00208000
> +textofs-$(CONFIG_ARCH_REALTEK) := 0x00208000
>  textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000

Can you explain why this is needed for your platform?

>  # Machine directory name.  This list is sorted alphanumerically
> new file mode 100644
> index 000000000000..a8269964dbdb
> --- /dev/null
> +++ b/arch/arm/mach-realtek/Kconfig
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menuconfig ARCH_REALTEK
> +       bool "Realtek SoCs"

Please add "depends on ARCH_MULTI_V7" to avoid
compile time issues when selecting it on an earlier
architecture.

> +       select ARM_GLOBAL_TIMER
> +       select CLKDEV_LOOKUP
> +       select HAVE_SMP
> +       select HAVE_MACH_CLKDEV
> +       select GENERIC_CLOCKEVENTS
> +       select HAVE_SCHED_CLOCK
> +       select ARCH_HAS_CPUFREQ
> +       select CLKSRC_OF
> +       select ARCH_REQUIRE_GPIOLIB
> +       select GENERIC_IRQ_CHIP
> +       select IRQ_DOMAIN
> +       select PINCTRL
> +       select COMMON_CLK
> +       select ARCH_HAS_BARRIERS
> +       select SPARSE_IRQ
> +       select PM_OPP
> +       select ARM_HAS_SG_CHAIN
> +       select ARM_PATCH_PHYS_VIRT
> +       select AUTO_ZRELADDR
> +       select MIGHT_HAVE_PCI
> +       select MULTI_IRQ_HANDLER
> +       select PCI_DOMAINS if PCI
> +       select USE_OF

Almost all of the symbols above are implied by
ARCH_MULTI_V7 and should not be selected
separately.

> +config ARCH_RTD16XX
> +       bool "Enable support for RTD1619"
> +       depends on ARCH_REALTEK
> +       select ARM_GIC_V3
> +       select ARM_PSCI

As I understand, this chip uses a Cortex-A55. What is the reason
for adding support only to the 32-bit ARM architecture rather than
64-bit?

Most 64-bit SoCs are only supported with arch/arm64, but generally
speaking that is not a requirement. My rule of thumb is that on
systems with 1GB of RAM or more, one would want to run a 64-bit
kernel, while systems with less than that are better off with a 32-bit
one, but that is clearly not the only reason for picking one over the
other.

> +
> +static int rtk_boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> +       unsigned long entry_pa = __pa_symbol(secondary_startup);
> +
> +       writel_relaxed(entry_pa | (cpu << CPUID), cpu_release_virt);
> +
> +       arch_send_wakeup_ipi_mask(cpumask_of(cpu));
> +
> +       return 0;
> +}

It's very unusual to see custom smp operations on an ARMv8
system, as we normally use PSCI here. Can you explain what
is going on here? Are you able to use a boot wrapper that implements
these in psci instead?
> +
> +#include "platsmp.h"
> +
> +#define RBUS_BASE_PHYS (0x98000000)
> +#define RBUS_BASE_VIRT (0xfe000000)
> +#define RBUS_BASE_SIZE (0x00100000)
> +
> +static struct map_desc rtk_io_desc[] __initdata = {
> +       {
> +               .virtual = (unsigned long) IOMEM(RBUS_BASE_VIRT),
> +               .pfn = __phys_to_pfn(RBUS_BASE_PHYS),
> +               .length = RBUS_BASE_SIZE,
> +               .type = MT_DEVICE,
> +       },
> +};

This needs a comment: Why do you require a static mapping for
"RBUS_BASE_PHYS"? Normally device drivers should just use
ioremap() for mapping whichever registers they want to access.

> +static void __init rtk_dt_init(void)
> +{
> +       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}

This should be taken care of by the
of_platform_default_populate_init() and can be dropped.

> +static void __init rtk_timer_init(void)
> +{
> +#ifdef CONFIG_COMMON_CLK
> +       of_clk_init(NULL);
> +#endif

COMMON_CLK is implied by ARCH_MULTI_V7, so the
#ifdef can be dropped.

> +       timer_probe();
> +       tick_setup_hrtimer_broadcast();
> +}

What do you need tick_setup_hrtimer_broadcast() for? I don't
see any other platform calling this.

> +bool __init rtk_smp_init_ops(void)
> +{
> +       smp_set_ops(smp_ops(rtk_smp_ops));
> +
> +       return true;
> +}

I think this can also be dropped, as you set the smp_ops in the
machine descriptor.


       Arnd
