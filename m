Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8649BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAE020717
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBJBDRwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfLQNRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:17:23 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32847 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfLQNRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:17:22 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so5682403pgk.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 05:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=q7HMsQPCoGg7Kj9u51JEhABe48pFo2CGzQTfPBf3p5Q=;
        b=nBJBDRwVA66xUHFjL5+fvgO8NsgGXXyQCATNhRjftbI1Stk6F7lCQePQG5cVVTlmOu
         PLgj5P2Xft+2WP8RWyy9iGpctLbmTmIKyIXgI0b2xW453G4zgK2OTMqXpDWQspAn6YOL
         XosRlp531XGMFHE/fpftV3wsb7z7MCct7BuPOev8HZwuR91jUjtQnA//3Y+/N0nRFYiA
         RNRa2RhvlTuye/ADUPlj4EdME77TTT5+eFl/pfFIa5aPmgYAxAGz33Q0228ws+tJk1sS
         oPmHhRfxywvaJwHc0k7wyNN3wLGNsYN2Z+kuWLtyxjZrjyuV1BuVxWi7mkZNPVgNC9nb
         DNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=q7HMsQPCoGg7Kj9u51JEhABe48pFo2CGzQTfPBf3p5Q=;
        b=ESSVh0/j5UsVUYJCJfzB+DxNr9uGkg8fDhHT4no/mvtqNdFHDVkoyBQMrLP5J4Qd3v
         /cpU801hinTrLHs9s/0GTy/s9slYRNCEhSb5I0W3T/RRjd5IAHnG02t/AOWGTyatuf3A
         j3yAXk5B+OI1GabC8XEJ2UVG0FE8H+FiY89cwYZUAQPLJoiw1gHYZI+NtbwxLwbxra9O
         CLQiZqqKx64v38f8y8guxkzIQ34isiPf+leY0owxdKZby9NHS5BYerN3PW5oOTWMKfTm
         jaKl17pVBDvDMgHVvMVfMuVk0yJflkAACRJkII5RmV5GVbyxj3I9rc3rN5Ou9LleuxRz
         VNTw==
X-Gm-Message-State: APjAAAVxpKvA0USRgRDAvyiikWraPrXy4XpE8rzoPyDNQLa6FWJaC/qE
        RqGkDpDj3rrqIdXu1kZ4B3hvjyqvO4M=
X-Google-Smtp-Source: APXvYqwBH6hBJIYjycnHHvGJPN234J5g5Qq6WtQHOOJcPmNeQsHMljjBOlwtg21ARB+eKY8Nyt+2ug==
X-Received: by 2002:a63:551a:: with SMTP id j26mr24686778pgb.370.1576588642061;
        Tue, 17 Dec 2019 05:17:22 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.139.134? ([2402:f000:1:1501:200:5efe:a66f:8b86])
        by smtp.gmail.com with ESMTPSA id g25sm1213966pfo.110.2019.12.17.05.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 05:17:21 -0800 (PST)
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
 <e0305f5c-ae52-c144-fe50-00f3f815ad82@gmail.com>
 <CACT4Y+YLxmFTkDT88z9y5yH75bAi42-Hqatv9z2-EyufTtKHRw@mail.gmail.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <bc4569a3-19f8-ca5f-7e59-29bacdbc7955@gmail.com>
Date:   Tue, 17 Dec 2019 21:17:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YLxmFTkDT88z9y5yH75bAi42-Hqatv9z2-EyufTtKHRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/12/17 21:13, Dmitry Vyukov wrote:
> On Tue, Dec 17, 2019 at 2:11 PM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>> On 2019/12/17 21:02, Dmitry Vyukov wrote:
>>> On Tue, Dec 17, 2019 at 1:56 PM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>>>> The kernel may sleep while holding a spinlock.
>>>> The function call path (from bottom to top) in Linux 4.19 is:
>>>>
>>>> kernel/kcov.c, 237:
>>>>        vfree in kcov_put
>>>> kernel/kcov.c, 413:
>>>>        kcov_put in kcov_ioctl_locked
>>>> kernel/kcov.c, 427:
>>>>        kcov_ioctl_locked in kcov_ioctl
>>>> kernel/kcov.c, 426:
>>>>        spin_lock in kcov_ioctl
>>>>
>>>> vfree() can sleep at runtime.
>>>>
>>>> I am not sure how to properly fix this possible bug, so I only report it.
>>>> A possible way is to replace vfree() with kfree(), and replace related
>>>> calls to vmalloc() with kmalloc().
>>>>
>>>> This bug is found by a static analysis tool STCheck written by myself.
>>> Hi Jia-Ju,
>>>
>>> Are you sure kcov_ioctl_locked can really release the descriptor? It
>>> happens in the context of ioctl, which means there is an open
>>> reference for the file descriptor. So ioctl should not do vfree I
>>> would assume.
>> Thanks for the reply :)
>> I am not sure, because I am not familiar with kcov.
>> But looking at the code, if the reference count of kcov is 1, vfree()
>> could be called.
> That kcov_put should never call vfree. We still hold reference
> associated with the file, which will be released in kcov_close.

Okay, thanks for the explanation :)
My static analysis tool does not know this fact, so it reports the false 
bug, sorry...


Best wishes,
Jia-Ju Bai
