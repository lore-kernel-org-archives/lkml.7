Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D56C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBC221971
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbfDJLKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:10:14 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58697 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730748AbfDJLFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:05:31 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hEB2k-00050g-3T; Wed, 10 Apr 2019 13:05:26 +0200
Message-Id: <20190410102754.387743324@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 10 Apr 2019 12:27:54 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>
Subject: [RFC patch 00/41] stacktrace: Avoid the pointless redirection through
 struct stack_trace
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Struct stack_trace is a sinkhole for input and output parameters which is
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
level, but it removes the exposure to the generic code.

It's only lightly tested as I'm traveling and access to my test boxes is
limited.

Thanks,

	tglx

8<-----------------
 arch/um/kernel/stacktrace.c                   |    2 
 b/arch/arm/kernel/stacktrace.c                |    6 -
 b/arch/arm64/kernel/stacktrace.c              |    4 
 b/arch/parisc/kernel/stacktrace.c             |    5 -
 b/arch/riscv/kernel/stacktrace.c              |    2 
 b/arch/s390/kernel/stacktrace.c               |    6 -
 b/arch/sh/kernel/stacktrace.c                 |    4 
 b/arch/unicore32/kernel/stacktrace.c          |    2 
 b/arch/x86/kernel/stacktrace.c                |   14 --
 drivers/gpu/drm/drm_mm.c                      |   27 +----
 drivers/gpu/drm/i915/i915_vma.c               |   11 --
 drivers/gpu/drm/i915/intel_runtime_pm.c       |   25 +----
 drivers/md/dm-bufio.c                         |   15 +--
 drivers/md/persistent-data/dm-block-manager.c |   19 +--
 fs/btrfs/ref-verify.c                         |   15 ---
 fs/proc/base.c                                |   18 +--
 include/linux/ftrace.h                        |    1 
 include/linux/lockdep.h                       |    9 +
 include/linux/stackdepot.h                    |    8 -
 include/linux/stacktrace.h                    |   40 ++++----
 kernel/backtracetest.c                        |   11 --
 kernel/dma/debug.c                            |   13 +-
 kernel/latencytop.c                           |   29 +----
 kernel/locking/lockdep.c                      |   87 ++++++-----------
 kernel/stacktrace.c                           |  127 ++++++++++++++++++++++----
 kernel/trace/trace.c                          |  103 +++++++++------------
 kernel/trace/trace.h                          |    8 -
 kernel/trace/trace_events_hist.c              |   14 --
 kernel/trace/trace_stack.c                    |   24 +---
 lib/fault-inject.c                            |   12 --
 lib/stackdepot.c                              |   50 +++++-----
 mm/kasan/common.c                             |   33 ++----
 mm/kasan/report.c                             |    7 -
 mm/kmemleak.c                                 |   24 ----
 mm/page_owner.c                               |   82 +++++-----------
 mm/slub.c                                     |   21 +---
 36 files changed, 375 insertions(+), 503 deletions(-)



