Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F069AC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA4A20661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbgAIOZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:25:21 -0500
Received: from mga18.intel.com ([134.134.136.126]:29444 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbgAIOZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:25:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 06:25:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="421795166"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jan 2020 06:25:15 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipYkN-00012Z-DF; Thu, 09 Jan 2020 16:25:15 +0200
Date:   Thu, 9 Jan 2020 16:25:15 +0200
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
Message-ID: <20200109142515.GS32742@smile.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-35-mika.westerberg@linux.intel.com>
 <20200109114354.GP32742@smile.fi.intel.com>
 <20200109114753.GF2838@lahna.fi.intel.com>
 <20200109125727.GG2838@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109125727.GG2838@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 02:57:27PM +0200, Mika Westerberg wrote:
> On Thu, Jan 09, 2020 at 01:47:59PM +0200, Mika Westerberg wrote:
> > > >  config INTEL_SOC_PMIC_BXTWC
> > > >  	tristate "Support for Intel Broxton Whiskey Cove PMIC"
> > > > -	depends on INTEL_PMC_IPC
> > > > +	depends on MFD_INTEL_PMC_BXT
> > > >  	select MFD_CORE
> > > >  	select REGMAP_IRQ
> > > >  	help
> > > > @@ -632,6 +632,18 @@ config MFD_INTEL_MSIC
> > > >  	  Passage) chip. This chip embeds audio, battery, GPIO, etc.
> > > >  	  devices used in Intel Medfield platforms.
> > > >  
> > > > +config MFD_INTEL_PMC_BXT
> > > > +	tristate "Intel PMC Driver for Broxton"
> > > 
> > > > +	depends on X86 && X86_PLATFORM_DEVICES && ACPI
> > > 
> > > Is the X86_PLATFORM_DEVICES dependency compulsory?
> > > Quick grep shows that none of drivers (except nouveau) relies on it.
> > 
> > Well, we need that to be able to do the "select INTEL_SCU_IPC" below.
> > I'm happy to change it if you have a better alternative ;-)
> 
> Just to provide more information. If I don't have that dependency I get
> warnings like this:
> 
> WARNING: unmet direct dependencies detected for INTEL_SCU_IPC
>   Depends on [n]: X86 [=y] && X86_PLATFORM_DEVICES [=n]
>     Selected by [y]:
>       - MFD_INTEL_PMC_BXT [=y] && HAS_IOMEM [=y] && X86 [=y] && ACPI [=y]

I see, thanks for elaboration.
Please, just split them one per line.

-- 
With Best Regards,
Andy Shevchenko


