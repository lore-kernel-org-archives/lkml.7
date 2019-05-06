Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8421C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B8720578
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfEFQob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 12:44:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:37006 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbfEFQob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:44:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 09:44:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="168539904"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga002.fm.intel.com with ESMTP; 06 May 2019 09:44:27 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hNgj4-0000Se-6N; Mon, 06 May 2019 19:44:26 +0300
Date:   Mon, 6 May 2019 19:44:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Esben Haabendal <esben@haabendal.dk>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-serial@vger.kernel.org,
        Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>,
        Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device
 resources
Message-ID: <20190506164426.GO9224@smile.fi.intel.com>
References: <20190430140416.4707-1-esben@geanix.com>
 <20190430153736.GL9224@smile.fi.intel.com>
 <874l6efxta.fsf@haabendal.dk>
 <20190502104556.GS9224@smile.fi.intel.com>
 <87pnp11112.fsf@haabendal.dk>
 <20190502153124.GA9224@smile.fi.intel.com>
 <87ef5boaa7.fsf@haabendal.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ef5boaa7.fsf@haabendal.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 05:46:56PM +0200, Esben Haabendal wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> >> > On Wed, May 01, 2019 at 09:17:37AM +0200, Esben Haabendal wrote:
> >> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> As an example, the sm501.c driver, the only driver in drivers/mfd/ which
> uses serial8250 driver, does not use any code from mfd-core.
> Incidentally, it is 1 year older than mfd-core.c, and as never been
> refactored to use mfd-core functionality.

So, sm501.c should not request resources for its children. This as simple as
that.

What you are trying to do here is a hack workaround on the current behaviour in
the Linux device model (resource management) as I told you already.

> > Why not? Again, *slicing* resources is OK and that's what MFD for, *requesting*
> > them in the parent is not.
> 
> Why we cannot use request_mem_region() for those memory resources again?

Because it's how it was designed. "One device per one resource". If you would
like to fix this, it should be done obviously not in 8250 driver or any other
driver, but driver core.

Nevertheless there is one particular exception here, i.e. IORESOURCE_MUXED.

> It fails because the resources are now already owned the mfd driver, on
> behalf of the child.

Yes. Behaves in order how it's implementer. No issues here.

> > Nope, *requesting* resources as you mentioned lock them to the certain user.
> 
> I still think there is some confusion in relation to your use of the
> word "requesting".  There is no explicit request/lock action in
> kernel/resource.c.

You have to check IORESOURCE_BUSY. It seems that what you missed in your
picture.

I didn't comment the rest until we will figure out the IO resource management
in general.

-- 
With Best Regards,
Andy Shevchenko


