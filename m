Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A3EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C162070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582424;
	bh=eX/c/Pw8DCLmryCtSBVvXuEnTrul8Ci4Ldqt5V49INk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1ZEcn86BOdYFd+lskfTQiWb4qPOI1nx4r/ynL4ORJk3y7+nZtOFCHqiQ6IE5iNJGX
	 LBRrfqxf5P1Oliayd4NudvyGeVP4Vm0QoeqIFD6pO0R7cKXo9atWRCoIsLACMo42KO
	 Ci/PgKa3AMjiuozQ4JSZiLlvcBcnGG2CTodmv7i8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732863AbfCZGkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732360AbfCZGkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:40:22 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02109213A2;
        Tue, 26 Mar 2019 06:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582421;
        bh=eX/c/Pw8DCLmryCtSBVvXuEnTrul8Ci4Ldqt5V49INk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MuVIjUcLAnGK+Z3374KpYFYsNRjLDFIraTX0H3fd/XaCfDnwCPrljzlCxSwkcOSrD
         bYQcq7UwlHUAH7FfI7IMqMeoUMmgEzIUJMaWt5SzofWvp+IImspANAvD6z7QrTJuW8
         Q3arcX4BlHvLidxmNalAe73N6RXQUHwvTLMbilnA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        syzbot+b19c2dc2c990ea657a71@syzkaller.appspotmail.com,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.0 50/52] mm, mempolicy: fix uninit memory access
Date:   Tue, 26 Mar 2019 15:30:37 +0900
Message-Id: <20190326042703.653914631@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vlastimil Babka <vbabka@suse.cz>

commit 2e25644e8da4ed3a27e7b8315aaae74660be72dc upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/mempolicy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -350,7 +350,7 @@ static void mpol_rebind_policy(struct me
 {
 	if (!pol)
 		return;
-	if (!mpol_store_user_nodemask(pol) &&
+	if (!mpol_store_user_nodemask(pol) && !(pol->flags & MPOL_F_LOCAL) &&
 	    nodes_equal(pol->w.cpuset_mems_allowed, *newmask))
 		return;
 


