Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A1CC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 20:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB35620838
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 20:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LHI9vvVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfL0U1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 15:27:01 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37624 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfL0U1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 15:27:01 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so15226350pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 12:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GkUIVOSRB0ui7Tj6XXdW1tapEpmmQozsPyWQm0I5SNk=;
        b=LHI9vvVJi2FkSw3sqZyRb6OmkyjLywchf1TQDsZ3J4vUuI0a4l1RCbrksgR73xsP3I
         u+4sLkRTGpqMUXuyr1xxYf+8QwrizUvbrbX0yJjHVjYV8R6yW2fCkAaGPmCDi87C8nUi
         vm5xWe9ELj1DsGUYw9AwpnXvBICfdEVR1goh70myIVVhAjNur3y4qMsJ13rY6e9vj+LP
         uajymLh5LrI+QNZjbSbU6MzyEaJCXHf4VURcU5KvjNLA9oVL3Dfszxfl+lEZ84fv88zL
         +W+jRKf7a9QJUFtG1lqmE/FsPFaai0Q4yPXnVXayONgcscKaYoKRp06GewcGTZxFpVzu
         Th6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GkUIVOSRB0ui7Tj6XXdW1tapEpmmQozsPyWQm0I5SNk=;
        b=NYdl2RHk/IX9KTvG0FQWydpfyictfUNY+4d4eJDLkL8x3HteBKDGmL8wjysyT1o8xT
         3/tZvojaii3txMjN0UMQ8lTkT5ODAPeWuEN3Dp/HtMT/rFeLNMkrNwfAKKEi3kvWB6PF
         WnLYSd9zeuOByZTfi5j1EPBvtXb/2zL/IGUdPU1NbgeVgYobyDWShuaIwwNA9k1v+21l
         nAbLcQdsJK1+Zn3PlrYGPdSdXduqOY4+ez/3tFAtgyRm7nQhzFY4WkjZ8wJDf6/A++/N
         iqk8AebXUWJc719eeO7Z2PJycgC4dlci+4fnpM67oz5GmaDu9TgWJ66SA9FCeyuRp+VS
         JMkg==
X-Gm-Message-State: APjAAAUmEKSAdC105BHiXLkIm2zXaZY6lyXJHUYAZkGsT84Ju1CUjL5C
        H/lMWb6aaoKaQziF1M8UZnROvA==
X-Google-Smtp-Source: APXvYqzMFuyFFX1cCQquvaHxVqERuVRKvWiCGeNTeYX+5Z9dpHxR068mYwZLO5ITa/OtBjQVFIouOQ==
X-Received: by 2002:a63:f901:: with SMTP id h1mr56630767pgi.445.1577478420181;
        Fri, 27 Dec 2019 12:27:00 -0800 (PST)
Received: from smuckle.san.corp.google.com ([2620:15c:2d:3:8fbe:ee3b:c81d:238d])
        by smtp.gmail.com with ESMTPSA id t63sm42038315pfb.70.2019.12.27.12.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2019 12:26:59 -0800 (PST)
Subject: Re: [PATCH] rtc: class: support hctosys from modular RTC drivers
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        kernel-team@android.com
References: <20191106194625.116692-1-smuckle@google.com>
 <20191106231923.GK8309@piout.net>
 <b96f085b-8a0c-7c71-4fde-8af83d49823a@google.com>
 <20191115133627.GT3572@piout.net>
From:   Steve Muckle <smuckle@google.com>
Message-ID: <e43fd369-f0ad-f8bb-be8a-1a3ca038af44@google.com>
Date:   Fri, 27 Dec 2019 12:26:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191115133627.GT3572@piout.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(accidentally sent as HTML, resending in text)

On 11/15/19 5:36 AM, Alexandre Belloni wrote:
> On 06/11/2019 15:37:49-0800, Steve Muckle wrote:
>> On 11/6/19 3:19 PM, Alexandre Belloni wrote:
>>> On 06/11/2019 11:46:25-0800, Steve Muckle wrote:
>>>> Due to distribution constraints it may not be possible to statically
>>>> compile the required RTC driver into the kernel.
>>>>
>>>> Expand RTC_HCTOSYS support to cover all RTC devices (statically compiled
>>>> or not) by checking at the end of RTC device registration whether the
>>>> time should be synced.
>>>>
>>>
>>> This does not really help distributions because most of them will still
>>> have "rtc0" hardcoded and rtc0 is often the rtc that shouldn't be used.
>>
>> Just for my own edification, why is that? Is rtc0 normally useless on PC for
>> some reason?
>>
> 
> On PC, rtc0 is probably fine which is not the case for other
> architectures where rtc0 is the SoC RTC and is often not battery backed.
> 
>> On the platforms I'm working with I believe it can be assured that rtc0 will
>> be the correct rtc. That doesn't help typical distributions though.
>>
>> What about a kernel parameter to optionally override the rtc hctosys device
>> at runtime?
>>
> 
> What about keeping that in userspace instead which is way easier than
> messing with kernel parameters?

This should ideally happen before file systems are mounted so I don't 
see many alternatives for communicating which RTC should be used. 
Android uses the kernel command line for userspace parameters as well 
and that's an option but that defeats part of the value of doing it in 
userspace IMO. There's also device tree but I'm not sure this belongs there.

Hctosys is also saving and restoring the system time on suspend/resume. 
It seems more efficient to me to do this (which happens very frequently 
on an Android device) in the kernel as opposed to in userspace.

If I set the initial system time from the rtc in userspace but continue 
to rely on the hctosys suspend/resume code, as it stands there will be a 
window after the rtc driver is loaded but before the system time is set 
where if suspend is entered, the correct time in the rtc will be lost.
>>> Can't you move away from HCTOSYS and do the correct thing in userspace
>>> instead of the crap hctosys is doing?
>>
>> Yes, I just figured it's a small change, and if hctosys can be made to work
>> might as well use that.
> 
> The fact is that hctosys is more related to time keeping than it is to
> the RTC subsytem. It also does a very poor job setting the system time
> because adding 0.5s is not the smartest thing to do. The rtc granularity
> is indeed 1 second but is can be very precisely set.
No argument with that, but millions of devices successfully rely on it 
today. AFAICT this simple patch doesn't make anything worse. Together 
with a change to support a kernel parameter for runtime rtc selection, 
it should allow RTC drivers to be modularized on many systems. Can it be 
adopted as a stopgap measure?
