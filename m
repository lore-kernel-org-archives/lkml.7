Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FC1C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A442120673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgAIGNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 01:13:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:32600 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgAIGNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 01:13:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 22:13:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,412,1571727600"; 
   d="scan'208";a="226400153"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 08 Jan 2020 22:13:17 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 09 Jan 2020 08:13:16 +0200
Date:   Thu, 9 Jan 2020 08:13:16 +0200
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
Subject: Re: [PATCH v2 00/36] platform/x86: Rework intel_scu_ipc and
 intel_pmc_ipc drivers
Message-ID: <20200109061316.GB2838@lahna.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108173444.GZ32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108173444.GZ32742@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 07:34:44PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 08, 2020 at 02:41:25PM +0300, Mika Westerberg wrote:
> > Hi,
> > 
> > Currently both intel_scu_ipc.c and intel_pmc_ipc.c implement the same SCU
> > IPC communications with minor differences. This duplication does not make
> > much sense so this series reworks the two drivers so that there is only a
> > single implementation of the SCU IPC. In addition to that the API will be
> > updated to take SCU instance pointer as an argument, and most of the
> > callers will be converted to this new API. The old API is left there but
> > the plan is to get rid the callers and then the old API as well (this is
> > something we are working with Andy Shevchenko).
> > 
> > The intel_pmc_ipc.c is then moved under MFD which suits better for this
> > kind of a driver that pretty much sets up the SCU IPC and then creates a
> > bunch of platform devices for the things sitting behind the PMC. The driver
> > is renamed to intel_pmc_bxt.c which should follow the existing conventions
> > under drivers/mfd (and it is only meant for Intel Broxton derivatives).
> > 
> > Previous version of the series:
> > 
> >   https://www.spinics.net/lists/platform-driver-x86/msg20359.html
> > 
> > Changes from the previous version:
> > 
> >   * Update changelog of patch 16 according to what the patch actually does.
> >   * Add kernel-doc for struct intel_soc_pmic.
> >   * Move octal permission patch to be before MFD conversion.
> >   * Convert the intel_pmc_bxt.c to MFD APIs whilst it is being moved under
> >     drivers/mfd.
> 
> Hmm... I didn't see you appended Lee's ACKs.

I thought those were for his own reference:

  For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

I can add them if that's not the case.

> > I'm including all x86 maintainers just to be sure they are aware of this as
> > I'm not sure if x86@kernel.org reaches them all. Let me know if you have
> > issues with this series.
> > 
> > I would prefer this to be merged through platform/x86 or MFD trees assuming
> > there are no objections.
> 
> I'm almost reviewed it (few patches left which I plan to do soon), I'm fine if
> it goes via other tree.

Thanks a lot for the review!
