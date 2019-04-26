Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C7DC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418B320B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=haabendal.dk header.i=@haabendal.dk header.b="SGvIRP6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfDZRKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:10:15 -0400
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com ([46.30.210.183]:18396
        "EHLO mailrelay2-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726005AbfDZRKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:10:13 -0400
X-Greylist: delayed 962 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Apr 2019 13:10:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=6PpxBj6pB/cO4YIWmewX8fZB5vKk03QrNawxU24bf1c=;
        b=SGvIRP6YCDkErfRQsU9qoa3NGq9l4bZasOIpTlrEn2uRAhsudm4AmtTAe/pZygILaJ8gqxKqO+IBP
         W6dUm5U+eAxVi9qmfl/OYvCIja0s2XB0NApLn8ZEv+jfMsFknNr2eA04fKWl2BdmsszuNZUiILu8+1
         u2NfgYsQ+tzXGUUw=
X-HalOne-Cookie: f031e2cbc18c747382f60270cb5227e8c885703a
X-HalOne-ID: e6f85b29-6843-11e9-9317-d0431ea8a290
Received: from localhost (unknown [87.49.45.205])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id e6f85b29-6843-11e9-9317-d0431ea8a290;
        Fri, 26 Apr 2019 16:54:06 +0000 (UTC)
From:   Esben Haabendal <esben@haabendal.dk>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        He Zhe <zhe.he@windriver.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] serial: 8250: Allow port registration without UPF_BOOT_AUTOCONF
References: <20190426084038.6377-1-esben@geanix.com>
        <20190426084038.6377-2-esben@geanix.com>
        <20190426143946.GX9224@smile.fi.intel.com>
Date:   Fri, 26 Apr 2019 18:54:05 +0200
In-Reply-To: <20190426143946.GX9224@smile.fi.intel.com> (Andy Shevchenko's
        message of "Fri, 26 Apr 2019 17:39:46 +0300")
Message-ID: <871s1og11u.fsf@haabendal.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Fri, Apr 26, 2019 at 10:40:37AM +0200, Esben Haabendal wrote:
>> With serial8250_register_8250_port() forcing UPF_BOOT_AUTOCONF bit on, it
>> is not possible to register a port without having
>> serial8250_request_std_resource() called.
>> 
>> For adding a 8250 port to an MFD device, this is problematic, as the
>> request_mem_region() call will fail, as the MFD device (and rightly  so)
>> has requested the region.  For this case, the 8250 port should accept
>> having passed mapbase and membase, and just use that.
>
> You need to simple set port type and use UPF_FIXED_TYPE.
> No need for this patch.

The reason for this patch is to be able to do exactly that (set port
type and UPF_FIXED_TYPE) without having UPF_BOOT_AUTOCONF added.

In the current serial8250_register_8250_port() there is:

    uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;

So, even though I set UPF_FIXED_TYPE, I get
UPF_FIXED_TYPE|UPF_BOOT_AUTOCONF.  So I need this patch.

I think it is unfortunate that UPF_BOOT_AUTOCONF is or'ed to flags like
that, but changing that will surely break stuff.

/Esben

>
>> 
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>>  drivers/tty/serial/8250/8250_core.c | 36 +++++++++++++++++++++---------------
>>  include/linux/serial_8250.h         |  2 ++
>>  2 files changed, 23 insertions(+), 15 deletions(-)
>> 
>> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
>> index e441221..ddbb0a0 100644
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -957,20 +957,8 @@ static void serial_8250_overrun_backoff_work(struct work_struct *work)
>>  	spin_unlock_irqrestore(&port->lock, flags);
>>  }
>>  
>> -/**
>> - *	serial8250_register_8250_port - register a serial port
>> - *	@up: serial port template
>> - *
>> - *	Configure the serial port specified by the request. If the
>> - *	port exists and is in use, it is hung up and unregistered
>> - *	first.
>> - *
>> - *	The port is then probed and if necessary the IRQ is autodetected
>> - *	If this fails an error is returned.
>> - *
>> - *	On success the port is ready to use and the line number is returned.
>> - */
>> -int serial8250_register_8250_port(struct uart_8250_port *up)
>> +int __serial8250_register_8250_port(struct uart_8250_port *up,
>> +				    unsigned int extra_flags)
>>  {
>>  	struct uart_8250_port *uart;
>>  	int ret = -ENOSPC;
>> @@ -993,7 +981,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
>>  		uart->port.fifosize     = up->port.fifosize;
>>  		uart->port.regshift     = up->port.regshift;
>>  		uart->port.iotype       = up->port.iotype;
>> -		uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
>> +		uart->port.flags        = up->port.flags | extra_flags;
>>  		uart->bugs		= up->bugs;
>>  		uart->port.mapbase      = up->port.mapbase;
>>  		uart->port.mapsize      = up->port.mapsize;
>> @@ -1086,6 +1074,24 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
>>  
>>  	return ret;
>>  }
>> +
>> +/**
>> + *	serial8250_register_8250_port - register a serial port
>> + *	@up: serial port template
>> + *
>> + *	Configure the serial port specified by the request. If the
>> + *	port exists and is in use, it is hung up and unregistered
>> + *	first.
>> + *
>> + *	The port is then probed and if necessary the IRQ is autodetected
>> + *	If this fails an error is returned.
>> + *
>> + *	On success the port is ready to use and the line number is returned.
>> + */
>> +int serial8250_register_8250_port(struct uart_8250_port *up)
>> +{
>> +	return __serial8250_register_8250_port(up, UPF_BOOT_AUTOCONF);
>> +}
>>  EXPORT_SYMBOL(serial8250_register_8250_port);
>>  
>>  /**
>> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
>> index 5a655ba..9d1fe2e 100644
>> --- a/include/linux/serial_8250.h
>> +++ b/include/linux/serial_8250.h
>> @@ -145,6 +145,8 @@ static inline struct uart_8250_port *up_to_u8250p(struct uart_port *up)
>>  	return container_of(up, struct uart_8250_port, port);
>>  }
>>  
>> +extern int __serial8250_register_8250_port(struct uart_8250_port *,
>> +					   unsigned int);
>>  int serial8250_register_8250_port(struct uart_8250_port *);
>>  void serial8250_unregister_port(int line);
>>  void serial8250_suspend_port(int line);
>> -- 
>> 2.4.11
>> 
