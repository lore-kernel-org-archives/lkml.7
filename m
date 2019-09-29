Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D4FC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 01:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6942082F
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 01:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="am9+hfAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfI2Bo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 21:44:29 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35121 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfI2Bo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 21:44:29 -0400
Received: by mail-oi1-f195.google.com with SMTP id x3so8305672oig.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 18:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=D6VeIErh+8KaLvJbYMRE86Pl0R5H4QLRbONvVO8u13E=;
        b=am9+hfAULTS1nirDM2wx4jXo/syl1zs6SExFRHa3G7OXWc97tBwROQ3AuCBEgwz2nW
         Z8dcuxgt34MOnF8I9bBAJsjb6qYrE1Tq1uoXtT8E7YNXH4s5UW5QIUm5ynmdbh4ccWtR
         hH+FvkufPSsmlzwC+C0exdEgc14TJ9t5JkBWjs4jJGTn2CUitSUcJSFTZOLzr4jAq5Os
         V5pczsveQaHgdqEUdStmgp2BM7fstJB3pz1GAIx2ijl8cXBkYnC73fZ3HoCRqqDfgPdH
         fh8NVtoFvtaAZg+lubGCc7e+1qyfAyA4fChc87ks2Rrd/QYxZxLQIsptx0TJbUksMAe8
         Cvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=D6VeIErh+8KaLvJbYMRE86Pl0R5H4QLRbONvVO8u13E=;
        b=ir9O6rpcKp1eKCymRCfTb0RUCpSVSEHlaWe1RcgFAEbNU7Y8EMpulP0+v2H/rnbzyD
         t9Uo7AXHHC/PsY/rYR1r8oOiQGtAtuu/xLcg+uul8fd3c9lNU+4lskbtu1lyiqBbaG/O
         paqBz1BNniqSS49gnZcirQLpIA3ETyRhIZKsEbHYxmo3obZ3VF1Xqz/VuvkeF3+ZQaj1
         PwoztmQmcOw4a4o40M9JUPW87/rFluioflMsGtlekb/VCrYXB5cQBEaG0JIsK0BukfnJ
         802Mv2CA/uYIN/zZ/vqEbahcMvOghrMu3FismSygtMy1iyAsv9BKMbQrO3lPbaTeDgPD
         4vxg==
X-Gm-Message-State: APjAAAUX2gJl5aKxB2RxVK3tQ9+0SxFKRJ/XOh3fbQSzLqf0UHstpSsD
        NYzY8MDut5ryofXiNZSQ0ZKlFNab8ivJ8XiZDytC2d6HeoE=
X-Google-Smtp-Source: APXvYqzT9FuMMlTI3sZ2A+7luXbbWVa+lN7PZL6ngkoyM/uy6MaY1NDyjfUAtJgisqJ1OHXabN9ZcHFmFXUFPEjcZto=
X-Received: by 2002:aca:4b05:: with SMTP id y5mr12165899oia.70.1569721468562;
 Sat, 28 Sep 2019 18:44:28 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 28 Sep 2019 18:44:17 -0700
Message-ID: <CAPcyv4jJjjkXXSYpYNC3y2r2YJrcSYw=tZ9p=KyA8BS46kfFuA@mail.gmail.com>
Subject: [GIT PULL] libnvdimm fixes for v5.4-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.4-rc1

...to receive the completion of the work to fixup libnvdimm operation
on powerpc as well as a collection of typical -rc class fixes. This
powerpc work missed the initial libnvdimm pull last week due to a late
discovered compile breakage (missing symbol export), but it's all
fixed up now, and has appeared in -next releases over the past week
with no issues. The touch of arch/powerpc/ has an ack from Michael.

---

The following changes since commit 5b26db95fee3f1ce0d096b2de0ac6f3716171093:

  libnvdimm: Use PAGE_SIZE instead of SZ_4K for align check
(2019-09-05 16:11:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.4-rc1

for you to fetch changes up to 4c806b897d6075bfa5067e524fb058c57ab64e7b:

  libnvdimm/region: Enable MAP_SYNC for volatile regions (2019-09-24
10:33:19 -0700)

----------------------------------------------------------------
libnvdimm fixes v5.4-rc1

- Complete the reworks to interoperate with powerpc dynamic huge page sizes

- Fix a crash due to missed accounting for the powerpc 'struct
  page'-memmap mapping granularity.

- Fix badblock initialization for volatile (DRAM emulated) pmem ranges.

- Stop triggering request_key() notifications to userspace when
  NVDIMM-security is disabled / not present.

- Miscellaneous small fixups.

----------------------------------------------------------------
Aneesh Kumar K.V (6):
      powerpc/book3s64: Export has_transparent_hugepage() related functions.
      libnvdimm/dax: Pick the right alignment default when creating dax devices
      libnvdimm: Fix endian conversion issues
      libnvdimm/altmap: Track namespace boundaries in altmap
      libnvdimm/region: Initialize bad block for volatile namespaces
      libnvdimm/region: Enable MAP_SYNC for volatile regions

Dave Jiang (1):
      libnvdimm: prevent nvdimm from requesting key when security is disabled

Nathan Chancellor (1):
      libnvdimm/nfit_test: Fix acpi_handle redefinition

 arch/powerpc/include/asm/book3s/64/radix.h |  8 +++-
 arch/powerpc/mm/book3s64/hash_pgtable.c    |  2 +
 arch/powerpc/mm/book3s64/radix_pgtable.c   |  7 ---
 arch/powerpc/mm/init_64.c                  | 17 ++++++-
 drivers/nvdimm/btt.c                       |  8 ++--
 drivers/nvdimm/bus.c                       |  2 +-
 drivers/nvdimm/namespace_devs.c            |  7 +--
 drivers/nvdimm/nd.h                        |  6 +--
 drivers/nvdimm/pfn_devs.c                  | 77 ++++++++++++++++++++++--------
 drivers/nvdimm/region.c                    |  4 +-
 drivers/nvdimm/region_devs.c               |  7 ++-
 drivers/nvdimm/security.c                  |  4 ++
 include/linux/huge_mm.h                    |  7 ++-
 include/linux/memremap.h                   |  1 +
 tools/testing/nvdimm/test/nfit_test.h      |  4 +-
 15 files changed, 110 insertions(+), 51 deletions(-)
