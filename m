Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20F4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC4D2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504242;
	bh=P4dMpDvhBPN5Wx05GPrpTJkk2VG1k+xFDs0XYWKE8pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=188e9e4wxuF260nrANskBMN96CrtF9sgvqxda9d0d3hGZCq8MMnbrmG928iQcuePJ
	 E4GkvIWbj92I8lFnwG07sqYtyjvscGTziUcYlQoN6TlIagjOrd+cChVWR7WHxSc18Z
	 YEvSX3yF1+1Shjnsm8DURnyN9NEiBgRfmyPam6kc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfCMTKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbfCMTKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:10:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 874712184D;
        Wed, 13 Mar 2019 19:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504237;
        bh=P4dMpDvhBPN5Wx05GPrpTJkk2VG1k+xFDs0XYWKE8pc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BqHQM1VVXeoFAgIFDgqirLcVwzk/22rrrrWuIscP2c7RGPlleNzW65Ya0nz+EYWfd
         v62MHMojF9crKpWotu6krwOBhfkF94D2gotze7Dy2ggRwNrXqO71MIcPq0qo4tshGz
         FMCJ+SI5qKJqR6jN/VpP87oHV7c1vQYMdweOBAt8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 08/60] bpf: fix lockdep false positive in stackmap
Date:   Wed, 13 Mar 2019 15:09:29 -0400
Message-Id: <20190313191021.158171-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

[ Upstream commit 3defaf2f15b2bfd86c6664181ac009e91985f8ac ]

Lockdep warns about false positive:
[   11.211460] ------------[ cut here ]------------
[   11.211936] DEBUG_LOCKS_WARN_ON(depth <= 0)
[   11.211985] WARNING: CPU: 0 PID: 141 at ../kernel/locking/lockdep.c:3592 lock_release+0x1ad/0x280
[   11.213134] Modules linked in:
[   11.214954] RIP: 0010:lock_release+0x1ad/0x280
[   11.223508] Call Trace:
[   11.223705]  <IRQ>
[   11.223874]  ? __local_bh_enable+0x7a/0x80
[   11.224199]  up_read+0x1c/0xa0
[   11.224446]  do_up_read+0x12/0x20
[   11.224713]  irq_work_run_list+0x43/0x70
[   11.225030]  irq_work_run+0x26/0x50
[   11.225310]  smp_irq_work_interrupt+0x57/0x1f0
[   11.225662]  irq_work_interrupt+0xf/0x20

since rw_semaphore is released in a different task vs task that locked the sema.
It is expected behavior.
Fix the warning with up_read_non_owner() and rwsem_release() annotation.

Fixes: bae77c5eb5b2 ("bpf: enable stackmap with build_id in nmi context")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/stackmap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index d43b14535827..950ab2f28922 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -44,7 +44,7 @@ static void do_up_read(struct irq_work *entry)
 	struct stack_map_irq_work *work;
 
 	work = container_of(entry, struct stack_map_irq_work, irq_work);
-	up_read(work->sem);
+	up_read_non_owner(work->sem);
 	work->sem = NULL;
 }
 
@@ -338,6 +338,12 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 	} else {
 		work->sem = &current->mm->mmap_sem;
 		irq_work_queue(&work->irq_work);
+		/*
+		 * The irq_work will release the mmap_sem with
+		 * up_read_non_owner(). The rwsem_release() is called
+		 * here to release the lock from lockdep's perspective.
+		 */
+		rwsem_release(&current->mm->mmap_sem.dep_map, 1, _RET_IP_);
 	}
 }
 
-- 
2.19.1

