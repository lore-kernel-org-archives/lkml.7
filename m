Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F577C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5413C20674
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfKVL32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:29:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:30924 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbfKVL31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:29:27 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 03:29:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,229,1571727600"; 
   d="scan'208";a="216346463"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 22 Nov 2019 03:29:22 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 22 Nov 2019 13:29:21 +0200
Date:   Fri, 22 Nov 2019 13:29:21 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Christian Kellner <ck@xatom.net>, linux-kernel@vger.kernel.org,
        Anthony Wong <anthony.wong@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: USB devices on Dell TB16 dock stop working after resuming
Message-ID: <20191122112921.GF11621@lahna.fi.intel.com>
References: <20191104142459.GC2552@lahna.fi.intel.com>
 <20191104144436.GD2552@lahna.fi.intel.com>
 <20191104154446.GH2552@lahna.fi.intel.com>
 <ea829adedf0445c0845e25d6e4b47905@AUSX13MPC105.AMER.DELL.COM>
 <d8cb6bc6-8145-eaed-5ba4-d7291478bdd7@molgen.mpg.de>
 <20191104162103.GI2552@lahna.fi.intel.com>
 <f0257624-920e-eec4-a2ec-7adf8ecbcc9d@molgen.mpg.de>
 <20191120105048.GY11621@lahna.fi.intel.com>
 <20191122105012.GD11621@lahna.fi.intel.com>
 <edfe1e3c-779b-61e4-8551-f2e13d46d733@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edfe1e3c-779b-61e4-8551-f2e13d46d733@molgen.mpg.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 12:05:13PM +0100, Paul Menzel wrote:
> Dear Mika,
> 
> 
> Thank you so much for looking into this issue.
> 
> 
> On 2019-11-22 11:50, Mika Westerberg wrote:
> > On Wed, Nov 20, 2019 at 12:50:53PM +0200, Mika Westerberg wrote:
> >> On Tue, Nov 19, 2019 at 05:55:43PM +0100, Paul Menzel wrote:
> 
> >>> On 2019-11-04 17:21, Mika Westerberg wrote:
> >>>> On Mon, Nov 04, 2019 at 05:11:10PM +0100, Paul Menzel wrote:
> >>>
> >>>>> On 2019-11-04 16:49, Mario.Limonciello@dell.com wrote:
> >>>>>
> >>>>>>> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> >>>>>>> Sent: Monday, November 4, 2019 9:45 AM
> >>>>>
> >>>>>>> On Mon, Nov 04, 2019 at 04:44:40PM +0200, Mika Westerberg wrote:
> >>>>>>>> On Mon, Nov 04, 2019 at 04:25:03PM +0200, Mika Westerberg wrote:
> >>>>>
> >>>>>>>>> On Mon, Nov 04, 2019 at 02:13:13PM +0100, Paul Menzel wrote:
> >>>>>
> >>>>>>>>>> On the Dell XPS 13 9380 with Debian Sid/unstable with Linux 5.3.7
> >>>>>>>>>> suspending the system, and resuming with Dell’s Thunderbolt TB16
> >>>>>>>>>> dock connected, the USB input devices, keyboard and mouse,
> >>>>>>>>>> connected to the TB16 stop working. They work for a few seconds
> >>>>>>>>>> (mouse cursor can be moved), but then stop working. The laptop
> >>>>>>>>>> keyboard and touchpad still works fine. All firmware is up-to-date
> >>>>>>>>>> according to `fwupdmgr`.
> >>>>>>>>>
> >>>>>>>>> What are the exact steps to reproduce? Just "echo mem >
> >>>>>>>>> /sys/power/state" and then resume by pressing power button?
> >>>>>
> >>>>> GNOME Shell 3.34.1+git20191024-1 is used, and the user just closes the
> >>>>> display. So more than `echo mem > /sys/power/state` is done. What
> >>>>> distribution do you use?
> >>>>
> >>>> I have buildroot based "distro" so there is no UI running.
> >>>
> >>> Hmm, this is quite different from the “normal” use-case of the these devices.
> >>> That way you won’t hit the bugs of the normal users. ;-)
> >>
> >> Well, I can install some distro to that thing also :) I suppose Debian
> >> 10.2 does have this issue, no?
> >>
> >>>>>>>> I tried v5.4-rc6 on my 9380 with TB16 dock connected and did a couple of
> >>>>>>>> suspend/resume cycles (to s2idle) but I don't see any issues.
> >>>>>>>>
> >>>>>>>> I may have older/different firmware than you, though.
> >>>>>>>
> >>>>>>> Upgraded BIOS to 1.8.0 and TBT NVM to v44 but still can't reproduce this
> >>>>>>> on my system :/
> >>>>>
> >>>>> The user reported the issue with the previous firmwares 1.x and TBT NVM v40.
> >>>>> Updating to the recent version (I got the logs with) did not fix the issue.
> >>>>
> >>>> I also tried v40 (that was originally on that system) but I was not able
> >>>> to reproduce it.
> >>>>
> >>>> Do you know if the user changed any BIOS settings?
> >>>
> >>> We had to disable the Thunderbolt security settings as otherwise the USB
> >>> devices wouldn’t work at cold boot either.
> >>
> >> That does not sound right at all. There is the preboot ACL that allows
> >> you to use TBT dock aready on boot. Bolt takes care of this.
> >>
> >> Are you talking about USB devices connected to the TB16 dock?
> >>
> >> Also are you connecting the TB16 dock to the Thunderbolt ports (left
> >> side of the system marked with small lightning logo) or to the normal
> >> Type-C ports (right side)?
> >>
> >>> So, I built Linux 5.4-rc8 (`make bindeb-pkg -j8`), but unfortunately the
> >>> error is still there. Sometimes, re-plugging the dock helped, and sometimes
> >>> it did not.
> >>>
> >>> Please find the logs attached. The strange thing is, the Linux kernel detects
> >>> the devices and I do not see any disconnect events. But, `lsusb` does not list
> >>> the keyboard and the mouse. Is that expected.
> >>
> >> I'm bit confused. Can you describe the exact steps what you do (so I can
> >> replicate them).
> > 
> > I managed to reproduce following scenario.
> > 
> > 1. Boot the system up to UI
> > 2. Connect TB16 dock (and see that it gets authorized by bolt)
> > 3. Connect keyboard and mouse to the TB16 dock
> > 4. Both mouse and keyboard are functional
> > 5. Enter s2idle by closing laptop lid
> > 6. Exit s2idle by opening the laptop lid
> > 7. After ~10 seconds or so the mouse or keyboard or both do not work
> >    anymore. They do not respond but they are still "present".
> > 
> > The above does not happen always but from time to time.
> > 
> > Is this the scenario you see as well?
> 
> Yes, it is. Though I’d say it’s only five seconds or so.
> 
> > This is on Ubuntu 19.10 with the 5.3 stock kernel.
> 
> “stock” in upstream’s or Ubuntu’s?

It is Ubuntu's.

> > I can get them work again by unplugging them and plugging back (leaving
> > the TBT16 dock connected). Also if you run lspci when the problem
> > occurs it still shows the dock so PCIe link stays up.
> 
> Re-connecting the USB devices does not help here, but I still suspect it’s
> the same issue.

Yeah, sounds like so. Did you try to connect the device (mouse,
keyboard) to anoter USB port?

> Yesterday, I had my hand on a Dell XPS 13 7390 (10th Intel generation) and
> tried it with the shipped Ubuntu 18.04 LTS. There, the problem was not
> always reproducible, but it still happened. Sometimes, only one of the USB
> device (either keyboard or mouse) stopped working.

I suppose this is also with the TB16 dock connected, correct?
