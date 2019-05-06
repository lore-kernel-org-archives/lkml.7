Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD261C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800AC2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557132620;
	bh=wzHqfWVJQM2qdwIT23zgFQ/XKSmjU9U2GhZ3uO7C5Lg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=kTOSy/WLHEgx3FaPXdp39tgdVHGGRpFrbmNZFoYmi/j9U3GW76+InR6fgPSc4g6cB
	 FoAYxScnsTD/11oR6bdKgdd11+SfHhNjGi9xfwok3cVOfGVuMMXRSpLJTgbxHf4agz
	 r16JpLwETXwXSqdi4GLjHn8IgedvfaOA6pCMsfZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfEFIuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:50:19 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:52360 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfEFIuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:50:18 -0400
Received: by mail-wm1-f41.google.com with SMTP id o25so3594777wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YyTgewxJ9ULvLwNIhTkHnKAAdCD5wqm5JBkzLVUOVbs=;
        b=nAomvzg4YJ4kiG+XuJ/CKyZjCjX8MArX+eOy2dzfdKXJ34SNV8VO3aMMHjp7xMMbla
         WoFNfJqK6KGeasz0d3qWe3zEeXFzFyPUfvzH6OPDCBUFhIRAMivnLam4p2EENsAx0wLB
         f1WnSNS6hIveJIm74VCOIAJhJ/OzniZfjHEAgSRd5ATVxC9KrqTzMrDBZW/ZRap4Q7yB
         pX3FVJWPM0HwDCs0Ml1FcLIAbe7pI4YM199XcdW25aHm2X0WxdQvnqHDoXrsmr6oMmvT
         faXPneYNSLm+ZCPuEcr76Vd+XbuEBh7a9RobPVKPtkDaPnmhRZf5TryZLKzaB40WLHPJ
         CwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=YyTgewxJ9ULvLwNIhTkHnKAAdCD5wqm5JBkzLVUOVbs=;
        b=Z/XHVzOOWl/SJ6apydjw/HqhUyIS2g0o90/b29sZkuHLN/q5mS9yGnn6z17LT2kC+e
         XB7maQ8GGBCTeJFjlZGzn0PU7xtAs2bnL/1e3AAw74RM8vK5oAyC6/5VsuUtd88cKjre
         u8u+vqCsbOzWhOSwi1EdPjY4CSo0ShGdNAusCKkEtovBfC3kiEsNZdrjsjuxozr0CoNa
         N2jfLObpKXzbBJR7VDS92gFd+8is2hKvVlliYqb7CUO8Nnj3U+O09wHnTYGg8MLhq+1X
         iOWarRaaJkY/z0b35Du2D0V3Omk6KkRWZeTaQoMm4QiqiKosOolobs+G5+uZMtm7N2o8
         3mog==
X-Gm-Message-State: APjAAAUSqJz2jbOVVg2YdGuVmJ6Ml824L8bUHzIQXwvcGaa173sZAW59
        ZDfvlnGAHQCTGK9aKEWBNnc=
X-Google-Smtp-Source: APXvYqyFCnU5xR0gqARFaHOMc3+q/UDKCiWrmgEzggPEU9dwDqB9WUXS6H3pO7WIMng+Te3+auf/aA==
X-Received: by 2002:a1c:a74f:: with SMTP id q76mr6753359wme.152.1557132616584;
        Mon, 06 May 2019 01:50:16 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i9sm6306532wmb.4.2019.05.06.01.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 01:50:15 -0700 (PDT)
Date:   Mon, 6 May 2019 10:50:14 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking changes for v5.2
Message-ID: <20190506085014.GA130963@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-for-linus

   # HEAD: d671002be6bdd7f77a771e23bf3e95d1f16775e6 locking/lockdep: Remove unnecessary unlikely()

[ Dependency note: this tree depends on commits also in the RCU tree, 
  please disregard this pull request if you weren't able to pull the RCU 
  tree for some reason. ]

Here are the locking changes in this cycle:

 - rwsem unification and simpler micro-optimizations to prepare for more 
   intrusive (and more lucrative) scalability improvements in v5.3
   (Waiman Long)

 - Lockdep irq state tracking flag usage cleanups (Frederic Weisbecker)

 - static key improvements (Jakub Kicinski, Peter Zijlstra)

 - misc updates, cleanups and smaller fixes.

 Thanks,

	Ingo

------------------>

Arnd Bergmann (1):
      locking/lockdep: Avoid bogus Clang warning

Frederic Weisbecker (4):
      locking/lockdep: Move valid_state() inside CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING
      locking/lockdep: Map remaining magic numbers to lock usage mask names
      locking/lockdep: Use expanded masks on find_usage_*() functions
      locking/lockdep: Test all incompatible scenarios at once in check_irq_usage()

Ingo Molnar (3):
      Merge branch 'linus' into locking/core, to pick up fixes
      Merge branch 'lkmm-for-mingo' of git://git.kernel.org/.../paulmck/linux-rcu into locking/core
      Merge branch 'locking-core-for-linus' into linus

Jakub Kicinski (3):
      locking/static_key: Add support for deferred static branches
      locking/static_key: Factor out the fast path of static_key_slow_dec()
      locking/static_key: Don't take sleeping locks in __static_key_slow_dec_deferred()

Peter Zijlstra (2):
      locking/static_key: Fix false positive warnings on concurrent dec/inc
      locking/lockdep: Generate LOCKF_ bit composites

Waiman Long (15):
      locking/rwsem: Remove arch specific rwsem files
      locking/rwsem: Remove rwsem-spinlock.c & use rwsem-xadd.c for all archs
      locking/rwsem: Optimize down_read_trylock()
      locking/rwsem: Relocate rwsem_down_read_failed()
      locking/rwsem: Move owner setting code from rwsem.c to rwsem.h
      locking/rwsem: Move rwsem internal function declarations to rwsem-xadd.h
      locking/rwsem: Micro-optimize rwsem_try_read_lock_unqueued()
      locking/rwsem: Add debug check for __down_read*()
      locking/rwsem: Enhance DEBUG_RWSEMS_WARN_ON() macro
      locking/qspinlock_stat: Introduce generic lockevent_*() counting APIs
      locking/lock_events: Make lock_events available for all archs & other locks
      locking/lock_events: Don't show pvqspinlock events on bare metal
      locking/rwsem: Enable lock event counting
      locking/rwsem: Optimize rwsem structure for uncontended lock acquisition
      locking/rwsem: Prevent unneeded warning during locking selftest

zhengbin (1):
      locking/lockdep: Remove unnecessary unlikely()

 MAINTAINERS                          |   1 -
 arch/Kconfig                         |   9 +
 arch/alpha/Kconfig                   |   7 -
 arch/alpha/include/asm/rwsem.h       | 211 ----------------------
 arch/arc/Kconfig                     |   3 -
 arch/arm/Kconfig                     |   4 -
 arch/arm/include/asm/Kbuild          |   1 -
 arch/arm64/Kconfig                   |   3 -
 arch/arm64/include/asm/Kbuild        |   1 -
 arch/c6x/Kconfig                     |   3 -
 arch/csky/Kconfig                    |   3 -
 arch/h8300/Kconfig                   |   3 -
 arch/hexagon/Kconfig                 |   6 -
 arch/hexagon/include/asm/Kbuild      |   1 -
 arch/ia64/Kconfig                    |   4 -
 arch/ia64/include/asm/rwsem.h        | 172 ------------------
 arch/m68k/Kconfig                    |   7 -
 arch/microblaze/Kconfig              |   6 -
 arch/mips/Kconfig                    |   7 -
 arch/nds32/Kconfig                   |   3 -
 arch/nios2/Kconfig                   |   3 -
 arch/openrisc/Kconfig                |   6 -
 arch/parisc/Kconfig                  |   6 -
 arch/powerpc/Kconfig                 |   7 -
 arch/powerpc/include/asm/Kbuild      |   1 -
 arch/riscv/Kconfig                   |   3 -
 arch/s390/Kconfig                    |   6 -
 arch/s390/include/asm/Kbuild         |   1 -
 arch/sh/Kconfig                      |   6 -
 arch/sh/include/asm/Kbuild           |   1 -
 arch/sparc/Kconfig                   |   8 -
 arch/sparc/include/asm/Kbuild        |   1 -
 arch/unicore32/Kconfig               |   6 -
 arch/x86/Kconfig                     |  11 --
 arch/x86/include/asm/rwsem.h         | 237 ------------------------
 arch/x86/lib/Makefile                |   1 -
 arch/x86/lib/rwsem.S                 | 156 ----------------
 arch/x86/um/Kconfig                  |   6 -
 arch/x86/um/Makefile                 |   4 +-
 arch/xtensa/Kconfig                  |   3 -
 arch/xtensa/include/asm/Kbuild       |   1 -
 include/asm-generic/rwsem.h          | 140 ---------------
 include/linux/jump_label_ratelimit.h |  64 ++++++-
 include/linux/lockdep.h              |   2 +-
 include/linux/rwsem-spinlock.h       |  47 -----
 include/linux/rwsem.h                |  37 ++--
 kernel/Kconfig.locks                 |   2 +-
 kernel/jump_label.c                  |  63 ++++---
 kernel/locking/Makefile              |   5 +-
 kernel/locking/lock_events.c         | 179 ++++++++++++++++++
 kernel/locking/lock_events.h         |  59 ++++++
 kernel/locking/lock_events_list.h    |  67 +++++++
 kernel/locking/lockdep.c             | 267 ++++++++++++++++++---------
 kernel/locking/lockdep_internals.h   |  34 +++-
 kernel/locking/percpu-rwsem.c        |   2 +
 kernel/locking/qspinlock.c           |   8 +-
 kernel/locking/qspinlock_paravirt.h  |  19 +-
 kernel/locking/qspinlock_stat.h      | 242 +++++--------------------
 kernel/locking/rwsem-spinlock.c      | 339 -----------------------------------
 kernel/locking/rwsem-xadd.c          | 204 +++++++++++----------
 kernel/locking/rwsem.c               |  25 +--
 kernel/locking/rwsem.h               | 174 +++++++++++++++++-
 62 files changed, 983 insertions(+), 1925 deletions(-)
