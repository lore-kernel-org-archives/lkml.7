Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A53FC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC1E2133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389628AbfJAPe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 11:34:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:62567 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbfJAPe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 11:34:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 08:32:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="205087932"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 01 Oct 2019 08:32:55 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 01 Oct 2019 18:32:54 +0300
Date:   Tue, 1 Oct 2019 18:32:54 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mario.Limonciello@dell.com, linux-usb@vger.kernel.org,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, rajmohan.mani@intel.com,
        nicholas.johnson-opensource@outlook.com.au, lukas@wunner.de,
        stern@rowland.harvard.edu, anthony.wong@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Message-ID: <20191001153254.GD2714@lahna.fi.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-18-mika.westerberg@linux.intel.com>
 <20191001124748.GH2954373@kroah.com>
 <20191001130905.GO2714@lahna.fi.intel.com>
 <20191001145354.GA3366714@kroah.com>
 <924ce4d5862c4d859e238c0e706a3d5b@AUSX13MPC105.AMER.DELL.COM>
 <20191001152213.GB3450435@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001152213.GB3450435@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 05:22:13PM +0200, Greg KH wrote:
> On Tue, Oct 01, 2019 at 02:59:06PM +0000, Mario.Limonciello@dell.com wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Sent: Tuesday, October 1, 2019 9:54 AM
> > > To: Mika Westerberg
> > > Cc: linux-usb@vger.kernel.org; Andreas Noever; Michael Jamet; Yehezkel Bernat;
> > > Rajmohan Mani; Nicholas Johnson; Lukas Wunner; Alan Stern; Limonciello, Mario;
> > > Anthony Wong; linux-kernel@vger.kernel.org
> > > Subject: Re: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
> > > 
> > > 
> > > [EXTERNAL EMAIL]
> > > 
> > > On Tue, Oct 01, 2019 at 04:09:05PM +0300, Mika Westerberg wrote:
> > > > On Tue, Oct 01, 2019 at 02:47:48PM +0200, Greg Kroah-Hartman wrote:
> > > > > > -	  Thunderbolt Controller driver. This driver is required if you
> > > > > > -	  want to hotplug Thunderbolt devices on Apple hardware or on PCs
> > > > > > -	  with Intel Falcon Ridge or newer.
> > > > > > +	  USB4 (Thunderbolt) driver. USB4 is the public spec based on
> > > > > > +	  Thunderbolt 3 protocol. This driver is required if you want to
> > > > > > +	  hotplug Thunderbolt and USB4 compliant devices on Apple
> > > > > > +	  hardware or on PCs with Intel Falcon Ridge or newer.
> > > > >
> > > > > Wait, did "old" thunderbolt just get re-branded as USB4?
> > > >
> > > > Not but the driver started supporting USB4 as well :)
> > > >
> > > > USB4 is pretty much public spec of Thunderbolt 3 but with some
> > > > differences in register layouts (this is because Thunderbolt uses some
> > > > vendor specific capabilities which are now moved to more "standard"
> > > > places).
> > > 
> > > Ok, then we need to rename the Kconfig option as well, otherwise no one
> > > will "know" that this changed, so they will not be prompted for it.
> > > 
> > > > > Because if I have an "old" laptop that needs Thunderbolt support, how am
> > > > > I going to know it is now called USB4 instead?
> > > >
> > > > Well the Kconfig option tries to have both names there:
> > > >
> > > >   tristate "USB4 (Thunderbolt) support"
> > > >
> > > > and then
> > > >
> > > >   USB4 (Thunderbolt) driver. USB4 is the public spec based on
> > > >   Thunderbolt 3 protocol. This driver is required if you want to hotplug
> > > >   Thunderbolt and USB4 compliant devices on Apple hardware or on PCs
> > > >   with Intel Falcon Ridge or newer.
> > > >
> > > > and the Kconfig option is still CONFIG_THUNDERBOLT. I know this is
> > > > confusing but I don't have better ideas how we can advertise both. I
> > > > borrowed this "format" from firewire.
> > > 
> > > CONFIG_USB4 instead?
> > 
> > How about CONFIG_USB4_PCIE?
> > 
> > I think that will help align that certain aspects of USB4 can be built optionally.
> 
> What aspects?  We don't have that here at all.
> 
> I guess the parts of USB4 that are not just this "hook up the PCIe
> lane" that need to still be developed?

Actually PCIe tunneling is already there in the driver. USB4 has one bit
that is needed to be set before PCIe tunneling can happen (we do that in
patch 17/22) but other than that the existing PCIe tunneling code in the
driver works as is.
