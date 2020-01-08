Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6BFC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971C6206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgAHReu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:34:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:26610 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbgAHRet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:34:49 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 09:34:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="246409632"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 08 Jan 2020 09:34:44 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipFEC-00063o-1g; Wed, 08 Jan 2020 19:34:44 +0200
Date:   Wed, 8 Jan 2020 19:34:44 +0200
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
Subject: Re: [PATCH v2 00/36] platform/x86: Rework intel_scu_ipc and
 intel_pmc_ipc drivers
Message-ID: <20200108173444.GZ32742@smile.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:41:25PM +0300, Mika Westerberg wrote:
> Hi,
> 
> Currently both intel_scu_ipc.c and intel_pmc_ipc.c implement the same SCU
> IPC communications with minor differences. This duplication does not make
> much sense so this series reworks the two drivers so that there is only a
> single implementation of the SCU IPC. In addition to that the API will be
> updated to take SCU instance pointer as an argument, and most of the
> callers will be converted to this new API. The old API is left there but
> the plan is to get rid the callers and then the old API as well (this is
> something we are working with Andy Shevchenko).
> 
> The intel_pmc_ipc.c is then moved under MFD which suits better for this
> kind of a driver that pretty much sets up the SCU IPC and then creates a
> bunch of platform devices for the things sitting behind the PMC. The driver
> is renamed to intel_pmc_bxt.c which should follow the existing conventions
> under drivers/mfd (and it is only meant for Intel Broxton derivatives).
> 
> Previous version of the series:
> 
>   https://www.spinics.net/lists/platform-driver-x86/msg20359.html
> 
> Changes from the previous version:
> 
>   * Update changelog of patch 16 according to what the patch actually does.
>   * Add kernel-doc for struct intel_soc_pmic.
>   * Move octal permission patch to be before MFD conversion.
>   * Convert the intel_pmc_bxt.c to MFD APIs whilst it is being moved under
>     drivers/mfd.

Hmm... I didn't see you appended Lee's ACKs.

> 
> I'm including all x86 maintainers just to be sure they are aware of this as
> I'm not sure if x86@kernel.org reaches them all. Let me know if you have
> issues with this series.
> 
> I would prefer this to be merged through platform/x86 or MFD trees assuming
> there are no objections.

I'm almost reviewed it (few patches left which I plan to do soon), I'm fine if
it goes via other tree.

> 
> I have tested this on Intel Edison (Merrifield) and Joule (Broxton-M).
> 
> Mika Westerberg (36):
>   platform/x86: intel_mid_powerbtn: Take a copy of ddata
>   platform/x86: intel_scu_ipcutil: Remove default y from Kconfig
>   platform/x86: intel_scu_ipc: Add constants for register offsets
>   platform/x86: intel_scu_ipc: Remove Lincroft support
>   platform/x86: intel_scu_ipc: Drop intel_scu_ipc_i2c_cntrl()
>   platform/x86: intel_scu_ipc: Fix interrupt support
>   platform/x86: intel_scu_ipc: Sleeping is fine when polling
>   platform/x86: intel_scu_ipc: Drop unused prototype intel_scu_ipc_fw_update()
>   platform/x86: intel_scu_ipc: Drop unused macros
>   platform/x86: intel_scu_ipc: Drop intel_scu_ipc_io[read|write][8|16]()
>   platform/x86: intel_scu_ipc: Drop intel_scu_ipc_raw_command()
>   platform/x86: intel_scu_ipc: Split out SCU IPC functionality from the SCU driver
>   platform/x86: intel_scu_ipc: Reformat kernel-doc comments of exported functions
>   platform/x86: intel_scu_ipc: Introduce new SCU IPC API
>   platform/x86: intel_mid_powerbtn: Convert to use new SCU IPC API
>   watchdog: intel-mid_wdt: Convert to use new SCU IPC API
>   platform/x86: intel_scu_ipcutil: Convert to use new SCU IPC API
>   platform/x86: intel_pmc_ipc: Make intel_pmc_gcr_update() static
>   platform/x86: intel_pmc_ipc: Make intel_pmc_ipc_simple_command() static
>   platform/x86: intel_pmc_ipc: Make intel_pmc_ipc_raw_cmd() static
>   platform/x86: intel_pmc_ipc: Drop intel_pmc_gcr_read() and intel_pmc_gcr_write()
>   platform/x86: intel_pmc_ipc: Drop ipc_data_readb()
>   platform/x86: intel_pmc_ipc: Get rid of unnecessary includes
>   platform/x86: intel_scu_ipc: Add function to remove SCU IPC
>   platform/x86: intel_pmc_ipc: Start using SCU IPC
>   mfd: intel_soc_pmic: Add SCU IPC member to struct intel_soc_pmic
>   mfd: intel_soc_pmic_bxtwc: Convert to use new SCU IPC API
>   mfd: intel_soc_pmic_mrfld: Convert to use new SCU IPC API
>   platform/x86: intel_telemetry: Convert to use new SCU IPC API
>   platform/x86: intel_pmc_ipc: Drop intel_pmc_ipc_command()
>   x86/platform/intel-mid: Add empty stubs for intel_scu_devices_[create|destroy]()
>   platform/x86: intel_pmc_ipc: Move PCI IDs to intel_scu_pcidrv.c
>   platform/x86: intel_pmc_ipc: Use octal permissions in sysfs attributes
>   platform/x86: intel_pmc_ipc: Convert to MFD
>   mfd: intel_pmc_bxt: Switch to use driver->dev_groups
>   MAINTAINERS: Update entry for Intel Broxton PMC driver
> 
>  MAINTAINERS                                   |   13 +-
>  arch/x86/Kconfig                              |    2 +-
>  arch/x86/include/asm/intel-mid.h              |    9 +-
>  arch/x86/include/asm/intel_pmc_ipc.h          |   91 --
>  arch/x86/include/asm/intel_scu_ipc.h          |  104 +-
>  arch/x86/include/asm/intel_scu_ipc_legacy.h   |   76 ++
>  arch/x86/include/asm/intel_telemetry.h        |    3 +
>  drivers/mfd/Kconfig                           |   18 +-
>  drivers/mfd/Makefile                          |    1 +
>  drivers/mfd/intel_pmc_bxt.c                   |  539 +++++++++
>  drivers/mfd/intel_soc_pmic_bxtwc.c            |   22 +-
>  drivers/mfd/intel_soc_pmic_mrfld.c            |   10 +-
>  drivers/platform/x86/Kconfig                  |   49 +-
>  drivers/platform/x86/Makefile                 |    2 +-
>  drivers/platform/x86/intel_mid_powerbtn.c     |   20 +-
>  drivers/platform/x86/intel_pmc_ipc.c          | 1031 -----------------
>  drivers/platform/x86/intel_scu_ipc.c          |  681 +++++------
>  drivers/platform/x86/intel_scu_ipcutil.c      |   43 +-
>  drivers/platform/x86/intel_scu_pcidrv.c       |   75 ++
>  .../platform/x86/intel_telemetry_debugfs.c    |    2 +-
>  drivers/platform/x86/intel_telemetry_pltdrv.c |  101 +-
>  drivers/usb/typec/tcpm/Kconfig                |    2 +-
>  drivers/watchdog/intel-mid_wdt.c              |   53 +-
>  include/linux/mfd/intel_pmc_bxt.h             |   50 +
>  include/linux/mfd/intel_soc_pmic.h            |   15 +
>  25 files changed, 1319 insertions(+), 1693 deletions(-)
>  delete mode 100644 arch/x86/include/asm/intel_pmc_ipc.h
>  create mode 100644 arch/x86/include/asm/intel_scu_ipc_legacy.h
>  create mode 100644 drivers/mfd/intel_pmc_bxt.c
>  delete mode 100644 drivers/platform/x86/intel_pmc_ipc.c
>  create mode 100644 drivers/platform/x86/intel_scu_pcidrv.c
>  create mode 100644 include/linux/mfd/intel_pmc_bxt.h
> 
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


