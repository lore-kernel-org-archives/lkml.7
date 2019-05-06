Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4B9C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568482082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557130361;
	bh=ujRXtNseWHYzyAqmy+mroJJZsY/+L41sUVWf9lkFOH8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=il7kMnTIPniGvHgY2//vJK15D3PasoxixaP5oyW9J8I0HBxEWTfuSSl4zPAo+RpMw
	 NhFyNpiEINUknq7U62oAbHN5VthInoxB6hhxRTtmP8RWeprQk/vfRfBeMxd/nnLe73
	 582F7whq2EzcfYcNqE+a/swbfK/Y80R4ylKn94A4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfEFIMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:12:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34975 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfEFIMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:12:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so13991739wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BC77NUTKaDpF37KYLTtxTjLD9VgTpMXCW8lMUp57UCQ=;
        b=e4r/JGBYDH49cPrP58BIdJz0KI8n6fO1xwMogLUNfBNqrOBzQQa4afmqezyiW4/KDa
         P4ko9WmWBO85xX7pV3PEKcr8M3aLOFPDM7ZsrschJLgi/DoZcoVGqNRmZszwNv9OjvpL
         2VHiwImaL0asf4HYkyo6123yX5o30FbXiCuTMw0gGj1Z0iE8Po3IxsNFDHTQmLv0m3Vw
         Tzg5ceIPoNr7B4QOzNDz7J3DtIq557wH2X7zqeYtfk60fN/zk7AVgrt5BEXF5KP4ltCZ
         2VJYXiW7oJK+QS4Tqtht13lAwuNPQDMwd2z3rDdltfvzDhgf3CPFGRxg7QzGiuZdJJBf
         fXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=BC77NUTKaDpF37KYLTtxTjLD9VgTpMXCW8lMUp57UCQ=;
        b=RTJycfNOd9Xa4fmeOKVjtQtNxM9VQ9OEfcVchVK5GVzZ68sc20fjZV+o7ieYgIvgVb
         08s5tELqhA9sl66bD9MlE3S5i/tH0tKGWpN5JxQ/CYM/SdFY8RMABBYxIer35KsTo4sO
         bFXnsGMrCjfGr35sKyffXQc2m787WsCF51Ql9Gcs6Jpcb5Dn8jdLOL8F4UZqZjFs0dUX
         4jOPO6yyGCoUbHPXyvZMILKPjsgDLvz8gwCD+/ZuWDi6ywEzdQy2nH7HgatNdQsKHf0A
         kvzy6bRyGcqYUmPz5RsbE/TKgDp5rJVRto3jsBwmg1ys+T93nFkBsdlmJ6QA/AETOwih
         oDqQ==
X-Gm-Message-State: APjAAAV/3UAILqDCqiIEhqkt+w14U5CD+KMkwYW3/Dax1h5XcIzyR4JY
        GXJz4/J8oFqm+ZILba+B4HTsCJFm
X-Google-Smtp-Source: APXvYqx/AidS8fbTvWU/hh6LBf7CRPgV9KQYV8++alNqnt+QvWr2rTtzbSmcExrBxQyIRyU9AFPdLw==
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr1970607wmk.66.1557130357282;
        Mon, 06 May 2019 01:12:37 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o130sm8422844wmo.43.2019.05.06.01.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 01:12:36 -0700 (PDT)
Date:   Mon, 6 May 2019 10:12:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] core/stacktrace updates for v5.2
Message-ID: <20190506081234.GA69602@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-stacktrace-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-stacktrace-for-linus

   # HEAD: 3599fe12a125fa7118da2bcc5033d7741fb5f3a1 x86/stacktrace: Use common infrastructure

So Thomas looked at the stacktrace code recently and noticed a few 
weirdnesses, and we all know how such stories of crummy kernel code 
meeting German engineering perfection end: a 45-patch series to clean it 
all up! :-)

Here's the changes in Thomas's words:

 "Struct stack_trace is a sinkhole for input and output parameters which is
  largely pointless for most usage sites. In fact if embedded into other data
  structures it creates indirections and extra storage overhead for no benefit.

  Looking at all usage sites makes it clear that they just require an
  interface which is based on a storage array. That array is either on stack,
  global or embedded into some other data structure.

  Some of the stack depot usage sites are outright wrong, but fortunately the
  wrongness just causes more stack being used for nothing and does not have
  functional impact.

  Another oddity is the inconsistent termination of the stack trace with
  ULONG_MAX. It's pointless as the number of entries is what determines the
  length of the stored trace. In fact quite some call sites remove the
  ULONG_MAX marker afterwards with or without nasty comments about it. Not
  all architectures do that and those which do, do it inconsistenly either
  conditional on nr_entries == 0 or unconditionally.

  The following series cleans that up by:

      1) Removing the ULONG_MAX termination in the architecture code

      2) Removing the ULONG_MAX fixups at the call sites

      3) Providing plain storage array based interfaces for stacktrace and
         stackdepot.

      4) Cleaning up the mess at the callsites including some related
         cleanups.

      5) Removing the struct stack_trace based interfaces

  This is not changing the struct stack_trace interfaces at the architecture
  level, but it removes the exposure to the generic code."

 Thanks,

	Ingo

------------------>
Thomas Gleixner (45):
      um/stacktrace: Remove the pointless ULONG_MAX marker
      x86/stacktrace: Remove the pointless ULONG_MAX marker
      arm/stacktrace: Remove the pointless ULONG_MAX marker
      sh/stacktrace: Remove the pointless ULONG_MAX marker
      unicore32/stacktrace: Remove the pointless ULONG_MAX marker
      riscv/stacktrace: Remove the pointless ULONG_MAX marker
      arm64/stacktrace: Remove the pointless ULONG_MAX marker
      parisc/stacktrace: Remove the pointless ULONG_MAX marker
      s390/stacktrace: Remove the pointless ULONG_MAX marker
      lockdep: Remove the ULONG_MAX stack trace hackery
      mm/slub: Remove the ULONG_MAX stack trace hackery
      mm/page_owner: Remove the ULONG_MAX stack trace hackery
      mm/kasan: Remove the ULONG_MAX stack trace hackery
      latency_top: Remove the ULONG_MAX stack trace hackery
      drm: Remove the ULONG_MAX stack trace hackery
      tracing: Remove the ULONG_MAX stack trace hackery
      tracing: Cleanup stack trace code
      stacktrace: Provide helpers for common stack trace operations
      lib/stackdepot: Provide functions which operate on plain storage arrays
      backtrace-test: Simplify stack trace handling
      proc: Simplify task stack retrieval
      latency_top: Simplify stack trace handling
      mm/slub: Simplify stack trace retrieval
      mm/kmemleak: Simplify stacktrace handling
      mm/kasan: Simplify stacktrace handling
      mm/page_owner: Simplify stack trace handling
      fault-inject: Simplify stacktrace retrieval
      dma/debug: Simplify stracktrace retrieval
      btrfs: ref-verify: Simplify stack trace retrieval
      dm bufio: Simplify stack trace retrieval
      dm persistent data: Simplify stack trace handling
      drm: Simplify stacktrace handling
      lockdep: Remove unused trace argument from print_circular_bug()
      lockdep: Remove save argument from check_prev_add()
      lockdep: Simplify stack trace handling
      tracing: Simplify stacktrace retrieval in histograms
      tracing: Use percpu stack trace buffer more intelligently
      tracing: Make ftrace_trace_userstack() static and conditional
      tracing: Simplify stack trace retrieval
      tracing: Remove the last struct stack_trace usage
      livepatch: Simplify stack trace retrieval
      stacktrace: Remove obsolete functions
      lib/stackdepot: Remove obsolete functions
      stacktrace: Provide common infrastructure
      x86/stacktrace: Use common infrastructure


 arch/arm/kernel/stacktrace.c                  |   6 -
 arch/arm64/kernel/stacktrace.c                |   4 -
 arch/parisc/kernel/stacktrace.c               |   5 -
 arch/riscv/kernel/stacktrace.c                |   2 -
 arch/s390/kernel/stacktrace.c                 |   6 -
 arch/sh/kernel/stacktrace.c                   |   4 -
 arch/um/kernel/stacktrace.c                   |   2 -
 arch/unicore32/kernel/stacktrace.c            |   2 -
 arch/x86/Kconfig                              |   1 +
 arch/x86/kernel/stacktrace.c                  | 128 ++--------
 drivers/gpu/drm/drm_mm.c                      |  25 +-
 drivers/gpu/drm/i915/i915_vma.c               |  11 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c       |  25 +-
 drivers/md/dm-bufio.c                         |  15 +-
 drivers/md/persistent-data/dm-block-manager.c |  19 +-
 fs/btrfs/ref-verify.c                         |  15 +-
 fs/proc/base.c                                |  17 +-
 include/linux/ftrace.h                        |  18 +-
 include/linux/lockdep.h                       |   9 +-
 include/linux/stackdepot.h                    |   8 +-
 include/linux/stacktrace.h                    |  81 +++++--
 kernel/backtracetest.c                        |  11 +-
 kernel/dma/debug.c                            |  14 +-
 kernel/latencytop.c                           |  29 +--
 kernel/livepatch/transition.c                 |  22 +-
 kernel/locking/lockdep.c                      |  87 +++----
 kernel/stacktrace.c                           | 333 ++++++++++++++++++++++++--
 kernel/trace/trace.c                          | 105 ++++----
 kernel/trace/trace.h                          |   8 -
 kernel/trace/trace_events_hist.c              |  14 +-
 kernel/trace/trace_stack.c                    |  85 +++----
 lib/Kconfig                                   |   4 +
 lib/fault-inject.c                            |  12 +-
 lib/stackdepot.c                              |  54 +++--
 mm/kasan/common.c                             |  35 +--
 mm/kasan/report.c                             |   7 +-
 mm/kmemleak.c                                 |  24 +-
 mm/page_owner.c                               |  82 +++----
 mm/slub.c                                     |  21 +-
 39 files changed, 694 insertions(+), 656 deletions(-)
