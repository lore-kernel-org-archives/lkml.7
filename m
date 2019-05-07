Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B76C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9133120C01
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfEHAJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 20:09:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:9079 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfEHAJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 20:09:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 17:09:45 -0700
X-ExtLoop1: 1
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga004.fm.intel.com with ESMTP; 07 May 2019 17:09:46 -0700
Subject: [PATCH v2 0/6] mm/devm_memremap_pages: Fix page release race
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org
Date:   Tue, 07 May 2019 16:55:59 -0700
Message-ID: <155727335978.292046.12068191395005445711.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1 [1]:
- Fix a NULL-pointer deref crash in pci_p2pdma_release() (Logan)

- Refresh the p2pdma patch headers to match the format of other p2pdma
  patches (Bjorn)

- Collect Ira's reviewed-by

[1]: https://lore.kernel.org/lkml/155387324370.2443841.574715745262628837.stgit@dwillia2-desk3.amr.corp.intel.com/

---

Logan audited the devm_memremap_pages() shutdown path and noticed that
it was possible to proceed to arch_remove_memory() before all
potential page references have been reaped.

Introduce a new ->cleanup() callback to do the work of waiting for any
straggling page references and then perform the percpu_ref_exit() in
devm_memremap_pages_release() context.

For p2pdma this involves some deeper reworks to reference count
resources on a per-instance basis rather than a per pci-device basis. A
modified genalloc api is introduced to convey a driver-private pointer
through gen_pool_{alloc,free}() interfaces. Also, a
devm_memunmap_pages() api is introduced since p2pdma does not
auto-release resources on a setup failure.

The dax and pmem changes pass the nvdimm unit tests, and the p2pdma
changes should now pass testing with the pci_p2pdma_release() fix.
Jérôme, how does this look for HMM?

In general, I think these patches / fixes are suitable for v5.2-rc1 or
v5.2-rc2, and since they touch kernel/memremap.c, and other various
pieces of the core, they should go through the -mm tree. These patches
merge cleanly with the current state of -next, pass the nvdimm unit
tests, and are exposed to the 0day robot with no issues reported
(https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/log/?h=libnvdimm-pending).

---

Dan Williams (6):
      drivers/base/devres: Introduce devm_release_action()
      mm/devm_memremap_pages: Introduce devm_memunmap_pages
      PCI/P2PDMA: Fix the gen_pool_add_virt() failure path
      lib/genalloc: Introduce chunk owners
      PCI/P2PDMA: Track pgmap references per resource, not globally
      mm/devm_memremap_pages: Fix final page put race


 drivers/base/devres.c             |   24 +++++++-
 drivers/dax/device.c              |   13 +---
 drivers/nvdimm/pmem.c             |   17 ++++-
 drivers/pci/p2pdma.c              |  115 +++++++++++++++++++++++--------------
 include/linux/device.h            |    1 
 include/linux/genalloc.h          |   55 ++++++++++++++++--
 include/linux/memremap.h          |    8 +++
 kernel/memremap.c                 |   23 ++++++-
 lib/genalloc.c                    |   51 ++++++++--------
 mm/hmm.c                          |   14 +----
 tools/testing/nvdimm/test/iomap.c |    2 +
 11 files changed, 217 insertions(+), 106 deletions(-)
