Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87844CA9ED4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 01:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5475D217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 01:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572915862;
	bh=sTcBCA8l2RZxRpdS9VTLmDe7MskoQYokwGOaXyovaL0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HnXfPoiGrG8yamE39xBvOMWjbPDih/zFF4FO30e8RlCz9EkP0NCrnDin0duHP35SH
	 ttTDq70H1q92TIyKvl6LB5O1/wBgJw+QVNIKm2YoIAJvLXZrneh7KmnGriLqUCWwy2
	 b2OmVd40Dx20Q/kV3BbsCp5liHyMYQHkhMPu85C8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbfKEBEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 20:04:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728602AbfKEBEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 20:04:21 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7ACB21882;
        Tue,  5 Nov 2019 01:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572915860;
        bh=sTcBCA8l2RZxRpdS9VTLmDe7MskoQYokwGOaXyovaL0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SEBWjM+2C7C+IcNnpZxGZfG9B2EaB1eSzHoQ6F4AHHiw7rFMeAukOWRRIbLk7Buxd
         M8jOUKACjHyvm1xZxB+aM2PzpGfOwuCSQn3SszWspFcSDzBeUiCxV/M48Gg6Y60cos
         55l1rgdjNrkh4pK/dr0GP8NZzO8ffSU1uKHuSusI=
Received: by mail-qk1-f173.google.com with SMTP id q70so19574251qke.12;
        Mon, 04 Nov 2019 17:04:19 -0800 (PST)
X-Gm-Message-State: APjAAAXk+wV9P65rm7MrioIlxwI275iXW/s8PROzEVWVYj1ELg1lEuHb
        5KFlyUkvmFv0TtZKBB1roOsJCDKrJAHZY4s0Og==
X-Google-Smtp-Source: APXvYqwsMu703NinjvwjbQZjTIbHvV30WH6ox/R/wnr91ZuuYkfPj8qqz/+pre0d3AXOsSI7kgSuVkXvG0Sts88cEm4=
X-Received: by 2002:a37:f703:: with SMTP id q3mr25759531qkj.254.1572915858826;
 Mon, 04 Nov 2019 17:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20191101081148.23274-1-yamada.masahiro@socionext.com> <20191101081148.23274-3-yamada.masahiro@socionext.com>
In-Reply-To: <20191101081148.23274-3-yamada.masahiro@socionext.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 4 Nov 2019 19:04:07 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+_vKmhVacTnt7fXJFsFGkg0AopdiZ4XaQ3V4M=zhn_CA@mail.gmail.com>
Message-ID: <CAL_Jsq+_vKmhVacTnt7fXJFsFGkg0AopdiZ4XaQ3V4M=zhn_CA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ARM: decompressor: simplify libfdt builds
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Russell King <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 3:12 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Copying source files during the build time may not end up with
> as clean code as you expect.
>
> lib/fdt*.c simply wrap scripts/dtc/libfdt/fdt*.c, and it works
> nicely. Let's follow that approach for the arm decompressor, too.
>
> Add four wrappers, arch/arm/boot/compressed/fdt*.c and remove the
> Makefile messes.
>
> Another nice thing is we no longer need to maintain the separate
> libfdt_env.h since we can include <linux/libfdt_env.h>, and the
> diff stat also looks nice.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2: None
>
>  arch/arm/boot/compressed/.gitignore     |  9 -------
>  arch/arm/boot/compressed/Makefile       | 33 +++++++------------------
>  arch/arm/boot/compressed/atags_to_fdt.c |  1 +
>  arch/arm/boot/compressed/fdt.c          |  2 ++
>  arch/arm/boot/compressed/fdt_ro.c       |  2 ++
>  arch/arm/boot/compressed/fdt_rw.c       |  2 ++
>  arch/arm/boot/compressed/fdt_wip.c      |  2 ++
>  arch/arm/boot/compressed/libfdt_env.h   | 22 -----------------
>  8 files changed, 18 insertions(+), 55 deletions(-)
>  create mode 100644 arch/arm/boot/compressed/fdt.c
>  create mode 100644 arch/arm/boot/compressed/fdt_ro.c
>  create mode 100644 arch/arm/boot/compressed/fdt_rw.c
>  create mode 100644 arch/arm/boot/compressed/fdt_wip.c
>  delete mode 100644 arch/arm/boot/compressed/libfdt_env.h

Looks fine to me other than my question on licensing on patch 1.

Who did you want to take the series? I can take it with Russell's ack.

One other side comment below.

> diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compressed/.gitignore
> index 86b2f5d28240..2fdb4885846b 100644
> --- a/arch/arm/boot/compressed/.gitignore
> +++ b/arch/arm/boot/compressed/.gitignore
> @@ -6,12 +6,3 @@ hyp-stub.S
>  piggy_data
>  vmlinux
>  vmlinux.lds
> -
> -# borrowed libfdt files
> -fdt.c
> -fdt.h
> -fdt_ro.c
> -fdt_rw.c
> -fdt_wip.c
> -libfdt.h
> -libfdt_internal.h
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 9219389bbe61..a0d645c66980 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -76,29 +76,23 @@ compress-$(CONFIG_KERNEL_LZMA) = lzma
>  compress-$(CONFIG_KERNEL_XZ)   = xzkern
>  compress-$(CONFIG_KERNEL_LZ4)  = lz4
>
> -# Borrowed libfdt files for the ATAG compatibility mode
> -
> -libfdt         := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c
> -libfdt_hdrs    := fdt.h libfdt.h libfdt_internal.h
> -
> -libfdt_objs    := $(addsuffix .o, $(basename $(libfdt)))
> -
> -$(addprefix $(obj)/,$(libfdt) $(libfdt_hdrs)): $(obj)/%: $(srctree)/scripts/dtc/libfdt/%
> -       $(call cmd,shipped)
> +ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
> +libfdt_objs = fdt_rw.o fdt_ro.o fdt_wip.o fdt.o atags_to_fdt.o
>
> -$(addprefix $(obj)/,$(libfdt_objs) atags_to_fdt.o): \
> -       $(addprefix $(obj)/,$(libfdt_hdrs))
> +OBJS   += $(libfdt_objs)

Seems like this file could benefit from doing 'OBJS-$(CONFIG_*)' style
variables.

> -ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
> -OBJS   += $(libfdt_objs) atags_to_fdt.o
> +# -fstack-protector-strong triggers protection checks in this code,
> +# but it is being used too early to link to meaningful stack_chk logic.
> +nossp_flags := $(call cc-option, -fno-stack-protector)
> +$(foreach o, $(libfdt_objs), \
> +       $(eval CFLAGS_$(o) := -I $(srctree)/scripts/dtc/libfdt) $(nossp_flags))
>  endif
>
>  targets       := vmlinux vmlinux.lds piggy_data piggy.o \
>                  lib1funcs.o ashldi3.o bswapsdi2.o \
>                  head.o $(OBJS)
>
> -clean-files += piggy_data lib1funcs.S ashldi3.S bswapsdi2.S \
> -               $(libfdt) $(libfdt_hdrs) hyp-stub.S
> +clean-files += piggy_data lib1funcs.S ashldi3.S bswapsdi2.S hyp-stub.S
>
>  KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
>  KBUILD_CFLAGS += $(DISABLE_ARM_SSP_PER_TASK_PLUGIN)
> @@ -108,15 +102,6 @@ ORIG_CFLAGS := $(KBUILD_CFLAGS)
>  KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
>  endif
>
> -# -fstack-protector-strong triggers protection checks in this code,
> -# but it is being used too early to link to meaningful stack_chk logic.
> -nossp_flags := $(call cc-option, -fno-stack-protector)
> -CFLAGS_atags_to_fdt.o := $(nossp_flags)
> -CFLAGS_fdt.o := $(nossp_flags)
> -CFLAGS_fdt_ro.o := $(nossp_flags)
> -CFLAGS_fdt_rw.o := $(nossp_flags)
> -CFLAGS_fdt_wip.o := $(nossp_flags)
> -
>  ccflags-y := -fpic $(call cc-option,-mno-single-pic-base,) -fno-builtin -I$(obj)
>  asflags-y := -DZIMAGE
>
> diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
> index 330cd3c2eae5..53a60ba066a1 100644
> --- a/arch/arm/boot/compressed/atags_to_fdt.c
> +++ b/arch/arm/boot/compressed/atags_to_fdt.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <linux/libfdt_env.h>
>  #include <asm/setup.h>
>  #include <libfdt.h>
>
> diff --git a/arch/arm/boot/compressed/fdt.c b/arch/arm/boot/compressed/fdt.c
> new file mode 100644
> index 000000000000..f8ea7a201ab1
> --- /dev/null
> +++ b/arch/arm/boot/compressed/fdt.c
> @@ -0,0 +1,2 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include "../../../../lib/fdt.c"
> diff --git a/arch/arm/boot/compressed/fdt_ro.c b/arch/arm/boot/compressed/fdt_ro.c
> new file mode 100644
> index 000000000000..93970a4ad5ae
> --- /dev/null
> +++ b/arch/arm/boot/compressed/fdt_ro.c
> @@ -0,0 +1,2 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include "../../../../lib/fdt_ro.c"
> diff --git a/arch/arm/boot/compressed/fdt_rw.c b/arch/arm/boot/compressed/fdt_rw.c
> new file mode 100644
> index 000000000000..f7c6b8b7e01c
> --- /dev/null
> +++ b/arch/arm/boot/compressed/fdt_rw.c
> @@ -0,0 +1,2 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include "../../../../lib/fdt_rw.c"
> diff --git a/arch/arm/boot/compressed/fdt_wip.c b/arch/arm/boot/compressed/fdt_wip.c
> new file mode 100644
> index 000000000000..048d2c7a088d
> --- /dev/null
> +++ b/arch/arm/boot/compressed/fdt_wip.c
> @@ -0,0 +1,2 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include "../../../../lib/fdt_wip.c"
> diff --git a/arch/arm/boot/compressed/libfdt_env.h b/arch/arm/boot/compressed/libfdt_env.h
> deleted file mode 100644
> index b36c0289a308..000000000000
> --- a/arch/arm/boot/compressed/libfdt_env.h
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ARM_LIBFDT_ENV_H
> -#define _ARM_LIBFDT_ENV_H
> -
> -#include <linux/types.h>
> -#include <linux/string.h>
> -#include <asm/byteorder.h>
> -
> -#define INT_MAX                        ((int)(~0U>>1))
> -
> -typedef __be16 fdt16_t;
> -typedef __be32 fdt32_t;
> -typedef __be64 fdt64_t;
> -
> -#define fdt16_to_cpu(x)                be16_to_cpu(x)
> -#define cpu_to_fdt16(x)                cpu_to_be16(x)
> -#define fdt32_to_cpu(x)                be32_to_cpu(x)
> -#define cpu_to_fdt32(x)                cpu_to_be32(x)
> -#define fdt64_to_cpu(x)                be64_to_cpu(x)
> -#define cpu_to_fdt64(x)                cpu_to_be64(x)
> -
> -#endif
> --
> 2.17.1
>
