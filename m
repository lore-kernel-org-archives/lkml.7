Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D4DC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC9C2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfDHSP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:15:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:56333 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbfDHSP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:15:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 11:15:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,326,1549958400"; 
   d="scan'208";a="159317003"
Received: from raj-desk2.iind.intel.com ([10.223.107.30])
  by fmsmga002.fm.intel.com with ESMTP; 08 Apr 2019 11:15:23 -0700
Date:   Mon, 8 Apr 2019 23:32:03 +0530
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wysocki@google.com, Rafael J <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        furquan@google.com, evgreen@google.com, rajatxjain@gmail.com
Subject: Re: [PATCH v3 3/3] platform/x86: intel_pmc_core: Instantiate
 pmc_core device on legacy platforms
Message-ID: <20190408180202.GA769@raj-desk2.iind.intel.com>
References: <20190313222124.229371-1-rajatja@google.com>
 <20190405203558.19160-1-rajatja@google.com>
 <20190405203558.19160-3-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405203558.19160-3-rajatja@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 01:35:58PM -0700, Rajat Jain wrote:
> Add code to instantiate the pmc_core platform device and thus attach to
> the driver, if the ACPI device for the same ("INT33A1") is not present
> in a system where it should be. This was discussed here:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1966991.html
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v3: (first version of *this* patch -to go with rest of v3 patchset)
> v2: (does not exist)
> v1: (does not exist)
> 
>  drivers/platform/x86/Makefile                 |  2 +-
>  .../platform/x86/intel_pmc_core_plat_init.c   | 64 +++++++++++++++++++
>  2 files changed, 65 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/platform/x86/intel_pmc_core_plat_init.c

Can we call this intel_pmc_core_plat_drv.c instead?

> 
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 86cb76677bc8..83d0bb9a14bb 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -89,7 +89,7 @@ obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= intel_bxtwc_tmu.o
>  obj-$(CONFIG_INTEL_TELEMETRY)	+= intel_telemetry_core.o \
>  				   intel_telemetry_pltdrv.o \
>  				   intel_telemetry_debugfs.o
> -obj-$(CONFIG_INTEL_PMC_CORE)    += intel_pmc_core.o
> +obj-$(CONFIG_INTEL_PMC_CORE)    += intel_pmc_core.o intel_pmc_core_plat_init.o

ditto

>  obj-$(CONFIG_PMC_ATOM)		+= pmc_atom.o
>  obj-$(CONFIG_MLX_PLATFORM)	+= mlx-platform.o
>  obj-$(CONFIG_INTEL_TURBO_MAX_3) += intel_turbo_max_3.o
> diff --git a/drivers/platform/x86/intel_pmc_core_plat_init.c b/drivers/platform/x86/intel_pmc_core_plat_init.c
> new file mode 100644
> index 000000000000..45be89e7586c
> --- /dev/null
> +++ b/drivers/platform/x86/intel_pmc_core_plat_init.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Intel PMC Core platform init
> + * Copyright (c) 2019, Google Inc.

I'd like to consult Andy and Darren if we should also have Intel Copyright
too?

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
> +	.name = "pmc_core",
> +};
> +
> +static int dummy;
> +/*
> + * INTEL_CPU_FAM6 macro won't take NULL for driver_data (uses &driver_data),
> + * thus provide a dummy driver_data.
> + */
> +static const struct x86_cpu_id intel_pmc_core_ids[] = {
> +	INTEL_CPU_FAM6(SKYLAKE_MOBILE, dummy),
> +	INTEL_CPU_FAM6(SKYLAKE_DESKTOP, dummy),
> +	INTEL_CPU_FAM6(KABYLAKE_MOBILE, dummy),
> +	INTEL_CPU_FAM6(KABYLAKE_DESKTOP, dummy),
> +	INTEL_CPU_FAM6(CANNONLAKE_MOBILE, dummy),
> +	INTEL_CPU_FAM6(ICELAKE_MOBILE, dummy),
> +	{}
> +};
> +MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_ids);
> +
> +static int __init pmc_core_platform_init(void)
> +{
> +	int ret;
> +
> +	/* Skip creating the platform device if ACPI already has a device */
> +	if (acpi_dev_present("INT33A1", NULL, -1) ||
> +	    !x86_match_cpu(intel_pmc_core_ids))
> +		return -ENODEV;
> +
> +	ret = platform_device_register(&pmc_core_device);
> +	if (ret)
> +		return ret;

we can just return platform_devie_register (...) and avoid extra lines and
variable.

> +
> +	return 0;
> +}
> +
> +static void __exit pmc_core_platform_exit(void)
> +{
> +	if (!acpi_dev_present("INT33A1", NULL, -1) &&
> +	    x86_match_cpu(intel_pmc_core_ids))
> +		platform_device_unregister(&pmc_core_device);
> +}
> +
> +module_init(pmc_core_platform_init);
> +module_exit(pmc_core_platform_exit);
> -- 
> 2.21.0.392.gf8f6787159e-goog
> 

-- 
Best Regards,
Rajneesh
