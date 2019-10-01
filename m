Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27547ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012F42086A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388615AbfJANmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:42:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:19704 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfJANmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:42:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 06:42:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="205064778"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 01 Oct 2019 06:42:47 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 01 Oct 2019 16:42:47 +0300
Date:   Tue, 1 Oct 2019 16:42:47 +0300
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
Subject: Re: [RFC PATCH 00/22] thunderbolt: Add support for USB4
Message-ID: <20191001134247.GT2714@lahna.fi.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001124954.GI2954373@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001124954.GI2954373@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 02:49:54PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 01, 2019 at 02:38:08PM +0300, Mika Westerberg wrote:
> > Hi all,
> > 
> > I'm sending this as RFC because the series is still missing important
> > features such as power management so not ready for merging. However, I
> > think it is good to get any early feedback from the community. We are
> > working to add support for the missing features.
> > 
> > USB4 is the public specification of Thunderbolt 3 protocol and can be
> > downloaded here:
> > 
> >   https://www.usb.org/sites/default/files/USB4%20Specification_1.zip
> > 
> > USB4 is about tunneling different protocols over a single cable (in the
> > same way as Thunderbolt). The current USB4 spec supports PCIe, Display Port
> > and USB 3.x, and also software based protocols such as networking between
> > domains (hosts).
> > 
> > So far PCs have been using firmware based Connection Manager and Apple
> > systems have been using software based one. A Connection Manager is the
> > entity that handles creation of different tunnel types through the USB4
> > (and Thunderbolt) fabric. With USB4 the plan is to have software based
> > Connection Manager everywhere but some early systems will also support
> > firmware to allow OS downgrade for example.
> > 
> > Current Linux Thunderbolt driver supports both "modes" and can detect which
> > one to use dynamically.
> > 
> > This series first adds support for Thunderbolt 3 devices to the software
> > connection manager and then extends that to support USB4 compliant hosts
> > and devices (this applies to both firmware and software based connection
> > managers). With this series the following features are supported also for
> > USB4 compliant devices:
> > 
> >   - PCIe tunneling
> >   - Display Port tunneling
> >   - USB 3.x tunneling
> >   - P2P networking (implemented in drivers/net/thunderbolt.c)
> >   - Host and device NVM firmware upgrade
> > 
> > We also add two new sysfs attributes under each device that expose link
> > speed and width to userspace. The rest of the userspace ABI stays the same.
> > 
> > I'm including Linux USB folks as well because USB4 is officially coming
> > from USB-IF which puts us on same boat now.
> > 
> > While I changed the user visible Kconfig string to mention "USB4" (the
> > Kconfig option is still CONFIG_THUNDERBOLT), I'm wondering whether we
> > should move the whole Thunderbolt driver under drivers/usb/thunderbolt as
> > well? 
> 
> Looks "interesting", nice work!

Thanks!

> I stopped at patch "Add initial support for USB4" as I don't think we
> want to add USB4 code to a system that we know does not have it, right?

You can connect a USB4 device to Thunderbolt 3 system. USB4 hubs
specifically are required to support this by the spec. Of course then it
is in Thunderbolt 3 alternate mode (not in USB4 native mode) but the
USB4 register set is still there. So for example we still need to
configure TMU (Time Management Unit) and access the DROM via router
operations and so on.

Do you mean we don't want that?

> Everything up to then is just "normal" thunderbolt, and with the
> exception of a few minor comments, all look fine to me.
> 
> I didn't actually read the USB4 patch just yet, as I figured we needed
> to argue about that some more :)

Heh, sure and thanks for the feedback so far :)
