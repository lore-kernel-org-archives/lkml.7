Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0F9C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 03:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4888D20835
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 03:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfEGDmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 23:42:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38284 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726912AbfEGDmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 23:42:07 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 44A7083ABDF68C9C0024;
        Tue,  7 May 2019 11:42:05 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Tue, 7 May 2019 11:41:55 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <akpm@linux-foundation.org>, <ard.biesheuvel@linaro.org>,
        <rppt@linux.ibm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <ebiederm@xmission.com>
CC:     <horms@verge.net.au>, <takahiro.akashi@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <linux-mm@kvack.org>, <wangkefeng.wang@huawei.com>,
        Chen Zhou <chenzhou10@huawei.com>
Subject: [PATCH 0/4] support reserving crashkernel above 4G on arm64 kdump 
Date:   Tue, 7 May 2019 11:50:54 +0800
Message-ID: <20190507035058.63992-1-chenzhou10@huawei.com>
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

This patch series enable reserving crashkernel on high memory in arm64.

We use crashkernel=X to reserve crashkernel below 4G, which will fail
when there is no enough memory. Currently, crashkernel=Y@X can be used
to reserve crashkernel above 4G, in this case, if swiotlb or DMA buffers
are requierd, capture kernel will boot failure because of no low memory.

When crashkernel is reserved above 4G in memory, kernel should reserve
some amount of low memory for swiotlb and some DMA buffers. So there may
be two crash kernel regions, one is below 4G, the other is above 4G. Then
Crash dump kernel reads more than one crash kernel regions via a dtb
property under node /chosen,
linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>.

Besides, we need to modify kexec-tools:
  arm64: support more than one crash kernel regions(see [1])

I post this patch series about one month ago. The previous changes and
discussions can be retrived from:

Changes since [v4]
- reimplement memblock_cap_memory_ranges for multiple ranges by Mike.

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

[1]: http://lists.infradead.org/pipermail/kexec/2019-April/022792.html
[v1]: https://lkml.org/lkml/2019/4/2/1174
[v2]: https://lkml.org/lkml/2019/4/9/86
[v3]: https://lkml.org/lkml/2019/4/9/306
[v4]: https://lkml.org/lkml/2019/4/15/273

Chen Zhou (3):
  x86: kdump: move reserve_crashkernel_low() into kexec_core.c
  arm64: kdump: support reserving crashkernel above 4G
  kdump: update Documentation about crashkernel on arm64

Mike Rapoport (1):
  memblock: extend memblock_cap_memory_range to multiple ranges

 Documentation/admin-guide/kernel-parameters.txt |  6 +--
 arch/arm64/include/asm/kexec.h                  |  3 ++
 arch/arm64/kernel/setup.c                       |  3 ++
 arch/arm64/mm/init.c                            | 72 +++++++++++++++++++------
 arch/x86/include/asm/kexec.h                    |  3 ++
 arch/x86/kernel/setup.c                         | 66 +++--------------------
 include/linux/kexec.h                           |  5 ++
 include/linux/memblock.h                        |  2 +-
 kernel/kexec_core.c                             | 56 +++++++++++++++++++
 mm/memblock.c                                   | 44 +++++++--------
 10 files changed, 157 insertions(+), 103 deletions(-)

-- 
2.7.4

