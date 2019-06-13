Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5992C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6812084D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404262AbfFMQs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:48:56 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:35192 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727910AbfFMEoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 00:44:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TU25N7U_1560401051;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TU25N7U_1560401051)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Jun 2019 12:44:19 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     hughd@google.com, kirill.shutemov@linux.intel.com, mhocko@suse.com,
        vbabka@suse.cz, rientjes@google.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 0/2] Fix false negative of shmem vma's THP eligibility
Date:   Thu, 13 Jun 2019 12:43:59 +0800
Message-Id: <1560401041-32207-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The commit 7635d9cbe832 ("mm, thp, proc: report THP eligibility for each
vma") introduced THPeligible bit for processes' smaps. But, when checking
the eligibility for shmem vma, __transparent_hugepage_enabled() is
called to override the result from shmem_huge_enabled().  It may result
in the anonymous vma's THP flag override shmem's.  For example, running a
simple test which create THP for shmem, but with anonymous THP disabled,
when reading the process's smaps, it may show:

7fc92ec00000-7fc92f000000 rw-s 00000000 00:14 27764 /dev/shm/test
Size:               4096 kB
...
[snip]
...
ShmemPmdMapped:     4096 kB
...
[snip]
...
THPeligible:    0

And, /proc/meminfo does show THP allocated and PMD mapped too:

ShmemHugePages:     4096 kB
ShmemPmdMapped:     4096 kB

This doesn't make too much sense.  The shmem objects should be treated
separately from anonymous THP.  Calling shmem_huge_enabled() with checking
MMF_DISABLE_THP sounds good enough.  And, we could skip stack and
dax vma check since we already checked if the vma is shmem already.

The transhuge_vma_suitable() is needed to check vma, but it was only
available for shmem THP.  The patch 1/2 makes it available for all kind of
THPs and does some code duplication cleanup, so it is made a separate patch.


Changelog:
v3: * Check if vma is suitable for allocating THP per Hugh Dickins
    * Fixed smaps output alignment and documentation per Hugh Dickins
v2: * Check VM_NOHUGEPAGE per Michal Hocko


Yang Shi (2):
      mm: thp: make transhuge_vma_suitable available for anonymous THP
      mm: thp: fix false negative of shmem vma's THP eligibility

 Documentation/filesystems/proc.txt |  4 ++--
 fs/proc/task_mmu.c                 |  3 ++-
 mm/huge_memory.c                   | 11 ++++++++---
 mm/internal.h                      | 25 +++++++++++++++++++++++++
 mm/memory.c                        | 13 -------------
 mm/shmem.c                         |  3 +++
 6 files changed, 40 insertions(+), 19 deletions(-)
