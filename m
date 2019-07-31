Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86158C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA79208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="fOlK1pZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfGaPjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:39:01 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37922 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbfGaPjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:39:01 -0400
Received: by mail-qk1-f195.google.com with SMTP id a27so49596242qkk.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o/O3YpN4O8rPb4BgrrX1qWIeA6J8/etb5rlyfqo4ciQ=;
        b=fOlK1pZTJZmDoPZasVUypsNKooUm9H+V1U6+OsQGPQtgVMQkxb3fJ1+UwUtJOR/0a1
         U1xjP8sYotLYI727WseY4fv7iJnqltKbNblNHQf3MWVZZsXTajVL34VYRVHYVdbt6ZQG
         r+0HTEjMOgKgyOCoc4DPX/cbDyJnziYpmU6qzD98mje3mqCjsrLzCzC44nx8I1NUzHOT
         uGDBZIK18qQSjuRjl3oW12PzgM4IrL8xZb/dUBn11cgWX84yOokXq1Cd+J0lOA5K17i+
         9pJITYdbN24xX7LH4sCLKlQBFo5AZ5afeaew/VAGZAnOopNVAoAkad1RSXIgnx2IcW//
         F97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o/O3YpN4O8rPb4BgrrX1qWIeA6J8/etb5rlyfqo4ciQ=;
        b=RU54/A6CN2UgUxvRLEhW6NENaECeSkhhyohzCJOWN+IdMCANm3Woem2KF667Wsm4CU
         NR8wFrpHaANrTliGPx0V80lo2cJEYDF68hR4ovHZxHDjOQuisGS7j5Rvhe78dW+vVJBd
         LkOevBqljoz/Vv+RnoIyLUMyUeSigmo0OF9W5BacdvL2vrnKWGZlZcMBEj0928I9Z+12
         ktrlwsOoUcrf7rXsfiypSdE6EmtE6mnxv06t7cW9r6Ccq6KABsl6DYFeHFTRB9tQ31zh
         cSuQ+PzxbbKcsSEu8re41GoMrEtVB2Fnb0kwIEA0PmWm6BnGGjZ3JrLfFVtlOlqI6M03
         toyw==
X-Gm-Message-State: APjAAAVCvO2po+dekO5hB99iTYP6UEAzrEpjvsv/5AFAnN/PUFAp9PnN
        vQsxAFh4TXuVJ7I2id0gaqI=
X-Google-Smtp-Source: APXvYqz3bX9t942bsPfIdm5UWF5TE+oazNJbrYKmlWzscRMxFVemlmAHsAGgHRnb/Jr/wSRlzl3clg==
X-Received: by 2002:a37:a851:: with SMTP id r78mr28629493qke.120.1564587539523;
        Wed, 31 Jul 2019 08:38:59 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id f25sm35116803qta.81.2019.07.31.08.38.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 08:38:58 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        marc.zyngier@arm.com, james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com
Subject: [RFC v2 0/8] arm64: MMU enabled kexec relocation
Date:   Wed, 31 Jul 2019 11:38:49 -0400
Message-Id: <20190731153857.4045-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog from previous RFC:
- Added trans_table support for both hibernate and kexec.
- Fixed performance issue, where enabling MMU did not yield the
  actual performance improvement.

Bug:
With the current state, this patch series works on kernels booted with EL1
mode, but for some reason, when elevated to EL2 mode reboot freezes in
both QEMU and on real hardware.

The freeze happens in:

arch/arm64/kernel/relocate_kernel.S
	turn_on_mmu()

Right after sctlr_el2 is written (MMU on EL2 is enabled)

	msr     sctlr_el2, \tmp1

I've been studying all the relevant control registers for EL2, but do not
see what might be causing this hang:

MAIR_EL2 is set to be exactly the same as MAIR_EL1 0xbbff440c0400

TCR_EL2        0x80843510
Enabled bits:
PS      Physical Address Size. (0b100   44 bits, 16TB.)
SH0     Shareability    11 Inner Shareable
ORGN0   Normal memory, Outer Write-Back Read-Allocate Write-Allocate Cach.
IRGN0   Normal memory, Inner Write-Back Read-Allocate Write-Allocate Cach.
T0SZ    01 0000

SCTLR_EL2	0x30e5183f
RES1    : Reserve ones
M       : MMU enabled
A       : Align check
C       : Cacheability control
SA      : SP Alignment check enable
IESB    : Implicit Error Synchronization event
I       : Instruction access Cacheability

TTBR0_EL2      0x1b3069000 (address of trans_table)

Any suggestion of what else might be missing that causes this freeze when
MMU is enabled in EL2?

=====
Here is the current data from the real hardware:
(because of bug, I forced EL1 mode by setting el2_switch always to zero in
cpu_soft_restart()):

For this experiment, the size of kernel plus initramfs is 25M. If initramfs
was larger, than the improvements would be even greater, as time spent in
relocation is proportional to the size of relocation.

Previously:
kernel shutdown	0.022131328s
relocation	0.440510736s
kernel startup	0.294706768s

Relocation was taking: 58.2% of reboot time

Now:
kernel shutdown	0.032066576s
relocation	0.022158152s
kernel startup	0.296055880s

Now: Relocation takes 6.3% of reboot time

Total reboot is x2.16 times faster.

Previous approaches and discussions
-----------------------------------
https://lore.kernel.org/lkml/20190709182014.16052-1-pasha.tatashin@soleen.com
reserve space for kexec to avoid relocation, involves changes to generic code
to optimize a problem that exists on arm64 only:

https://lore.kernel.org/lkml/20190716165641.6990-1-pasha.tatashin@soleen.com
The first attempt to enable MMU, some bugs that prevented performance
improvement. The page tables unnecessary configured idmap for the whole
physical space.

Pavel Tatashin (8):
  kexec: quiet down kexec reboot
  arm64, mm: transitional tables
  arm64: hibernate: switch to transtional page tables.
  kexec: add machine_kexec_post_load()
  arm64, kexec: move relocation function setup and clean up
  arm64, kexec: add expandable argument to relocation function
  arm64, kexec: configure transitional page table for kexec
  arm64, kexec: enable MMU during kexec relocation

 arch/arm64/Kconfig                     |   4 +
 arch/arm64/include/asm/kexec.h         |  24 ++-
 arch/arm64/include/asm/pgtable-hwdef.h |   1 +
 arch/arm64/include/asm/trans_table.h   |  66 ++++++
 arch/arm64/kernel/asm-offsets.c        |  10 +
 arch/arm64/kernel/cpu-reset.S          |   4 +-
 arch/arm64/kernel/cpu-reset.h          |   8 +-
 arch/arm64/kernel/hibernate.c          | 261 ++++++------------------
 arch/arm64/kernel/machine_kexec.c      | 168 ++++++++++++---
 arch/arm64/kernel/relocate_kernel.S    | 238 +++++++++++++++-------
 arch/arm64/mm/Makefile                 |   1 +
 arch/arm64/mm/trans_table.c            | 272 +++++++++++++++++++++++++
 kernel/kexec.c                         |   4 +
 kernel/kexec_core.c                    |   8 +-
 kernel/kexec_file.c                    |   4 +
 kernel/kexec_internal.h                |   2 +
 16 files changed, 756 insertions(+), 319 deletions(-)
 create mode 100644 arch/arm64/include/asm/trans_table.h
 create mode 100644 arch/arm64/mm/trans_table.c

-- 
2.22.0

