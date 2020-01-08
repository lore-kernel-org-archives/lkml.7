Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B389C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E507205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgAHRWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:22:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:13390 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729516AbgAHRWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:22:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 09:22:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="303613631"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 08 Jan 2020 09:22:17 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipF29-0005v6-Uu; Wed, 08 Jan 2020 19:22:17 +0200
Date:   Wed, 8 Jan 2020 19:22:17 +0200
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
Subject: Re: [PATCH v2 12/36] platform/x86: intel_scu_ipc: Split out SCU IPC
 functionality from the SCU driver
Message-ID: <20200108172217.GU32742@smile.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-13-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108114201.27908-13-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:41:37PM +0300, Mika Westerberg wrote:
> The SCU IPC functionality is usable outside of Intel MID devices. For
> example modern Intel CPUs include the same thing but now it is called
> PMC (Power Management Controller) instead of SCU. To make the IPC
> available for those split the driver into library part (intel_scu_ipc.c)
> and the SCU PCI driver part (intel_scu_pcidrv.c) which then calls the
> former before it goes and creates rest of the SCU devices.
> 
> We also split the Kconfig symbols so that INTEL_SCU_IPC enables the SCU
> IPC library and INTEL_SCU_PCI the SCU driver and convert the users
> accordingly. While there remove default y from the INTEL_SCU_PCI symbol
> as it is already selected by X86_INTEL_MID.

After addressing at least Kconfig related comment (the rest is up to you)
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  arch/x86/Kconfig                        |  2 +-
>  arch/x86/include/asm/intel_scu_ipc.h    | 15 +++++
>  drivers/mfd/Kconfig                     |  4 +-
>  drivers/platform/x86/Kconfig            | 26 ++++++---
>  drivers/platform/x86/Makefile           |  1 +
>  drivers/platform/x86/intel_scu_ipc.c    | 77 +++++++++----------------
>  drivers/platform/x86/intel_scu_pcidrv.c | 61 ++++++++++++++++++++
>  7 files changed, 125 insertions(+), 61 deletions(-)
>  create mode 100644 drivers/platform/x86/intel_scu_pcidrv.c
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5e8949953660..aca17d1583c4 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -594,7 +594,7 @@ config X86_INTEL_MID
>  	select I2C
>  	select DW_APB_TIMER
>  	select APB_TIMER
> -	select INTEL_SCU_IPC
> +	select INTEL_SCU_PCI
>  	select MFD_INTEL_MSIC
>  	---help---
>  	  Select to build a kernel capable of supporting Intel MID (Mobile
> diff --git a/arch/x86/include/asm/intel_scu_ipc.h b/arch/x86/include/asm/intel_scu_ipc.h
> index 2a1442ba6e78..405c47bf0965 100644
> --- a/arch/x86/include/asm/intel_scu_ipc.h
> +++ b/arch/x86/include/asm/intel_scu_ipc.h
> @@ -19,6 +19,21 @@
>  	#define IPC_CMD_VRTC_SETTIME      1 /* Set time */
>  	#define IPC_CMD_VRTC_SETALARM     2 /* Set alarm */
>  
> +struct device;
> +
> +/**
> + * struct intel_scu_ipc_pdata - Platform data for SCU IPC
> + * @ipc_regs: IPC regs MMIO address
> + * @irq: The IRQ number used for SCU (optional)
> + */
> +struct intel_scu_ipc_pdata {
> +	void __iomem *ipc_regs;
> +	int irq;
> +};
> +

> +int intel_scu_ipc_probe(struct device *dev,
> +			const struct intel_scu_ipc_pdata *pdata);

Perhaps one line?

> +
>  /* Read single register */
>  int intel_scu_ipc_ioread8(u16 addr, u8 *data);
>  
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 420900852166..59515142438e 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -593,7 +593,7 @@ config INTEL_SOC_PMIC_MRFLD
>  	tristate "Support for Intel Merrifield Basin Cove PMIC"
>  	depends on GPIOLIB
>  	depends on ACPI
> -	depends on INTEL_SCU_IPC
> +	depends on INTEL_SCU
>  	select MFD_CORE
>  	select REGMAP_IRQ
>  	help
> @@ -625,7 +625,7 @@ config MFD_INTEL_LPSS_PCI
>  
>  config MFD_INTEL_MSIC
>  	bool "Intel MSIC"
> -	depends on INTEL_SCU_IPC
> +	depends on INTEL_SCU
>  	select MFD_CORE
>  	help
>  	  Select this option to enable access to Intel MSIC (Avatele
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index dd4326736d11..e9ba81fc1770 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -986,25 +986,33 @@ config INTEL_VBTN
>  	  be called intel_vbtn.
>  
>  config INTEL_SCU_IPC
> -	bool "Intel SCU IPC Support"
> +	bool
> +
> +config INTEL_SCU
> +	bool
> +	select INTEL_SCU_IPC
> +
> +config INTEL_SCU_PCI
> +	bool "Intel SCU PCI driver"
>  	depends on X86_INTEL_MID
> -	default y
> -	---help---
> -	  IPC is used to bridge the communications between kernel and SCU on
> -	  some embedded Intel x86 platforms. This is not needed for PC-type
> -	  machines.
> +	select INTEL_SCU
> +	help

> +	  SCU is used to bridge the communications between kernel and

I guess you meant
	SCU -> This driver
here or alike, otherwise it sounds awkward.

> +	  SCU on some embedded Intel x86 platforms. It also creates
> +	  devices that are connected to the SoC through the SCU. This is
> +	  not needed for PC-type machines.
>  
>  config INTEL_SCU_IPC_UTIL
>  	tristate "Intel SCU IPC utility driver"
> -	depends on INTEL_SCU_IPC
> -	---help---
> +	depends on INTEL_SCU
> +	help
>  	  The IPC Util driver provides an interface with the SCU enabling
>  	  low level access for debug work and updating the firmware. Say
>  	  N unless you will be doing this on an Intel MID platform.
>  
>  config INTEL_MID_POWER_BUTTON
>  	tristate "power button driver for Intel MID platforms"
> -	depends on INTEL_SCU_IPC && INPUT
> +	depends on INTEL_SCU && INPUT
>  	help
>  	  This driver handles the power button on the Intel MID platforms.
>  
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 42d85a00be4e..c7a42feaa521 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -68,6 +68,7 @@ intel_cht_int33fe-objs		:= intel_cht_int33fe_common.o \
>  obj-$(CONFIG_INTEL_INT0002_VGPIO) += intel_int0002_vgpio.o
>  obj-$(CONFIG_INTEL_HID_EVENT)	+= intel-hid.o
>  obj-$(CONFIG_INTEL_VBTN)	+= intel-vbtn.o
> +obj-$(CONFIG_INTEL_SCU_PCI)	+= intel_scu_pcidrv.o
>  obj-$(CONFIG_INTEL_SCU_IPC)	+= intel_scu_ipc.o
>  obj-$(CONFIG_INTEL_SCU_IPC_UTIL) += intel_scu_ipcutil.o
>  obj-$(CONFIG_INTEL_MFLD_THERMAL) += intel_mid_thermal.o
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index 93a810fa6c8a..e3f658f1b40a 100644
> --- a/drivers/platform/x86/intel_scu_ipc.c
> +++ b/drivers/platform/x86/intel_scu_ipc.c
> @@ -18,11 +18,8 @@
>  #include <linux/errno.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> -#include <linux/pci.h>
> -#include <linux/pm.h>
> -#include <linux/sfi.h>
> +#include <linux/io.h>
>  
> -#include <asm/intel-mid.h>
>  #include <asm/intel_scu_ipc.h>
>  
>  /* IPC defines the following message types */
> @@ -58,7 +55,7 @@ struct intel_scu_ipc_dev {
>  	struct device *dev;
>  	void __iomem *ipc_base;
>  	struct completion cmd_complete;
> -	u8 irq_mode;
> +	int irq;
>  };
>  
>  static struct intel_scu_ipc_dev  ipcdev; /* Only one for now */
> @@ -166,7 +163,7 @@ static inline int ipc_wait_for_interrupt(struct intel_scu_ipc_dev *scu)
>  
>  static int intel_scu_ipc_check_status(struct intel_scu_ipc_dev *scu)
>  {
> -	return scu->irq_mode ? ipc_wait_for_interrupt(scu) : busy_loop(scu);
> +	return scu->irq > 0 ? ipc_wait_for_interrupt(scu) : busy_loop(scu);
>  }
>  
>  /* Read/Write power control(PMIC in Langwell, MSIC in PenWell) registers */
> @@ -402,60 +399,42 @@ static irqreturn_t ioc(int irq, void *dev_id)
>  }
>  
>  /**
> - *	ipc_probe	-	probe an Intel SCU IPC
> - *	@pdev: the PCI device matching
> - *	@id: entry in the match table
> + * intel_scu_ipc_probe() - Initializes SCU IPC mechanism
> + * @dev: SCU device
> + * @pdata: Platform specific data
>   *
> - *	Enable and install an intel SCU IPC. This appears in the PCI space
> - *	but uses some hard coded addresses as well.
> + * Call this function to initialize SCU IPC mechanism. It is removed
> + * automatically when the calling driver is unbound from @dev.
>   */
> -static int ipc_probe(struct pci_dev *pdev, const struct pci_device_id *id)

> +int intel_scu_ipc_probe(struct device *dev,
> +			const struct intel_scu_ipc_pdata *pdata)

Perhaps one line?

>  {
>  	int err;
>  	struct intel_scu_ipc_dev *scu = &ipcdev;
>  
> -	if (scu->dev)		/* We support only one SCU */
> +	mutex_lock(&ipclock);
> +	/* We support only one IPC */
> +	if (scu->dev) {
> +		mutex_unlock(&ipclock);
>  		return -EBUSY;
> +	}
>  
> -	err = pcim_enable_device(pdev);
> -	if (err)
> -		return err;
> -
> -	err = pcim_iomap_regions(pdev, 1 << 0, pci_name(pdev));
> -	if (err)
> -		return err;
> -
> +	scu->ipc_base = pdata->ipc_regs;
> +	scu->irq = pdata->irq;
>  	init_completion(&scu->cmd_complete);
>  
> -	scu->ipc_base = pcim_iomap_table(pdev)[0];
> -
> -	err = devm_request_irq(&pdev->dev, pdev->irq, ioc, 0, "intel_scu_ipc",
> -			       scu);
> -	if (err)
> -		return err;
> +	if (scu->irq > 0) {

> +		err = devm_request_irq(dev, scu->irq, ioc, 0, "intel_scu_ipc",
> +				       scu);

One line?

> +		if (err)
> +			goto unlock;
> +	}
>  
>  	/* Assign device at last */
> -	scu->dev = &pdev->dev;
> -
> -	intel_scu_devices_create();
> +	scu->dev = dev;
>  
> -	pci_set_drvdata(pdev, scu);
> -	return 0;
> +unlock:
> +	mutex_unlock(&ipclock);
> +	return err;
>  }
> -
> -static const struct pci_device_id pci_ids[] = {
> -	{ PCI_VDEVICE(INTEL, 0x080e) },
> -	{ PCI_VDEVICE(INTEL, 0x08ea) },
> -	{ PCI_VDEVICE(INTEL, 0x11a0) },
> -	{ }
> -};
> -
> -static struct pci_driver ipc_driver = {
> -	.driver = {
> -		.suppress_bind_attrs = true,
> -	},
> -	.name = "intel_scu_ipc",
> -	.id_table = pci_ids,
> -	.probe = ipc_probe,
> -};
> -builtin_pci_driver(ipc_driver);
> +EXPORT_SYMBOL_GPL(intel_scu_ipc_probe);
> diff --git a/drivers/platform/x86/intel_scu_pcidrv.c b/drivers/platform/x86/intel_scu_pcidrv.c
> new file mode 100644
> index 000000000000..47dd4d85bf2a
> --- /dev/null
> +++ b/drivers/platform/x86/intel_scu_pcidrv.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCI driver for the Intel SCU.
> + *
> + * Copyright (C) 2008-2010, 2015, 2020 Intel Corporation
> + * Authors: Sreedhara DS (sreedhara.ds@intel.com)
> + *	    Mika Westerberg <mika.westerberg@linux.intel.com>
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/pci.h>
> +
> +#include <asm/intel-mid.h>
> +#include <asm/intel_scu_ipc.h>
> +
> +static int intel_scu_pci_probe(struct pci_dev *pdev,
> +			       const struct pci_device_id *id)
> +{
> +	struct intel_scu_ipc_pdata *pdata;
> +	int ret;
> +
> +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = pcim_iomap_regions(pdev, 1 << 0, pci_name(pdev));
> +	if (ret)
> +		return ret;
> +
> +	pdata->ipc_regs = pcim_iomap_table(pdev)[0];
> +	pdata->irq = pdev->irq;
> +
> +	ret = intel_scu_ipc_probe(&pdev->dev, pdata);
> +	if (ret)
> +		return ret;
> +
> +	intel_scu_devices_create();
> +	return 0;
> +}
> +
> +static const struct pci_device_id pci_ids[] = {
> +	{ PCI_VDEVICE(INTEL, 0x080e) },
> +	{ PCI_VDEVICE(INTEL, 0x08ea) },
> +	{ PCI_VDEVICE(INTEL, 0x11a0) },
> +	{}
> +};
> +
> +static struct pci_driver intel_scu_pci_driver = {
> +	.driver = {
> +		.suppress_bind_attrs = true,
> +	},
> +	.name = "intel_scu",
> +	.id_table = pci_ids,
> +	.probe = intel_scu_pci_probe,
> +};
> +builtin_pci_driver(intel_scu_pci_driver);
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


