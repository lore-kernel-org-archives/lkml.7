Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90CFC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87ED216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390976AbfETOPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:15:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29061 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390783AbfETOPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:15:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8DEBE81DFC;
        Mon, 20 May 2019 14:15:06 +0000 (UTC)
Received: from llong.com (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4579710027BC;
        Mon, 20 May 2019 14:14:59 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Yang Shi <yang.shi@linux.alibaba.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Qian Cai <cai@gmx.us>, Zhong Jiang <zhongjiang@huawei.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/5] debugobjects: Reduce global pool_lock contention
Date:   Mon, 20 May 2019 10:14:45 -0400
Message-Id: <20190520141450.7575-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 20 May 2019 14:15:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many large workloads require the kernel to acquire a lot of objects
and then free them when the work is done. When the debug objects code
is configured, this will cause a lot of debug objects to be allocated and
then free later on. For instance, after a kernel boot up and 3 parallel
kernel builds, the partial output of the debug objects stats file was:

  pool_free     :3082
  pool_min_free :498
  pool_used     :108488
  pool_max_used :170127
  on_free_list  :0
  objs_allocated:34954917
  objs_freed    :34844371

It can be seen that a lot of debug objects were allocated and freed
during those operations. All these debug object allocation and free
operations require grabbing the global pool_lock. On systems with many
CPUs, the contention on this single global lock can become one of the
bottlenecks.

This patchset tries to reduce the level of contention on this global
pool_lock by the following means:
 1) Add a percpu free object pool to serve as a cache so that object
    allocation and freeing can be done without acquiring pool_lock when
    is not empty or full.
 2) Batching up multiple operations in a single lock/unlock critical
    section to reduce the number of times the pool_lock is to be
    acquired.
 3) Make the actual freeing of the debug objects via the workqueue less
    aggressive to minimize the actual number of slab allocation and
    freeing calls.

In addition, this patchset also tries to move the printk() call out
of the raw db->lock critical section to reduce the lock hold time as
much as possible.

With or without these changes, the times to do a parallel kernel build
on a 2-socket 36-core 72-thread Haswell system were:

   Kernel         Elapsed time      System time
   ------         ------------      -----------
   Pre-patch        4m51.01s         83m11.53s
   Post-patch       4m47.45s         80m25.78s

The post-patch partial debug objects stats file for the same operations
was:

  pool_free     :5901
  pool_pcp_free :3742
  pool_min_free :1022
  pool_used     :104805
  pool_max_used :168081
  on_free_list  :0
  objs_allocated:5796864
  objs_freed    :5687182

Waiman Long (5):
  debugobjects: Add percpu free pools
  debugobjects: Percpu pool lookahead freeing/allocation
  debugobjects: Reduce number of pool_lock acquisitions in fill_pool()
  debugobjects: Less aggressive freeing of excess debug objects
  debugobjects: Move printk out of db lock critical sections

 lib/debugobjects.c | 308 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 252 insertions(+), 56 deletions(-)

-- 
2.18.1

