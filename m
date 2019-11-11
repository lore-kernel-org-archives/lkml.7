Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740B3C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4595021783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573481070;
	bh=AqjH6lBvlgVE8nab9htSIq2F7jnMyPZAyZaqcbdHGCo=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=C7iHw95Qu1OESXWxtW4Lu83k+oiaIh5ct7qfpHzMsEPkF1BS8bSORbq7YiOsbuwQt
	 pKV69P61FlnFZ28PNNSByOwceyZKe21njU6ttV2QIq7Y7WQvGG0LMOoM5xG/zzS0f1
	 NJitZ5IUaVCUs07ARUcyYSYYHDu1924Ib+Uxw+fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfKKOE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:04:29 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:53233 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726834AbfKKOE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:04:28 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iUAIr-0002cs-UW; Mon, 11 Nov 2019 15:04:25 +0100
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [RFC PATCH v2] arm64: cpufeatures: add support for tlbi range  instructions
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 Nov 2019 15:13:46 +0109
From:   Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>, <catalin.marinas@arm.com>,
        <suzuki.poulose@arm.com>, <mark.rutland@arm.com>,
        <tangnianyao@huawei.com>, <xiexiangyou@huawei.com>,
        <linux-kernel@vger.kernel.org>, <arm@kernel.org>
In-Reply-To: <5DC96660.8040505@huawei.com>
References: <5DC960EB.9050503@huawei.com>
 <20191111132716.GA9394@willie-the-truck> <5DC96660.8040505@huawei.com>
Message-ID: <d4542758f83b3df3ab391341499fecfb@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: yezhenyu2@huawei.com, will@kernel.org, catalin.marinas@arm.com, suzuki.poulose@arm.com, mark.rutland@arm.com, tangnianyao@huawei.com, xiexiangyou@huawei.com, linux-kernel@vger.kernel.org, arm@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-11 14:56, Zhenyu Ye wrote:
> On 2019/11/11 21:27, Will Deacon wrote:
>> On Mon, Nov 11, 2019 at 09:23:55PM +0800, Zhenyu Ye wrote:
>>> ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
>>> range of input addresses. This patch adds support for this feature.
>>> This is the second version of the patch.
>>>
>>> I traced the __flush_tlb_range() for a minute and get some 
>>> statistical
>>> data as below:
>>>
>>> 	PAGENUM		COUNT
>>> 	1		34944
>>> 	2		5683
>>> 	3		1343
>>> 	4		7857
>>> 	5		838
>>> 	9		339
>>> 	16		933
>>> 	19		427
>>> 	20		5821
>>> 	23		279
>>> 	41		338
>>> 	141		279
>>> 	512		428
>>> 	1668		120
>>> 	2038		100
>>>
>>> Those data are based on kernel-5.4.0, where PAGENUM = end - start, 
>>> COUNT
>>> shows number of calls to the __flush_tlb_range() in a minute. There 
>>> only
>>> shows the data which COUNT >= 100. The kernel is started normally, 
>>> and
>>> transparent hugepage is opened. As we can see, though most user 
>>> TLBI
>>> ranges were 1 pages long, the num of long-range can not be ignored.
>>>
>>> The new feature of TLB range can improve lots of performance 
>>> compared to
>>> the current implementation. As an example, flush 512 ranges needs 
>>> only 1
>>> instruction as opposed to 512 instructions using current 
>>> implementation.
>>>
>>> And for a new hardware feature, support is better than not.
>>>
>>> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
>>> ---
>>> ChangeLog v1 -> v2:
>>> - Change the main implementation of this feature.
>>> - Add some comments.
>>
>> How does this address my concerns here:
>>
>> 
>> https://lore.kernel.org/linux-arm-kernel/20191031131649.GB27196@willie-the-truck/
>>
>> ?
>>
>> Will
>>
>> .
>>
>
> I think your concern is more about the hardware level, and we can do
> nothing about
> this at all. The interconnect/DVM implementation is not exposed to
> software layer
> (and no need), and may should be constrained at hardware level.

You're missing the point here: the instruction may be implemented
and perfectly working at the CPU level, and yet not carried over
the interconnect. In this situation, other CPUs may not observe
the DVM messages instructing them of such invalidation, and you'll end
up with memory corruption.

So, in the absence of an architectural guarantee that range 
invalidation
is supported and observed by all the DVM agents in the system, there 
must
be a firmware description for it on which the kernel can rely.

         M.
-- 
Jazz is not dead. It just smells funny...
