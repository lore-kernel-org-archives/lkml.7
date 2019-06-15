Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EF3C31E44
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 01:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7219A21841
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 01:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFOBLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 21:11:11 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60634 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfFOBLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 21:11:08 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x5F19xU0035307;
        Sat, 15 Jun 2019 10:09:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Sat, 15 Jun 2019 10:09:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x5F19xuD035300
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 15 Jun 2019 10:09:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: general protection fault in oom_unkillable_task
To:     syzbot <syzbot+d0fc9d3c166bc5e4a94b@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, mhocko@kernel.org
References: <0000000000004143a5058b526503@google.com>
Cc:     ebiederm@xmission.com, guro@fb.com, hannes@cmpxchg.org,
        jglisse@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, yuzhoujian@didichuxing.com
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <cc3d5247-855d-a124-041f-64c4659d95c3@i-love.sakura.ne.jp>
Date:   Sat, 15 Jun 2019 10:10:00 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0000000000004143a5058b526503@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure this patch is correct/safe. Can you try memcg OOM torture
test (including memcg group OOM killing enabled) with this patch applied?
----------------------------------------
From a436624c73d106fad9b880a6cef5abd83b2329a2 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sat, 15 Jun 2019 10:06:00 +0900
Subject: [PATCH] memcg: Protect whole mem_cgroup_scan_tasks() using RCU.

syzbot is reporting a GFP at for_each_thread() from a memcg OOM event [1].
While select_bad_process() in a global OOM event traverses whole threads
under RCU, select_bad_process() in a memcg OOM event is traversing threads
without RCU, and I guess that this can result in traversing bogus pointer.

Suppose a process containing three threads T1, T2, T3 is in a memcg.
T3 invokes memcg OOM killer, and starts traversing from T1. T3 elevates
refcount on T1, but T3 is preempted before oom_unkillable_task(T1) check.
Then, T1 reaches do_exit() and T1 does list_del_rcu(&T1->thread_node).

  do_exit() {
    cgroup_exit() {
      css_set_move_task(tsk, cset, NULL, false);
    }
    exit_notify() {
      release_task() {
        __exit_signal() {
          __unhash_process() {
            list_del_rcu(&p->thread_node);
          }
        }
      }
    }
  }

Then, T2 also reaches do_exit() and does list_del_rcu(&T2->thread_node).
Since the refcount of T1 was kept elevated by T3, T1 cannot be freed. But
since the refcount of T2 was not elevated by T3, T2 can complete do_exit()
and T2 is freed as soon as RCU grace period elapsed. At this point, since
T1 was removed from thread group before T2 was removed, T1's next thread
remains already freed T2. If memory used for T2 was reallocated before T3
resumes execution, accessing T1's next thread will not be reported as
use-after-free but memory referenced as T1's next thread contains bogus
values.

Thus, I think that the rule is: when traversing threads inside a section
between css_task_iter_start() and css_task_iter_end(), each thread must
not involve e.g. for_each_thread() unless whole section is protected by
RCU.

[1] https://syzkaller.appspot.com/bug?id=4559bc383e7c73a35bc6c8336557635459fb7a62

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+d0fc9d3c166bc5e4a94b@syzkaller.appspotmail.com>
---
 mm/memcontrol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ba9138a..8e01f01 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1159,6 +1159,7 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 
 	BUG_ON(memcg == root_mem_cgroup);
 
+	rcu_read_lock();
 	for_each_mem_cgroup_tree(iter, memcg) {
 		struct css_task_iter it;
 		struct task_struct *task;
@@ -1172,6 +1173,7 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 			break;
 		}
 	}
+	rcu_read_unlock();
 	return ret;
 }
 
-- 
1.8.3.1

