Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB95C46477
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F4221734
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408195AbfFKXkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 19:40:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:43209 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405380AbfFKXkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 19:40:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 16:40:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,363,1557212400"; 
   d="scan'208";a="184035062"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jun 2019 16:39:59 -0700
Subject: [PATCH 0/6] libnvdimm: Fix async operations and locking
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Jane Chu <jane.chu@oracle.com>, stable@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Erwin Tsaur <erwin.tsaur@oracle.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Tue, 11 Jun 2019 16:25:43 -0700
Message-ID: <156029554317.419799.1324389595953183385.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The libnvdimm subsystem uses async operations to parallelize device
probing operations and to allow sysfs to trigger device_unregister() on
deleted namepsaces. A multithreaded stress test of the libnvdimm sysfs
interface uncovered a case where device_unregister() is triggered
multiple times, and the subsequent investigation uncovered a broken
locking scenario.

The lack of lockdep coverage for device_lock() stymied the debug. That
is, until patch6 "driver-core, libnvdimm: Let device subsystems add
local lockdep coverage" solved that with a shadow lock, with lockdep
coverage, to mirror device_lock() operations. Given the time saved with
shadow-lock debug-hack, patch6 attempts to generalize device_lock()
debug facility that might be able to be carried upstream. Patch6 is
staged at the end of this fix series in case it is contentious and needs
to be dropped.

Patch1 "drivers/base: Introduce kill_device()" could be achieved with
local libnvdimm infrastructure. However, the existing 'dead' flag in
'struct device_private' aims to solve similar async register/unregister
races so the fix in patch2 "libnvdimm/bus: Prevent duplicate
device_unregister() calls" can be implemented with existing driver-core
infrastructure.

Patch3 is a rare lockdep warning that is intermittent based on
namespaces racing ahead of the completion of probe of their parent
region. It is not related to the other fixes, it just happened to
trigger as a result of the async stress test.

Patch4 and patch5 address an ABBA deadlock tripped by the stress test.

These patches pass the failing stress test and the existing libnvdimm
unit tests with CONFIG_PROVE_LOCKING=y and the new "dev->lockdep_mutex"
shadow lock with no lockdep warnings.

---

Dan Williams (6):
      drivers/base: Introduce kill_device()
      libnvdimm/bus: Prevent duplicate device_unregister() calls
      libnvdimm/region: Register badblocks before namespaces
      libnvdimm/bus: Stop holding nvdimm_bus_list_mutex over __nd_ioctl()
      libnvdimm/bus: Fix wait_nvdimm_bus_probe_idle() ABBA deadlock
      driver-core, libnvdimm: Let device subsystems add local lockdep coverage


 drivers/acpi/nfit/core.c        |   28 ++++---
 drivers/acpi/nfit/nfit.h        |   24 ++++++
 drivers/base/core.c             |   30 ++++++--
 drivers/nvdimm/btt_devs.c       |   16 ++--
 drivers/nvdimm/bus.c            |  154 +++++++++++++++++++++++++++------------
 drivers/nvdimm/core.c           |   10 +--
 drivers/nvdimm/dimm_devs.c      |    4 +
 drivers/nvdimm/namespace_devs.c |   36 +++++----
 drivers/nvdimm/nd-core.h        |   71 ++++++++++++++++++
 drivers/nvdimm/pfn_devs.c       |   24 +++---
 drivers/nvdimm/pmem.c           |    4 +
 drivers/nvdimm/region.c         |   24 +++---
 drivers/nvdimm/region_devs.c    |   12 ++-
 include/linux/device.h          |    6 ++
 14 files changed, 308 insertions(+), 135 deletions(-)
