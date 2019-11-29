Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B5FC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 18:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B647C21721
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 18:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Q1+qt9qm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfK2S4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 13:56:34 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44634 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfK2S4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 13:56:34 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so1957980oia.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 10:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xboj7F00bLbKnatedgQze9i2APMnPtQy1LrQNkM7FYQ=;
        b=Q1+qt9qmF/rLkAGqDYkEHYeW6EPQtxzZ+8NtolvjMgoSovWm13CTHenqOgKWRP4D4f
         aKXtgJD3mrzRgeFkX4xXtZZU7Tdp+RyHrJh2Cs5RgQvLZ4qveq/M2BTUPg1q7EfeQAVw
         lVGygT+Pwk34HBtkoZLFR+TF2OmaHYuV/8l+eJJCQwlE3ZOt6U/fTUUIwPhaZU5STa0e
         quHtjFQJVApCTJ9Cl5pvi3VW+Ts1WpNYNTuKfsnptFQciYz3CLt+VGAkAr5hxfFJ07W4
         S906t//NGSvk1EVk2cIcfrb2jweYPzanpDN9XPOBJVtzBuizrtYc+UHNa+DFFutxL+j5
         Lb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xboj7F00bLbKnatedgQze9i2APMnPtQy1LrQNkM7FYQ=;
        b=TLQgkoFd8gxZpeYJdsalmu7HGwi4UauHLBrm1WZG5lXFl0DMcZPQqc3VtVSf5KaJNc
         tZcmM5PHz1JPc9FLLvcf30XPWo8RR1ZSJ4KdLhzr7l1V17rWQvu4lf16XpR9Qi0BnOM+
         MY1k0DR3DKiSuVOUlbZiqgbPHmLIQrzbgsYXPiaN7sFGLebrtJz6TW0Ya1o/tQ/b1djx
         /XwlRCZSIIvT5DoqzoAH6DA7F/UZyomqfEGnJQd1BW4+PoPWNHh4eRmc+Eb8+Utkrmn6
         qfZ3hUMm9aGwEUTVMCLGDV9sbNd1SNFX7Rg9IaDJGLeJqHyBgYzYyvvHBljTRMSBIvku
         tUeA==
X-Gm-Message-State: APjAAAXxHSIlm2XBDQNZF5qSkx/Nz4jM14WbMF0kARwgHVmIoRP4ii6g
        HSdAHNLjKlpKj2kmXUX3m0LcBZwdVjX9XKitgWvk417rzYE=
X-Google-Smtp-Source: APXvYqzd57f2wxECF4fesi3hhXmvOo40o4Zq2olC+h0RWJ9X7eKDf4fWTmQ75AQmTV7EkFg6r5iSKXRdJRJrI8ZfR34=
X-Received: by 2002:a54:468e:: with SMTP id k14mr1852547oic.105.1575053793229;
 Fri, 29 Nov 2019 10:56:33 -0800 (PST)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Nov 2019 10:56:22 -0800
Message-ID: <CAPcyv4jftz7mN=4zNPo1tGZfcXxfKunTUF4Owof6pJ108GYk=g@mail.gmail.com>
Subject: [GIT PULL] libnvdimm for v5.5
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
tags/libnvdimm-for-5.5

...to receive the libnvdimm update for this cycle. The highlight this
cycle is continuing integration fixes for PowerPC and some resulting
optimizations. These commits have appeared in -next with no reported
issues.

---

The following changes since commit d6d5df1db6e9d7f8f76d2911707f7d5877251b02:

  Linux 5.4-rc5 (2019-10-27 13:19:19 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.5

for you to fetch changes up to 0dfbb932bb67dc76646e579ec5cd21a12125a458:

  MAINTAINERS: Remove Keith from NVDIMM maintainers (2019-11-25 15:45:08 -0800)

----------------------------------------------------------------
libnvdimm for 5.5

- Updates to better support vmalloc space restrictions on PowerPC platforms.

- Cleanups to move common sysfs attributes to core 'struct device_type'
  objects.

- Export the 'target_node' attribute (the effective numa node if pmem is
  marked online) for regions and namespaces.

- Miscellaneous fixups and optimizations.

----------------------------------------------------------------
Alastair D'Silva (1):
      libnvdimm: Remove prototypes for nonexistent functions

Aneesh Kumar K.V (2):
      libnvdimm/pfn_dev: Don't clear device memmap area during generic
namespace probe
      libnvdimm/namespace: Differentiate between probe mapping and
runtime mapping

Dan Williams (14):
      libnvdimm/pmem: Delete include of nd-core.h
      libnvdimm: Move attribute groups to device type
      libnvdimm: Move region attribute group definition
      libnvdimm: Move nd_device_attribute_group to device_type
      libnvdimm: Move nd_numa_attribute_group to device_type
      libnvdimm: Move nd_region_attribute_group to device_type
      libnvdimm: Move nd_mapping_attribute_group to device_type
      libnvdimm: Move nvdimm_attribute_group to device_type
      libnvdimm: Move nvdimm_bus_attribute_group to device_type
      dax: Create a dax device_type
      dax: Simplify root read-only definition for the 'resource' attribute
      libnvdimm: Simplify root read-only definition for the 'resource' attribute
      dax: Add numa_node to the default device-dax attributes
      libnvdimm: Export the target_node attribute for regions and namespaces

Ira Weiny (2):
      libnvdimm/namsepace: Don't set claim_class on error
      libnvdimm: Trivial comment fix

Keith Busch (1):
      MAINTAINERS: Remove Keith from NVDIMM maintainers

Qian Cai (1):
      libnvdimm/btt: fix variable 'rc' set but not used

 MAINTAINERS                               |   2 -
 arch/powerpc/platforms/pseries/papr_scm.c |  25 +---
 drivers/acpi/nfit/core.c                  |   7 -
 drivers/dax/bus.c                         |  22 ++-
 drivers/dax/pmem/core.c                   |   6 +-
 drivers/nvdimm/btt.c                      |  18 ++-
 drivers/nvdimm/btt_devs.c                 |  24 +--
 drivers/nvdimm/bus.c                      |  44 +++++-
 drivers/nvdimm/claim.c                    |  14 +-
 drivers/nvdimm/core.c                     |   8 +-
 drivers/nvdimm/dax_devs.c                 |  27 ++--
 drivers/nvdimm/dimm_devs.c                |  30 ++--
 drivers/nvdimm/e820.c                     |  13 --
 drivers/nvdimm/namespace_devs.c           | 114 +++++++++------
 drivers/nvdimm/nd-core.h                  |  21 ++-
 drivers/nvdimm/nd.h                       |  27 ++--
 drivers/nvdimm/of_pmem.c                  |  13 --
 drivers/nvdimm/pfn_devs.c                 |  64 ++++----
 drivers/nvdimm/pmem.c                     |  18 ++-
 drivers/nvdimm/region_devs.c              | 235 +++++++++++++++---------------
 include/linux/libnvdimm.h                 |   7 -
 include/linux/nd.h                        |   2 +-
 22 files changed, 387 insertions(+), 354 deletions(-)
