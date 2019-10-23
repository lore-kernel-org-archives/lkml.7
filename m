Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1812CCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CDC20650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571831750;
	bh=DkaAPeQW7827D92+5dmhOvyTj/GtNDU7gEZ+ZZgFI7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sfavnVMWcUdTo/XodjZ4FG8q7v3sBY/14x7t+egfv8iXgC0gJAoFS2sMr6oZfrafg
	 2657mYn3kLzVGMaoMuRbJQfOVZEGeN+31kkpAeTg4zfDx10ekeEnbVHKDDafDcAYAm
	 KUTF8ClHajT08AuLm1yIZXmvldJ2+q1Lx2vbbVFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405147AbfJWLzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:55:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46780 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732092AbfJWLzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:55:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id r18so15495124eds.13;
        Wed, 23 Oct 2019 04:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t9yscY3cldReUeJnGTW1RuCGAW8E5UxWLhXTLgxX2Pg=;
        b=YCV0MfC3ngG8SFQmqgV96kDnKQds/7d0aB5eqI+WCfojF7kFT42H8RNY2GPr7QUoyT
         uOxGnoK6EwYkRHPofG6BNB5Ar8AR6OD4KMgKKFCPS43K95rEfx13NvDLKZRjCA+fl8gQ
         7cshf5qGXjSULXsuoAb3JRy5aRQE7Rhu+8J9ZKWDbUSJ4PT3VCTQlfq+p0qo5wufPkFi
         ap2p7W+jeazngbvhjbeDnTqa9WIePF+JRFTEbkNMYjVQqkO4AlJezGAFVNyKARU57GbL
         jAm+yVbaGPj7SG/2Zkb9BKu6xwTBob6fh34J1vYFhhxHwNvmrEfqC0+LkLtP/KhDrJr7
         mwHQ==
X-Gm-Message-State: APjAAAX+6IayxiAB5kuZfin1o2cGK7LIxMLi9IuIqMMUdxiigo5U8Ky0
        ab0OoKA91By9afDt+5nAAc0=
X-Google-Smtp-Source: APXvYqzi1/P+yOkEAwDoVvDt7dUkhBcKlph4r7Zctm4hUQ1hmtjEFKeIxqu34Clpk7LZPVIlV8IEnQ==
X-Received: by 2002:a50:91f6:: with SMTP id h51mr8123336eda.99.1571831746966;
        Wed, 23 Oct 2019 04:55:46 -0700 (PDT)
Received: from pi3 ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id i5sm739109edv.29.2019.10.23.04.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 04:55:46 -0700 (PDT)
Date:   Wed, 23 Oct 2019 13:55:44 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/36] ARM: s5pv210: use private pm save/restore
Message-ID: <20191023115544.GA11048@pi3>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-10-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191010203043.1241612-10-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 10:29:54PM +0200, Arnd Bergmann wrote:
> The pm save/restore code is fairly small, so in order to
> separate the s3c and s5p platforms, adding an s5p specific
> copy instead of sharing it is actually easier.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-s5pv210/Makefile     |  7 -----
>  arch/arm/mach-s5pv210/pm.c         | 45 ++++++++++++++++++++++++++++--
>  arch/arm/mach-s5pv210/regs-clock.h |  2 +-
>  arch/arm/mach-s5pv210/s5pv210.c    |  2 --
>  arch/arm/plat-samsung/Makefile     |  4 +--
>  5 files changed, 45 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
> index e7b551e18e5c..aa0a1f091daf 100644
> --- a/arch/arm/mach-s5pv210/Makefile
> +++ b/arch/arm/mach-s5pv210/Makefile
> @@ -3,12 +3,5 @@
>  # Copyright (c) 2010 Samsung Electronics Co., Ltd.
>  # 		http://www.samsung.com/
>  
> -ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/arch/arm/plat-samsung/include
> -
> -# Core
> -
>  obj-$(CONFIG_PM_SLEEP)		+= pm.o sleep.o
> -
> -# machine support
> -
>  obj-y				+= s5pv210.o
> diff --git a/arch/arm/mach-s5pv210/pm.c b/arch/arm/mach-s5pv210/pm.c
> index efdb5a27c060..d59c094cdea8 100644
> --- a/arch/arm/mach-s5pv210/pm.c
> +++ b/arch/arm/mach-s5pv210/pm.c
> @@ -13,15 +13,56 @@
>  #include <linux/suspend.h>
>  #include <linux/syscore_ops.h>
>  #include <linux/io.h>
> +#include <linux/soc/samsung/s3c-pm.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/suspend.h>
>  
> -#include <plat/pm-common.h>
> -
>  #include "common.h"
>  #include "regs-clock.h"
>  
> +/* helper functions to save and restore register state */
> +struct sleep_save {
> +	void __iomem	*reg;
> +	unsigned long	val;
> +};
> +
> +#define SAVE_ITEM(x) \
> +	{ .reg = (x) }
> +
> +/**
> + * s3c_pm_do_save() - save a set of registers for restoration on resume.
> + * @ptr: Pointer to an array of registers.
> + * @count: Size of the ptr array.
> + *
> + * Run through the list of registers given, saving their contents in the
> + * array for later restoration when we wakeup.
> + */
> +static void s3c_pm_do_save(struct sleep_save *ptr, int count)
> +{
> +	for (; count > 0; count--, ptr++) {
> +		ptr->val = readl_relaxed(ptr->reg);
> +		S3C_PMDBG("saved %p value %08lx\n", ptr->reg, ptr->val);
> +	}
> +}
> +
> +/**
> + * s3c_pm_do_restore() - restore register values from the save list.
> + * @ptr: Pointer to an array of registers.
> + * @count: Size of the ptr array.
> + *
> + * Restore the register values saved from s3c_pm_do_save().
> + *
> + * WARNING: Do not put any debug in here that may effect memory or use
> + * peripherals, as things may be changing!
> +*/
> +
> +static void s3c_pm_do_restore_core(const struct sleep_save *ptr, int count)
> +{
> +	for (; count > 0; count--, ptr++)
> +		writel_relaxed(ptr->val, ptr->reg);
> +}
> +
>  static struct sleep_save s5pv210_core_save[] = {
>  	/* Clock ETC */
>  	SAVE_ITEM(S5P_MDNIE_SEL),
> diff --git a/arch/arm/mach-s5pv210/regs-clock.h b/arch/arm/mach-s5pv210/regs-clock.h
> index 2a35c831a9b0..8c7530614e37 100644
> --- a/arch/arm/mach-s5pv210/regs-clock.h
> +++ b/arch/arm/mach-s5pv210/regs-clock.h
> @@ -9,7 +9,7 @@
>  #ifndef __ASM_ARCH_REGS_CLOCK_H
>  #define __ASM_ARCH_REGS_CLOCK_H __FILE__
>  
> -#include <plat/map-base.h>
> +#define S3C_VA_SYS		((void __iomem __force *)0xF6100000)

The same as for one of earlier patches - I prefer to keep the S3C_ADDR()
macro for consistency.

>  
>  #define S5P_CLKREG(x)		(S3C_VA_SYS + (x))
>  
> diff --git a/arch/arm/mach-s5pv210/s5pv210.c b/arch/arm/mach-s5pv210/s5pv210.c
> index 868f9c20419d..a21ed3bb992a 100644
> --- a/arch/arm/mach-s5pv210/s5pv210.c
> +++ b/arch/arm/mach-s5pv210/s5pv210.c
> @@ -13,8 +13,6 @@
>  #include <asm/mach/map.h>
>  #include <asm/system_misc.h>
>  
> -#include <plat/map-base.h>
> -
>  #include "common.h"
>  #include "regs-clock.h"
>  
> diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
> index d88b9b84f3a9..025ce22876c1 100644
> --- a/arch/arm/plat-samsung/Makefile
> +++ b/arch/arm/plat-samsung/Makefile
> @@ -24,9 +24,7 @@ obj-$(CONFIG_GPIO_SAMSUNG)     += gpio-samsung.o
>  
>  # PM support
>  
> -obj-$(CONFIG_PM_SLEEP)		+= pm-common.o
> -obj-$(CONFIG_EXYNOS_CPU_SUSPEND) += pm-common.o

CONFIG_EXYNOS_CPU_SUSPEND looks unrelated and seems to be not needed at
all. Can you remove it in separate patch?

Best regards,
Krzysztof


> -obj-$(CONFIG_SAMSUNG_PM)	+= pm.o
> +obj-$(CONFIG_SAMSUNG_PM)	+= pm.o pm-common.o
>  obj-$(CONFIG_SAMSUNG_PM_GPIO)	+= pm-gpio.o
>  
>  obj-$(CONFIG_SAMSUNG_WAKEMASK)	+= wakeup-mask.o
> -- 
> 2.20.0
> 
