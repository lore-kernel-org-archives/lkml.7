Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7E8C432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 22:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDDC20865
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 22:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575238935;
	bh=W0SYALR+gVbe+5ciHYtmLk2q9YczB+FZM78s6ZnMPoI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=IDKdgY5XUI80lZ1fiP29lo1K7vwigcYwER+ROoKl+i3p7ARp/+8ZonKc1eiMq5aWN
	 e5WgHi7RlZQckYSke+sQS5ftzTxpMJEUSEXaXkp6NPNHIvZl2JmbSROua073DoWNaN
	 dX7gj1kIv3mWkkcBaDZOWqhg2yFz4EoLp8UZl6NA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfLAWWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 17:22:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50515 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfLAWWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 17:22:14 -0500
Received: by mail-wm1-f68.google.com with SMTP id l17so19763572wmh.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2019 14:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BipLDQwj8/08vJKROQCDBTQtGOTsf5wIpOwEGjV4cQE=;
        b=HSxquPvdNJVnxvh8rcgBEXB7vfXiz2CkRligGh+jTgDWFymXDdhYUA40ZoL2/QjJdA
         hB+8S+O3mIB/oHlFRJxBo7/wbuNYWXW3YxLgnCWRdKIaZlqMwceN2x364uDBq5O/djfl
         ZuFRDq2eybDbXRPYnC+2sZSAjYAdUPFwJg9d9TQ9A9t6uJ25O53ZnbvvNemAwh9g7vm7
         TxqeMyOvVQuJUzaHRRupqRJAzI7YtwW+NMS8w3eVsfI7M2AFwGdvsArr8VNtmtv2Y5Av
         Y/zZo+TkeL9VL3daMKvqKxDabyzAGuGgqCQQyTpmcQNzTDUhBSBuBB8iA/G5E+Uh7VD0
         367g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=BipLDQwj8/08vJKROQCDBTQtGOTsf5wIpOwEGjV4cQE=;
        b=UhMIb8/jpSZRJmVpeHLhyO0JMqVOraXZ2kvFFFc7Ai7gPmqJ3GzDivg/xdgXEu8zvy
         5toosaT+2i594LEEWoYDmqftE9j+hYwVwp43u2M59QkgVC8xfszqFtpbs5ibfpR0/TpK
         s9PhJ8xpR0WVjQQTIsa0YAG9dPLbfMKHyOtG7Kzia6kPLuSuaUbdma9hrB1XxVf4dnHq
         qIeXj8JJpLNeNB9DL86e5H6Qn2IZ0P7jWO4+zQEd5VL3zxeBHvmiM6IqwOlan7pTSWe+
         EVUVtBA8vXGuLJOQ+CItUljDVWYj21gPEDL6v8pk1VA1A0Jn283B3DIb0yZ1JCP6IVfJ
         5uEg==
X-Gm-Message-State: APjAAAUhbTrM6RIzssO/k8TGYTNndcP3YZc7WrDU+pntGvj/uyBqPIAS
        45HNQhAocd2bUaMETk96IqmCvSC0
X-Google-Smtp-Source: APXvYqxHm2/dYSk5BGQplkArBJ9KGJAuIOP+5Vm6CmkuNc3mSZcgWaNV12/Eiee6uvBT3qvJsAAheg==
X-Received: by 2002:a1c:2186:: with SMTP id h128mr25993134wmh.14.1575238931775;
        Sun, 01 Dec 2019 14:22:11 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c15sm10144452wrt.1.2019.12.01.14.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2019 14:22:10 -0800 (PST)
Date:   Sun, 1 Dec 2019 23:22:08 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20191201222208.GA109470@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: 91298f1a302dad0f0f630413c812818636faa8a0 x86/mm/pat: Fix off-by-one bugs in interval tree search

Various fixes:

 - Fix the PAT performance regression that downgraded write-combining 
   device memory regions to uncached.

 - There's been a number of bugs in 32-bit double fault handling - 
   hopefully all fixed now.

 - Fix an LDT crash

 - Fix an FPU over-optimization that broke with GCC9 code optimizations.

 - Misc cleanups

 Thanks,

	Ingo

------------------>
Andy Lutomirski (9):
      selftests/x86/single_step_syscall: Check SYSENTER directly
      lkdtm: Add a DOUBLE_FAULT crash type on x86
      x86/traps: Disentangle the 32-bit and 64-bit doublefault code
      x86/doublefault/32: Rename doublefault.c to doublefault_32.c
      x86/doublefault/32: Move #DF stack and TSS to cpu_entry_area
      x86/doublefault/32: Rewrite the x86_32 #DF handler and unify with 64-bit
      x86/traps: die() instead of panicking on a double fault
      x86/ptrace: Remove set_segment_reg() implementations for current
      x86/ptrace: Document FSBASE and GSBASE ABI oddities

Borislav Petkov (2):
      x86/entry/32: Remove unused 'restore_all_notrace' local label
      x86/ioperm: Save an indentation level in tss_update_io_bitmap()

Ingo Molnar (1):
      x86/mm/pat: Fix off-by-one bugs in interval tree search

Joerg Roedel (1):
      x86/mm/32: Sync only to VMALLOC_END in vmalloc_sync_all()

Sebastian Andrzej Siewior (1):
      x86/fpu: Don't cache access to fpu_fpregs_owner_ctx


 arch/x86/Kconfig.debug                            |   2 +-
 arch/x86/entry/entry_32.S                         |  43 ++++++-
 arch/x86/include/asm/cpu_entry_area.h             |  12 ++
 arch/x86/include/asm/doublefault.h                |  13 +++
 arch/x86/include/asm/fpu/internal.h               |   2 +-
 arch/x86/include/asm/pgtable_32_types.h           |   7 +-
 arch/x86/include/asm/processor.h                  |   2 -
 arch/x86/include/asm/traps.h                      |   3 +
 arch/x86/kernel/Makefile                          |   4 +-
 arch/x86/kernel/cpu/common.c                      |  12 +-
 arch/x86/kernel/doublefault.c                     |  86 --------------
 arch/x86/kernel/doublefault_32.c                  | 136 ++++++++++++++++++++++
 arch/x86/kernel/dumpstack_32.c                    |  30 +++++
 arch/x86/kernel/process.c                         |  52 ++++-----
 arch/x86/kernel/ptrace.c                          |  36 ++++--
 arch/x86/kernel/traps.c                           |  31 +++--
 arch/x86/mm/cpu_entry_area.c                      |  14 ++-
 arch/x86/mm/fault.c                               |   2 +-
 arch/x86/mm/pat_interval.c                        |  12 +-
 drivers/misc/lkdtm/bugs.c                         |  39 +++++++
 drivers/misc/lkdtm/core.c                         |   3 +
 drivers/misc/lkdtm/lkdtm.h                        |   3 +
 tools/testing/selftests/x86/single_step_syscall.c |  94 +++++++++++++--
 23 files changed, 467 insertions(+), 171 deletions(-)
 create mode 100644 arch/x86/include/asm/doublefault.h
 delete mode 100644 arch/x86/kernel/doublefault.c
 create mode 100644 arch/x86/kernel/doublefault_32.c

