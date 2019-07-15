Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6E4C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C2220659
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbfGOTta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:49:30 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:56859 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730487AbfGOTta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:49:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TX.eHB5_1563220162;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TX.eHB5_1563220162)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Jul 2019 03:49:25 +0800
Subject: Re: [v3 PATCH 0/2] Fix false negative of shmem vma's THP eligibility
To:     hughd@google.com, kirill.shutemov@linux.intel.com, mhocko@suse.com,
        vbabka@suse.cz, rientjes@google.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1560401041-32207-1-git-send-email-yang.shi@linux.alibaba.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <11e1c58e-ffa4-fcb0-dc9e-95354e21c392@linux.alibaba.com>
Date:   Mon, 15 Jul 2019 12:49:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1560401041-32207-1-git-send-email-yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,


Any comments for this version? Although they have been in -mm tree, they 
didn't make in 5.3 merge window, I'm supposed Andrew needs ack from you 
or someone else.


Thanks,

Yang



On 6/12/19 9:43 PM, Yang Shi wrote:
> The commit 7635d9cbe832 ("mm, thp, proc: report THP eligibility for each
> vma") introduced THPeligible bit for processes' smaps. But, when checking
> the eligibility for shmem vma, __transparent_hugepage_enabled() is
> called to override the result from shmem_huge_enabled().  It may result
> in the anonymous vma's THP flag override shmem's.  For example, running a
> simple test which create THP for shmem, but with anonymous THP disabled,
> when reading the process's smaps, it may show:
>
> 7fc92ec00000-7fc92f000000 rw-s 00000000 00:14 27764 /dev/shm/test
> Size:               4096 kB
> ...
> [snip]
> ...
> ShmemPmdMapped:     4096 kB
> ...
> [snip]
> ...
> THPeligible:    0
>
> And, /proc/meminfo does show THP allocated and PMD mapped too:
>
> ShmemHugePages:     4096 kB
> ShmemPmdMapped:     4096 kB
>
> This doesn't make too much sense.  The shmem objects should be treated
> separately from anonymous THP.  Calling shmem_huge_enabled() with checking
> MMF_DISABLE_THP sounds good enough.  And, we could skip stack and
> dax vma check since we already checked if the vma is shmem already.
>
> The transhuge_vma_suitable() is needed to check vma, but it was only
> available for shmem THP.  The patch 1/2 makes it available for all kind of
> THPs and does some code duplication cleanup, so it is made a separate patch.
>
>
> Changelog:
> v3: * Check if vma is suitable for allocating THP per Hugh Dickins
>      * Fixed smaps output alignment and documentation per Hugh Dickins
> v2: * Check VM_NOHUGEPAGE per Michal Hocko
>
>
> Yang Shi (2):
>        mm: thp: make transhuge_vma_suitable available for anonymous THP
>        mm: thp: fix false negative of shmem vma's THP eligibility
>
>   Documentation/filesystems/proc.txt |  4 ++--
>   fs/proc/task_mmu.c                 |  3 ++-
>   mm/huge_memory.c                   | 11 ++++++++---
>   mm/internal.h                      | 25 +++++++++++++++++++++++++
>   mm/memory.c                        | 13 -------------
>   mm/shmem.c                         |  3 +++
>   6 files changed, 40 insertions(+), 19 deletions(-)

