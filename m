Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2892FC04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C935320830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557127219;
	bh=bkJrbgt5x9PyS0I50s4VHO0H6N6NZByuIOhP8t6wurs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=HUignlXwTOBw6lf9JOfpZoZMoJlYodyIj1X0GQ+ABACPWV9Hti9bq9r0iwN7yP6DF
	 x1E8bTLtA5Sa5d6+RGK9N0Sn1eUN6qS6v87DvAXhXtU7qyDHy5RgM4BGXn2XriiDcx
	 9WZehlXOihxXJgt6YzI100UPr2svZj1/rfZbblYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfEFHUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:20:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36085 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfEFHUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:20:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so182104wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 00:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/grF58AXpzz9yvksa/HkvMQkIZ6mqEgNZDRk6V3fMV4=;
        b=gVzKPfneDmP/7jhHy2YDOAlSVLFZnxWHYdv1Lz9zpBQDwoQrE1cEa3JbjXuFSB1v5a
         bk5mjere84hC6YT4fYmE9IotDSMwQXDv+JjrsaMF6jL/j/ZXNvmA3dQ9LEM7FuyxJaYT
         6muva72A9uWyMjIVDdRl5zp8tCHpX50N+OpcqeJF6Yzi1vVuq7cKYQHUw6Iuw7otWmhr
         Oqfkmw2MqznOb90oBvFIaYpQJds1nEyb9x6qSqpX5iELSTYwk1/kyBzQCNyDdlfJOOL1
         /6t0WIRu88X/wlWKEv2RwXzWlf8Rb4DQVSVjTnwxf3ndJBoIlG8YWkO7w56Jj01VMOIB
         ORbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=/grF58AXpzz9yvksa/HkvMQkIZ6mqEgNZDRk6V3fMV4=;
        b=FaiJXoV2DmnYsopgN5+A1qgSRYO/cpy2U1EXqaUbhDygHnBCwKJAGtzcbwh3jzFuWf
         3TK/GqOa70Db1PMmPd8z5MU3VUUMVnENsl+xGCsvRkkzZJan8INmQnKYR5VyTyd4Je8y
         TlFqqgPmht1E7ydmXE7dyr3LGctE24LuaFC56r8QVPrg9qPd+5yuC4rc4/ruf8/cUvvc
         N+DoBSxTITQzZ0y5341dJJOSFoq23u+27NifDalZpbryQAClz2nx06H1Pv9S7hcB7Pia
         83t1GEQq0XQk/OQ8AzwtF1WSUhe2JsXlu7Gaepwj2qBMNAYJgaGGQPJ2/KLaECc37v2n
         Cjng==
X-Gm-Message-State: APjAAAWOdgcAt3OCcHD0nWN7zGMEhpAAWa+e+AXM68yRznlhI3nwYssj
        XQhWjbWbeYE4nXsJKmeeP50=
X-Google-Smtp-Source: APXvYqzac3Xe7s0HbJoMo6W6sH9zt269qfBpyVlld4sa4IqCNcNLsw6HLomi8OxkRekscr8soRzK2Q==
X-Received: by 2002:a1c:cb8f:: with SMTP id b137mr6920534wmg.64.1557127215697;
        Mon, 06 May 2019 00:20:15 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y7sm23290283wrg.45.2019.05.06.00.20.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 00:20:14 -0700 (PDT)
Date:   Mon, 6 May 2019 09:20:12 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtool changes for v5.2: Add build-time uaccess
 permissions and DF validation
Message-ID: <20190506072012.GA33946@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-objtool-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-objtool-for-linus

   # HEAD: 29da93fea3ea39ab9b12270cc6be1b70ef201c9e mm/uaccess: Use 'unsigned long' to placate UBSAN warnings on older GCC versions

This is a series from Peter Zijlstra that adds x86 build-time uaccess 
validation of SMAP to objtool, which will detect and warn about the 
following uaccess API usage bugs and weirdnesses:

	call to %s() with UACCESS enabled
	return with UACCESS enabled
	return with UACCESS disabled from a UACCESS-safe function
	recursive UACCESS enable
	redundant UACCESS disable
	UACCESS-safe disables UACCESS

As it turns out not leaking uaccess permissions outside the intended 
uaccess functionality is hard when the interfaces are complex and when 
such bugs are mostly dormant.

As a bonus we now also check the DF flag. We had at least one 
high-profile bug in that area in the early days of Linux, and the 
checking is fairly simple. The checks performed and warnings emitted are:

	call to %s() with DF set
	return with DF set
	return with modified stack frame
	recursive STD
	redundant CLD

It's all x86-only for now, but later on this can also be used for PAN on 
ARM and objtool is fairly cross-platform in principle.

While all warnings emitted by this new checking facility that got 
reported to us were fixed, there might be GCC version dependent warnings 
that were not reported yet - which we'll address, should they trigger.

The warnings are non-fatal build warnings.

 Thanks,

	Ingo

------------------>
Josh Poimboeuf (1):
      tracing: Improve "if" macro code generation

Peter Zijlstra (26):
      sched/x86: Save [ER]FLAGS on context switch
      x86/ia32: Fix ia32_restore_sigcontext() AC leak
      i915, uaccess: Fix redundant CLAC
      x86/uaccess: Move copy_user_handle_tail() into asm
      x86/uaccess: Fix up the fixup
      x86/nospec, objtool: Introduce ANNOTATE_IGNORE_ALTERNATIVE
      x86/uaccess, xen: Suppress SMAP warnings
      x86/uaccess: Always inline user_access_begin()
      x86/uaccess, signal: Fix AC=1 bloat
      x86/uaccess: Introduce user_access_{save,restore}()
      x86/smap: Ditch __stringify()
      x86/uaccess, kasan: Fix KASAN vs SMAP
      x86/uaccess, ubsan: Fix UBSAN vs. SMAP
      x86/uaccess, ftrace: Fix ftrace_likely_update() vs. SMAP
      x86/uaccess, kcov: Disable stack protector
      objtool: Set insn->func for alternatives
      objtool: Handle function aliases
      objtool: Rewrite add_ignores()
      objtool: Add --backtrace support
      objtool: Rewrite alt->skip_orig
      objtool: Fix sibling call detection
      objtool: Add UACCESS validation
      objtool: Add Direction Flag validation
      sched/x86_64: Don't save flags on context switch
      x86/uaccess: Dont leak the AC flag into __put_user() argument evaluation
      mm/uaccess: Use 'unsigned long' to placate UBSAN warnings on older GCC versions


 arch/x86/entry/entry_32.S                  |   2 +
 arch/x86/ia32/ia32_signal.c                |  29 ++-
 arch/x86/include/asm/alternative-asm.h     |  11 +
 arch/x86/include/asm/alternative.h         |  10 +
 arch/x86/include/asm/asm.h                 |  24 --
 arch/x86/include/asm/nospec-branch.h       |  28 +-
 arch/x86/include/asm/smap.h                |  37 ++-
 arch/x86/include/asm/switch_to.h           |   1 +
 arch/x86/include/asm/uaccess.h             |  12 +-
 arch/x86/include/asm/uaccess_64.h          |   3 -
 arch/x86/include/asm/xen/hypercall.h       |  24 +-
 arch/x86/kernel/process_32.c               |   7 +
 arch/x86/kernel/process_64.c               |   1 +
 arch/x86/kernel/signal.c                   |  29 ++-
 arch/x86/lib/copy_user_64.S                |  48 ++++
 arch/x86/lib/memcpy_64.S                   |   3 +-
 arch/x86/lib/usercopy_64.c                 |  20 --
 drivers/gpu/drm/i915/i915_gem_execbuffer.c |   6 +-
 include/linux/compiler.h                   |   2 +-
 include/linux/uaccess.h                    |   2 +
 kernel/Makefile                            |   1 +
 kernel/trace/trace_branch.c                |   4 +
 lib/Makefile                               |   1 +
 lib/strncpy_from_user.c                    |   5 +-
 lib/strnlen_user.c                         |   4 +-
 lib/ubsan.c                                |   4 +
 mm/kasan/Makefile                          |   3 +
 mm/kasan/common.c                          |  10 +
 mm/kasan/report.c                          |   3 +-
 scripts/Makefile.build                     |   3 +
 tools/objtool/arch.h                       |   8 +-
 tools/objtool/arch/x86/decode.c            |  21 +-
 tools/objtool/builtin-check.c              |   4 +-
 tools/objtool/builtin.h                    |   2 +-
 tools/objtool/check.c                      | 400 ++++++++++++++++++++++-------
 tools/objtool/check.h                      |   4 +-
 tools/objtool/elf.c                        |  15 +-
 tools/objtool/elf.h                        |   3 +-
 tools/objtool/special.c                    |  18 ++
 tools/objtool/special.h                    |   1 +
 tools/objtool/warn.h                       |   8 +
 41 files changed, 602 insertions(+), 219 deletions(-)
