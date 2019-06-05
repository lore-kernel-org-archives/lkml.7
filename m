Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FE8C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752BF206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfFEQcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:32:09 -0400
Received: from foss.arm.com ([217.140.101.70]:34638 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfFEQcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:32:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EA8A374;
        Wed,  5 Jun 2019 09:32:08 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9ED53F5AF;
        Wed,  5 Jun 2019 09:32:05 -0700 (PDT)
Subject: Re: [PATCH 0/4] support reserving crashkernel above 4G on arm64 kdump
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org,
        rppt@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, ebiederm@xmission.com, horms@verge.net.au,
        takahiro.akashi@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-mm@kvack.org, wangkefeng.wang@huawei.com
References: <20190507035058.63992-1-chenzhou10@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <51995efd-8469-7c15-0d5e-935b63fe2d9f@arm.com>
Date:   Wed, 5 Jun 2019 17:32:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190507035058.63992-1-chenzhou10@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 07/05/2019 04:50, Chen Zhou wrote:
> We use crashkernel=X to reserve crashkernel below 4G, which will fail
> when there is no enough memory. Currently, crashkernel=Y@X can be used
> to reserve crashkernel above 4G, in this case, if swiotlb or DMA buffers
> are requierd, capture kernel will boot failure because of no low memory.

> When crashkernel is reserved above 4G in memory, kernel should reserve
> some amount of low memory for swiotlb and some DMA buffers. So there may
> be two crash kernel regions, one is below 4G, the other is above 4G.

This is a good argument for supporting the 'crashkernel=...,low' version.
What is the 'crashkernel=...,high' version for?

Wouldn't it be simpler to relax the ARCH_LOW_ADDRESS_LIMIT if we see 'crashkernel=...,low'
in the kernel cmdline?

I don't see what the 'crashkernel=...,high' variant is giving us, it just complicates the
flow of reserve_crashkernel().

If we called reserve_crashkernel_low() at the beginning of reserve_crashkernel() we could
use crashk_low_res.end to change some limit variable from ARCH_LOW_ADDRESS_LIMIT to
memblock_end_of_DRAM().
I think this is a simpler change that gives you what you want.


> Then
> Crash dump kernel reads more than one crash kernel regions via a dtb
> property under node /chosen,
> linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>.

Won't this break if your kdump kernel doesn't know what the extra parameters are?
Or if it expects two ranges, but only gets one? These DT properties should be treated as
ABI between kernel versions, we can't really change it like this.

I think the 'low' region is an optional-extra, that is never mapped by the first kernel. I
think the simplest thing to do is to add an 'linux,low-memory-range' that we
memblock_add() after memblock_cap_memory_range() has been called.
If its missing, or the new kernel doesn't know what its for, everything keeps working.


> Besides, we need to modify kexec-tools:
>   arm64: support more than one crash kernel regions(see [1])

> I post this patch series about one month ago. The previous changes and
> discussions can be retrived from:

Ah, this wasn't obvious as you've stopped numbering the series. Please label the next one
'v6' so that we can describe this as 'v5'. (duplicate numbering would be even more confusing!)


Thanks,

James
