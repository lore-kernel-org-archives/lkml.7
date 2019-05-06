Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85981C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521662082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=haabendal.dk header.i=@haabendal.dk header.b="MkebEHJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfEFRkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:40:13 -0400
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com ([46.30.210.183]:37860
        "EHLO mailrelay2-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbfEFRkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=QvIXuHSMi14BbgpAu71CyRRHzUx37OGpE4k435JO/ew=;
        b=MkebEHJxy/Ptg/tSISn8t20elUABLs5VBPAUjaKtmoUeDnFL+ppsnT112xciWn38oV6s9jAV5zMsD
         icMY3u9sjspKLoEB8zuy6294GwriOl2X5LDBikWX/FK2qduTRZxWX1WJJRQmJxpUJDbDq8GIxhta1F
         lwTJOJCLCRLhcLEY=
X-HalOne-Cookie: 5d44f6536f09bb48291f160d6ae784b75b759e4b
X-HalOne-ID: fd5217d1-7025-11e9-9368-d0431ea8a290
Received: from localhost (unknown [87.49.44.240])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id fd5217d1-7025-11e9-9368-d0431ea8a290;
        Mon, 06 May 2019 17:40:08 +0000 (UTC)
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
        <87pnp11112.fsf@haabendal.dk>
        <20190502153124.GA9224@smile.fi.intel.com>
        <87ef5boaa7.fsf@haabendal.dk>
        <20190506164426.GO9224@smile.fi.intel.com>
Date:   Mon, 06 May 2019 19:40:07 +0200
In-Reply-To: <20190506164426.GO9224@smile.fi.intel.com> (Andy Shevchenko's
        message of "Mon, 6 May 2019 19:44:26 +0300")
Message-ID: <87o94f32iw.fsf@haabendal.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, May 06, 2019 at 05:46:56PM +0200, Esben Haabendal wrote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> >> > On Wed, May 01, 2019 at 09:17:37AM +0200, Esben Haabendal wrote:
>> >> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>
>> As an example, the sm501.c driver, the only driver in drivers/mfd/ which
>> uses serial8250 driver, does not use any code from mfd-core.
>> Incidentally, it is 1 year older than mfd-core.c, and as never been
>> refactored to use mfd-core functionality.
>
> So, sm501.c should not request resources for its children. This as simple as
> that.

Funny thing.  Even though sm501.c does not use mfd-core at all, it does
request resources for all its child devices, except for the uart
children.

sm501_register_usbhost(), sm501_register_display() and
sm501_register_gpio() all creates/requests resources.  But
sm501_register_uart() does not.

How many concrete examples are needed to convince you that what I am
trying to do is how it is done everywhere else (than
serial8250_core.c/serial8250_port.c, even in other 8250_*.c drivers)
(obviously not 100% true, there are ofcourse other pieces of code not
working well with resource management) ?

> What you are trying to do here is a hack workaround on the current
> behaviour in the Linux device model (resource management) as I told
> you already.

No.  If it was, then all (most) mfd drivers added after 2008 are hacky
workarounds, because the use mfd_add_devices().

There are currently 53 drivers in drivers/mfd/ that calls
mfd_add_devices() with one or more cells with resources attached.

Are they all hacky workarounds?

I am not trying to do anything that they are not already doing.

>> > Why not? Again, *slicing* resources is OK and that's what MFD for,
>> > *requesting*
>> > them in the parent is not.
>> 
>> Why we cannot use request_mem_region() for those memory resources again?
>
> Because it's how it was designed. "One device per one resource". If you would
> like to fix this, it should be done obviously not in 8250 driver or any other
> driver, but driver core.
>
> Nevertheless there is one particular exception here,
> i.e. IORESOURCE_MUXED.

I am not trying to fix the problem of having multiple drivers owning the
same resource.  I am just trying to make serial8250 driver behave so it
can use the resources that it is handed by mfd-core.

This really is how it (mfd and also device resource management) is
designed.  I am not inventing anything, or making a workaround.

Actually, you should take a look at the following specialized 8250
8250_aspeed_vuart.c
8250_bcm2835aux.c
8250_dw.c
8250_em.c
8250_ingenic.c
8250_lpc18xx.c
8250_mtk.c
8250_omap.c
8250_pxa.c
8250_uniphier.c

They all use platform_get_resource(), and will work nicely with mfd.
And of-course, none of them use request_mem_region().

So, if you want to insist that I create a clone of the current standard
serial8250 driver (serial8250_isa_driver in 8520_core.c), even though I
want absolutely nothing specialized, just need it to play nicely with
platform_get_resource(), what should I call the driver?  8520_plat.c ?

>> It fails because the resources are now already owned the mfd driver, on
>> behalf of the child.
>
> Yes. Behaves in order how it's implementer. No issues here.

If that was the case, then mfd-core would be implemented in order to not
work with existing platform drivers.  There definitely is an issue
here.  And it is in 8250_core.c and 8250_port.c.

>> > Nope, *requesting* resources as you mentioned lock them to the certain user.
>> 
>> I still think there is some confusion in relation to your use of the
>> word "requesting".  There is no explicit request/lock action in
>> kernel/resource.c.
>
> You have to check IORESOURCE_BUSY. It seems that what you missed in your
> picture.

Point taken.  I haven't put much focus on that.  But I don't see how
that is going to help making use of serial8250_isa_driver in combination
with mfd_add_devices().  I am not creating/requesting the resources.
That is done by mfd_add_device(), which I fail to see why I would need
to change.

> I didn't comment the rest until we will figure out the IO resource management
> in general.

I believe all my comments were related to this same resource management
discussion.

/Esben
