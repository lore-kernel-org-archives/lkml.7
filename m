Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B77C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6F421917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfCVRKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:10:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:1496 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbfCVRKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:10:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 10:10:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="154240203"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga002.fm.intel.com with ESMTP; 22 Mar 2019 10:10:33 -0700
Subject: [PATCH v5 00/10] mm: Sub-section memory hotplug support
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Jeff Moyer <jmoyer@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 22 Mar 2019 09:57:54 -0700
Message-ID: <155327387405.225273.9325594075351253804.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v4 [1]:
- Given v4 was from March of 2017 the bulk of the changes result from
  rebasing the patch set from a v4.11-rc2 baseline to v5.1-rc1.

- A unit test is added to ndctl to exercise the creation and dax
  mounting of multiple independent namespaces in a single 128M section.

[1]: https://lwn.net/Articles/717383/

---

Quote patch7:

"The libnvdimm sub-system has suffered a series of hacks and broken
 workarounds for the memory-hotplug implementation's awkward
 section-aligned (128MB) granularity. For example the following backtrace
 is emitted when attempting arch_add_memory() with physical address
 ranges that intersect 'System RAM' (RAM) with 'Persistent Memory' (PMEM)
 within a given section:
 
  WARNING: CPU: 0 PID: 558 at kernel/memremap.c:300 devm_memremap_pages+0x3b5/0x4c0
  devm_memremap_pages attempted on mixed region [mem 0x200000000-0x2fbffffff flags 0x200]
  [..]
  Call Trace:
    dump_stack+0x86/0xc3
    __warn+0xcb/0xf0
    warn_slowpath_fmt+0x5f/0x80
    devm_memremap_pages+0x3b5/0x4c0
    __wrap_devm_memremap_pages+0x58/0x70 [nfit_test_iomap]
    pmem_attach_disk+0x19a/0x440 [nd_pmem]
 
 Recently it was discovered that the problem goes beyond RAM vs PMEM
 collisions as some platform produce PMEM vs PMEM collisions within a
 given section. The libnvdimm workaround for that case revealed that the
 libnvdimm section-alignment-padding implementation has been broken for a
 long while. A fix for that long-standing breakage introduces as many
 problems as it solves as it would require a backward-incompatible change
 to the namespace metadata interpretation. Instead of that dubious route
 [2], address the root problem in the memory-hotplug implementation."

The approach is taken is to observe that each section already maintains
an array of 'unsigned long' values to hold the pageblock_flags. A single
additional 'unsigned long' is added to house a 'sub-section active'
bitmask. Each bit tracks the mapped state of one sub-section's worth of
capacity which is SECTION_SIZE / BITS_PER_LONG, or 2MB on x86-64.

The implication of allowing sections to be piecemeal mapped/unmapped is
that the valid_section() helper is no longer authoritative to determine
if a section is fully mapped. Instead pfn_valid() is updated to consult
the section-active bitmask. Given that typical memory hotplug still has
deep "section" dependencies the sub-section capability is limited to
'want_memblock=false' invocations of arch_add_memory(), effectively only
devm_memremap_pages() users for now.

With this in place the hacks in the libnvdimm sub-system can be
dropped, and other devm_memremap_pages() users need no longer be
constrained to 128MB mapping granularity.

[2]: https://lore.kernel.org/r/155000671719.348031.2347363160141119237.stgit@dwillia2-desk3.amr.corp.intel.com

---

Dan Williams (10):
      mm/sparsemem: Introduce struct mem_section_usage
      mm/sparsemem: Introduce common definitions for the size and mask of a section
      mm/sparsemem: Add helpers track active portions of a section at boot
      mm/hotplug: Prepare shrink_{zone,pgdat}_span for sub-section removal
      mm/sparsemem: Convert kmalloc_section_memmap() to populate_section_memmap()
      mm/sparsemem: Prepare for sub-section ranges
      mm/sparsemem: Support sub-section hotplug
      mm/devm_memremap_pages: Enable sub-section remap
      libnvdimm/pfn: Fix fsdax-mode namespace info-block zero-fields
      libnvdimm/pfn: Stop padding pmem namespaces to section alignment


 arch/x86/mm/init_64.c          |   15 +-
 drivers/nvdimm/dax_devs.c      |    2 
 drivers/nvdimm/pfn.h           |   12 -
 drivers/nvdimm/pfn_devs.c      |   93 +++-------
 include/linux/memory_hotplug.h |    7 -
 include/linux/mm.h             |    4 
 include/linux/mmzone.h         |   60 ++++++
 kernel/memremap.c              |   57 ++----
 mm/hmm.c                       |    2 
 mm/memory_hotplug.c            |  119 +++++++-----
 mm/page_alloc.c                |    6 -
 mm/sparse-vmemmap.c            |   21 +-
 mm/sparse.c                    |  382 ++++++++++++++++++++++++++++------------
 13 files changed, 476 insertions(+), 304 deletions(-)
