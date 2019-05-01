Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8DBC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 07:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECD92064A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 07:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=haabendal.dk header.i=@haabendal.dk header.b="XL9RJUiT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfEAHRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 03:17:43 -0400
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com ([46.30.210.183]:25323
        "EHLO mailrelay2-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbfEAHRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 03:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=F15j0AFunF4CBEEgLxdpx3aWJyR9of//q1hGRpFq+i0=;
        b=XL9RJUiTRW24HdIpIv99IKY08IB4D/AbB6uaTp2riAlcowmbs4L5wrp9suCUKv53yrB/gicGQOskP
         vssZsQZGw6nESy6VoQGQewoOn7zpYIaemkSNc6taPCrWENckWgguWdXvlK+SeaVk/gCyB48O1L50l6
         Bzh6piVjllF1nxqg=
X-HalOne-Cookie: 6c80926cc8f071f60467f5cf294afa5a4b457f55
X-HalOne-ID: 32f67941-6be1-11e9-931a-d0431ea8a290
Received: from localhost (unknown [193.163.1.7])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 32f67941-6be1-11e9-931a-d0431ea8a290;
        Wed, 01 May 2019 07:17:38 +0000 (UTC)
From:   Esben Haabendal <esben@haabendal.dk>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device resources
References: <20190430140416.4707-1-esben@geanix.com>
        <20190430153736.GL9224@smile.fi.intel.com>
Date:   Wed, 01 May 2019 09:17:37 +0200
In-Reply-To: <20190430153736.GL9224@smile.fi.intel.com> (Andy Shevchenko's
        message of "Tue, 30 Apr 2019 18:37:36 +0300")
Message-ID: <874l6efxta.fsf@haabendal.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Tue, Apr 30, 2019 at 04:04:13PM +0200, Esben Haabendal wrote:
>> Remaining platform_data fields (other than mapbase, iobase, mapsize and
>> irq) are used just as before.  Note
>
> Note what?

Note nothing.  I will remove it, sorry about that.

>> +static int serial8250_probe_resources(struct platform_device *pdev,
>> +				      unsigned int num,
>> +				      struct plat_serial8250_port *p,
>> +				      struct uart_8250_port *uart)
>> +{
>> +	struct resource *r;
>> +	int irq;
>> +
>> +	switch (p->iotype) {
>> +	case UPIO_AU:
>> +	case UPIO_TSI:
>> +	case UPIO_MEM32:
>> +	case UPIO_MEM32BE:
>> +	case UPIO_MEM16:
>> +	case UPIO_MEM:
>> +		r = platform_get_resource(pdev, IORESOURCE_MEM, num);
>> +		if (!r)
>> +			return -ENODEV;
>> +		uart->port.mapbase = r->start;
>> +		uart->port.mapsize = resource_size(r);
>> +		uart->port.flags |= UPF_IOREMAP;
>> +		break;
>> +	case UPIO_HUB6:
>> +	case UPIO_PORT:
>> +		r = platform_get_resource(pdev, IORESOURCE_IO, num);
>> +		if (!r)
>> +			return -ENODEV;
>> +		uart->port.iobase = r->start;
>> +		uart->port.mapsize = resource_size(r);
>> +		break;
>> +	}
>> +
>> +	irq = platform_get_irq(pdev, num);
>> +	if (irq == -ENXIO)
>> +		uart->port.irq = 0; /* no interrupt -> use polling */
>> +	else if (irq < 0)
>> +		return irq;
>> +	uart->port.irq = irq;
>> +
>> +	return 0;
>> +}
>
> Hmm... Currently it's done inside individual port drivers, like 8250_dw.c.
> Each of the drivers can do it differently, for example 8250_lpss.c or
> 8250_pnp.c.

So, you would prefer to create a new "specialized" port driver that uses
platform resources?  I am not doing anything else different from
the generic port driver here in 8250_core.c.

>> +				if (!(port->flags & UPF_DEV_RESOURCES))
>> +					release_mem_region(port->mapbase, size);
>
> This is again same issue. The parent should not request resource it
> doesn't use.

Yes, this is same issue.

But the last part is not true.  A parent mfd driver might "use" a memory
resource for the sole purpose of splitting it up for it's mfd child
devices.  This is a core part of mfd framework, and not something I am
inventing with this patch.  I am just trying to make it possible to use
8250 driver in that context.

> I think I understand what is a confusion here.
>
> For the IO resources we have two operations:
> - mapping / re-mapping (may be shared)
> - requesting (exclusive)
>
> In the parenthesis I put a level of access to it. While many device
> drivers can *share* same resource (mapped or unmapped), the only one
> can actually request it.

Mostly true.  But there is an important twist to the exclusive restriction.

The exclusive part of the request is limited to the the same root/parent
resource.

When you request a memory resource from the root resource
(iomem_resource), the resource returned can be used as a new parent
resource.  This new parent can then be used to give exclusive access to
slices of that resource.  When used like that, I expect that the parent
resource is not supposed to be used for anything else than honoring
resource requests.

And this is exactly what mfd-core uses the mem_base argument
in mfd_add_devices().

> So, the parent can take an slice resources as it would be
> appropriated, but not requesting them.

The parent is not and should not be doing that by itself.  The request
is done on by mfd-core when mfd_add_devices() is called.

> OTOH, it's possible to have a (weird) MFD case where parent *requested*
> resources, and *all* of its children are aware of that.

I am not sure what you mean with this, but mfd drivers should not pass
along it's intire requested memory resource(s) to child devices.  The
child devices will get the requested resource slices, as implemented by
mfd_add_devices().

I hope you can see that I am not violating any fundamental design
decissions here, but actually try adhere to them (resource management,
platform_device resource management, and mfd-core).

/Esben
