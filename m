Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215FEC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D791C2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b4sl0Isu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbfDQXGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:06:18 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44356 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387595AbfDQXGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:06:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id h18so63241lfj.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 16:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Av6BO5kPNY5/JBGhmM1xHMRtLVpLz7/E2jXOQUXROk8=;
        b=b4sl0IsuKhivAS7J1xI4ohIKs9/8+5DJYjI7sIs1E7ph76hR0vpiZpoGyVzeLSU0NW
         s9vho0l12NJdFeaJdsGcApYNvlCeOtqDUYZuK9IDwVW3nHF2aU33/IRFklQwO/iwuK0V
         IEdx1EJE8LF2D37SAZCvu2UDE7TXKm06Nw3UC2zukxa2sF6kNBER806WfkmyTxWz6gI3
         uqvjpcbvOMoKQNtMQ9Kn/CopqE0FUFICmYyrkofXQK2NRDeSk/tl3apOa/CpF+z/Jfs+
         V4CvnHcSvKdjSvvnQsvmQ3RlYE0JpIpUDlhGhgE4lDEkRwE0zX7IF4hn4/CG8192uUyD
         xHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Av6BO5kPNY5/JBGhmM1xHMRtLVpLz7/E2jXOQUXROk8=;
        b=ZibFGnIMxufbBEcIO32EoN59EQMCsdkBEEL7hWBvWd4ShAKTx+tmipZMz1RIQBExkY
         2lEvhA1+VS/KEEHIOg3/IvEUYmMyCgIJUCHbM/BuPiqhfY92Gr8nznmFP8D71i4AeHHT
         OimB/c97tMfqQeAzLcKxkQf+GgA1fU61emP2m3HlFjk4IFkN944Yhh7ZAPPLdxCU5mz2
         7U9EndrJRIke+FFET5O17G+tGx1viM/PZNK3dSe1DjfwM24nsiDxFsnAf5YKjN289GD5
         hFYtVHI5u+mo24e4R+FoAqCJXkpljBMv8ezfE5mZOX0uBogFaUhQpj19Rw0NPAsoO46E
         DB8w==
X-Gm-Message-State: APjAAAVouphVpKJJnsi/ENBgz47fWIhC9Yn4QIxqlfI0ufmmBchigX89
        Lg5uPLOoooPEfuA7Zu2qIpJDkI+/HAjWsLoxGO3xKA==
X-Google-Smtp-Source: APXvYqyBcA1SQNuzniGpr8RZ8W8bQ6t96xdiUObkxDl3/OKz10V3RlcQHYFMh0UDMBw2MABeLsU4ovPe8fV5sGKo3Wo=
X-Received: by 2002:ac2:48bb:: with SMTP id u27mr1645558lfg.17.1555542374577;
 Wed, 17 Apr 2019 16:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190411003738.55073-1-rajatja@google.com>
 <20190411003738.55073-3-rajatja@google.com> <CAHp75VeSUVzzcRRsrDKg6KnTXptB5_fgQUk_jYiFwziimS8D2A@mail.gmail.com>
In-Reply-To: <CAHp75VeSUVzzcRRsrDKg6KnTXptB5_fgQUk_jYiFwziimS8D2A@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 17 Apr 2019 16:05:37 -0700
Message-ID: <CACK8Z6EjGSCapBARvPPXuLg-iQ24oKhWpqLskzwV1w6VFhJAWQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] platform/x86: intel_pmc_core: Instantiate pmc_core
 device on legacy platforms
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Thu, Apr 11, 2019 at 6:46 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Apr 11, 2019 at 3:38 AM Rajat Jain <rajatja@google.com> wrote:
> >
> > Add code to instantiate the pmc_core platform device and thus attach to
> > the driver, if the ACPI device for the same ("INT33A1") is not present
> > in a system where it should be. This was discussed here:
> > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1966991.html
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > v5: Remove the gerrit id from commit log
> > v4: Rename file, remove dummy arg, 1 conditional per if statement,
> >     simplify init / exit calls..
> > v3: (first version of *this* patch -to go with rest of v3 patchset)
> > v2: (does not exist)
> > v1: (does not exist)
> >
> >  drivers/platform/x86/Makefile                 |  2 +-
> >  .../platform/x86/intel_pmc_core_plat_drv.c    | 60 +++++++++++++++++++
> >  2 files changed, 61 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/platform/x86/intel_pmc_core_plat_drv.c
> >
> > diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> > index 86cb76677bc8..7041a88c34c7 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -89,7 +89,7 @@ obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)    += intel_bxtwc_tmu.o
> >  obj-$(CONFIG_INTEL_TELEMETRY)  += intel_telemetry_core.o \
> >                                    intel_telemetry_pltdrv.o \
> >                                    intel_telemetry_debugfs.o
> > -obj-$(CONFIG_INTEL_PMC_CORE)    += intel_pmc_core.o
> > +obj-$(CONFIG_INTEL_PMC_CORE)    += intel_pmc_core.o intel_pmc_core_plat_drv.o
> >  obj-$(CONFIG_PMC_ATOM)         += pmc_atom.o
> >  obj-$(CONFIG_MLX_PLATFORM)     += mlx-platform.o
> >  obj-$(CONFIG_INTEL_TURBO_MAX_3) += intel_turbo_max_3.o
> > diff --git a/drivers/platform/x86/intel_pmc_core_plat_drv.c b/drivers/platform/x86/intel_pmc_core_plat_drv.c
> > new file mode 100644
> > index 000000000000..7f5af5bd7f1f
> > --- /dev/null
> > +++ b/drivers/platform/x86/intel_pmc_core_plat_drv.c
> > @@ -0,0 +1,60 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Intel PMC Core platform init
> > + * Copyright (c) 2019, Google Inc.
> > + * Author - Rajat Jain
> > + *
> > + * This code instantiates platform devices for intel_pmc_core driver, only
> > + * on supported platforms that may not have the ACPI devices in the ACPI tables.
> > + * No new platforms should be added here, because we expect that new platforms
> > + * should all have the ACPI device, which is the preferred way of enumeration.
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <asm/cpu_device_id.h>
> > +#include <asm/intel-family.h>
> > +
> > +static struct platform_device pmc_core_device = {
> > +       .name = "pmc_core",
>
> This name is too generic. Better to use the current module name, i.e.
> "intel_pmc_core".

done


>
> However, see my comment to the first patch in the series.
>
> > +};
> > +
> > +/*
> > + * intel_pmc_core_platform_ids is the list of platforms where we want to
> > + * instantiate the platform_device if not already instantiated. This is
> > + * different than intel_pmc_core_ids in intel_pmc_core.c which is the
> > + * list of platforms that the driver supports for pmc_core device. The
> > + * other list may grow, but this list should not.
> > + */
> > +static const struct x86_cpu_id intel_pmc_core_platform_ids[] = {
> > +       INTEL_CPU_FAM6(SKYLAKE_MOBILE, pmc_core_device),
> > +       INTEL_CPU_FAM6(SKYLAKE_DESKTOP, pmc_core_device),
> > +       INTEL_CPU_FAM6(KABYLAKE_MOBILE, pmc_core_device),
> > +       INTEL_CPU_FAM6(KABYLAKE_DESKTOP, pmc_core_device),
> > +       INTEL_CPU_FAM6(CANNONLAKE_MOBILE, pmc_core_device),
> > +       INTEL_CPU_FAM6(ICELAKE_MOBILE, pmc_core_device),
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_platform_ids);
> > +
> > +static int __init pmc_core_platform_init(void)
> > +{
> > +       /* Skip creating the platform device if ACPI already has a device */
> > +       if (acpi_dev_present("INT33A1", NULL, -1))
> > +               return -ENODEV;
> > +
> > +       if (!x86_match_cpu(intel_pmc_core_platform_ids))
> > +               return -ENODEV;
> > +
> > +       return platform_device_register(&pmc_core_device);
> > +}
> > +
> > +static void __exit pmc_core_platform_exit(void)
> > +{
> > +       platform_device_unregister(&pmc_core_device);
> > +}
> > +
> > +module_init(pmc_core_platform_init);
> > +module_exit(pmc_core_platform_exit);
> > --
> > 2.21.0.392.gf8f6787159e-goog
> >
>
>
> --
> With Best Regards,
> Andy Shevchenko
