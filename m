Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70137C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8C1207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="EG2xaZfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407272AbfITX5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 19:57:44 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:32988 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407258AbfITX5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:57:44 -0400
Received: by mail-ot1-f68.google.com with SMTP id g25so7659799otl.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 16:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SNZHTXzWFoKdfyj4SStuMD6R3nyVpzOS/PYND2ZV/mU=;
        b=EG2xaZfdclJq2IuOFaxMmJcqHhFSAUvzcOVxAaowYSI2UPsZnqF3fEyRlK+eD87aa1
         f9di2GUe07f0vlLec7Elw2l8gHLl8sx4BqttWPPUQ1IpD01ySFme8ZfIq4JjlVMwRr9r
         O1gTPAfFoAg9QJFADrghcRLE5rk+5nwBsfCPF3xTDbSXVHVGnxT5SRXaH86JD/NEB9rN
         S07K7bdsME0qmcJ5CoBy0ATRmcFwtJKwaIJ9ef72V5bhz/S6etQJz8ZFldAsUFdPquV9
         O19plpd/L3TBPobjrgZ0JRxUvnlyAHUSxyYECq8/n43+TZ3Kia1h25hEvN6h6J0mTnWD
         Z1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SNZHTXzWFoKdfyj4SStuMD6R3nyVpzOS/PYND2ZV/mU=;
        b=UHkT/tMEl9huGD3G1rCNVEYINmOvDBAyIL+1kmqA0jUp/iuWthXipXZq8PMVVlawk9
         Bv44Idy09Qt+nRt0CnTXUguS5I1VoqE7zvMXdDY1Pf0z02434EkBQGx5KvndsHySJSeG
         gWmtsqtBFi+IWd8Dw1cgQKfznTvtoRt5yhM6oPDWIBqcbvaeOdJt/UuHAWxYK6DqG6ni
         r9Ema/IuasGnEMAUBHV1kuIGxrgKtSvVy4gfNp3Ygf8GUe33B7klyUoeorFXmJEBU+c3
         YYr8Pkbkqvu8IVIOzmfYZJlDPPY8pdmAOOpN7/GZ2gbuJ8wxUf6ZvhnRWgPJxcERA3jg
         rF+A==
X-Gm-Message-State: APjAAAXY30furaE7yU0BkhtVSNkp5ImNjh3u/uIhVNoxTSET0LBmYn1D
        YGkhfJidl89DrWi+2Y3MzvZEoopqEmjhkIxH1Fz/cqGfW2U=
X-Google-Smtp-Source: APXvYqyUYCL340Fi0wZXLSZtP6idL/XMJySaz6gMFxZbpUO44FKAPVfR7TlRToS+JVeVKsf60wttWvs/zJYYbqHuPzo=
X-Received: by 2002:a9d:6014:: with SMTP id h20mr13280117otj.207.1569023863066;
 Fri, 20 Sep 2019 16:57:43 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 20 Sep 2019 16:57:31 -0700
Message-ID: <CAPcyv4g9TpgciDdVpQajSxEYTaHxB4+R9KWF0d=Emt9J7LkAqg@mail.gmail.com>
Subject: [GIT PULL] libnvdimm for 5.4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.4

...to receive some reworks to better support nvdimms on powerpc and an
nvdimm security interface update.

There was some last minute build breakage detected in -next so I've
left a patch that finalizes the powerpc compatibility work and some
other fixes out of this pull request.  The build fix requires a new
symbol export that needs an ack from ppc folks, so I'm going to save
that for a post -rc1 update. "libnvdimm/dax: Pick the right alignment
default when creating dax devices" not typically something I would
send during the -rc cycle, but I see no strong reason for it to wait
until v5.5.

The pending fixes for others watching are:

Aneesh Kumar K.V (4):
      libnvdimm/dax: Pick the right alignment default when creating dax devices
      mm/nvdimm: Fix endian conversion issues
      libnvdimm/altmap: Track namespace boundaries in altmap
      libnvdimm/region: Initialize bad block for volatile namespaces

Nathan Chancellor (1):
      libnvdimm/nfit_test: Fix acpi_handle redefinition

---

The following changes since commit d45331b00ddb179e291766617259261c112db872:

  Linux 5.3-rc4 (2019-08-11 13:26:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.4

for you to fetch changes up to 5b26db95fee3f1ce0d096b2de0ac6f3716171093:

  libnvdimm: Use PAGE_SIZE instead of SZ_4K for align check
(2019-09-05 16:11:14 -0700)

----------------------------------------------------------------
libnvdimm for 5.4

- Rework the nvdimm core to accommodate architectures with different page
  sizes and ones that can change supported huge page sizes at boot
  time rather than a compile time constant.

- Introduce a distinct 'frozen' attribute for the nvdimm security state
  since it is independent of the locked state.

- Miscellaneous fixups.

----------------------------------------------------------------
Aneesh Kumar K.V (6):
      libnvdimm/of_pmem: Provide a unique name for bus provider
      libnvdimm/pmem: Advance namespace seed for specific probe errors
      libnvdimm/pfn_dev: Add a build check to make sure we notice when
struct page size change
      libnvdimm/pfn_dev: Add page size and struct page size to pfn superblock
      libnvdimm/label: Remove the dpa align check
      libnvdimm: Use PAGE_SIZE instead of SZ_4K for align check

Dan Williams (5):
      tools/testing/nvdimm: Fix fallthrough warning
      libnvdimm/security: Introduce a 'frozen' attribute
      libnvdimm/security: Tighten scope of nvdimm->busy vs security operations
      libnvdimm/security: Consolidate 'security' operations
      libnvdimm/region: Rewrite _probe_success() to _advance_seeds()

Gustavo A. R. Silva (1):
      libnvdimm, region: Use struct_size() in kzalloc()

 drivers/acpi/nfit/intel.c        |  59 ++++++------
 drivers/nvdimm/bus.c             |  10 +-
 drivers/nvdimm/dimm_devs.c       | 134 ++++++--------------------
 drivers/nvdimm/label.c           |   5 -
 drivers/nvdimm/namespace_devs.c  |  40 ++++++--
 drivers/nvdimm/nd-core.h         |  54 ++++-------
 drivers/nvdimm/nd.h              |   4 +
 drivers/nvdimm/of_pmem.c         |   2 +-
 drivers/nvdimm/pfn.h             |   5 +-
 drivers/nvdimm/pfn_devs.c        |  35 ++++++-
 drivers/nvdimm/pmem.c            |  29 +++++-
 drivers/nvdimm/region_devs.c     |  83 ++++------------
 drivers/nvdimm/security.c        | 199 ++++++++++++++++++++++++++-------------
 include/linux/libnvdimm.h        |   9 +-
 tools/testing/nvdimm/dimm_devs.c |  19 +---
 tools/testing/nvdimm/test/nfit.c |   3 +-
 16 files changed, 346 insertions(+), 344 deletions(-)
