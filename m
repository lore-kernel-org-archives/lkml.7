Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78504CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533F620848
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbfKDQVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 11:21:09 -0500
Received: from mga14.intel.com ([192.55.52.115]:37244 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbfKDQVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:21:09 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 08:21:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,267,1569308400"; 
   d="scan'208";a="212343225"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 04 Nov 2019 08:21:04 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 04 Nov 2019 18:21:03 +0200
Date:   Mon, 4 Nov 2019 18:21:03 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Christian Kellner <ck@xatom.net>, linux-kernel@vger.kernel.org,
        Anthony Wong <anthony.wong@canonical.com>
Subject: Re: USB devices on Dell TB16 dock stop working after resuming
Message-ID: <20191104162103.GI2552@lahna.fi.intel.com>
References: <5d2b39bc-5952-c2b6-63b3-bce28122ffd5@molgen.mpg.de>
 <20191104142459.GC2552@lahna.fi.intel.com>
 <20191104144436.GD2552@lahna.fi.intel.com>
 <20191104154446.GH2552@lahna.fi.intel.com>
 <ea829adedf0445c0845e25d6e4b47905@AUSX13MPC105.AMER.DELL.COM>
 <d8cb6bc6-8145-eaed-5ba4-d7291478bdd7@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8cb6bc6-8145-eaed-5ba4-d7291478bdd7@molgen.mpg.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 05:11:10PM +0100, Paul Menzel wrote:
> Dear Mika, dear Mario,
> 
> 
> On 2019-11-04 16:49, Mario.Limonciello@dell.com wrote:
> 
> >> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> >> Sent: Monday, November 4, 2019 9:45 AM
> 
> >> On Mon, Nov 04, 2019 at 04:44:40PM +0200, Mika Westerberg wrote:
> >>> On Mon, Nov 04, 2019 at 04:25:03PM +0200, Mika Westerberg wrote:
> 
> >>>> On Mon, Nov 04, 2019 at 02:13:13PM +0100, Paul Menzel wrote:
> 
> >>>>> On the Dell XPS 13 9380 with Debian Sid/unstable with Linux 5.3.7
> >>>>> suspending the system, and resuming with Dell’s Thunderbolt TB16
> >>>>> dock connected, the USB input devices, keyboard and mouse,
> >>>>> connected to the TB16 stop working. They work for a few seconds
> >>>>> (mouse cursor can be moved), but then stop working. The laptop
> >>>>> keyboard and touchpad still works fine. All firmware is up-to-date
> >>>>> according to `fwupdmgr`.
> >>>>
> >>>> What are the exact steps to reproduce? Just "echo mem >
> >>>> /sys/power/state" and then resume by pressing power button?
> 
> GNOME Shell 3.34.1+git20191024-1 is used, and the user just closes the
> display. So more than `echo mem > /sys/power/state` is done. What
> distribution do you use?

I have buildroot based "distro" so there is no UI running.

> >>> I tried v5.4-rc6 on my 9380 with TB16 dock connected and did a couple of
> >>> suspend/resume cycles (to s2idle) but I don't see any issues.
> >>>
> >>> I may have older/different firmware than you, though.
> >>
> >> Upgraded BIOS to 1.8.0 and TBT NVM to v44 but still can't reproduce this
> >> on my system :/
> 
> The user reported the issue with the previous firmwares 1.x and TBT NVM v40.
> Updating to the recent version (I got the logs with) did not fix the issue.

I also tried v40 (that was originally on that system) but I was not able
to reproduce it.

Do you know if the user changed any BIOS settings?
