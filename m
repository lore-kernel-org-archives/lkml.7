Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0094C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9F220830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557138469;
	bh=JsN3XUn/OEw+ppmk08ky2ye8AntLxGIS2FIWcjeh8Cs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Hew8GoDlan5zsiGV5c9qj2dUVGMhu7rNNi+FlBsKAwQBsxSRsqRCRnoK9gFX1DWfz
	 XEMHU/TFF50zv//kvX//EQ4ENiKUK89Gr8svrLKb5ge/ilBW1XYqBk93XiTt2Lc+r1
	 Hrigr9IHAR8sUwmNQcCqVXTGwicnPIHf32tIz0WM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfEFK1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 06:27:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36384 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFK1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 06:27:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so865449wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 03:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qfFFHRvbnzGcbJohPttiSpeh2kW+OlQVdh2SxkWyUcg=;
        b=otIiTTtVajYND8+FmVObkD/A7KF8ZVGo1Zbpse9H32MkmZ1Qmqw2SKBgl2BrAXBDyU
         lxTenf9YogFT2KLTtwfxxaqJ9oGHv9fnfXs77AKMmEI1ZRx1KcoBpELTr/laznah6fgT
         MPlfQEFDKPwCEZbo9pPLYk4xvqFpMbXn4k0nLQPkEaxrY7G8SWRo/pNWnBFHgowXJBkM
         bqVyQ3wqeP9XjKwS0nxgrkt7vkwI1AS/hI+Vnv4p5mIVePjgaWh8D/5nF81kGqp6Xfuk
         JcsSE5cWUq4zAuVn08A2n+NWvrk1a453Q9bKpLrvFtAKCQPrlEVVTWL9cFJRWV9ZHJsF
         zhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=qfFFHRvbnzGcbJohPttiSpeh2kW+OlQVdh2SxkWyUcg=;
        b=li3QJ9pOss+/sJUZSQjJihZSbT6qV5eoHCV9w/md9xn209n65GypsPli6K2jZOq6aQ
         mAlJg1iXF6qm0Mx7L8Uo+EfziDsRSpZcUiPFqAWuXzJeS78ivK+0GGUIBO2weulWzUsG
         Puw8ucIQaU31aNHj7uoewVUoo8Rvmpe53q2PfwF5pwZhHPNhAscegGuXsujcv2A7gWZV
         0Noy/cOLkvLX/icEixFS/E9+o9jKJ5oZwpBv8gz3AwH9kKY13ehxd8pZPNMWCrc7fDpA
         s1hjr5PRQoID2pOHzypg1X9CptxBz/+VHAcXG5LCmaN21Q9HgImffsVco+CyYP4CbFJd
         qjLg==
X-Gm-Message-State: APjAAAX9Goj6Y/2ClKS1Sz5BZesuz9pcJTckcVd7wsSwFFa27O14bU8F
        5j2KtW9bgnY8l0IZ38HY1aLp0Ubq
X-Google-Smtp-Source: APXvYqwIGO3Mekh362kEZo8BVpeRaeVC2OasEyRfgqcEi+176KQ1mJuueVtnWOgez5ytxtpVmbuN0A==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr4697689wmc.15.1557138465762;
        Mon, 06 May 2019 03:27:45 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o6sm22024818wre.60.2019.05.06.03.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 03:27:45 -0700 (PDT)
Date:   Mon, 6 May 2019 12:27:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [GIT PULL] x86/irq changes for v5.2
Message-ID: <20190506102742.GA119840@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-irq-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-for-linus

   # HEAD: 2c4645439e8f2f6e7c37f158feae6f6a82baa910 x86/irq: Fix outdated comments

Here are the main changes in this tree:

 - Introduce x86-64 IRQ/exception/debug stack guard pages to detect stack 
   overflows immediately and deterministically.

 - Clean up over a decade worth of cruft accumulated.

The outcome of this feature should be more clear-cut faults/crashes when 
any of the low level x86 CPU stacks overflow, instead of silent memory 
corruption and sporadic failures much later on.


  out-of-topic modifications in x86-irq-for-linus:
  --------------------------------------------------
  mm/slab.c                          # 80552f0f7aeb: mm/slab: Remove store_stacki

 Thanks,

	Ingo

------------------>
Andy Lutomirski (4):
      x86/dumpstack: Fix off-by-one errors in stack identification
      x86/irq/64: Remove a hardcoded irq_stack_union access
      x86/irq/64: Split the IRQ stack into its own pages
      x86/irq/64: Remap the IRQ stack with guard pages

Jiang Biao (1):
      x86/irq: Fix outdated comments

Qian Cai (1):
      mm/slab: Remove store_stackinfo()

Thomas Gleixner (27):
      x86/irq/64: Limit IST stack overflow check to #DB stack
      x86/irq/64: Sanitize the top/bottom confusion
      x86/idt: Remove unused macro SISTG
      x86/64: Remove stale CURRENT_MASK
      x86/exceptions: Remove unused stack defines on 32bit
      x86/exceptions: Make IST index zero based
      x86/cpu_entry_area: Cleanup setup functions
      x86/exceptions: Add structs for exception stacks
      x86/cpu_entry_area: Prepare for IST guard pages
      x86/cpu_entry_area: Provide exception stack accessor
      x86/traps: Use cpu_entry_area instead of orig_ist
      x86/irq/64: Use cpu entry area instead of orig_ist
      x86/dumpstack/64: Use cpu_entry_area instead of orig_ist
      x86/cpu: Prepare TSS.IST setup for guard pages
      x86/cpu: Remove orig_ist array
      x86/exceptions: Disconnect IST index and stack order
      x86/exceptions: Enable IST guard pages
      x86/exceptions: Split debug IST stack
      x86/dumpstack/64: Speedup in_exception_stack()
      x86/irq/32: Define IRQ_STACK_SIZE
      x86/irq/32: Make irq stack a character array
      x86/irq/32: Rename hard/softirq_stack to hard/softirq_stack_ptr
      x86/irq/64: Rename irq_stack_ptr to hardirq_stack_ptr
      x86/irq/32: Invoke irq_ctx_init() from init_IRQ()
      x86/irq/32: Handle irq stack allocation failure proper
      x86/irq/64: Init hardirq_stack_ptr during CPU hotplug
      x86/irq/64: Remove stack overflow debug code


 Documentation/x86/kernel-stacks       | 13 +++--
 arch/x86/Kconfig                      |  2 +-
 arch/x86/entry/entry_64.S             | 16 +++---
 arch/x86/include/asm/cpu_entry_area.h | 69 ++++++++++++++++++++++--
 arch/x86/include/asm/debugreg.h       |  2 -
 arch/x86/include/asm/irq.h            |  6 +--
 arch/x86/include/asm/irq_vectors.h    |  4 +-
 arch/x86/include/asm/page_32_types.h  |  8 ++-
 arch/x86/include/asm/page_64_types.h  | 16 +++---
 arch/x86/include/asm/processor.h      | 43 ++++++---------
 arch/x86/include/asm/smp.h            |  2 +-
 arch/x86/include/asm/stackprotector.h |  6 +--
 arch/x86/include/asm/stacktrace.h     |  2 +
 arch/x86/kernel/asm-offsets_64.c      |  4 +-
 arch/x86/kernel/cpu/common.c          | 60 ++++-----------------
 arch/x86/kernel/dumpstack_32.c        |  8 +--
 arch/x86/kernel/dumpstack_64.c        | 99 ++++++++++++++++++++++++-----------
 arch/x86/kernel/head_64.S             |  2 +-
 arch/x86/kernel/idt.c                 | 19 ++++---
 arch/x86/kernel/irq_32.c              | 41 ++++++++-------
 arch/x86/kernel/irq_64.c              | 89 +++++++++++++++----------------
 arch/x86/kernel/irqinit.c             |  4 +-
 arch/x86/kernel/nmi.c                 | 20 ++++++-
 arch/x86/kernel/setup_percpu.c        |  5 --
 arch/x86/kernel/smpboot.c             | 15 ++++--
 arch/x86/kernel/vmlinux.lds.S         |  7 +--
 arch/x86/mm/cpu_entry_area.c          | 64 +++++++++++++++-------
 arch/x86/mm/fault.c                   |  3 +-
 arch/x86/tools/relocs.c               |  2 +-
 arch/x86/xen/smp_pv.c                 |  4 +-
 arch/x86/xen/xen-head.S               | 10 ++--
 drivers/xen/events/events_base.c      |  1 -
 mm/slab.c                             | 48 +++--------------
 33 files changed, 377 insertions(+), 317 deletions(-)
