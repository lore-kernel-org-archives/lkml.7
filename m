Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A583C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121542087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557139243;
	bh=wQ2ktsr6a9u9eBcm1dGeb1ZEk3xPjJo5KhEaGtsKsGk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=YEEYSTw3MFItN5rqH4og3YVfuUVCYufGyC2d6BTHeo8izCVcGXaJDdGYHc4mXkYqE
	 UF1eS1bwdLslKNucM/5A67J+lHwWq775XlR8ekD8BtCr7l8dT2mz4RMvkC0XjfZ0ow
	 CzIR9TlCH9jIssxM+PEZ5p/RKJWeKAZut9gxbfQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfEFKkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 06:40:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34717 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfEFKkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 06:40:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id m20so5142620wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 03:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ijxsCt+TB//9DJtfbHRaO+c3pvussPa3AewCteTr1Hg=;
        b=cm4WCGSoQesOMJV0mmDe2ozMJOyLsbE7L+gy5HRxAFRvtKbNg6l/umR90WaVx7T5tt
         qFvkIqDdhBiGwyCKEJBOg3yVfsB0av2m3nQzU/XoAC6kn0xtwLy3SOgB4I7QJbj0jVdQ
         cXDvjvvXBcpG+FIQWYInlaLK7Q1Yo1Lt1goE5Mx+aPfG3kAGbd4UMfEIYU5o/fW5aRMF
         UOpQVKM9fBRlbz3mXc0+1FuQToNmQZF50TMgIeSeM1ZsBIRsIfVeo6YM3gNUFvFfdiXR
         Q0Z23giVrN3urdzwkLm0x9ztHpDagcSMyTOjzhDr1gOVYdjgtg0VFccOgd+pQM2rD3CQ
         WHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=ijxsCt+TB//9DJtfbHRaO+c3pvussPa3AewCteTr1Hg=;
        b=DNx9aN4CrLcoxdWS13wON+rSTdgGOtj3FrBwbTFI5jYwkoeDzdXoax/kWX497gpXOz
         tehU82deLiLuo5u9yHJhBQgul5J1DuaT0Qnli+cUN3csmHbVnO0P9v+2wuQESrhgpsM+
         qKzpYk2+cPpPDHxka/15Cqxym/QXp4MHZ8VJH49LAqdcANntSGlbMUK79E8wnMZOL9Hw
         bJQ6QnmpN4A49kbwCm3q/rwncHYbyoxmLgjJk6uSywgFB6OJWGfyI0frdbQn7cYevm68
         twoGsFOaw96ZqMIG8j1hmfrKm6UN8citbmJzt1d3mXah4914lNXEhwSXseuTkcLuZfxe
         PbVw==
X-Gm-Message-State: APjAAAXh8C71dzZTMK1r5UKzViaEMiJigSHboRaCacht40JOHVgfThh2
        eI5P9EITNvO83j9ICwISso6hFldP
X-Google-Smtp-Source: APXvYqxGkDZmTkkDSbpkuuqwZyKv0uLiWR/I7zO0+nCn2XLbI19Qh77QtU1bLOuckU6BiNPfXU3Lcg==
X-Received: by 2002:a1c:44d7:: with SMTP id r206mr15405366wma.129.1557139238454;
        Mon, 06 May 2019 03:40:38 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r9sm9261584wrv.82.2019.05.06.03.40.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 03:40:37 -0700 (PDT)
Date:   Mon, 6 May 2019 12:40:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [GIT PULL] x86/mm changes for v5.2
Message-ID: <20190506104035.GA39266@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-mm-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-for-linus

   # HEAD: caa841360134f863987f2d4f77b8dc2fbb7596f8 x86/mm: Initialize PGD cache during mm initialization

The changes in this tree are:

 - text_poke() fixes and an extensive set of executability lockdowns, to 
   (hopefully) eliminate the last residual circumstances under which we 
   are using W|X mappings even temporarily on x86 kernels. This required 
   a broad range of surgery in text patching facilities, module loading, 
   trampoline handling and other bits.

 - Tweak page fault messages to be more informative and more structured.

 - Remove DISCONTIGMEM support on x86-32 and make SPARSEMEM the default.

 - Reduce KASLR granularity on 5-level paging kernels from 512 GB to 1 GB.

 - Misc other changes and updates.

  out-of-topic modifications in x86-mm-for-linus:
  -------------------------------------------------
  arch/Kconfig                       # d253ca0c3865: x86/mm/cpa: Add set_direct_m
  include/asm-generic/pgtable.h      # caa841360134: x86/mm: Initialize PGD cache
  include/asm-generic/tlb.h          # 5932c9fd19e6: mm/tlb: Provide default nmi_
  include/linux/filter.h             # d53d2f78cead: bpf: Use vmalloc special fla
                                   # f2c65fb3221a: x86/modules: Avoid breaking 
  include/linux/mm.h                 # d63326928611: mm/hibernation: Make hiberna
  include/linux/sched/task.h         # 13585fa0668c: fork: Provide a function for
  include/linux/set_memory.h         # d253ca0c3865: x86/mm/cpa: Add set_direct_m
  include/linux/uprobes.h            # aad42dd44db0: uprobes: Initialize uprobes 
  include/linux/vmalloc.h            # 868b104d7379: mm/vmalloc: Add flag for fre
  kernel/bpf/core.c                  # d53d2f78cead: bpf: Use vmalloc special fla
  kernel/events/uprobes.c            # aad42dd44db0: uprobes: Initialize uprobes 
  kernel/module.c                    # 1a7b7d922081: modules: Use vmalloc special
                                   # f2c65fb3221a: x86/modules: Avoid breaking 
  kernel/power/snapshot.c            # d63326928611: mm/hibernation: Make hiberna
  kernel/trace/bpf_trace.c           # c7b6f29b6257: bpf: Fail bpf_probe_write_us
  mm/page_alloc.c                    # d63326928611: mm/hibernation: Make hiberna
  mm/vmalloc.c                       # 868b104d7379: mm/vmalloc: Add flag for fre

 Thanks,

	Ingo

------------------>
Andy Lutomirski (1):
      x86/mm: Introduce temporary mm structs

Baoquan He (2):
      x86/mm/KASLR: Use only one PUD entry for real mode trampoline
      x86/mm/KASLR: Reduce randomization granularity for 5-level paging to 1GB

Borislav Petkov (1):
      x86/fault: Make fault messages more succinct

Jiri Kosina (1):
      x86/mm: Remove in_nmi() warning from 64-bit implementation of vmalloc_fault()

Kees Cook (1):
      x86/build: Move _etext to actual end of .text

Mike Rapoport (2):
      x86/Kconfig: Make SPARSEMEM default for 32-bit x86
      x86/Kconfig: Deprecate DISCONTIGMEM support for 32-bit x86

Nadav Amit (18):
      x86/mm/tlb: Remove 'struct flush_tlb_info' from the stack
      x86/alternatives: Add text_poke_kgdb() to not assert the lock when debugging
      mm/tlb: Provide default nmi_uaccess_okay()
      bpf: Fail bpf_probe_write_user() while mm is switched
      x86/jump_label: Use text_poke_early() during early init
      x86/mm: Save debug registers when loading a temporary mm
      uprobes: Initialize uprobes earlier
      fork: Provide a function for copying init_mm
      x86/alternatives: Initialize temporary mm for patching
      x86/alternatives: Use temporary mm for text poking
      x86/kgdb: Avoid redundant comparison of patched code
      x86/ftrace: Set trampoline pages as executable
      x86/kprobes: Set instruction page as executable
      x86/modules: Avoid breaking W^X while loading modules
      x86/jump-label: Remove support for custom text poker
      x86/alternatives: Remove the return value of text_poke_*()
      x86/alternatives: Add comment about module removal races
      x86/mm: Initialize PGD cache during mm initialization

Rick Edgecombe (7):
      x86/mm/cpa: Add set_direct_map_*() functions
      mm/hibernation: Make hibernation handle unmapped pages
      mm/vmalloc: Add flag for freeing of special permsissions
      modules: Use vmalloc special flag
      bpf: Use vmalloc special flag
      x86/ftrace: Use vmalloc special flag
      x86/kprobes: Use vmalloc special flag

Sean Christopherson (2):
      x86/fault: Reword initial BUG message for unhandled page faults
      x86/fault: Decode and print #PF oops in human readable form

Stephen Kitt (1):
      x86/mm: Fix the 56-bit addresses memory map in Documentation/x86/x86_64/mm.txt


 Documentation/x86/x86_64/mm.txt      |   6 +-
 arch/Kconfig                         |   4 +
 arch/x86/Kconfig                     |  11 +-
 arch/x86/include/asm/fixmap.h        |   2 -
 arch/x86/include/asm/mmu_context.h   |  56 ++++++++++
 arch/x86/include/asm/pgtable.h       |   3 +
 arch/x86/include/asm/set_memory.h    |   3 +
 arch/x86/include/asm/text-patching.h |   7 +-
 arch/x86/include/asm/tlbflush.h      |   2 +
 arch/x86/kernel/alternative.c        | 201 +++++++++++++++++++++++++++--------
 arch/x86/kernel/ftrace.c             |  22 ++--
 arch/x86/kernel/jump_label.c         |  21 ++--
 arch/x86/kernel/kgdb.c               |  25 ++---
 arch/x86/kernel/kprobes/core.c       |  19 +++-
 arch/x86/kernel/module.c             |   2 +-
 arch/x86/kernel/vmlinux.lds.S        |   6 +-
 arch/x86/mm/fault.c                  |  55 ++++------
 arch/x86/mm/init.c                   |  37 +++++++
 arch/x86/mm/kaslr.c                  |  94 +++++++---------
 arch/x86/mm/pageattr.c               |  16 +--
 arch/x86/mm/pgtable.c                |  10 +-
 arch/x86/mm/tlb.c                    | 116 ++++++++++++++------
 arch/x86/xen/mmu_pv.c                |   2 -
 include/asm-generic/pgtable.h        |   2 +
 include/asm-generic/tlb.h            |   9 ++
 include/linux/filter.h               |  18 +---
 include/linux/mm.h                   |  18 ++--
 include/linux/sched/task.h           |   1 +
 include/linux/set_memory.h           |  11 ++
 include/linux/uprobes.h              |   5 +
 include/linux/vmalloc.h              |  15 +++
 init/main.c                          |   6 ++
 kernel/bpf/core.c                    |   1 -
 kernel/events/uprobes.c              |   8 +-
 kernel/fork.c                        |  25 +++--
 kernel/module.c                      |  82 +++++++-------
 kernel/power/snapshot.c              |   5 +-
 kernel/trace/bpf_trace.c             |   8 ++
 mm/page_alloc.c                      |   7 +-
 mm/vmalloc.c                         | 113 ++++++++++++++++----
 40 files changed, 711 insertions(+), 343 deletions(-)
