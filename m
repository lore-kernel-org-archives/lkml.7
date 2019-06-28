Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D106C5B57B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA0220656
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfF1KpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:45:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbfF1KpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:45:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71AB381F0E;
        Fri, 28 Jun 2019 10:44:48 +0000 (UTC)
Received: from xz-x1.redhat.com (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB5785D705;
        Fri, 28 Jun 2019 10:44:34 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH 0/7] mm: Page fault enhancements
Date:   Fri, 28 Jun 2019 18:44:25 +0800
Message-Id: <20190628104432.12799-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 28 Jun 2019 10:45:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is split out of userfaultfd-wp series to only cover the
general page fault changes, since it seems to make sense itself.

Basically it does two things:

  (a) Allows the page fault handlers to be more interactive on not
      only SIGKILL, but also the rest of userspace signals (especially
      for user-mode faults), and,

  (b) Allows the page fault retry (VM_FAULT_RETRY) to happen for more
      than once.

I'm keeping the CC list as in uffd-wp v5, hopefully I'm not sending
too much spams...

And, instead of writting again the cover letter, I'm just copy-pasting
my previous link here which has more details on why we do this:

  https://patchwork.kernel.org/cover/10691991/

The major change from that latest version should be that we introduced
a new page fault flag FAULT_FLAG_INTERRUPTIBLE as suggested by Linus
[1] to represents that we would like the fault handler to respond to
non-fatal signals.  Also, we're more careful now on when to do the
immediate return of the page fault for such signals.  For example, now
we'll only check against signal_pending() for user-mode page faults
and we keep the kernel-mode page fault patch untouched for it.  More
information can be found in separate patches.

The patchset is only lightly tested on x86.

All comments are greatly welcomed.  Thanks,

[1] https://lkml.org/lkml/2019/6/25/1382

Peter Xu (7):
  mm/gup: Rename "nonblocking" to "locked" where proper
  mm: Introduce FAULT_FLAG_DEFAULT
  mm: Introduce FAULT_FLAG_INTERRUPTIBLE
  mm: Return faster for non-fatal signals in user mode faults
  userfaultfd: Don't retake mmap_sem to emulate NOPAGE
  mm: Allow VM_FAULT_RETRY for multiple times
  mm/gup: Allow VM_FAULT_RETRY for multiple times

 arch/alpha/mm/fault.c           |  7 +--
 arch/arc/mm/fault.c             | 17 ++-----
 arch/arm/mm/fault.c             | 14 +++---
 arch/arm64/mm/fault.c           | 16 +++----
 arch/hexagon/mm/vm_fault.c      |  6 +--
 arch/ia64/mm/fault.c            |  6 +--
 arch/m68k/mm/fault.c            | 10 ++--
 arch/microblaze/mm/fault.c      |  6 +--
 arch/mips/mm/fault.c            |  6 +--
 arch/nds32/mm/fault.c           | 12 ++---
 arch/nios2/mm/fault.c           |  8 ++--
 arch/openrisc/mm/fault.c        |  6 +--
 arch/parisc/mm/fault.c          |  9 ++--
 arch/powerpc/mm/fault.c         | 10 ++--
 arch/riscv/mm/fault.c           | 12 ++---
 arch/s390/mm/fault.c            | 11 ++---
 arch/sh/mm/fault.c              |  7 ++-
 arch/sparc/mm/fault_32.c        |  5 +-
 arch/sparc/mm/fault_64.c        |  6 +--
 arch/um/kernel/trap.c           |  7 +--
 arch/unicore32/mm/fault.c       | 11 ++---
 arch/x86/mm/fault.c             |  6 +--
 arch/xtensa/mm/fault.c          |  6 +--
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 12 +++--
 fs/userfaultfd.c                | 28 +-----------
 include/linux/mm.h              | 81 +++++++++++++++++++++++++++++----
 include/linux/sched/signal.h    | 12 +++++
 mm/filemap.c                    |  2 +-
 mm/gup.c                        | 61 ++++++++++++++-----------
 mm/hugetlb.c                    | 14 +++---
 mm/shmem.c                      |  2 +-
 31 files changed, 226 insertions(+), 190 deletions(-)

-- 
2.21.0

