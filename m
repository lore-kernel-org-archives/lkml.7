Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9446C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C329D208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfFGGIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 02:08:13 -0400
Received: from out4437.biz.mail.alibaba.com ([47.88.44.37]:20878 "EHLO
        out4437.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726948AbfFGGIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:08:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TTcZLUN_1559887677;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TTcZLUN_1559887677)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Jun 2019 14:08:09 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     ktkhai@virtuozzo.com, kirill.shutemov@linux.intel.com,
        hannes@cmpxchg.org, mhocko@suse.com, hughd@google.com,
        shakeelb@google.com, rientjes@google.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 0/4] Make deferred split shrinker memcg aware
Date:   Fri,  7 Jun 2019 14:07:35 +0800
Message-Id: <1559887659-23121-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
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

And, move deleting THP from deferred split queue in page free before
memcg uncharge so that the page's memcg information is available.

Reuse the second tail page's deferred_list for per memcg list since the
same THP can't be on multiple deferred split queues.

Remove THP specific destructor since it is not used anymore with memcg
aware THP shrinker (Please see the commit log of patch 3/4 for the details).

Make deferred split shrinker not depend on memcg kmem since it is not slab.
It doesn't make sense to not shrink THP even though memcg kmem is disabled.

With the above change the test demonstrated above doesn't trigger OOM even
though with cgroup.memory=nokmem.


Changelog:
v2: * Adopted the suggestion from Krill Shutemov to extract deferred split
      fields into a struct to reduce code duplication (patch 1/4).  With this
      change, the lines of change is shrunk down to 198 from 278.
    * Removed memcg_deferred_list. Use deferred_list for both global and memcg.
      With the code deduplication, it doesn't make too much sense to keep it.
      Kirill Tkhai also suggested so.
    * Fixed typo for SHRINKER_NONSLAB.


Yang Shi (4):
      mm: thp: extract split_queue_* into a struct
      mm: thp: make deferred split shrinker memcg aware
      mm: thp: remove THP destructor
      mm: shrinker: make shrinker not depend on memcg kmem

 include/linux/huge_mm.h    | 15 +++++++++++
 include/linux/memcontrol.h |  4 +++
 include/linux/mm.h         |  3 ---
 include/linux/mm_types.h   |  1 +
 include/linux/mmzone.h     | 12 ++++++---
 include/linux/shrinker.h   |  3 +--
 mm/huge_memory.c           | 99 ++++++++++++++++++++++++++++++++++++++++++++------------------------
 mm/memcontrol.c            | 19 +++++++++++++
 mm/page_alloc.c            | 11 ++++----
 mm/swap.c                  |  4 +++
 mm/vmscan.c                | 27 +++++--------------
 11 files changed, 129 insertions(+), 69 deletions(-)
