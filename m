Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF55CC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85ACE20862
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="OqcKX4sr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732765AbfJCTpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 15:45:05 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39565 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfJCTpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:45:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id n7so5299732qtb.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 12:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZK/812DPI17OzssjX/ncpTsS1jxD3oLQB/kn3c5LmsE=;
        b=OqcKX4sr8ZKSCXRtmZs1YRVarga2V/sRg80tJUxWRQI5y50OxsUtDkuZ0FzEUYx0v3
         USAo9JdKRTaCRkwFT8Gh2UGcj10DES0uduJntykuhHB9m8+43MBvMf/j17HGTJ1WZrVP
         1yzUfy+C8jubt4qt5bB/+RqPgEC4/XLf6MolVsZqVF6a+LMMjpFcPkuvPeKmr0KDDqZP
         VgN27bApJ8KKW8R3IY/3ecpMuVURZIz6OlEcNpv8R3T9NuvAGUwEo5umzner1BtBcQd8
         S/nXRccpSzYUdBKdXzykHWQ8SjI1nomhO9WMS0e+bV6lwx9eH+GAP5LcMD+wOrWje3Mr
         V8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZK/812DPI17OzssjX/ncpTsS1jxD3oLQB/kn3c5LmsE=;
        b=m25Kc8HR87gzss+lrmcnm/Iu2gcMXgc8p/lmqJrRJujMDUTx/BjDslavcIuO6PlUH3
         Yrl9MqoyakmMeH4Wdp8pMmL5xzNP3jUPtCLkqovLwqK1iDS/Xl3ETcEjr9qORtW1l8kx
         lnVCGFbhi766wpR2vUuHcFa4m59nAhYeFtS0VXT+Fhayn9JddSotY2+bfjrdskaFNhLi
         N/Y2gDcMzzLO+LNBEd83X0EsotY3cKdOKXE0B3BlUpE1UECirTEub2gs+X1HVhaTItaP
         AZGvNC5Q0rqTiHkHcoqGqZY+cQLWUtMdT0loIZcec4x1MxFjd3pkIJCwbOYXJ+7bYMxr
         NnOg==
X-Gm-Message-State: APjAAAU4YBsgNh4nYdrMBPWZSkVpRM4/lEYz/F/5ooiXdqMrXUFyIA8q
        OPEu//WsW4qf4+i0n8DyGpWLIA==
X-Google-Smtp-Source: APXvYqzMTk5toL2TSFld1we47WRlfymL5JjfFJxKadNqOphmEFP5vvj0Y2Kq9gheRH8hp8Hte6YMDA==
X-Received: by 2002:ac8:7a8d:: with SMTP id x13mr11874246qtr.155.1570131901888;
        Thu, 03 Oct 2019 12:45:01 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q6sm1837346qkj.108.2019.10.03.12.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 12:45:01 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        tj@kernel.org, vdavydov.dev@gmail.com, hannes@cmpxchg.org,
        guro@fb.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/slub: fix a deadlock in show_slab_objects()
Date:   Thu,  3 Oct 2019 15:44:29 -0400
Message-Id: <1570131869-2545-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Long time ago, there fixed a similar deadlock in show_slab_objects()
[1]. However, it is apparently due to the commits like 01fb58bcba63
("slab: remove synchronous synchronize_sched() from memcg cache
deactivation path") and 03afc0e25f7f ("slab: get_online_mems for
kmem_cache_{create,destroy,shrink}"), this kind of deadlock is back by
just reading files in /sys/kernel/slab will generate a lockdep splat
below.

Since the "mem_hotplug_lock" here is only to obtain a stable online node
mask while racing with NUMA node hotplug, it is probably fine to do
without it.

WARNING: possible circular locking dependency detected
------------------------------------------------------
cat/5224 is trying to acquire lock:
ffff900012ac3120 (mem_hotplug_lock.rw_sem){++++}, at:
show_slab_objects+0x94/0x3a8

but task is already holding lock:
b8ff009693eee398 (kn->count#45){++++}, at: kernfs_seq_start+0x44/0xf0

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (kn->count#45){++++}:
       lock_acquire+0x31c/0x360
       __kernfs_remove+0x290/0x490
       kernfs_remove+0x30/0x44
       sysfs_remove_dir+0x70/0x88
       kobject_del+0x50/0xb0
       sysfs_slab_unlink+0x2c/0x38
       shutdown_cache+0xa0/0xf0
       kmemcg_cache_shutdown_fn+0x1c/0x34
       kmemcg_workfn+0x44/0x64
       process_one_work+0x4f4/0x950
       worker_thread+0x390/0x4bc
       kthread+0x1cc/0x1e8
       ret_from_fork+0x10/0x18

-> #1 (slab_mutex){+.+.}:
       lock_acquire+0x31c/0x360
       __mutex_lock_common+0x16c/0xf78
       mutex_lock_nested+0x40/0x50
       memcg_create_kmem_cache+0x38/0x16c
       memcg_kmem_cache_create_func+0x3c/0x70
       process_one_work+0x4f4/0x950
       worker_thread+0x390/0x4bc
       kthread+0x1cc/0x1e8
       ret_from_fork+0x10/0x18

-> #0 (mem_hotplug_lock.rw_sem){++++}:
       validate_chain+0xd10/0x2bcc
       __lock_acquire+0x7f4/0xb8c
       lock_acquire+0x31c/0x360
       get_online_mems+0x54/0x150
       show_slab_objects+0x94/0x3a8
       total_objects_show+0x28/0x34
       slab_attr_show+0x38/0x54
       sysfs_kf_seq_show+0x198/0x2d4
       kernfs_seq_show+0xa4/0xcc
       seq_read+0x30c/0x8a8
       kernfs_fop_read+0xa8/0x314
       __vfs_read+0x88/0x20c
       vfs_read+0xd8/0x10c
       ksys_read+0xb0/0x120
       __arm64_sys_read+0x54/0x88
       el0_svc_handler+0x170/0x240
       el0_svc+0x8/0xc

other info that might help us debug this:

Chain exists of:
  mem_hotplug_lock.rw_sem --> slab_mutex --> kn->count#45

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(kn->count#45);
                               lock(slab_mutex);
                               lock(kn->count#45);
  lock(mem_hotplug_lock.rw_sem);

 *** DEADLOCK ***

3 locks held by cat/5224:
 #0: 9eff00095b14b2a0 (&p->lock){+.+.}, at: seq_read+0x4c/0x8a8
 #1: 0eff008997041480 (&of->mutex){+.+.}, at: kernfs_seq_start+0x34/0xf0
 #2: b8ff009693eee398 (kn->count#45){++++}, at:
kernfs_seq_start+0x44/0xf0

stack backtrace:
Call trace:
 dump_backtrace+0x0/0x248
 show_stack+0x20/0x2c
 dump_stack+0xd0/0x140
 print_circular_bug+0x368/0x380
 check_noncircular+0x248/0x250
 validate_chain+0xd10/0x2bcc
 __lock_acquire+0x7f4/0xb8c
 lock_acquire+0x31c/0x360
 get_online_mems+0x54/0x150
 show_slab_objects+0x94/0x3a8
 total_objects_show+0x28/0x34
 slab_attr_show+0x38/0x54
 sysfs_kf_seq_show+0x198/0x2d4
 kernfs_seq_show+0xa4/0xcc
 seq_read+0x30c/0x8a8
 kernfs_fop_read+0xa8/0x314
 __vfs_read+0x88/0x20c
 vfs_read+0xd8/0x10c
 ksys_read+0xb0/0x120
 __arm64_sys_read+0x54/0x88
 el0_svc_handler+0x170/0x240
 el0_svc+0x8/0xc

[1] http://lkml.iu.edu/hypermail/linux/kernel/1101.0/02850.html

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/slub.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 42c1b3af3c98..922cdcf5758a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4838,7 +4838,15 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
 		}
 	}
 
-	get_online_mems();
+/*
+ * It is not possible to take "mem_hotplug_lock" here, as it has already held
+ * "kernfs_mutex" which could race with the lock order:
+ *
+ * mem_hotplug_lock->slab_mutex->kernfs_mutex
+ *
+ * In the worest case, it might be mis-calculated while doing NUMA node
+ * hotplug, but it shall be corrected by later reads of the same files.
+ */
 #ifdef CONFIG_SLUB_DEBUG
 	if (flags & SO_ALL) {
 		struct kmem_cache_node *n;
@@ -4879,7 +4887,6 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
 			x += sprintf(buf + x, " N%d=%lu",
 					node, nodes[node]);
 #endif
-	put_online_mems();
 	kfree(nodes);
 	return x + sprintf(buf + x, "\n");
 }
-- 
1.8.3.1

