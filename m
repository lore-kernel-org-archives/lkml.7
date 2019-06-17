Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A93AC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6D5208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YuxppzVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfFQPye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:54:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36088 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfFQPyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:54:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id k21so16883604edq.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 08:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=jV2fDJB1zhXMMMVqBq/8vXLMU9+s4P/AYpC16uvGS84=;
        b=YuxppzVpxWjvgD7CQFa65TY2bCaxtM0JMcUuzRKkgHgT/8D4S59j6Oqhf/u44x7pg0
         SowGT29iwxZyW14Rfac78gCP7sS6gISMriYhIAYJGSZlvi77MF1IzoVGhv/x5lTa4nOz
         lcmrY6o0Lt7Li2Coi6VzXf4Rqwxg0adWSTzTFeOnmNy2wmqtDuOdoWKzxMH1hDnnJuCF
         /WPTj/wWWXQu3xJ5z5WJbQUm75mGr90OFkAPkWSRNi3q85elB1t0aJw7j3LGt8zkDjyo
         hogKo5k06xVWXdIb5KrxRbx+ZcQn5GAaQf193B8Ak3B9O1V+/iSCcV7TYZqPQKzkmdgU
         Dyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=jV2fDJB1zhXMMMVqBq/8vXLMU9+s4P/AYpC16uvGS84=;
        b=kYSXpvNf4DfxnLX/5bbaxN77PeGUtLw8i+n7LxsC0iUGlS/imnsMlq0IN66LkzdpJj
         v00ippmoYPVbhSdPfUKGZu3KtqN3PSe6Z7AXrUy5rW7XqVI1QtOKcDAgt2QqeeuUqiIO
         Hj1Qbgnu2btNyPAcZZydnAyhZTd8DA786VtGmrbrU4fAdoSwDPwd7h7MHY8UzMuq87OC
         Fd6z3jChCdeU68K1BNypSV/hxVawuL9oQz1dVUN36shmEHGxGD7R1vC5WErylaisbde4
         jcwWOyKBBt+JNy1vQKjuBf5+/Lojw2hxYrxG0KdKoUNF1B+m47waoOfvQ52u5F1/9cU0
         QCmg==
X-Gm-Message-State: APjAAAXhhc3oulEun4h/Qy40YRQECp3eAmkoAaAbENPF53l1fi4cv7ln
        Zu+y93sawp16+2U4onTFIctU29+BSqg=
X-Google-Smtp-Source: APXvYqwkkzzQLh5Z3U9OcJIPb6Q6NL3JOaCnMfSdWkTBEdV3Tucxf1iPAKZ/7FaGkE+pBLCyQPcMBA==
X-Received: by 2002:a17:906:c459:: with SMTP id ck25mr52234185ejb.32.1560786872016;
        Mon, 17 Jun 2019 08:54:32 -0700 (PDT)
Received: from localhost ([81.92.102.43])
        by smtp.gmail.com with ESMTPSA id i1sm2239790ejb.80.2019.06.17.08.54.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 08:54:31 -0700 (PDT)
Date:   Mon, 17 Jun 2019 08:54:30 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V patches for v5.2-rc6
Message-ID: <alpine.DEB.2.21.9999.1906170846340.30717@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-v5.2/fixes-rc6

for you to fetch changes up to 259931fd3b96e4386b361b7f80c1d89b266234c8:

  riscv: remove unused barrier defines (2019-06-17 07:09:43 -0700)

----------------------------------------------------------------
RISC-V patches for v5.2-rc6

This tag contains fixes, defconfig, and DT data changes for the v5.2-rc
series.  The fixes are relatively straightforward:

- Addition of a TLB fence in the vmalloc_fault path, so the CPU doesn't
  enter an infinite page fault loop;
- Readdition of the pm_power_off export, so device drivers that
  reassign it can now be built as modules;
- A udelay() fix for RV32, fixing a miscomputation of the delay time;
- Removal of deprecated smp_mb__*() barriers.

The tag also adds initial DT data infrastructure for arch/riscv, along
with initial data for the SiFive FU540-C000 SoC and the corresponding
HiFive Unleashed board.

We also update the RV64 defconfig to include some core drivers for the
FU540 in the build.

----------------------------------------------------------------
Andreas Schwab (1):
      riscv: export pm_power_off again

Kevin Hilman (1):
      RISC-V: defconfig: enable clocks, serial console

Nick Hu (1):
      riscv: Fix udelay in RV32.

Paul Walmsley (5):
      arch: riscv: add support for building DTB files from DT source data
      dt-bindings: riscv: sifive: add YAML documentation for the SiFive FU540
      dt-bindings: riscv: convert cpu binding to json-schema
      riscv: dts: add initial support for the SiFive FU540-C000 SoC
      riscv: dts: add initial board data for the SiFive HiFive Unleashed

Rolf Eike Beer (1):
      riscv: remove unused barrier defines

ShihPo Hung (1):
      riscv: mm: synchronize MMU after pte change

 Documentation/devicetree/bindings/riscv/cpus.yaml  | 168 ++++++++++++++++
 .../devicetree/bindings/riscv/sifive.yaml          |  25 +++
 MAINTAINERS                                        |   9 +
 arch/riscv/boot/dts/Makefile                       |   2 +
 arch/riscv/boot/dts/sifive/Makefile                |   2 +
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi         | 215 +++++++++++++++++++++
 .../riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  65 +++++++
 arch/riscv/configs/defconfig                       |   4 +
 arch/riscv/include/asm/bitops.h                    |   5 -
 arch/riscv/kernel/reset.c                          |   1 +
 arch/riscv/lib/delay.c                             |   2 +-
 arch/riscv/mm/fault.c                              |  13 ++
 12 files changed, 505 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/riscv/cpus.yaml
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive.yaml
 create mode 100644 arch/riscv/boot/dts/Makefile
 create mode 100644 arch/riscv/boot/dts/sifive/Makefile
 create mode 100644 arch/riscv/boot/dts/sifive/fu540-c000.dtsi
 create mode 100644 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
