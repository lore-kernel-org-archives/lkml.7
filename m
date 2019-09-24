Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5DDC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 10:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A2E214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 10:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YqGzRScs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbfIXKJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 06:09:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41410 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfIXKJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 06:09:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id s1so1038008pgv.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 03:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eZzNcc+wvQuzQf2GWcxTSylUxSPYFH1qsBG8DB3c2nY=;
        b=YqGzRScsb1FbTM5WCrcuiuWh1n0Rbn8sjw0unKF0AgsREOA5eYkIB5EO8cTBWrU8Mo
         UzydS8VMNZsF+nAINFsnu+7pLqr/jneh3+kAZQsscAp6H6NTjFlaWd83CVpHSvRCpzZZ
         x9HR9pp09reHZwmivsh1580x0BeKmD7D627MKZdNjGVSarYZN4p1n+H/QuMGpEczLCoo
         1+MHrvNwLa7vsPrJh5AZVE3Y7k9pshK5tbFXAaC0CvWCxUUF/15HPGfCyBiQVLJZSl2f
         rTiVmhhcScE/9pFeus7NH2PZue9f0WQGJGOKp9VS+FZWer5QOHcVCE0XanyzjGney+iB
         DK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eZzNcc+wvQuzQf2GWcxTSylUxSPYFH1qsBG8DB3c2nY=;
        b=NTRbSZw0vkz/FtJcpgq9afHYiYtk67A0eSwCNzwjCdvhWZRp8y/eNs+FboMl87ujig
         iuu+lyEYU5gAc0FFDHVQmoXSHR4Sif0yW7ET89MeK+bhwkVjkNSecy1PvQtllxscLpKH
         QSdXbnxUTYYxjFKWmZyAq00Hz2spbAQ/Es+9FIdBaW2M7aHXQp4UyBgdVLm2nN257R/e
         tiX25XfhEMIS0ewsyjEoRZ7w6uAFoCdBVbUXJXrT1ptc0vHxHmGuY2B88Wrm+qkHIzaz
         gMQv3Dz8GHCkctgY+o6ZfYDpPSzP5ecIrWx9Y+TnI8yKlMT4+gxI0L0ReQFgG63SHmaX
         2kKQ==
X-Gm-Message-State: APjAAAUqkEx+PJyQE0x0UNafLXD1Ce6/1QvyrhKhcVPTUZiiYQJMV0lg
        3SPmQ5iyMZqFvjpdSjTmCNBVS55XWXcXEg==
X-Google-Smtp-Source: APXvYqwlqchHmVSIE78No20chUn+TpSKqX4ZZfuY2wwCDIiO0RpDdGoDqhrWfTBpuXln1+tHL4Mpnw==
X-Received: by 2002:a63:2aca:: with SMTP id q193mr2299446pgq.156.1569319752154;
        Tue, 24 Sep 2019 03:09:12 -0700 (PDT)
Received: from ?IPv6:2600:380:8419:743e:6023:99b1:fa9f:a39c? ([2600:380:8419:743e:6023:99b1:fa9f:a39c])
        by smtp.gmail.com with ESMTPSA id f6sm1368574pga.50.2019.09.24.03.09.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 03:09:10 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1569139018.git.asml.silence@gmail.com>
 <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
 <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
 <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
 <b999490f-6138-b685-5472-5cd1843b747d@kernel.dk>
 <4240453d-2a6a-092f-28a4-523d2f6fc6c1@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <405d24d1-6f73-0437-e3e9-f862d1437c21@kernel.dk>
Date:   Tue, 24 Sep 2019 12:09:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4240453d-2a6a-092f-28a4-523d2f6fc6c1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/19 3:20 AM, Pavel Begunkov wrote:
> 
> 
> On 24/09/2019 11:27, Jens Axboe wrote:
>> On 9/24/19 2:02 AM, Jens Axboe wrote:
>>> On 9/24/19 1:06 AM, Pavel Begunkov wrote:
>>>> On 24/09/2019 02:00, Jens Axboe wrote:
>>>>>> I think we can do the same thing, just wrapping the waitqueue in a
>>>>>> structure with a count in it, on the stack. Got some flight time
>>>>>> coming up later today, let me try and cook up a patch.
>>>>>
>>>>> Totally untested, and sent out 5 min before departure... But something
>>>>> like this.
>>>> Hmm, reminds me my first version. Basically that's the same thing but
>>>> with macroses inlined. I wanted to make it reusable and self-contained,
>>>> though.
>>>>
>>>> If you don't think it could be useful in other places, sure, we could do
>>>> something like that. Is that so?
>>>
>>> I totally agree it could be useful in other places. Maybe formalized and
>>> used with wake_up_nr() instead of adding a new primitive? Haven't looked
>>> into that, I may be talking nonsense.
>>>
>>> In any case, I did get a chance to test it and it works for me. Here's
>>> the "finished" version, slightly cleaned up and with a comment added
>>> for good measure.
>>
>> Notes:
>>
>> This version gets the ordering right, you need exclusive waits to get
>> fifo ordering on the waitqueue.
>>
>> Both versions (yours and mine) suffer from the problem of potentially
>> waking too many. I don't think this is a real issue, as generally we
>> don't do threaded access to the io_urings. But if you had the following
>> tasks wait on the cqring:
>>
>> [min_events = 32], [min_events = 8], [min_events = 8]
>>
>> and we reach the io_cqring_events() == threshold, we'll wake all three.
>> I don't see a good solution to this, so I suspect we just live with
>> until proven an issue. Both versions are much better than what we have
>> now.
>>
> If io_cqring_events() == 8, only the last two would be woken up in both
> implementations, as to_wait/threshold is specified per waiter. Isn't it?

If io_cqring_events() == 8, then none would be woken in my
implementation since the first one will break the wakeup loop.

> Agree with waiting, I don't see a good real-life case for that, that
> couldn't be done efficiently in userspace.

Exactly

-- 
Jens Axboe

