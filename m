Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDE8C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFD221874
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfHXGFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 02:05:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34651 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfHXGFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 02:05:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id b24so8066246pfp.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 23:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kDV1vhN0wODBotvyRh1M9ntCF2zJ8VrUcg/cgB4CwYg=;
        b=NISril8xgnKPq8sH+bCA8IO/00VdT0J7DX966/UC6mCE/72dFUrF7OugxQnNUyx07c
         gnCn9tsil/6IR0PztUNNrJo/x6H/2skN3q22V68SvU+cWBOnfBCZj3pH/ovAowVL4rKE
         vJcyEK7Qf6c0Uw51KycnjThnuOkBzpo62VCWif06KXKUwDCNrNnWMIdEGzFG/rFvFBtB
         sC9R1Z8Kw/rwo3TRHJ1P5i8mevEh6wnucEkw/s6UW7Ggi9NKdjA72hTeZ7T6RuMBSMNC
         wsA8MWSYSrVgbwuUnlap1RjwSVDICO9sLPmjcVFr9VnK1VyfmlO/upIY1CW8WKekiP+O
         WAmA==
X-Gm-Message-State: APjAAAWGoHpZAx1Pa3O+KiNl3Mvu7ZjpeaD9cAHur9d1yy1pvrDftv8y
        FcXjGsOiyjkHSLd4nIYy1zM=
X-Google-Smtp-Source: APXvYqzlRbYMmTK0qQhZkPzDvPeuntH4nvz+aupEoP5w94g3eR1oGjx1Ji6+K1Gk7+sTj6ivfU5Fkw==
X-Received: by 2002:a62:53c3:: with SMTP id h186mr9304094pfb.178.1566626712276;
        Fri, 23 Aug 2019 23:05:12 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id w2sm4300882pjr.27.2019.08.23.23.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 23:05:11 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Garnier <thgarnie@chromium.org>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [PATCH 0/7] x86/percpu: Use segment qualifiers
Date:   Fri, 23 Aug 2019 15:44:17 -0700
Message-Id: <20190823224424.15296-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 6+ supports segment qualifiers. Using them allows to implement
several optimizations:

1. Avoid unnecessary instructions when an operation is carried on
read/written per-cpu value, and instead allow the compiler to set
instructions that access per-cpu value directly.

2. Make this_cpu_ptr() more efficient and allow its value to be cached,
since preemption must be disabled when this_cpu_ptr() is used.

3. Provide better alternative for this_cpu_read_stable() that caches
values more efficiently using alias attribute to const variable.

4. Allow the compiler to perform other optimizations (e.g. CSE).

5. Use rip-relative addressing in per_cpu_read_stable(), which make it
PIE-ready.

"size" and Peter's compare do not seem to show the impact on code size
reduction correctly. Summing the code size according to nm on defconfig
shows a minor reduction from 11451310 to 11451310 (0.09%).

RFC->v1:
 * Fixing i386 build bug
 * Moving chunk to the right place [Peter]

Nadav Amit (7):
  compiler: Report x86 segment support
  x86/percpu: Use compiler segment prefix qualifier
  x86/percpu: Use C for percpu accesses when possible
  x86: Fix possible caching of current_task
  percpu: Assume preemption is disabled on per_cpu_ptr()
  x86/percpu: Optimized arch_raw_cpu_ptr()
  x86/current: Aggressive caching of current

 arch/x86/include/asm/current.h         |  30 +++
 arch/x86/include/asm/fpu/internal.h    |   7 +-
 arch/x86/include/asm/percpu.h          | 293 +++++++++++++++++++------
 arch/x86/include/asm/preempt.h         |   3 +-
 arch/x86/include/asm/resctrl_sched.h   |  14 +-
 arch/x86/kernel/cpu/Makefile           |   1 +
 arch/x86/kernel/cpu/common.c           |   7 +-
 arch/x86/kernel/cpu/current.c          |  16 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   4 +-
 arch/x86/kernel/process_32.c           |   4 +-
 arch/x86/kernel/process_64.c           |   4 +-
 include/asm-generic/percpu.h           |  12 +
 include/linux/compiler-gcc.h           |   4 +
 include/linux/compiler.h               |   2 +-
 include/linux/percpu-defs.h            |  33 ++-
 15 files changed, 346 insertions(+), 88 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/current.c

-- 
2.17.1

