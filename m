Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C34C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89752206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfC0R3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:29:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:28008 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbfC0R3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:29:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 10:29:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,277,1549958400"; 
   d="scan'208";a="135290404"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga008.fm.intel.com with SMTP; 27 Mar 2019 10:29:41 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 27 Mar 2019 19:29:40 +0200
Date:   Wed, 27 Mar 2019 19:29:40 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Daniel Drake <drake@endlessm.com>
Cc:     Chris Chiu <chiu@endlessm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH] pinctrl: intel: save HOSTSW_OWN register over
 suspend/resume
Message-ID: <20190327172940.GR3622@lahna.fi.intel.com>
References: <20171115101302.GA17200@lahna.fi.intel.com>
 <CAB4CAwc-SFtw4+74Qe-vX57JRGDjJMt9xM2+ev3OiipzwxBPBw@mail.gmail.com>
 <20171116124431.GS17200@lahna.fi.intel.com>
 <CAB4CAwfHx8DgCYk0piVnrTa7YP2=6A8Le4ekoENFPyNVF9g1rw@mail.gmail.com>
 <20171117064904.GZ17200@lahna.fi.intel.com>
 <CAB4CAwdGQjXc6gsswyCgLTfFRN9CgcC=OJ6pz4rX-HCn8AT-TQ@mail.gmail.com>
 <20171121105205.GP22431@lahna.fi.intel.com>
 <CAB4CAwcjXi=YX+0PEC6wBdfAZ=am+BceB4HCFzTXzdts_FE2vQ@mail.gmail.com>
 <20171121120422.GR22431@lahna.fi.intel.com>
 <CAD8Lp444FNHZh6fLUfhfp1i_UBpMbS5QuvJ4FuZn7PKH1Ucy=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD8Lp444FNHZh6fLUfhfp1i_UBpMbS5QuvJ4FuZn7PKH1Ucy=A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Andy

On Wed, Mar 27, 2019 at 04:22:04PM +0800, Daniel Drake wrote:
> Hi Mika,
> 
> Digging up this old thread again...
> 
> On Tue, Nov 21, 2017 at 8:13 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Tue, Nov 21, 2017 at 07:54:26PM +0800, Chris Chiu wrote:
> > > Yup, I checked the value of the corresponded pin. It shows following before
> > > suspend
> > > pin 18 (GPIO_18) GPIO 0x40800102 0x00024075
> > >
> > > Then after resume
> > > pin 18 (GPIO_18) GPIO 0x40800102 0x00024075 [ACPI]
> >
> > OK, so ownership is changed to ACPI.
> >
> > > What else register do you suggest me to compare? The PADCFG2 is invalid
> >
> > It's fine APL does not have PADCFG2.
> >
> > Hmm, I don't understand how this can work in Windows either. The Windows
> > people told me that they don't save and restore anything else than
> > padcfg registers + ie. If the ownership is changed to ACPI it means you
> > don't get interrupts anymore (only GPEs) and that applies to Windows as
> > well.
> 
> In the mails after the one quoted above, we reported back to you that
> the new BIOS from Asus solved the issue.
> 
> However, during the time that has followed, we have had numerous user
> reports from Asus E403NA, X540NA, and X541NA laptops (basically the
> same models that we originally discussed) where the touchpad stops
> working after suspend/resume, even with the latest BIOS. We managed to
> get an affected E403NA unit in-hands again, and confirmed that
> HOSTSW_OWN was being lost like we had observed before.
> 
> Unfortunately as this was a customer laptop we had to return it
> immediately, before we could investigate further. We don't have access
> to any more units since they are old models now.
> 
> However I'm wondering if you have any other ideas or if you think
> something like our workaround patch might be acceptable under these
> circumstances:
> https://github.com/endlessm/linux/commit/f391452299f62a3d0cbe5333be90f69e9895d8ff

I wonder if it would be simpler to save it always and then upon resume
compare them and if changed, log this in dmesg and restore the saved
one.
