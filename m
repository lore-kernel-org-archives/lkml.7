Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51265C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275CA218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfCVXUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 19:20:45 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:56781 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726023AbfCVXUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 19:20:44 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 23 Mar 2019 01:20:39 +0200
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x2MNKavw007896;
        Sat, 23 Mar 2019 01:20:37 +0200
From:   Parav Pandit <parav@mellanox.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kwankhede@nvidia.com, alex.williamson@redhat.com
Cc:     parav@mellanox.com
Subject: [PATCH 0/8] vfio/mdev: Improve vfio/mdev core module
Date:   Fri, 22 Mar 2019 18:20:27 -0500
Message-Id: <1553296835-37522-1-git-send-email-parav@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we would like to use mdev subsystem for wider use case as
discussed in [1], [2] apart from an offline discussion.
This use case is also discussed with wider forum in [4] in track
'Lightweight NIC HW functions for container offload use cases'.

This series is prep-work and improves vfio/mdev module in following ways.

Patch-1 and 2 Fixes releasing parent dev reference during error unwinding
of mdev create and mdev parent registration.
Patch-3 Simplifies mdev device for unused kref.
Patch-4 Drops redundant extern prefix of exported symbols.
Patch-5 Returns right error code from vendor driver.
Patch-6 Fixes to use right sysfs remove sequence.
Patch-7 Fixes removing all child devices if one of them fails.
Patch 8 Brings improvements to mdev in following ways.

1. Fix race conditions among mdev parent's create(), remove() and
mdev parent unregistration routines that leads to call traces.

2. Setup vendor mdev device before placing the device on mdev bus.
This ensures that vfio_mdev or any other module that accesses mdev,
is rightly in any of the callbacks of mdev_register_driver().
This follows Linux driver model now.
Similarly follow exact reverse remove sequence, i.e. to take away the
device first from the bus before removing underlying hardware mdev.

This series is tested using
(a) mtty with VM using vfio_mdev driver for positive tests.
(b) mtty with vfio_mdev with error race condition cases of create,
remove and mtty driver.
(c) mlx5 core driver using RFC patches [3] and internal patches.
Internal patches are large and cannot be combined with this
prep-work patches. It will posted once prep-work completes.

[1] https://www.spinics.net/lists/netdev/msg556978.html
[2] https://lkml.org/lkml/2019/3/7/696
[3] https://lkml.org/lkml/2019/3/8/819
[4] https://netdevconf.org/0x13/session.html?workshop-hardware-offload


Parav Pandit (8):
  vfio/mdev: Fix to not do put_device on device_register failure
  vfio/mdev: Avoid release parent reference during error path
  vfio/mdev: Removed unused kref
  vfio/mdev: Drop redundant extern for exported symbols
  vfio/mdev: Avoid masking error code to EBUSY
  vfio/mdev: Follow correct remove sequence
  vfio/mdev: Fix aborting mdev child device removal if one fails
  vfio/mdev: Improve the create/remove sequence

 drivers/vfio/mdev/mdev_core.c    | 164 +++++++++++++++++++--------------------
 drivers/vfio/mdev/mdev_private.h |   8 +-
 drivers/vfio/mdev/mdev_sysfs.c   |   8 +-
 include/linux/mdev.h             |  21 +++--
 4 files changed, 98 insertions(+), 103 deletions(-)

-- 
1.8.3.1

