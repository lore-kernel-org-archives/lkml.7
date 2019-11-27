Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671D1C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D74C21556
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889785;
	bh=v2Lr6UhqiPVvG1GHncj3T4v9MmrlPcSOl5zQ1vp0id0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1UF728rmKCRtXGNIxhXXNrXZ6qcB6bgANEsFzkzXztgNRfUbF2QtQPKfXsvOvcehq
	 yTWXCsW1Ht7i0rMj2gkuqRlxkMEKr08YL1pmgElONQB2j3nfJWznVfKnoz6YQO2J4y
	 tXDaiZ+FGx5DZ2owQcrOEBFugJzc138vsIPI7Xds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbfK0VXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:23:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:58742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727468AbfK0VFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:05:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BAAB215F1;
        Wed, 27 Nov 2019 21:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888707;
        bh=v2Lr6UhqiPVvG1GHncj3T4v9MmrlPcSOl5zQ1vp0id0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dDRHbfyXr9z26QK/JcM5flg7ze0J6WqwTqnxdw4jxHSAsaOjH1ekHHb66wPPiojGD
         H19t+ytahxYX52b1A5n9eaqhAZWIuD4wW17IatWiJOXCvnTz+HLZ1JvygujE0PP/df
         2+T6czjFYA+KllBaIeAkfnv6y2+0vFjrA1BFaE0E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Mike Galbraith <efault@gmx.de>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 195/306] mm: handle no memcg case in memcg_kmem_charge() properly
Date:   Wed, 27 Nov 2019 21:30:45 +0100
Message-Id: <20191127203129.442793037@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Gushchin <guro@fb.com>

[ Upstream commit e68599a3c3ad0f3171a7cb4e48aa6f9a69381902 ]

Mike Galbraith reported a regression caused by the commit 9b6f7e163cd0
("mm: rework memcg kernel stack accounting") on a system with
"cgroup_disable=memory" boot option: the system panics with the following
stack trace:

  BUG: unable to handle kernel NULL pointer dereference at 00000000000000f8
  PGD 0 P4D 0
  Oops: 0002 [#1] PREEMPT SMP PTI
  CPU: 0 PID: 1 Comm: systemd Not tainted 4.19.0-preempt+ #410
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20180531_142017-buildhw-08.phx2.fed4
  RIP: 0010:page_counter_try_charge+0x22/0xc0
  Code: 41 5d c3 c3 0f 1f 40 00 0f 1f 44 00 00 48 85 ff 0f 84 a7 00 00 00 41 56 48 89 f8 49 89 fe 49
  Call Trace:
   try_charge+0xcb/0x780
   memcg_kmem_charge_memcg+0x28/0x80
   memcg_kmem_charge+0x8b/0x1d0
   copy_process.part.41+0x1ca/0x2070
   _do_fork+0xd7/0x3d0
   do_syscall_64+0x5a/0x180
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

The problem occurs because get_mem_cgroup_from_current() returns the NULL
pointer if memory controller is disabled.  Let's check if this is a case
at the beginning of memcg_kmem_charge() and just return 0 if
mem_cgroup_disabled() returns true.  This is how we handle this case in
many other places in the memory controller code.

Link: http://lkml.kernel.org/r/20181029215123.17830-1-guro@fb.com
Fixes: 9b6f7e163cd0 ("mm: rework memcg kernel stack accounting")
Signed-off-by: Roman Gushchin <guro@fb.com>
Reported-by: Mike Galbraith <efault@gmx.de>
Acked-by: Rik van Riel <riel@surriel.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5af38d8a9afd3..3a3d109dce215 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2678,7 +2678,7 @@ int memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
 	struct mem_cgroup *memcg;
 	int ret = 0;
 
-	if (memcg_kmem_bypass())
+	if (mem_cgroup_disabled() || memcg_kmem_bypass())
 		return 0;
 
 	memcg = get_mem_cgroup_from_current();
-- 
2.20.1



