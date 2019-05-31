Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373E1C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1662626469
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfEaGg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 02:36:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42548 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaGg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:36:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id r22so5548861pfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 23:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Xfx4FpzFal1JVbe0hIZsssk5cDjneCfnDqzDXKu6Fw=;
        b=SD6Qb4JT08g/0jpD54WflpmVGAork7vzicvIQcvFrtp3NnnaeRfixJeODx3RJ2Jx4Z
         iDpdFHOqVLPhh4GDwfYVJN/eNAoiC3Cl9jhiNwthIXiLJFqZ5lLHgu0/PGIg2bGuaorJ
         nzGrUowXHe2s0HffizPngRh2ZQv7LZgMwEsAIHAVeQqLmUtNmYlTOWjvflOkIAvBEPHC
         6rjjRs+yFgqcyzRIbrthFiCZ2mS0fSTLCbn7yCw98kkNsT1NRred/gjWQ1i1GxAy3Kxh
         IJCKUUXYZEHGsAQaNM12aBYl2W9kvPrO+iM7p3DgOKtz/O8qiVhk6ha7JJ+lp/Uv8ez5
         YJnQ==
X-Gm-Message-State: APjAAAVK2Y/vHouJWk6QEa61/DVBNmzNTa/cJP3BRzY8RGN619MORWUL
        4Y1tH+NV4Jdwm0lGnH0q8cE=
X-Google-Smtp-Source: APXvYqwmLwR5wY1FgNqtnQR7hiU/n9+Ommcyx4lbFe48W+Hvw9z8HhoK/t57syK16hmmWH9MoGtMmA==
X-Received: by 2002:a63:e04:: with SMTP id d4mr3899507pgl.331.1559284617776;
        Thu, 30 May 2019 23:36:57 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id g17sm9256429pfk.55.2019.05.30.23.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 23:36:56 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>
Subject: [RFC PATCH v2 00/12] x86: Flush remote TLBs concurrently and async
Date:   Thu, 30 May 2019 23:36:33 -0700
Message-Id: <20190531063645.4697-1-namit@vmware.com>
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

In addition, this patch-set performs remote TLB shootdowns of userspace
mappings asynchronously. It inlines the info that describes what to
flush with the SMP information (which also reduces cache coherency
traffic), and the initiator continues to run after the IPI is received
before the actual flush. This is only possible if page tables were not
removed as otherwise speculative page-walks might lead to machine
checks. Access to userspace is prevented from NMI handlers and kprobes
until the flush is actually carried. Arguably, this should be safe.

Finally, there are various small optimizations to avoid unwarranted
false-sharing and atomic operations.

The proposed changes should also improve the performance of other
invocations of on_each_cpu(). Hopefully, no one has relied on the
behavior of on_each_cpu() that functions were first executed remotely
and only then locally.

On my Haswell machine (bare-metal), running a TLB flush microbenchmark
(MADV_DONTNEED/touch for a single page on one thread in a loop, others
perform busy-wait loop), takes the following time (ns per iteration) on
the thread the invokes the TLB shootdown:

	n_threads	before		after
	---------	------		-----
	1		661		663
	2		1436		923 (-36%)
	4		1571		1070 (-32%)

Note that since the benchmark also causes page-faults, the actual
speedup of TLB shootdowns is actually greater. Also note the higher
improvement in performance with 2 thread (a single remote TLB flush
target). This seems to be a side-effect of holding synchronization
data-structures (csd) off the stack, unlike the way it is currently done
(in smp_call_function_single()).

This microbenchmark only measures the time of the thread that invokes
the TLB shootdown. Running sysbench on dax w/emulated-pmem:

  sysbench fileio --file-total-size=3G --file-test-mode=rndwr \
   --file-io-mode=mmap --threads=4 --file-fsync-mode=fdatasync run

Shows a performance improvement of 5% (607k vs 575k events).

Patch 1 does small cleanup. Patches 3-5 implement the concurrent
execution of TLB flushes. Patch 6-8 deals with false-sharing and
unnecassary atomic operations. Patches 9-12 perform async TLB flushes
when possible and inline the data on IPIs.

RFC v1 -> RFC v2:
- Removed a patch which did not improve performance
- Patches 6-8: false-sharing and atomic operation optimizations
- Patches 9-12: asynchronous TLB flushes

Nadav Amit (12):
  smp: Remove smp_call_function() and on_each_cpu() return values
  smp: Run functions concurrently in smp_call_function_many()
  x86/mm/tlb: Refactor common code into flush_tlb_on_cpus()
  x86/mm/tlb: Flush remote and local TLBs concurrently
  x86/mm/tlb: Optimize local TLB flushes
  KVM: x86: Provide paravirtualized flush_tlb_multi()
  smp: Do not mark call_function_data as shared
  x86/tlb: Privatize cpu_tlbstate
  x86/apic: Use non-atomic operations when possible
  smp: Enable data inlining for inter-processor function call
  x86/mm/tlb: Use async and inline messages for flushing
  x86/mm/tlb: Reverting the removal of flush_tlb_info from stack

 arch/alpha/kernel/smp.c               |  19 +--
 arch/alpha/oprofile/common.c          |   6 +-
 arch/ia64/kernel/perfmon.c            |  12 +-
 arch/ia64/kernel/uncached.c           |   8 +-
 arch/x86/hyperv/mmu.c                 |   2 +
 arch/x86/include/asm/paravirt.h       |   8 +
 arch/x86/include/asm/paravirt_types.h |   6 +
 arch/x86/include/asm/tlbflush.h       |  58 ++++---
 arch/x86/kernel/apic/apic_flat_64.c   |   4 +-
 arch/x86/kernel/apic/x2apic_cluster.c |   2 +-
 arch/x86/kernel/kvm.c                 |  11 +-
 arch/x86/kernel/paravirt.c            |   3 +
 arch/x86/kernel/smp.c                 |   2 +-
 arch/x86/lib/cache-smp.c              |   3 +-
 arch/x86/mm/init.c                    |   2 +-
 arch/x86/mm/tlb.c                     | 204 +++++++++++++++++--------
 arch/x86/xen/mmu_pv.c                 |   2 +
 drivers/char/agp/generic.c            |   3 +-
 include/linux/smp.h                   |  45 ++++--
 kernel/smp.c                          | 210 ++++++++++++++++----------
 kernel/up.c                           |   3 +-
 21 files changed, 397 insertions(+), 216 deletions(-)

-- 
2.20.1

