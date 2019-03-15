Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BECC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FE2218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfCOUtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:49:08 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:40977 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfCOUtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:49:08 -0400
Received: by mail-qt1-f182.google.com with SMTP id w30so6347599qta.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 13:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a4CPB5A/+GpX8tyD94diakciAgGyDRgPweGwpqPXIo0=;
        b=JQWIbU9TIgGTaFHCbPdhixQESHoHWfy9mtcULINoBO2UdUw8RQDfW0YFoAboKHSQDC
         200M2MoQq0KbYPBBS2h+Qn6JJv05vNpvtPmOO7ym/a5V3LnLEwICHcYj54p3lUG5hxeG
         CrbNnwdZpXEoDzM/sdZuCotSoIHR5V/4o9o1aOp6FBTE1L1tgB0vMry4XQHVyOwlJgmx
         QCq0KrXQlgtOJBLNg/FhFI3uj7ImrLCVvWIRcAm+B5F9ftpcXmLi/1DhizJrUoXwGEqj
         FBhRO17GJfzbyK2zUzgsyFM/iWYbecW2sftzpJLzq/eOg3jfA0je1U+TZEkejgtg/wKi
         V+QQ==
X-Gm-Message-State: APjAAAX9iRSWsR72/Feb6ikfAk4i+rXOSuBKTe6j0xbSkU+t5pUhkZZi
        yAGTH+wBENcEs8ZA9AWseZlGKtTocPU=
X-Google-Smtp-Source: APXvYqzMhFPCrdJg4uY8aiGeS113NHXNgyP0VDE5oq7oxFZGVUb67naWrPjP0n/F507k9rBkr7Uqsw==
X-Received: by 2002:a0c:ba13:: with SMTP id w19mr3973639qvf.179.1552682947343;
        Fri, 15 Mar 2019 13:49:07 -0700 (PDT)
Received: from ?IPv6:2601:602:9800:dae6::362? ([2601:602:9800:dae6::362])
        by smtp.gmail.com with ESMTPSA id w8sm3213970qkw.80.2019.03.15.13.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 13:49:06 -0700 (PDT)
Subject: Re: [RFC][PATCH 5/5 v2] kselftests: Add dma-heap test
To:     John Stultz <john.stultz@linaro.org>
Cc:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-6-git-send-email-john.stultz@linaro.org>
 <CA+M3ks6AUmmYbXscjTRo+Vr-6cV8okafsDn2Tg3tskvzrV_dbA@mail.gmail.com>
 <CALAqxLWxpExDpiKbNGQ6Oz5h=FUPNLvehm34JdrntLQjFed41w@mail.gmail.com>
 <232410de-f20c-cde8-fdbb-48ca8ec1223b@redhat.com>
 <CALAqxLUjSZHBXsT0c-KTra4zLFxCYDmYHTJswk5OckrUbd=ykg@mail.gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <501196c4-e5bd-476d-21a8-3450d804cd5b@redhat.com>
Date:   Fri, 15 Mar 2019 13:49:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLUjSZHBXsT0c-KTra4zLFxCYDmYHTJswk5OckrUbd=ykg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/19 1:13 PM, John Stultz wrote:
> On Fri, Mar 15, 2019 at 1:07 PM Laura Abbott <labbott@redhat.com> wrote:
>>
>> On 3/6/19 9:01 AM, John Stultz wrote:
>>> On Wed, Mar 6, 2019 at 8:14 AM Benjamin Gaignard
>>> <benjamin.gaignard@linaro.org> wrote:
>>>> Le mar. 5 mars 2019 à 21:54, John Stultz <john.stultz@linaro.org> a écrit :
>>>>> +
>>>>> +       printf("Allocating 1 MEG\n");
>>>>> +       ret = dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
>>>>> +       if (ret)
>>>>> +               goto out;
>>>>> +
>>>>> +       /* DO SOMETHING WITH THE DMABUF HERE? */
>>>>
>>>> You can do a call to mmap and write a pattern in the buffer.
>>>
>>> Yea. I can also do some invalid allocations to make sure things fail properly.
>>>
>>> But I was talking a bit w/ Sumit about the lack of any general dmabuf
>>> tests, and am curious if we need to have a importer device driver that
>>> can validate its a real dmabuf and exercise more of the dmabuf ops.
>>>
>>> thanks
>>> -john
>>>
>>
>> There's the vgem driver in drm. I did some work to clean that
>> up so it could take an import af33a9190d02 ("drm/vgem: Enable dmabuf import
>> interfaces") . I mostly used it for private tests and never ended
>> up upstreaming any of the tests.
> 
> Thanks for the poitner, I'll check that out as well!  Also, if you
> still have them around, I'd be interested in checking out the tests to
> try to get something integrated into kselftest.
> 
> Talking with Brian yesterday, there was some thought that we should
> try to put together some sort of example dmabuf pipeline that isn't
> hardware dependent and can be used to demonstrate the usage model as
> well as validate the frameworks and maybe even benchmark some of the
> ideas floating around right now.  So suggestions here would be
> welcome!
> 

So the existing ion selftest (tools/testing/selftests/android/ion)
does make use of the import to do some very simple tests.
I can't seem to find the more complex tests I had though
they may have been lost during my last machine move :(

I do think building off of vgem would be a good first step
for a testing pipeline, although I worry we wouldn't be
able to measure caching effects without a real device since
setting up coherency testing otherwise seems error prone.

Thanks,
Laura

> thanks
> -john
> 

