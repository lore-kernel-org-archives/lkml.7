Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0050C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10FE2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389071AbfJDOVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:21:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:36150 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729638AbfJDOVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:21:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 07:21:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,256,1566889200"; 
   d="scan'208";a="205868034"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 04 Oct 2019 07:21:11 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 04 Oct 2019 17:21:10 +0300
Date:   Fri, 4 Oct 2019 17:21:10 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario.Limonciello@dell.com
Cc:     yehezkelshb@gmail.com, linux-usb@vger.kernel.org,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        rajmohan.mani@intel.com,
        nicholas.johnson-opensource@outlook.com.au, lukas@wunner.de,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        anthony.wong@canonical.com, linux-kernel@vger.kernel.org,
        christian@kellner.me
Subject: Re: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Message-ID: <20191004142110.GJ2819@lahna.fi.intel.com>
References: <767f2f97059e4e9f861080672aaa18d3@AUSX13MPC105.AMER.DELL.COM>
 <CA+CmpXs4YsTA3QnD77SaXq3mRYX6oFwx+pm-3wEErwkF-02M+A@mail.gmail.com>
 <bb84da73d1df468da1707a2af09eb2de@AUSX13MPC105.AMER.DELL.COM>
 <20191003080028.GK2819@lahna.fi.intel.com>
 <06a04bff94494da99c5359a7fb645d19@AUSX13MPC105.AMER.DELL.COM>
 <20191004075426.GA2819@lahna.fi.intel.com>
 <CA+CmpXsMkwZhCegGYPYQo2GwN6ROwDYbY3RVZTEeN+FfZ-PbMQ@mail.gmail.com>
 <20191004081951.GD2819@lahna.fi.intel.com>
 <CA+CmpXvoro+m-NZLguMtDq_r_Og8LAFQgPGosvA+WsjMhi6m1Q@mail.gmail.com>
 <332849ed8714496587251b6319a11b0b@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <332849ed8714496587251b6319a11b0b@AUSX13MPC105.AMER.DELL.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Christian

On Fri, Oct 04, 2019 at 02:05:46PM +0000, Mario.Limonciello@dell.com wrote:
> > 
> > On Fri, Oct 4, 2019 at 11:19 AM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > On Fri, Oct 04, 2019 at 11:07:34AM +0300, Yehezkel Bernat wrote:
> > > > > Also if you can get the hw_vendor_id and hw_product_id from the kernel
> > > > > does that mean you don't need to do the two reads or you still need
> > > > > those?
> > > >
> > > > Are those the chip vendor or the OEM, in case they are different?
> > >
> > > Those are the actual USB4 hardware maker values, directly from
> > > ROUTER_CS_0 (p. 287 in the USB4 spec). This almost certainly differ from
> > > the OEM values from DROM we currently expose.
> > 
> > Makes sense to me. Userspace can learn the relevant IDs that their NVM format
> > is
> > known.
> > 
> > >
> > > > Thinking about it again, I'd guess it shouldn't matter much, if the chip is from
> > > > Intel, the FW supports NVM upgrade, isn't it?
> > >
> > > So the bottom line is that if the kernel thinks the router supports NVM
> > > upgrade it exposes the nvm_active/nvm_non_active files etc. I think
> > > fwupd uses this information to display user whether the device can be
> > > upgraded or not (for example ICL cannot as the NVM is part of BIOS).
> > 
> > Yes, fwupd already takes this into account, but the question here is how to
> > handle cases that NVM is available but the format isn't known to
> > userspace (yet).
> 
> Exactly.
> 
> > 
> > >
> > > Exposing hw_vendor_id and hw_product_id may speed up fwupd because it
> > > does not need to go over the active NVM to figure out whether the new
> > > image is for the correct controller.
> > 
> > It's not about finding the relevant image for upgrade (which must be searched
> > for by looking in the DROM vendor/product values), but about the question if the
> > NVM format is known to userspace and skip the parsing work if it's anyway going
> > to fail.
> > 
> > So yes, I think exposing vendor ID (and maybe also product ID) can improve the
> > situation.
> > 
> 
> Currently at probe time everything comes from udev except for the bit indicating
> running in "native" mode or not.  Just enough chunks of the NVM are read to determine
> that (IE no reading up through DROM or jumping around).
> 
> If Christian's patch to export generation is accepted I think that we could move that check
> to only read -native if generation < 3.
> 
> And if you export the hw_vendor_id and hw_product_id fields then that means USB4 devices
> would require no reading from NVM at "probe" since we don't have to read a -native bit.

Right. So I'm thinking instead of sw->generation what if we expose three
new attributes:

  hw_vendor_id - Hardware Vendor ID read from ROUTER_CS_0.
  hw_product_id - Hardware Product ID read from ROUTER_CS_0.
  hw_version - Hardware USB4 version read from ROUTER_CS_4.

This should allow userspace to determine what exactly the device is and
which version it is. For example USB4 routers the hw_version is 0x20.

@Christian, would this work for bolt as well?
