Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D45C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDB02072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgAILr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 06:47:59 -0500
Received: from mga14.intel.com ([192.55.52.115]:42248 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbgAILr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:47:59 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 03:47:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,413,1571727600"; 
   d="scan'208";a="227236495"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 09 Jan 2020 03:47:54 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 09 Jan 2020 13:47:53 +0200
Date:   Thu, 9 Jan 2020 13:47:53 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <20200109114753.GF2838@lahna.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-35-mika.westerberg@linux.intel.com>
 <20200109114354.GP32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109114354.GP32742@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 01:43:54PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 08, 2020 at 02:41:59PM +0300, Mika Westerberg wrote:
> > This driver only creates a bunch of platform devices sharing resources
> > belonging to the PMC device. This is pretty much what MFD subsystem is
> > for so move the driver there, renaming it to intel_pmc_bxt.c which
> > should be more clear what it is.
> > 
> > MFD subsystem provides nice helper APIs for subdevice creation so
> > convert the driver to use those. Unfortunately the ACPI device includes
> > separate resources for most of the subdevices so we cannot simply call
> > mfd_add_devices() to create all of them but instead we need to call it
> > separately for each device.
> 
> Comments below, after addressing,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/mfd/Kconfig                           |  14 +-
> >  drivers/mfd/Makefile                          |   1 +
> >  .../intel_pmc_ipc.c => mfd/intel_pmc_bxt.c}   | 394 +++++++-----------
> >  drivers/platform/x86/Kconfig                  |  16 +-
> >  drivers/platform/x86/Makefile                 |   1 -
> >  .../platform/x86/intel_telemetry_debugfs.c    |   2 +-
> >  drivers/usb/typec/tcpm/Kconfig                |   2 +-
> >  .../linux/mfd/intel_pmc_bxt.h                 |  11 +-
> >  8 files changed, 171 insertions(+), 270 deletions(-)
> >  rename drivers/{platform/x86/intel_pmc_ipc.c => mfd/intel_pmc_bxt.c} (50%)
> >  rename arch/x86/include/asm/intel_pmc_ipc.h => include/linux/mfd/intel_pmc_bxt.h (83%)
> > 
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 59515142438e..04542feffe25 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -551,7 +551,7 @@ config INTEL_SOC_PMIC
> >  
> >  config INTEL_SOC_PMIC_BXTWC
> >  	tristate "Support for Intel Broxton Whiskey Cove PMIC"
> > -	depends on INTEL_PMC_IPC
> > +	depends on MFD_INTEL_PMC_BXT
> >  	select MFD_CORE
> >  	select REGMAP_IRQ
> >  	help
> > @@ -632,6 +632,18 @@ config MFD_INTEL_MSIC
> >  	  Passage) chip. This chip embeds audio, battery, GPIO, etc.
> >  	  devices used in Intel Medfield platforms.
> >  
> > +config MFD_INTEL_PMC_BXT
> > +	tristate "Intel PMC Driver for Broxton"
> 
> > +	depends on X86 && X86_PLATFORM_DEVICES && ACPI
> 
> Is the X86_PLATFORM_DEVICES dependency compulsory?
> Quick grep shows that none of drivers (except nouveau) relies on it.

Well, we need that to be able to do the "select INTEL_SCU_IPC" below.
I'm happy to change it if you have a better alternative ;-)

> For the rest two I think we might split one per line to be consistent with
> existing example(s) in  drivers/mfd/Kconfig.

OK

> 
> > +	select INTEL_SCU_IPC
> > +	select MFD_CORE
> > +	help
> > +	  This driver provides support for PMC (Power Management
> > +	  Controller) on Intel Broxton and Apollo Lake. PMC is a
> > +	  multi-function device that exposes IPC, General Control
> > +	  Register and P-unit access. In addition this creates devices
> > +	  for iTCO watchdog and telemetry that are part of the PMC.
