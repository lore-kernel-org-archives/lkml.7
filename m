Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F1BC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B19E20874
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfFEWNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 18:13:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:25093 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfFEWNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 18:13:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 15:13:04 -0700
X-ExtLoop1: 1
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jun 2019 15:13:04 -0700
Subject: [PATCH v9 09/12] mm: Document ZONE_DEVICE memory-model implications
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        osalvador@suse.de, mhocko@suse.com
Date:   Wed, 05 Jun 2019 14:58:47 -0700
Message-ID: <155977192794.2443951.16177998596403034849.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explain the general mechanisms of 'ZONE_DEVICE' pages and list the users
of 'devm_memremap_pages()'.

Cc: Jonathan Corbet <corbet@lwn.net>
Reported-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/vm/memory-model.rst |   39 +++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/vm/memory-model.rst b/Documentation/vm/memory-model.rst
index 382f72ace1fc..e0af47e02e78 100644
--- a/Documentation/vm/memory-model.rst
+++ b/Documentation/vm/memory-model.rst
@@ -181,3 +181,42 @@ that is eventually passed to vmemmap_populate() through a long chain
 of function calls. The vmemmap_populate() implementation may use the
 `vmem_altmap` along with :c:func:`altmap_alloc_block_buf` helper to
 allocate memory map on the persistent memory device.
+
+ZONE_DEVICE
+===========
+The `ZONE_DEVICE` facility builds upon `SPARSEMEM_VMEMMAP` to offer
+`struct page` `mem_map` services for device driver identified physical
+address ranges. The "device" aspect of `ZONE_DEVICE` relates to the fact
+that the page objects for these address ranges are never marked online,
+and that a reference must be taken against the device, not just the page
+to keep the memory pinned for active use. `ZONE_DEVICE`, via
+:c:func:`devm_memremap_pages`, performs just enough memory hotplug to
+turn on :c:func:`pfn_to_page`, :c:func:`page_to_pfn`, and
+:c:func:`get_user_pages` service for the given range of pfns. Since the
+page reference count never drops below 1 the page is never tracked as
+free memory and the page's `struct list_head lru` space is repurposed
+for back referencing to the host device / driver that mapped the memory.
+
+While `SPARSEMEM` presents memory as a collection of sections,
+optionally collected into memory blocks, `ZONE_DEVICE` users have a need
+for smaller granularity of populating the `mem_map`. Given that
+`ZONE_DEVICE` memory is never marked online it is subsequently never
+subject to its memory ranges being exposed through the sysfs memory
+hotplug api on memory block boundaries. The implementation relies on
+this lack of user-api constraint to allow sub-section sized memory
+ranges to be specified to :c:func:`arch_add_memory`, the top-half of
+memory hotplug. Sub-section support allows for `PMD_SIZE` as the minimum
+alignment granularity for :c:func:`devm_memremap_pages`.
+
+The users of `ZONE_DEVICE` are:
+* pmem: Map platform persistent memory to be used as a direct-I/O target
+  via DAX mappings.
+
+* hmm: Extend `ZONE_DEVICE` with `->page_fault()` and `->page_free()`
+  event callbacks to allow a device-driver to coordinate memory management
+  events related to device-memory, typically GPU memory. See
+  Documentation/vm/hmm.rst.
+
+* p2pdma: Create `struct page` objects to allow peer devices in a
+  PCI/-E topology to coordinate direct-DMA operations between themselves,
+  i.e. bypass host memory.

