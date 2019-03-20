Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E05EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114352146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfCTSuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:50:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44764 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbfCTSuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:50:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1C96A78;
        Wed, 20 Mar 2019 11:50:03 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 771EB3F59C;
        Wed, 20 Mar 2019 11:50:02 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        robert.walker@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 00/25] coresight: Support for ACPI bindings
Date:   Wed, 20 Mar 2019 18:49:17 +0000
Message-Id: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
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

As a prepartion for the ACPI support, we merge the driver for dynamic
and non-programmable replicators. We introduce platform independent
helpers to parse the platform supplied information. Thus we rename
the platform handling code from:
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

Applies on v5.1-rc1

Tested on a Juno-r0 board with ACPI bindings patch (Patch 26/25) added on
top of [2]. You would need to make sure that the debug power domain is
turned on before the Linux kernel boots. (e.g, connect the DS-5 to the
Juno board while at UEFI). arm32 code is only compile tested.

[0] ACPI Device Graphs using _DSD (Not available online yet, approved but
    awaiting publish and eventually should be linked at).
    https://uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel-1_1.htm
[1] https://developer.arm.com/docs/den0067/latest/acpi-for-coresighttm-10-platform-design-document
[2] https://github.com/tianocore/edk2-platforms.git

Suzuki K Poulose (25):
  coresight: tmc: Report DMA setup failures
  coresight: dynamic-replicator: Clean up error handling
  coresight: replicator: Prepare for merging with dynamic-replicator
  coresight: dynamic-replicator: Prepare for merging with static
    replicator
  coresight: Merge the static and dynamic replicator drivers
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
  coresight: Introduce generic platform data helper
  coresight: Make device to CPU mapping generic
  coresight: platform: Use fwnode handle for device search
  coresight: Use fwnode handle instead of device names
  coresight: Use platform agnostic names
  coresight: stm: ACPI support for parsing stimulus base
  coresight: Support for ACPI bindings
  coresight: acpi: Support for components

 drivers/acpi/acpi_amba.c                           |   9 +
 drivers/hwtracing/coresight/Kconfig                |   8 -
 drivers/hwtracing/coresight/Makefile               |   4 +-
 drivers/hwtracing/coresight/coresight-catu.c       |  38 +-
 drivers/hwtracing/coresight/coresight-catu.h       |   1 -
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |   3 +-
 .../coresight/coresight-dynamic-replicator.c       | 255 --------
 drivers/hwtracing/coresight/coresight-etb10.c      |  23 +-
 drivers/hwtracing/coresight/coresight-etm3x.c      |  23 +-
 drivers/hwtracing/coresight/coresight-etm4x.c      |  19 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |  27 +-
 drivers/hwtracing/coresight/coresight-platform.c   | 723 +++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-priv.h       |   2 +
 drivers/hwtracing/coresight/coresight-replicator.c | 255 ++++++--
 drivers/hwtracing/coresight/coresight-stm.c        | 119 +++-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |  26 +-
 drivers/hwtracing/coresight/coresight-tmc.c        |  71 +-
 drivers/hwtracing/coresight/coresight-tpiu.c       |  29 +-
 drivers/hwtracing/coresight/coresight.c            |  77 ++-
 drivers/hwtracing/coresight/of_coresight.c         | 297 ---------
 include/linux/coresight.h                          |  43 +-
 21 files changed, 1287 insertions(+), 765 deletions(-)
 delete mode 100644 drivers/hwtracing/coresight/coresight-dynamic-replicator.c
 create mode 100644 drivers/hwtracing/coresight/coresight-platform.c
 delete mode 100644 drivers/hwtracing/coresight/of_coresight.c

ACPI bindings for Juno-r0 (applies on [2] above)

Suzuki K Poulose (1):
  edk2-platform: juno: Update ACPI CoreSight Bindings

 Platform/ARM/JunoPkg/AcpiTables/Dsdt.asl | 241 +++++++++++++++++++++++++++++++
 1 file changed, 241 insertions(+)

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

-- 
2.7.4
