Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A4EC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07542081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfECIpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:45:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:5527 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbfECIpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:45:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 01:45:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="147811516"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2019 01:45:18 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 00/22] intel_th: Updates for v5.2
Date:   Fri,  3 May 2019 11:44:33 +0300
Message-Id: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are the updates that I have for v5.2. The main item on the list is
the support for software trace sinks that I call "buffer drivers". The
purpose is to create a software path for the trace data coming out of
the TH that would allow exporting it via a USB gadget or ethernet or
some such. Most of the patches are reworks in the MSU code to enable
this, including interrupt handling and resource passing between glue
layers and the driver core. An example sink driver is included. Also,
there's a bugfix that's backportable all the way to stable 4.4.

These are all, as usual, tested with aiaiai for bisectability, cppcheck,
sparse, smatch, coccinelle and checkpatch errors.

Signed tag is at the repo below. Individual patches follow. Please
consider pulling or applying. Apologies for late request.

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git tags/intel_th-for-greg-20190503

for you to fetch changes up to c0e8a65abd2e4ad47e5257de6bde1822e9c458b6:

  intel_th: msu: Preserve pre-existing buffer configuration (2019-05-03 11:35:46 +0300)

----------------------------------------------------------------
intel_th: Updates for v5.2

These are:
  * Support for software trace sinks
  * Interrupt handling, MSI support
  * Reworks in resource passing between glue layers and driver core
  * Reworks in buffer management code
  * Various small reworks in the MSU code
  * Support for window switching in MSU "multi" mode
  * A fix for the MSU "single" mode, backportable all the way to v4.4
  * A new "rtit" subdevice

----------------------------------------------------------------
Alexander Shishkin (22):
      intel_th: msu: Fix single mode with IOMMU
      intel_th: SPDX-ify the documentation
      intel_th: Rework resource passing between glue layers and core
      intel_th: Skip subdevices if their MMIO is missing
      intel_th: Add "rtit" source device
      intel_th: Communicate IRQ via resource
      intel_th: pci: Use MSI interrupt signalling
      intel_th: msu: Start handling IRQs
      intel_th: Only report useful IRQs to subdevices
      intel_th: msu: Replace open-coded list_{first,last,next}_entry variants
      intel_th: msu: Switch over to scatterlist
      intel_th: msu: Support multipage blocks
      intel_th: msu: Factor out pipeline draining
      intel_th: gth: Factor out trace start/stop
      intel_th: Add switch triggering support
      intel_th: msu: Correct the block wrap detection
      intel_th: msu: Add a sysfs attribute to trigger window switch
      intel_th: msu: Add current window tracking
      intel_th: msu: Introduce buffer driver interface
      intel_th: msu: Add a sysfs attribute showing possible modes
      intel_th: msu-sink: An example msu buffer driver
      intel_th: msu: Preserve pre-existing buffer configuration

 .../ABI/testing/sysfs-bus-intel_th-devices-msc     |  19 +-
 Documentation/trace/intel_th.rst                   |   2 +
 MAINTAINERS                                        |   1 +
 drivers/hwtracing/intel_th/Makefile                |   3 +
 drivers/hwtracing/intel_th/acpi.c                  |  10 +-
 drivers/hwtracing/intel_th/core.c                  | 139 +++-
 drivers/hwtracing/intel_th/gth.c                   | 125 ++-
 drivers/hwtracing/intel_th/gth.h                   |  19 +
 drivers/hwtracing/intel_th/intel_th.h              |  30 +-
 drivers/hwtracing/intel_th/msu-sink.c              | 137 ++++
 drivers/hwtracing/intel_th/msu.c                   | 864 +++++++++++++++++----
 drivers/hwtracing/intel_th/msu.h                   |  31 +-
 drivers/hwtracing/intel_th/pci.c                   |  32 +-
 include/linux/intel_th.h                           |  67 ++
 14 files changed, 1270 insertions(+), 209 deletions(-)
 create mode 100644 drivers/hwtracing/intel_th/msu-sink.c
 create mode 100644 include/linux/intel_th.h

-- 
2.20.1

