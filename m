Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CBFC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466B720679
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfJKOJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:09:52 -0400
Received: from foss.arm.com ([217.140.110.172]:33416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbfJKOJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:09:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F814142F;
        Fri, 11 Oct 2019 07:09:51 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.40.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7A8693F68E;
        Fri, 11 Oct 2019 07:09:46 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>, nd@arm.com,
        Jia He <justin.he@arm.com>
Subject: [PATCH v12 0/4] fix double page fault in cow_user_page for pfn mapping
Date:   Fri, 11 Oct 2019 22:09:35 +0800
Message-Id: <20191011140939.6115-1-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we tested pmdk unit test vmmalloc_fork TEST1 in arm64 guest, there
will be a double page fault in __copy_from_user_inatomic of cow_user_page.

As told by Catalin: "On arm64 without hardware Access Flag, copying from
user will fail because the pte is old and cannot be marked young. So we
always end up with zeroed page after fork() + CoW for pfn mappings. we
don't always have a hardware-managed access flag on arm64."

-Changes
v12:
    refine PATCH 01, remove the !! since C languages can convert unsigned
    to bool (Catalin)
v11:
    refine cpu_has_hw_af in PATCH 01(Will Deacon, Suzuki)
    change the default return value to true in arch_faults_on_old_pte
    add PATCH 03 for overriding arch_faults_on_old_pte(false) on x86
v10:
    add r-b from Catalin and a-b from Kirill in PATCH 03
    remoe Reported-by in PATCH 01
v9: refactor cow_user_page for indention optimization (Catalin)
    hold the ptl longer (Catalin)
v8: change cow_user_page's return type (Matthew)
v7: s/pte_spinlock/pte_offset_map_lock (Kirill)
v6: fix error case of returning with spinlock taken (Catalin)
    move kmap_atomic to avoid handling kunmap_atomic
v5: handle the case correctly when !pte_same
    fix kbuild test failed
v4: introduce cpu_has_hw_af (Suzuki)
    bail out if !pte_same (Kirill)
v3: add vmf->ptl lock/unlock (Kirill A. Shutemov)
    add arch_faults_on_old_pte (Matthew, Catalin)
v2: remove FAULT_FLAG_WRITE when setting pte access flag (Catalin)

Jia He (4):
  arm64: cpufeature: introduce helper cpu_has_hw_af()
  arm64: mm: implement arch_faults_on_old_pte() on arm64
  x86/mm: implement arch_faults_on_old_pte() stub on x86
  mm: fix double page fault on arm64 if PTE_AF is cleared

 arch/arm64/include/asm/cpufeature.h |  14 ++++
 arch/arm64/include/asm/pgtable.h    |  14 ++++
 arch/x86/include/asm/pgtable.h      |   6 ++
 mm/memory.c                         | 104 ++++++++++++++++++++++++----
 4 files changed, 123 insertions(+), 15 deletions(-)

-- 
2.17.1

