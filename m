Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F410C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 12:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B262147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 12:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfENMis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 08:38:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:56137 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfENMis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 08:38:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 05:38:47 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 14 May 2019 05:38:44 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1hQWhf-0007xn-3y; Tue, 14 May 2019 15:38:43 +0300
Date:   Tue, 14 May 2019 15:38:43 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Esben Haabendal <esben@haabendal.dk>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>,
        Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device
 resources
Message-ID: <20190514123843.GC9224@smile.fi.intel.com>
References: <20190502104556.GS9224@smile.fi.intel.com>
 <87pnp11112.fsf@haabendal.dk>
 <20190507093239.GB4529@dell>
 <87sgtqjy3l.fsf@haabendal.dk>
 <20190507115325.GV9224@smile.fi.intel.com>
 <87k1f2jvyd.fsf@haabendal.dk>
 <20190507150847.GW9224@smile.fi.intel.com>
 <87k1etmrfk.fsf@haabendal.dk>
 <CAHp75VfrP6SLVzmp6LepN7dU1c7QYxfRDRtj7dCTuWzmYp2tCA@mail.gmail.com>
 <871s11meg3.fsf@haabendal.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871s11meg3.fsf@haabendal.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 02:02:36PM +0200, Esben Haabendal wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> > On Tue, May 14, 2019 at 10:24 AM Esben Haabendal <esben@haabendal.dk> wrote:
> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> >> > On Tue, May 07, 2019 at 02:22:18PM +0200, Esben Haabendal wrote:
> >
> >> We are on repeat here.  I don't agree with you here.  I have a simple
> >> generic 8250 (16550A) compatible device, and cannot use it in a mfd
> >> driver using the standard mfd-core framework.
> >
> >> The lacking of support for platform_get_resource() in the generic
> >> serial8250 driver is not a feature.  It should be supported, just as it
> >> is in several of the specialized 8250 drivers.
> >
> > We are going circles here.
> > What exactly prevents you to use it? Presence of request_mem_region()?
> 
> Exactly.

And I completely tired to repeat that this is okay and does not prevent you to
use MFD.

> >> It would still mean that I would have revert to not using convenient and
> >> otherwise fully appropriate API calls like pci_request_regions() and
> >> mfd_add_devices().
> >
> > Yes, here is the issue. 8250 requires the parent not to *request*
> > resources. Because child handles IO access itself.
> 
> Ok, clearly we are not discussing the actual IO access.  The only issue
> is how to handle the memory resource management.
> 
> And yes, serial8250 requires "the parent" to not request the resources.
> But by doing so, it gets in the way of the mfd-core way of splitting a
> properly requested resource.

Which is right thing to do. Requesting resources should be done by their actual
user, no?

Moreover, if you look at /proc/iomem, for example, I bet there will be
a difference with your proposed method and a established one.

> >> The mfd driver in question is for a PCI device.  Not being able to
> >> request the PCI regions seems silly.
> >
> > Nope. Otherwise, the parent which *doesn't handle* IO on behalf of
> > child should not request its resources.
> 
> If I may, could I get you to discuss this with Lee Jones?
> 
> As I read both of your comments in this thread, you are not aligned on
> how mfd drivers should handle resources.  And in that case, one of you
> are most likely more right than the other, and if Lee is right, I seem
> to be unable to convince you about that.

MFD has nothing to do with *requesting* resource. It's about *slicing* them.
*Requesting* resource is orthogonal to the *slicing*.

> >> Not being able to register all child devices with the call introduced
> >> for that sole purpose also seems silly.
> >
> >> Please take a look at https://lkml.org/lkml/2019/4/9/576
> >> ("[PATCH v2 2/4] mfd: ioc3: Add driver for SGI IOC3 chip")
> >
> > Thank you for this link.
> > Now, look at this comment:
> >
> > + /*
> > + * Map all IOC3 registers.  These are shared between subdevices
> > + * so the main IOC3 module manages them.
> > + */
> >
> > Is it your case? Can we see the code?
> 
> That comment seems quite misleading.  I am quote certain that the uart
> registers which are part of BAR 0 is not more shared between subdevices
> than the uart registers in BAR 0 in my case.
> 
> But BAR 0 as a whole is shared between subdevices.  But BAR 0 can be
> (is) split in parts that are exclusive to one subdevice.  The only
> difference I see is that I don't have any registers accessed directly by
> the mfd driver.

I stopped here. Let's discuss an actual code.

-- 
With Best Regards,
Andy Shevchenko


