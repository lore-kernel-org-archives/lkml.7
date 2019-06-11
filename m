Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB4CC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DE220896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388478AbfFKMoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 08:44:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:38430 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbfFKMoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 08:44:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 05:44:18 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga002.jf.intel.com with ESMTP; 11 Jun 2019 05:44:15 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hag8N-00059q-0l; Tue, 11 Jun 2019 15:44:15 +0300
Date:   Tue, 11 Jun 2019 15:44:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2 v5] tty/serial/8250: use mctrl_gpio helpers
Message-ID: <20190611124415.GT9224@smile.fi.intel.com>
References: <20190611105603.4435-1-sr@denx.de>
 <20190611105603.4435-2-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611105603.4435-2-sr@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 12:56:03PM +0200, Stefan Roese wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> This patch permits the usage for GPIOs to control
> the CTS/RTS/DTR/DSR/DCD/RI signals.

>  static inline void serial8250_out_MCR(struct uart_8250_port *up, int value)
>  {
>  	serial_out(up, UART_MCR, value);
> +
> +	if (up->gpios) {
> +		int mctrl_gpio = 0;
> +
> +		if (value & UART_MCR_RTS)
> +			mctrl_gpio |= TIOCM_RTS;
> +		if (value & UART_MCR_DTR)
> +			mctrl_gpio |= TIOCM_DTR;
> +
> +		mctrl_gpio_set(up->gpios, mctrl_gpio);
> +	}
>  }
>  
>  static inline int serial8250_in_MCR(struct uart_8250_port *up)
>  {
> -	return serial_in(up, UART_MCR);
> +	int mctrl;
> +
> +	mctrl = serial_in(up, UART_MCR);
> +
> +	if (up->gpios) {
> +		int mctrl_gpio = 0;
> +
> +		/* save current MCR values */
> +		if (mctrl & UART_MCR_RTS)
> +			mctrl_gpio |= TIOCM_RTS;
> +		if (mctrl & UART_MCR_DTR)
> +			mctrl_gpio |= TIOCM_DTR;
> +
> +		mctrl_gpio = mctrl_gpio_get_outputs(up->gpios, &mctrl_gpio);
> +		if (mctrl_gpio & TIOCM_RTS)
> +			mctrl |= UART_MCR_RTS;
> +		else
> +			mctrl &= ~UART_MCR_RTS;
> +
> +		if (mctrl_gpio & TIOCM_DTR)
> +			mctrl |= UART_MCR_DTR;
> +		else
> +			mctrl &= ~UART_MCR_DTR;
> +	}
> +
> +	return mctrl;
>  }

These are using OR logic with potentially volatile data. Shouldn't we mask
unused bits in UART_MCR in case of up->gpios != NULL?

> +	if (up->gpios == 0)

This is type inconsistency with this check as far as I understand.
I guess you have to do either (up->gpios == NULL), or (!up->gpios).

>  	ret = 0;

+ Blank line.

> +	if (up->gpios)
> +		return mctrl_gpio_get(up->gpios, &ret);

-- 
With Best Regards,
Andy Shevchenko


