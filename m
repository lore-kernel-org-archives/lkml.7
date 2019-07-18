Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CB6C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 01:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A002084C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 01:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfGSBDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 21:03:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38416 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfGSBDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 21:03:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id az7so14735218plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 18:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d3rODNYxuy5WSNSg2yOMOvh6Io0aB+kYlsQ525KJnc0=;
        b=VniQ51CkLGNon56YgITDV/olp4AWOFIA6rzhpqBDYGzue81zg1RfpFXwtVN9A8bnsN
         axZ1YX+54woQfvdxS4kqHJZdo/UEEtgdXbrq7s5ct7W7aDvTBmTf1ko+L5ShlB/SLLkq
         f67vqQWc2kQcbQX1Y/mQgCjuIr5K8q2MWIA6eN6W46fYRO56JBmxCE91dI4qGyslPCtu
         cSZ+fQAtu5jV4Mc7zZAbiLseZc5CeyDdhGW1klz67TI1ZqH5iI/HXyHL+pgPikwzYDKM
         0xZ+gjhX/XFishj9flq3E7OZKgtC669YLj54pIA/XqZ1zjDffQrkqr4oLSem6JxYYnJx
         P6fA==
X-Gm-Message-State: APjAAAXznEitaKSbmKIkMEbl0DWZm6GLo/ypog2st82AtD/AOx2IIgg4
        7/C6+90Hz3F7gd3KDeERJ5Bv1bovJcc=
X-Google-Smtp-Source: APXvYqyNnYXLRkRi6Ll9bz/3tajFAV1xPszlLINuuVWkZO2ozRs4+asqt2Ylc201rgEWbM7nm9wEHQ==
X-Received: by 2002:a17:902:2f84:: with SMTP id t4mr48549709plb.57.1563498229683;
        Thu, 18 Jul 2019 18:03:49 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q144sm28887612pfc.103.2019.07.18.18.03.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 18:03:49 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [RFC 0/7] x86/percpu: Use segment qualifiers 
Date:   Thu, 18 Jul 2019 10:41:03 -0700
Message-Id: <20190718174110.4635-1-namit@vmware.com>
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
shows a minor reduction from 11349763 to 11339840 (0.09%).

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

