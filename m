Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B258C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F95E20818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfDLTCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 15:02:04 -0400
Received: from foss.arm.com ([217.140.101.70]:38358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbfDLTCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 15:02:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE618374;
        Fri, 12 Apr 2019 12:02:03 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4F8043F718;
        Fri, 12 Apr 2019 12:02:02 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     linux-mm@kvack.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com, jglisse@redhat.com,
        oohall@gmail.com, x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 0/3] Device-memory-related cleanups
Date:   Fri, 12 Apr 2019 20:01:55 +0100
Message-Id: <cover.1555093412.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412190155.Fs0z5Tns6w8Rq1oAJQsDDrhMagtGma2VZ9eTIpW4M28@z>

[This time hopefully without botching Oliver's address.. sorry for the spam]

Hi,

As promised, these are my preparatory cleanup patches that have so far
fallen out of pmem DAX work for arm64. Patch #1 has already been out for
a ride in Anshuman's hot-remove series, so I've collected the acks
already given.

Since we have various things in flight at the moment touching arm64
pagetable code, I'm wary of conflicts and cross-tree dependencies for
our actual ARCH_HAS_PTE_DEVMAP implementation. Thus it would be nice if
these could be picked up for 5.2 via mm or nvdimm as appropriate, such
that we can then handle the devmap patch itself via arm64 next cycle.

Robin.


Robin Murphy (3):
  mm/memremap: Rename and consolidate SECTION_SIZE
  mm: clean up is_device_*_page() definitions
  mm: introduce ARCH_HAS_PTE_DEVMAP

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
 12 files changed, 29 insertions(+), 52 deletions(-)

-- 
2.21.0.dirty

