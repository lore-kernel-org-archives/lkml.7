Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AC0C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 03:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CF720851
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 03:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z69JU9hq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfCIDZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 22:25:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfCIDZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 22:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HLpr+obtdQymSLEX0VBeqqKTFk3mULyBsv8/ILpD39U=; b=Z69JU9hq0DuNMnqalC6uRQ35r
        cGyqhNfcvRi5J3T2UMa7a4ULYL1ckmiyfXHVbjgdwkeXh+L3izjDFFiU3w4HTUO2aYEi/9tJ3RBld
        c42b9pjyvgT2o1/JrKSgrR8EqrT1QhLbPEpdEbNINBj+x7QmIfhrOc04Ky771iqLHSQ+8g/THiusp
        OUvHB7ZPv9KAqCMU1mQeowVuxsKWH46JOsj3J/G0OUB3uNukg5n3n64GWEakOp/PUUGg8MhE+0q0j
        Ed+oVu5azL3tpbmvOA3gVt755ioJqlyPgi/Ev9HLuM8ShSey2OgeZgotHVxIBaU8NxpSw0F1BgRgG
        RhepMDe0A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2ScG-0004VQ-6k; Sat, 09 Mar 2019 03:25:41 +0000
Subject: Re: Smarter Kconfig help
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190305173111.t3n6ycktht7kxuhq@shell.armlinux.org.uk>
 <1551865552.9298.24.camel@pengutronix.de>
 <20190306095147.xyf3d62bywx4v6ji@shell.armlinux.org.uk>
 <CAHp75Vc_Nfm7tAwGtLuYgrPGPFQzx3a4ppx0+mXhF=q_X8jT7w@mail.gmail.com>
 <20190306113436.5ucdjppibwl6pahz@shell.armlinux.org.uk>
 <20190306124221.bf6qj6zx6jbdcsey@shell.armlinux.org.uk>
 <80d7c75a-f537-ee10-a139-d342c6b0f2b4@metux.net>
 <20190306202221.n654yxedjtdang5n@shell.armlinux.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e96ebc7b-29cf-c560-f922-cf6fc1ccaf9d@infradead.org>
Date:   Fri, 8 Mar 2019 19:25:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190306202221.n654yxedjtdang5n@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/19 12:22 PM, Russell King - ARM Linux admin wrote:
> On Wed, Mar 06, 2019 at 09:16:02PM +0100, Enrico Weigelt, metux IT consult wrote:
>> On 06.03.19 13:42, Russell King - ARM Linux admin wrote:
>>
>>> In case it isn't clear, this is the *exact* point here - I don't know> whether this option should be enabled for iMX6 or not, and the only>
>> way I found out was to grep the dts files in arch/arm/boot/dts for> the
>> driver's compatible string.  What that reveals is that *no* 32-bit> dts
>> files contain the compatible string, and so I summise that *no*> 32-bit
>> iMX SoC should have this driver enabled.
>> The problem is a bit more generic. I often have to spend lots of time
>> to find out which configs to enable on a specific board, to get certain
>> features (eg. network, sata, display, gpu, ...). Even worse: many
>> options require other stuff enabled before even showing up. And when
>> disabling unneeded stuff, it leaves lots of other things enabled.
>> (we don't have some `apt autoremove` kconfig counterpart :().
>>
>> I've decided to cope w/ that on a higher level and written a little
>> config generator tool for that - here you can enable high level
>> features (eg. 'network' or 'display', etc) and it will generate the
>> actual .config:
>>
>> 	https://github.com/metux/kmct
>>
>>> The excuse that "we can't list the explicit SoCs" to me seems to be> a very lame excuse
>>
>> Maybe this actually means "nobody here volounteered to actually maintain
>> these help texts" ?
>>
>>> The best that I can come up with right now, given what little I know> from grepping the 32-bit DTS files, is that the help text should at>
>> least indicate that it *isn't* applicable to 32-bit SoCs, or if you>
>> prefer, *is* applicable to 64-bit SoCs.  Beyond that, I have no>
>> information to formulate a better suggestion.
>> Perhaps just fix the text based on your knowledge and send a patch to
>> the maintainers. They'll propably tell you if it's incorrect.
> 
> Frankly, no.  I don't want to be going round endlessly writing help
> texts.
> 
> We need the effort to be properly distributed - we need those who
> _know_ the feature they're developing to write a proper help text.
> One way to achieve that is to make a proper informative help text
> a pre-requisit of accepting the code.

Ack.

> The quality of the help text is just as important as the quality of
> the code, and we really should be paying the same amount of attention
> to both.

It goes much further than this IMHO, such as:

- #including the needed header files and not #including header files that
  are not used.

- using the correct Kconfig dependencies and selects

- testing builds with multiple kconfig settings (as applicable)

- builds should be clean, and that means without newly added warnings as
  well as build errors

I.e., the build testing that the 0day kernel robot does and that Arnd
and I do and that a few other people do should not catch nearly as many build
problems as they do.  The developer who knows the code should put due
diligence into the entire package, not just the (driver) source code and
building/testing with one default config.


Documentation/process/submit-checklist.rst has a more thorough list.


-- 
~Randy
