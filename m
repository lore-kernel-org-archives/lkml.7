Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4034BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A3121582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAuRvIkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfLQNLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:11:33 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:46319 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfLQNLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:11:32 -0500
Received: by mail-pj1-f67.google.com with SMTP id z21so4558125pjq.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 05:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0bLDwlFhAjD8JtsYFaAWxIGU/Ti65IuVrutK0Wnwgh8=;
        b=TAuRvIkzOJHjpRc9awnY0e6r2IWU7Gi6v5PV5CP94fu2+VtCKjM3XUqifVueOckKUH
         d2fFSdNG/i1T2MBK+fy4evxJfUr+28/JP7AWL7Hw7ohz9G4msyEW3Rijby9DSxA473L8
         IhAfQ2+HULliz+DFiHPXcNFDSKKXiwjTDE2qJ/SFTh8ww9dvEvSrDdWFu3ObuWoXxM33
         IbALuXs5eSJpO3ubPWz6kdZe4g+GwJcX+m4llBnivP6OIM9VvK3UTtZmQrWdh5MNj/ht
         vJ8TColPBA4quSZpBWOIn164XGwHC4ko+vSs4NOu7BhRN/oMEDZp0OOJIZTD+sHKCe9/
         EbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0bLDwlFhAjD8JtsYFaAWxIGU/Ti65IuVrutK0Wnwgh8=;
        b=tm8Cf5AqBvfYahcXaQbtV12HzjTjz4YLEhbm3pYhMKNMCzrT/NqTGY6d8fpgiqtYt9
         YecTllbZi1vvlFtXRRb32BTWx2j8cm0Ivkc0fUSJHW8wYbHBVL6efGJfpKkXOy7r+2px
         H24azFGVYt36zo9FyMRWonbeEG7CmCOxhmmdcAZ0biNu1BK0+QP8NjKPMhegqCOW9WMc
         7g/e5Xq38xjeAlUmq0QYRtux+KaUvhx57ttE8eAIe28//bKlII202pwo5fR41Dciqm88
         QfaaakEPf1njCme/Iv8nsQDWT4ALkqY0vTqvIC1mmtYtQDsoqzYVoZinLQoWPTguc8mr
         J4ZQ==
X-Gm-Message-State: APjAAAXZwMDC25R72EZvu3KrhMJGeHtx+++GmOYEf6DT7IjwVG6ICCMs
        Qdy6pAOAxlk6ZwSiz/kssmG6oHluqGc=
X-Google-Smtp-Source: APXvYqy5Zw08hhM6pxUoWPxI6pHme3hvlON8SIHpX4hJW6WIeLwb+ViJQ7OCiWtEWvmYyhTdC6xyug==
X-Received: by 2002:a17:902:b609:: with SMTP id b9mr22592307pls.70.1576588291234;
        Tue, 17 Dec 2019 05:11:31 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.139.134? ([2402:f000:1:1501:200:5efe:a66f:8b86])
        by smtp.gmail.com with ESMTPSA id x65sm23435167pfb.171.2019.12.17.05.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 05:11:30 -0800 (PST)
Subject: Re: [BUG] kernel: kcov: a possible sleep-in-atomic-context bug in
 kcov_ioctl()
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <3c4608bc-9c84-d79b-de76-b1a1a2a4fb6d@gmail.com>
 <CACT4Y+b3nvFAgM32SF0Bv46EOO4UFEK3M99pqYzEwmsmLvmhTQ@mail.gmail.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <e0305f5c-ae52-c144-fe50-00f3f815ad82@gmail.com>
Date:   Tue, 17 Dec 2019 21:11:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+b3nvFAgM32SF0Bv46EOO4UFEK3M99pqYzEwmsmLvmhTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/12/17 21:02, Dmitry Vyukov wrote:
> On Tue, Dec 17, 2019 at 1:56 PM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>> The kernel may sleep while holding a spinlock.
>> The function call path (from bottom to top) in Linux 4.19 is:
>>
>> kernel/kcov.c, 237:
>>       vfree in kcov_put
>> kernel/kcov.c, 413:
>>       kcov_put in kcov_ioctl_locked
>> kernel/kcov.c, 427:
>>       kcov_ioctl_locked in kcov_ioctl
>> kernel/kcov.c, 426:
>>       spin_lock in kcov_ioctl
>>
>> vfree() can sleep at runtime.
>>
>> I am not sure how to properly fix this possible bug, so I only report it.
>> A possible way is to replace vfree() with kfree(), and replace related
>> calls to vmalloc() with kmalloc().
>>
>> This bug is found by a static analysis tool STCheck written by myself.
> Hi Jia-Ju,
>
> Are you sure kcov_ioctl_locked can really release the descriptor? It
> happens in the context of ioctl, which means there is an open
> reference for the file descriptor. So ioctl should not do vfree I
> would assume.

Thanks for the reply :)
I am not sure, because I am not familiar with kcov.
But looking at the code, if the reference count of kcov is 1, vfree() 
could be called.


Best wishes,
Jia-Ju Bai
