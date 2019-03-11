Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EEDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CED02075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfCKJj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:39:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:53362 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727026AbfCKJjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:39:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E42C0AC3F;
        Mon, 11 Mar 2019 09:39:53 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fixes and features for 5.1-rc1
Date:   Mon, 11 Mar 2019 10:39:51 +0100
Message-Id: <20190311093951.18085-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.1a-rc1-tag

xen: fixes and features for 5.1-rc1

It contains the following patches:

- a remove of fallback code for very old Xen hypervisors
- 3 patches for fixing Xen dom0 boot regressions
- an old patch for Xen PCI passthrough which was never applied for
  unknown reasons
- some more minor fixes and cleanup patches

Thanks.

Juergen

 arch/x86/include/asm/xen/hypercall.h  | 13 +-----
 arch/x86/kernel/e820.c                |  5 +++
 arch/x86/xen/mmu_pv.c                 | 13 +++---
 arch/x86/xen/setup.c                  | 13 ++++++
 drivers/xen/Makefile                  |  1 -
 drivers/xen/cpu_hotplug.c             |  2 +-
 drivers/xen/fallback.c                | 81 -----------------------------------
 drivers/xen/gntdev-dmabuf.c           | 21 ++++++++-
 drivers/xen/gntdev-dmabuf.h           |  2 +-
 drivers/xen/gntdev.c                  |  2 +-
 drivers/xen/xen-acpi-processor.c      | 22 +++++-----
 drivers/xen/xen-balloon.c             | 11 +++++
 drivers/xen/xen-pciback/pciback_ops.c |  2 -
 drivers/xen/xen-pciback/xenbus.c      |  2 +-
 drivers/xen/xen-scsiback.c            |  2 +-
 include/linux/memory_hotplug.h        |  2 +
 include/xen/xen.h                     |  4 ++
 mm/memory_hotplug.c                   |  6 +++
 18 files changed, 85 insertions(+), 119 deletions(-)

Andy Shevchenko (1):
      xen/ACPI: Switch to bitmap_zalloc()

Arnd Bergmann (1):
      xen: remove pre-xen3 fallback handlers

Dan Carpenter (1):
      xen, cpu_hotplug: Prevent an out of bounds access

Gustavo A. R. Silva (2):
      xen: mark expected switch fall-through
      xen-scsiback: mark expected switch fall-through

Juergen Gross (3):
      x86: respect memory size limiting via mem= parameter
      x86/xen: dont add memory above max allowed allocation
      xen: fix dom0 boot on huge systems

Konrad Rzeszutek Wilk (1):
      xen/pciback: Don't disable PCI_COMMAND on PCI device reset.

Oleksandr Andrushchenko (2):
      xen/gntdev: Do not destroy context while dma-bufs are in use
      xen/gntdev: Check and release imported dma-bufs on close
