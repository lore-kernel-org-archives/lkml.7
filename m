Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DFDC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C489E20857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574157817;
	bh=6Y0UX76dYgG94wwiaXQ7Jansl5pk7ejlZtl3UjXrPV0=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=0eH2DdEGbfi8qzaTvyNYT/mBuEwXCj3fFUcZ7fXiEAIbKM1b8TvzXOvqKMu8CRjl5
	 bn5CaZ+CMzCkS55/es0jWjDOaOz7UMjPwvE1UjZCDbsIrdTC8AR0WUjpeZy/oNDEp4
	 G+0frPnefpl9nUmaYaYvwTeuerpnX41Eg8ut3bI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKSKDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 05:03:36 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:37915 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725280AbfKSKDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 05:03:36 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iX0MA-0001a9-8z; Tue, 19 Nov 2019 11:03:34 +0100
To:     Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [RFC PATCH v2] arm64: cpufeatures: add support for tlbi range  instructions
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 Nov 2019 10:03:34 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     Zhenyu Ye <yezhenyu2@huawei.com>, Will Deacon <will@kernel.org>,
        <catalin.marinas@arm.com>, <suzuki.poulose@arm.com>,
        <mark.rutland@arm.com>, <tangnianyao@huawei.com>,
        <xiexiangyou@huawei.com>, <linux-kernel@vger.kernel.org>,
        <arm@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
In-Reply-To: <c9dfb341-9d14-1a62-0c34-6ec8bd9b4c55@huawei.com>
References: <5DC960EB.9050503@huawei.com>
 <20191111132716.GA9394@willie-the-truck> <5DC96660.8040505@huawei.com>
 <d4542758f83b3df3ab391341499fecfb@www.loen.fr>
 <c9dfb341-9d14-1a62-0c34-6ec8bd9b4c55@huawei.com>
Message-ID: <e6d2ad1c5392c2c3503ed8bb7560e04f@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: guohanjun@huawei.com, yezhenyu2@huawei.com, will@kernel.org, catalin.marinas@arm.com, suzuki.poulose@arm.com, mark.rutland@arm.com, tangnianyao@huawei.com, xiexiangyou@huawei.com, linux-kernel@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, zhangshaokun@hisilicon.com, wanghuiqiang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hanjun,

On 2019-11-19 01:13, Hanjun Guo wrote:
> +Cc linux-arm-kernel mailing list and Shaokun.
>
> Hi Marc,
>
> On 2019/11/11 22:04, Marc Zyngier wrote:
>> On 2019-11-11 14:56, Zhenyu Ye wrote:
>>> On 2019/11/11 21:27, Will Deacon wrote:
>>>> On Mon, Nov 11, 2019 at 09:23:55PM +0800, Zhenyu Ye wrote:
> [...]
>>>>
>>>> How does this address my concerns here:
>>>>
>>>>
>>>> 
>>>> https://lore.kernel.org/linux-arm-kernel/20191031131649.GB27196@willie-the-truck/
>>>>
>>>> ?
>>>>
>>>> Will
>>>
>>> I think your concern is more about the hardware level, and we can 
>>> do
>>> nothing about
>>> this at all. The interconnect/DVM implementation is not exposed to
>>> software layer
>>> (and no need), and may should be constrained at hardware level.
>>
>> You're missing the point here: the instruction may be implemented
>> and perfectly working at the CPU level, and yet not carried over
>> the interconnect. In this situation, other CPUs may not observe
>> the DVM messages instructing them of such invalidation, and you'll 
>> end
>> up with memory corruption.
>>
>> So, in the absence of an architectural guarantee that range 
>> invalidation
>> is supported and observed by all the DVM agents in the system, there 
>> must
>> be a firmware description for it on which the kernel can rely.
>
> I'm thinking of how to add a firmware description for it, how about 
> this:
>
> Adding a system level flag to indicate the supporting of TIBi by 
> range,
> which means adding a binding name for example "tlbi-by-range" at 
> system
> level in the dts file, or a tlbi by range flag in ACPI FADT table, 
> then
> we use the ID register per-cpu and the system level flag as
>
> if (cpus_have_const_cap(ARM64_HAS_TLBI_BY_RANGE) &&
> system_level_tlbi_by_range)
> 	flush_tlb_by_range()
> else
> 	flush_tlb_range()
>
> And this seems work for heterogeneous system (olny parts of the CPU 
> support
> TLBi by range) as well, correct me if anything wrong.

It could work, but it needs to come with the strongest guarantees that
all the DVM agents in the system understand this type of invalidation,
specially as we move into the SVM territory. It may also need to cope
with non-compliant agents being hot-plugged, or at least discovered 
late.

I also wonder if the ARMv8.4-TTL extension (which I have patches for in
the nested virt series) requires the same kind of treatment (after all,
it has an implicit range based on the base granule size and level).

In any way, this requires careful specification, and I don't think
we can improvise this on the ML... ;-)

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
