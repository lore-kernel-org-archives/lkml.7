Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C4FC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7626D2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbfFMPbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:31:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:20387 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728631AbfFMLFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:05:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 04:05:32 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga001.jf.intel.com with ESMTP; 13 Jun 2019 04:05:30 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hbNXt-0003ZP-BF; Thu, 13 Jun 2019 14:05:29 +0300
Date:   Thu, 13 Jun 2019 14:05:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2 v5] tty/serial/8250: use mctrl_gpio helpers
Message-ID: <20190613110529.GR9224@smile.fi.intel.com>
References: <20190611105603.4435-1-sr@denx.de>
 <20190611105603.4435-2-sr@denx.de>
 <20190611124415.GT9224@smile.fi.intel.com>
 <85f0d39c-e5d8-320b-e611-d956630a629f@denx.de>
 <20190611144828.GX9224@smile.fi.intel.com>
 <12e5180e-b4a0-e5fa-bcad-ddc8103d644c@denx.de>
 <20190612091621.GA9224@smile.fi.intel.com>
 <6a4f1001-b023-c972-7b36-6d2f8f9a3fa8@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a4f1001-b023-c972-7b36-6d2f8f9a3fa8@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 07:32:39AM +0200, Stefan Roese wrote:
> On 12.06.19 11:16, Andy Shevchenko wrote:
> > On Wed, Jun 12, 2019 at 10:13:05AM +0200, Stefan Roese wrote:
> > > On 11.06.19 16:48, Andy Shevchenko wrote:

> > > Do you something like this in mind?
> > 
> > More likely
> > 
> > static inline int serial8250_MCR_to_TIOCM(int mcr)
> 
> MSR_to_TIOCM (see below) ...

Yes. true.

> > {
> > 	int tiocm = 0;
> > 
> > 	if (mcr & ...)
> > 		tiocm |= ...;
> > 	...
> > 
> > 	return tiocm;
> > }
> > 
> > static inline int serial8250_TIOCM_to_MCR(int tiocm)
> > {
> > 	... in a similar way ...
> > }
> 
> While implementing such wrapper functions I noticed, that get_mctrl() /
> set_mctrl() need TIOCM->MCR and MSR->TIOCM (notice MSR vs MCR here) but
> serial8250_in_MCR() needs MCR->TIOCM. So there is not that much
> overlay here.

It seems not only this driver is using such conversion. It's even possible to
move it to serial level for all.

> Additionally the wrappers would need to handle all bits
> and only some of them are needed in serial8250_in/out_MCR(),
> so I would
> need to add masking here as well.

I don't see this. You will get a value for exclusive bits only. No additional
mask would be needed.

> For my taste its not really worth adding these wrappers as they won't
> make things much clearer (if at all).

Hmm.. For me it would be quite clear if something with proposed name would be
called in the code.

-- 
With Best Regards,
Andy Shevchenko


