Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8163C282E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B39206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfDVIzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:55:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:29979 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfDVIzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 04:55:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Apr 2019 01:55:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,381,1549958400"; 
   d="scan'208";a="163900826"
Received: from rzhang-dell-9360.sh.intel.com ([10.239.161.125])
  by fmsmga004.fm.intel.com with ESMTP; 22 Apr 2019 01:55:36 -0700
Message-ID: <1555923334.26198.25.camel@intel.com>
Subject: Re: [PATCH] thermal: intel: int340x: processor_thermal_device:
 simplify to get driver data
From:   Zhang Rui <rui.zhang@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     edubezval@gmail.com, daniel.lezcano@linaro.org,
        srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 22 Apr 2019 16:55:34 +0800
In-Reply-To: <1555922784.26198.20.camel@intel.com>
References: <1555339710-28028-1-git-send-email-sumeet.r.pawnikar@intel.com>
         <20190415162809.GU9224@smile.fi.intel.com>
         <1555922784.26198.20.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 一, 2019-04-22 at 16:46 +0800, Zhang Rui wrote:
> On 一, 2019-04-15 at 19:28 +0300, Andy Shevchenko wrote:
> > 
> > On Mon, Apr 15, 2019 at 08:18:30PM +0530, Sumeet Pawnikar wrote:
> > > 
> > > 
> > > From: "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>
> > > 
just one comment, the author name you used is not consistent with the
name you used for your Signed-off-by 'Pawnikar, Sumeet R <sumeet.r.pawn
ikar@intel.com>', and checkpatch complains about missing Signed-off-by
from patch author.
Please fix your gitconfig and run checkpatch before sending next time.

thanks,
rui

> > > This simplifies getting the 'driver_data' from 'struct device'
> > > directly.
> > > Going through platform_device or pci_dev is not required. Also
> > > removes
> > > condition check as the private data stored with dev pointer,
> > > means
> > > irrespective of enumeration mode, we can use dev_get_drvdata().
> > > This removes the unnecessary step back and forth.
> > > 
> > Indeed, good clean up!
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > 
> Thanks, patch applied.
> 
> -rui
> > 
> > > 
> > > 
> > > Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> > > ---
> > >  .../int340x_thermal/processor_thermal_device.c     |   11 +-----
> > > --
> > > ---
> > >  1 file changed, 1 insertion(+), 10 deletions(-)
> > > 
> > > diff --git
> > > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.
> > > c
> > > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.
> > > c
> > > index 8e1cf4d..2a7cbaa 100644
> > > ---
> > > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.
> > > c
> > > +++
> > > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.
> > > c
> > > @@ -81,22 +81,13 @@ enum proc_thermal_emum_mode_type {
> > >  					struct device_attribute
> > > *attr, \
> > >  					char *buf) \
> > >  { \
> > > -	struct pci_dev *pci_dev; \
> > > -	struct platform_device *pdev; \
> > > -	struct proc_thermal_device *proc_dev; \
> > > +	struct proc_thermal_device *proc_dev =
> > > dev_get_drvdata(dev); \
> > >  	\
> > >  	if (proc_thermal_emum_mode == PROC_THERMAL_NONE) { \
> > >  		dev_warn(dev, "Attempted to get power limit
> > > before
> > > device was initialized!\n"); \
> > >  		return 0; \
> > >  	} \
> > >  	\
> > > -	if (proc_thermal_emum_mode == PROC_THERMAL_PLATFORM_DEV)
> > > {
> > > \
> > > -		pdev = to_platform_device(dev); \
> > > -		proc_dev = platform_get_drvdata(pdev); \
> > > -	} else { \
> > > -		pci_dev = to_pci_dev(dev); \
> > > -		proc_dev = pci_get_drvdata(pci_dev); \
> > > -	} \
> > >  	return sprintf(buf, "%lu\n",\
> > >  	(unsigned long)proc_dev->power_limits[index].suffix *
> > > 1000); \
> > >  }
> > > -- 
> > > 1.7.9.5
