Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D65C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC1221019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EvOoroJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391054AbfGRTHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:07:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46279 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfGRTHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:07:39 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so53185235iol.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 12:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=MQUZMSd8XzLJvG3kqon6Z7O6xL3wGkssHmZcIZJnmv8=;
        b=EvOoroJqXk90Np+OA+Gy1HD9IFvuOM3F6KVcElccvHImWBkweE9IcwQ+fFYQvkMZ9i
         3C7TGrXvQX1/K29F2ddJvyLrBt5A5E50Qws/BQpY2OM9GUIGtYL1cUjaU2m9thKICpqd
         oLtsW4dstSTM8SPWXF5VefG6b9SEFuHlYkPatg8C3WdEkDJfnahU/C+Wy72Yq829pFkp
         H0ptNkpWIk6wJ+KDo3bsAJQp+P5e3KkNYZvmBMoBzA6OHsNvjVqRhF8dWQ/jQaC6F00D
         uh80XKIXkR7Cg6/tsvJggCkuRqT9+S/QoHsoDzZsQiu28rk3MKraANiH4gcJsH9Jz1/1
         06pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=MQUZMSd8XzLJvG3kqon6Z7O6xL3wGkssHmZcIZJnmv8=;
        b=nZp2uVo1qBF2B9tlSWkQ604qfq1AoS/CbGpzJWjvdl1yQROxVpen4y6YCSK2qgEyrW
         i/u3vJDrKjIzWvRtW+2K25b2vPvY8qBNoV9VcC9KIKjatWhSUYjGPxzPY/fNGb34auXk
         X24PrEnshttckt7uyL2aQ1mIpOFtd2K5c2zcW6+yFwzh07UxaZwFkHYhidWOYUzuRnJm
         4KjQxxcO2oJUfeIDGIx2eYBt7Q2Y3f30uJrUSwwzIln8JqQP8xYgfOm3Xoz6z8s+JIxe
         JkpVXqFuE8A++H781v+H5EGh6QlRQTS+Grlv/MILEs2kjKckUvOhrZSWH4kO0DrPN10F
         YadA==
X-Gm-Message-State: APjAAAWRszt4cYCJF9nQXlI2CwOiTT5Dx0IZlcOKPxGQlB6NYveKGcHX
        7OWbuvWg48HAFetdeA07EUj4AJnOoqY=
X-Google-Smtp-Source: APXvYqyhJxkNfXL7NWy4swrh8GSZ5IwccJV82aIpycrs3GVBegCdaYy0F+qdLW8XH19x/r9Ypt+kMA==
X-Received: by 2002:a5d:9bc6:: with SMTP id d6mr36025209ion.160.1563476858439;
        Thu, 18 Jul 2019 12:07:38 -0700 (PDT)
Received: from localhost (67-0-62-24.albq.qwest.net. [67.0.62.24])
        by smtp.gmail.com with ESMTPSA id s10sm78233725iod.46.2019.07.18.12.07.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 12:07:37 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:07:36 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     torvalds@linux-foundation.org
cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [GIT PULL] RISC-V updates for v5.3
Message-ID: <alpine.DEB.2.21.9999.1907181155050.17807@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 6fbc7275c7a9ba97877050335f290341a1fd8dbf:

  Linux 5.2-rc7 (2019-06-30 11:25:36 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.3-rc1

for you to fetch changes up to 2d69fbf3d01a5b71e98137e2406d4087960c512e:

  riscv: fix build break after macro-to-function conversion in generic cacheflush.h (2019-07-18 08:16:56 -0700)

----------------------------------------------------------------
RISC-V updates for v5.3

- Hugepage support

- "Image" header support for RISC-V kernel binaries, compatible with
  the current ARM64 "Image" header

- Initial page table setup now split into two stages

- CONFIG_SOC support (starting with SiFive SoCs)

- Avoid reserving memory between RAM start and the kernel in setup_bootmem()

- Enable high-res timers and dynamic tick in the RV64 defconfig

- Remove long-deprecated gate area stubs

- MAINTAINERS updates to switch to the newly-created shared RISC-V git
  tree, and to fix a get_maintainers.pl issue for patches involving
  SiFive E-mail addresses

Also, one integration fix to resolve a build problem introduced during
in the v5.3-rc1 merge window:

- Fix build break after macro-to-function conversion in
  asm-generic/cacheflush.h

----------------------------------------------------------------
Alexandre Ghiti (2):
      x86, arm64: Move ARCH_WANT_HUGE_PMD_SHARE config in arch/Kconfig
      riscv: Introduce huge page support for 32/64bit kernel

Andy Lutomirski (1):
      riscv: Remove gate area stubs

Anup Patel (3):
      RISC-V: defconfig: Enable NO_HZ_IDLE and HIGH_RES_TIMERS
      RISC-V: Fix memory reservation in setup_bootmem()
      RISC-V: Setup initial page tables in two stages

Atish Patra (1):
      RISC-V: Add an Image header that boot loader can parse.

Christoph Hellwig (1):
      riscv: remove free_initrd_mem

Loys Ollivier (3):
      arch: riscv: add config option for building SiFive's SoC resource
      riscv: select SiFive platform drivers with SOC_SIFIVE
      riscv: defconfig: enable SOC_SIFIVE

Paul Walmsley (3):
      MAINTAINERS: don't automatically patches involving SiFive to the linux-riscv list
      MAINTAINERS: change the arch/riscv git tree to the new shared tree
      riscv: fix build break after macro-to-function conversion in generic cacheflush.h

Yash Shah (1):
      riscv: ccache: Remove unused variable

 Documentation/riscv/boot-image-header.txt |  50 +++++
 MAINTAINERS                               |   4 +-
 arch/Kconfig                              |   3 +
 arch/arm64/Kconfig                        |   2 +-
 arch/riscv/Kconfig                        |  10 +
 arch/riscv/Kconfig.socs                   |  13 ++
 arch/riscv/boot/dts/sifive/Makefile       |   2 +-
 arch/riscv/configs/defconfig              |   8 +-
 arch/riscv/configs/rv32_defconfig         |   2 +
 arch/riscv/include/asm/cacheflush.h       |  63 +++++-
 arch/riscv/include/asm/fixmap.h           |   5 +
 arch/riscv/include/asm/hugetlb.h          |  18 ++
 arch/riscv/include/asm/image.h            |  65 ++++++
 arch/riscv/include/asm/page.h             |  14 +-
 arch/riscv/include/asm/pgtable-64.h       |   5 +
 arch/riscv/include/asm/pgtable.h          |  16 +-
 arch/riscv/kernel/head.S                  |  49 ++++-
 arch/riscv/kernel/setup.c                 |   6 +-
 arch/riscv/kernel/vdso.c                  |  19 --
 arch/riscv/mm/Makefile                    |   2 +
 arch/riscv/mm/hugetlbpage.c               |  44 ++++
 arch/riscv/mm/init.c                      | 326 ++++++++++++++++++++++++------
 arch/riscv/mm/sifive_l2_cache.c           |  11 +-
 arch/x86/Kconfig                          |   4 +-
 24 files changed, 620 insertions(+), 121 deletions(-)
 create mode 100644 Documentation/riscv/boot-image-header.txt
 create mode 100644 arch/riscv/Kconfig.socs
 create mode 100644 arch/riscv/include/asm/hugetlb.h
 create mode 100644 arch/riscv/include/asm/image.h
 create mode 100644 arch/riscv/mm/hugetlbpage.c
