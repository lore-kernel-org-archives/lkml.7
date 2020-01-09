Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED03CC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6E92077C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgAILoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 06:44:00 -0500
Received: from mga01.intel.com ([192.55.52.88]:56409 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbgAILn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:43:59 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 03:43:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,413,1571727600"; 
   d="scan'208";a="303846467"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 09 Jan 2020 03:43:54 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipWEE-0007dA-4u; Thu, 09 Jan 2020 13:43:54 +0200
Date:   Thu, 9 Jan 2020 13:43:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 34/36] platform/x86: intel_pmc_ipc: Convert to MFD
Message-ID: <20200109114354.GP32742@smile.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-35-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108114201.27908-35-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:41:59PM +0300, Mika Westerberg wrote:
> This driver only creates a bunch of platform devices sharing resources
> belonging to the PMC device. This is pretty much what MFD subsystem is
> for so move the driver there, renaming it to intel_pmc_bxt.c which
> should be more clear what it is.
> 
> MFD subsystem provides nice helper APIs for subdevice creation so
> convert the driver to use those. Unfortunately the ACPI device includes
> separate resources for most of the subdevices so we cannot simply call
> mfd_add_devices() to create all of them but instead we need to call it
> separately for each device.

Comments below, after addressing,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/mfd/Kconfig                           |  14 +-
>  drivers/mfd/Makefile                          |   1 +
>  .../intel_pmc_ipc.c => mfd/intel_pmc_bxt.c}   | 394 +++++++-----------
>  drivers/platform/x86/Kconfig                  |  16 +-
>  drivers/platform/x86/Makefile                 |   1 -
>  .../platform/x86/intel_telemetry_debugfs.c    |   2 +-
>  drivers/usb/typec/tcpm/Kconfig                |   2 +-
>  .../linux/mfd/intel_pmc_bxt.h                 |  11 +-
>  8 files changed, 171 insertions(+), 270 deletions(-)
>  rename drivers/{platform/x86/intel_pmc_ipc.c => mfd/intel_pmc_bxt.c} (50%)
>  rename arch/x86/include/asm/intel_pmc_ipc.h => include/linux/mfd/intel_pmc_bxt.h (83%)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 59515142438e..04542feffe25 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -551,7 +551,7 @@ config INTEL_SOC_PMIC
>  
>  config INTEL_SOC_PMIC_BXTWC
>  	tristate "Support for Intel Broxton Whiskey Cove PMIC"
> -	depends on INTEL_PMC_IPC
> +	depends on MFD_INTEL_PMC_BXT
>  	select MFD_CORE
>  	select REGMAP_IRQ
>  	help
> @@ -632,6 +632,18 @@ config MFD_INTEL_MSIC
>  	  Passage) chip. This chip embeds audio, battery, GPIO, etc.
>  	  devices used in Intel Medfield platforms.
>  
> +config MFD_INTEL_PMC_BXT
> +	tristate "Intel PMC Driver for Broxton"

> +	depends on X86 && X86_PLATFORM_DEVICES && ACPI

Is the X86_PLATFORM_DEVICES dependency compulsory?
Quick grep shows that none of drivers (except nouveau) relies on it.

For the rest two I think we might split one per line to be consistent with
existing example(s) in  drivers/mfd/Kconfig.

> +	select INTEL_SCU_IPC
> +	select MFD_CORE
> +	help
> +	  This driver provides support for PMC (Power Management
> +	  Controller) on Intel Broxton and Apollo Lake. PMC is a
> +	  multi-function device that exposes IPC, General Control
> +	  Register and P-unit access. In addition this creates devices
> +	  for iTCO watchdog and telemetry that are part of the PMC.
> +
>  config MFD_IPAQ_MICRO
>  	bool "Atmel Micro ASIC (iPAQ h3100/h3600/h3700) Support"
>  	depends on SA1100_H3100 || SA1100_H3600
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index aed99f08739f..34563a6a047b 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -211,6 +211,7 @@ obj-$(CONFIG_MFD_INTEL_LPSS)	+= intel-lpss.o
>  obj-$(CONFIG_MFD_INTEL_LPSS_PCI)	+= intel-lpss-pci.o
>  obj-$(CONFIG_MFD_INTEL_LPSS_ACPI)	+= intel-lpss-acpi.o
>  obj-$(CONFIG_MFD_INTEL_MSIC)	+= intel_msic.o
> +obj-$(CONFIG_MFD_INTEL_PMC_BXT)	+= intel_pmc_bxt.o
>  obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
>  obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
>  obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
> diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/mfd/intel_pmc_bxt.c
> similarity index 50%
> rename from drivers/platform/x86/intel_pmc_ipc.c
> rename to drivers/mfd/intel_pmc_bxt.c
> index 20a4bb72aeac..76f166c1455b 100644
> --- a/drivers/platform/x86/intel_pmc_ipc.c
> +++ b/drivers/mfd/intel_pmc_bxt.c
> @@ -1,8 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Driver for the Intel PMC IPC mechanism
> + * Driver for the Intel Broxton PMC
>   *
> - * (C) Copyright 2014-2015 Intel Corporation
> + * (C) Copyright 2014-2015, 2020 Intel Corporation
>   *
>   * This driver is based on Intel SCU IPC driver(intel_scu_ipc.c) by
>   *     Sreedhara DS <sreedhara.ds@intel.com>
> @@ -16,10 +16,11 @@
>  #include <linux/errno.h>
>  #include <linux/interrupt.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/intel_pmc_bxt.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  
> -#include <asm/intel_pmc_ipc.h>
>  #include <asm/intel_scu_ipc.h>
>  
>  #include <linux/platform_data/itco_wdt.h>
> @@ -62,8 +63,6 @@
>  #define TELEM_SSRAM_SIZE		240
>  #define TELEM_PMC_SSRAM_OFFSET		0x1B00
>  #define TELEM_PUNIT_SSRAM_OFFSET	0x1A00
> -#define TCO_PMC_OFFSET			0x08
> -#define TCO_PMC_SIZE			0x04
>  
>  /* PMC register bit definitions */
>  
> @@ -72,40 +71,32 @@
>  #define PMC_CFG_NO_REBOOT_EN		(1 << 4)
>  #define PMC_CFG_NO_REBOOT_DIS		(0 << 4)
>  
> -static struct intel_pmc_ipc_dev {
> +static struct intel_pmc_dev {
>  	struct device *dev;
>  
> -	/* The following PMC BARs share the same ACPI device with the IPC */
> -	resource_size_t acpi_io_base;
> -	int acpi_io_size;
> -	struct platform_device *tco_dev;
> +	/* iTCO */
> +	struct resource tco_res[2];
>  
>  	/* gcr */
>  	void __iomem *gcr_mem_base;
> -	bool has_gcr_regs;
>  	spinlock_t gcr_lock;
>  
>  	/* punit */
> -	struct platform_device *punit_dev;
> +	struct resource punit_res[6];
>  	unsigned int punit_res_count;
>  
>  	/* Telemetry */
> -	resource_size_t telem_pmc_ssram_base;
> -	resource_size_t telem_punit_ssram_base;
> -	int telem_pmc_ssram_size;
> -	int telem_punit_ssram_size;
> -	u8 telem_res_inval;
> -	struct platform_device *telemetry_dev;
> -} ipcdev;
> +	struct resource *telem_base;
> +} pmcdev;
>  
>  static inline u64 gcr_data_readq(u32 offset)
>  {
> -	return readq(ipcdev.gcr_mem_base + offset);
> +	return readq(pmcdev.gcr_mem_base + offset);
>  }
>  
>  static inline int is_gcr_valid(u32 offset)
>  {
> -	if (!ipcdev.has_gcr_regs)
> +	if (!pmcdev.gcr_mem_base)
>  		return -EACCES;
>  
>  	if (offset > PLAT_RESOURCE_GCR_SIZE)
> @@ -127,17 +118,17 @@ int intel_pmc_gcr_read64(u32 offset, u64 *data)
>  {
>  	int ret;
>  
> -	spin_lock(&ipcdev.gcr_lock);
> +	spin_lock(&pmcdev.gcr_lock);
>  
>  	ret = is_gcr_valid(offset);
>  	if (ret < 0) {
> -		spin_unlock(&ipcdev.gcr_lock);
> +		spin_unlock(&pmcdev.gcr_lock);
>  		return ret;
>  	}
>  
> -	*data = readq(ipcdev.gcr_mem_base + offset);
> +	*data = readq(pmcdev.gcr_mem_base + offset);
>  
> -	spin_unlock(&ipcdev.gcr_lock);
> +	spin_unlock(&pmcdev.gcr_lock);
>  
>  	return 0;
>  }
> @@ -159,29 +150,29 @@ static int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val)
>  	u32 new_val;
>  	int ret = 0;
>  
> -	spin_lock(&ipcdev.gcr_lock);
> +	spin_lock(&pmcdev.gcr_lock);
>  
>  	ret = is_gcr_valid(offset);
>  	if (ret < 0)
> -		goto gcr_ipc_unlock;
> +		goto gcr_unlock;
>  
> -	new_val = readl(ipcdev.gcr_mem_base + offset);
> +	new_val = readl(pmcdev.gcr_mem_base + offset);
>  
>  	new_val &= ~mask;
>  	new_val |= val & mask;
>  
> -	writel(new_val, ipcdev.gcr_mem_base + offset);
> +	writel(new_val, pmcdev.gcr_mem_base + offset);
>  
> -	new_val = readl(ipcdev.gcr_mem_base + offset);
> +	new_val = readl(pmcdev.gcr_mem_base + offset);
>  
>  	/* check whether the bit update is successful */
>  	if ((new_val & mask) != (val & mask)) {
>  		ret = -EIO;
> -		goto gcr_ipc_unlock;
> +		goto gcr_unlock;
>  	}
>  
> -gcr_ipc_unlock:
> -	spin_unlock(&ipcdev.gcr_lock);
> +gcr_unlock:
> +	spin_unlock(&pmcdev.gcr_lock);
>  	return ret;
>  }
>  
> @@ -193,9 +184,9 @@ static int update_no_reboot_bit(void *priv, bool set)
>  				    PMC_CFG_NO_REBOOT_MASK, value);
>  }
>  
> -static ssize_t intel_pmc_ipc_simple_cmd_store(struct device *dev,
> -					      struct device_attribute *attr,
> -					      const char *buf, size_t count)
> +static ssize_t intel_pmc_simple_cmd_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf, size_t count)
>  {
>  	struct intel_scu_ipc_dev *scu = dev_get_drvdata(dev);
>  	int subcmd;
> @@ -215,11 +206,11 @@ static ssize_t intel_pmc_ipc_simple_cmd_store(struct device *dev,
>  	}
>  	return (ssize_t)count;
>  }
> -static DEVICE_ATTR(simplecmd, 0200, NULL, intel_pmc_ipc_simple_cmd_store);
> +static DEVICE_ATTR(simplecmd, 0200, NULL, intel_pmc_simple_cmd_store);
>  
> -static ssize_t intel_pmc_ipc_northpeak_store(struct device *dev,
> -					     struct device_attribute *attr,
> -					     const char *buf, size_t count)
> +static ssize_t intel_pmc_northpeak_store(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t count)
>  {
>  	struct intel_scu_ipc_dev *scu = dev_get_drvdata(dev);
>  	unsigned long val;
> @@ -241,264 +232,183 @@ static ssize_t intel_pmc_ipc_northpeak_store(struct device *dev,
>  	}
>  	return (ssize_t)count;
>  }
> -static DEVICE_ATTR(northpeak, 0200, NULL, intel_pmc_ipc_northpeak_store);
> +static DEVICE_ATTR(northpeak, 0200, NULL, intel_pmc_northpeak_store);
>  
> -static struct attribute *intel_ipc_attrs[] = {
> +static struct attribute *intel_pmc_attrs[] = {
>  	&dev_attr_northpeak.attr,
>  	&dev_attr_simplecmd.attr,
>  	NULL
>  };
>  
> -static const struct attribute_group intel_ipc_group = {
> -	.attrs = intel_ipc_attrs,
> +static const struct attribute_group intel_pmc_group = {
> +	.attrs = intel_pmc_attrs,
>  };
>  
> -static struct resource punit_res_array[] = {
> -	/* Punit BIOS */
> -	{
> -		.flags = IORESOURCE_MEM,
> -	},
> -	{
> -		.flags = IORESOURCE_MEM,
> -	},
> -	/* Punit ISP */
> -	{
> -		.flags = IORESOURCE_MEM,
> -	},
> -	{
> -		.flags = IORESOURCE_MEM,
> -	},
> -	/* Punit GTD */
> -	{
> -		.flags = IORESOURCE_MEM,
> -	},
> -	{
> -		.flags = IORESOURCE_MEM,
> -	},
> -};
> -
> -#define TCO_RESOURCE_ACPI_IO		0
> -#define TCO_RESOURCE_SMI_EN_IO		1
> -#define TCO_RESOURCE_GCR_MEM		2
> -static struct resource tco_res[] = {
> -	/* ACPI - TCO */
> -	{
> -		.flags = IORESOURCE_IO,
> -	},
> -	/* ACPI - SMI */
> -	{
> -		.flags = IORESOURCE_IO,
> -	},
> -};
> -
> -static struct itco_wdt_platform_data tco_info = {
> -	.name = "Apollo Lake SoC",
> -	.version = 5,
> -	.no_reboot_priv = &ipcdev,
> -	.update_no_reboot_bit = update_no_reboot_bit,
> -};
> -
> -#define TELEMETRY_RESOURCE_PUNIT_SSRAM	0
> -#define TELEMETRY_RESOURCE_PMC_SSRAM	1
> -static struct resource telemetry_res[] = {
> -	/*Telemetry*/
> -	{
> -		.flags = IORESOURCE_MEM,
> -	},
> -	{
> -		.flags = IORESOURCE_MEM,
> -	},
> -};
> -
> -static int ipc_create_punit_device(void)
> +static int pmc_create_punit_device(void)
>  {
> -	struct platform_device *pdev;
> -	const struct platform_device_info pdevinfo = {
> -		.parent = ipcdev.dev,
> +	struct mfd_cell punit = {
>  		.name = PUNIT_DEVICE_NAME,
> -		.id = -1,
> -		.res = punit_res_array,
> -		.num_res = ipcdev.punit_res_count,
> -		};
> +		.resources = pmcdev.punit_res,
> +		.num_resources = pmcdev.punit_res_count,
> +	};
>  
> -	pdev = platform_device_register_full(&pdevinfo);
> -	if (IS_ERR(pdev))
> -		return PTR_ERR(pdev);
> +	if (!pmcdev.punit_res_count)
> +		return 0;
>  
> -	ipcdev.punit_dev = pdev;
> -
> -	return 0;
> +	return devm_mfd_add_devices(pmcdev.dev, PLATFORM_DEVID_AUTO, &punit, 1,
> +				    NULL, 0, NULL);
>  }
>  
> -static int ipc_create_tco_device(void)
> +static int pmc_create_tco_device(void)
>  {
> -	struct platform_device *pdev;
> -	struct resource *res;
> -	const struct platform_device_info pdevinfo = {
> -		.parent = ipcdev.dev,
> +	struct itco_wdt_platform_data tco_info = {
> +		.name = "Apollo Lake SoC",
> +		.version = 5,
> +		.no_reboot_priv = &pmcdev,
> +		.update_no_reboot_bit = update_no_reboot_bit,
> +	};
> +	struct mfd_cell tco = {
>  		.name = TCO_DEVICE_NAME,
> -		.id = -1,
> -		.res = tco_res,
> -		.num_res = ARRAY_SIZE(tco_res),
> -		.data = &tco_info,
> -		.size_data = sizeof(tco_info),
> -		};
> -
> -	res = tco_res + TCO_RESOURCE_ACPI_IO;
> -	res->start = ipcdev.acpi_io_base + TCO_BASE_OFFSET;
> -	res->end = res->start + TCO_REGS_SIZE - 1;
> -
> -	res = tco_res + TCO_RESOURCE_SMI_EN_IO;
> -	res->start = ipcdev.acpi_io_base + SMI_EN_OFFSET;
> -	res->end = res->start + SMI_EN_SIZE - 1;
> -
> -	pdev = platform_device_register_full(&pdevinfo);
> -	if (IS_ERR(pdev))
> -		return PTR_ERR(pdev);
> -
> -	ipcdev.tco_dev = pdev;
> -
> -	return 0;
> +		.ignore_resource_conflicts = true,
> +		.platform_data = &tco_info,
> +		.pdata_size = sizeof(tco_info),
> +		.resources = pmcdev.tco_res,
> +		.num_resources = ARRAY_SIZE(pmcdev.tco_res),
> +	};
> +
> +	if (!pmcdev.tco_res[0].start)
> +		return 0;
> +
> +	return devm_mfd_add_devices(pmcdev.dev, PLATFORM_DEVID_AUTO, &tco, 1,
> +				    NULL, 0, NULL);
>  }
>  
> -static int ipc_create_telemetry_device(void)
> +static int pmc_create_telemetry_device(void)
>  {
> -	struct platform_device *pdev;
> -	struct resource *res;
> -	const struct platform_device_info pdevinfo = {
> -		.parent = ipcdev.dev,
> +	struct resource telem_res[] = {
> +		DEFINE_RES_MEM(TELEM_PUNIT_SSRAM_OFFSET, TELEM_SSRAM_SIZE),
> +		DEFINE_RES_MEM(TELEM_PMC_SSRAM_OFFSET, TELEM_SSRAM_SIZE),
> +	};
> +	struct mfd_cell telem  = {
>  		.name = TELEMETRY_DEVICE_NAME,
> -		.id = -1,
> -		.res = telemetry_res,
> -		.num_res = ARRAY_SIZE(telemetry_res),
> -		};
> -
> -	res = telemetry_res + TELEMETRY_RESOURCE_PUNIT_SSRAM;
> -	res->start = ipcdev.telem_punit_ssram_base;
> -	res->end = res->start + ipcdev.telem_punit_ssram_size - 1;
> +		.resources = telem_res,
> +		.num_resources = ARRAY_SIZE(telem_res),
> +	};
>  
> -	res = telemetry_res + TELEMETRY_RESOURCE_PMC_SSRAM;
> -	res->start = ipcdev.telem_pmc_ssram_base;
> -	res->end = res->start + ipcdev.telem_pmc_ssram_size - 1;
> +	if (!pmcdev.telem_base)
> +		return 0;
>  
> -	pdev = platform_device_register_full(&pdevinfo);
> -	if (IS_ERR(pdev))
> -		return PTR_ERR(pdev);
> -
> -	ipcdev.telemetry_dev = pdev;
> -
> -	return 0;
> +	return devm_mfd_add_devices(pmcdev.dev, PLATFORM_DEVID_AUTO, &telem, 1,
> +				    pmcdev.telem_base, 0, NULL);
>  }
>  
> -static int ipc_create_pmc_devices(void)
> +static int pmc_create_devices(void)
>  {
>  	int ret;
>  
>  	/* If we have ACPI based watchdog use that instead */
>  	if (!acpi_has_watchdog()) {
> -		ret = ipc_create_tco_device();
> +		ret = pmc_create_tco_device();
>  		if (ret) {
> -			dev_err(ipcdev.dev, "Failed to add tco platform device\n");
> +			dev_err(pmcdev.dev, "Failed to add tco platform device\n");
>  			return ret;
>  		}
>  	}
>  
> -	ret = ipc_create_punit_device();
> +	ret = pmc_create_punit_device();
>  	if (ret) {
> -		dev_err(ipcdev.dev, "Failed to add punit platform device\n");
> -		platform_device_unregister(ipcdev.tco_dev);
> +		dev_err(pmcdev.dev, "Failed to add punit platform device\n");
>  		return ret;
>  	}
>  
> -	if (!ipcdev.telem_res_inval) {
> -		ret = ipc_create_telemetry_device();
> -		if (ret) {
> -			dev_warn(ipcdev.dev,
> -				"Failed to add telemetry platform device\n");
> -			platform_device_unregister(ipcdev.punit_dev);
> -			platform_device_unregister(ipcdev.tco_dev);
> -		}
> -	}
> +	ret = pmc_create_telemetry_device();
> +	if (ret)
> +		dev_warn(pmcdev.dev, "Failed to add telemetry platform device\n");
>  
>  	return ret;
>  }
>  
> -static int ipc_plat_get_res(struct platform_device *pdev,
> +static int pmc_plat_get_res(struct platform_device *pdev,
>  			    struct intel_scu_ipc_pdata *pdata)
>  {
> -	struct resource *res, *punit_res = punit_res_array;
> +	struct resource *res, *punit_res = pmcdev.punit_res;
> +	struct resource *tco_res = pmcdev.tco_res;
>  	void __iomem *addr;
>  	int size;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_IO,
>  				    PLAT_RESOURCE_ACPI_IO_INDEX);
>  	if (!res) {
> -		dev_err(&pdev->dev, "Failed to get io resource\n");
> +		dev_err(&pdev->dev, "Failed to get IO resource\n");
>  		return -ENXIO;
> +
>  	}
> -	size = resource_size(res);
> -	ipcdev.acpi_io_base = res->start;
> -	ipcdev.acpi_io_size = size;
> -	dev_info(&pdev->dev, "io res: %pR\n", res);
> +	tco_res[0].flags = IORESOURCE_IO;
> +	tco_res[0].start = res->start + TCO_BASE_OFFSET;
> +	tco_res[0].end = tco_res[0].start + TCO_REGS_SIZE - 1;
> +	tco_res[1].flags = IORESOURCE_IO;
> +	tco_res[1].start = res->start + SMI_EN_OFFSET;
> +	tco_res[1].end = tco_res[1].start + SMI_EN_SIZE - 1;
> +	dev_dbg(&pdev->dev, "IO: %pR\n", res);
>  
> -	ipcdev.punit_res_count = 0;
> +	pmcdev.punit_res_count = 0;
>  
>  	/* This is index 0 to cover BIOS data register */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM,
>  				    PLAT_RESOURCE_BIOS_DATA_INDEX);
>  	if (!res) {
> -		dev_err(&pdev->dev, "Failed to get res of punit BIOS data\n");
> +		dev_err(&pdev->dev, "Failed to get res of P-unit BIOS data\n");
>  		return -ENXIO;
>  	}
> -	punit_res[ipcdev.punit_res_count++] = *res;
> -	dev_info(&pdev->dev, "punit BIOS data res: %pR\n", res);
> +	punit_res[pmcdev.punit_res_count++] = *res;
> +	dev_dbg(&pdev->dev, "P-unit BIOS data: %pR\n", res);
>  
>  	/* This is index 1 to cover BIOS interface register */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM,
>  				    PLAT_RESOURCE_BIOS_IFACE_INDEX);
>  	if (!res) {
> -		dev_err(&pdev->dev, "Failed to get res of punit BIOS iface\n");
> +		dev_err(&pdev->dev, "Failed to get res of P-unit BIOS iface\n");
>  		return -ENXIO;
>  	}
> -	punit_res[ipcdev.punit_res_count++] = *res;
> -	dev_info(&pdev->dev, "punit BIOS interface res: %pR\n", res);
> +	punit_res[pmcdev.punit_res_count++] = *res;
> +	dev_dbg(&pdev->dev, "P-unit BIOS interface: %pR\n", res);
>  
>  	/* This is index 2 to cover ISP data register, optional */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM,
>  				    PLAT_RESOURCE_ISP_DATA_INDEX);
>  	if (res) {
> -		punit_res[ipcdev.punit_res_count++] = *res;
> -		dev_info(&pdev->dev, "punit ISP data res: %pR\n", res);
> +		punit_res[pmcdev.punit_res_count++] = *res;
> +		dev_dbg(&pdev->dev, "P-unit ISP data: %pR\n", res);
>  	}
>  
>  	/* This is index 3 to cover ISP interface register, optional */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM,
>  				    PLAT_RESOURCE_ISP_IFACE_INDEX);
>  	if (res) {
> -		punit_res[ipcdev.punit_res_count++] = *res;
> -		dev_info(&pdev->dev, "punit ISP interface res: %pR\n", res);
> +		punit_res[pmcdev.punit_res_count++] = *res;
> +		dev_dbg(&pdev->dev, "P-unit ISP interface: %pR\n", res);
>  	}
>  
>  	/* This is index 4 to cover GTD data register, optional */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM,
>  				    PLAT_RESOURCE_GTD_DATA_INDEX);
>  	if (res) {
> -		punit_res[ipcdev.punit_res_count++] = *res;
> -		dev_info(&pdev->dev, "punit GTD data res: %pR\n", res);
> +		punit_res[pmcdev.punit_res_count++] = *res;
> +		dev_dbg(&pdev->dev, "P-unit GTD data: %pR\n", res);
>  	}
>  
>  	/* This is index 5 to cover GTD interface register, optional */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM,
>  				    PLAT_RESOURCE_GTD_IFACE_INDEX);
>  	if (res) {
> -		punit_res[ipcdev.punit_res_count++] = *res;
> -		dev_info(&pdev->dev, "punit GTD interface res: %pR\n", res);
> +		punit_res[pmcdev.punit_res_count++] = *res;
> +		dev_dbg(&pdev->dev, "P-unit GTD interface: %pR\n", res);
>  	}
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM,
>  				    PLAT_RESOURCE_IPC_INDEX);
>  	if (!res) {
> -		dev_err(&pdev->dev, "Failed to get ipc resource\n");
> +		dev_err(&pdev->dev, "Failed to get IPC resource\n");
>  		return -ENXIO;
>  	}
>  	size = PLAT_RESOURCE_IPC_SIZE + PLAT_RESOURCE_GCR_SIZE;
> @@ -510,23 +420,16 @@ static int ipc_plat_get_res(struct platform_device *pdev,
>  
>  	pdata->ipc_regs = addr;
>  
> -	ipcdev.gcr_mem_base = addr + PLAT_RESOURCE_GCR_OFFSET;
> -	dev_info(&pdev->dev, "ipc res: %pR\n", res);
> +	pmcdev.gcr_mem_base = addr + PLAT_RESOURCE_GCR_OFFSET;
> +	dev_dbg(&pdev->dev, "IPC: %pR\n", res);
>  
> -	ipcdev.telem_res_inval = 0;
>  	res = platform_get_resource(pdev, IORESOURCE_MEM,
>  				    PLAT_RESOURCE_TELEM_SSRAM_INDEX);
>  	if (!res) {
> -		dev_err(&pdev->dev, "Failed to get telemetry ssram resource\n");
> -		ipcdev.telem_res_inval = 1;
> +		dev_err(&pdev->dev, "Failed to get telemetry SSRAM resource\n");
>  	} else {
> -		ipcdev.telem_punit_ssram_base = res->start +
> -						TELEM_PUNIT_SSRAM_OFFSET;
> -		ipcdev.telem_punit_ssram_size = TELEM_SSRAM_SIZE;
> -		ipcdev.telem_pmc_ssram_base = res->start +
> -						TELEM_PMC_SSRAM_OFFSET;
> -		ipcdev.telem_pmc_ssram_size = TELEM_SSRAM_SIZE;
> -		dev_info(&pdev->dev, "telemetry ssram res: %pR\n", res);
> +		dev_dbg(&pdev->dev, "Telemetry SSRAM: %pR\n", res);
> +		pmcdev.telem_base = res;
>  	}
>  
>  	return 0;
> @@ -542,7 +445,7 @@ int intel_pmc_s0ix_counter_read(u64 *data)
>  {
>  	u64 deep, shlw;
>  
> -	if (!ipcdev.has_gcr_regs)
> +	if (!pmcdev.gcr_mem_base)
>  		return -EACCES;
>  
>  	deep = gcr_data_readq(PMC_GCR_TELEM_DEEP_S0IX_REG);
> @@ -554,15 +457,13 @@ int intel_pmc_s0ix_counter_read(u64 *data)
>  }
>  EXPORT_SYMBOL_GPL(intel_pmc_s0ix_counter_read);
>  
> -#ifdef CONFIG_ACPI
> -static const struct acpi_device_id ipc_acpi_ids[] = {
> +static const struct acpi_device_id intel_pmc_acpi_ids[] = {
>  	{ "INT34D2", 0},
>  	{ }
>  };
> -MODULE_DEVICE_TABLE(acpi, ipc_acpi_ids);
> -#endif
> +MODULE_DEVICE_TABLE(acpi, intel_pmc_acpi_ids);
>  
> -static int ipc_plat_probe(struct platform_device *pdev)
> +static int intel_pmc_probe(struct platform_device *pdev)
>  {
>  	struct intel_scu_ipc_pdata pdata;
>  	struct intel_scu_ipc_dev *scu;
> @@ -573,10 +474,10 @@ static int ipc_plat_probe(struct platform_device *pdev)
>  	if (pdata.irq < 0)
>  		return -EINVAL;
>  
> -	ipcdev.dev = &pdev->dev;
> -	spin_lock_init(&ipcdev.gcr_lock);
> +	pmcdev.dev = &pdev->dev;
> +	spin_lock_init(&pmcdev.gcr_lock);
>  
> -	ret = ipc_plat_get_res(pdev, &pdata);
> +	ret = pmc_plat_get_res(pdev, &pdata);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to request resource\n");
>  		return ret;
> @@ -588,67 +489,58 @@ static int ipc_plat_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, scu);
>  
> -	ret = ipc_create_pmc_devices();
> +	ret = pmc_create_devices();
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to create pmc devices\n");
>  		goto err_ipc;
>  	}
>  
> -	ret = sysfs_create_group(&pdev->dev.kobj, &intel_ipc_group);
> +	ret = sysfs_create_group(&pdev->dev.kobj, &intel_pmc_group);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to create sysfs group %d\n",
>  			ret);
> -		goto err_devs;
> +		goto err_ipc;
>  	}
>  
> -	ipcdev.has_gcr_regs = true;
> -
>  	return 0;
>  
>  err_ipc:
>  	intel_scu_ipc_remove(scu);
> -err_devs:
> -	platform_device_unregister(ipcdev.tco_dev);
> -	platform_device_unregister(ipcdev.punit_dev);
> -	platform_device_unregister(ipcdev.telemetry_dev);
>  
>  	return ret;
>  }
>  
> -static int ipc_plat_remove(struct platform_device *pdev)
> +static int intel_pmc_remove(struct platform_device *pdev)
>  {
> -	sysfs_remove_group(&pdev->dev.kobj, &intel_ipc_group);
> -	platform_device_unregister(ipcdev.tco_dev);
> -	platform_device_unregister(ipcdev.punit_dev);
> -	platform_device_unregister(ipcdev.telemetry_dev);
> +	sysfs_remove_group(&pdev->dev.kobj, &intel_pmc_group);
>  	intel_scu_ipc_remove(platform_get_drvdata(pdev));
> -	ipcdev.dev = NULL;
> +	pmcdev.dev = NULL;
>  	return 0;
>  }
>  
> -static struct platform_driver ipc_plat_driver = {
> -	.remove = ipc_plat_remove,
> -	.probe = ipc_plat_probe,
> +static struct platform_driver intel_pmc_driver = {
> +	.remove = intel_pmc_remove,
> +	.probe = intel_pmc_probe,
>  	.driver = {
> -		.name = "pmc-ipc-plat",
> -		.acpi_match_table = ACPI_PTR(ipc_acpi_ids),
> +		.name = "intel_pmc_bxt",
> +		.acpi_match_table = ACPI_PTR(intel_pmc_acpi_ids),
>  	},
>  };
>  
> -static int __init intel_pmc_ipc_init(void)
> +static int __init intel_pmc_init(void)
>  {
> -	return platform_driver_register(&ipc_plat_driver);
> +	return platform_driver_register(&intel_pmc_driver);
>  }
>  
> -static void __exit intel_pmc_ipc_exit(void)
> +static void __exit intel_pmc_exit(void)
>  {
> -	platform_driver_unregister(&ipc_plat_driver);
> +	platform_driver_unregister(&intel_pmc_driver);
>  }
>  
>  MODULE_AUTHOR("Zha Qipeng <qipeng.zha@intel.com>");
> -MODULE_DESCRIPTION("Intel PMC IPC driver");
> +MODULE_DESCRIPTION("Intel Broxton PMC driver");
>  MODULE_LICENSE("GPL v2");
>  
>  /* Some modules are dependent on this, so init earlier */
> -fs_initcall(intel_pmc_ipc_init);
> -module_exit(intel_pmc_ipc_exit);
> +fs_initcall(intel_pmc_init);
> +module_exit(intel_pmc_exit);
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 1c5afb9e4965..e01aba797656 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1195,19 +1195,11 @@ config INTEL_SMARTCONNECT
>  	  This driver checks to determine whether the device has Intel Smart
>  	  Connect enabled, and if so disables it.
>  
> -config INTEL_PMC_IPC
> -	tristate "Intel PMC IPC Driver"
> -	depends on ACPI
> -	select INTEL_SCU_IPC
> -	---help---
> -	This driver provides support for PMC control on some Intel platforms.
> -	The PMC is an ARC processor which defines IPC commands for communication
> -	with other entities in the CPU.
> -
>  config INTEL_BXTWC_PMIC_TMU
>  	tristate "Intel BXT Whiskey Cove TMU Driver"
>  	depends on REGMAP
> -	depends on INTEL_SOC_PMIC_BXTWC && INTEL_PMC_IPC
> +	depends on MFD_INTEL_PMC_BXT
> +	depends on INTEL_SOC_PMIC_BXTWC
>  	---help---
>  	  Select this driver to use Intel BXT Whiskey Cove PMIC TMU feature.
>  	  This driver enables the alarm wakeup functionality in the TMU unit
> @@ -1233,7 +1225,9 @@ config INTEL_PUNIT_IPC
>  
>  config INTEL_TELEMETRY
>  	tristate "Intel SoC Telemetry Driver"
> -	depends on INTEL_PMC_IPC && INTEL_PUNIT_IPC && X86_64
> +	depends on X86_64
> +	depends on MFD_INTEL_PMC_BXT
> +	depends on INTEL_PUNIT_IPC
>  	---help---
>  	  This driver provides interfaces to configure and use
>  	  telemetry for INTEL SoC from APL onwards. It is also
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index c7a42feaa521..f1abce3e1720 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -86,7 +86,6 @@ obj-$(CONFIG_INTEL_RST)		+= intel-rst.o
>  obj-$(CONFIG_INTEL_SMARTCONNECT)	+= intel-smartconnect.o
>  
>  obj-$(CONFIG_ALIENWARE_WMI)	+= alienware-wmi.o
> -obj-$(CONFIG_INTEL_PMC_IPC)	+= intel_pmc_ipc.o
>  obj-$(CONFIG_TOUCHSCREEN_DMI)	+= touchscreen_dmi.o
>  obj-$(CONFIG_SURFACE_PRO3_BUTTON)	+= surfacepro3_button.o
>  obj-$(CONFIG_SURFACE_3_BUTTON)	+= surface3_button.o
> diff --git a/drivers/platform/x86/intel_telemetry_debugfs.c b/drivers/platform/x86/intel_telemetry_debugfs.c
> index e84d3e983e0c..7b7a766a6cb8 100644
> --- a/drivers/platform/x86/intel_telemetry_debugfs.c
> +++ b/drivers/platform/x86/intel_telemetry_debugfs.c
> @@ -16,13 +16,13 @@
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
> +#include <linux/mfd/intel_pmc_bxt.h>
>  #include <linux/pci.h>
>  #include <linux/seq_file.h>
>  #include <linux/suspend.h>
>  
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
> -#include <asm/intel_pmc_ipc.h>
>  #include <asm/intel_telemetry.h>
>  
>  #define DRIVER_NAME			"telemetry_soc_debugfs"
> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> index 5b986d6c801d..fa3f39336246 100644
> --- a/drivers/usb/typec/tcpm/Kconfig
> +++ b/drivers/usb/typec/tcpm/Kconfig
> @@ -41,8 +41,8 @@ config TYPEC_FUSB302
>  config TYPEC_WCOVE
>  	tristate "Intel WhiskeyCove PMIC USB Type-C PHY driver"
>  	depends on ACPI
> +	depends on MFD_INTEL_PMC_BXT
>  	depends on INTEL_SOC_PMIC
> -	depends on INTEL_PMC_IPC
>  	depends on BXT_WC_PMIC_OPREGION
>  	help
>  	  This driver adds support for USB Type-C on Intel Broxton platforms
> diff --git a/arch/x86/include/asm/intel_pmc_ipc.h b/include/linux/mfd/intel_pmc_bxt.h
> similarity index 83%
> rename from arch/x86/include/asm/intel_pmc_ipc.h
> rename to include/linux/mfd/intel_pmc_bxt.h
> index 22848df5faaf..f03a80df0728 100644
> --- a/arch/x86/include/asm/intel_pmc_ipc.h
> +++ b/include/linux/mfd/intel_pmc_bxt.h
> @@ -1,6 +1,9 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_X86_INTEL_PMC_IPC_H_
> -#define  _ASM_X86_INTEL_PMC_IPC_H_
> +#ifndef MFD_INTEL_PMC_BXT_H
> +#define MFD_INTEL_PMC_BXT_H
> +
> +#include <linux/errno.h>
> +#include <linux/types.h>
>  
>  /* Commands */
>  #define PMC_IPC_USB_PWR_CTRL		0xF0
> @@ -25,7 +28,7 @@
>  #define PMC_GCR_TELEM_DEEP_S0IX_REG	0x78
>  #define PMC_GCR_TELEM_SHLW_S0IX_REG	0x80
>  
> -#if IS_ENABLED(CONFIG_INTEL_PMC_IPC)
> +#if IS_ENABLED(CONFIG_MFD_INTEL_PMC_BXT)
>  
>  int intel_pmc_s0ix_counter_read(u64 *data);
>  int intel_pmc_gcr_read64(u32 offset, u64 *data);
> @@ -42,6 +45,6 @@ static inline int intel_pmc_gcr_read64(u32 offset, u64 *data)
>  	return -EINVAL;
>  }
>  
> -#endif /*CONFIG_INTEL_PMC_IPC*/
> +#endif /* CONFIG_MFD_INTEL_PMC_BXT */
>  
>  #endif
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


