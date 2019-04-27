Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7B3C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFFB2087F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfD0KHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 06:07:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:51308 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725902AbfD0KHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 06:07:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1C391ACBC;
        Sat, 27 Apr 2019 10:07:45 +0000 (UTC)
From:   Nicolai Stange <nstange@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>
Subject: [PATCH 0/4] x86/ftrace: make ftrace_int3_handler() not to skip fops invocation
Date:   Sat, 27 Apr 2019 12:06:35 +0200
Message-Id: <20190427100639.15074-1-nstange@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series is the result of the discussion to the RFC patch found at [1].

The goal is to make x86' ftrace_int3_handler() not to simply skip over
the trapping instruction as this is problematic in the context of
the live patching consistency model. For details, c.f. the commit message
of [3/4] ("x86/ftrace: make ftrace_int3_handler() not to skip fops
invocation").

Everything is based on v5.1-rc6, please let me know in case you want me to
rebase on somehing else.

For x86_64, the live patching selftest added in [4/4] succeeds with this
series applied and fails without it. On 32 bits I only compile-tested.

checkpatch reports warnings about
- an overlong line in assembly -- I chose to ignore that
- MAINTAINERS perhaps needing updates due to the new files
  arch/x86/kernel/ftrace_int3_stubs.S and
  tools/testing/selftests/livepatch/test-livepatch-vs-ftrace.sh.
  As the existing arch/x86/kernel/ftrace_{32,64}.S haven't got an
  explicit entry either, this one is probably Ok? The selftest
  definitely is.

Changes to the RFC patch:
- s/trampoline/stub/ to avoid confusion with the ftrace_ops' trampolines,
- use a fixed size stack kept in struct thread_info for passing the
  (adjusted) ->ip values from ftrace_int3_handler() to the stubs,
- provide one stub for each of the two possible jump targets and hardcode
  those,
- add the live patching selftest.

Thanks,

Nicolai

Nicolai Stange (4):
  x86/thread_info: introduce ->ftrace_int3_stack member
  ftrace: drop 'static' qualifier from ftrace_ops_list_func()
  x86/ftrace: make ftrace_int3_handler() not to skip fops invocation
  selftests/livepatch: add "ftrace a live patched function" test

 arch/x86/include/asm/thread_info.h                 | 11 +++
 arch/x86/kernel/Makefile                           |  1 +
 arch/x86/kernel/asm-offsets.c                      |  8 +++
 arch/x86/kernel/ftrace.c                           | 79 +++++++++++++++++++---
 arch/x86/kernel/ftrace_int3_stubs.S                | 61 +++++++++++++++++
 kernel/trace/ftrace.c                              |  8 +--
 tools/testing/selftests/livepatch/Makefile         |  3 +-
 .../livepatch/test-livepatch-vs-ftrace.sh          | 44 ++++++++++++
 8 files changed, 199 insertions(+), 16 deletions(-)
 create mode 100644 arch/x86/kernel/ftrace_int3_stubs.S
 create mode 100755 tools/testing/selftests/livepatch/test-livepatch-vs-ftrace.sh

-- 
2.13.7

