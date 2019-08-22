Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E7CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611962070B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e15u45Fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394127AbfHVWoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 18:44:04 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42631 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394081AbfHVWn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 18:43:59 -0400
Received: by mail-lf1-f68.google.com with SMTP id s19so5691723lfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 15:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H8l7wiMMUHrZuNeEcqw+cMi/TFoxbqaAZ0zFmrdQUd8=;
        b=e15u45FbA6x5Dg8BFxhCxSv2LU58YacddRWjaMbPYKxjhaDyYi/SqF+VKxPpK+qw3Y
         7PI95YhnxrSaAOEKXgO2G0z5a4w3+6UMO1LnwkwBMHVjVIO35LisV0pWaXOzZxOOE86z
         HfLqp1OaEFkW2olQ6bUpzoI+lvZrZ4403TJTGIxnmCgUA0R9jLd6+S9Cq1vRPOciPcU0
         cazuAXrY5O9xySjFmq590OTmcclySR2NZ1x5rBMOv8ssSmemMH8j1eLwe6qkUmOo1qd7
         3xB+jNokMD8Qt0HE6SFyH1K+PfJw+FI6lvxQtxLiJyyHFaI9sZgiB33rZJ4zVlO8kQrE
         GxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8l7wiMMUHrZuNeEcqw+cMi/TFoxbqaAZ0zFmrdQUd8=;
        b=i3TSfUrCJcs/Q4/QPkv4Tsyl4yRr1tfVamqSAu+Pxg7d2vxCLan7jyOpgGKycmps7u
         Aqs2scjf0V1EncCfKv33Dt4JcbUNWcxdzkCnIHC5lvGJ+VR6BQ9flJyL7p+Xo+h5Ov1e
         ABQhh0L/25IaR2Jkgat4PKpliI6LmoieND+3y1nGnwyyvxZf0elr5jTzJqIX7vgzpSjg
         2ILf4yHv/Ny+LBK6E5xYU8QQA/AZ1E7pxUmehIU566jTljAKJu61LY2z38SpWJNN8dRB
         1UlyvUUDKAYekCfM9CHmXdjRqBBRdvZ+j78EMlpPP91Y1nwYNWWH7AOp8knjypvX7x5d
         9Btg==
X-Gm-Message-State: APjAAAVKBHOfYim+UPh37LSlWL3I+3t9bceziiqMIICbd0sMgKTYshHp
        cWGriRRSbVtjRq6xUzjg7pI7ojeGluyr6L7Yu4iRAA==
X-Google-Smtp-Source: APXvYqxJ3k6D9ZNQsdCbqjzAQc83gIEs28NFrbZn0szD6o/v6a7l4b6EWPCAQkmHgESTvWuHdx+n5rZN62XHk+3PhpA=
X-Received: by 2002:a19:5218:: with SMTP id m24mr822179lfb.164.1566513835919;
 Thu, 22 Aug 2019 15:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Ver=TNKxh8rdJs1xQYSLNsRLfEoFtcGG6hViug=cF6s_g@mail.gmail.com>
 <20190628033413.8058-1-rajatja@google.com>
In-Reply-To: <20190628033413.8058-1-rajatja@google.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 22 Aug 2019 15:43:19 -0700
Message-ID: <CACK8Z6GYwPhz-+7zxxe-aG673Tbin=GYUvVZyL9cTgjqk_EXqA@mail.gmail.com>
Subject: Re: [PATCH v7] platform/x86: intel_pmc_core: Attach using APCI HID "INT33A1"
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Furquan Shaikh <furquan@google.com>,
        Evan Green <evgreen@google.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 8:34 PM Rajat Jain <rajatja@google.com> wrote:
>
> Most modern platforms already have the ACPI device "INT33A1" that could
> be used to attach to the driver. Switch the driver to using that and
> thus make the intel_pmc_core.c a pure platform_driver.
>
> Some of the legacy platforms though, may still not have this ACPI device
> in their ACPI tables. Thus for such platforms, move the code to manually
> instantiate a platform_device into a new file of its own. This would
> instantiate the intel_pmc_core platform device and thus attach to
> the driver, if the ACPI device for the same ("INT33A1") is not present
> in a system where it should be. This was discussed here:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1966991.html


HI Andy, Rajneesh, this seems to have fallen through the cracks. Any
comments here on this patch?

Thanks,

Rajat


>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v7: Include module.h and add MODULE_LICENSE()
> v6: was here: https://patchwork.kernel.org/patch/10906387/
>     (The patchset was accepted, but this particular patch was later
>      dropped becasue it created some warnings in certain kernel
>      configurations: https://www.spinics.net/lists/linux-next/msg47611.html)
>
>  drivers/platform/x86/Makefile                 |  2 +-
>  drivers/platform/x86/intel_pmc_core.c         | 40 +++---------
>  .../platform/x86/intel_pmc_core_plat_drv.c    | 62 +++++++++++++++++++
>  3 files changed, 71 insertions(+), 33 deletions(-)
>  create mode 100644 drivers/platform/x86/intel_pmc_core_plat_drv.c
>
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 87b0069bd781..4ba707111c27 100644
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
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index 1d902230ba61..f20d08ad39ea 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -1023,47 +1023,23 @@ static const struct dev_pm_ops pmc_core_pm_ops = {
>         SET_LATE_SYSTEM_SLEEP_PM_OPS(pmc_core_suspend, pmc_core_resume)
>  };
>
> +static const struct acpi_device_id pmc_core_acpi_ids[] = {
> +       {"INT33A1", 0}, /* _HID for Intel Power Engine, _CID PNP0D80*/
> +       { }
> +};
> +MODULE_DEVICE_TABLE(acpi, pmc_core_acpi_ids);
> +
>  static struct platform_driver pmc_core_driver = {
>         .driver = {
>                 .name = "intel_pmc_core",
> +               .acpi_match_table = ACPI_PTR(pmc_core_acpi_ids),
>                 .pm = &pmc_core_pm_ops,
>         },
>         .probe = pmc_core_probe,
>         .remove = pmc_core_remove,
>  };
>
> -static struct platform_device pmc_core_device = {
> -       .name = "intel_pmc_core",
> -};
> -
> -static int __init pmc_core_init(void)
> -{
> -       int ret;
> -
> -       if (!x86_match_cpu(intel_pmc_core_ids))
> -               return -ENODEV;
> -
> -       ret = platform_driver_register(&pmc_core_driver);
> -       if (ret)
> -               return ret;
> -
> -       ret = platform_device_register(&pmc_core_device);
> -       if (ret) {
> -               platform_driver_unregister(&pmc_core_driver);
> -               return ret;
> -       }
> -
> -       return 0;
> -}
> -
> -static void __exit pmc_core_exit(void)
> -{
> -       platform_device_unregister(&pmc_core_device);
> -       platform_driver_unregister(&pmc_core_driver);
> -}
> -
> -module_init(pmc_core_init)
> -module_exit(pmc_core_exit)
> +module_platform_driver(pmc_core_driver);
>
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("Intel PMC Core Driver");
> diff --git a/drivers/platform/x86/intel_pmc_core_plat_drv.c b/drivers/platform/x86/intel_pmc_core_plat_drv.c
> new file mode 100644
> index 000000000000..a8754a6db1b8
> --- /dev/null
> +++ b/drivers/platform/x86/intel_pmc_core_plat_drv.c
> @@ -0,0 +1,62 @@
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
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/cpu_device_id.h>
> +#include <asm/intel-family.h>
> +
> +static struct platform_device pmc_core_device = {
> +       .name = "intel_pmc_core",
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
> +MODULE_LICENSE("GPL v2");
> --
> 2.22.0.410.gd8fdbe21b5-goog
>
