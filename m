Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CADC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798532087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbfC0Jfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:35:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:32823 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbfC0Jff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:35:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 02:35:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,276,1549958400"; 
   d="scan'208";a="217967853"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga001.jf.intel.com with ESMTP; 27 Mar 2019 02:35:31 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h94y2-0005aA-9u; Wed, 27 Mar 2019 11:35:30 +0200
Date:   Wed, 27 Mar 2019 11:35:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] Input: add Apple SPI keyboard and trackpad driver.
Message-ID: <20190327093530.GH9224@smile.fi.intel.com>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <20190327014807.7472-5-ronald@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190327014807.7472-5-ronald@innovation.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 06:48:07PM -0700, Ronald Tschalär wrote:
> The keyboard and trackpad on recent MacBook's (since 8,1) and
> MacBookPro's (13,* and 14,*) are attached to an SPI controller instead
> of USB, as previously. The higher level protocol is not publicly
> documented and hence has been reverse engineered. As a consequence there
> are still a number of unknown fields and commands. However, the known
> parts have been working well and received extensive testing and use.
> 
> In order for this driver to work, the proper SPI drivers need to be
> loaded too; for MB8,1 these are spi_pxa2xx_platform and spi_pxa2xx_pci;
> for all others they are spi_pxa2xx_platform and intel_lpss_pci. For this
> reason enabling this driver in the config implies enabling the above
> drivers.

> +// SPDX-License-Identifier: GPL-2.0

According to last changes this should be GPL-2.0-only

> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/crc16.h>
> +#include <linux/delay.h>
> +#include <linux/efi.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/ktime.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/spinlock.h>
> +#include <linux/spi/spi.h>
> +#include <linux/wait.h>
> +#include <linux/workqueue.h>
> +
> +#include <asm/barrier.h>

> +#include <asm-generic/unaligned.h>

generic?!

#include <asm/unaligned.h>
should work.

> +static const char *applespi_debug_facility(unsigned int log_mask)
> +{
> +	switch (log_mask) {
> +	case DBG_CMD_TP_INI:
> +		return "Touchpad Initialization";
> +	case DBG_CMD_BL:
> +		return "Backlight Command";
> +	case DBG_CMD_CL:
> +		return "Caps-Lock Command";
> +	case DBG_RD_KEYB:
> +		return "Keyboard Event";
> +	case DBG_RD_TPAD:
> +		return "Touchpad Event";
> +	case DBG_RD_UNKN:
> +		return "Unknown Event";
> +	case DBG_RD_IRQ:
> +		return "Interrupt Request";
> +	case DBG_RD_CRC:
> +		return "Corrupted packet";
> +	case DBG_TP_DIM:
> +		return "Touchpad Dimensions";
> +	default:

> +		return "-Unrecognized log mask-";

I don't think '-' surroundings are needed, but this is rather minor. Up to you.

> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko


