Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41289C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE4A21655
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="S9o1BssE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfI0SZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 14:25:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41272 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfI0SZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:25:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id h7so4268303wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 11:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=ILyYK/RyFSznwVzkPBcKhiT8HPwbfb9Jo/boI1cizIU=;
        b=S9o1BssEg46wqpVTRWJVH0DuDQdCRBiTBnhb600zFmYBhAWiIfq3By9eUgU6SbMKd0
         /pnnnBkVUSxgg5JjB9Ska3G7vmvzp1dmUHbhNedoqPE3K8ndqDP8U0qJqzjH12s4qy4u
         8XqdZtvI5xHKroydSrGjBVqTHl5EOltqb3ioXGj1TH4DqwxK8NNo8X2uhHjpfTnDLVOW
         n4aYTst7l9b0R4vgxGmlh972Y/TyRH5xy7ZhT/YCyHBCqqlyI0u6gnU+oqja1lwnRuZg
         6+oRwQBY2XbCnJJK43B3G2n8OwxDIDBQRAIITZB6OJizVRy11WO7XfQUcRiZ6e6vPiK5
         L1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=ILyYK/RyFSznwVzkPBcKhiT8HPwbfb9Jo/boI1cizIU=;
        b=fmTw7jmQ8bdWC2Nc0vWhXMeYDG3FPjWzRPfD3KC8U38Zv/twKkiJd/w1+nlauRpD/9
         KiEH6WqgnB+K+5xGnCNmwe53n8r3grrkLeOHO2yH3gEXHirbRpcwzBArtK+bDkpvAdYF
         K2eLsclkey1zfzzflPlr8oBXwHiEE+PjGCUgrXiDsI3ohobjMlADPxSGUpWF29Xf56J+
         XiIg7MVxOZYNn7x2Ki6OBmHajh79srWxkGEqxJjUxVn2Nu7XrxXybRhLJk2hQuARwKqR
         4B3KwKMuI1HL9qvWLMfAPtyeoVDqtLk5bTQNnWNz/RbeWgWFE8fukm8nUHQIJwe8JZO8
         Kvsw==
X-Gm-Message-State: APjAAAU8L8YneeI+okbreOeN+Y574N7ltqirlGbG59ynp3kIq+g1bgeR
        IaWnP6DaNfxWgJYJpI7z7AqrXap3jv0=
X-Google-Smtp-Source: APXvYqz6qVaFBt7XT3TUgHDF4YZhVzJCpdIiKfIOmy7VkWX76KlB8NIB36WxA7SH24DIw5NikJN4jA==
X-Received: by 2002:adf:9c88:: with SMTP id d8mr4050027wre.364.1569608714352;
        Fri, 27 Sep 2019 11:25:14 -0700 (PDT)
Received: from localhost ([81.255.46.201])
        by smtp.gmail.com with ESMTPSA id b7sm3500756wrj.28.2019.09.27.11.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 11:25:13 -0700 (PDT)
Date:   Fri, 27 Sep 2019 11:25:13 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     torvalds@linux-foundation.org
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V additional updates for v5.4-rc1
Message-ID: <alpine.DEB.2.21.9999.1909271123370.17782@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit b41dae061bbd722b9d7fa828f35d22035b218e18:

  Merge tag 'xfs-5.4-merge-7' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux (2019-09-18 18:32:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.4-rc1-b

for you to fetch changes up to c82dd6d078a2bb29d41eda032bb96d05699a524d:

  riscv: Avoid interrupts being erroneously enabled in handle_exception() (2019-09-20 08:42:34 -0700)

----------------------------------------------------------------
RISC-V additional updates for v5.4-rc1

Some additional RISC-V updates for v5.4-rc1.  This includes one
significant fix:

- Prevent interrupts from being unconditionally re-enabled during
  exception handling if they were disabled in the context in which the
  exception occurred

Also a few other fixes:

- Fix a build error when sparse memory support is manually enabled

- Prevent CPUs beyond CONFIG_NR_CPUS from being enabled in early boot

And a few minor improvements:

- DT improvements: in the FU540 SoC DT files, improve U-Boot
  compatibility by adding an "ethernet0" alias, drop an unnecessary
  property from the DT files, and add support for the PWM device

- KVM preparation: add a KVM-related macro for future RISC-V KVM
  support, and export some symbols required to build KVM support as
  modules

- defconfig additions: build more drivers by default for QEMU
  configurations

----------------------------------------------------------------
Anup Patel (2):
      RISC-V: Enable VIRTIO drivers in RV64 and RV32 defconfig
      KVM: RISC-V: Add KVM_REG_RISCV for ONE_REG interface

Atish Patra (1):
      RISC-V: Export kernel symbols for kvm

Bin Meng (2):
      riscv: dts: sifive: Add ethernet0 to the aliases node
      riscv: dts: sifive: Drop "clock-frequency" property of cpu nodes

Greentime Hu (1):
      RISC-V: Fix building error when CONFIG_SPARSEMEM_MANUAL=y

Vincent Chen (1):
      riscv: Avoid interrupts being erroneously enabled in handle_exception()

Xiang Wang (1):
      arch/riscv: disable excess harts before picking main boot hart

Yash Shah (1):
      riscv: dts: Add DT support for SiFive FU540 PWM driver

 arch/riscv/boot/dts/sifive/fu540-c000.dtsi         | 22 +++++++++++++++++---
 .../riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  8 ++++++++
 arch/riscv/configs/defconfig                       | 11 ++++++++++
 arch/riscv/configs/rv32_defconfig                  | 11 ++++++++++
 arch/riscv/include/asm/pgtable.h                   | 24 +++++++++++-----------
 arch/riscv/kernel/entry.S                          |  6 +++++-
 arch/riscv/kernel/head.S                           |  8 +++++---
 arch/riscv/kernel/smp.c                            |  1 +
 arch/riscv/kernel/time.c                           |  1 +
 include/uapi/linux/kvm.h                           |  1 +
 10 files changed, 74 insertions(+), 19 deletions(-)
