Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6A6C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7EF208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfE1Moq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:44:46 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:52268 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727209AbfE1Mop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:44:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TStMl0v_1559047475;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TStMl0v_1559047475)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 May 2019 20:44:42 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     ktkhai@virtuozzo.com, hannes@cmpxchg.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        shakeelb@google.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] Make deferred split shrinker memcg aware
Date:   Tue, 28 May 2019 20:44:21 +0800
Message-Id: <1559047464-59838-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I got some reports from our internal application team about memcg OOM.
Even though the application has been killed by oom killer, there are
still a lot THPs reside, page reclaim doesn't reclaim them at all.

Some investigation shows they are on deferred split queue, memcg direct
reclaim can't shrink them since THP deferred split shrinker is not memcg
aware, this may cause premature OOM in memcg.  The issue can be
reproduced easily by the below test:

$ cgcreate -g memory:thp
$ echo 4G > /sys/fs/cgroup/memory/thp/memory/limit_in_bytes
$ cgexec -g memory:thp ./transhuge-stress 4000

transhuge-stress comes from kernel selftest.

It is easy to hit OOM, but there are still a lot THP on the deferred split
queue, memcg direct reclaim can't touch them since the deferred split
shrinker is not memcg aware.

Convert deferred split shrinker memcg aware by introducing per memcg deferred
split queue.  The THP should be on either per node or per memcg deferred
split queue if it belongs to a memcg.  When the page is immigrated to the
other memcg, it will be immigrated to the target memcg's deferred split queue
too.

And, move deleting THP from deferred split queue in page free before memcg
uncharge so that the page's memcg information is available.

Reuse the second tail page's deferred_list for per memcg list since the same
THP can't be on multiple deferred split queues at the same time.

Remove THP specific destructor since it is not used anymore with memcg aware
THP shrinker (Please see the commit log of patch 2/3 for the details).

Make deferred split shrinker not depend on memcg kmem since it is not slab.
It doesn't make sense to not shrink THP even though memcg kmem is disabled.

With the above change the test demonstrated above doesn't trigger OOM anymore
even though with cgroup.memory=nokmem.


Yang Shi (3):
      mm: thp: make deferred split shrinker memcg aware
      mm: thp: remove THP destructor
      mm: shrinker: make shrinker not depend on memcg kmem

 include/linux/huge_mm.h    |  24 +++++++++
 include/linux/memcontrol.h |   6 +++
 include/linux/mm.h         |   3 --
 include/linux/mm_types.h   |   7 ++-
 include/linux/shrinker.h   |   3 +-
 mm/huge_memory.c           | 181 ++++++++++++++++++++++++++++++++++++++++++++++++-------------------
 mm/memcontrol.c            |  20 ++++++++
 mm/page_alloc.c            |   3 --
 mm/swap.c                  |   4 ++
 mm/vmscan.c                |  27 +++-------
 10 files changed, 198 insertions(+), 80 deletions(-)
