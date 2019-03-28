Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BCDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7DA20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfC1Q41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:56:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:54040 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfC1Q40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:56:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 09:56:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,281,1549958400"; 
   d="scan'208";a="129497815"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga008.jf.intel.com with SMTP; 28 Mar 2019 09:56:22 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 28 Mar 2019 18:56:21 +0200
Date:   Thu, 28 Mar 2019 18:56:21 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario.Limonciello@dell.com
Cc:     linux-kernel@vger.kernel.org, michael.jamet@intel.com,
        YehezkelShB@gmail.com, andreas.noever@gmail.com, lukas@wunner.de,
        davem@davemloft.net, andriy.shevchenko@linux.intel.com,
        ckellner@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v3 00/36] thunderbolt: Software connection manager
 improvements
Message-ID: <20190328165621.GB3622@lahna.fi.intel.com>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
 <1aaab9baea4f46b481b5601dfb060104@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aaab9baea4f46b481b5601dfb060104@ausx13mpc120.AMER.DELL.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 03:17:57PM +0000, Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Sent: Thursday, March 28, 2019 7:36 AM
> > To: linux-kernel@vger.kernel.org
> > Cc: Michael Jamet; Yehezkel Bernat; Andreas Noever; Lukas Wunner; David S .
> > Miller; Andy Shevchenko; Christian Kellner; Limonciello, Mario; Mika Westerberg;
> > netdev@vger.kernel.org
> > Subject: [PATCH v3 00/36] thunderbolt: Software connection manager
> > improvements
> > 
> > 
> > [EXTERNAL EMAIL]
> > 
> > Hi,
> > 
> > This is third iteration of the patch series intending to bring same kind of
> > functionality for older Apple systems than we have in PCs. Software
> > connection manager is used on Apple hardware with Light Ridge, Cactus Ridge
> > or Falcon Ridge controllers to create PCIe tunnels when a Thunderbolt
> > device is connected. Currently only one PCIe tunnel is supported. On newer
> > Alpine Ridge based Apple systems the driver starts the firmware which then
> > takes care creating tunnels.
> > 
> > This series improves the software connection manager so that it will
> > support:
> > 
> >   - Full PCIe daisy chains (up to 6 devices)
> >   - Display Port tunneling
> >   - P2P networking
> > 
> > We also add support for Titan Ridge based Apple systems where we can use
> > the same flows than with Alpine Ridge to start the firmware.
> 
> It seems to me that there would be an expectation that PC system firmware and TBT controller
> firmware is configured to behave like Apple systems to use this SW connection manager
> instead of the ICM in AR/TR FW.
> 
> Is there an intent to eventually offer a way to "side-step" the TBT ICM and try to use this instead
> without firmware support?

Yes, that's the intention.

> > 
> > This applies on top of thunderbolt.git/next.
> > 
> > Christian, Mario do you see any issues with patch [05/36] regarding bolt
> > and fwupd? The kernel is supposed to restart the syscall automatically so
> > userspace should not be affected but wanted to check with you.
> 
> I don't see a problem for fwupd in this area.

OK, thanks for checking.

> > Previous version of the patch series can be viewed here:
> > 
> >   v2: https://lkml.org/lkml/2019/2/6/347
> >   v1: https://lkml.org/lkml/2019/1/29/924
> > 
> > Making v3 took longer than I anticipated mostly due to some issues I run
> > during testing the new changes. There are quite many changes so I dropped
> > the reviewed-by tags I got for v2. Below is the list of major changes from
> > the previous version:
> > 
> >   * Always set port->remote even in case of dual link connection.
> > 
> >   * Leave (DP, PCIe) tunnels up when the driver is unloaded. When loaded
> >     back, it discovers the existing tunnels and updated data structures
> >     accordingly. I noticed that the code in v2 did not support cases
> >     properly when you unplug something before the driver gets loaded back.
> >     This version tears down partial paths during discovery.
> > 
> >   * Do not automatically create PCIe tunnels. Instead we implement "user"
> >     security level in the software connection manager as well taking
> >     advantage of the existing sysfs interfaces. This allows user to disable
> >     PCIe tunneling completely or implement different white listing
> >     policies. Major distros include bolt system daemon that takes care of
> >     this.
> 
> This is a bit unfortunate.  Is this because of IOMMU limitations in working
> with devices down the chain?

No, it just makes it possible to do things such as "disable all PCIe
tunneling", like the master switch we have in GNOME UI. Even if you have
full IOMMU support it still does not prevent misbehaving devices.

This also allows other kind of whitelisting like supporting devices from
certain "known" vendor only.

IOMMU is still the primary protection against DMA attacks.
