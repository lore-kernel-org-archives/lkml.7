Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC3AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35CA218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551373973;
	bh=GypjQ9nVMHLfr4z0oOCb+10wmkNy33x0AF1jEdm5Z24=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=jehVTCgQE5OmEtqMcevwcavFjl0An8Z7uJlK3meWNXtekJ27AE3JjLFw2201e5286
	 HkAWsRSldYOGk9sbdkS99k1OP/1SCTJK7H4p7+S8B3K9iI5SO5OUhTM/vBW+EFjCa9
	 1TNM6rsne4B/AyTzjU0yL3Gz+KPfDkNiDPlMQONc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387480AbfB1RMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:12:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:57674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733080AbfB1RMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:12:51 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B7EB218AE;
        Thu, 28 Feb 2019 17:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551373970;
        bh=GypjQ9nVMHLfr4z0oOCb+10wmkNy33x0AF1jEdm5Z24=;
        h=From:To:Cc:Subject:Date:From;
        b=bK3RUfYmmnFrIEp9UJWyIyKavlEqW6emYgU8a1T3ZYgfb8yyAkYpL6byE7MEl9fZq
         Mr21RoDUMM9zvx/+afbXKccw0mJz+sLfMrCNWXsxRHTD507cLXspWX165jP6uzXcSl
         3a83OvMLHq+IJYu3dKsJX2RCAauRBnCkUOHYK9Nc=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 00/37] softirq: Per vector masking v3 
Date:   Thu, 28 Feb 2019 18:12:05 +0100
Message-Id: <20190228171242.32144-1-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So this set should hopefully address all reviews from the v2, and
fix all reports from the extremely useful (as always) Kbuild testing
bot. It also completes support for all archs.

Unfortunately the already huge pile is ever growing. I should be able to
offload 2 or 3 of those patches but the rest really belong together.

Changes since v2:

* Fix unused function warning (reported by Kbuild test robot)
    - locking/lockdep: Move valid_state() inside CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING

* Added Reviewed-by tags from davem

* Reorder changes introducing u64 to the proper patches (reported by Linus)

* Fix lock usage mask iteration by avoid shifting beyond 63 (reported by Linus)
    - locking/lockdep: Introduce lock usage mask iterator

* Fix mark_lock() verbosity by handling all usages in the ask
    - locking/lockdep: Report all usages on mark_lock() verbosity mode

* Add SPDX licence identifier on softirq_vector.h (reported by Sebastian)

* Fix several build errors on s390 (reported by Kbuild test robot)
    - arch/softirq: Rename softirq_pending fields to softirq_data
    - softirq: Introduce disabled softirq vectors bits
    - softirq: Check enabled vectors before processing

* Initialize softirq enabled field on all other archs than x86
    - parisc: Init softirq enabled field
    - powerpc: Init softirq enabled field
    - softirq: Init softirq enabled field for default irq_stat definition

* Fix spin_[un]lock_bh_mask() on UP, also some build errors against uninlined spinlocks (reported by Kbuild test robot)
    - locking: Introduce spin_[un]lock_bh_mask()

* Socket lock may also execute on HRTIMER_SOFTIRQ, include it on the mask (reported by Sebastian)
    - net: Make softirq vector masking finegrained on release_sock()


git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	softirq/soft-interruptible-v2

HEAD: 63c89028058f5920d4b5a9d38452fa4623469583

Thanks,
	Frederic
---

Frederic Weisbecker (37):
      locking/lockdep: Move valid_state() inside CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING
      locking/lockdep: Use expanded masks on find_usage_*() functions
      locking/lockdep: Introduce struct lock_usage
      locking/lockdep: Convert usage_mask to u64
      locking/lockdep: Introduce lock usage mask iterator
      locking/lockdep: Test all incompatible scenario at once in check_irq_usage()
      locking/lockdep: Prepare valid_state() to handle plain masks
      locking/lockdep: Prepare check_usage_*() to handle plain masks
      locking/lockdep: Prepare state_verbose() to handle all softirqs
      locking/lockdep: Make mark_lock() fastpath to work with multiple usage at once
      locking/lockdep: Save stack trace for each softirq vector involved
      locking/lockdep: Report all usages on mark_lock() verbosity mode
      softirq: Macrofy softirq vectors
      locking/lockdep: Define per vector softirq lock usage states
      softirq: Pass softirq vector number to lockdep on vector execution
      x86: Revert "x86/irq: Demote irq_cpustat_t::__softirq_pending to u16"
      arch/softirq: Rename softirq_pending fields to softirq_data
      softirq: Normalize softirq_pending naming scheme
      softirq: Convert softirq_pending_*() to set/clear mask scheme
      softirq: Introduce disabled softirq vectors bits
      softirq: Rename _local_bh_enable() to local_bh_enable_no_softirq()
      softirq: Move vectors bits to bottom_half.h
      x86: Init softirq enabled field
      parisc: Init softirq enabled field
      powerpc: Init softirq enabled field
      softirq: Init softirq enabled field for default irq_stat definition
      softirq: Check enabled vectors before processing
      softirq: Remove stale comment
      softirq: Uninline !CONFIG_TRACE_IRQFLAGS __local_bh_disable_ip()
      softirq: Prepare for mixing all/per-vector masking
      softirq: Support per vector masking
      locking/lockdep: Remove redundant softirqs on check
      locking/lockdep: Update check_flags() according to new layout
      locking/lockdep: Branch the new vec-finegrained softirq masking to lockdep
      softirq: Allow to soft interrupt vector-specific masked contexts
      locking: Introduce spin_[un]lock_bh_mask()
      net: Make softirq vector masking finegrained on release_sock()


 arch/arm/include/asm/hardirq.h      |   2 +-
 arch/arm64/include/asm/hardirq.h    |   2 +-
 arch/h8300/kernel/asm-offsets.c     |   2 +-
 arch/ia64/include/asm/hardirq.h     |   2 +-
 arch/ia64/include/asm/processor.h   |   2 +-
 arch/m68k/include/asm/hardirq.h     |   2 +-
 arch/m68k/kernel/asm-offsets.c      |   2 +-
 arch/parisc/include/asm/hardirq.h   |   2 +-
 arch/parisc/kernel/irq.c            |   6 +-
 arch/powerpc/include/asm/hardirq.h  |   2 +-
 arch/powerpc/kernel/irq.c           |   5 +-
 arch/s390/include/asm/hardirq.h     |  11 +-
 arch/s390/include/asm/lowcore.h     |   2 +-
 arch/s390/lib/delay.c               |   2 +-
 arch/sh/include/asm/hardirq.h       |   2 +-
 arch/sparc/include/asm/cpudata_64.h |   2 +-
 arch/sparc/include/asm/hardirq_64.h |   4 +-
 arch/um/include/asm/hardirq.h       |   2 +-
 arch/x86/include/asm/hardirq.h      |   2 +-
 arch/x86/kernel/irq.c               |   5 +-
 drivers/s390/char/sclp.c            |   2 +-
 drivers/s390/cio/cio.c              |   2 +-
 include/asm-generic/hardirq.h       |   2 +-
 include/linux/bottom_half.h         |  41 +++-
 include/linux/interrupt.h           |  87 ++++---
 include/linux/irqflags.h            |  12 +-
 include/linux/lockdep.h             |   5 +-
 include/linux/softirq_vector.h      |  12 +
 include/linux/spinlock.h            |  14 ++
 include/linux/spinlock_api_smp.h    |  28 +++
 include/linux/spinlock_api_up.h     |  13 +
 kernel/locking/lockdep.c            | 475 ++++++++++++++++++++++++------------
 kernel/locking/lockdep_internals.h  |  50 +++-
 kernel/locking/lockdep_proc.c       |   2 +-
 kernel/locking/lockdep_states.h     |   4 +-
 kernel/locking/spinlock.c           |  19 ++
 kernel/softirq.c                    | 163 +++++++++----
 lib/locking-selftest.c              |   4 +-
 net/core/sock.c                     |   8 +-
 39 files changed, 715 insertions(+), 289 deletions(-)
