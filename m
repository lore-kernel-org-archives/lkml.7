Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3BFC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0CB20881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbfEWPDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 11:03:22 -0400
Received: from foss.arm.com ([217.140.101.70]:48332 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730672AbfEWPDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 11:03:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5FC580D;
        Thu, 23 May 2019 08:03:21 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 852053F690;
        Thu, 23 May 2019 08:03:20 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com, anshuman.khandual@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Devmap cleanups + arm64 support
Date:   Thu, 23 May 2019 16:03:12 +0100
Message-Id: <cover.1558547956.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's a refresh of my devmap stuff, now including the end goal as
well. Patches #1 to #3 are just a rebase of v2, and I hope are ready to
be picked up in the mm tree (#1 is currently doing double-duty in Dan's
subsection series as well). Patch #4 could either go via mm if Will and
Catalin agree, or could go via arm64 with a small tweak to let it build
(but otherwise do nothing) until it meets up with #3 again.

Robin.


Robin Murphy (4):
  mm/memremap: Rename and consolidate SECTION_SIZE
  mm: clean up is_device_*_page() definitions
  mm: introduce ARCH_HAS_PTE_DEVMAP
  arm64: mm: Implement pte_devmap support

 arch/arm64/Kconfig                           |  1 +
 arch/arm64/include/asm/pgtable-prot.h        |  1 +
 arch/arm64/include/asm/pgtable.h             | 19 ++++++++
 arch/powerpc/Kconfig                         |  2 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h |  1 -
 arch/x86/Kconfig                             |  2 +-
 arch/x86/include/asm/pgtable.h               |  4 +-
 arch/x86/include/asm/pgtable_types.h         |  1 -
 include/linux/mm.h                           | 47 +++++++-------------
 include/linux/mmzone.h                       |  1 +
 include/linux/pfn_t.h                        |  4 +-
 kernel/memremap.c                            | 10 ++---
 mm/Kconfig                                   |  5 +--
 mm/gup.c                                     |  2 +-
 mm/hmm.c                                     |  2 -
 15 files changed, 50 insertions(+), 52 deletions(-)

-- 
2.21.0.dirty

