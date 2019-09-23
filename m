Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85562C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 04:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580AF20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 04:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbfIWEZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 00:25:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfIWEZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 00:25:40 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D5ED85538
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 04:25:40 +0000 (UTC)
Received: by mail-pg1-f200.google.com with SMTP id d3so5020561pgv.9
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 21:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G7OJPYXScS/aprwEHeB3wBmaaEIrzoxx5Za5qyc7/bs=;
        b=QNFtnXxrxu2FKaCz5QNcKp0YEmCeupUncTZzOKH+/2gkVj8ykAhw7IyxajZFGMkTcA
         IPYbyZ4aceuiuBl2oBprGI5bKbi3D5GzbBtDT4GJWSFvV6Zx4vXTDOJY/4sClbmd4NPN
         vAwdJB6d+FCdiQLLGnP0+jLkAa/Y6FDnZYeX0piEC8k4DPfl4NI6vQOnMWpEEga07ZM1
         PCvFSAAT6iHpv2uVkllPXWzZp76M3BCjkKGPi5OQ191vdvUfdphuaGCcrAtMgZbmyf+s
         9gSWOYNU3B4KaoEhknjmsrsfI/txcFDqAiMLH5SGV29FcFXes4xycQEt11yReoW0r8H8
         otDQ==
X-Gm-Message-State: APjAAAWThVq2wKZ8eqwfLefh/a3M7cHfP3s7Tl7Lc7wS76HjGlccEwWG
        kb9byDhEf3mLfouTFLE6ibaozELc/jGF79dW0+9Tgxi2+9W1k1fbEkKNUW0b5BoMm8NZm83PDhM
        s+kMiTdLDI38/byCk2+aDH2f9
X-Received: by 2002:a63:a369:: with SMTP id v41mr59368pgn.148.1569212739920;
        Sun, 22 Sep 2019 21:25:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxN5IPd3dnULbwjrVGDF+2da6/6JNBmAnDKOwrR5ZZNcp6rZnCt3mj9HLRdTa6gUsED6y5n2w==
X-Received: by 2002:a63:a369:: with SMTP id v41mr59337pgn.148.1569212739518;
        Sun, 22 Sep 2019 21:25:39 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x20sm11781867pfp.120.2019.09.22.21.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 21:25:38 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Marty McFadden <mcfadden8@llnl.gov>, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v4 00/10] mm: Page fault enhancements
Date:   Mon, 23 Sep 2019 12:25:13 +0800
Message-Id: <20190923042523.10027-1-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 4th version of the PF enhancement series on signal
handlings and fault retries.  This new version does not change
existing patches in v3 but added two more patches to address the
current gup issue on not responding to SIGKILL.  A 3rd new patch is
also added to allow handle_userfaultfd to respect FAULT_FLAG_KILLABLE
though should have no functional change when with the two new patches
above.

I would really appreciate any review comments for the series,
especially for the first two patches which IMHO are even not related
to this patchset and they should either cleanup or fix things.

v4:
- use lore.kernel.org for all the links in commit messages [Kirill]
- one more patch ("mm/gup: Fix __get_user_pages() on fault retry of
  hugetlb") to fix hugetlb path on fault retry
- one more patch ("mm/gup: Allow to react to fatal signals") to:
  - use down_read_killable() properly [Linus]
  - pass in FAULT_FLAG_KILLABLE for all GUP [Linus]
- one more patch ("mm/userfaultfd: Honor FAULT_FLAG_KILLABLE in fault
  path") to let handle_userfaultfd() respect FAULT_FLAG_KILLABLE.
  Should have no functional change after previous two new patches.

v3:
- check fatal signals in __get_user_page_locked() [Linus]
- add r-bs

v2:
- resent previous version, rebase only

=============== v1 cover letter ==================

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

Peter Xu (10):
  mm/gup: Rename "nonblocking" to "locked" where proper
  mm/gup: Fix __get_user_pages() on fault retry of hugetlb
  mm: Introduce FAULT_FLAG_DEFAULT
  mm: Introduce FAULT_FLAG_INTERRUPTIBLE
  mm: Return faster for non-fatal signals in user mode faults
  userfaultfd: Don't retake mmap_sem to emulate NOPAGE
  mm: Allow VM_FAULT_RETRY for multiple times
  mm/gup: Allow VM_FAULT_RETRY for multiple times
  mm/gup: Allow to react to fatal signals
  mm/userfaultfd: Honor FAULT_FLAG_KILLABLE in fault path

 arch/alpha/mm/fault.c           |  7 +--
 arch/arc/mm/fault.c             |  8 ++-
 arch/arm/mm/fault.c             | 14 +++--
 arch/arm64/mm/fault.c           | 16 +++---
 arch/hexagon/mm/vm_fault.c      |  6 +--
 arch/ia64/mm/fault.c            |  6 +--
 arch/m68k/mm/fault.c            | 10 ++--
 arch/microblaze/mm/fault.c      |  6 +--
 arch/mips/mm/fault.c            |  6 +--
 arch/nds32/mm/fault.c           | 12 ++---
 arch/nios2/mm/fault.c           |  8 ++-
 arch/openrisc/mm/fault.c        |  6 +--
 arch/parisc/mm/fault.c          |  9 ++--
 arch/powerpc/mm/fault.c         | 10 ++--
 arch/riscv/mm/fault.c           | 12 ++---
 arch/s390/mm/fault.c            | 11 ++--
 arch/sh/mm/fault.c              |  7 ++-
 arch/sparc/mm/fault_32.c        |  5 +-
 arch/sparc/mm/fault_64.c        |  6 +--
 arch/um/kernel/trap.c           |  7 +--
 arch/unicore32/mm/fault.c       | 11 ++--
 arch/x86/mm/fault.c             |  6 +--
 arch/xtensa/mm/fault.c          |  6 +--
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 12 +++--
 fs/userfaultfd.c                | 62 ++++++++++------------
 include/linux/mm.h              | 81 ++++++++++++++++++++++++----
 include/linux/sched/signal.h    | 12 +++++
 mm/filemap.c                    |  2 +-
 mm/gup.c                        | 93 +++++++++++++++++++++------------
 mm/hugetlb.c                    | 17 +++---
 mm/shmem.c                      |  2 +-
 31 files changed, 283 insertions(+), 193 deletions(-)

-- 
2.21.0

