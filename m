Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB82C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200A221743
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387664AbfIEKPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:15:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733028AbfIEKPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:15:50 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 829838830A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2019 10:15:49 +0000 (UTC)
Received: by mail-pl1-f200.google.com with SMTP id c14so1169385plo.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 03:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sGQuWQQe8fDlEhpLmREf75/mh3j/W3ajLyehA5owUl8=;
        b=UJGhpLyq2DfLcq2K49Ud4Jyf0sft8raWbig7Gk13J9Pu0fRVe88/QhLPqrUNNcz74+
         NKcMToROw0MNKKJiKwYzmn+nPnR51aj873GsBl8TjP4EvKyPE4Ulm1uo6Yz4vqVCe9Bp
         XJeaTsq/6W/KeBMVbEe46SqCsuEG439eGpNw89Yx+9ZtNvTdUrjNWaOy5uvD1cLkGQy5
         TR23VmQD+Bb6Hxn2ESAcJ6cxUfRtspAMc3K3WVXPUZQ/q/C1DDkOA8O+69Bh89sN6e+7
         0lYhC/zEiFCrtvLqQJqR2/hBdlutEyEjKBBvZyN3mu5KmT+8MxPLfm+M35L1zoDOGBxA
         BDWQ==
X-Gm-Message-State: APjAAAUfBvldXV8WKSkxZO7eS8kb8051WwvjOpDFWUfNfnEjjD4GCkpR
        FKk5HhLKL7tTVMLK/29BNxOVF2WLNS6XjT52bQf+xJbUmleo4nEtDBmc/pWx+70uRUOfI2GJ0Aj
        UsjMD5hveDyBV85QuMt/u6Mzt
X-Received: by 2002:a17:902:8a81:: with SMTP id p1mr2465944plo.71.1567678549045;
        Thu, 05 Sep 2019 03:15:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwgSRo4NDJ7ab9oov6zo1BxyCr5I28O4Qdk/qqHUJDnK0Sb3P39/6OhZUQ34zMdEKMPdKxa2A==
X-Received: by 2002:a17:902:8a81:: with SMTP id p1mr2465913plo.71.1567678548782;
        Thu, 05 Sep 2019 03:15:48 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a20sm413852pfo.33.2019.09.05.03.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 03:15:48 -0700 (PDT)
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
Subject: [PATCH v2 0/7] mm: Page fault enhancements
Date:   Thu,  5 Sep 2019 18:15:27 +0800
Message-Id: <20190905101534.9637-1-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- resent previous version, rebase only

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
 arch/arc/mm/fault.c             |  8 +++-
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
 31 files changed, 227 insertions(+), 180 deletions(-)

-- 
2.21.0

