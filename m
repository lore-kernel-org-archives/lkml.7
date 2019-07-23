Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08210C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB222238E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732452AbfGWFxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 01:53:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2699 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732295AbfGWFxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 01:53:52 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D4A5E6E6D5A9386D9C48;
        Tue, 23 Jul 2019 13:53:49 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Tue, 23 Jul 2019 13:53:42 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Jia He" <hejianet@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v12 0/2] introduce memblock_next_valid_pfn() (again) for arm64
Date:   Tue, 23 Jul 2019 13:51:11 +0800
Message-ID: <1563861073-47071-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is new version of "[PATCH v11 0/3] remain and optimize
memblock_next_valid_pfn on arm and arm64" from Jia He, which is suggested
by Ard to respin this patch set [1].

In the new version, I squashed patch 1/3 and patch 2/3 in v11 into
one patch, fixed a bug for possible out of bound accessing the
regions, and just introduce memblock_next_valid_pfn() for arm64 only
as I don't have a arm32 platform to test.

Ard asked to "with the new data points added for documentation, and
crystal clear about how the meaning of PFN validity differs between
ARM and other architectures, and why the assumptions that the
optimization is based on are guaranteed to hold", to be honest, I
didn't see PFN validity differs between ARM and x86 architecture,
but there is a bug in commit b92df1de5d28 ("mm: page_alloc: skip over
regions of invalid pfns where possible") which has a possible out of
bound accessing the regions as well, so not sure that is the root cause.

Testing on a HiSilicon ARM64 server (a 4 sockets system), I can get
pretty much speedup for bootmem_init() at boot:
    
with 384G memory,
before: 13310ms
after:  1415ms
   
with 1T memory,
before: 20s
after:  2s

[1]: https://lkml.org/lkml/2019/6/10/412

Jia He (2):
  mm: page_alloc: introduce memblock_next_valid_pfn() (again) for arm64
  mm: page_alloc: reduce unnecessary binary search in
    memblock_next_valid_pfn

 arch/arm64/Kconfig     |  1 +
 include/linux/mmzone.h |  9 +++++++
 mm/Kconfig             |  3 +++
 mm/memblock.c          | 56 ++++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c        |  4 ++-
 5 files changed, 72 insertions(+), 1 deletion(-)

-- 
2.19.1

