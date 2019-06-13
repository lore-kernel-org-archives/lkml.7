Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04B1C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843D120673
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfFMQma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:42:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40445 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbfFMGs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 02:48:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so7894205pfp.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 23:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VV+hwkRWfuJlEKYhE1hDz5poWY2znmOsLTaK/SE+bvA=;
        b=kOUn0cxOh7Yqs6ziW0ZhYjjb2t0LQC9MeY1aiGiGaaB+GKWYxMMmFIcPut3Xy82In6
         K2loiGx6n17l/uetBE9ik6TqYuJt5MYBM+U1UYx7kGBbWFU33ZOeEPBsX07Bu2WpKYO8
         U5Ga/54QrtgmWWfRrWw5Wn+kV7WK/rGBQcL/fKQzoTQBVwVfoPoqFnPW5iZ7ZZlYtzEM
         2UBVheZjnHBrk6lhwgMmZO7WxGIiQef3HGc8+AURw5rqePl+pY2LBiNMhFMsTub2UUkk
         l1I+0oUHj4zCVNUghaj5ZhjzW/QDno6wXoJo4SkKpGDMnengJ3nqsG+xXZENwnVbIANT
         pNEw==
X-Gm-Message-State: APjAAAVYh0UfzYnm7fumsS4BNqIDJOQVJ6owofw2azC89upLVauVvEgR
        3QLzo2MWHgwo3OG599zPYuI=
X-Google-Smtp-Source: APXvYqzMh2iyv/DW+QulW2gDoHdukmthpxVlfstKodVPUw40ZhhVgpuyry4Y/fdry7yB/Useu2j44Q==
X-Received: by 2002:a63:5247:: with SMTP id s7mr11254107pgl.29.1560408537348;
        Wed, 12 Jun 2019 23:48:57 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id i3sm1559973pfa.175.2019.06.12.23.48.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 23:48:56 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/9] x86: Concurrent TLB flushes and other improvements
Date:   Wed, 12 Jun 2019 23:48:04 -0700
Message-Id: <20190613064813.8102-1-namit@vmware.com>
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

In addition, there are various small optimizations to avoid unwarranted
false-sharing and atomic operations.

The proposed changes should also improve the performance of other
invocations of on_each_cpu(). Hopefully, no one has relied on this
behavior of on_each_cpu() that invoked functions first remotely and only
then locally [Peter says he remembers someone might do so, but without
further information it is hard to know how to address it].

Running sysbench on dax w/emulated-pmem, write-cache disabled, and
various mitigations (PTI, Spectre, MDS) disabled on Haswell:

 sysbench fileio --file-total-size=3G --file-test-mode=rndwr \
  --file-io-mode=mmap --threads=4 --file-fsync-mode=fdatasync run

			events (avg/stddev)
			-------------------
  5.2-rc3:		1247669.0000/16075.39
  +patchset:		1290607.0000/13617.56 (+3.4%)

Patch 1 does small cleanup. Patches 2-5 implement the concurrent
execution of TLB flushes. Patches 6-9 deal with false-sharing and
unnecessary atomic operations. There is still no implementation that
uses the concurrent TLB flushes by Xen and Hyper-V. 

There are various additional possible optimizations that were sent or
are in development (async flushes, x2apic shorthands, fewer mm_tlb_gen
accesses, etc.), but based on Andy's feedback, they will be sent later.

RFCv2 -> v1:
* Fix comment on flush_tlb_multi [Juergen]
* Removing async invalidation optimizations [Andy]
* Adding KVM support [Paolo]

Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

Nadav Amit (9):
  smp: Remove smp_call_function() and on_each_cpu() return values
  smp: Run functions concurrently in smp_call_function_many()
  x86/mm/tlb: Refactor common code into flush_tlb_on_cpus()
  x86/mm/tlb: Flush remote and local TLBs concurrently
  x86/mm/tlb: Optimize local TLB flushes
  KVM: x86: Provide paravirtualized flush_tlb_multi()
  smp: Do not mark call_function_data as shared
  x86/tlb: Privatize cpu_tlbstate
  x86/apic: Use non-atomic operations when possible

 arch/alpha/kernel/smp.c               |  19 +---
 arch/alpha/oprofile/common.c          |   6 +-
 arch/ia64/kernel/perfmon.c            |  12 +--
 arch/ia64/kernel/uncached.c           |   8 +-
 arch/x86/hyperv/mmu.c                 |   2 +
 arch/x86/include/asm/paravirt.h       |   8 ++
 arch/x86/include/asm/paravirt_types.h |   6 ++
 arch/x86/include/asm/tlbflush.h       |  46 ++++----
 arch/x86/kernel/apic/apic_flat_64.c   |   4 +-
 arch/x86/kernel/apic/x2apic_cluster.c |   2 +-
 arch/x86/kernel/kvm.c                 |  11 +-
 arch/x86/kernel/paravirt.c            |   3 +
 arch/x86/kernel/smp.c                 |   2 +-
 arch/x86/lib/cache-smp.c              |   3 +-
 arch/x86/mm/init.c                    |   2 +-
 arch/x86/mm/tlb.c                     | 150 ++++++++++++++++++--------
 arch/x86/xen/mmu_pv.c                 |   2 +
 drivers/char/agp/generic.c            |   3 +-
 include/linux/smp.h                   |  32 ++++--
 kernel/smp.c                          | 141 +++++++++++-------------
 kernel/up.c                           |   3 +-
 21 files changed, 272 insertions(+), 193 deletions(-)

-- 
2.20.1

