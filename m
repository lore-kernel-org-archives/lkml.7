Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4CDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22A02147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="pDKoSqgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfCKVy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:54:59 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40960 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfCKVy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:54:59 -0400
Received: by mail-oi1-f195.google.com with SMTP id e7so385200oia.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 14:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=prLvtdgijDE7anHBdKpQSgXUM//Li7bfJi+Sflxhf98=;
        b=pDKoSqgcYHfaqF6LH4VphTgdj8ZPG+XwOfFj1rn/XQRZ9AvwDgw5qBbOv1FMbmTa9d
         tFJxd3b6tO404mgSj1Qix3gJtqXkfXvbJuE2xkBQ9mVDOuaPZbSi3RCf0gvwos9feout
         BVrc+pU+XNKGCQQfnwV7SKsqHGTM2Z8GAAbs0P7BNqRtEUuJSVZ9Iub1HkN79ZeaXsdS
         qW4My2so8FbBxZ7tY2z2p2gVI1G9u1p6vHZyatf381VZr3GCL2t5rlZwbvuxQu+iA2Xx
         ebF+SYWo2yAwxfnLDX7oDPEMSospg+rzQa8vq4Gw+xFluLmGgHEXrc1qNKtdvca1VX8Z
         RCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=prLvtdgijDE7anHBdKpQSgXUM//Li7bfJi+Sflxhf98=;
        b=mZLw7zYezt9LzZUNqLAH7ip4LyY420BdasNYcR19bqMuZ4bnQTc0+5DnIOKyP14hw4
         hSm2H0oKxzsU9ZSbiw0IX1I4AJtOFgyW0+ebHjX5BGHaUpvwkUb0aSoyEIMmrmhUkofq
         WgIKnchm4yM7MvtUHYCDAR7pcFbNasuDkqhCPKoOc0iJQgWI3XmMNF6HS53zLqOwJC/L
         I1b0blfJJIVS9BJkNNEk+0O2G43b4J91YNIZUpExKEWNFzn/YExK4KOryHcYLQ9498DH
         LVRp5tLcYPxPpXoEg/sQP0WdeiQS9XgQqsr0KZ+2eRM+0ZWGEBorfWYYatSfPG1UKHC4
         tGUg==
X-Gm-Message-State: APjAAAW+uhCBY5AAvy+qD2Y1Jqv1sWLlhLK8dXIRvaGmBAjmjERq1+xj
        DJovpwG3WVnf1caEYpft3ATCyTeJfI8PtnubJlDQlBbfmxk=
X-Google-Smtp-Source: APXvYqybMup1Xj4IUj0ZrDKdvKAhJ3GhVMtlYSYCh1m3w7wt6ohqodlIIv5Sj3othwt8S8k0r37EH0iyXNM+/N6FlY4=
X-Received: by 2002:aca:cc0f:: with SMTP id c15mr265421oig.105.1552341298046;
 Mon, 11 Mar 2019 14:54:58 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 11 Mar 2019 14:54:47 -0700
Message-ID: <CAPcyv4hPv7b1FWUxuDvcx8+kFWh7Npgk92P+SEpSPWvT2cxheg@mail.gmail.com>
Subject: [GIT PULL] libnvdimm updates for 5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.1

...to receive the general libnvdimm update for 5.1, while I track down
a response on the issue highlighted "PMEM as RAM" pull request.

The bulk of this has been in -next since before the merge window
opened, with no known collisions / issues reported. The only detail
worth noting, outside the tag message, is that the
"libnvdimm-start-pad" topic has been truncated to just cleanups and
small fixes. The full topic branch would have doubled down on hacks
around the "section alignment" limitation of the core-mm, instead
effort is now being spent to address that root issue in the memory
hotplug implementation for v5.2. I'll note, since I messed this up in
the past, the topic-branch merges have summary messages as to why the
merge was made.

---

The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.1

for you to fetch changes up to 4083014e32699af04a8e6eaa4855b08dba36a47a:

  Merge branch 'for-5.1/nfit/ars' into libnvdimm-for-next (2019-03-11
12:37:55 -0700)

----------------------------------------------------------------
libnvdimm for v5.1

* Fix nfit-bus command submission regression

* Support retrieval of short-ARS results if the ARS state is "requires
  continuation", and even if the "no_init_ars" module parameter is
  specified.

* Allow busy-polling of the kernel ARS state by allowing root to reset
  the exponential back-off timer.

* Filter potentially stale ARS results by tracking query-ARS relative to
  the previous start-ARS.

* Enhance dax_device alignment checks

* Add support for the Hyper-V family of device-specific-methods (DSMs)

* Add several fixes and workarounds for Hyper-V compatibility.

* Fix support to cache the dirty-shutdown-count at init.

----------------------------------------------------------------
Dan Williams (20):
      libnvdimm/label: Clear 'updating' flag after label-set update
      nfit: Fix nfit_intel_shutdown_status() command submission
      MAINTAINERS: Update filesystem-dax and NVDIMM entries
      libnvdimm/dimm: Add a no-BLK quirk based on NVDIMM family
      acpi/nfit: Fix bus command validation
      libnvdimm/pfn: Account for PAGE_SIZE > info-block-size in nd_pfn_init()
      libnvdimm/pmem: Honor force_raw for legacy pmem regions
      acpi/nfit: Require opt-in for read-only label configurations
      nfit/ars: Attempt a short-ARS whenever the ARS state is idle at boot
      nfit/ars: Attempt short-ARS even in the no_init_ars case
      nfit/ars: Remove ars_start_flags
      nfit/ars: Introduce scrub_flags
      nfit/ars: Allow root to busy-poll the ARS state machine
      nfit/ars: Avoid stale ARS results
      dax: Check the end of the block-device capacity with dax_direct_access()
      libnvdimm/pfn: Remove dax_label_reserve
      libnvdimm/namespace: Clean up holder_class_store()
      Merge branch 'for-5.1/libnvdimm' into libnvdimm-for-next
      Merge branch 'for-5.1/libnvdimm-start-pad' into libnvdimm-for-next
      Merge branch 'for-5.1/nfit/ars' into libnvdimm-for-next

Dexuan Cui (2):
      nfit: acpi_nfit_ctl(): Check out_obj->type in the right place
      nfit: Add Hyper-V NVDIMM DSM command set to white list

Oliver O'Halloran (1):
      libnvdimm: Fix altmap reservation size calculation

Toshi Kani (1):
      acpi/nfit: Update NFIT flags error message

Vishal Verma (2):
      libnvdimm/btt: Remove unnecessary code in btt_freelist_init
      libnvdimm/btt: Fix LBA masking during 'free list' population

Wei Yang (1):
      libnvdimm, pfn: Fix over-trim in trim_pfn_device()

YueHaibing (1):
      libnvdimm/of_pmem: Fix platform_no_drv_owner.cocci warnings

 MAINTAINERS                     |  17 ++--
 drivers/acpi/nfit/core.c        | 185 +++++++++++++++++++++++++++-------------
 drivers/acpi/nfit/nfit.h        |  17 +++-
 drivers/dax/super.c             |  38 ++++++---
 drivers/nvdimm/btt.c            |  33 ++++---
 drivers/nvdimm/btt.h            |   2 +
 drivers/nvdimm/btt_devs.c       |   8 ++
 drivers/nvdimm/dimm_devs.c      |   7 ++
 drivers/nvdimm/label.c          |  26 ++++--
 drivers/nvdimm/namespace_devs.c |  18 +++-
 drivers/nvdimm/of_pmem.c        |   1 -
 drivers/nvdimm/pfn_devs.c       |  24 +++---
 drivers/nvdimm/region_devs.c    |   7 ++
 include/linux/libnvdimm.h       |   2 +
 include/uapi/linux/ndctl.h      |   1 +
 15 files changed, 273 insertions(+), 113 deletions(-)
