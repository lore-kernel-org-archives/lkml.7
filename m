Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45E5C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9542120652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfD3Phm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:37:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:56135 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfD3Phl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:37:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 08:37:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,414,1549958400"; 
   d="scan'208";a="153608978"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Apr 2019 08:37:38 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hLUp6-0007FV-Ki; Tue, 30 Apr 2019 18:37:36 +0300
Date:   Tue, 30 Apr 2019 18:37:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Esben Haabendal <esben@geanix.com>
Cc:     linux-serial@vger.kernel.org, Enrico Weigelt <lkml@metux.net>,
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
Message-ID: <20190430153736.GL9224@smile.fi.intel.com>
References: <20190430140416.4707-1-esben@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430140416.4707-1-esben@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 04:04:13PM +0200, Esben Haabendal wrote:
> Allow getting memory resource (mapbase or iobase) as well as irq from
> platform_device resources.
> 
> The UPF_DEV_RESOURCES flag must be set for devices where platform_device
> resources are to be used.  When not set, driver behaves as before.
> 
> This allows use of the serial8250 driver together with devices with
> resources added by platform_device_add_resources(), such as mfd child
> devices added with mfd_add_devices().
> 

> Remaining platform_data fields (other than mapbase, iobase, mapsize and
> irq) are used just as before.  Note

Note what?

> +static int serial8250_probe_resources(struct platform_device *pdev,
> +				      unsigned int num,
> +				      struct plat_serial8250_port *p,
> +				      struct uart_8250_port *uart)
> +{
> +	struct resource *r;
> +	int irq;
> +
> +	switch (p->iotype) {
> +	case UPIO_AU:
> +	case UPIO_TSI:
> +	case UPIO_MEM32:
> +	case UPIO_MEM32BE:
> +	case UPIO_MEM16:
> +	case UPIO_MEM:
> +		r = platform_get_resource(pdev, IORESOURCE_MEM, num);
> +		if (!r)
> +			return -ENODEV;
> +		uart->port.mapbase = r->start;
> +		uart->port.mapsize = resource_size(r);
> +		uart->port.flags |= UPF_IOREMAP;
> +		break;
> +	case UPIO_HUB6:
> +	case UPIO_PORT:
> +		r = platform_get_resource(pdev, IORESOURCE_IO, num);
> +		if (!r)
> +			return -ENODEV;
> +		uart->port.iobase = r->start;
> +		uart->port.mapsize = resource_size(r);
> +		break;
> +	}
> +
> +	irq = platform_get_irq(pdev, num);
> +	if (irq == -ENXIO)
> +		uart->port.irq = 0; /* no interrupt -> use polling */
> +	else if (irq < 0)
> +		return irq;
> +	uart->port.irq = irq;
> +
> +	return 0;
> +}

Hmm... Currently it's done inside individual port drivers, like 8250_dw.c.
Each of the drivers can do it differently, for example 8250_lpss.c or
8250_pnp.c.

> +				if (!(port->flags & UPF_DEV_RESOURCES))
> +					release_mem_region(port->mapbase, size);

This is again same issue. The parent should not request resource it doesn't use.

I think I understand what is a confusion here.

For the IO resources we have two operations:
- mapping / re-mapping (may be shared)
- requesting (exclusive)

In the parenthesis I put a level of access to it. While many device drivers can
*share* same resource (mapped or unmapped), the only one can actually request
it.

So, the parent can take an slice resources as it would be appropriated, but not
requesting them.

OTOH, it's possible to have a (weird) MFD case where parent *requested*
resources, and *all* of its children are aware of that.

-- 
With Best Regards,
Andy Shevchenko


