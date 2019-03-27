Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95873C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 03:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66BB2208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 03:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732956AbfC0Dpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 23:45:52 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:40482 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732884AbfC0Dpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 23:45:51 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 27 Mar 2019 05:45:49 +0200
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x2R3jlG4031531;
        Wed, 27 Mar 2019 05:45:47 +0200
From:   Parav Pandit <parav@mellanox.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kwankhede@nvidia.com, alex.williamson@redhat.com
Cc:     cjia@nvidia.com, parav@mellanox.com
Subject: [PATCHv1 0/7] vfio/mdev: Improve vfio/mdev core module
Date:   Tue, 26 Mar 2019 22:45:38 -0500
Message-Id: <1553658345-43995-1-git-send-email-parav@mellanox.com>
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

Patch-1 Fixes releasing parent dev reference during error unwinding
mdev parent registration.
Patch-2 Simplifies mdev device for unused kref.
Patch-3 Drops redundant extern prefix of exported symbols.
Patch-4 Returns right error code from vendor driver.
Patch-5 Fixes to use right sysfs remove sequence.
Patch-6 Fixes removing all child devices if one of them fails.
Patch-7 Fixes conditions with mdev device life cycle APIs

This series is tested using
(a) mtty with VM using vfio_mdev driver for positive tests.
(b) mtty with vfio_mdev with error race condition cases of create,
remove and unloading of mtty driver.
(c) mlx5 core driver using RFC patches [3] and internal patches.
Internal patches are large and cannot be combined with this
prep-work patches. It will posted once prep-work completes.

[1] https://www.spinics.net/lists/netdev/msg556978.html
[2] https://lkml.org/lkml/2019/3/7/696
[3] https://lkml.org/lkml/2019/3/8/819
[4] https://netdevconf.org/0x13/session.html?workshop-hardware-offload

---
Changelog:
---

v0->v1:
 - Dropped device placement on bus sequence patch for this series
 - Addressed below comments from Alex, Kirti, Maxim.
 - Added Review-by tag for already reviewed patches.
 - Dropped incorrect patch of put_device().
 - Corrected Fixes commit tag for sysfs remove sequence fix
 - Split last 8th patch to smaller refactor and fixes patch
 - Following coding style commenting format
 - Fixed accidental delete of mutex_lock in mdev_unregister_device
 - Renamed remove helped to mdev_device_remove_common().
 - Rebased for uuid/guid change


Parav Pandit (7):
  vfio/mdev: Avoid release parent reference during error path
  vfio/mdev: Removed unused kref
  vfio/mdev: Drop redundant extern for exported symbols
  vfio/mdev: Avoid masking error code to EBUSY
  vfio/mdev: Follow correct remove sequence
  vfio/mdev: Fix aborting mdev child device removal if one fails
  vfio/mdev: Fix race conditions with mdev device life cycle APIs

 drivers/vfio/mdev/mdev_core.c    | 102 ++++++++++++++++++++++++++++-----------
 drivers/vfio/mdev/mdev_private.h |   7 ++-
 drivers/vfio/mdev/mdev_sysfs.c   |   2 +-
 include/linux/mdev.h             |  21 ++++----
 4 files changed, 91 insertions(+), 41 deletions(-)

-- 
1.8.3.1

