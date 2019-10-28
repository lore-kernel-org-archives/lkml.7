Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2706CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E55321783
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391002AbfJ1Q3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:29:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:37947 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732565AbfJ1Q3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:29:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 09:29:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,240,1569308400"; 
   d="scan'208";a="211478363"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 28 Oct 2019 09:29:00 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iP7t5-0005D3-EA; Mon, 28 Oct 2019 18:28:59 +0200
Date:   Mon, 28 Oct 2019 18:28:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>, lgirdwood@gmail.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Subject: Re: [PATCH 0/2] add regulator driver and mfd cell for Intel Cherry
 Trail Whiskey Cove PMIC
Message-ID: <20191028162859.GO32742@smile.fi.intel.com>
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191025075335.GC32742@smile.fi.intel.com>
 <20191025075540.GD32742@smile.fi.intel.com>
 <166c9855-910d-a70c-ba86-6aebe5f2346d@intel.com>
 <20191028124554.GF5015@sirena.co.uk>
 <c5faf16d-892e-b36e-b448-9c59c2051b9e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5faf16d-892e-b36e-b448-9c59c2051b9e@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 02:26:21PM +0100, Hans de Goede wrote:
> On 28-10-2019 13:45, Mark Brown wrote:
> > On Mon, Oct 28, 2019 at 02:41:46PM +0200, Adrian Hunter wrote:
> > > On 25/10/19 10:55 AM, Andy Shevchenko wrote:
> > 
> > > > Since it's about UHS/SD, Cc to Adrian as well.
> > 
> > > My only concern is that the driver might conflict with ACPI methods trying
> > > to do the same thing, e.g. there is one ACPI SDHC instance from GPDWin DSDT
> > > with code like this:
> 
> Oh, right that is a very good point.
> 
> > That's certainly what's idiomatic for ACPI (though machine specific
> > quirks are too!).  The safe thing to do would be to only register the
> > supply on systems where we know there's no ACPI method.
> 
> Right, so as I mentioned before Andrey told me about the evaluation
> board he is using I was aware of only 3 Cherry Trail devices using
> the Whiskey Cove PMIC. The GPD win, the GPD pocket and the Lenovo
> Yoga book. I've checked the DSDT of all 3 and all 3 of them offer
> voltage control through the Intel _DSM method for voltage control.
> 
> I've also actually tested this on the GPD win and 1.8V signalling
> works fine there without needing Andrey's patch.
> 
> So it seems that Andrey's patch should only be active on his
> dev-board, as actual production hardware ships with the _DSM method.
> 
> I believe that the best solution is for the Whiskey Cove MFD driver:
> drivers/mfd/intel_soc_pmic_chtwc.c
> 
> To only register the new cell on Andrey's evaluation board model
> (based in a DMI match I guess). Another option would be to do
> the DMI check in the regulator driver, but that would mean
> udev will needlessly modprobe the regulator driver on production
> hardware, so doing it in the MFD driver and not registering the cell
> seems best,

I'm wondering if we can upgrade DSDT to provide _DSM for Aero platform.

-- 
With Best Regards,
Andy Shevchenko


