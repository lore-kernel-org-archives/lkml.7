Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802EFC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5D520825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfEGLxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 07:53:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:22953 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfEGLxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 07:53:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 04:53:31 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 07 May 2019 04:53:27 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hNyez-00033G-L0; Tue, 07 May 2019 14:53:25 +0300
Date:   Tue, 7 May 2019 14:53:25 +0300
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
Message-ID: <20190507115325.GV9224@smile.fi.intel.com>
References: <20190430140416.4707-1-esben@geanix.com>
 <20190430153736.GL9224@smile.fi.intel.com>
 <874l6efxta.fsf@haabendal.dk>
 <20190502104556.GS9224@smile.fi.intel.com>
 <87pnp11112.fsf@haabendal.dk>
 <20190507093239.GB4529@dell>
 <87sgtqjy3l.fsf@haabendal.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgtqjy3l.fsf@haabendal.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 01:35:58PM +0200, Esben Haabendal wrote:
> Lee Jones <lee.jones@linaro.org> writes:
> > On Thu, 02 May 2019, Esben Haabendal wrote:
> >
> >> Could you help clarify whether or not this patch is trying to do
> >> something odd/wrong?
> >> 
> >> I might be misunderstanding Andy (probably is), but the discussion
> >> revolves around the changes I propose where I change the serial8250
> >> driver to use platform_get_resource() in favour of
> >> request_mem_region()/release_mem_region().
> >
> > Since 'serial8250' is registered as a platform device, I don't see any
> > reason why it shouldn't have the capability to obtain its memory
> > regions from the platform_get_*() helpers.
> 
> Good to hear.  That is exactly what I am trying do with this patch.
> 
> @Andy: If you still don't like my approach, could you please advice an
> acceptable method for improving the serial8250 driver to allow the use
> of platform_get_*() helpers?

I still don't get why you need this.

If it's MFD, you may use "serial8250" with a given platform data like dozens of
current users do.

Another approach is to use 8250 library, thus, creating a specific glue driver
(like all 8250_* do).

Yes, I understand that 8250 driver is full of quirks and not modern approaches
to do one or another thing. Unfortunately it's not too easy to fix it without
uglifying code and doing some kind of ping-pong thru the conversion. I don't
think it worth to do it in the current state of affairs. Though, cleaning up
the core part from the quirks and custom pieces would make this task
achievable.

I'm also puzzled why you don't use FPGA manager which should handle, as far as
I understand, very flexible configurations of FPGAs.

Btw, what exact IP of UART do you have implemented there?

-- 
With Best Regards,
Andy Shevchenko


