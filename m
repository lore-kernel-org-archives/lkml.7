Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C6CC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 04:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86342178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 04:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733180AbfKGEKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 23:10:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:40082 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbfKGEKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 23:10:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:10:52 -0800
X-IronPort-AV: E=Sophos;i="5.68,276,1569308400"; 
   d="scan'208";a="192696501"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:10:52 -0800
Subject: [PATCH 00/16] Memory Hierarchy: Enable target node lookups for
 reserved memory
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Lutomirski <luto@kernel.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 06 Nov 2019 19:56:35 -0800
Message-ID: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, this patch series looks like a pile of boring libnvdimm cleanups,
but buried at the end are some small gems that testing with libnvdimm
uncovered. These gems will prove more valuable over time for Memory
Hierarchy management as more platforms, via the ACPI HMAT and EFI
Specific Purpose Memory, publish reserved or "soft-reserved" ranges to
Linux. Linux system administrators will expect to be able to interact
with those ranges with a unique numa node number when/if that memory is
onlined via the dax_kmem driver [1].

One configuration that currently fails to properly convey the target
node for the resulting memory hotplug operation is persistent memory
defined by the memmap=nn!ss parameter. For example, today if node1 is a
memory only node, and all the memory from node1 is specified to
memmap=nn!ss and subsequently onlined, it will end up being onlined as
node0 memory. As it stands, memory_add_physaddr_to_nid() can only
identify online nodes and since node1 in this example has no online cpus
/ memory the target node is initialized node0.

The fix is to preserve rather than discard the numa_meminfo entries that
are relevant for reserved memory ranges, and to uplevel the node
distance helper for determining the "local" (closest) node relative to
an initiator node.

The first 12 patches are cleanups to make sure that all nvdimm devices
and their children properly export a numa_node attribute. The switch to
a device-type is less code and less error prone as a result.

Patch 13 and 14 are the core changes (gems) to allow numa node
information for offline memory to be tracked.

Patches 15 and 16 use this new capability to fix the conveyance of numa
node information for memmap=nn!ss assignments. See patch 16 for more
details.

[1]: https://pmem.io/ndctl/daxctl-reconfigure-device.html

---

Dan Williams (16):
      libnvdimm: Move attribute groups to device type
      libnvdimm: Move region attribute group definition
      libnvdimm: Move nd_device_attribute_group to device_type
      libnvdimm: Move nd_numa_attribute_group to device_type
      libnvdimm: Move nd_region_attribute_group to device_type
      libnvdimm: Move nd_mapping_attribute_group to device_type
      libnvdimm: Move nvdimm_attribute_group to device_type
      libnvdimm: Move nvdimm_bus_attribute_group to device_type
      dax: Create a dax device_type
      dax: Simplify root read-only definition for the 'resource' attribute
      libnvdimm: Simplify root read-only definition for the 'resource' attribute
      dax: Add numa_node to the default device-dax attributes
      acpi/mm: Up-level "map to online node" functionality
      x86/numa: Provide a range-to-target_node lookup facility
      libnvdimm/e820: Drop the wrapper around memory_add_physaddr_to_nid
      libnvdimm/e820: Retrieve and populate correct 'target_node' info


 arch/powerpc/platforms/pseries/papr_scm.c |   25 ---
 arch/x86/mm/numa.c                        |   72 ++++++++-
 drivers/acpi/nfit/core.c                  |    7 -
 drivers/acpi/numa.c                       |   41 -----
 drivers/dax/bus.c                         |   22 ++-
 drivers/nvdimm/btt_devs.c                 |   24 +--
 drivers/nvdimm/bus.c                      |   15 +-
 drivers/nvdimm/core.c                     |    8 +
 drivers/nvdimm/dax_devs.c                 |   27 +--
 drivers/nvdimm/dimm_devs.c                |   30 ++--
 drivers/nvdimm/e820.c                     |   30 ----
 drivers/nvdimm/namespace_devs.c           |   77 +++++-----
 drivers/nvdimm/nd.h                       |    5 -
 drivers/nvdimm/of_pmem.c                  |   13 --
 drivers/nvdimm/pfn_devs.c                 |   38 ++---
 drivers/nvdimm/region_devs.c              |  235 +++++++++++++++--------------
 include/linux/acpi.h                      |   23 +++
 include/linux/libnvdimm.h                 |    7 -
 include/linux/memory_hotplug.h            |    6 +
 include/linux/numa.h                      |    2 
 mm/mempolicy.c                            |   30 ++++
 21 files changed, 382 insertions(+), 355 deletions(-)
