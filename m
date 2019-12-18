Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51CEC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 02:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AA421582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 02:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfLRCIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 21:08:16 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:46950 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726296AbfLRCIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 21:08:16 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1F37C6A3B9D3AA7B4D68;
        Wed, 18 Dec 2019 10:08:11 +0800 (CST)
Received: from [127.0.0.1] (10.177.131.64) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 18 Dec 2019
 10:08:05 +0800
Subject: Re: [PATCH v6 0/4] support reserving crashkernel above 4G on arm64
 kdump
To:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <james.morse@arm.com>, <dyoung@redhat.com>, <bhsharma@redhat.com>
References: <20190830071200.56169-1-chenzhou10@huawei.com>
CC:     <horms@verge.net.au>, <guohanjun@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>
From:   Chen Zhou <chenzhou10@huawei.com>
Message-ID: <2a97b296-59e7-0a26-84fa-e2ddcd7987b6@huawei.com>
Date:   Wed, 18 Dec 2019 10:07:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20190830071200.56169-1-chenzhou10@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.131.64]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Friendly ping...

On 2019/8/30 15:11, Chen Zhou wrote:
> I am busy with other things, so it was a long time before this version was
> released.
> 
> This patch series enable reserving crashkernel above 4G in arm64.
> 
> There are following issues in arm64 kdump:
> 1. We use crashkernel=X to reserve crashkernel below 4G, which will fail
> when there is no enough low memory.
> 2. Currently, crashkernel=Y@X can be used to reserve crashkernel above 4G,
> in this case, if swiotlb or DMA buffers are requierd, crash dump kernel
> will boot failure because there is no low memory available for allocation.
> 
> To solve these issues, introduce crashkernel=X,low to reserve specified
> size low memory.
> Crashkernel=X tries to reserve memory for the crash dump kernel under
> 4G. If crashkernel=Y,low is specified simultaneously, reserve spcified
> size low memory for crash kdump kernel devices firstly and then reserve
> memory above 4G.
> 
> When crashkernel is reserved above 4G in memory, that is, crashkernel=X,low
> is specified simultaneously, kernel should reserve specified size low memory
> for crash dump kernel devices. So there may be two crash kernel regions, one
> is below 4G, the other is above 4G.
> In order to distinct from the high region and make no effect to the use of
> kexec-tools, rename the low region as "Crash kernel (low)", and add DT property
> "linux,low-memory-range" to crash dump kernel's dtb to pass the low region.
> 
> Besides, we need to modify kexec-tools:
> arm64: kdump: add another DT property to crash dump kernel's dtb(see [1])
> 
> The previous changes and discussions can be retrieved from:
> 
> Changes since [v5]
> - Move reserve_crashkernel_low() into kernel/crash_core.c.
> - Delete crashkernel=X,high.
> - Modify crashkernel=X,low.
> If crashkernel=X,low is specified simultaneously, reserve spcified size low
> memory for crash kdump kernel devices firstly and then reserve memory above 4G.
> In addition, rename crashk_low_res as "Crash kernel (low)" for arm64, and then
> pass to crash dump kernel by DT property "linux,low-memory-range".
> - Update Documentation/admin-guide/kdump/kdump.rst.
> 
> Changes since [v4]
> - Reimplement memblock_cap_memory_ranges for multiple ranges by Mike.
> 
> Changes since [v3]
> - Add memblock_cap_memory_ranges back for multiple ranges.
> - Fix some compiling warnings.
> 
> Changes since [v2]
> - Split patch "arm64: kdump: support reserving crashkernel above 4G" as
> two. Put "move reserve_crashkernel_low() into kexec_core.c" in a separate
> patch.
> 
> Changes since [v1]:
> - Move common reserve_crashkernel_low() code into kernel/kexec_core.c.
> - Remove memblock_cap_memory_ranges() i added in v1 and implement that
> in fdt_enforce_memory_region().
> There are at most two crash kernel regions, for two crash kernel regions
> case, we cap the memory range [min(regs[*].start), max(regs[*].end)]
> and then remove the memory range in the middle.
> 
> [1]: http://lists.infradead.org/pipermail/kexec/2019-August/023569.html
> [v1]: https://lkml.org/lkml/2019/4/2/1174
> [v2]: https://lkml.org/lkml/2019/4/9/86
> [v3]: https://lkml.org/lkml/2019/4/9/306
> [v4]: https://lkml.org/lkml/2019/4/15/273
> [v5]: https://lkml.org/lkml/2019/5/6/1360
> 
> Chen Zhou (4):
>   x86: kdump: move reserve_crashkernel_low() into crash_core.c
>   arm64: kdump: reserve crashkenel above 4G for crash dump kernel
>   arm64: kdump: add memory for devices by DT property, low-memory-range
>   kdump: update Documentation about crashkernel on arm64
> 
>  Documentation/admin-guide/kdump/kdump.rst       | 13 ++++-
>  Documentation/admin-guide/kernel-parameters.txt | 12 ++++-
>  arch/arm64/include/asm/kexec.h                  |  3 ++
>  arch/arm64/kernel/setup.c                       |  8 ++-
>  arch/arm64/mm/init.c                            | 61 +++++++++++++++++++++--
>  arch/x86/include/asm/kexec.h                    |  3 ++
>  arch/x86/kernel/setup.c                         | 65 +++----------------------
>  include/linux/crash_core.h                      |  4 ++
>  include/linux/kexec.h                           |  1 -
>  kernel/crash_core.c                             | 65 +++++++++++++++++++++++++
>  10 files changed, 168 insertions(+), 67 deletions(-)
> 

