Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE25BC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6AE218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfJBIsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 04:48:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:3556 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfJBIsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 04:48:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 01:48:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,573,1559545200"; 
   d="scan'208";a="205281082"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 02 Oct 2019 01:48:08 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 02 Oct 2019 11:48:08 +0300
Date:   Wed, 2 Oct 2019 11:48:08 +0300
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
Message-ID: <20191002084808.GI2714@lahna.fi.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-23-mika.westerberg@linux.intel.com>
 <10cccc5a8d1a43fd9769ab6c4b53aeba@AUSX13MPC105.AMER.DELL.COM>
 <20191001145850.GZ2714@lahna.fi.intel.com>
 <1cec43f38ccd42d9a4d9a9c86365a24a@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cec43f38ccd42d9a4d9a9c86365a24a@AUSX13MPC105.AMER.DELL.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 04:53:54PM +0000, Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Sent: Tuesday, October 1, 2019 9:59 AM
> > To: Limonciello, Mario
> > Cc: linux-usb@vger.kernel.org; andreas.noever@gmail.com;
> > michael.jamet@intel.com; YehezkelShB@gmail.com; rajmohan.mani@intel.com;
> > nicholas.johnson-opensource@outlook.com.au; lukas@wunner.de;
> > gregkh@linuxfoundation.org; stern@rowland.harvard.edu;
> > anthony.wong@canonical.com; linux-kernel@vger.kernel.org
> > Subject: Re: [RFC PATCH 22/22] thunderbolt: Do not start firmware unless asked by
> > the user
> > 
> > 
> > [EXTERNAL EMAIL]
> > 
> > On Tue, Oct 01, 2019 at 02:43:15PM +0000, Mario.Limonciello@dell.com wrote:
> > > > -----Original Message-----
> > > > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > Sent: Tuesday, October 1, 2019 6:39 AM
> > > > To: linux-usb@vger.kernel.org
> > > > Cc: Andreas Noever; Michael Jamet; Mika Westerberg; Yehezkel Bernat;
> > Rajmohan
> > > > Mani; Nicholas Johnson; Lukas Wunner; Greg Kroah-Hartman; Alan Stern;
> > > > Limonciello, Mario; Anthony Wong; linux-kernel@vger.kernel.org
> > > > Subject: [RFC PATCH 22/22] thunderbolt: Do not start firmware unless asked by
> > the
> > > > user
> > > >
> > > >
> > > > [EXTERNAL EMAIL]
> > > >
> > > > Since now we can do pretty much the same thing in the software
> > > > connection manager than the firmware would do, there is no point
> > > > starting it by default. Instead we can just continue using the software
> > > > connection manager.
> > > >
> > > > Make it possible for user to switch between the two by adding a module
> > > > pararameter (start_icm) which is by default false. Having this ability
> > > > to enable the firmware may be useful at least when debugging possible
> > > > issues with the software connection manager implementation.
> > >
> > > If the host system firmware didn't start the ICM, does that mean SW connection
> > > manager would just take over even on systems with discrete AR/TR controllers?
> > 
> > Yes. This is pretty much the case with Apple systems now.
> 
> Potentially if system firmware started ICM can we accomplish the same thing by
> resetting AR/TR that normally use ICM and then SW CM would take over?
> 
> Or is the ICM started up automatically when the controller is power cycled based
> on something in the NVM?

It is something in the NVM :)

> I'm trying to find a way that I can usefully exercise some of this stuff on pre-USB4
> controllers like AR/TR/ICL-TBT.

Only way I can think of is to find yourself a Mac ;-)

> > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > ---
> > > >  drivers/thunderbolt/icm.c | 14 +++++++++++---
> > > >  drivers/thunderbolt/tb.c  |  4 ----
> > > >  2 files changed, 11 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
> > > > index 9c9c6ea2b790..c4a2de0f2a44 100644
> > > > --- a/drivers/thunderbolt/icm.c
> > > > +++ b/drivers/thunderbolt/icm.c
> > > > @@ -11,6 +11,7 @@
> > > >
> > > >  #include <linux/delay.h>
> > > >  #include <linux/mutex.h>
> > > > +#include <linux/moduleparam.h>
> > > >  #include <linux/pci.h>
> > > >  #include <linux/pm_runtime.h>
> > > >  #include <linux/platform_data/x86/apple.h>
> > > > @@ -43,6 +44,10 @@
> > > >  #define ICM_APPROVE_TIMEOUT		10000	/* ms */
> > > >  #define ICM_MAX_LINK			4
> > > >
> > > > +static bool start_icm;
> > > > +module_param(start_icm, bool, 0444);
> > > > +MODULE_PARM_DESC(start_icm, "start ICM firmware if it is not running
> > (default:
> > > > false)");
> > > > +
> > > >  /**
> > > >   * struct icm - Internal connection manager private data
> > > >   * @request_lock: Makes sure only one message is send to ICM at time
> > > > @@ -1353,13 +1358,16 @@ static bool icm_ar_is_supported(struct tb *tb)
> > > >  {
> > > >  	struct pci_dev *upstream_port;
> > > >  	struct icm *icm = tb_priv(tb);
> > > > +	u32 val;
> > > >
> > > >  	/*
> > > >  	 * Starting from Alpine Ridge we can use ICM on Apple machines
> > > >  	 * as well. We just need to reset and re-enable it first.
> > >
> > > This comment doesn't really seem as relevant anymore.  The meaning of it
> > > has nothing to do with Apple anymore.
> > 
> > Actually it is still relevant. For USB4 the intent is to have FW/SW CM
> > switch in ACPI spec instead. But that is still under discussion.
> 
> Like read a hint from an ACPI table that indicates which one driver should use?

Yes.

I think it will be extension to _OSC but as it is still under discussion
so subject to change.

> The idea being early USB4 systems would test and ship with this bit set to
> FW CM and later USB4 systems can have it set to SW CM?

Correct.

> I like that idea, but I think that you almost want the module parameter to indicate
> which CM you want to "use" instead so you would override what was set in ACPI
> either way, but default to auto.
> 
> cm=auto
> TBT3 and less: follow NVM behavior
> USB4: follow ACPI table, either use FW or SW CM.
> 
> cm=icm
> Start up ICM, or error out if you can't.
> 
> cm=sw
> Stop ICM if it's running, and initialize using kernel CM.
>
> That would certainly allow running this across some more configurations really easily then.

The point with start_icm is to act as "chicken bit" in case SW CM (Linux
driver) does not work properly. Nothing else. User can then switch back
to FW CM on their Apple system and get more "working" system hopefully
reporting this to us so we can try to figure out what's wrong with the
driver :)

I don't think it is good idea to have a module parameter to control
anything else that is supposed to be set in the BIOS/boot firmware.
