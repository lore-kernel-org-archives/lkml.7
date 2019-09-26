Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BB7C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797B1222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfIZJjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:39:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbfIZJjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:39:22 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3CDB12A09BB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 09:39:21 +0000 (UTC)
Received: by mail-pf1-f200.google.com with SMTP id m25so1335473pfa.23
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 02:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XpJIVkV2JTQeqVrGvzpBNVWPrss7wtwRxivKCELQDgQ=;
        b=r4xfCV2z06GR0CjNfwhsx6O7E4uv2tr1Bvje+xFEI86DXyYzxq9MrIpgJGLOJQl/Wj
         uftNoAeFg8FL+h2jxNeJBi0ANtCxtZr04vhPZYrD4aUWHnLBsFM/xbr730YY+CMRGB1G
         iN7hTOh7LjubztBwcOt3ESLeLDPKEckb8l01jJiQdOeFFC1jSMzvaJScOHfPQv5QGt3c
         DjlpocgrxxBooJwu4EVvFpYDqTEKXo4cABh1TW8QuoeDxjf9oXH+1+llCDdsJnoqnPRO
         bUmvlD4RLelxsoC9NOHqw+Ilc4dSsa1trJJsu7K5a/RgttksB/ZvrXJ+M1/hIcdls1Zz
         UisA==
X-Gm-Message-State: APjAAAWR5h1Y56HxHMvs7EnLEgtmVNsYLs9erQZifJfnOrebpX6QfSJY
        FlNLQ45aIBr10nl/NyeGRi6Ua5HCASvgva/IOL+DlSfmYQwYtCgZv8hGrfdKKmlfXXQPQUmg329
        3n4lqtjQxlO7+WjY5rLYMo7tP
X-Received: by 2002:a63:505:: with SMTP id 5mr2376093pgf.297.1569490760657;
        Thu, 26 Sep 2019 02:39:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz246WsKNOlpuxSaHx2kHIp4UrwpzYlBY+LHB45Q4lkin9SL8l7rEsBBaugQ/q5VsAk+stD9g==
X-Received: by 2002:a63:505:: with SMTP id 5mr2376051pgf.297.1569490760262;
        Thu, 26 Sep 2019 02:39:20 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p68sm3224982pfp.9.2019.09.26.02.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 02:39:19 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Matthew Wilcox <willy@infradead.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v5 00/16] mm: Page fault enhancements
Date:   Thu, 26 Sep 2019 17:38:48 +0800
Message-Id: <20190926093904.5090-1-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v5 of the series.  As Matthew suggested, I split the previous
patch "mm: Return faster for non-fatal signals in user mode faults"
into a few smaller ones:

  1. One patch to introduce fatal_signal_pending(), and use it in
     archs that can directly apply

  2. A few more patches to let the rest archs to use the new helper.
     With that we can have an unified entry for signal detection

  3. One last patch to change fatal_signal_pending() to detect
     userspace non-fatal signal

Nothing should have changed in the rest patches.  Because the fault
retry patches will depend on the previous ones, I decided to simply
repost all the patches.

Here's the new patchset layout:

Patch 1-2:      cleanup, and potential bugfix of hugetlbfs on fault retry

Patch 3-9:      let page fault to respond to non-fatal signals faster

Patch 10:       remove the userfaultfd NOPAGE emulation

Patch 11-14:    allow page fault to retry more than once

Patch 15-16:    let gup code to use FAULT_FLAG_KILLABLE too

I would really appreciate any review comments for the series,
especially for the first two patches which IMHO are even not related
to this patchset and they should either cleanup or fix things.

Smoke tested on x86 only.

Thanks,

v5:
- split "mm: Return faster for non-fatal signals in user mode faults"
  into a few more patches, let all archs to use an unified entry for
  fast signal handling (fatal_signal_pending)

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

Peter Xu (16):
  mm/gup: Rename "nonblocking" to "locked" where proper
  mm/gup: Fix __get_user_pages() on fault retry of hugetlb
  mm: Introduce fault_signal_pending()
  x86/mm: Use helper fault_signal_pending()
  arc/mm: Use helper fault_signal_pending()
  arm64/mm: Use helper fault_signal_pending()
  powerpc/mm: Use helper fault_signal_pending()
  sh/mm: Use helper fault_signal_pending()
  mm: Return faster for non-fatal signals in user mode faults
  userfaultfd: Don't retake mmap_sem to emulate NOPAGE
  mm: Introduce FAULT_FLAG_DEFAULT
  mm: Introduce FAULT_FLAG_INTERRUPTIBLE
  mm: Allow VM_FAULT_RETRY for multiple times
  mm/gup: Allow VM_FAULT_RETRY for multiple times
  mm/gup: Allow to react to fatal signals
  mm/userfaultfd: Honor FAULT_FLAG_KILLABLE in fault path

 arch/alpha/mm/fault.c           |  6 +--
 arch/arc/mm/fault.c             | 35 +++++--------
 arch/arm/mm/fault.c             |  7 +--
 arch/arm64/mm/fault.c           | 26 +++------
 arch/hexagon/mm/vm_fault.c      |  5 +-
 arch/ia64/mm/fault.c            |  5 +-
 arch/m68k/mm/fault.c            |  7 +--
 arch/microblaze/mm/fault.c      |  5 +-
 arch/mips/mm/fault.c            |  5 +-
 arch/nds32/mm/fault.c           |  5 +-
 arch/nios2/mm/fault.c           |  7 +--
 arch/openrisc/mm/fault.c        |  5 +-
 arch/parisc/mm/fault.c          |  8 ++-
 arch/powerpc/mm/fault.c         | 20 ++-----
 arch/riscv/mm/fault.c           |  9 +---
 arch/s390/mm/fault.c            | 10 ++--
 arch/sh/mm/fault.c              | 13 +++--
 arch/sparc/mm/fault_32.c        |  5 +-
 arch/sparc/mm/fault_64.c        |  5 +-
 arch/um/kernel/trap.c           |  3 +-
 arch/unicore32/mm/fault.c       |  8 ++-
 arch/x86/mm/fault.c             | 30 +++++------
 arch/xtensa/mm/fault.c          |  5 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 12 +++--
 fs/userfaultfd.c                | 62 ++++++++++------------
 include/linux/mm.h              | 81 ++++++++++++++++++++++++----
 include/linux/sched/signal.h    | 14 +++++
 mm/filemap.c                    |  2 +-
 mm/gup.c                        | 93 +++++++++++++++++++++------------
 mm/hugetlb.c                    | 17 +++---
 mm/shmem.c                      |  2 +-
 31 files changed, 279 insertions(+), 238 deletions(-)

-- 
2.21.0

