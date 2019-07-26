Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D062C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 22:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F33218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 22:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="m+fsM1k5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfGZWyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 18:54:00 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34640 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbfGZWyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 18:54:00 -0400
Received: by mail-ot1-f67.google.com with SMTP id n5so56954932otk.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 15:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9yHKSH2nyrMOIGNyd4CyMcnUdirfGb0YWEy2r0HnXdM=;
        b=m+fsM1k54XE4l7Y52Rhdx4f6VkwEeRHjELBA+I2opnzo8BChnkBi+nWCp1/u+0Zzq6
         ZvAue14znBPJb5hRMhgpvnah1jfLjorbivaiwWENClta8GSdohIK26jSG0LeaxCoyTbn
         I+I+bwIxe7kgCCti111wRuoG3MqDY5six9EKOl7pu0y9+pLG3g53Ew4MhVOADh65+/bB
         l3quZNvoqrVfTNtnOeIpMDAm2BQpee37zNSDx4caUe8n4X9Ah2NDfwxvh/IL0YTkBaAX
         8KXqUQtQ8DEh6jkKXms/C83uYNLukuZb4fctkwhO2GyNZfajirB5HJZFAMChPsZcF/Al
         qlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9yHKSH2nyrMOIGNyd4CyMcnUdirfGb0YWEy2r0HnXdM=;
        b=j9L61UAGsUyfGlSx0VJpCreIErnH/xHFEzwxq1W0njxGCmnMJsckqHibym3Bh1bq8E
         NWPEdbh2kewHJdMawlpzKnaAeMK3UQVOKUb+VL+1kkfTmGSca07JmeBoyLqxOk+k2Sru
         jykY6j1sEsxDzXfy7xW18cuwvGb7xlFBkMsIOBh7/tThjhSpi9GZoKZpm8xOZWEaDtdY
         8K4yoEjorPd+IkDz9Ym/xWOu094KQZoPZQQJF1wQGikQXuIChNCiBXR19G5+ob8A4a5B
         KpV32ri6dKf3IgNx0ZcuFZyo9wxPlFsUVjoM1OOouDVq7caeL3bs8k6nO2mOlTZr+JLb
         BkDA==
X-Gm-Message-State: APjAAAX3PvOXo4UAlI4UfrqbfUrzw6e+JHwPSwiS7iYD9FtSy//Mjtck
        SoVMy40V8LxMDH/+HEQLA5j2K9yFvrfs75i9LtvnfpZ2hKI=
X-Google-Smtp-Source: APXvYqz4Uvodp449SpQfppdw+t/cXgvDGwkwTvwh7UY4Ms1pF+6kuQ9VjwgbAYP1RwIe4MoqUCAC2Qf4MJiEBRYC6Kw=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr65596750otn.71.1564181639248;
 Fri, 26 Jul 2019 15:53:59 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 26 Jul 2019 15:53:47 -0700
Message-ID: <CAPcyv4gqE6zOoSibTgjbWWHE3VVQ0wSJN-NxwF288nTe2Z3yzA@mail.gmail.com>
Subject: [GIT PULL] libnvdimm fixes for 5.3-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.3-rc2

...to receive a collection of locking and async operations fixes for
v5.3-rc2. These had been soaking in a branch targeting the merge
window, but missed due to a regression hunt. This fixed up version has
otherwise been in -next this past week with no reported issues.

In order to gain confidence in the locking changes the pull also
includes a debug / instrumentation patch to enable lockdep coverage
for libnvdimm subsystem operations that depend on the device_lock for
exclusion. As mentioned in the changelog it is a hack, but it works
and documents the locking expectations of the sub-system in a way that
others can use lockdep to verify. The driver core touches got an ack
from Greg.

Please pull, but I'll understand if you want a resend with the debug
patch dropped.

---

The following changes since commit d1fdb6d8f6a4109a4263176c84b899076a5f8008:

  Linux 5.2-rc4 (2019-06-08 20:24:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.3-rc2

for you to fetch changes up to 87a30e1f05d73a34e6d1895065541369131aaf1c:

  driver-core, libnvdimm: Let device subsystems add local lockdep
coverage (2019-07-18 16:23:27 -0700)

----------------------------------------------------------------
libnvdimm fixes v5.3-rc2

- Fix duplicate device_unregister() calls (multiple threads competing to
  do unregister work when scheduling device removal from a sysfs attribute
  of the self-same device).

- Fix badblocks registration order bug. Ensure region badblocks are
  initialized in advance of namespace registration.

- Fix a deadlock between the bus lock and probe operations.

- Export device-core infrastructure to coordinate async operations via
  the device ->dead state.

- Add device-core infrastructure to validate device_lock() usage with
  lockdep.

----------------------------------------------------------------
Dan Williams (7):
      drivers/base: Introduce kill_device()
      libnvdimm/bus: Prevent duplicate device_unregister() calls
      libnvdimm/region: Register badblocks before namespaces
      libnvdimm/bus: Prepare the nd_ioctl() path to be re-entrant
      libnvdimm/bus: Stop holding nvdimm_bus_list_mutex over __nd_ioctl()
      libnvdimm/bus: Fix wait_nvdimm_bus_probe_idle() ABBA deadlock
      driver-core, libnvdimm: Let device subsystems add local lockdep coverage

 drivers/acpi/nfit/core.c        |  28 +++---
 drivers/acpi/nfit/nfit.h        |  24 +++++
 drivers/base/core.c             |  30 ++++--
 drivers/nvdimm/btt_devs.c       |  16 +--
 drivers/nvdimm/bus.c            | 210 ++++++++++++++++++++++++++--------------
 drivers/nvdimm/core.c           |  10 +-
 drivers/nvdimm/dimm_devs.c      |   4 +-
 drivers/nvdimm/namespace_devs.c |  36 +++----
 drivers/nvdimm/nd-core.h        |  71 +++++++++++++-
 drivers/nvdimm/pfn_devs.c       |  24 ++---
 drivers/nvdimm/pmem.c           |   4 +-
 drivers/nvdimm/region.c         |  24 ++---
 drivers/nvdimm/region_devs.c    |  12 ++-
 drivers/nvdimm/region.c         |  24 ++---
 drivers/nvdimm/region_devs.c    |  12 ++-
 include/linux/device.h          |   6 ++
 14 files changed, 343 insertions(+), 156 deletions(-)
