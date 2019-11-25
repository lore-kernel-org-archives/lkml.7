Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332C9C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CCC20674
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574683899;
	bh=tjL85nc5dg+xALnMiVnqlzSIVK3YVkjWxBJIeaFxBhc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=NN0o+MQTYEfBU3ngT8s/p4wNOrqJRNswppMkUG/Zvu1aiPgd72bcg716ZQ62QtCv0
	 DoxWr/BKLCPeXRRbWpbfABwQr+fp2FkjeoxP7ao7k75RCm6T4GMQFQpEqsgZGASLMa
	 BrZJh+7kp3joNsanjJ/WRyitSUD+ggY6kjm+KiVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfKYMLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 07:11:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33847 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfKYMLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 07:11:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id j18so16046713wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 04:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YZIIp6uG4nYB2xO6MENEMk3qQv64nQTMspRnfypnhVo=;
        b=jv/yHxV0OST3PnxfuNfwGhVP/tNn/neQqKWpkvk2zoXGVnwTvZwC52lEkpMjPE8tdk
         WZSSUSUH+1HBf4EotT5AiUd8iznclhOmtLCTwYiDeXFh8dIvPyk7B6m6n39Ei8LjMtwS
         bcHJD1vZ+zQI7XsG0a4JFdYq+qpG7LgO/bIJm+xquZSGlDAQoPCo38IzQNDJ8hA6+Aqq
         hAGMr2kQlJ2/YBGXzBpDdgOITeJV5m6ZGqoPDnZxfsVv0hvEqTismHHwOB6woAgKDpmP
         2R9drZjgBeIwDvgzbApe4s7O+HGBTKXqBtvFtWx8tgzIUh7fL2L79IwS5HOlp8rdX3vJ
         HT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=YZIIp6uG4nYB2xO6MENEMk3qQv64nQTMspRnfypnhVo=;
        b=Zthch/RYeBpab/BVggxHKVxpquFp7k3s0aR4K/5YIBliLRawRpSKJek0mKQ8mkhMGW
         9ufw9hUGj9rlWo/3YC7S/QrixeElNnLrUK3T17mSvecJVTIiE3ZrHpxwXjfLLlcn70jX
         B0Ti7Lb/Q4/+0o4x6f2OBCsCFyyTqEVBtPYv3DG1B3fbgR8j7NdFVZgKFCUCANdl85sy
         lh7EF1k9LtdAvyhlioUUw0tBPaOWKGakfXVee8xlKvxy4R7isNrXpIgkpFC+kUy3YtLH
         LflRBkN8cd1VbJEFXlS4WbzhA0nAIIZMQkUEDZjIWnbDvI4K18054l04lsl/cUQFMBhT
         XuFQ==
X-Gm-Message-State: APjAAAXWzn+JTN0evbKpKLPniUsoDIxtN7IbuVfCs2RO40vatmUeOUre
        HxToD4UZTTFlQs3quKXwuTo=
X-Google-Smtp-Source: APXvYqxuBlajT72ywwaGdE1RIpr8yK8819GmRJMpRaQw8LyQWOQNX1H0sHICzSZRBnrympH0f5YG9w==
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr26435722wmc.123.1574683895267;
        Mon, 25 Nov 2019 04:11:35 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c15sm10191862wrx.78.2019.11.25.04.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 04:11:34 -0800 (PST)
Date:   Mon, 25 Nov 2019 13:11:32 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Will Deacon <will@kernel.org>, Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] Locking: Add the Kernel Concurrency Sanitizer (KCSAN)
 subsystem
Message-ID: <20191125121132.GA115908@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking-kcsan-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-kcsan-for-linus

   # HEAD: 5cbaefe9743bf14c9d3106db0cc19f8cb0a3ca22 kcsan: Improve various small stylistic details

This tree adds the Kernel Concurrency Sanitizer (KCSAN) subsystem 
authored by Marco Elver, which is a debugging facility that uses compiler 
instrumentation of data accesses to statistically detect and report data 
races on live kernels.

KCSAN uses the -fsanitize=thread build time instrumentation features of 
both GCC and Clang, which transforms all memory reads/writes into 
__tsan_*callbacks with addresses and access type flags passed in that 
KCSAN can process and turn into a global array of 'watchpoints' that 
denote ongoing accesses. If two CPUs happen upon each other via an unsafe 
(non-atomic) access then a warning is generated.

Most users probably don't want to enable CONFIG_KCSAN due to the 
significant runtime overhead, bloat and the intentional udelay()s added 
to widen data races:

   text     data    bss	
   19769486 5201776 1613896 vmlinux.defconfig
   30181608 5313912 1675336 vmlinux.defconfig.CONFIG_KCSAN=y

... but for kernel developers it's a powerful facility that has already 
found a number of concurrency bugs.

There's a significant set of false positives and early and low level code 
complications that require the whitelisting and blacklisting of various 
pieces of kernel code - but in practice the code is already functional 
enough to find races.

 Thanks,

	Ingo

------------------>
Ingo Molnar (1):
      kcsan: Improve various small stylistic details

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
 include/linux/compiler-clang.h            |  11 +-
 include/linux/compiler-gcc.h              |   7 +
 include/linux/compiler.h                  |  57 ++-
 include/linux/kcsan-checks.h              |  93 +++++
 include/linux/kcsan.h                     | 108 ++++++
 include/linux/sched.h                     |   4 +
 include/linux/seqlock.h                   |  51 ++-
 init/init_task.c                          |   8 +
 init/main.c                               |   2 +
 kernel/Makefile                           |   6 +
 kernel/kcsan/Makefile                     |  11 +
 kernel/kcsan/atomic.h                     |  27 ++
 kernel/kcsan/core.c                       | 621 ++++++++++++++++++++++++++++++
 kernel/kcsan/debugfs.c                    | 271 +++++++++++++
 kernel/kcsan/encoding.h                   |  95 +++++
 kernel/kcsan/kcsan.h                      | 109 ++++++
 kernel/kcsan/report.c                     | 318 +++++++++++++++
 kernel/kcsan/test.c                       | 121 ++++++
 kernel/sched/Makefile                     |   6 +
 lib/Kconfig.debug                         |   2 +
 lib/Kconfig.kcsan                         | 116 ++++++
 lib/Makefile                              |   3 +
 mm/Makefile                               |   8 +
 scripts/Makefile.kcsan                    |   6 +
 scripts/Makefile.lib                      |  10 +
 scripts/atomic/gen-atomic-instrumented.sh |  17 +-
 tools/objtool/check.c                     |  18 +
 45 files changed, 2602 insertions(+), 207 deletions(-)
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

