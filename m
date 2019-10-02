Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7A3C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B7A21783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfJBIak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 04:30:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:20607 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfJBIaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 04:30:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 01:30:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,573,1559545200"; 
   d="scan'208";a="205278527"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 02 Oct 2019 01:30:35 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 02 Oct 2019 11:30:34 +0300
Date:   Wed, 2 Oct 2019 11:30:34 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anthony Wong <anthony.wong@canonical.com>,
        Mario.Limonciello@dell.com,
        Andreas Noever <andreas.noever@gmail.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Message-ID: <20191002083034.GE2714@lahna.fi.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-18-mika.westerberg@linux.intel.com>
 <20191001124748.GH2954373@kroah.com>
 <20191001130905.GO2714@lahna.fi.intel.com>
 <20191001145354.GA3366714@kroah.com>
 <20191001150734.GA2714@lahna.fi.intel.com>
 <1569947262.2639.15.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569947262.2639.15.camel@suse.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 06:27:42PM +0200, Oliver Neukum wrote:
> Am Dienstag, den 01.10.2019, 18:07 +0300 schrieb Mika Westerberg:
> 
> Hi,
> 
> > OK, but does that break existing .configs? I mean if you have already
> > CONFIG_THUNDERBOLT in your .config/defconfig does it now just get
> > dropped silently?
> 
> People will have to look at this new stuff anyway.
> 
> > For example firewire has CONFIG_FIREWIRE even though the "standard" name
> > is IEEE 1394. I was thinking maybe we can do the same for
> > USB4/Thunderbolt
> 
> USB and Thunderbolt used to be distinct protocols. Whereas Firewire
> was just a colloquial name for IEEE1394. Please be wordy here.
> "Unified support for USB4 and Thunderbolt4"

OK.

I've been thinking this bit more and since Thunderbolt will stick around
as well (it basically implements all the optional USB4 features and
more) so would it make sense to have the Kconfig option be
CONFIG_THUNDERBOLT_USB4 (or CONFIG_USB4_THUNDERBOLT)? That should cover
both.

Comments?

Also does anyone have any thoughts about keeping the driver under
drivers/thunderbolt vs. moving it under usb like
drivers/usb/thunderbolt? I'm thinking if anyone not familiar with this
tries to enable support for USB4 so the first place he/she probably
looks is under "USB support" menuconfig entry.
