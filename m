Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E387FC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D6E21783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 14:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="W8sPtuhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390601AbfGROQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 10:16:54 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36403 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390457AbfGROQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:16:54 -0400
Received: by mail-ot1-f68.google.com with SMTP id r6so29183558oti.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 07:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=RwpnZ/oYArVLKO1FOa0zkV+rIVwJ+6+HIwfsxFdupWs=;
        b=W8sPtuhs0XYA3yVl25QJblCCOLf59FqZ8LL+DoHIc0yvkazbLQZCN3mIP185ktOrtw
         RrZvReTlY2b2kXUGci9xvRh2Sw8VSICp7oKsf2MsCvQ46r47Wd9eyksSn2VoUw1wkqea
         VQG6gNCEh15o0VRH9XrQmpdItVep31fMjxygzk0q14RO8+z4SktKfgNofQlV6VwTVgK4
         5BSaBazfdkk3uZj+LirLot8dfN71GXNgsVgiwvwwvbc8NeMmo1eeP9Rp0u0RrSMqxfQI
         Ce/qPBM9C2bAK7YJ9UZqHSH6VO8AC5PS+AJUBR3LV8Y76Pxv6o89epff2ihtDTv5HWFd
         Ywow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=RwpnZ/oYArVLKO1FOa0zkV+rIVwJ+6+HIwfsxFdupWs=;
        b=KVsKNiz/XaZYqRtseHDPk2GjoIJniwq0l7ocx+Bty5nq24GlLj7o5CL8gPaLdQwOY3
         2eHAx4V1FZXknS05hRSSTqtyLFzRlyt0EcDGpnHSNOA6TIF2mJLQ2j7Jvr+XitSET+6i
         5A1oO7k2yp6MSR+XGCgoFRlA2kUbkprf2fj+Ao9km2rQU/j2/BPFOirbbngE1l1jpJWs
         BvP+bPETVrQFVGXmScdF/o5RbFvCaUwpNxtYRW2E49zBip7raf+Pp1EQ22sLwUJoOlxY
         sMbeDwGgUvtSGSCVYhCsY24XVd50vre1HZFbko/CveBEo8150ncGfFQNNqe3dU2Ugg3L
         rwTA==
X-Gm-Message-State: APjAAAW9uU2JQd1eeghpmDgj45oi4F6ricKH1qA3rg1Dsz/4byUz41Q+
        f0usOVlpQwsQlWmJzl2obpqcVKB5bICrJUQhuYTdow==
X-Google-Smtp-Source: APXvYqyoP5GJxKjG9yqXUy0a6+m6CJdrkTAwTJlxCLi1DF02tSRMO8QPtauzgaksegMMK6qPttHmI7N0dt209RrVo3c=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr33844897otf.126.1563459412721;
 Thu, 18 Jul 2019 07:16:52 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 18 Jul 2019 07:16:41 -0700
Message-ID: <CAPcyv4ji_0CqmeO2hh1ERvUnVJZkFcuj+=QQ3mrSx13y3uSHoQ@mail.gmail.com>
Subject: [GIT PULL] libnvdimm for 5.3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pankaj Gupta <pagupta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.3

...to receive primarily just the virtio_pmem driver for v5.3-rc1. The
lateness is attributed to me being out last week, and a last minute
regression hunt in a pending fix / rework of libnvdimm locking. Those
fixes can wait to post-rc1.

These commits have been in multiple -next releases, and uncovered a
late sparse fixup that is appended. The touches to ext4 and xfs have
received acks. Ted's ack is here [1], it arrived after I cut the
branch. Mike reviewed the device-mapper touches.

[1]: https://lore.kernel.org/lkml/20190707163415.GA19775@mit.edu/

---

The following changes since commit 9e0babf2c06c73cda2c0cd37a1653d823adb40ec:

  Linux 5.2-rc5 (2019-06-16 08:49:45 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.3

for you to fetch changes up to 8c2e408e73f735d2e6e8b43f9b038c9abb082939:

  virtio_pmem: fix sparse warning (2019-07-16 19:44:26 -0700)

----------------------------------------------------------------
- virtio_pmem: The new virtio_pmem facility introduces a paravirtualized
  persistent memory device that allows a guest VM to use DAX mechanisms to
  access a host-file with host-page-cache. It arranges for MAP_SYNC to
  be disabled and instead triggers a host fsync() when a 'write-cache
  flush' command is sent to the virtual disk device.

- Miscellaneous small fixups.

----------------------------------------------------------------
Andy Shevchenko (1):
      libnvdimm, namespace: Drop uuid_t implementation detail

Pankaj Gupta (8):
      libnvdimm: nd_region flush callback support
      virtio-pmem: Add virtio pmem driver
      libnvdimm: add dax_dev sync flag
      dm: enable synchronous dax
      dax: check synchronous mapping is supported
      ext4: disable map_sync for async flush
      xfs: disable map_sync for async flush
      virtio_pmem: fix sparse warning

 drivers/acpi/nfit/core.c         |   4 +-
 drivers/dax/bus.c                |   2 +-
 drivers/dax/super.c              |  19 +++++-
 drivers/md/dm-table.c            |  24 ++++++--
 drivers/md/dm.c                  |   5 +-
 drivers/md/dm.h                  |   5 +-
 drivers/nvdimm/Makefile          |   1 +
 drivers/nvdimm/claim.c           |   6 +-
 drivers/nvdimm/namespace_devs.c  |   8 +--
 drivers/nvdimm/nd.h              |   1 +
 drivers/nvdimm/nd_virtio.c       | 125 +++++++++++++++++++++++++++++++++++++++
 drivers/nvdimm/pmem.c            |  18 ++++--
 drivers/nvdimm/region_devs.c     |  33 ++++++++++-
 drivers/nvdimm/virtio_pmem.c     | 122 ++++++++++++++++++++++++++++++++++++++
 drivers/nvdimm/virtio_pmem.h     |  55 +++++++++++++++++
 drivers/s390/block/dcssblk.c     |   2 +-
 drivers/virtio/Kconfig           |  11 ++++
 fs/ext4/file.c                   |  10 ++--
 fs/xfs/xfs_file.c                |   9 ++-
 include/linux/dax.h              |  41 ++++++++++++-
 include/linux/libnvdimm.h        |  10 +++-
 include/uapi/linux/virtio_ids.h  |   1 +
 include/uapi/linux/virtio_pmem.h |  34 +++++++++++
 23 files changed, 508 insertions(+), 38 deletions(-)
 create mode 100644 drivers/nvdimm/nd_virtio.c
 create mode 100644 drivers/nvdimm/virtio_pmem.c
 create mode 100644 drivers/nvdimm/virtio_pmem.h
 create mode 100644 include/uapi/linux/virtio_pmem.h
