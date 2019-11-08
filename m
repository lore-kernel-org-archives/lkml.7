Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB86FC6198
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CF621D7E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733061AbfKHVey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:34:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:34614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfKHVev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:34:51 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4A10215EA;
        Fri,  8 Nov 2019 21:34:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iTBu5-0007v7-NB; Fri, 08 Nov 2019 16:34:49 -0500
Message-Id: <20191108212834.594904349@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 08 Nov 2019 16:28:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 00/10] ftrace: Add register_ftrace_direct()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alexei mentioned that he would like a way to access the ftrace fentry
code to jump directly to a custom eBPF trampoline instead of using
ftrace regs caller, as he said it would be faster.

I proposed a new register_ftrace_direct() function that would allow
this to happen and still work with the ftrace infrastructure. I posted
a proof of concept patch here:

 https://lore.kernel.org/r/20191023122307.756b4978@gandalf.local.home

This patch series is a more complete version, and the start of the
actual implementation. I haven't run it through my full test suite but
it passes my smoke tests and some other custom tests I built.

I also realized that I need to make the sample modules depend on X86_64
as it has inlined assembly in it that requires that dependency.

This is based on 5.4-rc6 plus the permanent patches that prevent
a ftrace_ops from being disabled by /proc/sys/kernel/ftrace_enabled

Below is the tree that contains this code.

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
ftrace/direct

Head SHA1: 9492654d091cb90a487ca669c58f802fa99bcd6f

Enjoy,

-- Steve


Steven Rostedt (VMware) (10):
      ftrace: Separate out the copying of a ftrace_hash from __ftrace_hash_move()
      ftrace: Separate out functionality from ftrace_location_range()
      ftrace: Add register_ftrace_direct()
      ftrace: Add ftrace_find_direct_func()
      ftrace: Add sample module that uses register_ftrace_direct()
      ftrace/selftest: Add tests to test register_ftrace_direct()
      ftrace: Add another example of register_ftrace_direct() use case
      ftrace/selftests: Update the direct call selftests to test two direct calls
      ftrace/x86: Add register_ftrace_direct() for custom trampolines
      ftrace/x86: Add a counter to test function_graph with direct

----
 arch/x86/Kconfig                                   |   1 +
 arch/x86/include/asm/ftrace.h                      |  13 +
 arch/x86/kernel/ftrace.c                           |  14 +
 arch/x86/kernel/ftrace_64.S                        |  33 +-
 include/linux/ftrace.h                             |  50 ++-
 kernel/trace/Kconfig                               |   8 +
 kernel/trace/ftrace.c                              | 420 +++++++++++++++++++--
 samples/Kconfig                                    |   7 +
 samples/Makefile                                   |   1 +
 samples/ftrace/Makefile                            |   4 +
 samples/ftrace/ftrace-direct-too.c                 |  51 +++
 samples/ftrace/ftrace-direct.c                     |  45 +++
 .../ftrace/test.d/direct/ftrace-direct.tc          |  69 ++++
 .../ftrace/test.d/direct/kprobe-direct.tc          |  84 +++++
 14 files changed, 759 insertions(+), 41 deletions(-)
 create mode 100644 samples/ftrace/Makefile
 create mode 100644 samples/ftrace/ftrace-direct-too.c
 create mode 100644 samples/ftrace/ftrace-direct.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
