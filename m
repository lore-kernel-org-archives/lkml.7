Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C659C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 00:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3709320883
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 00:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfFZADG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 20:03:06 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:60531 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbfFZADF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 20:03:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TVCYVJX_1561507375;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TVCYVJX_1561507375)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 Jun 2019 08:03:02 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     kirill.shutemov@linux.intel.com, ktkhai@virtuozzo.com,
        hannes@cmpxchg.org, mhocko@suse.com, hughd@google.com,
        shakeelb@google.com, rientjes@google.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v4 PATCH 0/4] Make deferred split shrinker memcg aware
Date:   Wed, 26 Jun 2019 08:02:37 +0800
Message-Id: <1561507361-59349-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Currently THP deferred split shrinker is not memcg aware, this may cause
premature OOM with some configuration. For example the below test would
run into premature OOM easily:

$ cgcreate -g memory:thp
$ echo 4G > /sys/fs/cgroup/memory/thp/memory/limit_in_bytes
$ cgexec -g memory:thp transhuge-stress 4000

transhuge-stress comes from kernel selftest.

It is easy to hit OOM, but there are still a lot THP on the deferred
split queue, memcg direct reclaim can't touch them since the deferred
split shrinker is not memcg aware.

Convert deferred split shrinker memcg aware by introducing per memcg
deferred split queue.  The THP should be on either per node or per memcg
deferred split queue if it belongs to a memcg.  When the page is
immigrated to the other memcg, it will be immigrated to the target
memcg's deferred split queue too.

Reuse the second tail page's deferred_list for per memcg list since the
same THP can't be on multiple deferred split queues.

Make deferred split shrinker not depend on memcg kmem since it is not slab.
It doesn’t make sense to not shrink THP even though memcg kmem is disabled.

With the above change the test demonstrated above doesn’t trigger OOM even
though with cgroup.memory=nokmem.


Changelog:
v4: * Replace list_del() to list_del_init() per Andrew.
    * Fixed the build failure for different kconfig combo and tested the
      below combo:
          MEMCG + TRANSPARENT_HUGEPAGE
          !MEMCG + TRANSPARENT_HUGEPAGE
          MEMCG + !TRANSPARENT_HUGEPAGE
          !MEMCG + !TRANSPARENT_HUGEPAGE
    * Added Acked-by from Kirill Shutemov. 
v3: * Adopted the suggestion from Kirill Shutemov to move mem_cgroup_uncharge()
      out of __page_cache_release() in order to handle THP free properly. 
    * Adjusted the sequence of the patches per Kirill Shutemov. Dropped the
      patch 3/4 in v2.
    * Moved enqueuing THP onto "to" memcg deferred split queue after
      page->mem_cgroup is changed in memcg account move per Kirill Tkhai.
 
v2: * Adopted the suggestion from Krill Shutemov to extract deferred split
      fields into a struct to reduce code duplication (patch 1/4).  With this
      change, the lines of change is shrunk down to 198 from 278.
    * Removed memcg_deferred_list. Use deferred_list for both global and memcg.
      With the code deduplication, it doesn't make too much sense to keep it.
      Kirill Tkhai also suggested so.
    * Fixed typo for SHRINKER_NONSLAB.

Yang Shi (4):
      mm: thp: extract split_queue_* into a struct
      mm: move mem_cgroup_uncharge out of __page_cache_release()
      mm: shrinker: make shrinker not depend on memcg kmem
      mm: thp: make deferred split shrinker memcg aware

 include/linux/huge_mm.h    |  9 +++++++
 include/linux/memcontrol.h |  4 +++
 include/linux/mm_types.h   |  1 +
 include/linux/mmzone.h     | 12 ++++++---
 include/linux/shrinker.h   |  3 ++-
 mm/huge_memory.c           | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++------------------
 mm/memcontrol.c            | 24 +++++++++++++++++
 mm/page_alloc.c            |  9 ++++---
 mm/swap.c                  |  2 +-
 mm/vmscan.c                | 36 +++++++++++++------------
 10 files changed, 147 insertions(+), 51 deletions(-)
