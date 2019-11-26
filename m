Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16325C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF5620659
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfKZUOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 15:14:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:45486 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726033AbfKZUOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:14:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 39C4BAAD0;
        Tue, 26 Nov 2019 20:13:59 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Nicholas Piggin <npiggin@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Breno Leitao <leitao@debian.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Diana Craciun <diana.craciun@nxp.com>,
        Daniel Axtens <dja@axtens.net>,
        Michael Neuling <mikey@neuling.org>,
        Gustavo Romero <gromero@linux.ibm.com>,
        Mathieu Malaterre <malat@debian.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/35] exception cleanup, syscall in C and !COMPAT
Date:   Tue, 26 Nov 2019 21:13:14 +0100
Message-Id: <cover.1574798487.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is merge of https://patchwork.ozlabs.org/cover/1162376/ (except two
last experimental patches) and
https://patchwork.ozlabs.org/patch/1162079/ rebased on top of master.

There was minor conflict in Makefile in the latter series.

Refreshed the patchset to fix build error on ppc32 and ppc64e.

Thanks

Michal

Michal Suchanek (10):
  powerpc/64: system call: Fix sparse warning about missing declaration
  powerpc: Add back __ARCH_WANT_SYS_LLSEEK macro
  powerpc: move common register copy functions from signal_32.c to
    signal.c
  powerpc/perf: remove current_is_64bit()
  powerpc/perf: consolidate read_user_stack_32
  powerpc/perf: consolidate valid_user_sp
  powerpc/64: make buildable without CONFIG_COMPAT
  powerpc/64: Make COMPAT user-selectable disabled on littleendian by
    default.
  powerpc/perf: split callchain.c by bitness
  MAINTAINERS: perf: Add pattern that matches ppc perf to the perf
    entry.

Nicholas Piggin (25):
  powerpc/64s/exception: Introduce INT_DEFINE parameter block for code
    generation
  powerpc/64s/exception: Add GEN_COMMON macro that uses INT_DEFINE
    parameters
  powerpc/64s/exception: Add GEN_KVM macro that uses INT_DEFINE
    parameters
  powerpc/64s/exception: Expand EXC_COMMON and EXC_COMMON_ASYNC macros
  powerpc/64s/exception: Move all interrupt handlers to new style code
    gen macros
  powerpc/64s/exception: Remove old INT_ENTRY macro
  powerpc/64s/exception: Remove old INT_COMMON macro
  powerpc/64s/exception: Remove old INT_KVM_HANDLER
  powerpc/64s/exception: Add ISIDE option
  powerpc/64s/exception: move real->virt switch into the common handler
  powerpc/64s/exception: move soft-mask test to common code
  powerpc/64s/exception: move KVM test to common code
  powerpc/64s/exception: remove confusing IEARLY option
  powerpc/64s/exception: remove the SPR saving patch code macros
  powerpc/64s/exception: trim unused arguments from KVMTEST macro
  powerpc/64s/exception: hdecrementer avoid touching the stack
  powerpc/64s/exception: re-inline some handlers
  powerpc/64s/exception: Clean up SRR specifiers
  powerpc/64s/exception: add more comments for interrupt handlers
  powerpc/64s/exception: only test KVM in SRR interrupts when PR KVM is
    supported
  powerpc/64s/exception: soft nmi interrupt should not use
    ret_from_except
  powerpc/64: system call remove non-volatile GPR save optimisation
  powerpc/64: system call implement the bulk of the logic in C
  powerpc/64s: interrupt return in C
  powerpc/64s/exception: remove lite interrupt return

 MAINTAINERS                                   |    2 +
 arch/powerpc/Kconfig                          |    5 +-
 arch/powerpc/include/asm/asm-prototypes.h     |   17 +-
 .../powerpc/include/asm/book3s/64/kup-radix.h |   24 +-
 arch/powerpc/include/asm/cputime.h            |   24 +
 arch/powerpc/include/asm/exception-64s.h      |    4 -
 arch/powerpc/include/asm/hw_irq.h             |    4 +
 arch/powerpc/include/asm/ptrace.h             |    3 +
 arch/powerpc/include/asm/signal.h             |    3 +
 arch/powerpc/include/asm/switch_to.h          |   11 +
 arch/powerpc/include/asm/thread_info.h        |    4 +-
 arch/powerpc/include/asm/time.h               |    4 +-
 arch/powerpc/include/asm/unistd.h             |    1 +
 arch/powerpc/kernel/Makefile                  |    9 +-
 arch/powerpc/kernel/entry_64.S                |  880 ++------
 arch/powerpc/kernel/exceptions-64e.S          |  255 ++-
 arch/powerpc/kernel/exceptions-64s.S          | 1937 ++++++++++++-----
 arch/powerpc/kernel/process.c                 |   89 +-
 arch/powerpc/kernel/signal.c                  |  144 +-
 arch/powerpc/kernel/signal.h                  |    2 -
 arch/powerpc/kernel/signal_32.c               |  140 --
 arch/powerpc/kernel/syscall_64.c              |  349 +++
 arch/powerpc/kernel/syscalls/syscall.tbl      |   22 +-
 arch/powerpc/kernel/systbl.S                  |    9 +-
 arch/powerpc/kernel/time.c                    |    9 -
 arch/powerpc/kernel/vdso.c                    |    3 +-
 arch/powerpc/kernel/vector.S                  |    2 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S       |   11 -
 arch/powerpc/kvm/book3s_segment.S             |    7 -
 arch/powerpc/perf/Makefile                    |    5 +-
 arch/powerpc/perf/callchain.c                 |  387 +---
 arch/powerpc/perf/callchain.h                 |   20 +
 arch/powerpc/perf/callchain_32.c              |  197 ++
 arch/powerpc/perf/callchain_64.c              |  178 ++
 fs/read_write.c                               |    3 +-
 35 files changed, 2799 insertions(+), 1965 deletions(-)
 create mode 100644 arch/powerpc/kernel/syscall_64.c
 create mode 100644 arch/powerpc/perf/callchain.h
 create mode 100644 arch/powerpc/perf/callchain_32.c
 create mode 100644 arch/powerpc/perf/callchain_64.c

-- 
2.23.0

