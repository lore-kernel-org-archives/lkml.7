Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F80EC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E952168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389417AbfJAP0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 11:26:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:6487 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727312AbfJAP0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 11:26:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 08:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="205086228"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 01 Oct 2019 08:26:47 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 01 Oct 2019 18:26:46 +0300
Date:   Tue, 1 Oct 2019 18:26:46 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Lukas Wunner <lukas@wunner.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Message-ID: <20191001152646.GC2714@lahna.fi.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-18-mika.westerberg@linux.intel.com>
 <20191001124748.GH2954373@kroah.com>
 <20191001130905.GO2714@lahna.fi.intel.com>
 <20191001145354.GA3366714@kroah.com>
 <20191001150734.GA2714@lahna.fi.intel.com>
 <20191001151935.GA3450435@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001151935.GA3450435@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 05:19:35PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 01, 2019 at 06:07:34PM +0300, Mika Westerberg wrote:
> > On Tue, Oct 01, 2019 at 04:53:54PM +0200, Greg Kroah-Hartman wrote:
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
> > OK, but does that break existing .configs? I mean if you have already
> > CONFIG_THUNDERBOLT in your .config/defconfig does it now just get
> > dropped silently?
> 
> Yup.  And then you get asked about CONFIG_USB4

I see.

> > For example firewire has CONFIG_FIREWIRE even though the "standard" name
> > is IEEE 1394. I was thinking maybe we can do the same for
> > USB4/Thunderbolt?
> 
> It comes down to the what do you want to do for the next 20+ years,
> explain to people that "to get USB4 support, enable CONFIG_THUNDERBOLT"?

That's a very good point indeed :)
