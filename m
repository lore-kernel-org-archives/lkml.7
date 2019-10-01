Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020CFC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F08215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389407AbfJAO64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:58:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:32208 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbfJAO6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:58:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 07:58:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="205077193"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 01 Oct 2019 07:58:51 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 01 Oct 2019 17:58:50 +0300
Date:   Tue, 1 Oct 2019 17:58:50 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario.Limonciello@dell.com
Cc:     linux-usb@vger.kernel.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        rajmohan.mani@intel.com,
        nicholas.johnson-opensource@outlook.com.au, lukas@wunner.de,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        anthony.wong@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 22/22] thunderbolt: Do not start firmware unless
 asked by the user
Message-ID: <20191001145850.GZ2714@lahna.fi.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-23-mika.westerberg@linux.intel.com>
 <10cccc5a8d1a43fd9769ab6c4b53aeba@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10cccc5a8d1a43fd9769ab6c4b53aeba@AUSX13MPC105.AMER.DELL.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 02:43:15PM +0000, Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Sent: Tuesday, October 1, 2019 6:39 AM
> > To: linux-usb@vger.kernel.org
> > Cc: Andreas Noever; Michael Jamet; Mika Westerberg; Yehezkel Bernat; Rajmohan
> > Mani; Nicholas Johnson; Lukas Wunner; Greg Kroah-Hartman; Alan Stern;
> > Limonciello, Mario; Anthony Wong; linux-kernel@vger.kernel.org
> > Subject: [RFC PATCH 22/22] thunderbolt: Do not start firmware unless asked by the
> > user
> > 
> > 
> > [EXTERNAL EMAIL]
> > 
> > Since now we can do pretty much the same thing in the software
> > connection manager than the firmware would do, there is no point
> > starting it by default. Instead we can just continue using the software
> > connection manager.
> > 
> > Make it possible for user to switch between the two by adding a module
> > pararameter (start_icm) which is by default false. Having this ability
> > to enable the firmware may be useful at least when debugging possible
> > issues with the software connection manager implementation.
> 
> If the host system firmware didn't start the ICM, does that mean SW connection
> manager would just take over even on systems with discrete AR/TR controllers?

Yes. This is pretty much the case with Apple systems now.

> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/thunderbolt/icm.c | 14 +++++++++++---
> >  drivers/thunderbolt/tb.c  |  4 ----
> >  2 files changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
> > index 9c9c6ea2b790..c4a2de0f2a44 100644
> > --- a/drivers/thunderbolt/icm.c
> > +++ b/drivers/thunderbolt/icm.c
> > @@ -11,6 +11,7 @@
> > 
> >  #include <linux/delay.h>
> >  #include <linux/mutex.h>
> > +#include <linux/moduleparam.h>
> >  #include <linux/pci.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/platform_data/x86/apple.h>
> > @@ -43,6 +44,10 @@
> >  #define ICM_APPROVE_TIMEOUT		10000	/* ms */
> >  #define ICM_MAX_LINK			4
> > 
> > +static bool start_icm;
> > +module_param(start_icm, bool, 0444);
> > +MODULE_PARM_DESC(start_icm, "start ICM firmware if it is not running (default:
> > false)");
> > +
> >  /**
> >   * struct icm - Internal connection manager private data
> >   * @request_lock: Makes sure only one message is send to ICM at time
> > @@ -1353,13 +1358,16 @@ static bool icm_ar_is_supported(struct tb *tb)
> >  {
> >  	struct pci_dev *upstream_port;
> >  	struct icm *icm = tb_priv(tb);
> > +	u32 val;
> > 
> >  	/*
> >  	 * Starting from Alpine Ridge we can use ICM on Apple machines
> >  	 * as well. We just need to reset and re-enable it first.
> 
> This comment doesn't really seem as relevant anymore.  The meaning of it
> has nothing to do with Apple anymore.

Actually it is still relevant. For USB4 the intent is to have FW/SW CM
switch in ACPI spec instead. But that is still under discussion.

> > +	 * However, only start it if explicitly asked by the user.
> >  	 */
> > -	if (!x86_apple_machine)
> > -		return true;
> > +	val = ioread32(tb->nhi->iobase + REG_FW_STS);
> > +	if (!(val & REG_FW_STS_ICM_EN) && !start_icm)
> > +		return false;
> 
> This code is already in icm_firmware_start.  Maybe split it to a small function
> So you can just have the more readable
> 
> If (!icm_firmware_running(tb) && !start_icm))

Good point. I'll do that.
