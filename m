Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F11EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EEC223CA1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfFDQw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 12:52:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:28822 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727860AbfFDQw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 12:52:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 09:52:27 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga005.jf.intel.com with ESMTP; 04 Jun 2019 09:52:24 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hYCfg-00018B-7E; Tue, 04 Jun 2019 19:52:24 +0300
Date:   Tue, 4 Jun 2019 19:52:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/2 v4] tty/serial/8250: use mctrl_gpio helpers
Message-ID: <20190604165224.GP9224@smile.fi.intel.com>
References: <20190603083332.12480-1-sr@denx.de>
 <20190603083332.12480-2-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603083332.12480-2-sr@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 10:33:32AM +0200, Stefan Roese wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> This patch permits the usage for GPIOs to control
> the CTS/RTS/DTR/DSR/DCD/RI signals.

> +	if (up->gpios) {

> +		mctrl_gpio_set(up->gpios, mctrl_gpio);
> +	}

...

> +	if (up->gpios) {

> +		mctrl_gpio = mctrl_gpio_get_outputs(up->gpios, &mctrl_gpio);

> +	}

...

> +			gpios = mctrl_gpio_init(&uart->port, 0);
> +			if (IS_ERR(gpios)) {
> +				if (PTR_ERR(gpios) != -ENOSYS)
> +					return PTR_ERR(gpios);
> +			}

...

> +	if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(up->gpios,
> +						UART_GPIO_RTS))) {

> +	}

...

> -	if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW) {
> +	if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW
> +		&& IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(up->gpios,
> +							UART_GPIO_RTS))) {

> }

...

> +	if (up->gpios)
> +		mctrl_gpio_disable_ms(up->gpios);

...

> +	if (up->gpios)
> +		mctrl_gpio_enable_ms(up->gpios);

...

> +	if (up->gpios)
> +		return mctrl_gpio_get(up->gpios, &ret);


Can we rather make this mimic the gpiod_get_optional() API?

So, if we get an error, it's an error, otherwise with NULL pointer the
operations goes to be no-op.

[IS_ERR_OR_NULL() -> IS_ERR(), if (up->gpios) -> /dev/null, etc]


-- 
With Best Regards,
Andy Shevchenko


