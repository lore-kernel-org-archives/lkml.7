Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DE9C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 05:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A12920693
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 05:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbfDNF73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 01:59:29 -0400
Received: from foss.arm.com ([217.140.101.70]:49562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfDNF72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 01:59:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D872280D;
        Sat, 13 Apr 2019 22:59:27 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.41.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7EC783F557;
        Sat, 13 Apr 2019 22:59:22 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com
Cc:     mhocko@suse.com, mgorman@techsingularity.net, james.morse@arm.com,
        mark.rutland@arm.com, robin.murphy@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        ira.weiny@intel.com
Subject: [PATCH V2 0/2] arm64/mm: Enable memory hot remove
Date:   Sun, 14 Apr 2019 11:29:11 +0530
Message-Id: <1555221553-18845-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables memory hot remove on arm64 after fixing a memblock
removal ordering problem in generic __remove_memory(). This is based
on the following arm64 working tree.

git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core

Testing:

Tested hot remove on arm64 for all 4K, 16K, 64K page config options with
all possible VA_BITS and PGTABLE_LEVELS combinations. Build tested on non
arm64 platforms.

Changes in V2:

- Added all received review and ack tags
- Split the series from ZONE_DEVICE enablement for better review

- Moved memblock re-order patch to the front as per Robin Murphy
- Updated commit message on memblock re-order patch per Michal Hocko

- Dropped [pmd|pud]_large() definitions
- Used existing [pmd|pud]_sect() instead of earlier [pmd|pud]_large()
- Removed __meminit and __ref tags as per Oscar Salvador
- Dropped unnecessary 'ret' init in arch_add_memory() per Robin Murphy
- Skipped calling into pgtable_page_dtor() for linear mapping page table
  pages and updated all relevant functions

Changes in V1: (https://lkml.org/lkml/2019/4/3/28)

Anshuman Khandual (2):
  mm/hotplug: Reorder arch_remove_memory() call in __remove_memory()
  arm64/mm: Enable memory hot remove

 arch/arm64/Kconfig               |   3 +
 arch/arm64/include/asm/pgtable.h |   2 +
 arch/arm64/mm/mmu.c              | 221 ++++++++++++++++++++++++++++++++++++++-
 mm/memory_hotplug.c              |   3 +-
 4 files changed, 225 insertions(+), 4 deletions(-)

-- 
2.7.4

