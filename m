Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42EDC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 01:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C422231A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 01:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfKSBNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 20:13:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6249 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726775AbfKSBNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 20:13:54 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F23E3FCA1D89BD2D1402;
        Tue, 19 Nov 2019 09:13:52 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 19 Nov 2019
 09:13:46 +0800
Subject: Re: [RFC PATCH v2] arm64: cpufeatures: add support for tlbi range
 instructions
To:     Marc Zyngier <maz@kernel.org>, Zhenyu Ye <yezhenyu2@huawei.com>
CC:     Will Deacon <will@kernel.org>, <catalin.marinas@arm.com>,
        <suzuki.poulose@arm.com>, <mark.rutland@arm.com>,
        <tangnianyao@huawei.com>, <xiexiangyou@huawei.com>,
        <linux-kernel@vger.kernel.org>, <arm@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
References: <5DC960EB.9050503@huawei.com>
 <20191111132716.GA9394@willie-the-truck> <5DC96660.8040505@huawei.com>
 <d4542758f83b3df3ab391341499fecfb@www.loen.fr>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <c9dfb341-9d14-1a62-0c34-6ec8bd9b4c55@huawei.com>
Date:   Tue, 19 Nov 2019 09:13:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <d4542758f83b3df3ab391341499fecfb@www.loen.fr>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc linux-arm-kernel mailing list and Shaokun.

Hi Marc,

On 2019/11/11 22:04, Marc Zyngier wrote:
> On 2019-11-11 14:56, Zhenyu Ye wrote:
>> On 2019/11/11 21:27, Will Deacon wrote:
>>> On Mon, Nov 11, 2019 at 09:23:55PM +0800, Zhenyu Ye wrote:
[...]
>>>
>>> How does this address my concerns here:
>>>
>>>
>>> https://lore.kernel.org/linux-arm-kernel/20191031131649.GB27196@willie-the-truck/
>>>
>>> ?
>>>
>>> Will
>>
>> I think your concern is more about the hardware level, and we can do
>> nothing about
>> this at all. The interconnect/DVM implementation is not exposed to
>> software layer
>> (and no need), and may should be constrained at hardware level.
> 
> You're missing the point here: the instruction may be implemented
> and perfectly working at the CPU level, and yet not carried over
> the interconnect. In this situation, other CPUs may not observe
> the DVM messages instructing them of such invalidation, and you'll end
> up with memory corruption.
> 
> So, in the absence of an architectural guarantee that range invalidation
> is supported and observed by all the DVM agents in the system, there must
> be a firmware description for it on which the kernel can rely.

I'm thinking of how to add a firmware description for it, how about this:

Adding a system level flag to indicate the supporting of TIBi by range,
which means adding a binding name for example "tlbi-by-range" at system
level in the dts file, or a tlbi by range flag in ACPI FADT table, then
we use the ID register per-cpu and the system level flag as

if (cpus_have_const_cap(ARM64_HAS_TLBI_BY_RANGE) && system_level_tlbi_by_range)
	flush_tlb_by_range()
else
	flush_tlb_range()

And this seems work for heterogeneous system (olny parts of the CPU support
TLBi by range) as well, correct me if anything wrong.

Thanks
Hanjun

