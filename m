Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82532C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 12:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547EE20881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 12:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=haabendal.dk header.i=@haabendal.dk header.b="ixmUWZOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfENMCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 08:02:41 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com ([46.30.210.185]:35416
        "EHLO mailrelay4-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726409AbfENMCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 08:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=j4RzQ2F61OaLVNMuvo3VT0Xh20+qitpMikiavu8ugBE=;
        b=ixmUWZOwqwVip0IJzVjOrVBL1Pt9sHmzG4JcO3LtriADDILHFPLPJwsKDEsFPWL1WkNgLWuOAJl3v
         W50ILUHo9eCPvenAsVe1ieJ9WmROADCFA5d5a/ZGIScqLjjf7oNfc5GrDxa2CbzTFXNcw7X1FNasNn
         UvesScdOLN0GDQmM=
X-HalOne-Cookie: c1a8cde9a5cd1996bef07585b780cb7bc58f7d68
X-HalOne-ID: 29c099f6-7640-11e9-abc4-d0431ea8bb10
Received: from localhost (unknown [193.163.1.7])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 29c099f6-7640-11e9-abc4-d0431ea8bb10;
        Tue, 14 May 2019 12:02:36 +0000 (UTC)
From:   Esben Haabendal <esben@haabendal.dk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        "open list\:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>,
        Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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
        <87k1etmrfk.fsf@haabendal.dk>
        <CAHp75VfrP6SLVzmp6LepN7dU1c7QYxfRDRtj7dCTuWzmYp2tCA@mail.gmail.com>
Date:   Tue, 14 May 2019 14:02:36 +0200
In-Reply-To: <CAHp75VfrP6SLVzmp6LepN7dU1c7QYxfRDRtj7dCTuWzmYp2tCA@mail.gmail.com>
        (Andy Shevchenko's message of "Tue, 14 May 2019 12:23:33 +0300")
Message-ID: <871s11meg3.fsf@haabendal.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Tue, May 14, 2019 at 10:24 AM Esben Haabendal <esben@haabendal.dk> wrote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> > On Tue, May 07, 2019 at 02:22:18PM +0200, Esben Haabendal wrote:
>
>> We are on repeat here.  I don't agree with you here.  I have a simple
>> generic 8250 (16550A) compatible device, and cannot use it in a mfd
>> driver using the standard mfd-core framework.
>
>> The lacking of support for platform_get_resource() in the generic
>> serial8250 driver is not a feature.  It should be supported, just as it
>> is in several of the specialized 8250 drivers.
>
> We are going circles here.
> What exactly prevents you to use it? Presence of request_mem_region()?

Exactly.

>> It would still mean that I would have revert to not using convenient and
>> otherwise fully appropriate API calls like pci_request_regions() and
>> mfd_add_devices().
>
> Yes, here is the issue. 8250 requires the parent not to *request*
> resources. Because child handles IO access itself.

Ok, clearly we are not discussing the actual IO access.  The only issue
is how to handle the memory resource management.

And yes, serial8250 requires "the parent" to not request the resources.
But by doing so, it gets in the way of the mfd-core way of splitting a
properly requested resource.

>> The mfd driver in question is for a PCI device.  Not being able to
>> request the PCI regions seems silly.
>
> Nope. Otherwise, the parent which *doesn't handle* IO on behalf of
> child should not request its resources.

If I may, could I get you to discuss this with Lee Jones?

As I read both of your comments in this thread, you are not aligned on
how mfd drivers should handle resources.  And in that case, one of you
are most likely more right than the other, and if Lee is right, I seem
to be unable to convince you about that.

>> Not being able to register all child devices with the call introduced
>> for that sole purpose also seems silly.
>
>> Please take a look at https://lkml.org/lkml/2019/4/9/576
>> ("[PATCH v2 2/4] mfd: ioc3: Add driver for SGI IOC3 chip")
>
> Thank you for this link.
> Now, look at this comment:
>
> + /*
> + * Map all IOC3 registers.  These are shared between subdevices
> + * so the main IOC3 module manages them.
> + */
>
> Is it your case? Can we see the code?

That comment seems quite misleading.  I am quote certain that the uart
registers which are part of BAR 0 is not more shared between subdevices
than the uart registers in BAR 0 in my case.

But BAR 0 as a whole is shared between subdevices.  But BAR 0 can be
(is) split in parts that are exclusive to one subdevice.  The only
difference I see is that I don't have any registers accessed directly by
the mfd driver.

/Esben
