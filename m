Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD89C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B828D206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553565575;
	bh=S+vy7MtkYSeBHrLzIA1nUZYgaiTpzcW96rqj0aBG3Ho=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=OtxK5gUFXM0dNTQTMqCd/JKBUIo8wXFffi7nUZDumn7AkIpcF+z12nl5zEoWLpbmN
	 qA4hfWmSiC7piTP3aIUWdtj6hxQ3zHUikKr2MiOlIyor/i82mSjwNAdqBQZyaoGbI5
	 BQ644gjCs5pZ5qpxR7ZJ/j6CBN6BUDi1aH2roRVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbfCZB7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:59:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbfCZB7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:59:32 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74589206BA;
        Tue, 26 Mar 2019 01:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553565571;
        bh=S+vy7MtkYSeBHrLzIA1nUZYgaiTpzcW96rqj0aBG3Ho=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=k2DqdBzdeZJJcfOD47um1q3T0EwBzJmvlrXZKM6wu1DxFN/T+7lL+0lervr7BpYMo
         q5+6VmHRS3tpdYWrYQ4KqcFTMgC1QT0ZcBoR06E9APhF0GFGY5Dy71bnJExJ60tdCg
         iCmjvKU9nJH59AjmKjsnLcIwuiyrZnvaY0O/0Iz8=
Subject: Re: [PATCH] tools: usb: usbip: adding support for older kernel
 versions
To:     Brian Norris <briannorris@chromium.org>
Cc:     David Valleau <valleau@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        shuah <shuah@kernel.org>
References: <20190306214730.6545-1-valleau@chromium.org>
 <44e151af-b6c4-d0af-3ef1-a5632d079915@kernel.org>
 <CA+ASDXMcnEfZzTjDGsDbZxX2Xknv6dt3H-3kN79WdKFzif2zsA@mail.gmail.com>
 <caee30e2-ddc4-0076-907e-558dbcfe7c52@kernel.org>
 <CA+ASDXOzTkXk_JtBDa4zkMhy3NyWv7Wn1i6YYtwRdeF8j_c2nA@mail.gmail.com>
 <23918a77-2694-fdae-4300-0882c7c940cf@kernel.org>
 <CA+ASDXOEkG36W-6rONqDntzChtq65=cQh6JVyjWhftBykXVTbw@mail.gmail.com>
 <759fcefa-974b-7430-e7cf-64eabd219d61@kernel.org>
 <CA+ASDXMt97g-r3PniB4Z9+DeETdybtZ2sUneRgmetRKVZC-FBw@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <01ee061c-bbf5-12f2-8e0e-eda3f9132ad0@kernel.org>
Date:   Mon, 25 Mar 2019 19:59:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CA+ASDXMt97g-r3PniB4Z9+DeETdybtZ2sUneRgmetRKVZC-FBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/19 7:29 PM, Brian Norris wrote:
> Hi Shuah,
> 
> On Mon, Mar 25, 2019 at 5:04 PM shuah <shuah@kernel.org> wrote:
>> Agreed. Let's move forward with the assumption that this won't happen
>> in the future.
> 

I would amend that to say, unless absolutely necessary. The user
exported information is stable after fixing the kernel address
pointer leaks. If something pops up that requires changes, I will
have to make a call on that.

> Great! Are you going to propose a Documentation/ABI/ patch to help
> with that? e.g., Documentation/ABI/testing/sysfs-platform-vhci-hcd?
> I'm frankly not that familiar with usbip (I'm just trying to help
> David out) and might not be the best person for describing the details
> exposed here.
> 

ABI will need to documented at some point. :) This driver moved from
staging to mainline around 3.18 time frame. So what you are seeing is
adaption and enhancements. Some background on this driver might help
understand some of the growing pains. :) This is one of the reasons,
I strongly recommend not using old tool on new kernels and make sure
you are on the latest stable releases. For more details on the nature
if security fixes:

https://events.linuxfoundation.org/wp-content/uploads/2017/11/One-Small-Step-to-Harden-USB-Over-IP-on-Linux-Shuah-Khan-Samsung-OSG.pdf

> And are you planning to try something else to maintain compatibility
> pre-[1]? I'm not saying you have to, but you mentioned it and I'd like
> to know if we're doing any duplicate work.
> 

1. I plan to fix the tool to make it run on older kernels (pre-USB 3.0).
2. I don't plan to support old tool running on new kernels. It doesn't
make sense considering the security fixes. You can use the latest on
older kernels (pre-USB 3.0).
3. I am going to assume you are *using* the latest stable kernels that
have the security fixes.

thanks,
-- Shuah



