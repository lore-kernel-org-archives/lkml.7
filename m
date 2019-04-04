Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4D6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73E1206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbfDDM1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:27:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:28135 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbfDDM1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:27:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 05:27:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,308,1549958400"; 
   d="scan'208";a="158698520"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga004.fm.intel.com with ESMTP; 04 Apr 2019 05:27:09 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hC1SW-0005DM-85; Thu, 04 Apr 2019 15:27:08 +0300
Date:   Thu, 4 Apr 2019 15:27:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: Add support for Merrifield Basin Cove PMIC
Message-ID: <20190404122708.GS9224@smile.fi.intel.com>
References: <20190318095316.69278-1-andriy.shevchenko@linux.intel.com>
 <20190402051211.GR4187@dell>
 <20190402122001.GM9224@smile.fi.intel.com>
 <20190404070004.GE6830@dell>
 <20190404070357.GF6830@dell>
 <20190404082138.GF9224@smile.fi.intel.com>
 <20190404090314.GT6830@dell>
 <20190404092617.GO9224@smile.fi.intel.com>
 <20190404094459.GV6830@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404094459.GV6830@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 10:44:59AM +0100, Lee Jones wrote:
> On Thu, 04 Apr 2019, Andy Shevchenko wrote:
> > On Thu, Apr 04, 2019 at 10:03:14AM +0100, Lee Jones wrote:
> > > On Thu, 04 Apr 2019, Andy Shevchenko wrote:
> > > > On Thu, Apr 04, 2019 at 08:03:57AM +0100, Lee Jones wrote:
> > > > > On Thu, 04 Apr 2019, Lee Jones wrote:
> > > > > > On Tue, 02 Apr 2019, Andy Shevchenko wrote:

> > > > > > From the child:
> > > > > > 
> > > > > >   platform_get_irq(dev->parent, CLIENT_ID);
> > > > 
> > > > So, instead of keeping a fragile approach in one driver, we will spread this
> > > > to all of them.
> > > 
> > > No, the fragileness goes away with implicit definitions of IDs.
> > 
> > Did you mean "explicit"?
> 
> Yes.  Thank you for correcting my English. :)
> 
> > Something like we need to have a shared map of those indices?
> 
> Defining the IDs of the devices would lead to a more robust
> implementation, yes.

This would make children to know that they are springs of exact MFD parent driver
that makes them dependent and inflexible.

> > > > There is one device node with several IRQ and other resources.
> > > > In pseudo code:
> > > > 
> > > > 	device node {
> > > > 		device ID,
> > > > 		IRQ 0,
> > > > 		IRQ 1,
> > > > 		...
> > > > 		MMIO 0,
> > > > 		...
> > > > 	}
> > > 
> > > Sure.  Thanks for the explanation.
> > > 
> > > Very well.  I guess it's not too bad as it is.
> > 
> > It represent real hardware 1:1.
> > Just out of curiosity how this case can be described in DT?
> 
> In DT you can have a sub-node for each child which can contain the
> IRQ.  Without a sub-node you would define the IRQs in this file.  If
> these IRQs do not change, that option is still available to you.
> 
> I can't think of an example where all of the children's IRQs have been
> listed in the parent's DT node in this way.

I see. Something similar is done in ACPI table for Intel Galileo Gen2
(see intel_quark_i2c_gpio.c), though it's a PCI device with shared
interrupt line.

If it would be a case like above, MFD would have propagated IRQ resources from
them to the children anyway.

-- 
With Best Regards,
Andy Shevchenko


