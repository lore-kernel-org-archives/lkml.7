Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BC2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE152075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfDDTVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:21:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:48503 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729287AbfDDTVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:21:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 12:21:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,309,1549958400"; 
   d="scan'208";a="128686099"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007.jf.intel.com with ESMTP; 04 Apr 2019 12:21:07 -0700
Subject: [RFC PATCH 0/5] EFI Special Purpose Memory Support
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Andy Shevchenko <andy@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-mm@kvack.org, keith.busch@intel.com,
        vishal.l.verma@intel.com, linux-nvdimm@lists.01.org
Date:   Thu, 04 Apr 2019 12:08:28 -0700
Message-ID: <155440490809.3190322.15060922240602775809.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EFI 2.8 Specification [1] introduces the EFI_MEMORY_SP ("special
purpose") memory attribute. This attribute bit replaces the deprecated
"reservation hint" that was introduced in ACPI 6.2 and removed in ACPI
6.3.

Given the increasing diversity of memory types that might be advertised
to the operating system, there is a need for platform firmware to hint
which memory ranges are free for the OS to use as general purpose memory
and which ranges are intended for application specific usage. For
example, an application with prior knowledge of the platform may expect
to be able to exclusively allocate a precious / limited pool of high
bandwidth memory. Alternatively, for the general purpose case, the
operating system may want to make the memory available on a best effort
basis as a unique numa-node with performance properties by the new
CONFIG_HMEM_REPORTING [2] facility.

In support of allowing for both exclusive and core-kernel-mm managed
access to differentiated memory, claim EFI_MEMORY_SP ranges for exposure
as device-dax instances by default. Those instances can be directly
owned / mapped by a platform-topology-aware application. However, with
the new kmem facility [3], the administrator has the option to instead
designate that those memory ranges be hot-added to the core-kernel-mm as
a unique memory numa-node. In short, allow for the decision about what
software agent manages special purpose memory to be made at runtime.

The patches are based on v8 of Keith's "HMEM" series currently in Greg's
driver-core-testing branch [4], and have not been tested. This is an RFC
proposal on how to handle the new EFI memory attribute.

[1]: https://uefi.org/sites/default/files/resources/UEFI_Spec_2_8_final.pdf
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=driver-core-testing&id=b6efba75c449
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c221c0b0308f
[4]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/log/?h=driver-core-testing

---

Dan Williams (5):
      efi: Detect UEFI 2.8 Special Purpose Memory
      lib/memregion: Uplevel the pmem "region" ida to a global allocator
      acpi/hmat: Track target address ranges
      acpi/hmat: Register special purpose memory as a device
      device-dax: Add a driver for "hmem" devices


 arch/x86/Kconfig                  |   18 +++++
 arch/x86/boot/compressed/eboot.c  |    5 +
 arch/x86/boot/compressed/kaslr.c  |    2 -
 arch/x86/include/asm/e820/types.h |    9 ++
 arch/x86/kernel/e820.c            |    9 ++
 arch/x86/platform/efi/efi.c       |   10 ++-
 drivers/acpi/hmat/Kconfig         |    1 
 drivers/acpi/hmat/hmat.c          |  140 +++++++++++++++++++++++++++++++------
 drivers/dax/Kconfig               |   26 ++++++-
 drivers/dax/Makefile              |    2 +
 drivers/dax/hmem.c                |   58 +++++++++++++++
 drivers/nvdimm/Kconfig            |    1 
 drivers/nvdimm/core.c             |    1 
 drivers/nvdimm/nd-core.h          |    1 
 drivers/nvdimm/region_devs.c      |   13 +--
 include/linux/efi.h               |   14 ++++
 include/linux/ioport.h            |    1 
 include/linux/memregion.h         |    9 ++
 lib/Kconfig                       |    6 ++
 lib/Makefile                      |    1 
 lib/memregion.c                   |   22 ++++++
 21 files changed, 304 insertions(+), 45 deletions(-)
 create mode 100644 drivers/dax/hmem.c
 create mode 100644 include/linux/memregion.h
 create mode 100644 lib/memregion.c
