Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3575C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE922053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=haabendal.dk header.i=@haabendal.dk header.b="sb528pFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfEFPTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:19:32 -0400
Received: from mailrelay1-1.pub.mailoutpod1-cph3.one.com ([46.30.210.182]:33422
        "EHLO mailrelay1-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726340AbfEFPTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=tIIjXVsYUQfztV2HMDyykqPnej8ujRojeO25gbPLAx8=;
        b=sb528pFjnouTzc+J3eVPhDX7vdvgMDXk7BFMuSZKambgzakehkG2af6Eb6srR1N1yDwoC8KtZnvPQ
         FU0t8xwGzqIPbM+AC+LEjkp16i0sMn26is3+Dp4i+K8hz36uub3HsQdSayvF5pfuL9hum9evDt4e76
         82cUEXBMxPHLOmcY=
X-HalOne-Cookie: 97b3711e6a3e173542b3f9ed2cff811ff8f0d11a
X-HalOne-ID: 56a34210-7012-11e9-be4a-d0431ea8a283
Received: from localhost (unknown [193.163.1.7])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 56a34210-7012-11e9-be4a-d0431ea8a283;
        Mon, 06 May 2019 15:19:27 +0000 (UTC)
From:   Esben Haabendal <esben@haabendal.dk>
To:     "Enrico Weigelt\, metux IT consult" <lkml@metux.net>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>,
        Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device resources
References: <20190430140416.4707-1-esben@geanix.com>
        <a535c7b6-54e0-ab58-7626-f7f631773c18@metux.net>
Date:   Mon, 06 May 2019 17:19:27 +0200
In-Reply-To: <a535c7b6-54e0-ab58-7626-f7f631773c18@metux.net> (Enrico
        Weigelt's message of "Thu, 2 May 2019 21:41:01 +0200")
Message-ID: <87imunobk0.fsf@haabendal.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Enrico Weigelt, metux IT consult" <lkml@metux.net> writes:

> On 30.04.19 16:04, Esben Haabendal wrote:
>> Allow getting memory resource (mapbase or iobase) as well as irq from
>> platform_device resources.
>> 
>> The UPF_DEV_RESOURCES flag must be set for devices where platform_device
>> resources are to be used.  When not set, driver behaves as before.
>> 
>> This allows use of the serial8250 driver together with devices with
>> resources added by platform_device_add_resources(), such as mfd child
>> devices added with mfd_add_devices().
>
> I like the idea (actually, quite the direction I'd like to go), but
> unfortunately it's more compilicated than that.
>
> Some drivers don't use these fields, eg. 8250 determines the mapsize
> based on several factors, at the time of the mapping is done. That's
> one of the things my patches shall clean up.

Could you take a quick look at my patch again.  The patch only changes
the probe method in the serial8250_isa_driver in 8250_core.c file.

So other drivers are not affected by this change.

And with the addition of the new UPF_DEV_RESOURCES flag, no existing
platforms should be affected either.

The patch merely makes it possible to start using plain "serial8250"
driver (serial8250_isa_driver) with standard platform resources, fx. as
implemented by mfd-core.

/Esben
