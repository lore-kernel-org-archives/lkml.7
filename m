Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF36C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3926218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258772;
	bh=FKs0pEjg3VzYKZjkgV61SmiMldEkcRTqmFIbVrUs7eY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TqGI0quOr8SvG6d8utVC3LwxcdvuS9fARNGN94DgUpQPSKjmjvaUeOy1NVf/BK9RQ
	 cmEPrbbFsYItyDeYGm18l4hND2ZvXRAHjkHnKwM4zawPfubHwYvBGrCo2jFElA15ur
	 smQA4beUouU4VtPJLskodPS1W4RV2I6qZGN5LAw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388267AbfCVMqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:46:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387992AbfCVL7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:59:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C19AB204FD;
        Fri, 22 Mar 2019 11:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255982;
        bh=FKs0pEjg3VzYKZjkgV61SmiMldEkcRTqmFIbVrUs7eY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CQjohJbOFSdqun4WDI9SdoUE0jteQARRnb8elrdSUmX/ubWvn6ZNPTHRVlfMzgtO9
         rWL+2pATvdBiyjI0km3NguuCvddjiaKWfT9UWeux36YQ0IFF+bg5F1d614TPyXw8zU
         8dZ7eXVPZEXvJ+I77aP8jwb9mCqXv8WvL1U5je1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 073/280] bpf: fix lockdep false positive in stackmap
Date:   Fri, 22 Mar 2019 12:13:46 +0100
Message-Id: <20190322111310.429201450@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 6a32933cae4f..7cb7a7f98a37 100644
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



