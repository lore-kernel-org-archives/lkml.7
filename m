Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1837C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D059E21655
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfLMKvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:51:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:19120 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfLMKvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:51:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 02:50:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600"; 
   d="scan'208";a="296894634"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 13 Dec 2019 02:50:34 -0800
Received: from andy by smile with local (Exim 4.93-RC7)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ifiWn-0007Os-SN; Fri, 13 Dec 2019 12:50:33 +0200
Date:   Fri, 13 Dec 2019 12:50:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     chengang@emindsoft.com.cn
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com, sr@denx.de,
        mika.westerberg@linux.intel.com, yegorslists@googlemail.com,
        yuehaibing@huawei.com, haolee.swjtu@gmail.com, dsterba@suse.com,
        mojha@codeaurora.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lv Li-song <lvlisong@emindsoft.com.cn>
Subject: Re: [PATCH] drivers: tty: serial: 8250: fintek: Can enable or
 disable irq sharing based on isa or pci bus
Message-ID: <20191213105033.GT32742@smile.fi.intel.com>
References: <20191213051717.2058-1-chengang@emindsoft.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213051717.2058-1-chengang@emindsoft.com.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 01:17:17PM +0800, chengang@emindsoft.com.cn wrote:
> From: Chen Gang <chengang@emindsoft.com.cn>

Thanks for the patch, my comments below.

> Sorry for this patch being too late, which is for linux-next 20151127 (
> about linux 4.4-rc2).  After 4 years, much things have been changed. But
> I think it might be still valuable for some old versions. Welcome anyone
> to refact this patch for their own.

This part should go after '---' line below.

> Fintek serial ports can share irq, but they need be enabled firstly, so
> enable or disable irq sharing based on isa or pci bus. From kconfig, it

irq -> IRQ
isa -> ISA
pci -> PCI
kconfig -> Kconfig

> can be configured.
> 
> For integrated 8250 drivers, kernel always calls pnp driver, which will
> not use integrated fintek driver for ever. So let pnp driver try the

fintek -> Fintek or Fintek 8250

> other drivers firstly (e.g. fintek), if fail, try pnp driver its own.

Ditto.

...

> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -14,6 +14,7 @@
>  #include <linux/serial_8250.h>
>  #include <linux/serial_reg.h>
>  #include <linux/dmaengine.h>

> +#include <linux/pnp.h>

The changes below doesn't require a header.
Pointers are known to the compiler. Names of data structures can be forward
declared. Moreover, these declarations may go inside respective #ifdef.

...

> +#if IS_ENABLED(CONFIG_SERIAL_8250_FINTEK_IRQ_SHARING)
> +
> +static void set_icsr(u16 base_port, u8 index)
> +{
> +	uint8_t icsr = 0;
> +
> +	outb(LDN, base_port + ADDR_PORT);
> +	outb(index, base_port + DATA_PORT);
> +	outb(ICSR, base_port + ADDR_PORT);
> +	icsr = inb(base_port + DATA_PORT);
> +

> +	if (icsr != 0xff) {

	if (icsr == 0xff)
		return;

?

> +		icsr |= IRQ_SHARING_MOD;
> +#if IS_ENABLED(CONFIG_SERIAL_8250_FINTEK_IRQ_SHARING_ISA)
> +		icsr |= ISA_IRQ_SHARING;
> +#else
> +		icsr |= PCI_IRQ_SHARING;
> +#endif
> +		outb(ICSR, base_port + ADDR_PORT);
> +		outb(icsr, base_port + DATA_PORT);
> +	}
> +}
> +
> +#endif

...

>  				aux |= inb(addr[i] + DATA_PORT) << 8;
>  				if (aux != io_address)
>  					continue;

> -

What the point?

> +#if IS_ENABLED(CONFIG_SERIAL_8250_FINTEK_IRQ_SHARING)
> +				set_icsr(addr[i], k);
> +#endif
>  				fintek_8250_exit_key(addr[i]);
>  				*key = keys[j];
>  				*index = k;
> @@ -179,53 +212,6 @@ static int fintek_8250_base_port(u16 io_address, u8 *key, u8 *index)
>  	return -ENODEV;
>  }
>  
> -static int
> -fintek_8250_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)

Why did you move this function?
It's now not only hard to follow what has been changed, and to review.

> --- a/drivers/tty/serial/8250/8250_pnp.c
> +++ b/drivers/tty/serial/8250/8250_pnp.c
> @@ -438,8 +438,13 @@ static int
>  serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
>  {
>  	struct uart_8250_port uart, *port;
> -	int ret, line, flags = dev_id->driver_data;
> +	int ret, line, flags;
>  

> +#if IS_BUILTIN(CONFIG_SERIAL_8250_FINTEK)
> +	if (!fintek_8250_probe(dev, dev_id))
> +		return 0;
> +#endif
> +	flags = dev_id->driver_data;

Oh, I don't like this.
It needs a bit more refactoring done first.

The idea that we are not going to pollute generic driver(s) with quirks anymore
(only when it's really unavoidable).


-- 
With Best Regards,
Andy Shevchenko


