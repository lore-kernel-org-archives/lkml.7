Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BC6C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84722133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h37PF+Vg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfDKNqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:46:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35929 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfDKNqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:46:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck15so3453529plb.3;
        Thu, 11 Apr 2019 06:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vm32vj1HgoKA9BYsxMA8gbsyYNvDg1BH08AEDNZDYDQ=;
        b=h37PF+VgrXurm/pt2cyUEpVmJ8ivOOLN7VIKx5hQND4gTHXSFsCAjgxOMuA8dOpSQQ
         /kltBDbtzxPUtUjfdnphIDBnO8WenQ1hh2VFWlYJwuoiAFeTAMylwir1aVFIZBEfe9NF
         kohvC83nObbkYeHOBd9l842WCsLjBgwFAR+0Ce+s2dsD5GllEtv3c2plXkFBR2xc4oU8
         4Ri0JO06Kf03tdPX53v6jQG3EprhD40ChD9Lai5qK/lhji4H2a+8vBGw/hVIJT1bvy3U
         GXbk4ihKTN4R+4aZzCZey6qRgaBPNca5Fl8xASWybm1V+PddccaleiJYzwuNmeMHEzjO
         LkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vm32vj1HgoKA9BYsxMA8gbsyYNvDg1BH08AEDNZDYDQ=;
        b=o3SbmDAd1sSy61fdYDbIQYLMg5SDC3QV47TwQlUq6XnFZmbvTmarRGfMg5ICsOcTpG
         2UHMqt9OKrVH2MzxbO0AGAQhsTBpnoXjs+XFBNGlqxyCk8w4mO2ItxC3xb/RpuT8htbf
         H2i75MduOx+/ib9MaQp4q9q2DjlYrfkL1MZOky6tV3dAwLIp6+KUz62gY5gUwfTDmyb7
         5I6JeGRS0i9gjgdVwnCXYK87B6x5QzKpbF8N+ywhOzzKiF9sJ8oihM7nMotZZe9grkf2
         mCbx7WkV3P7RYxGT7nj0r3l4UbreX/lZoI3/Pk36nRr6srFHilbLEmhpS5m3JJBYBi5+
         VMPA==
X-Gm-Message-State: APjAAAUBzoJ8Ngds8KYEYoVyRw/aJ+8fxUPu0hk6s2Rf/t28Y8ZAsoWZ
        c6Znkfwrut3Xgd0dy51Svo9Xn2vHdC8rwpav0vY=
X-Google-Smtp-Source: APXvYqyR6+nrI7i5dm/rBW97CWzeFiPHHLOR8lVYdaSNV3PIyeS+oqT0LErdrbZn/KxzQAP2ngQI3xBQi2guvOYjbK0=
X-Received: by 2002:a17:902:2d01:: with SMTP id o1mr50831703plb.155.1554990394411;
 Thu, 11 Apr 2019 06:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190411003738.55073-1-rajatja@google.com>
 <20190411003738.55073-3-rajatja@google.com>
In-Reply-To: <20190411003738.55073-3-rajatja@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 Apr 2019 16:46:23 +0300
Message-ID: <CAHp75VeSUVzzcRRsrDKg6KnTXptB5_fgQUk_jYiFwziimS8D2A@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] platform/x86: intel_pmc_core: Instantiate pmc_core
 device on legacy platforms
To:     Rajat Jain <rajatja@google.com>
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Furquan Shaikh <furquan@google.com>,
        Evan Green <evgreen@google.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 3:38 AM Rajat Jain <rajatja@google.com> wrote:
>
> Add code to instantiate the pmc_core platform device and thus attach to
> the driver, if the ACPI device for the same ("INT33A1") is not present
> in a system where it should be. This was discussed here:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1966991.html
>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v5: Remove the gerrit id from commit log
> v4: Rename file, remove dummy arg, 1 conditional per if statement,
>     simplify init / exit calls..
> v3: (first version of *this* patch -to go with rest of v3 patchset)
> v2: (does not exist)
> v1: (does not exist)
>
>  drivers/platform/x86/Makefile                 |  2 +-
>  .../platform/x86/intel_pmc_core_plat_drv.c    | 60 +++++++++++++++++++
>  2 files changed, 61 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/platform/x86/intel_pmc_core_plat_drv.c
>
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 86cb76677bc8..7041a88c34c7 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -89,7 +89,7 @@ obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)    += intel_bxtwc_tmu.o
>  obj-$(CONFIG_INTEL_TELEMETRY)  += intel_telemetry_core.o \
>                                    intel_telemetry_pltdrv.o \
>                                    intel_telemetry_debugfs.o
> -obj-$(CONFIG_INTEL_PMC_CORE)    += intel_pmc_core.o
> +obj-$(CONFIG_INTEL_PMC_CORE)    += intel_pmc_core.o intel_pmc_core_plat_drv.o
>  obj-$(CONFIG_PMC_ATOM)         += pmc_atom.o
>  obj-$(CONFIG_MLX_PLATFORM)     += mlx-platform.o
>  obj-$(CONFIG_INTEL_TURBO_MAX_3) += intel_turbo_max_3.o
> diff --git a/drivers/platform/x86/intel_pmc_core_plat_drv.c b/drivers/platform/x86/intel_pmc_core_plat_drv.c
> new file mode 100644
> index 000000000000..7f5af5bd7f1f
> --- /dev/null
> +++ b/drivers/platform/x86/intel_pmc_core_plat_drv.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Intel PMC Core platform init
> + * Copyright (c) 2019, Google Inc.
> + * Author - Rajat Jain
> + *
> + * This code instantiates platform devices for intel_pmc_core driver, only
> + * on supported platforms that may not have the ACPI devices in the ACPI tables.
> + * No new platforms should be added here, because we expect that new platforms
> + * should all have the ACPI device, which is the preferred way of enumeration.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/cpu_device_id.h>
> +#include <asm/intel-family.h>
> +
> +static struct platform_device pmc_core_device = {
> +       .name = "pmc_core",

This name is too generic. Better to use the current module name, i.e.
"intel_pmc_core".

However, see my comment to the first patch in the series.

> +};
> +
> +/*
> + * intel_pmc_core_platform_ids is the list of platforms where we want to
> + * instantiate the platform_device if not already instantiated. This is
> + * different than intel_pmc_core_ids in intel_pmc_core.c which is the
> + * list of platforms that the driver supports for pmc_core device. The
> + * other list may grow, but this list should not.
> + */
> +static const struct x86_cpu_id intel_pmc_core_platform_ids[] = {
> +       INTEL_CPU_FAM6(SKYLAKE_MOBILE, pmc_core_device),
> +       INTEL_CPU_FAM6(SKYLAKE_DESKTOP, pmc_core_device),
> +       INTEL_CPU_FAM6(KABYLAKE_MOBILE, pmc_core_device),
> +       INTEL_CPU_FAM6(KABYLAKE_DESKTOP, pmc_core_device),
> +       INTEL_CPU_FAM6(CANNONLAKE_MOBILE, pmc_core_device),
> +       INTEL_CPU_FAM6(ICELAKE_MOBILE, pmc_core_device),
> +       {}
> +};
> +MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_platform_ids);
> +
> +static int __init pmc_core_platform_init(void)
> +{
> +       /* Skip creating the platform device if ACPI already has a device */
> +       if (acpi_dev_present("INT33A1", NULL, -1))
> +               return -ENODEV;
> +
> +       if (!x86_match_cpu(intel_pmc_core_platform_ids))
> +               return -ENODEV;
> +
> +       return platform_device_register(&pmc_core_device);
> +}
> +
> +static void __exit pmc_core_platform_exit(void)
> +{
> +       platform_device_unregister(&pmc_core_device);
> +}
> +
> +module_init(pmc_core_platform_init);
> +module_exit(pmc_core_platform_exit);
> --
> 2.21.0.392.gf8f6787159e-goog
>


-- 
With Best Regards,
Andy Shevchenko
