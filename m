Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975CCC00523
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 06:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C346215A4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 06:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fjETWpe1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgAEGET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 01:04:19 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37353 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgAEGES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 01:04:18 -0500
Received: by mail-io1-f67.google.com with SMTP id k24so15153141ioc.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 22:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=Vu/BIPQbyqubOJuLGv4uKPQrPxznt9X7LWYfO/wIAnA=;
        b=fjETWpe1qX+g0/b1/eDWfsSD96vubX6xO/gqryKmT925eFdQ716DPguv35Tw96K8pT
         nWa9ErHiDYq1+AEKdNiydKQAQ57L8wv5eticDWHBQOTPEVgEQSb/YhqiCpyjWHe4ACX8
         kPE9MT5T+nimkRzrWrhkQ84eVguvTsNhkrQfQGNMjPj6s2uj7eEPpgSRCwAqmzmp1R/C
         ic/3CdRNBZ5ASoGWtabWzAm95pGVMV5eOCc6VEc/Q6/Jdhm+PYkZPQoeczm+PYgLsfmw
         eEPLE0KmXdMFYYzPhkVd0pBkTfzoRiJ/NuTpS5sDoGGPH8OZ2ZCU+rs/DDUwAP4j/1g8
         +aVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=Vu/BIPQbyqubOJuLGv4uKPQrPxznt9X7LWYfO/wIAnA=;
        b=ikJXunSMNl67N31PLDCBdCMXit69sdyB+hwniF/MA31Gq5NP9Mkd4eEiKoQwAWIgQT
         l5lV/nSTwpZLyxmIEzWXs0BXAKNTE4DjQF/xdl7VgdHEV5SwWVVvRwUMM0Hh25nn2E29
         5Rcv6fGxfKluecvD9oAPdSUPnsbo9dA88MyTryx5tvQmPTAeY1FRcattJeKUlIBPwCOq
         1U/Pn6YWj2NPKzTKKylpsMRCVEaMzqz3J/lbYorqVo99rJh9n1ByeswYCFsZWy/SiE0t
         oLsDBRXkBpsi99SheQi9vjKJkpyVpcWSC90TnIWk/iJTeNa+sV4TB1A30rekmwfn2/Lz
         EMVQ==
X-Gm-Message-State: APjAAAWOQcgKoW/6a4OX2aUQ2Jc9bAfcPCJTizmvHPZLZKTPyz+1XZqE
        JFLTeywrENQWR0BepMOBQ6tZFlc9rdA=
X-Google-Smtp-Source: APXvYqxIBOGaSBg12yvBKwarm9Q3w9aL9cMpjLULTj3Hp4g+7r5n9gPa5UQgjwzWSMKfuLFmY0fV+g==
X-Received: by 2002:a6b:6f01:: with SMTP id k1mr65149377ioc.28.1578204257948;
        Sat, 04 Jan 2020 22:04:17 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id w16sm22830683ilq.5.2020.01.04.22.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 22:04:17 -0800 (PST)
Date:   Sat, 4 Jan 2020 22:04:16 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     torvalds@linux-foundation.org
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V updates for v5.5-rc5
Message-ID: <alpine.DEB.2.21.9999.2001042202460.484919@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit fd6988496e79a6a4bdb514a4655d2920209eb85d:

  Linux 5.5-rc4 (2019-12-29 15:29:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.5-rc5

for you to fetch changes up to 0e194d9da198936fe4fb4c1e031de0f7791c09b8:

  Documentation: riscv: add patch acceptance guidelines (2020-01-04 21:49:01 -0800)

----------------------------------------------------------------
RISC-V updates for v5.5-rc5

Several fixes for RISC-V:

- Fix function graph trace support

- Prefix the CSR IRQ_* macro names with "RV_", to avoid collisions
  with macros elsewhere in the Linux kernel tree named "IRQ_TIMER"

- Use __pa_symbol() when computing the physical address of a kernel
  symbol, rather than __pa()

- Mark the RISC-V port as supporting GCOV

One DT addition:

- Describe the L2 cache controller in the FU540 DT file

One documentation update:

- Add patch acceptance guideline documentation

----------------------------------------------------------------
Paul Walmsley (2):
      riscv: prefix IRQ_ macro names with an RV_ namespace
      Documentation: riscv: add patch acceptance guidelines

Yash Shah (1):
      riscv: dts: Add DT support for SiFive L2 cache controller

Zong Li (4):
      riscv: mm: use __pa_symbol for kernel symbols
      riscv: gcov: enable gcov for RISC-V
      riscv: ftrace: correct the condition logic in function graph tracer
      clocksource: riscv: add notrace to riscv_sched_clock

 .../debug/gcov-profile-all/arch-support.txt        |  2 +-
 Documentation/process/index.rst                    |  1 +
 Documentation/riscv/index.rst                      |  1 +
 Documentation/riscv/patch-acceptance.rst           | 35 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 arch/riscv/Kconfig                                 |  1 +
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi         | 15 ++++++++++
 arch/riscv/include/asm/csr.h                       | 18 +++++------
 arch/riscv/kernel/ftrace.c                         |  2 +-
 arch/riscv/kernel/irq.c                            |  6 ++--
 arch/riscv/mm/init.c                               | 12 ++++----
 drivers/clocksource/timer-riscv.c                  |  2 +-
 drivers/irqchip/irq-sifive-plic.c                  |  2 +-
 13 files changed, 76 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/riscv/patch-acceptance.rst

Kernel object size difference:
   text	   data	    bss	    dec	    hex	filename
6896189	2329828	 313920	9539937	 919161	vmlinux.rv64.orig
6896191	2329892	 313920	9540003	 9191a3	vmlinux.rv64.patched
6656496	1939040	 257576	8853112	 871678	vmlinux.rv32.orig
6656498	1939040	 257576	8853114	 87167a	vmlinux.rv32.patched
1171674	 353368	 130024	1655066	 19411a	vmlinux.nommu_virt.orig
1171674	 353368	 130024	1655066	 19411a	vmlinux.nommu_virt.patched

