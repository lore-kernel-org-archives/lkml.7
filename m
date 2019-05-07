Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E943C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C00820C01
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=haabendal.dk header.i=@haabendal.dk header.b="puvTEdg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfEGLcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 07:32:46 -0400
Received: from mailrelay1-1.pub.mailoutpod1-cph3.one.com ([46.30.210.182]:51285
        "EHLO mailrelay1-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726276AbfEGLcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 07:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=lFL8IZmKwJqoyNss0tfJ1Sb2p+/9FnYRZqyq6BeOLTg=;
        b=puvTEdg70iRNAavyyF4jNiJRXxF3z2FPpW+jbQNgS4Q9Oe1Kt9lBJykrPbzDf3hKxjMg41yRPxUt0
         C8FFZZH4ucG3joNvI0sceCYCxTSkZWpKyoTlXqNGCZ9mUEjt50aqf5I1BPAJlykM5BTbhEoaQZFT0k
         OeemWS+2tTmyFCQY=
X-HalOne-Cookie: 07c12b20bf8977491cce9da87c47e1242f400d49
X-HalOne-ID: d34e2284-70bb-11e9-be4a-d0431ea8a283
Received: from localhost (unknown [193.163.1.7])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id d34e2284-70bb-11e9-be4a-d0431ea8a283;
        Tue, 07 May 2019 11:32:41 +0000 (UTC)
From:   Esben Haabendal <esben@haabendal.dk>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, Enrico Weigelt <lkml@metux.net>,
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
        <20190507093631.GC4529@dell>
Date:   Tue, 07 May 2019 13:32:41 +0200
In-Reply-To: <20190507093631.GC4529@dell> (Lee Jones's message of "Tue, 7 May
        2019 10:36:31 +0100")
Message-ID: <87woj2jy92.fsf@haabendal.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee.jones@linaro.org> writes:

> On Tue, 07 May 2019, Lee Jones wrote:
>> On Thu, 02 May 2019, Esben Haabendal wrote:
>> 
>> > Could you help clarify whether or not this patch is trying to do
>> > something odd/wrong?
>> > 
>> > I might be misunderstanding Andy (probably is), but the discussion
>> > revolves around the changes I propose where I change the serial8250
>> > driver to use platform_get_resource() in favour of
>> > request_mem_region()/release_mem_region().
>> 
>> Since 'serial8250' is registered as a platform device, I don't see any
>> reason why it shouldn't have the capability to obtain its memory
>> regions from the platform_get_*() helpers.
>
> Not sure which device you're trying to enable, but if it's booted
> using Device Tree, you could always use 'of_serial'.

It is an x86_64 platform, so there is unfortunately no device tree.

> It does seem a little odd that the 'serial8250' IP block has been
> incorporated into an MFD.  Which device is it you're trying to enable
> exactly? 

It is a Xilinx FPGA, containing a number of different devices, including
5 16550A UART devices (XPS 16550 UART v3.00a).  It also contains 3
Ethernet interfaces and a number of custom IP blocks.

The FPGA is connected to the CPU using PCIe, with all devices using
parts of a big common io memory block, specified by a PCI BAR.

/Esben
