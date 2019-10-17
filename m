Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1871ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FC121D7A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440137AbfJQOVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:21:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:40502 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440094AbfJQOVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:21:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0C59CB447;
        Thu, 17 Oct 2019 14:21:32 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     n-horiguchi@ah.jp.nec.com
Cc:     mhocko@kernel.org, mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH v2 00/16] Hwpoison rework {hard,soft}-offline
Date:   Thu, 17 Oct 2019 16:21:07 +0200
Message-Id: <20191017142123.24245-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[NOTE]
 Although I think the patchset is ready to go since a) it fixes
 the original issues and b) survives all my tests, I wanted to
 giving it a last RFC spin.
 If no further objections are presented, I will drop the RFC.

This patchset was initially based on Naoya's hwpoison rework [1], so
thanks to him for the initial work.
I would also like to think Naoya for testing the patchset off-line,
and report any issues he found, that was quite helpful.

This patchset aims to fix some issues laying in {soft,hard}-offline handling,
but it also takes the chance and takes some further steps to perform 
cleanups and some refactoring as well.

While this patchset was initially thought for soft-offlining, I think
that hard-offline part can be further cleanup.
But that would be on top of this work.

 - Motivation:

   A customer and I were facing an issue were processes were killed
   after having soft-offlined some of their pages.
   This should not happen when soft-offlining, as it is meant to be non-disruptive.
   I was able to reproduce the issue when I stressed the memory +
   soft offlining pages in the meantime.

   After debugging the issue, I saw that the problem was that pages were returned
   back to user-space after having offlined them properly.
   So, when those pages were faulted in, the fault handler returned VM_FAULT_POISON
   all the way down to the arch handler, and it simply killed the process.

   After a further anaylsis, it became clear that the problem was that when
   kcompactd kicked in to migrate pages over, compaction_alloc callback
   was handing poisoned pages to the migrate routine.

   All this could happen because isolate_freepages_block and
   fast_isolate_freepages just check for the page to be PageBuddy,
   and since 1) poisoned pages can be part of a higher order page
   and 2) poisoned pages are also Page Buddy, they can sneak in easily.

   I also saw some other problems with sawap pages, but I suspected it
   to be the same sort of problem, so I did not follow that trace.

   The above refers to soft-offline.
   But I also saw problems with hard-offline, specially hugetlb corruption,
   and some other weird stuff. (I could paste the logs)

   The full explanation refering to the soft-offline case can be found at [2].

 - Approach:

   The taken approach is to contain those pages and never let them hit 
   neither pcplists nor buddy freelists.
   Only when they are completely out of reach, we flag them as poisoned.

   A full explanation of this can be found in patch#10 and patch#11.

 - Outcome:

   With this patchset, I no longer see the issues with soft-offline and
   hard-offline.

[1] https://lore.kernel.org/linux-mm/1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com/
[2] https://lore.kernel.org/linux-mm/20190826104144.GA7849@linux/T/#u

Naoya Horiguchi (6):
  mm,hwpoison: cleanup unused PageHuge() check
  mm,madvise: call soft_offline_page() without MF_COUNT_INCREASED
  mm,hwpoison-inject: don't pin for hwpoison_filter
  mm,hwpoison: remove MF_COUNT_INCREASED
  mm,hwpoison: remove flag argument from soft offline functions
  mm, soft-offline: convert parameter to pfn

Oscar Salvador (10):
  mm,madvise: Refactor madvise_inject_error
  mm,hwpoison: Un-export get_hwpoison_page and make it static
  mm,hwpoison: Kill put_hwpoison_page
  mm,hwpoison: Unify THP handling for hard and soft offline
  mm,hwpoison: Rework soft offline for free pages
  mm,hwpoison: Rework soft offline for in-use pages
  mm,hwpoison: Refactor soft_offline_huge_page and __soft_offline_page
  mm,hwpoison: Take pages off the buddy when hard-offlining
  mm,hwpoison: Return 0 if the page is already poisoned in soft-offline
  mm/hwpoison-inject: Rip off duplicated checks

 drivers/base/memory.c      |   7 +-
 include/linux/mm.h         |  11 +-
 include/linux/page-flags.h |   5 -
 mm/hwpoison-inject.c       |  43 +-----
 mm/madvise.c               |  39 ++---
 mm/memory-failure.c        | 365 +++++++++++++++++++++------------------------
 mm/migrate.c               |  11 +-
 mm/page_alloc.c            |  69 +++++++--
 8 files changed, 253 insertions(+), 297 deletions(-)

-- 
2.12.3

