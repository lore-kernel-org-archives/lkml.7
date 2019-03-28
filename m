Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4ABC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1723217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfC1Met (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:34:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:31697 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbfC1Mes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:34:48 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 05:34:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="126618696"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga007.jf.intel.com with SMTP; 28 Mar 2019 05:34:44 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 28 Mar 2019 14:34:44 +0200
Date:   Thu, 28 Mar 2019 14:34:44 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Chris Chiu <chiu@endlessm.com>
Cc:     Daniel Drake <drake@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: [PATCH] pinctrl: intel: save HOSTSW_OWN register over
 suspend/resume
Message-ID: <20190328123444.GX3622@lahna.fi.intel.com>
References: <20171117064904.GZ17200@lahna.fi.intel.com>
 <CAB4CAwdGQjXc6gsswyCgLTfFRN9CgcC=OJ6pz4rX-HCn8AT-TQ@mail.gmail.com>
 <20171121105205.GP22431@lahna.fi.intel.com>
 <CAB4CAwcjXi=YX+0PEC6wBdfAZ=am+BceB4HCFzTXzdts_FE2vQ@mail.gmail.com>
 <20171121120422.GR22431@lahna.fi.intel.com>
 <CAD8Lp444FNHZh6fLUfhfp1i_UBpMbS5QuvJ4FuZn7PKH1Ucy=A@mail.gmail.com>
 <20190327172940.GR3622@lahna.fi.intel.com>
 <20190328091729.GV9224@smile.fi.intel.com>
 <CAD8Lp44xuzHj4uu3a-Y9wscSyEmuG6=nbww6T9-9FaYZT_qYsw@mail.gmail.com>
 <CAB4CAwfH237-EUgfyR8-KWKo0HJOf=QkxiNjkBRg+gBpbKiM7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB4CAwfH237-EUgfyR8-KWKo0HJOf=QkxiNjkBRg+gBpbKiM7g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 08:19:59PM +0800, Chris Chiu wrote:
> On Thu, Mar 28, 2019 at 5:38 PM Daniel Drake <drake@endlessm.com> wrote:
> >
> > On Thu, Mar 28, 2019 at 5:17 PM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > Hmm... Can you confirm that laptop you declared as a fixed case and the
> > > mentioned here is the same one?
> >
> > They are definitely not the same exact unit - originally we had a
> > pre-production sample, and now we briefly diagnosed a real production
> > unit that was sold to a customer. There could be subtle motherboard
> > variations as you mention.
> >
> > > If it's the case, I recommend to ping Asus again and make them check and fix.
> >
> > We'll keep an eye open for any opportunities to go deeper here.
> > However further investigation on both our side and theirs is blocked
> > by not having any of the affected hardware (since the models are now
> > so old), so I'm not very optimistic that we'll be able to make
> > progress there.
> >
> > > Meanwhile, Mika's proposal sounds feasible and not so intrusive. We may
> > > implement this later on.
> >
> > Chris will work on implementing this for your consideration.
> >
> > Thanks for the quick feedback!
> > Daniel
> 
> What if I modify the patch as follows? It doesn't save HOSTSW_OWN register.
> It just toggles the bit specifically for the IRQ GPIO pin after resume when DMI
> matches.

I don't really like having quirks like this if we can avoid it and in
this case I think we can. Just always save HOSTSW_OWN and then restore
it if there is a GPIO requested and the value differs (and log a warning
or something like that).
