Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B7FC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D22C2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cmMwmE5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfCEVmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:42:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44342 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfCEVmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 16:42:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id j3so6542870pgm.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 13:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:cc:from:to:message-id;
        bh=XURuyW4/0JZAXwwF07kDW5Wg7eJQuF769RkLAzybchM=;
        b=cmMwmE5hRXltE/EMpYVzv+VQlE6r+VIfifz3v4IKv0euerY/ioUmZFpnU0y+DUO+6t
         Cbh6Y1FF4B0FAbY5Pi5anpJXyfTEUi0wXiyD5imrv3ei0H0wpCATUNN6KhZxugLECaNH
         IuwJEpigjJbEDJIkbQ4OZoqu8llx8DMa0rLgO/ydzJD6IuaMEX2MxiQWt67MsdFpii43
         suUQCAeXaKEZaRHZc/YXLoW4yv9nmcxYJRderN/WwHn7GvM2qt3/qNPwj9dm0do7lKhL
         lMtJcvHUstkCmO4y/dY0HQmmeinLQZejRqasqjsZrFzj0enRl63AL3hHVdJ8treYNw9L
         Rs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=XURuyW4/0JZAXwwF07kDW5Wg7eJQuF769RkLAzybchM=;
        b=CcdUiH212QL7A+WsbyNde4vAgs9lcLdkgJeOMpk9ewR25G6MRbTwmSj+coYf/VsCk0
         K09sUmUrNC8fn28pv/XJ05nXAY6xQl9gQregympgNUBfW9sg6p59SLFarvQiJ1SebWGq
         g1PxWQGHuAfZwQlbed1mnYl0KB7pRFB6gdfF3kX0Z/UPmMf8wYvWH8/XWN7FhAiTTnsU
         MJTob5Zho1UhSnFOtlYlknwro7NS3HG4IeQGYowzBTV/2F81nySFAQDOFAO7TrzvdNa0
         V9D+IUEqdkNFZzNbAESa4xesl46q7Js60VLb5iGt+54tGL/riGg62cYin6wLGmsI/p9/
         YEsg==
X-Gm-Message-State: APjAAAXTi9cVg6jKx2Fws7nUzmk83HjaJTFHJ/1befR5VB7j7WV7Avaf
        Yz62jntITR+DOHluN6sgTBsVJFVFfFMVbQ==
X-Google-Smtp-Source: APXvYqxiV2wn4mNG1Gv1QwYNeAVlBwkmgQCX1+ULbxfQlVnJ2vzi3HiSxNpfyxQP0bPINpRl+fikMw==
X-Received: by 2002:a62:f51d:: with SMTP id n29mr3858271pfh.21.1551822135966;
        Tue, 05 Mar 2019 13:42:15 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id d5sm13197208pfo.83.2019.03.05.13.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 13:42:15 -0800 (PST)
Date:   Tue, 05 Mar 2019 13:42:15 -0800 (PST)
X-Google-Original-Date: Tue, 05 Mar 2019 13:40:41 PST (-0800)
Subject: [GIT PULL] RISC-V Patches for the 5.1 Merge Window, Part 1
CC:     linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org
Message-ID: <mhng-abd0b24c-3a6c-47bf-9b0c-e069cef41489@palmer-si-x1c4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 41fb9d54f12b87fb1f670653e95d34668a08e8ee:

  Revert "RISC-V: Make BSS section as the last section in vmlinux.lds.S" (2019-02-11 15:24:45 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-5.1-mw0

for you to fetch changes up to 13fd5de06514458eb320188b7a815d65696efd99:

  RISC-V: Fixmap support and MM cleanups (2019-03-04 11:47:04 -0800)

----------------------------------------------------------------
RISC-V Patches for the 5.1 Merge Window, Part 1

This contains the vast majority of the RISC-V patches for this merge
window.  It includes:

* A handful of cleanups to our kernel prints, most of which are things I
  should have caught the first time.
* We now provide an HWCAP that contains the ISA extensions that all
  enabled processors support, as supposed to just looking at the first
  enabled processor.
* We no longer spin forever waiting for all harts to boot.
* A fixmap implementation, which is coupled to some cleanups in our MM
  code.

The only outstanding patches I know of right now are Vincent Chen's
patches to fix c.ebreak handling in the kernel, the v2 of which was
posted this morning.  I'd like those in the MW, but I didn't want to
hold up everything else.  The patch set is based on top of my last fixes
submission, but I've tested it with a conflict-free merge from v5.0.
I'm doing this rather than my "just go rebase everything" flow due to a
discussion with Linus, but if I misunderstood then just let me know and
I'll do something else.  It's also the first time I've taken a PR into
my own tree, so let me know if I screwed that one up.

I've used my standard testing flow (QEMU in Fedora), but now that we're
starting to get the kernel in better shape I think it's time to impose
some more testing here -- specifically I'm going to require that patches
boot on the HiFive Unleashed because we're getting to the point where we
can actually expect that to work.  I haven't done that for this tag, but
I'm going to do it for future ones.

I know the board is a bit expensive and not everyone has one, but if
I've sent you a free one and your patches break the boot then I'm going
to yell at you :).  If you don't have one then please indicate how you
tested in your cover letter, and if you have a board then please add
your Tested-by to patches if they work for your testing flow.

----------------------------------------------------------------
Andreas Schwab (1):
      arch: riscv: fix logic error in parse_dtb

Anup Patel (5):
      RISC-V: Setup init_mm before parse_early_param()
      RISC-V: Move setup_bootmem() to mm/init.c
      RISC-V: Move setup_vm() to mm/init.c
      RISC-V: Implement compile-time fixed mappings
      RISC-V: Free-up initrd in free_initrd_mem()

Atish Patra (6):
      RISC-V: Do not wait indefinitely in __cpu_up
      RISC-V: Move cpuid to hartid mapping to SMP.
      RISC-V: Remove NR_CPUs check during hartid search from DT
      RISC-V: Allow hartid-to-cpuid function to fail.
      RISC-V: Compare cpuid with NR_CPUS before mapping.
      RISC-V: Assign hwcap as per comman capabilities.

Christoph Hellwig (1):
      riscv: remove the HAVE_KPROBES option

Johan Hovold (5):
      riscv: add missing newlines to printk messages
      riscv: use pr_info and friends
      riscv: fix riscv_of_processor_hartid() comment
      riscv: treat cpu devicetree nodes without status as enabled
      riscv: use for_each_of_cpu_node iterator

Palmer Dabbelt (1):
      RISC-V: Fixmap support and MM cleanups

 arch/riscv/Kconfig               |   6 +-
 arch/riscv/include/asm/fixmap.h  |  44 +++++++++++
 arch/riscv/include/asm/pgtable.h |   1 +
 arch/riscv/include/asm/smp.h     |  18 +++--
 arch/riscv/kernel/cpu.c          |  30 +++-----
 arch/riscv/kernel/cpufeature.c   |  48 ++++++------
 arch/riscv/kernel/ftrace.c       |   2 +-
 arch/riscv/kernel/setup.c        | 141 ++---------------------------------
 arch/riscv/kernel/smp.c          |  10 ++-
 arch/riscv/kernel/smpboot.c      |  24 ++++--
 arch/riscv/mm/init.c             | 156 ++++++++++++++++++++++++++++++++++++++-
 11 files changed, 287 insertions(+), 193 deletions(-)
 create mode 100644 arch/riscv/include/asm/fixmap.h
