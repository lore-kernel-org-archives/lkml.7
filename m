Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CA4C04AB0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCF42168B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 08:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfEYIWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 04:22:08 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43600 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfEYIWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 04:22:08 -0400
Received: by mail-pl1-f196.google.com with SMTP id gn7so5066130plb.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 01:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mpUnwXaCrHUxBfP+dD3o1HbeuqOVCqCAHXyENTvsZfQ=;
        b=d9EGjBRGz2jywdv7MKd1Y5prO/7ScaPL83/gCOgQgepO9MCzAO7KW3N68yNmyrPS7Q
         pM7hn4Tb8reMzzgqMgatF3rxuvZ4CFR6gry2wabn7P9uaqoh5fX7rJcPfTi8D2FHZXYQ
         l8AJ6jkqz/7ihI/u5NDk7FLMUyzUzi3cl+SJqao5boeqRa7PN1XkpAOutdryrXF/2MX+
         HD6VtJko8UHm6qj5hdDC0AVFOg6R1MZauNcFXYvLwmRQZJrcVkdx1P9AAAzHgBpMbNF6
         z7m0Plt5xnm2aUyHkH5S+OcmnaAN06YbyeUyK+lw9YTAdJ5syMLqHGNOKTFsCuTCEwk3
         um9g==
X-Gm-Message-State: APjAAAVi7cWCMrKgmGayJ+IGsi8ykADtYIt/Mig/LA+qHzF/3Kl5A5ff
        c89BlR/iKst1wpr0kDitlzM=
X-Google-Smtp-Source: APXvYqwseZfbdlWz9+o1XwtSz+T9B+4xXaYZWc8ocbnHCM9tX5TgGXhvfF/CWIkK1QtZiG1JGwA2jw==
X-Received: by 2002:a17:902:b58a:: with SMTP id a10mr82126174pls.83.1558772527060;
        Sat, 25 May 2019 01:22:07 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e4sm1438505pgi.80.2019.05.25.01.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 01:22:05 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>
Subject: [RFC PATCH 0/6] x86/mm: Flush remote and local TLBs concurrently
Date:   Sat, 25 May 2019 01:21:57 -0700
Message-Id: <20190525082203.6531-1-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, local and remote TLB flushes are not performed concurrently,
which introduces unnecessary overhead - each INVLPG can take 100s of
cycles. This patch-set allows TLB flushes to be run concurrently: first
request the remote CPUs to initiate the flush, then run it locally, and
finally wait for the remote CPUs to finish their work.

The proposed changes should also improve the performance of other
invocations of on_each_cpu(). Hopefully, no one has relied on the
behavior of on_each_cpu() that functions were first executed remotely
and only then locally.

On my Haswell machine (bare-metal), running a TLB flush microbenchmark
(MADV_DONTNEED/touch for a single page on one thread), takes the
following time (ns):

	n_threads	before		after
	---------	------		-----
	1		661		663
	2		1436		1225 (-14%)
	4		1571		1421 (-10%)

Note that since the benchmark also causes page-faults, the actual
speedup of TLB shootdowns is actually greater. Also note the higher
improvement in performance with 2 thread (a single remote TLB flush
target). This seems to be a side-effect of holding synchronization
data-structures (csd) off the stack, unlike the way it is currently done
(in smp_call_function_single()).

Patches 1-2 do small cleanup. Patches 3-5 actually implement the
concurrent execution of TLB flushes. Patch 6 restores local TLB flushes
performance, which was hurt by the optimization, to be as good as it was
before these changes by introducing a fast-pass for this specific case.

Nadav Amit (6):
  smp: Remove smp_call_function() and on_each_cpu() return values
  cpumask: Purify cpumask_next()
  smp: Run functions concurrently in smp_call_function_many()
  x86/mm/tlb: Refactor common code into flush_tlb_on_cpus()
  x86/mm/tlb: Flush remote and local TLBs concurrently
  x86/mm/tlb: Optimize local TLB flushes

 arch/alpha/kernel/smp.c               |  19 +---
 arch/alpha/oprofile/common.c          |   6 +-
 arch/ia64/kernel/perfmon.c            |  12 +--
 arch/ia64/kernel/uncached.c           |   8 +-
 arch/x86/hyperv/mmu.c                 |   2 +
 arch/x86/include/asm/paravirt.h       |   8 ++
 arch/x86/include/asm/paravirt_types.h |   6 ++
 arch/x86/include/asm/tlbflush.h       |   6 ++
 arch/x86/kernel/kvm.c                 |   1 +
 arch/x86/kernel/paravirt.c            |   3 +
 arch/x86/lib/cache-smp.c              |   3 +-
 arch/x86/mm/tlb.c                     | 137 +++++++++++++++++--------
 arch/x86/xen/mmu_pv.c                 |   2 +
 drivers/char/agp/generic.c            |   3 +-
 include/linux/cpumask.h               |   2 +-
 include/linux/smp.h                   |  32 ++++--
 kernel/smp.c                          | 139 ++++++++++++--------------
 kernel/up.c                           |   3 +-
 18 files changed, 230 insertions(+), 162 deletions(-)

-- 
2.20.1

