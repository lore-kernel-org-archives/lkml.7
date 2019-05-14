Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60A0C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B67E206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=haabendal.dk header.i=@haabendal.dk header.b="0Sn4sk2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfENHWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 03:22:15 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com ([46.30.210.185]:43261
        "EHLO mailrelay4-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726190AbfENHWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 03:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=lHJDEPi83/7TupgeVc/Ztzp6V7A4QR/sUMN42jYTWxI=;
        b=0Sn4sk2AmAlV8NX9YMTrCyxoDA+mB43rp1kIvUNYNuamcfuy+oQgxFbc8Wd3PrnG3Fkrt9lU4WfkO
         hJR8c403WYb8OE3ZvYpYX+PU5fRdUjVjLQgMvu6yRYfTJasFTfH793uR0brmC3K/fK0IjxcMZFoln+
         Wyuo2Ddk4H/xqIpA=
X-HalOne-Cookie: 53fd3c0f1aa55a61d90a2fd056e5d74f25d59243
X-HalOne-ID: fb4ad7ed-7618-11e9-abc4-d0431ea8bb10
Received: from localhost (unknown [193.163.1.7])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id fb4ad7ed-7618-11e9-abc4-d0431ea8bb10;
        Tue, 14 May 2019 07:22:08 +0000 (UTC)
From:   Esben Haabendal <esben@haabendal.dk>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-serial@vger.kernel.org,
        Enrico Weigelt <lkml@metux.net>,
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
        <874l6efxta.fsf@haabendal.dk>
        <20190502104556.GS9224@smile.fi.intel.com>
        <87pnp11112.fsf@haabendal.dk> <20190507093239.GB4529@dell>
        <87sgtqjy3l.fsf@haabendal.dk>
        <20190507115325.GV9224@smile.fi.intel.com>
        <87k1f2jvyd.fsf@haabendal.dk>
        <20190507150847.GW9224@smile.fi.intel.com>
Date:   Tue, 14 May 2019 09:22:07 +0200
In-Reply-To: <20190507150847.GW9224@smile.fi.intel.com> (Andy Shevchenko's
        message of "Tue, 7 May 2019 18:08:47 +0300")
Message-ID: <87k1etmrfk.fsf@haabendal.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Tue, May 07, 2019 at 02:22:18PM +0200, Esben Haabendal wrote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> > On Tue, May 07, 2019 at 01:35:58PM +0200, Esben Haabendal wrote:
>> >> Lee Jones <lee.jones@linaro.org> writes:
>> >> > On Thu, 02 May 2019, Esben Haabendal wrote:
>> >> >
>> >> >> Could you help clarify whether or not this patch is trying to do
>> >> >> something odd/wrong?
>> >> >> 
>> >> >> I might be misunderstanding Andy (probably is), but the discussion
>> >> >> revolves around the changes I propose where I change the serial8250
>> >> >> driver to use platform_get_resource() in favour of
>> >> >> request_mem_region()/release_mem_region().
>> >> >
>> >> > Since 'serial8250' is registered as a platform device, I don't see any
>> >> > reason why it shouldn't have the capability to obtain its memory
>> >> > regions from the platform_get_*() helpers.
>> >> 
>> >> Good to hear.  That is exactly what I am trying do with this patch.
>> >> 
>> >> @Andy: If you still don't like my approach, could you please advice an
>> >> acceptable method for improving the serial8250 driver to allow the use
>> >> of platform_get_*() helpers?
>> >
>> > I still don't get why you need this.
>> 
>> Because platform_get_resource() is a generally available and useful
>> helper function for working with platform_device resources, that the
>> current standard serial8250 driver does not support.
>> 
>> I am uncertain if I still haven't convinced you that current serial8250
>> driver does not work with platform_get_resource(), or if you believe
>> that it really should not support it.
>
> I believe there is no need to do this support.
>
> Most of the platform code that uses it is quite legacy,

So all code that use/support platform_get_resource() is legacy code?

commit 7945f929f1a77a1c8887a97ca07f87626858ff42
Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed Feb 20 11:12:39 2019 +0000

    drivers: provide devm_platform_ioremap_resource()
    
    There are currently 1200+ instances of using platform_get_resource()
    and devm_ioremap_resource() together in the kernel tree.
    
    This patch wraps these two calls in a single helper. Thanks to that
    we don't have to declare a local variable for struct resource * and can
    omit the redundant argument for resource type. We also have one
    function call less.
    
    Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
    Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

It does not looks quite dead to me.

> and all under arch/
> ideally should be converted to use Device Tree.

When do you expect arch/x86 to be converted to device tree?

>> > If it's MFD, you may use "serial8250" with a given platform data like
>> > dozens of current users do.
>> 
>> There is only one in-tree mfd driver using "serial8250", the sm501.c
>> driver.  And that driver predates the mfd framework (mfd-core.c) by a
>> year, and does not use any of the mfd-core functionality.
>
> So, does it have an issue?

I don't have hardware so I can test it, but I assume that it is
working.

It is ignoring framework code (mfd-core), that is implemented to await
re-inventing the wheel for each and every mfd driver.  If that is an
issue, then yes, sm501.c does have an issue and could be improved/fixed.

>> I want to use the mfd-core provided handling of resource splitting,
>> because it makes it easier to handle splitting of a single memory
>> resource as defined by a PCI BAR in this case.  And the other drivers I
>> need to use all support/use platform_get_resource(), so it would even
>> have an impact on the integration of that if I cannot use mfd resource
>> splitting with serial8250.
>
> I tired to repeat, that is OKAY! You *may* split and supply resources to the
> drivers, nothing prevents you to do that with current code base.
>
> Do you see any problem with that? What is that problem?
>
> If you would like utilize serial8250, just provide a platform data for
> it.

I fear we are coming to an end here.

I don't seem to be able to break through to you, to get you to
understand the issue here.

I want to write a simple and elegant mfd driver, using mfd-core
framework (the mfd_add_devices() function call to be specific).  I don't
want to reimplement similar functionality in the mfd driver.

The other drivers I need all work fine with this, but serial8250 does
not.

As I understand Lee Jones, he seem to agree with me, so could you
please, please consider that I might not be totally on crack, and might
actually have brough forward a valid proposition.

>> > Another approach is to use 8250 library, thus, creating a specific
>> > glue driver (like all 8250_* do).
>> 
>> As mentioned, I think this is a bad approach, and I would prefer to
>> improve the "serial8250" driver instead.  But if you insist, what should
>> I call such a driver?  It needs a platform_driver name, for use when
>> matching with platform_device devices.  And it would support exactly the
>> same hardware as the current "serial8250" driver.
>
> If you need some specifics, you create a driver with whatever name
> suits the IP in question. Nevertheless, if it's simple generic 8250, nothing
> needs to be added, except platform data, see above.

We are on repeat here.  I don't agree with you here.  I have a simple
generic 8250 (16550A) compatible device, and cannot use it in a mfd
driver using the standard mfd-core framework.

The lacking of support for platform_get_resource() in the generic
serial8250 driver is not a feature.  It should be supported, just as it
is in several of the specialized 8250 drivers.

>> > Yes, I understand that 8250 driver is full of quirks and not modern
>> > approaches
>> > to do one or another thing. Unfortunately it's not too easy to fix it
>> > without
>> > uglifying code and doing some kind of ping-pong thru the conversion. I don't
>> > think it worth to do it in the current state of affairs. Though, cleaning up
>> > the core part from the quirks and custom pieces would make this task
>> > achievable.
>> 
>> I think it should be possible and worthwhile to improve serial8250
>> driver with support for using platform_device resources
>> (platform_get_resource() helper).
>
> I simple can't understand why it's needed. What problem would it solve which
> can't be solved with existing code base?

On repeat again.  I have explained it way to many times, so I guess I
must assume by now that you do not think that being able to use
serial8250 together with mfd-core is something that should be solved.

>> If we could stop discussing if it is a proper thing to do, we could try
>> to find a good way to do it instead.
>
>> > Btw, what exact IP of UART do you have implemented there?
>> 
>> It is an XPS 16550 UART (v3.00a).
>> https://www.xilinx.com/support/documentation/ip_documentation/xps_uart16550.pdf
>
> So, briefly looking at it I didn't find any deviations from a standard 16550a.

Exactly. I am pretty sure I have said this more than once in this
thread.  This IP is perfectly standard.  It would be completely wrong to
write a specialized 8250 driver for this.

But if I fail to find a way to get something merged which allows using
the generic serial8250 driver with platform_get_resource(), I guess I
need to handle this out-of-tree.  And anybody else needing/wanting to do
the same would have to do that as well.

> Also there are two drivers mentioned Xilinx, though I'm pretty sure it's not
> your case.
>
> Since you have more than one of them, it's even smaller to use current
> infrastructure to enumerate them using only one serial8250 description.
> See plenty examples in the Linux kernel, such as 8250_exar_st16c554.c.
> That is what you may just modify for your needs and put inside your MFD.

It would still mean that I would have revert to not using convenient and
otherwise fully appropriate API calls like pci_request_regions() and
mfd_add_devices().

The mfd driver in question is for a PCI device.  Not being able to
request the PCI regions seems silly.

Not being able to register all child devices with the call introduced
for that sole purpose also seems silly.

/Esben
