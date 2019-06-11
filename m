Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B117EC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2B12054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391579AbfFKOsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:48:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:14951 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389454AbfFKOsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:48:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 07:48:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,579,1557212400"; 
   d="scan'208";a="183821262"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jun 2019 07:48:29 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hai4a-00065P-Ol; Tue, 11 Jun 2019 17:48:28 +0300
Date:   Tue, 11 Jun 2019 17:48:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2 v5] tty/serial/8250: use mctrl_gpio helpers
Message-ID: <20190611144828.GX9224@smile.fi.intel.com>
References: <20190611105603.4435-1-sr@denx.de>
 <20190611105603.4435-2-sr@denx.de>
 <20190611124415.GT9224@smile.fi.intel.com>
 <85f0d39c-e5d8-320b-e611-d956630a629f@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85f0d39c-e5d8-320b-e611-d956630a629f@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 04:02:54PM +0200, Stefan Roese wrote:
> On 11.06.19 14:44, Andy Shevchenko wrote:
> > On Tue, Jun 11, 2019 at 12:56:03PM +0200, Stefan Roese wrote:

> > >   static inline void serial8250_out_MCR(struct uart_8250_port *up, int value)
> > >   {
> > >   	serial_out(up, UART_MCR, value);
> > > +
> > > +	if (up->gpios) {
> > > +		int mctrl_gpio = 0;
> > > +
> > > +		if (value & UART_MCR_RTS)
> > > +			mctrl_gpio |= TIOCM_RTS;
> > > +		if (value & UART_MCR_DTR)
> > > +			mctrl_gpio |= TIOCM_DTR;
> > > +
> > > +		mctrl_gpio_set(up->gpios, mctrl_gpio);
> > > +	}
> > >   }

> > >   static inline int serial8250_in_MCR(struct uart_8250_port *up)
> > >   {
> > > -	return serial_in(up, UART_MCR);
> > > +	int mctrl;
> > > +
> > > +	mctrl = serial_in(up, UART_MCR);
> > > +
> > > +	if (up->gpios) {
> > > +		int mctrl_gpio = 0;
> > > +
> > > +		/* save current MCR values */
> > > +		if (mctrl & UART_MCR_RTS)
> > > +			mctrl_gpio |= TIOCM_RTS;
> > > +		if (mctrl & UART_MCR_DTR)
> > > +			mctrl_gpio |= TIOCM_DTR;
> > > +
> > > +		mctrl_gpio = mctrl_gpio_get_outputs(up->gpios, &mctrl_gpio);
> > > +		if (mctrl_gpio & TIOCM_RTS)
> > > +			mctrl |= UART_MCR_RTS;
> > > +		else
> > > +			mctrl &= ~UART_MCR_RTS;
> > > +
> > > +		if (mctrl_gpio & TIOCM_DTR)
> > > +			mctrl |= UART_MCR_DTR;
> > > +		else
> > > +			mctrl &= ~UART_MCR_DTR;
> > > +	}
> > > +
> > > +	return mctrl;
> > >   }
> > 
> > These are using OR logic with potentially volatile data. Shouldn't we mask
> > unused bits in UART_MCR in case of up->gpios != NULL?
> 
> Sorry, I don't see, which bits you are referring to? Could you please be
> a bit more specific with the variable / macro meant (example)?

I meant that we double write values in the out() which might have some
consequences, though I hope nothing wrong with it happens.

In the in() we read the all bits in the register.

As now I look at the implementation of mctrl_gpio_get_outputs(),
I think we rather get helpers for conversion between TIOCM and UART_MCR values,
so, they can be used in get_mctrl() / set_mctrl() and above.

The logic now is understandable to me (I was confused by the conversions here
and there).

-- 
With Best Regards,
Andy Shevchenko


