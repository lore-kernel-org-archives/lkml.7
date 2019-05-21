Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDDDC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C47C21773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfEURD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 13:03:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:30950 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728175AbfEURD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 13:03:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 10:03:55 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga006.jf.intel.com with ESMTP; 21 May 2019 10:03:51 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hT8B4-0001g3-AK; Tue, 21 May 2019 20:03:50 +0300
Date:   Tue, 21 May 2019 20:03:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Esben Haabendal <esben@haabendal.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Enrico Weigelt <lkml@metux.net>, Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>,
        Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] serial: 8250: Add support for using
 platform_device resources
Message-ID: <20190521170350.GL9224@smile.fi.intel.com>
References: <20190430140416.4707-1-esben@geanix.com>
 <20190521113426.16790-1-esben@geanix.com>
 <20190521124202.GE9224@smile.fi.intel.com>
 <87d0kbna0p.fsf@haabendal.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0kbna0p.fsf@haabendal.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 04:43:18PM +0200, Esben Haabendal wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> 
> > On Tue, May 21, 2019 at 01:34:26PM +0200, Esben Haabendal wrote:
> >> Allow getting memory resource (mapbase or iobase) as well as irq from
> >> platform_device resources.
> >> 
> >> The UPF_DEV_RESOURCES flag must be set for devices where platform_device
> >> resources are to be used.  When not set, driver behaves as before.
> >> 
> >> This allows use of the serial8250 driver together with devices with
> >> resources added by platform_device_add_resources(), such as mfd child
> >> devices added with mfd_add_devices().
> >> 
> >> When UPF_DEV_RESOURCES flag is set, the following platform_data fields should
> >> not be used: mapbase, iobase, mapsize, and irq.  They are superseded by the
> >> resources attached to the device.
> >> 
> >
> > Same comment here: Requesting resource is orthogonal to the retrieving or
> > slicing them.
> 
> Yes.  But for MFD devices, I do think it makes sense for the MFD parent
> device to request the entire memory resource, and then split it.

Nope. This is layering violation here: The user of the resources is not
handling them in full.

> And for drivers that actually are aware of the struct resource given,
> both approaches work.  Throwing away the resource.parent information
> and calling out request_mem_region() manually breaks the idea of
> managing IORESOURCE_MEM as a tree structure.

How come? Can you show an example of output without and with your patches?

> Are we not supposed to be using the parent/child part of struct
> resource?

It's about slicing, no-one prevents you to do that. I don't see a problem.
Show the output!

> >> -		if (!request_mem_region(port->mapbase, size, "serial")) {
> >> +		if (!(port->flags & UPF_DEV_RESOURCES) &&
> >> +		    !request_mem_region(port->mapbase, size, "serial")) {
> >
> >> -				release_mem_region(port->mapbase, size);
> >> +				if (!(port->flags & UPF_DEV_RESOURCES))
> >> +					release_mem_region(port->mapbase, size);
> >
> >> -		if (!request_region(port->iobase, size, "serial"))
> >> +		if (!(port->flags & UPF_DEV_RESOURCES) &&
> >> +		    !request_region(port->iobase, size, "serial"))
> >
> >> -		release_mem_region(port->mapbase, size);
> >> +		if (!(port->flags & UPF_DEV_RESOURCES))
> >> +			release_mem_region(port->mapbase, size);
> >
> >> -		release_region(port->iobase, size);
> >> +		if (!(port->flags & UPF_DEV_RESOURCES))
> >> +			release_region(port->iobase, size);
> >
> > All these changes are not related to what you describe in the commit message.
> > is a workaround for the bug in the parent MFD driver of the 8250.
> 
> You are right, this is not adequately described in commit message.
> But unless we are not supposed to allow parent/child memory resource
> management, I don't think it is a workaround, but a fix.
> 
> But I can split it out in a separate patch.  Would be nice if I at least
> can get the other part of the change merged.

Like Lee said, and I agree, nothing prevents us to switch to
platform_get_resource().

The stumbling block here is the *requesting* in parent which I strongly
disagree with (at least in a form of this change, I already told you, that this
has to be "fixed" on generic level, not as a hack in one certain driver).

-- 
With Best Regards,
Andy Shevchenko


