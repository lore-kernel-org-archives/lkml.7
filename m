Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE53FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0C320657
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553551654;
	bh=bdQA1yn+ubC5F3Je6x5NQH25TE/gFi/MmaI8LZCgtAs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=glA6cnXll6PgakeAGAeFYcUCuG1jg16nF+PIXaVin0RywtL9c37sROjw4Wf8r4k9L
	 b9rqxRGUgwL/R9AmKlOUW3vAd57xo6OapEXRj0vYhVtU81opQpv0I0ha5mtxQo5LyN
	 6CxOL2KM+sXCl2sLTdpfnyHDy7EpXHjGdZIBMClA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbfCYWHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729297AbfCYWHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:07:32 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5753120657;
        Mon, 25 Mar 2019 22:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553551650;
        bh=bdQA1yn+ubC5F3Je6x5NQH25TE/gFi/MmaI8LZCgtAs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SNl5PkWF27q9qFfSlWDyDL7iwUBc6+MWT1aV+n299FzF9b8VqmKITLYmYSmotWn3I
         0akS8xtPucp3Bru7Z7sJllVHs7BLxpqa3XUsFowXWwqoiIFoA1xE0PbShJXOvG1pQ/
         Mn07n77+wF9gQeotyrwxS5wN65CRwqOpVs+Nh0OA=
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
From:   shuah <shuah@kernel.org>
Message-ID: <23918a77-2694-fdae-4300-0882c7c940cf@kernel.org>
Date:   Mon, 25 Mar 2019 16:07:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CA+ASDXOzTkXk_JtBDa4zkMhy3NyWv7Wn1i6YYtwRdeF8j_c2nA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

On 3/25/19 11:56 AM, Brian Norris wrote:
> Hi Shuah,
> 
> On Mon, Mar 25, 2019 at 8:51 AM shuah <shuah@kernel.org> wrote:
>> On 3/18/19 12:23 PM, Brian Norris wrote:
>>> On Sat, Mar 16, 2019 at 4:40 PM shuah <shuah@kernel.org> wrote:
>>>> I would like to understand the reasons for wanting to run new tool on
>>>> old kernels.
>>>
>>> On Chromium OS, we ship more or less the same user space for a variety
>>> of systems, but not all of those run the same kernel. That's not
>>> exactly a novel concept -- many good tools are written such that they
>>> degrade gracefully when running with reduced feature sets (e.g., older
>>> kernels). While we are working on reducing the divergence and number
>>> of kernels we ship, it's currently a fact of life that we have to
>>> support multiple target kernel versions.
>>
>> Thanks for the context for this change.
> 
> One thing to add: we're currently only using usbip as a test utility,
> and we're not yet enabling it on older kernels (because of this
> precise problem).
> 
>>> Is there a fundamental problem with VHCI such that it doesn't have a
>>> stable ABI that tools can be written against?
>>>
>>
>> In general the ABI is stable.
> 
> No, it really isn't. This commit was a breaking change:
> 
> commit 2f2d0088eb93db5c649d2a5e34a3800a8a935fc5
> Author: Shuah Khan <shuahkh@osg.samsung.com>
> Date: Thu Dec 7 14:16:49 2017 -0700
> 
>    usbip: prevent vhci_hcd driver from leaking a socket pointer address
> 
> That one is arguably OK, since nobody was actually using that field
> (except for parsing it and throwing it away), and it's a security
> leak.
> 

The ABI change and tool change went in the same security fix in my
back-port. I understand you are seeing it because you are using an
older 3.18 kernel. It was a judgment call to break ABI to fix the
leak. Looks like we are on the same page on this one.

> But this one is definitely a break:
> 
> commit 1c9de5bf428612458427943b724bea51abde520a
> Author: Yuyang Du <yuyang.du@intel.com>
> Date: Thu Jun 8 13:04:10 2017 +0800
> 
>    usbip: vhci-hcd: Add USB3 SuperSpeed support
> 
> You can't just arbitrarily add columns to the beginning of a file like
> that and claim that you're not breaking ABI. And I shouldn't need to
> remind you that Thou Shalt Not Break User Space.

USB 3.0 driver and tool support went in, I would say it was oversight to
not make sure the tool continues to work on older kernels.

> 
> Now, this whole file has tons of problems:
>   * it's not documented at all in Documentation/ABI/ (so hey, you can
> argue there's no ABI to break!)
>   * it violates the "one piece of information per attribute" rule; this
> contributes to the previous point, since it's hard to extend anything
> without breaking user space
> 

Agreed. The documentation could use work.

>> +#define V3_18_STATUS_HEADER "prt sta spd bus dev socket
>> local_busid"
>>
>> What's your 3.18 kernel version? I think you are missing security
>> fixes that prevent socket address leak in the status file.
> 
> We're not using the latest 3.18.y stable series, if that's what you're
> asking. So no, we don't have that security patch. But we also don't
> currently enable USBIP_CORE and similar. We can backport stuff if we
> need (backporting that security fix is on my/our plate), but we'd
> probably like to understand the maintenance landscape here first.
> Clearly usbip is not maintained with ABI compatibility in mind.
> 

I wouldn't characterize it is as "Clearly usbip is not maintained
with ABI compatibility in mind." It is not the intent to break ABI.

I back-ported the security to fix to all the stable releases.

> 
> I think we should settle the biggest questions first: documenting
> (and/or re-implementing) the current ABI, so that we have a stable
> target. Going forward, if we are to pretend this is a real kernel
> feature, it should not be breaking compatibility arbitrarily like it
> has already. If I started using usbip on kernel 3.18 (+ the
> pointer-leaking security fix), I should not expect to see my user
> space break just because I upgraded to the latest kernel.
> 

So what's your ability to upgrade to 3.18 latest to get the security
fix. You would want to pick this up anyway.

Now the second issue is "supporting the latest tool on older kernels".
Guess I didn't think about the possibility of tools from 5.1 being run
on 3.18 :)

I am willing to guarantee that going forward the latest usbip tool
will not break on the supported stable releases.

I am going to take a look at fixing the tool to run on older kernels.

thanks,
-- Shuah

