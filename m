Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0524C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7850B2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfC1JRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:17:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:12794 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfC1JRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 05:17:34 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 02:17:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="311094368"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga005.jf.intel.com with ESMTP; 28 Mar 2019 02:17:31 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1h9RA9-0000TT-VO; Thu, 28 Mar 2019 11:17:29 +0200
Date:   Thu, 28 Mar 2019 11:17:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Daniel Drake <drake@endlessm.com>, Chris Chiu <chiu@endlessm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: [PATCH] pinctrl: intel: save HOSTSW_OWN register over
 suspend/resume
Message-ID: <20190328091729.GV9224@smile.fi.intel.com>
References: <CAB4CAwc-SFtw4+74Qe-vX57JRGDjJMt9xM2+ev3OiipzwxBPBw@mail.gmail.com>
 <20171116124431.GS17200@lahna.fi.intel.com>
 <CAB4CAwfHx8DgCYk0piVnrTa7YP2=6A8Le4ekoENFPyNVF9g1rw@mail.gmail.com>
 <20171117064904.GZ17200@lahna.fi.intel.com>
 <CAB4CAwdGQjXc6gsswyCgLTfFRN9CgcC=OJ6pz4rX-HCn8AT-TQ@mail.gmail.com>
 <20171121105205.GP22431@lahna.fi.intel.com>
 <CAB4CAwcjXi=YX+0PEC6wBdfAZ=am+BceB4HCFzTXzdts_FE2vQ@mail.gmail.com>
 <20171121120422.GR22431@lahna.fi.intel.com>
 <CAD8Lp444FNHZh6fLUfhfp1i_UBpMbS5QuvJ4FuZn7PKH1Ucy=A@mail.gmail.com>
 <20190327172940.GR3622@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327172940.GR3622@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 07:29:40PM +0200, Mika Westerberg wrote:
> On Wed, Mar 27, 2019 at 04:22:04PM +0800, Daniel Drake wrote:
> > On Tue, Nov 21, 2017 at 8:13 PM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > > On Tue, Nov 21, 2017 at 07:54:26PM +0800, Chris Chiu wrote:
> > > > Yup, I checked the value of the corresponded pin. It shows following before
> > > > suspend
> > > > pin 18 (GPIO_18) GPIO 0x40800102 0x00024075
> > > >
> > > > Then after resume
> > > > pin 18 (GPIO_18) GPIO 0x40800102 0x00024075 [ACPI]
> > >
> > > OK, so ownership is changed to ACPI.
> > >
> > > > What else register do you suggest me to compare? The PADCFG2 is invalid
> > >
> > > It's fine APL does not have PADCFG2.
> > >
> > > Hmm, I don't understand how this can work in Windows either. The Windows
> > > people told me that they don't save and restore anything else than
> > > padcfg registers + ie. If the ownership is changed to ACPI it means you
> > > don't get interrupts anymore (only GPEs) and that applies to Windows as
> > > well.
> > 
> > In the mails after the one quoted above, we reported back to you that
> > the new BIOS from Asus solved the issue.
> > 
> > However, during the time that has followed, we have had numerous user
> > reports from Asus E403NA, X540NA, and X541NA laptops (basically the
> > same models that we originally discussed) where the touchpad stops
> > working after suspend/resume, even with the latest BIOS. We managed to
> > get an affected E403NA unit in-hands again, and confirmed that
> > HOSTSW_OWN was being lost like we had observed before.

Hmm... Can you confirm that laptop you declared as a fixed case and the
mentioned here is the same one?

If they are different, I have a theory that PCBs of those two are not the same
and used GPIO pin can be also not the same, therefore the BIOS fixes only one
revision of the model, but didn't consider the rest.

If it's the case, I recommend to ping Asus again and make them check and fix.

Meanwhile, Mika's proposal sounds feasible and not so intrusive. We may
implement this later on.

> > 
> > Unfortunately as this was a customer laptop we had to return it
> > immediately, before we could investigate further. We don't have access
> > to any more units since they are old models now.
> > 
> > However I'm wondering if you have any other ideas or if you think
> > something like our workaround patch might be acceptable under these
> > circumstances:
> > https://github.com/endlessm/linux/commit/f391452299f62a3d0cbe5333be90f69e9895d8ff
> 
> I wonder if it would be simpler to save it always and then upon resume
> compare them and if changed, log this in dmesg and restore the saved
> one.

-- 
With Best Regards,
Andy Shevchenko


