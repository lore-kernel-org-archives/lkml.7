Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD2EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3D82183F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfDOQFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:05:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37630 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfDOQFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:05:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9585D80D;
        Mon, 15 Apr 2019 09:05:44 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1B8B23F68F;
        Mon, 15 Apr 2019 09:05:42 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 00/36] coresight: Support for ACPI bindings
Date:   Mon, 15 Apr 2019 17:03:43 +0100
Message-Id: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series adds the support for CoreSight devices on ACPI based
platforms. The device connections are encoded as _DSD graph property[0],
with CoreSight specific extensions to indicate the direction of data
flow as described in [1]. Components attached to CPUs are listed
as child devices of the corresponding CPU, removing explicit links
to the CPU like we do in the DT.


The majority of the series cleans up the driver and prepares the subsystem
for platform agnostic firwmare probing, naming scheme, searching etc.

We introduce platform independent helpers to parse the platform supplied
information. Thus we rename the platform handling code from:
	of_coresight.c  => coresight-platform.c

The CoreSight driver creates shadow devices that appear on the Coresight
bus, in addition to the real devices (e.g, AMBA bus devices). The name
of these devices match the real device. This makes the device name
a bit cryptic for ACPI platform. So this series also introduces a generic
platform agnostic device naming scheme for the shadow Coresight devices.
Towards this we also make changes to the way we lookup devices to resolve
the connections, as we can't use the names to identify the devices. So,
we use the "fwnode_handle" of the real device for the device lookups.
Towards that we clean up the drivers to keep track of the "CoreSight"
device rather than the "real" device. However, all real operations,
like DMA allocation, Power management etc. must be performed on
the real device which is the parent of the shadow device.

Finally we add the support for parsing the ACPI platform data. The power
management support is missing in the ACPI (and this is not specific to
CoreSight). The firmware must ensure that the respective power domains
are turned on.

The last 3 patches in the series also exposes the device connections
via sysfs by symlinks to indicate the trace data paths.

Patches 01 - 05 : General cleanups and a fix.
Patches 06 - 13 : Cleanup the drivers for tracking the CoreSight device
		  instead of the parent device.
Patches 14 - 20 : Introduce platform agnostic APIs for firmware data
		  probing.
Patches 21 - 26 : Prepare for reusing and freeing up the platform data
		  description for device connections and references.
Patches 27 - 30 : Use fwnode handles and introduce generic naming scheme.
Patches 31 - 33 : Introduce ACPI bindings support
Patches 34 - 36 : RFC - expose device connections via sysfs


Applies on Mathieu's coresight/next tree.

Tested on a Juno-r0 board with ACPI bindings patch (Patch 37/36) added on
top of [2]. You would need to make sure that the debug power domain is
turned on before the Linux kernel boots. (e.g, connect the DS-5 to the
Juno board while at UEFI). arm32 code is only compile tested.

[0] ACPI Device Graphs using _DSD (Not available online yet, approved but
    awaiting publish and eventually should be linked at).
    https://uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel-1_1.htm
[1] https://developer.arm.com/docs/den0067/latest/acpi-for-coresighttm-10-platform-design-document
[2] https://github.com/tianocore/edk2-platforms.git


Changes since v1:

 [ http://lists.infradead.org/pipermail/linux-arm-kernel/2019-March/639963.html ]

  - Dropped the replicator driver merge changes as they were pulled already.
  - Cleanups for Power management in the drivers.
  - Reuse platform description for connection information. Also introduce
    routines to clean up the platform description to make sure we drop
    the references (fwnode_handle).
  - Add RFC patches for exposing the device-links via sysfs.
  - Drop tracking the device in favour of coresight_device.
  - Name etb10 as "etb"
  - Fix other comments in v1.
  - Use a generic helper for searching with fwnode_handle rather than adding
    one for CoreSight.


Suzuki K Poulose (36):
  coresight: Fix freeing up the coresight connections
  coresight: etb10: Cleanup power management
  coresight: tpiu: Cleanup power management
  coresight: catu: Cleanup power management
  coresight: tmc: Cleanup power management
  coresight: funnel: Clean up device book keeping
  coresight: replicator: Cleanup device tracking
  coresight: tmc: Clean up device specific data
  coresight: catu: Cleanup device specific data
  coresight: tpiu: Clean up device specific data
  coresight: stm: Cleanup device specific data
  coresight: etm: Clean up device specific data
  coresight: etb10: Clean up device specific data
  coresight: Rename of_coresight to coresight-platform
  coresight: etm3x: Rearrange cp14 access detection
  coresight: stm: Rearrange probing the stimulus area
  coresight: tmc-etr: Rearrange probing default buffer size
  coresight: platform: Make memory allocation helper generic
  coresight: Introduce generic platform data helper
  coresight: Make device to CPU mapping generic
  coresight: Remove cpu field from platform data
  coresight: Remove name from platform description
  coresight: Cleanup coresight_remove_conns
  coresight: Reuse platform data structure for connection tracking
  coresight: Rearrange platform data probing
  coresight: Add support for releasing platform specific data
  drivers: Add a generic helper to match device by fwnode handle
  coresight: platform: Use fwnode handle for device search
  coresight: Use fwnode handle instead of device names
  coresight: Use platform agnostic names
  coresight: stm: ACPI support for parsing stimulus base
  coresight: Support for ACPI bindings
  coresight: acpi: Support for components
  [RFC] coresight: Pass coresight_device for
    coresight_release_platform_data
  [RFC] coresight: add return value for fixup connections
  [RFC] coresight: Expose device connections via sysfs

 drivers/acpi/acpi_amba.c                           |   9 +
 drivers/base/devcon.c                              |   5 -
 drivers/base/property.c                            |   6 +
 drivers/hwtracing/coresight/Makefile               |   3 +-
 drivers/hwtracing/coresight/coresight-catu.c       |  43 +-
 drivers/hwtracing/coresight/coresight-catu.h       |   1 -
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |   3 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |  65 +-
 drivers/hwtracing/coresight/coresight-etm.h        |   6 +-
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    |  12 +-
 drivers/hwtracing/coresight/coresight-etm3x.c      |  45 +-
 drivers/hwtracing/coresight/coresight-etm4x.c      |  36 +-
 drivers/hwtracing/coresight/coresight-etm4x.h      |   2 -
 drivers/hwtracing/coresight/coresight-funnel.c     |  27 +-
 drivers/hwtracing/coresight/coresight-platform.c   | 740 +++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-priv.h       |   3 +
 drivers/hwtracing/coresight/coresight-replicator.c |  37 +-
 drivers/hwtracing/coresight/coresight-stm.c        | 110 ++-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |   9 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |  44 +-
 drivers/hwtracing/coresight/coresight-tmc.c        | 100 +--
 drivers/hwtracing/coresight/coresight-tmc.h        |   1 -
 drivers/hwtracing/coresight/coresight-tpiu.c       |  30 +-
 drivers/hwtracing/coresight/coresight.c            | 291 ++++++--
 drivers/hwtracing/coresight/of_coresight.c         | 297 ---------
 include/linux/coresight.h                          |  65 +-
 include/linux/property.h                           |   1 +
 27 files changed, 1378 insertions(+), 613 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-platform.c
 delete mode 100644 drivers/hwtracing/coresight/of_coresight.c



ACPI bindings for Juno-r0 (applies on [2] above)

Suzuki K Poulose (1):
  edk2-platform: juno: Update ACPI CoreSight Bindings

 Platform/ARM/JunoPkg/AcpiTables/Dsdt.asl | 241 +++++++++++++++++++++++++++++++
 1 file changed, 241 insertions(+)

-- 
2.7.4
