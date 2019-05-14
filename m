Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E903C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 12:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1102147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 12:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=haabendal.dk header.i=@haabendal.dk header.b="nbP0sEYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfENMCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 08:02:45 -0400
Received: from mailrelay1-1.pub.mailoutpod1-cph3.one.com ([46.30.210.182]:34437
        "EHLO mailrelay1-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726472AbfENMCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 08:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=5sv3t5JTJ3ZU3du0fNjgMbkaEr65ujxjxS+6J7R4VNo=;
        b=nbP0sEYkUeQa4ml6M5q0hxeCdNcs7yG4INE6mm/YKbHBKpNM+MyZAtW1RCi7ZRjZ7wmSjAtqwvIxC
         x0LUUHSfRHIwmj7W1VWScoZQEa+9+3M65Po+i6lJ5rZ3QL36FQ5FAD5Pd/vyp0voawFJquzSbbddjT
         yvMEzStRsL4Da1ZE=
X-HalOne-Cookie: a6a677708409723a01024242b1d8a93317ea455c
X-HalOne-ID: 2c981014-7640-11e9-bc24-d0431ea8a283
Received: from localhost (unknown [193.163.1.7])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 2c981014-7640-11e9-bc24-d0431ea8a283;
        Tue, 14 May 2019 12:02:41 +0000 (UTC)
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
        <CAHp75VetoajaeqUnUuj4sNjhujqDkbqvQmxE+LMtzFN4so_jwA@mail.gmail.com>
Date:   Tue, 14 May 2019 14:02:40 +0200
In-Reply-To: <CAHp75VetoajaeqUnUuj4sNjhujqDkbqvQmxE+LMtzFN4so_jwA@mail.gmail.com>
        (Andy Shevchenko's message of "Tue, 14 May 2019 12:37:25 +0300")
Message-ID: <87zhnpkzvj.fsf@haabendal.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Tue, May 14, 2019 at 12:23 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Tue, May 14, 2019 at 10:24 AM Esben Haabendal <esben@haabendal.dk> wrote:
>
>> > Please take a look at https://lkml.org/lkml/2019/4/9/576
>> > ("[PATCH v2 2/4] mfd: ioc3: Add driver for SGI IOC3 chip")
>>
>> Thank you for this link.
>> Now, look at this comment:
>>
>> + /*
>> + * Map all IOC3 registers.  These are shared between subdevices
>> + * so the main IOC3 module manages them.
>> + */
>>
>> Is it your case? Can we see the code?
>
> They do not request resources by the way.

Actually, that looks like a bug in ioc3.c driver.

It is using mfd_add_devices() with a mem_base that has not been properly
requested, and the platform_get_resource() calls made by child drivers
does not guarantee exclusive access to the memory resources, as they are
not inserted in the root memory resource tree.

> You may do the same, I told you this several times.

In drivers/mfd/ioc3.c:

First, the uart resources are defined.  The register memory resource is
defined relative to the mfd driver memory resource.

+static struct resource ioc3_uarta_resources[] = {
+	DEFINE_RES_MEM(offsetof(struct ioc3, sregs.uarta),
+		       sizeof_field(struct ioc3, sregs.uarta)),
+	DEFINE_RES_IRQ(6)
+};

This is then used when creating the uart cell.

+		cell->name = "ioc3-serial8250";
+		cell->id = ioc3_serial_id++;
+		cell->resources = ioc3_uarta_resources;
+		cell->num_resources = ARRAY_SIZE(ioc3_uarta_resources);

Finally, the mfd_add_devices() call is made, giving the resource for the
BAR0 region (&ipd->pdev->resource[0]) as mem_base argument:

+	mfd_add_devices(&ipd->pdev->dev, -1, ioc3_mfd_cells,
+			cell - ioc3_mfd_cells, &ipd->pdev->resource[0],
+			0, ipd->domain);

This is just what I want to do.

But in order to guarantee exclusive access to the memory resource, I
need to have it requested.

/Esben

