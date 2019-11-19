Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB7AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B357222EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574175381;
	bh=0Ljh4HfAXA7BAQs+eBmjHbb2K6a07lLbR0S63uNYi50=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=RKUhJknX4uT5ixTSHM3ucnHJSSymVNzogI6RahMh4JtYnmVidZuh9uPSL8FZX0pbk
	 728CvPrbCYqB8nJnvciHJy98vNdDasAZ7iK20COdrwaNqDfGkowLdbief6K/s0Emt3
	 rXr7DFSa+sg9myu5bsJeTvLquL7ovSXx5CC1i9/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfKSO4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:56:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfKSO4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:56:20 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99FE4222A0;
        Tue, 19 Nov 2019 14:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574175378;
        bh=0Ljh4HfAXA7BAQs+eBmjHbb2K6a07lLbR0S63uNYi50=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=nNqxkTunp73XruGKE4BEcS7t7f6t+aACKFK0b4f/xmPtLAjAOm9A32awUXo+QJQSC
         HTjtS3b0F3pJ+zSH2TzJ0IlwHh0xJlWlsjYYTwnYdL2lLPCJ7Ls2rLaPXWvunrA0Ss
         Ff7RPCVIGvgLDHLxtIwAMfnXiaIEj+Z8s7/79d4M=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4267D3520F2F; Tue, 19 Nov 2019 06:56:18 -0800 (PST)
Date:   Tue, 19 Nov 2019 06:56:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org
Cc:     elver@google.com, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au
Subject: [GIT RFC PULL kcsan] KCSAN commits for 5.5
Message-ID: <20191119145618.GA19028@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ingo,

This pull request contains base kernel concurrency sanitizer
(KCSAN) enablement for x86, courtesy of Marco Elver.  KCSAN is a
sampling watchpoint-based data-race detector, and is documented in
Documentation/dev-tools/kcsan.rst.  KCSAN was announced in September,
and much feedback has since been incorporated:

http://lkml.kernel.org/r/CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com

The data races located thus far have resulted in a number of fixes:

https://github.com/google/ktsan/wiki/KCSAN#upstream-fixes-of-data-races-found-by-kcsan

Additional information may be found here:

https://lore.kernel.org/lkml/20191114180303.66955-1-elver@google.com/

This has been subject to kbuild test robot and -next testing.  The
-next testing located a Kconfig conflict called out here:

https://lore.kernel.org/lkml/20191119183042.5839ef00@canb.auug.org.au/

Marco is satisfied with Stephen's resolution, and it looks good to me
as well.

The following changes since commit 31f4f5b495a62c9a8b15b1c3581acd5efeb9af8c:

  Linux 5.4-rc7 (2019-11-10 16:17:15 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo

for you to fetch changes up to 40d04110f87940b6a03bf0aa19cd29e84f465f20:

  x86, kcsan: Enable KCSAN for x86 (2019-11-16 07:23:16 -0800)

----------------------------------------------------------------
Marco Elver (9):
      kcsan: Add Kernel Concurrency Sanitizer infrastructure
      include/linux/compiler.h: Introduce data_race(expr) macro
      kcsan: Add Documentation entry in dev-tools
      objtool, kcsan: Add KCSAN runtime functions to whitelist
      build, kcsan: Add KCSAN build exceptions
      seqlock, kcsan: Add annotations for KCSAN
      seqlock: Require WRITE_ONCE surrounding raw_seqcount_barrier
      locking/atomics, kcsan: Add KCSAN instrumentation
      x86, kcsan: Enable KCSAN for x86

 Documentation/dev-tools/index.rst         |   1 +
 Documentation/dev-tools/kcsan.rst         | 256 ++++++++++++
 MAINTAINERS                               |  11 +
 Makefile                                  |   3 +-
 arch/x86/Kconfig                          |   1 +
 arch/x86/boot/Makefile                    |   2 +
 arch/x86/boot/compressed/Makefile         |   2 +
 arch/x86/entry/vdso/Makefile              |   3 +
 arch/x86/include/asm/bitops.h             |   6 +-
 arch/x86/kernel/Makefile                  |   4 +
 arch/x86/kernel/cpu/Makefile              |   3 +
 arch/x86/lib/Makefile                     |   4 +
 arch/x86/mm/Makefile                      |   4 +
 arch/x86/purgatory/Makefile               |   2 +
 arch/x86/realmode/Makefile                |   3 +
 arch/x86/realmode/rm/Makefile             |   3 +
 drivers/firmware/efi/libstub/Makefile     |   2 +
 include/asm-generic/atomic-instrumented.h | 393 ++++++++++---------
 include/linux/compiler-clang.h            |   9 +
 include/linux/compiler-gcc.h              |   7 +
 include/linux/compiler.h                  |  57 ++-
 include/linux/kcsan-checks.h              |  97 +++++
 include/linux/kcsan.h                     | 115 ++++++
 include/linux/sched.h                     |   4 +
 include/linux/seqlock.h                   |  51 ++-
 init/init_task.c                          |   8 +
 init/main.c                               |   2 +
 kernel/Makefile                           |   6 +
 kernel/kcsan/Makefile                     |  11 +
 kernel/kcsan/atomic.h                     |  27 ++
 kernel/kcsan/core.c                       | 626 ++++++++++++++++++++++++++++++
 kernel/kcsan/debugfs.c                    | 275 +++++++++++++
 kernel/kcsan/encoding.h                   |  94 +++++
 kernel/kcsan/kcsan.h                      | 108 ++++++
 kernel/kcsan/report.c                     | 320 +++++++++++++++
 kernel/kcsan/test.c                       | 121 ++++++
 kernel/sched/Makefile                     |   6 +
 lib/Kconfig.debug                         |   2 +
 lib/Kconfig.kcsan                         | 118 ++++++
 lib/Makefile                              |   3 +
 mm/Makefile                               |   8 +
 scripts/Makefile.kcsan                    |   6 +
 scripts/Makefile.lib                      |  10 +
 scripts/atomic/gen-atomic-instrumented.sh |  17 +-
 tools/objtool/check.c                     |  18 +
 45 files changed, 2623 insertions(+), 206 deletions(-)
 create mode 100644 Documentation/dev-tools/kcsan.rst
 create mode 100644 include/linux/kcsan-checks.h
 create mode 100644 include/linux/kcsan.h
 create mode 100644 kernel/kcsan/Makefile
 create mode 100644 kernel/kcsan/atomic.h
 create mode 100644 kernel/kcsan/core.c
 create mode 100644 kernel/kcsan/debugfs.c
 create mode 100644 kernel/kcsan/encoding.h
 create mode 100644 kernel/kcsan/kcsan.h
 create mode 100644 kernel/kcsan/report.c
 create mode 100644 kernel/kcsan/test.c
 create mode 100644 lib/Kconfig.kcsan
 create mode 100644 scripts/Makefile.kcsan
