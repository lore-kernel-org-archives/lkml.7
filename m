Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98893C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738FB2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfKZQgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:36:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:53760 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfKZQgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 11:36:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 08:36:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,246,1571727600"; 
   d="scan'208";a="359212403"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by orsmga004.jf.intel.com with ESMTP; 26 Nov 2019 08:36:31 -0800
From:   roman.sudarikov@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com
Cc:     alexander.antonov@intel.com, roman.sudarikov@linux.intel.com
Subject: [PATCH 0/6] perf x86: Exposing IO stack to IO PMON mapping through sysfs
Date:   Tue, 26 Nov 2019 19:36:24 +0300
Message-Id: <20191126163630.17300-1-roman.sudarikov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Sudarikov <roman.sudarikov@linux.intel.com>

Intel® Xeon® Scalable processor family (code name Skylake-SP) makes significant
changes in the integrated I/O (IIO) architecture. The new solution introduces
IIO stacks which are responsible for managing traffic between the PCIe domain
and the Mesh domain. Each IIO stack has its own PMON block and can handle either
DMI port, x16 PCIe root port, MCP-Link or various built-in accelerators.
IIO PMON blocks allow concurrent monitoring of I/O flows up to 4 x4 bifurcation
within each IIO stack.

Software is supposed to program required perf counters within each IIO stack
and gather performance data. The tricky thing here is that IIO PMON reports data
per IIO stack but users have no idea what IIO stacks are - they only know devices
which are connected to the platform. 

Understanding IIO stack concept to find which IIO stack that particular IO device
is connected to, or to identify an IIO PMON block to program for monitoring
specific IIO stack assumes a lot of implicit knowledge about given Intel server
platform architecture.

This patch set introduces:
    An infrastructure for exposing an Uncore unit to Uncore PMON mapping through sysfs-backend
    A new --iiostat mode in perf stat to provide I/O performance metrics per I/O device

Usage examples:

1. List all devices below IIO stacks
  ./perf stat --iiostat=show

Sample output w/o libpci:

    S0-RootPort0-uncore_iio_0<00:00.0>
    S1-RootPort0-uncore_iio_0<81:00.0>
    S0-RootPort1-uncore_iio_1<18:00.0>
    S1-RootPort1-uncore_iio_1<86:00.0>
    S1-RootPort1-uncore_iio_1<88:00.0>
    S0-RootPort2-uncore_iio_2<3d:00.0>
    S1-RootPort2-uncore_iio_2<af:00.0>
    S1-RootPort3-uncore_iio_3<da:00.0>

Sample output with libpci:

    S0-RootPort0-uncore_iio_0<00:00.0 Sky Lake-E DMI3 Registers>
    S1-RootPort0-uncore_iio_0<81:00.0 Ethernet Controller X710 for 10GbE SFP+>
    S0-RootPort1-uncore_iio_1<18:00.0 Omni-Path HFI Silicon 100 Series [discrete]>
    S1-RootPort1-uncore_iio_1<86:00.0 Ethernet Controller XL710 for 40GbE QSFP+>
    S1-RootPort1-uncore_iio_1<88:00.0 Ethernet Controller XL710 for 40GbE QSFP+>
    S0-RootPort2-uncore_iio_2<3d:00.0 Ethernet Connection X722 for 10GBASE-T>
    S1-RootPort2-uncore_iio_2<af:00.0 Omni-Path HFI Silicon 100 Series [discrete]>
    S1-RootPort3-uncore_iio_3<da:00.0 NVMe Datacenter SSD [Optane]>

2. Collect metrics for all I/O devices below IIO stack

  ./perf stat --iiostat -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
    357708+0 records in
    357707+0 records out
    375083606016 bytes (375 GB, 349 GiB) copied, 215.381 s, 1.7 GB/s

  Performance counter stats for 'system wide':

     device             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB)
    00:00.0                    0                    0                    0                    0
    81:00.0                    0                    0                    0                    0
    18:00.0                    0                    0                    0                    0
    86:00.0                    0                    0                    0                    0
    88:00.0                    0                    0                    0                    0
    3b:00.0                    3                    0                    0                    0
    3c:03.0                    3                    0                    0                    0
    3d:00.0                    3                    0                    0                    0
    af:00.0                    0                    0                    0                    0
    da:00.0               358559                   44                    0                   22

    215.383783574 seconds time elapsed


3. Collect metrics for comma separted list of I/O devices 

  ./perf stat --iiostat=da:00.0 -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
    381555+0 records in
    381554+0 records out
    400088457216 bytes (400 GB, 373 GiB) copied, 374.044 s, 1.1 GB/s

  Performance counter stats for 'system wide':

     device             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB)
    da:00.0               382462                   47                    0                   23

    374.045775505 seconds time elapsed

Roman Sudarikov (6):
  perf x86: Infrastructure for exposing an Uncore unit to PMON mapping
  perf tools: Helper functions to enumerate and probe PCI devices
  perf stat: Helper functions for list of IIO devices
  perf stat: New --iiostat mode to provide I/O performance metrics
  perf tools: Add feature check for libpci
  perf stat: Add PCI device name to --iiostat output

 arch/x86/events/intel/uncore.c                |  61 +-
 arch/x86/events/intel/uncore.h                |  13 +-
 arch/x86/events/intel/uncore_snbep.c          | 144 ++++
 tools/build/Makefile.feature                  |   2 +
 tools/build/feature/Makefile                  |   4 +
 tools/build/feature/test-all.c                |   5 +
 tools/build/feature/test-libpci.c             |  10 +
 tools/perf/Documentation/perf-stat.txt        |  12 +
 tools/perf/Makefile.config                    |  10 +
 tools/perf/arch/x86/util/Build                |   1 +
 tools/perf/arch/x86/util/iiostat.c            | 718 ++++++++++++++++++
 tools/perf/builtin-stat.c                     |  32 +-
 tools/perf/builtin-version.c                  |   1 +
 tools/perf/tests/make                         |   1 +
 tools/perf/util/Build                         |   1 +
 tools/perf/util/evsel.h                       |   1 +
 tools/perf/util/iiostat.h                     |  35 +
 tools/perf/util/pci.c                         |  99 +++
 tools/perf/util/pci.h                         |  27 +
 .../scripting-engines/trace-event-python.c    |   2 +-
 tools/perf/util/stat-display.c                |  53 +-
 tools/perf/util/stat-shadow.c                 |  12 +-
 tools/perf/util/stat.c                        |   3 +-
 tools/perf/util/stat.h                        |   2 +
 24 files changed, 1237 insertions(+), 12 deletions(-)
 create mode 100644 tools/build/feature/test-libpci.c
 create mode 100644 tools/perf/arch/x86/util/iiostat.c
 create mode 100644 tools/perf/util/iiostat.h
 create mode 100644 tools/perf/util/pci.c
 create mode 100644 tools/perf/util/pci.h


base-commit: 219d54332a09e8d8741c1e1982f5eae56099de85
-- 
2.19.1

