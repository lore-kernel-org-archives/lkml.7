Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA430C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE36D2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709792;
	bh=D5j9uqe7RjbpQnE4BIvdicEPeFYyYV+xlNv76Q1lI2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eWka4UWOXrnOIEUDDP2rx8LVEq/t/xd4++wte0lpby3TgbjUuyb3MCZnplciIfyEP
	 M4YBADLtZV7SvnuBRqzUjLVte2Y9eeRZ+UR5+JYjEJclcvj0h6ynQ1CrmZcVa/H7bP
	 +Uu95xQXtEumb7ADLqz1c0shOS5n38LgZd1DX4Y4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbfC0SDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:03:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731851AbfC0SDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:03:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 552D121734;
        Wed, 27 Mar 2019 18:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709786;
        bh=D5j9uqe7RjbpQnE4BIvdicEPeFYyYV+xlNv76Q1lI2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DsJnzbm1snkO95BkN0CXj+Xg5gm+I7k5d0PNxXbK+obcjeqwPM5L1cFbf2bxOsY9w
         Fe1+A+SCB745Ax+lYD0RDqpVAUhNV6AWm6aBMXvTLE8Wxp3K5gdYw1DE9ilceJVEeC
         xr1vhop358u32FwfRgH+qd2Kq/ub1hdrIDk0yZBo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 5.0 037/262] mm, mempolicy: fix uninit memory access
Date:   Wed, 27 Mar 2019 13:58:12 -0400
Message-Id: <20190327180158.10245-37-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vlastimil Babka <vbabka@suse.cz>

[ Upstream commit 2e25644e8da4ed3a27e7b8315aaae74660be72dc ]

Syzbot with KMSAN reports (excerpt):

==================================================================
BUG: KMSAN: uninit-value in mpol_rebind_policy mm/mempolicy.c:353 [inline]
BUG: KMSAN: uninit-value in mpol_rebind_mm+0x249/0x370 mm/mempolicy.c:384
CPU: 1 PID: 17420 Comm: syz-executor4 Not tainted 4.20.0-rc7+ #15
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x173/0x1d0 lib/dump_stack.c:113
  kmsan_report+0x12e/0x2a0 mm/kmsan/kmsan.c:613
  __msan_warning+0x82/0xf0 mm/kmsan/kmsan_instr.c:295
  mpol_rebind_policy mm/mempolicy.c:353 [inline]
  mpol_rebind_mm+0x249/0x370 mm/mempolicy.c:384
  update_tasks_nodemask+0x608/0xca0 kernel/cgroup/cpuset.c:1120
  update_nodemasks_hier kernel/cgroup/cpuset.c:1185 [inline]
  update_nodemask kernel/cgroup/cpuset.c:1253 [inline]
  cpuset_write_resmask+0x2a98/0x34b0 kernel/cgroup/cpuset.c:1728

...

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:204 [inline]
  kmsan_internal_poison_shadow+0x92/0x150 mm/kmsan/kmsan.c:158
  kmsan_kmalloc+0xa6/0x130 mm/kmsan/kmsan_hooks.c:176
  kmem_cache_alloc+0x572/0xb90 mm/slub.c:2777
  mpol_new mm/mempolicy.c:276 [inline]
  do_mbind mm/mempolicy.c:1180 [inline]
  kernel_mbind+0x8a7/0x31a0 mm/mempolicy.c:1347
  __do_sys_mbind mm/mempolicy.c:1354 [inline]

As it's difficult to report where exactly the uninit value resides in
the mempolicy object, we have to guess a bit.  mm/mempolicy.c:353
contains this part of mpol_rebind_policy():

        if (!mpol_store_user_nodemask(pol) &&
            nodes_equal(pol->w.cpuset_mems_allowed, *newmask))

"mpol_store_user_nodemask(pol)" is testing pol->flags, which I couldn't
ever see being uninitialized after leaving mpol_new().  So I'll guess
it's actually about accessing pol->w.cpuset_mems_allowed on line 354,
but still part of statement starting on line 353.

For w.cpuset_mems_allowed to be not initialized, and the nodes_equal()
reachable for a mempolicy where mpol_set_nodemask() is called in
do_mbind(), it seems the only possibility is a MPOL_PREFERRED policy
with empty set of nodes, i.e.  MPOL_LOCAL equivalent, with MPOL_F_LOCAL
flag.  Let's exclude such policies from the nodes_equal() check.  Note
the uninit access should be benign anyway, as rebinding this kind of
policy is always a no-op.  Therefore no actual need for stable
inclusion.

Link: http://lkml.kernel.org/r/a71997c3-e8ae-a787-d5ce-3db05768b27c@suse.cz
Link: http://lkml.kernel.org/r/73da3e9c-cc84-509e-17d9-0c434bb9967d@suse.cz
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reported-by: syzbot+b19c2dc2c990ea657a71@syzkaller.appspotmail.com
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>
Cc: zhong jiang <zhongjiang@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index ee2bce59d2bf..846f80e212ac 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -350,7 +350,7 @@ static void mpol_rebind_policy(struct mempolicy *pol, const nodemask_t *newmask)
 {
 	if (!pol)
 		return;
-	if (!mpol_store_user_nodemask(pol) &&
+	if (!mpol_store_user_nodemask(pol) && !(pol->flags & MPOL_F_LOCAL) &&
 	    nodes_equal(pol->w.cpuset_mems_allowed, *newmask))
 		return;
 
-- 
2.19.1

