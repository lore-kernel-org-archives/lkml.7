Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBFCC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 10:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B546206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 10:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgACK5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 05:57:46 -0500
Received: from foss.arm.com ([217.140.110.172]:54610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbgACK5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 05:57:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F9AC1FB;
        Fri,  3 Jan 2020 02:57:45 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A5E33F703;
        Fri,  3 Jan 2020 02:57:44 -0800 (PST)
Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations conflicts with
 lower layer
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>
References: <1577088979-8545-1-git-send-email-prime.zeng@hisilicon.com>
 <20191231164051.GA4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AE1D3@dggemm526-mbx.china.huawei.com>
 <20200102112955.GC4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AEB67@dggemm526-mbx.china.huawei.com>
 <c43342d0-7e4d-3be0-0fe1-8d802b0d7065@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340AFCA0@dggemm526-mbx.china.huawei.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <7b375d79-2d3c-422b-27a6-68972fbcbeaf@arm.com>
Date:   Fri, 3 Jan 2020 10:57:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED340AFCA0@dggemm526-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2020 04:24, Zengtao (B) wrote:
>>> From your example, the core 7 and core 8 has got different LLC but the
>> same Low
>>> Level cache?
>>
>> AFAIA what matters here is memory controllers, less so LLCs. Cores within
>> a single die could have private LLCs and separate memory controllers, or
>> shared LLC and separate memory controllers.
>>
>>> From schedule view of point, lower level sched domain should be a subset
>> of higher
>>> Level sched domain.
>>>
>>
>> Right, and that is checked when you have sched_debug on the cmdline
>> (or write 1 to /sys/kernel/debug/sched_debug & regenerate the sched
>> domains)
>>
> 
> No, here I think you don't get my issue, please try to understand my example
> First:.
> 
> *************************************
> NUMA:         0-2,  3-7
> core_siblings:    0-3,  4-7
> *************************************
> When we are building the sched domain, per the current code:
> (1) For core 3
>  MC sched domain fallbacks to 3~7
>  DIE sched domain is 3~7
> (2) For core 4:
>  MC sched domain is 4~7
>  DIE sched domain is 3~7
> 
> When we are build sched groups for the MC level:
> (1). core3's sched groups chain is built like as: 3->4->5->6->7->3 
> (2). core4's sched groups chain is built like as: 4->5->6->7->4 
> so after (2), 
> core3's sched groups is overlapped, and it's not a chain any more.
> In the afterwards usecase of core3's sched groups, deadloop happens.
> 
> And it's difficult for the scheduler to find out such errors,
> that is why I think a warning is necessary here.
> 

I was mostly commenting on Sudeep's example, sorry for the confusion.

The case you describe in the changelog (and again here in your reply)
is indeed slightly different, and quite more dramatic (we "corrupt" the
sched_group list).

I believe that could still be detected by the scheduler: the problem is
that we have non-equal yet non-disjoint non-NUMA sched domain spans; AFAIA
the only accepted configurations are either completely equal or completely
disjoint (otherwise we end up "corrupting" the sched group chain as above,
because we violate the assumptions used for building groups, see
topology.c::get_group()).

I'm juggling with other things atm, but let me have a think and see if we
couldn't detect that in the scheduler itself.

>> Now, I don't know how this plays out for the numa-in-package topologies
>> like
>> the one suggested by Sudeep. x86 and AMD had to play some games to
>> get
>> numa-in-package topologies working, see e.g.
>>
>>   cebf15eb09a2 ("x86, sched: Add new topology for multi-NUMA-node
>> CPUs")
>>
>> perhaps you need to "lie" here and ensure sub-NUMA sched domain levels
>> are
>> a subset of the NUMA levels, i.e. lie for core_siblings. I might go and
>> play with this to see how it behaves.
