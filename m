Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B89CC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283852086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=haabendal.dk header.i=@haabendal.dk header.b="WzTyjZI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfENHhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 03:37:40 -0400
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com ([46.30.210.183]:51446
        "EHLO mailrelay2-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726279AbfENHhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 03:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=QWHIQNN3/GVloHpDWkd7tztidhfedB4/rDXwqwKC8io=;
        b=WzTyjZI53WEUsDvqnoWAqeK3pEs2doKcx/BafTy9r2Vlw8jBqCPhCSXf/4Szj4hp/OXMrgz5loeG6
         iLnTEKmLAvK+k9F/pBsZz8BaCOmW1y/7XeK6y0AGHtk30IDnn3SCgCvyiBlQYw35LDZ8brUmPDUgVx
         V9e57T+AiFQ2n3LU=
X-HalOne-Cookie: d6c52a14cb2ac12375b82504112820e375415ae5
X-HalOne-ID: 24f28efd-761b-11e9-81c1-d0431ea8a290
Received: from localhost (unknown [193.163.1.7])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 24f28efd-761b-11e9-81c1-d0431ea8a290;
        Tue, 14 May 2019 07:37:36 +0000 (UTC)
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
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>
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
Date:   Tue, 14 May 2019 09:37:36 +0200
In-Reply-To: <20190507150847.GW9224@smile.fi.intel.com> (Andy Shevchenko's
        message of "Tue, 7 May 2019 18:08:47 +0300")
Message-ID: <87ftphmqpr.fsf@haabendal.dk>
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
> Most of the platform code that uses it is quite legacy, and all under arch/
> ideally should be converted to use Device Tree.

Please take a look at https://lkml.org/lkml/2019/4/9/576
("[PATCH v2 2/4] mfd: ioc3: Add driver for SGI IOC3 chip")

This is basically what I am trying to do.  I am just so unfortunate that
the serial devices I have are completely generic, so it does not make
sense for me to create a specialized 8250 driver.

Look at how the serial8250_ioc3_driver uses platform_get_resource() to
get the register memory, and how that works together with
mfd_add_devices() in the mfd driver.  Nice and elegant.  Standard
recommended approach for an mfd driver.

/Esben
