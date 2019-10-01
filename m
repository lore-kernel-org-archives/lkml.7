Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B33ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99FF821A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388107AbfJAMx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:53:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:1093 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfJAMx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:53:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 05:53:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="205058671"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 01 Oct 2019 05:53:21 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 01 Oct 2019 15:53:21 +0300
Date:   Tue, 1 Oct 2019 15:53:20 +0300
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
Subject: Re: [RFC PATCH 06/22] thunderbolt: Add support for lane bonding
Message-ID: <20191001125320.GN2714@lahna.fi.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-7-mika.westerberg@linux.intel.com>
 <20191001123808.GA2954373@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001123808.GA2954373@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 02:38:08PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 01, 2019 at 02:38:14PM +0300, Mika Westerberg wrote:
> > Lane bonding allows aggregating the two 10/20 Gb/s (depending on the
> > generation) lanes into a single 20/40 Gb/s bonded link. This allows
> > sharing the full bandwidth more efficiently. In order to establish lane
> > bonding we need to check that the lane bonding is possible through LC
> > and that both end of the link actually supports 2x widths. This also
> > means that all the paths should be established through the primary port
> > so update tb_path_alloc() to handle this as well.
> > 
> > Lane bonding is supported starting from Falcon Ridge (2nd generation)
> > controllers.
> 
> Are we only going to be allowed to "bond" two links together?  Or will
> we be doing more than 2 in the future?  If more, then we might want to
> think of a different way to specify these...

AFAICT only two lanes are available in USB4. This goes over USB type-C
using the two lanes there.

Of course I don't know if in future there will be USB4 1.1 or something
that adds more lanes so if you think there is a better way to specify
these, I'm happy to implement that instead :) 

> Anyway, one tiny nit below:
> 
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  .../ABI/testing/sysfs-bus-thunderbolt         |  17 ++
> >  drivers/thunderbolt/icm.c                     |  18 +-
> >  drivers/thunderbolt/lc.c                      |  28 ++
> >  drivers/thunderbolt/path.c                    |  30 +-
> >  drivers/thunderbolt/switch.c                  | 274 ++++++++++++++++++
> >  drivers/thunderbolt/tb.c                      |  21 ++
> >  drivers/thunderbolt/tb.h                      |  10 +
> >  drivers/thunderbolt/tb_msgs.h                 |   2 +
> >  drivers/thunderbolt/tb_regs.h                 |  20 ++
> >  drivers/thunderbolt/tunnel.c                  |  19 +-
> >  10 files changed, 429 insertions(+), 10 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-thunderbolt b/Documentation/ABI/testing/sysfs-bus-thunderbolt
> > index b21fba14689b..2c9166f6fa97 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-thunderbolt
> > +++ b/Documentation/ABI/testing/sysfs-bus-thunderbolt
> > @@ -104,6 +104,23 @@ Contact:	thunderbolt-software@lists.01.org
> >  Description:	This attribute contains name of this device extracted from
> >  		the device DROM.
> >  
> > +What:		/sys/bus/thunderbolt/devices/.../link_speed
> > +Date:		Apr 2020
> > +KernelVersion:	5.6
> > +Contact:	Mika Westerberg <mika.westerberg@linux.intel.com>
> > +Description:	This attribute reports the current upstream link speed
> > +		in Gb/s per lane. If there are two lanes they both are
> > +		running at the same speed. Use link_width to determine
> > +		whether the two lanes are bonded or not.
> > +
> > +What:		/sys/bus/thunderbolt/devices/.../link_width
> > +Date:		Apr 2020
> > +KernelVersion:	5.6
> > +Contact:	Mika Westerberg <mika.westerberg@linux.intel.com>
> > +Description:	This attribute reports the current upstream link width.
> > +		It is 1 for single lane link (or two single lane links)
> > +		and 2 for bonded dual lane link.
> > +
> >  What:		/sys/bus/thunderbolt/devices/.../vendor
> >  Date:		Sep 2017
> >  KernelVersion:	4.13
> > diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
> > index 6550f68f92ce..9c9c6ea2b790 100644
> > --- a/drivers/thunderbolt/icm.c
> > +++ b/drivers/thunderbolt/icm.c
> > @@ -567,7 +567,8 @@ static struct tb_switch *add_switch(struct tb_switch *parent_sw, u64 route,
> >  				    size_t ep_name_size, u8 connection_id,
> >  				    u8 connection_key, u8 link, u8 depth,
> >  				    enum tb_security_level security_level,
> > -				    bool authorized, bool boot)
> > +				    bool authorized, bool boot, bool dual_lane,
> > +				    bool speed_gen3)
> 
> That's just a crazy amount of function parameters, with no way of
> remembering what is what, especially when you add 2 more booleans at the
> end.
> 
> It's your code, but ugh, that's going to be hard to maintain over time
> :(

Good point. I'll see if I can simplify it in the next version.
