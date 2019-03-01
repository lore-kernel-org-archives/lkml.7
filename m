Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79469C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC7C2186A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfCAFgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:36:21 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42558 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726036AbfCAFgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 00:36:21 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 1 Mar 2019 07:36:14 +0200
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x215aAAo010150;
        Fri, 1 Mar 2019 07:36:11 +0200
From:   Parav Pandit <parav@mellanox.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.lkml@markovi.net, davem@davemloft.net,
        gregkh@linuxfoundation.org, jiri@mellanox.com
Cc:     parav@mellanox.com
Subject: [PATCH net-next 0/8] Introducing subdev bus and devlink extension
Date:   Thu, 28 Feb 2019 23:35:39 -0600
Message-Id: <1551418547-12736-1-git-send-email-parav@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use case:
---------
A user wants to create/delete hardware linked sub devices without
using SR-IOV.
These devices for a pci device can be netdev (optional rdma device)
or other devices. Such sub devices share some of the PCI device
resources and also have their own dedicated resources.

Few examples are:
1. netdev having its own txq(s), rq(s) and/or hw offload parameters.
2. netdev with switchdev mode using netdev representor
3. rdma device with IB link layer and IPoIB netdev
4. rdma/RoCE device and a netdev
5. rdma device with multiple ports

Requirements for above use cases:
--------------------------------
1. We need a generic user interface & core APIs to create sub devices
from a parent pci device but should be generic enough for other parent
devices
2. Interface should be vendor agnostic
3. User should be able to set device params at creation time
4. In future if needed, tool should be able to create passthrough
device to map to a virtual machine
5. A device can have multiple ports
6. An orchestration software wants to know how many such sub devices
can be created from a parent device so that it can manage them in global
cluster resources.

So how is it done?
------------------
(a) user in control
To address above requirements, a generic tool iproute2/devlink is
extended for sub device's life cycle.
However a devlink tool and its kernel counter part is not sufficient
to create protocol agnostic devices on a existing PCI bus.

(b) subdev bus
A given bus defines well defined addressing scheme. Creating sub devices
on existing PCI bus with a different naming scheme is just weird.
So, creating well named devices on appropriate bus is desired.

Hence a new 'subdev' bus is created.
User adds/removes new sub devices subdev on this bus via a devlink tool.
devlink tool instructs hardware driver to create/remove/configure
such devices. Hardware vendor driver places devices on the bus.
Another or same vendor driver matches based on vendor-id, device-id
scheme and run through classic device driver model.

Given that, these are user created devices for a given hardware and in
absence of a central entity like PCISIG to assign vendor and device ids,
A unique vendor and device id are maintained as enum in
include/linux/subdev_ids.h.

subdev bus device names follow default device naming scheme of Linux
kernel. It is done as 'subdev<instance_id>' such as, subdev0, subdev3.

subdev device inherits its parent's DMA parameters.
subdev will follow rich power management infrastructure of core kernel/
So that every vendor driver doesn't have to iterate over its child
devices, invent a locking and device anchoring scheme.

Patchset summary:
-----------------
Patch-1, 2 introduces a subdev bus and interface for subdev life cycle.
Patch-3 extends modpost tool for module device id table.
Patch-4,5,6 implements a devlink vendor driver to add/remove devices.
Patch-7 mlx5 driver implements subdev devices and places them on subdev
bus. 
Patch-8 match against the subdev for mlx5 vendor, device id and creates
fake netdevice.

All patches are only a reference implementation to see RFC in works
at devlink, sysfs and device model level. Once RFC looks good, more
solid upstreamable version of the implementation will be done.
All patches are functional except the last two patches, which just
create fake subdev devices and fake netdevice.

System example view:
--------------------

$ devlink dev show
pci/0000:05:00.0

$ devlink dev add pci/0000:05:00.0
$ devlink dev show
pci/0000:05:00.0
subdev/subdev0

sysfs view with subdev:

$ ls -l /sys/bus/pci/devices/0000:05:00.0
[..]
drwxr-xr-x 3 root root        0 Feb 13 15:57 infiniband
-rw-r--r-- 1 root root     4096 Feb 13 15:57 msi_bus
drwxr-xr-x 3 root root        0 Feb 13 15:57 net
drwxr-xr-x 2 root root        0 Feb 13 15:57 power
drwxr-xr-x 3 root root        0 Feb 13 15:57 ptp
drwxr-xr-x 4 root root        0 Feb 13 15:57 subdev0

$ ls -l /sys/bus/pci/devices/0000:05:00.0/subdev0
lrwxrwxrwx 1 root root    0 Feb 13 15:58 driver -> ../../../../../bus/subdev/drivers/mlx5_core
drwxr-xr-x 3 root root    0 Feb 13 15:58 net
drwxr-xr-x 2 root root    0 Feb 13 15:58 power
lrwxrwxrwx 1 root root    0 Feb 13 15:58 subsystem -> ../../../../../bus/subdev
-rw-r--r-- 1 root root 4096 Feb 13 15:58 uevent

$ ls -l /sys/bus/pci/devices/0000:05:00.0/subdev0/net/
drwxr-xr-x 5 root root 0 Feb 13 15:58 eth0

Software view:
-------------
Some of you if you prefer to see in picture, below diagram tries to
show software modules in bus/device hierarchy.

devlink user (iproute2/devlink)
------------------------------
         |
         |
  +----------------+
  | devlink module |
  |         doit() |     +------------------+
  |            |   |     |   vendor driver  |
  +------------|---+     |   (mlx5)         |
               ----------+-> subdev_ops()   |
                         +|-----------------+
                          |
                +---------|--+  +-----------+  +------------------+
                | subdev bus |  | core      |  | subdev device    |
                | driver     |  | kernel    |  | drivers          |
                | (add/del)  |  | dev model |  | (netdev, rdma)   |
                |       ----------------------> probe/remove()    |
                +------------+  +-----------+  +------------------+

Alternatives considered:
------------------------
Will discuss separately if needed to keep this RFC short.

Parav Pandit (8):
  subdev: Introducing subdev bus
  subdev: Introduce pm callbacks
  modpost: Add support for subdev device id table
  devlink: Introduce and use devlink_init/cleanup() in alloc/free
  devlink: Add variant of devlink_register/unregister
  devlink: Add support for devlink subdev lifecycle
  net/mlx5: Add devlink subdev life cycle command support
  net/mlx5: Add subdev driver to bind to subdev devices

 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  12 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |   7 +
 drivers/net/ethernet/mellanox/mlx5/core/subdev.c   |  55 ++++++
 .../ethernet/mellanox/mlx5/core/subdev_driver.c    |  93 +++++++++
 drivers/subdev/Kconfig                             |  12 ++
 drivers/subdev/Makefile                            |   8 +
 drivers/subdev/subdev_main.c                       | 212 +++++++++++++++++++++
 include/linux/mod_devicetable.h                    |  12 ++
 include/linux/subdev_bus.h                         |  63 ++++++
 include/linux/subdev_ids.h                         |  17 ++
 include/net/devlink.h                              |  29 ++-
 include/uapi/linux/devlink.h                       |   3 +
 net/core/devlink.c                                 | 179 +++++++++++++++--
 scripts/mod/devicetable-offsets.c                  |   4 +
 scripts/mod/file2alias.c                           |  15 ++
 18 files changed, 704 insertions(+), 21 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/subdev.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/subdev_driver.c
 create mode 100644 drivers/subdev/Kconfig
 create mode 100644 drivers/subdev/Makefile
 create mode 100644 drivers/subdev/subdev_main.c
 create mode 100644 include/linux/subdev_bus.h
 create mode 100644 include/linux/subdev_ids.h

-- 
1.8.3.1

