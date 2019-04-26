Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A89C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C7621479
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfDZOjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:39:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:36425 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfDZOjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:39:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP; 26 Apr 2019 07:39:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,397,1549958400"; 
   d="scan'208";a="165158929"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga002.fm.intel.com with ESMTP; 26 Apr 2019 07:39:47 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hK20w-0005Qc-3i; Fri, 26 Apr 2019 17:39:46 +0300
Date:   Fri, 26 Apr 2019 17:39:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Esben Haabendal <esben@geanix.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        He Zhe <zhe.he@windriver.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] serial: 8250: Allow port registration without
 UPF_BOOT_AUTOCONF
Message-ID: <20190426143946.GX9224@smile.fi.intel.com>
References: <20190426084038.6377-1-esben@geanix.com>
 <20190426084038.6377-2-esben@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426084038.6377-2-esben@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 10:40:37AM +0200, Esben Haabendal wrote:
> With serial8250_register_8250_port() forcing UPF_BOOT_AUTOCONF bit on, it
> is not possible to register a port without having
> serial8250_request_std_resource() called.
> 
> For adding a 8250 port to an MFD device, this is problematic, as the
> request_mem_region() call will fail, as the MFD device (and rightly  so)
> has requested the region.  For this case, the 8250 port should accept
> having passed mapbase and membase, and just use that.

You need to simple set port type and use UPF_FIXED_TYPE.
No need for this patch.

> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/tty/serial/8250/8250_core.c | 36 +++++++++++++++++++++---------------
>  include/linux/serial_8250.h         |  2 ++
>  2 files changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index e441221..ddbb0a0 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -957,20 +957,8 @@ static void serial_8250_overrun_backoff_work(struct work_struct *work)
>  	spin_unlock_irqrestore(&port->lock, flags);
>  }
>  
> -/**
> - *	serial8250_register_8250_port - register a serial port
> - *	@up: serial port template
> - *
> - *	Configure the serial port specified by the request. If the
> - *	port exists and is in use, it is hung up and unregistered
> - *	first.
> - *
> - *	The port is then probed and if necessary the IRQ is autodetected
> - *	If this fails an error is returned.
> - *
> - *	On success the port is ready to use and the line number is returned.
> - */
> -int serial8250_register_8250_port(struct uart_8250_port *up)
> +int __serial8250_register_8250_port(struct uart_8250_port *up,
> +				    unsigned int extra_flags)
>  {
>  	struct uart_8250_port *uart;
>  	int ret = -ENOSPC;
> @@ -993,7 +981,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
>  		uart->port.fifosize     = up->port.fifosize;
>  		uart->port.regshift     = up->port.regshift;
>  		uart->port.iotype       = up->port.iotype;
> -		uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
> +		uart->port.flags        = up->port.flags | extra_flags;
>  		uart->bugs		= up->bugs;
>  		uart->port.mapbase      = up->port.mapbase;
>  		uart->port.mapsize      = up->port.mapsize;
> @@ -1086,6 +1074,24 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
>  
>  	return ret;
>  }
> +
> +/**
> + *	serial8250_register_8250_port - register a serial port
> + *	@up: serial port template
> + *
> + *	Configure the serial port specified by the request. If the
> + *	port exists and is in use, it is hung up and unregistered
> + *	first.
> + *
> + *	The port is then probed and if necessary the IRQ is autodetected
> + *	If this fails an error is returned.
> + *
> + *	On success the port is ready to use and the line number is returned.
> + */
> +int serial8250_register_8250_port(struct uart_8250_port *up)
> +{
> +	return __serial8250_register_8250_port(up, UPF_BOOT_AUTOCONF);
> +}
>  EXPORT_SYMBOL(serial8250_register_8250_port);
>  
>  /**
> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> index 5a655ba..9d1fe2e 100644
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -145,6 +145,8 @@ static inline struct uart_8250_port *up_to_u8250p(struct uart_port *up)
>  	return container_of(up, struct uart_8250_port, port);
>  }
>  
> +extern int __serial8250_register_8250_port(struct uart_8250_port *,
> +					   unsigned int);
>  int serial8250_register_8250_port(struct uart_8250_port *);
>  void serial8250_unregister_port(int line);
>  void serial8250_suspend_port(int line);
> -- 
> 2.4.11
> 

-- 
With Best Regards,
Andy Shevchenko


