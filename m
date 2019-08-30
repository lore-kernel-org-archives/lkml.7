Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBE0C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415FE22CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfH3HI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:08:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5254 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726452AbfH3HI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:08:57 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DD2446750602CC9594D0;
        Fri, 30 Aug 2019 15:08:55 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Fri, 30 Aug 2019 15:08:47 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <james.morse@arm.com>, <dyoung@redhat.com>, <bhsharma@redhat.com>
CC:     <horms@verge.net.au>, <guohanjun@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        Chen Zhou <chenzhou10@huawei.com>
Subject: [PATCH v6 0/4] support reserving crashkernel above 4G on arm64 kdump
Date:   Fri, 30 Aug 2019 15:11:56 +0800
Message-ID: <20190830071200.56169-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am busy with other things, so it was a long time before this version was
released.

This patch series enable reserving crashkernel above 4G in arm64.

There are following issues in arm64 kdump:
1. We use crashkernel=X to reserve crashkernel below 4G, which will fail
when there is no enough low memory.
2. Currently, crashkernel=Y@X can be used to reserve crashkernel above 4G,
in this case, if swiotlb or DMA buffers are requierd, crash dump kernel
will boot failure because there is no low memory available for allocation.

To solve these issues, introduce crashkernel=X,low to reserve specified
size low memory.
Crashkernel=X tries to reserve memory for the crash dump kernel under
4G. If crashkernel=Y,low is specified simultaneously, reserve spcified
size low memory for crash kdump kernel devices firstly and then reserve
memory above 4G.

When crashkernel is reserved above 4G in memory, that is, crashkernel=X,low
is specified simultaneously, kernel should reserve specified size low memory
for crash dump kernel devices. So there may be two crash kernel regions, one
is below 4G, the other is above 4G.
In order to distinct from the high region and make no effect to the use of
kexec-tools, rename the low region as "Crash kernel (low)", and add DT property
"linux,low-memory-range" to crash dump kernel's dtb to pass the low region.

Besides, we need to modify kexec-tools:
arm64: kdump: add another DT property to crash dump kernel's dtb(see [1])

The previous changes and discussions can be retrieved from:

Changes since [v5]
- Move reserve_crashkernel_low() into kernel/crash_core.c.
- Delete crashkernel=X,high.
- Modify crashkernel=X,low.
If crashkernel=X,low is specified simultaneously, reserve spcified size low
memory for crash kdump kernel devices firstly and then reserve memory above 4G.
In addition, rename crashk_low_res as "Crash kernel (low)" for arm64, and then
pass to crash dump kernel by DT property "linux,low-memory-range".
- Update Documentation/admin-guide/kdump/kdump.rst.

Changes since [v4]
- Reimplement memblock_cap_memory_ranges for multiple ranges by Mike.

Changes since [v3]
- Add memblock_cap_memory_ranges back for multiple ranges.
- Fix some compiling warnings.

Changes since [v2]
- Split patch "arm64: kdump: support reserving crashkernel above 4G" as
two. Put "move reserve_crashkernel_low() into kexec_core.c" in a separate
patch.

Changes since [v1]:
- Move common reserve_crashkernel_low() code into kernel/kexec_core.c.
- Remove memblock_cap_memory_ranges() i added in v1 and implement that
in fdt_enforce_memory_region().
There are at most two crash kernel regions, for two crash kernel regions
case, we cap the memory range [min(regs[*].start), max(regs[*].end)]
and then remove the memory range in the middle.

[1]: http://lists.infradead.org/pipermail/kexec/2019-August/023569.html
[v1]: https://lkml.org/lkml/2019/4/2/1174
[v2]: https://lkml.org/lkml/2019/4/9/86
[v3]: https://lkml.org/lkml/2019/4/9/306
[v4]: https://lkml.org/lkml/2019/4/15/273
[v5]: https://lkml.org/lkml/2019/5/6/1360

Chen Zhou (4):
  x86: kdump: move reserve_crashkernel_low() into crash_core.c
  arm64: kdump: reserve crashkenel above 4G for crash dump kernel
  arm64: kdump: add memory for devices by DT property, low-memory-range
  kdump: update Documentation about crashkernel on arm64

 Documentation/admin-guide/kdump/kdump.rst       | 13 ++++-
 Documentation/admin-guide/kernel-parameters.txt | 12 ++++-
 arch/arm64/include/asm/kexec.h                  |  3 ++
 arch/arm64/kernel/setup.c                       |  8 ++-
 arch/arm64/mm/init.c                            | 61 +++++++++++++++++++++--
 arch/x86/include/asm/kexec.h                    |  3 ++
 arch/x86/kernel/setup.c                         | 65 +++----------------------
 include/linux/crash_core.h                      |  4 ++
 include/linux/kexec.h                           |  1 -
 kernel/crash_core.c                             | 65 +++++++++++++++++++++++++
 10 files changed, 168 insertions(+), 67 deletions(-)

-- 
2.7.4

