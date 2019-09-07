Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF9EC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 01:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7ED2173B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 01:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406457AbfIGB5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 21:57:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33290 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405470AbfIGB5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 21:57:12 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 806E16D8F654EF5E9BEE;
        Sat,  7 Sep 2019 09:57:10 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Sat, 7 Sep 2019
 09:57:08 +0800
Subject: Re: [PATCH v2 0/6] Rework REFCOUNT_FULL using atomic_fetch_*
 operations
To:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jan Glauber <jglauber@marvell.com>
References: <20190827163204.29903-1-will@kernel.org>
 <20190828073052.GL2332@hirez.programming.kicks-ass.net>
 <20190828141439.sqnpm5ff4tgyn66r@willie-the-truck>
 <201908281353.0EFD0776@keescook>
 <20190906134302.ie7wbdojkzsmrle7@willie-the-truck>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <82fb5620-1c10-3080-6f60-e4d826fa2aad@huawei.com>
Date:   Sat, 7 Sep 2019 09:57:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20190906134302.ie7wbdojkzsmrle7@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/6 21:43, Will Deacon wrote:
> On Wed, Aug 28, 2019 at 02:03:37PM -0700, Kees Cook wrote:
>> On Wed, Aug 28, 2019 at 03:14:40PM +0100, Will Deacon wrote:
>>> On Wed, Aug 28, 2019 at 09:30:52AM +0200, Peter Zijlstra wrote:
>>>> On Tue, Aug 27, 2019 at 05:31:58PM +0100, Will Deacon wrote:
>>>>> Will Deacon (6):
>>>>>   lib/refcount: Define constants for saturation and max refcount values
>>>>>   lib/refcount: Ensure integer operands are treated as signed
>>>>>   lib/refcount: Remove unused refcount_*_checked() variants
>>>>>   lib/refcount: Move bulk of REFCOUNT_FULL implementation into header
>>>>>   lib/refcount: Improve performance of generic REFCOUNT_FULL code
>>>>>   lib/refcount: Consolidate REFCOUNT_{MAX,SATURATED} definitions
>> BTW, can you repeat the timing details into the "Improve performance of
>> generic REFCOUNT_FULL code" patch?
> Of course.
> 
>>>> So I'm not a fan; I itch at the whole racy nature of this thing and I
>>>> find the code less than obvious. Yet, I have to agree it is exceedingly
>>>> unlikely the race will ever actually happen, I just don't want to be the
>>>> one having to debug it.
>>> FWIW, I think much the same about the version under arch/x86 ;)
>>>
>>>> I've not looked at the implementation much; does it do all the same
>>>> checks the FULL one does? The x86-asm one misses a few iirc, so if this
>>>> is similarly fast but has all the checks, it is in fact better.
>>> Yes, it passes all of the REFCOUNT_* tests in lkdtm [1] so I agree that
>>> it's an improvement over the asm version.
>>>
>>>> Can't we make this a default !FULL implementation?
>>> My concern with doing that is I think it would make the FULL implementation
>>> entirely pointless. I can't see anybody using it, and it would only exist
>>> as an academic exercise in handling the theoretical races. That's a change
>>> from the current situation where it genuinely handles cases which the
>>> x86-specific code does not and, judging by the Kconfig text, that's the
>>> only reason for its existence.
>> Looking at timing details, the new implementation is close enough to the
>> x86 asm version that I would be fine to drop the x86-specific case
>> entirely as long as we could drop "FULL" entirely too -- we'd have _one_
>> refcount_t implementation: it would be both complete and fast.
> That works for me; I'll spin a new version of this series so you can see
> what it looks like.

I will wait for the new version then do the performance test on ARM64 server.

Thanks
Hanjun

