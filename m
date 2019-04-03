Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15DCC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75CDC206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfDCEaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:30:13 -0400
Received: from foss.arm.com ([217.140.101.70]:60198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfDCEaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:30:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E40380D;
        Tue,  2 Apr 2019 21:30:12 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BE65E3F721;
        Tue,  2 Apr 2019 21:30:06 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com
Cc:     mhocko@suse.com, mgorman@techsingularity.net, james.morse@arm.com,
        mark.rutland@arm.com, robin.murphy@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        logang@deltatee.com, pasha.tatashin@oracle.com, david@redhat.com,
        cai@lca.pw
Subject: [PATCH 0/6] arm64/mm: Enable memory hot remove and ZONE_DEVICE
Date:   Wed,  3 Apr 2019 10:00:00 +0530
Message-Id: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables memory hot remove on arm64, fixes a memblock removal
ordering problem in generic __remove_memory(), enables sysfs memory probe
interface on arm64. It also enables ZONE_DEVICE with struct vmem_altmap
support.

Testing:

Tested hot remove on arm64 for all 4K, 16K, 64K page config options with
all possible VA_BITS and PGTABLE_LEVELS combinations. Tested ZONE_DEVICE
with ARM64_4K_PAGES through a dummy driver.

Build tested on non arm64 platforms. I will appreciate if folks can test
arch_remove_memory() re-ordering in __remove_memory() on other platforms.

Dependency:

V5 series in the thread (https://lkml.org/lkml/2019/2/14/1096) will make
kernel linear mapping loose pgtable_page_ctor() init. When this happens
the proposed functions free_pte|pmd|pud_table() in [PATCH 2/6] will have
to stop calling pgtable_page_dtor().

Anshuman Khandual (5):
  arm64/mm: Enable sysfs based memory hot add interface
  arm64/mm: Enable memory hot remove
  arm64/mm: Enable struct page allocation from device memory
  mm/hotplug: Reorder arch_remove_memory() call in __remove_memory()
  arm64/mm: Enable ZONE_DEVICE

Robin Murphy (1):
  mm/memremap: Rename and consolidate SECTION_SIZE

 arch/arm64/Kconfig               |  13 +++
 arch/arm64/include/asm/pgtable.h |  14 +++
 arch/arm64/mm/mmu.c              | 242 ++++++++++++++++++++++++++++++++++++++-
 include/linux/mmzone.h           |   1 +
 kernel/memremap.c                |  10 +-
 mm/hmm.c                         |   2 -
 mm/memory_hotplug.c              |   3 +-
 7 files changed, 271 insertions(+), 14 deletions(-)

-- 
2.7.4

