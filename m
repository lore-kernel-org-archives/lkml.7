Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A87C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F0C206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=haabendal.dk header.i=@haabendal.dk header.b="n9K0YhXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfEGMWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 08:22:22 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com ([46.30.210.185]:36161
        "EHLO mailrelay4-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbfEGMWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 08:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=CNobkVeV4ID2GG/RHaMtEGbDcAbI0h69642iKV08uC4=;
        b=n9K0YhXdSntdkQybLGYgOaq/YgoXWThm84N8TPNJ8bV5UAHL0uQyKHiNkNO6suBlqFw3RvmS1viuk
         hQoRsIrte2/ZQwacKsYBXYtz9NyUQySjmzRyeAkluc+/a8/XsT1n7xTLFngq9kfvTd9F7c1RHTghn4
         BixVqiIF4/4WcJGQ=
X-HalOne-Cookie: f5403fd914edd98e33be852ecab0f731b8ec6c07
X-HalOne-ID: c16c5734-70c2-11e9-a343-d0431ea8bb10
Received: from localhost (unknown [193.163.1.7])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id c16c5734-70c2-11e9-a343-d0431ea8bb10;
        Tue, 07 May 2019 12:22:18 +0000 (UTC)
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
Date:   Tue, 07 May 2019 14:22:18 +0200
In-Reply-To: <20190507115325.GV9224@smile.fi.intel.com> (Andy Shevchenko's
        message of "Tue, 7 May 2019 14:53:25 +0300")
Message-ID: <87k1f2jvyd.fsf@haabendal.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Tue, May 07, 2019 at 01:35:58PM +0200, Esben Haabendal wrote:
>> Lee Jones <lee.jones@linaro.org> writes:
>> > On Thu, 02 May 2019, Esben Haabendal wrote:
>> >
>> >> Could you help clarify whether or not this patch is trying to do
>> >> something odd/wrong?
>> >> 
>> >> I might be misunderstanding Andy (probably is), but the discussion
>> >> revolves around the changes I propose where I change the serial8250
>> >> driver to use platform_get_resource() in favour of
>> >> request_mem_region()/release_mem_region().
>> >
>> > Since 'serial8250' is registered as a platform device, I don't see any
>> > reason why it shouldn't have the capability to obtain its memory
>> > regions from the platform_get_*() helpers.
>> 
>> Good to hear.  That is exactly what I am trying do with this patch.
>> 
>> @Andy: If you still don't like my approach, could you please advice an
>> acceptable method for improving the serial8250 driver to allow the use
>> of platform_get_*() helpers?
>
> I still don't get why you need this.

Because platform_get_resource() is a generally available and useful
helper function for working with platform_device resources, that the
current standard serial8250 driver does not support.

I am uncertain if I still haven't convinced you that current serial8250
driver does not work with platform_get_resource(), or if you believe
that it really should not support it.

> If it's MFD, you may use "serial8250" with a given platform data like
> dozens of current users do.

There is only one in-tree mfd driver using "serial8250", the sm501.c
driver.  And that driver predates the mfd framework (mfd-core.c) by a
year, and does not use any of the mfd-core functionality.

I want to use the mfd-core provided handling of resource splitting,
because it makes it easier to handle splitting of a single memory
resource as defined by a PCI BAR in this case.  And the other drivers I
need to use all support/use platform_get_resource(), so it would even
have an impact on the integration of that if I cannot use mfd resource
splitting with serial8250.

> Another approach is to use 8250 library, thus, creating a specific glue driver
> (like all 8250_* do).

As mentioned, I think this is a bad approach, and I would prefer to
improve the "serial8250" driver instead.  But if you insist, what should
I call such a driver?  It needs a platform_driver name, for use when
matching with platform_device devices.  And it would support exactly the
same hardware as the current "serial8250" driver.

> Yes, I understand that 8250 driver is full of quirks and not modern approaches
> to do one or another thing. Unfortunately it's not too easy to fix it without
> uglifying code and doing some kind of ping-pong thru the conversion. I don't
> think it worth to do it in the current state of affairs. Though, cleaning up
> the core part from the quirks and custom pieces would make this task
> achievable.

I think it should be possible and worthwhile to improve serial8250
driver with support for using platform_device resources
(platform_get_resource() helper).

If we could stop discussing if it is a proper thing to do, we could try
to find a good way to do it instead.

> I'm also puzzled why you don't use FPGA manager which should handle, as far as
> I understand, very flexible configurations of FPGAs.

FPGA manager is for programming FPGA's.  The FPGA's used in this project
read their configuration from EEPROM.

I don't see any overlap of FPGA manager with MFD.  They server
completely different purposes, and could very well both be used for the
same FPGA's.

> Btw, what exact IP of UART do you have implemented there?

It is an XPS 16550 UART (v3.00a).
https://www.xilinx.com/support/documentation/ip_documentation/xps_uart16550.pdf

There are 5 of them in one FPGA, together with 3 XPS LL TEMAC Ethernet
IP blocks, an IRQ controller, and a number of custom IP blocks.

/Esben
