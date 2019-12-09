Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DF4C00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2808206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfLITOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:14:04 -0500
Received: from ale.deltatee.com ([207.54.116.67]:56026 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfLITOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 14:14:04 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ieOTk-00025k-Lg; Mon, 09 Dec 2019 12:13:57 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ieOTd-0001Me-0k; Mon, 09 Dec 2019 12:13:49 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon,  9 Dec 2019 12:13:40 -0700
Message-Id: <20191209191346.5197-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, dan.j.williams@intel.com, akpm@linux-foundation.org, catalin.marinas@arm.com, benh@kernel.crashing.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, will@kernel.org, luto@kernel.org, peterz@infradead.org, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 0/6] Allow setting caching mode in arch_add_memory() for P2PDMA
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Currently, the page tables created using memremap_pages() are always
created with the PAGE_KERNEL cacheing mode. However, the P2PDMA code
is creating pages for PCI BAR memory which should never be accessed
through the cache and instead use either WC or UC. This still works in
most cases, on x86, because the MTRR registers typically override the
caching settings in the page tables for all of the IO memory to be
UC-. However, this tends not to work so well on other arches or
some rare x86 machines that have firmware which does not setup the
MTRR registers in this way.

Instead of this, this series proposes a change to arch_add_memory()
to take the pgprot required by the mapping which allows us to
explicitly set pagetable entries for P2PDMA memory to WC.

This changes is pretty routine for most of the arches: x86_64, s390, arm64
and powerpc simply need to thread the pgprot through to where the page tables
are setup. x86_32 unfortunately sets up the page tables at boot so
must use _set_memory_prot() to change their caching mode. ia64 and sh
don't appear to have an easy way to change the page tables so, for now
at least, we just return -EINVAL on such mappings and thus they will
not support P2PDMA memory until the work for this is done.

Thanks,

Logan

--

Logan Gunthorpe (6):
  x86/mm: Thread pgprot_t through init_memory_mapping()
  x86/mm: Introduce _set_memory_prot()
  powerpc/mm: Thread pgprot_t through create_section_mapping()
  s390/mm: Thread pgprot_t through vmem_add_mapping()
  mm, memory_hotplug: Provide argument for the pgprot_t in
    arch_add_memory()
  mm/memremap: Set caching mode for PCI P2PDMA memory to WC

 arch/arm64/mm/mmu.c                        |  4 +--
 arch/ia64/mm/init.c                        |  5 +++-
 arch/powerpc/include/asm/book3s/64/hash.h  |  3 +-
 arch/powerpc/include/asm/book3s/64/radix.h |  3 +-
 arch/powerpc/include/asm/sparsemem.h       |  3 +-
 arch/powerpc/mm/book3s64/hash_utils.c      |  5 ++--
 arch/powerpc/mm/book3s64/pgtable.c         |  7 +++--
 arch/powerpc/mm/book3s64/radix_pgtable.c   | 18 +++++++-----
 arch/powerpc/mm/mem.c                      |  7 +++--
 arch/s390/include/asm/pgtable.h            |  3 +-
 arch/s390/mm/extmem.c                      |  3 +-
 arch/s390/mm/init.c                        |  4 +--
 arch/s390/mm/vmem.c                        | 10 +++----
 arch/sh/mm/init.c                          |  5 +++-
 arch/x86/include/asm/page_types.h          |  3 --
 arch/x86/include/asm/pgtable.h             |  3 ++
 arch/x86/include/asm/set_memory.h          |  1 +
 arch/x86/kernel/amd_gart_64.c              |  3 +-
 arch/x86/mm/init.c                         |  9 +++---
 arch/x86/mm/init_32.c                      | 10 +++++--
 arch/x86/mm/init_64.c                      | 34 ++++++++++++----------
 arch/x86/mm/mm_internal.h                  |  3 +-
 arch/x86/mm/pageattr.c                     |  7 +++++
 arch/x86/platform/efi/efi_64.c             |  3 +-
 include/linux/memory_hotplug.h             |  2 +-
 mm/memory_hotplug.c                        |  2 +-
 mm/memremap.c                              |  5 +++-
 27 files changed, 104 insertions(+), 61 deletions(-)

--
2.20.1
