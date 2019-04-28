Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0EAC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8DE204FD
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 15:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfD1PS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 11:18:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:34018 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbfD1PS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 11:18:57 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Apr 2019 08:18:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,406,1549958400"; 
   d="scan'208";a="341531946"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 28 Apr 2019 08:18:51 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hKlZo-0005Ys-RD; Sun, 28 Apr 2019 18:18:48 +0300
Date:   Sun, 28 Apr 2019 18:18:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        andrew@aj.id.au, macro@linux-mips.org, vz@mleia.com,
        slemieux.tyco@gmail.com, khilman@baylibre.com, liviu.dudau@arm.com,
        sudeep.holla@arm.com, lorenzo.pieralisi@arm.com,
        davem@davemloft.net, jacmet@sunsite.dk, linux@prisktech.co.nz,
        matthias.bgg@gmail.com, linux-mips@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 36/41] drivers: tty: serial: 8250: store mmio resource
 size in port struct
Message-ID: <20190428151848.GO9224@smile.fi.intel.com>
References: <1556369542-13247-1-git-send-email-info@metux.net>
 <1556369542-13247-37-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556369542-13247-37-git-send-email-info@metux.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 02:52:17PM +0200, Enrico Weigelt, metux IT consult wrote:
> The io resource size is currently recomputed when it's needed but this
> actually needs to be done once (or drivers could specify fixed values)

io -> IO

> 
> Simplify that by doing this computation only once and storing the result
> into the mapsize field. serial8250_register_8250_port() is now called
> only once on driver init, the previous call sites now just fetch the
> value from the mapsize field.

Do I understand correctly that this has no side effects?

Which hardware did you test this on?

> @@ -979,6 +979,9 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
>  	if (up->port.uartclk == 0)
>  		return -EINVAL;
>  
> +	/* compute the mapsize in case the driver didn't specify one */
> +	up->mapsize = serial8250_port_size(up);

I don't know all quirks in 8250 drivers by heart, though can you guarantee that
at this point the device reports correct IO resource size? (If I'm not mistaken
some broken hardware needs some magic to be done before card can be properly
handled)

> -	unsigned int size = serial8250_port_size(up);
>  	struct uart_port *port = &up->port;

> -	int ret = 0;

This and Co is a separate change that can be done in its own patch.

> +			port->membase = ioremap_nocache(port->mapbase,
> +							port->mapsize);

You may increase readability by introducing temporary variables

	... mapbase = port->mapbase;
	... mapsize = port->mapsize;
	...
	port->membase = ioremap_nocache(mapbase, mapsize);
	...

-- 
With Best Regards,
Andy Shevchenko


