Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1911EC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D582E20693
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lGT7esVt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lGT7esVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfDSTUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:20:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45888 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfDSTUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:20:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B79B060F3D; Fri, 19 Apr 2019 08:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555663435;
        bh=wqCLB/J1DcRgEHYdQbSvkebWAN/iaxdHIIVRRnbOPZc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lGT7esVt1Df+LgU7l6DnCGVHS9y3Ptj5DrlRGsT6Oirkp2sD95vv71PRW2yn1vABS
         kNAHV/ZLw+q8Sy/QcL6O0XSP7pgs4xCHXSYMLyonm3FlglZ5bZRAoi1w2unO0ETnM0
         nPUEZBGwiJfMc+SwzWgI+cEmguDU9G8LFEzu9NVE=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A4FDF6115C;
        Fri, 19 Apr 2019 08:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555663435;
        bh=wqCLB/J1DcRgEHYdQbSvkebWAN/iaxdHIIVRRnbOPZc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lGT7esVt1Df+LgU7l6DnCGVHS9y3Ptj5DrlRGsT6Oirkp2sD95vv71PRW2yn1vABS
         kNAHV/ZLw+q8Sy/QcL6O0XSP7pgs4xCHXSYMLyonm3FlglZ5bZRAoi1w2unO0ETnM0
         nPUEZBGwiJfMc+SwzWgI+cEmguDU9G8LFEzu9NVE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A4FDF6115C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2] Input: uinput: Avoid Object-Already-Free with a global
 lock
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gaurav Kohli <gkohli@codeaurora.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Martin Kepplinger <martink@posteo.de>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
References: <1554883176-24318-1-git-send-email-mojha@codeaurora.org>
 <7299a6db-38b7-75c7-633a-00d2257eba45@codeaurora.org>
 <20190418014321.dptin7tpxpldhsns@penguin>
 <bb92c3f2-faf1-04ec-4c67-3aba56c507a9@codeaurora.org>
 <a4d1a2f3-1db7-e300-9569-7b7a2fadd64e@codeaurora.org>
 <20190419071152.x5ghvbybjhv76uxt@penguin>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <f3cd46fb-2bb1-0422-b2be-3f7625ec9c4e@codeaurora.org>
Date:   Fri, 19 Apr 2019 14:13:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419071152.x5ghvbybjhv76uxt@penguin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/19/2019 12:41 PM, dmitry.torokhov@gmail.com wrote:
> Hi Mukesh,
>
> On Fri, Apr 19, 2019 at 12:17:44PM +0530, Mukesh Ojha wrote:
>> For some reason my last mail did not get delivered,  sending it again.
>>
>>
>> On 4/18/2019 11:55 AM, Mukesh Ojha wrote:
>>>
>>> On 4/18/2019 7:13 AM, dmitry.torokhov@gmail.com wrote:
>>>> Hi Mukesh,
>>>>
>>>> On Mon, Apr 15, 2019 at 03:35:51PM +0530, Mukesh Ojha wrote:
>>>>> Hi Dmitry,
>>>>>
>>>>> Can you please have a look at this patch ? as this seems to reproducing
>>>>> quite frequently
>>>>>
>>>>> Thanks,
>>>>> Mukesh
>>>>>
>>>>> On 4/10/2019 1:29 PM, Mukesh Ojha wrote:
>>>>>> uinput_destroy_device() gets called from two places. In one place,
>>>>>> uinput_ioctl_handler() where it is protected under a lock
>>>>>> udev->mutex but there is no protection on udev device from freeing
>>>>>> inside uinput_release().
>>>> uinput_release() should be called when last file handle to the uinput
>>>> instance is being dropped, so there should be no other users and thus we
>>>> can't be racing with anyone.
>>> Lets say an example where i am creating input device quite frequently
>>>
>>> [   97.836603] input: syz0 as /devices/virtual/input/input262
>>> [   97.845589] input: syz0 as /devices/virtual/input/input261
>>> [   97.849415] input: syz0 as /devices/virtual/input/input263
>>> [   97.856479] input: syz0 as /devices/virtual/input/input264
>>> [   97.936128] input: syz0 as /devices/virtual/input/input265
>>>
>>> e.g input265
>>>
>>> while input265 gets created [1] and handlers are getting registered on
>>> that device*fput* gets called on
>>> that device as user space got to know that input265 is created and its
>>> reference is still 1(rare but possible).
> Are you saying that there are 2 threads sharing the same file
> descriptor, one issuing the registration ioctl while the other closing
> the same fd?

Dmitry,

I don't have a the exact look inside the app here, but this looks like 
the same as it is able to do
fput on the uinput device.

FYI
Syskaller app is running in userspace (which is for syscall fuzzing) on 
kernel which is enabled
with various config fault injection, FAULT_INJECTION,FAIL_SLAB, 
FAIL_PAGEALLOC, KASAN etc.

Thanks,
Mukesh

>
> Thanks.
>
