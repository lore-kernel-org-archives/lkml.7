Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FA9ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8032206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2ve4K34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbfJIQjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:39:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42917 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731413AbfJIQjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:39:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id e5so1299848pls.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 09:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iTXErS40hwDITsEWC+0LMux5phAFBMz4ZCrgGz4WsI0=;
        b=k2ve4K3407ETx11T824r0FXXv0/2D1ydw8Xu3gJEFhJb87htUUnfjYZSlNKn7JGpmh
         KK3tGb/hbrmwRzC8+KB4UKyf0n50RzEg/afvqv32T80ygvuHd+PNfllOxK8x+0BaH9cX
         eceF+vxJes1sIIo7zVLJBIuQwScC/WYG/liMzQ6HZlJhtoImFSAxwI68FoYAH5i/+YTR
         NnLlWltz2k1ejbGSTXRlHHLHnyzM1c8PJqVwaCvKw+zW/t07oV5Vl0XRIAfvUMS38Z6t
         O7YnbSy8RnNd8R7u5zYzP8Gky/2xlNnyDIB4jKlC7ebe2dSATfL7mFjQowmczcXIwxPE
         nBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iTXErS40hwDITsEWC+0LMux5phAFBMz4ZCrgGz4WsI0=;
        b=Ar8zyySAZROHiycHRWqz37uvN6/nwVh8LiKbIpWs+QJj1dTPSHs+/QAH8juXKte9FA
         7bB4IvEAIbNjkyQ2tjSfg8eR3teIHd7MPaNdhTT53mHPvaMTV+lMts9bZZ53t1Y9s0Ma
         l2s2fPBts6pZTMonCAf56w2WwbUasKncjdK0g7ryhMC/HsRbt7gyP/z9n+OM3rblRKDI
         6fGXmUUfyLohH2cPuwKDRJzWBi9xaATB/ErcwhsVJS0dqKZolu+bv4qzBPnsL2B/oP3p
         C1XYfQBq74t+gjtTU/jzbJtKVl+l0LTxC5Jl7t1O8i+PZ2dvX3v2gAmV3Wak78CLRNw2
         hf/A==
X-Gm-Message-State: APjAAAVD/yj2UglTjE6EzK1JkebH0z8SoZBb0ZGCn3FNkN/zM3AYicMw
        sEZTA7+jmwZBf0aClrBb8SY=
X-Google-Smtp-Source: APXvYqytWElfiLLTTzrLW5HtWyckx/nZYQRdlUc96aizGGB9+1EpfQbEOpxoEmhd6/YSNOVC6k5Ujw==
X-Received: by 2002:a17:902:a717:: with SMTP id w23mr4184536plq.27.1570639184433;
        Wed, 09 Oct 2019 09:39:44 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id ce16sm2742759pjb.29.2019.10.09.09.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 09:39:43 -0700 (PDT)
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
To:     Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Paul Turner <pjt@google.com>, Daniel Axtens <dja@axtens.net>,
        Anatol Pomazau <anatol@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20190920155420.rxiflqdrpzinncpy@willie-the-truck>
 <0715d98b-12e9-fd81-31d1-67bcb752b0a1@gmail.com>
 <CACT4Y+bdPKQDGag1rZG6mCj2EKwEsgWdMuHZq_um2KuWOrog6Q@mail.gmail.com>
 <CACT4Y+Z+rX_cvDLwkzCvmudR6brCNM-8yA+hx9V6nXe159tf6A@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <a47cfff6-e5b7-bf05-fe42-73d9545f3ffb@gmail.com>
Date:   Wed, 9 Oct 2019 09:39:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Z+rX_cvDLwkzCvmudR6brCNM-8yA+hx9V6nXe159tf6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/19 12:45 AM, Dmitry Vyukov wrote:
> On Sat, Oct 5, 2019 at 6:16 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>> On Sat, Oct 5, 2019 at 2:58 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>>> This one is tricky. What I think we need to avoid is an onslaught of
>>>> patches adding READ_ONCE/WRITE_ONCE without a concrete analysis of the
>>>> code being modified. My worry is that Joe Developer is eager to get their
>>>> first patch into the kernel, so runs this tool and starts spamming
>>>> maintainers with these things to the point that they start ignoring KCSAN
>>>> reports altogether because of the time they take up.
>>>>
>>>> I suppose one thing we could do is to require each new READ_ONCE/WRITE_ONCE
>>>> to have a comment describing the racy access, a bit like we do for memory
>>>> barriers. Another possibility would be to use atomic_t more widely if
>>>> there is genuine concurrency involved.
>>>>
>>>
>>> About READ_ONCE() and WRITE_ONCE(), we will probably need
>>>
>>> ADD_ONCE(var, value)  for arches that can implement the RMW in a single instruction.
>>>
>>> WRITE_ONCE(var, var + value) does not look pretty, and increases register pressure.
>>
>> FWIW modern compilers can handle this if we tell them what we are trying to do:
>>
>> void foo(int *p, int x)
>> {
>>     x += __atomic_load_n(p, __ATOMIC_RELAXED);
>>     __atomic_store_n(p, x, __ATOMIC_RELAXED);
>> }
>>
>> $ clang test.c -c -O2 && objdump -d test.o
>>
>> 0000000000000000 <foo>:
>>    0: 01 37                add    %esi,(%rdi)
>>    2: c3                    retq
>>
>> We can have syntactic sugar on top of this of course.
> 
> An interesting precedent come up in another KCSAN bug report. Namely,
> it may be reasonable for a compiler to use different optimization
> heuristics for concurrent and non-concurrent code. Consider there are
> some legal code transformations, but it's unclear if they are
> profitable or not. It may be the case that for non-concurrent code the
> expectation is that it's a profitable transformation, but for
> concurrent code it is not. So that may be another reason to
> communicate to compiler what we want to do, rather than trying to
> trick and play against each other. I've added the concrete example
> here:
> https://github.com/google/ktsan/wiki/READ_ONCE-and-WRITE_ONCE#it-may-improve-performance
> 

Note that for bit fields, READ_ONCE() wont work.

Concrete example in net/xfrm/xfrm_algo.c:xfrm_probe_algs(void)
...
if (aalg_list[i].available != status)
        aalg_list[i].available = status;
...
if (ealg_list[i].available != status)
        ealg_list[i].available = status;
...
if (calg_list[i].available != status)
        calg_list[i].available = status;

