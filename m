Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17547C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2C920740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574681751;
	bh=/OxRb1JiMgG2Ok2k8jEslF8kjMafEpu8P157ghwiQwg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=fhgDNv/OUHMBWwEPnePIiG6ffx/t2DfQftQlHV3WxLCHQ603YUU4R10tMij/TVAo1
	 KLuzPjqj7+fLeHlZhjxzot8PY1IgAj7YBQq5Yc1D0asWzg9uxNdRIY1j0nTu8EWqc8
	 Zox6BG21rCv/Bv4HZHLqLgSPL9vqqTebOUoxRopw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfKYLfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 06:35:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40956 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfKYLft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 06:35:49 -0500
Received: by mail-wr1-f68.google.com with SMTP id 4so14288387wro.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 03:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9w7n/BKyzsYuvkmUJcKisJsAXCTg6KEIxIdt4Udtsl0=;
        b=PdALz5PS9ufbiTrHrD2RzzNaagjOo+PkxGjhfv8xEpdi5w47EARxSXzDaFqIp2opdb
         ozyiGc08OWwvqvbPqxmaM+prMMp4EwcglOKWbFfWNcUOIdEi4sEnGs1sfbC0G5GGGaWF
         Nsi8cAX0a9uL+x6n0dGSIm+KZ3cH2ZeZYHH2uM0RLEeBEW40jFwx9t88Q9jIYHiGhGDE
         NdKrtaOZxCZ16xA3+vSGiP+eQkMdqjDyvfoAcYBIOsH7MaJHchokiTG6x3p+0ti5dM4w
         we5dEZRhwm6Qfb3OSe+68ddrx7CSTB/NiHFr4slPkwMsUpMUoNCqX3gaSL3lkoN4s3LS
         c/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=9w7n/BKyzsYuvkmUJcKisJsAXCTg6KEIxIdt4Udtsl0=;
        b=Fip9XxOa7PgFgCsHpVa8Mzd2YSo/n491Q6e67hVzFjj4Xknd1PqEotnR+whqfRJMEV
         rxBoeM66EdKeCqZpqxjH3XHl8Qa5c6vgPAQ8xLFk1xb2NCy/MUrWzkkro17tDJLTQlES
         FiTXmpy0ks3wi73Hn75zxkHM5474Wiykd+xabifw29LOLTt4L9mBI4DhZdfTnYBx4w7o
         C5oOego/OrLMSuqMQIDXDf1PDad72Ngdgl/cG9IRPpLsV+L/I/4YMHex0X7tfGhp6seJ
         e/Ba/YgGpuo/qcDVH71uzBz/ipd0UFAP/pyYOO3gl8AF9PnAUXb9IViWUpRs/h33FTjn
         NeLw==
X-Gm-Message-State: APjAAAXpklWqiHiS+kBNomeX0Gkya5oFhQ0gMMh6GY1vkyJ5m1ohpOTD
        D4zbjeCcef59Y6v8Rtv+n+I=
X-Google-Smtp-Source: APXvYqwWayoC6rFMpjLrKT6o4GM83wHMfKzozXfNiMZ9+QJq9YW0oA7JDgG1VDdCqWD/ziX1Zd2DSg==
X-Received: by 2002:a5d:50c3:: with SMTP id f3mr30198779wrt.14.1574681745347;
        Mon, 25 Nov 2019 03:35:45 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id p1sm8086434wmc.38.2019.11.25.03.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 03:35:44 -0800 (PST)
Date:   Mon, 25 Nov 2019 12:35:42 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking changes for v5.5
Message-ID: <20191125113542.GA109603@gmail.com>
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

   # HEAD: 500543c53a54134ced386aed85cd93cf1363f981 lkdtm: Remove references to CONFIG_REFCOUNT_FULL

The main changes in this cycle were:

 - A comprehensive rewrite of the robust/PI futex code's exit handling to 
   fix various exit races. (Thomas Gleixner et al)

 - Rework the generic REFCOUNT_FULL implementation using atomic_fetch_* 
   operations so that the performance impact of the cmpxchg() loops is 
   mitigated for common refcount operations.

   With these performance improvements the generic implementation of 
   refcount_t should be good enough for everybody - and this got 
   confirmed by performance testing, so remove ARCH_HAS_REFCOUNT and 
   REFCOUNT_FULL entirely, leaving the generic implementation enabled 
   unconditionally. (Will Deacon)

 - Other misc changes, fixes, cleanups.

 Thanks,

	Ingo

------------------>
Dan Carpenter (1):
      locking/lockdep: Update the comment for __lock_release()

Davidlohr Bueso (2):
      futex: Drop leftover wake_q_add() comment
      locking/mutex: Complain upon mutex API misuse in IRQ contexts

Qian Cai (1):
      locking/lockdep: Remove unused @nested argument from lock_release()

Thomas Gleixner (11):
      futex: Move futex exit handling into futex code
      futex: Replace PF_EXITPIDONE with a state
      exit/exec: Seperate mm_release()
      futex: Split futex_mm_release() for exit/exec
      futex: Set task::futex_state to DEAD right after handling futex exit
      futex: Mark the begin of futex exit explicitly
      futex: Sanitize exit state handling
      futex: Provide state handling for exec() as well
      futex: Add mutex around futex exit
      futex: Provide distinct return value when owner is exiting
      futex: Prevent exit livelock

Waiman Long (1):
      lib/smp_processor_id: Don't use cpumask_equal()

Will Deacon (10):
      locking/refcount: Define constants for saturation and max refcount values
      locking/refcount: Ensure integer operands are treated as signed
      locking/refcount: Remove unused refcount_*_checked() variants
      locking/refcount: Move the bulk of the REFCOUNT_FULL implementation into the <linux/refcount.h> header
      locking/refcount: Improve performance of generic REFCOUNT_FULL code
      locking/refcount: Move saturation warnings out of line
      locking/refcount: Consolidate REFCOUNT_{MAX,SATURATED} definitions
      locking/refcount: Consolidate implementations of refcount_t
      locking/refcount: Remove unused 'refcount_error_report()' function
      lkdtm: Remove references to CONFIG_REFCOUNT_FULL

Yang Tao (1):
      futex: Prevent robust futex exit race


 arch/Kconfig                                  |  21 --
 arch/arm/Kconfig                              |   1 -
 arch/arm64/Kconfig                            |   1 -
 arch/s390/configs/debug_defconfig             |   1 -
 arch/x86/Kconfig                              |   1 -
 arch/x86/include/asm/asm.h                    |   6 -
 arch/x86/include/asm/refcount.h               | 126 ----------
 arch/x86/mm/extable.c                         |  49 ----
 drivers/gpu/drm/drm_connector.c               |   2 +-
 drivers/gpu/drm/i915/Kconfig.debug            |   1 -
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c  |   6 +-
 drivers/gpu/drm/i915/gt/intel_engine_pm.c     |   2 +-
 drivers/gpu/drm/i915/i915_request.c           |   2 +-
 drivers/misc/lkdtm/refcount.c                 |  11 +-
 drivers/tty/tty_ldsem.c                       |   8 +-
 fs/dcache.c                                   |   2 +-
 fs/exec.c                                     |   2 +-
 fs/jbd2/transaction.c                         |   4 +-
 fs/kernfs/dir.c                               |   4 +-
 fs/ocfs2/dlmglue.c                            |   2 +-
 include/linux/compat.h                        |   2 -
 include/linux/futex.h                         |  40 +++-
 include/linux/jbd2.h                          |   2 +-
 include/linux/kernel.h                        |   7 -
 include/linux/lockdep.h                       |  21 +-
 include/linux/percpu-rwsem.h                  |   4 +-
 include/linux/rcupdate.h                      |   2 +-
 include/linux/refcount.h                      | 269 +++++++++++++++++----
 include/linux/rwlock_api_smp.h                |  16 +-
 include/linux/sched.h                         |   3 +-
 include/linux/sched/mm.h                      |   6 +-
 include/linux/seqlock.h                       |   4 +-
 include/linux/spinlock_api_smp.h              |   8 +-
 include/linux/ww_mutex.h                      |   2 +-
 include/net/sock.h                            |   2 +-
 kernel/bpf/stackmap.c                         |   2 +-
 kernel/cpu.c                                  |   2 +-
 kernel/exit.c                                 |  30 +--
 kernel/fork.c                                 |  40 ++--
 kernel/futex.c                                | 326 ++++++++++++++++++++++----
 kernel/locking/lockdep.c                      |   7 +-
 kernel/locking/mutex.c                        |   8 +-
 kernel/locking/rtmutex.c                      |   6 +-
 kernel/locking/rwsem.c                        |  10 +-
 kernel/panic.c                                |  11 -
 kernel/printk/printk.c                        |  10 +-
 kernel/sched/core.c                           |   2 +-
 lib/locking-selftest.c                        |  24 +-
 lib/refcount.c                                | 255 +++-----------------
 lib/smp_processor_id.c                        |   2 +-
 mm/memcontrol.c                               |   2 +-
 net/core/sock.c                               |   2 +-
 tools/lib/lockdep/include/liblockdep/common.h |   3 +-
 tools/lib/lockdep/include/liblockdep/mutex.h  |   2 +-
 tools/lib/lockdep/include/liblockdep/rwlock.h |   2 +-
 tools/lib/lockdep/preload.c                   |  16 +-
 56 files changed, 686 insertions(+), 716 deletions(-)
 delete mode 100644 arch/x86/include/asm/refcount.h
