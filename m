Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39D3C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16432175B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962144;
	bh=fJ7o7W9TJ0EFwydGfjOyVAnw8jANR4RYU8jw4Rgb44Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s0Jaeh5c1wrQsoIwgPx/njvdQ9u9MKO6cq1h6u/Fli0NIdNC6UY58iyTcxTLOWHKt
	 9y5wM4xU/T4eQWwqO7Bc+hCts57I4PNuGkNlfBj4sUAZJuSBycw6/bpemwWlWAt9tz
	 NKdaoEqpI7pfCQUdqYxaTH8tq7f5j/yTw6oPC4Kk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfDVTmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:42:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728734AbfDVTmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:42:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69B4D2177B;
        Mon, 22 Apr 2019 19:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962138;
        bh=fJ7o7W9TJ0EFwydGfjOyVAnw8jANR4RYU8jw4Rgb44Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tRghVrXC/RkCuBWxQvvPt+0nbnIrVLlBsq0zROLy90r+d2Qp8Q3our/1oJ83OgDw0
         yUXtUv6+we3epEaPCa5aywdrq57RRfOiaO5nadH6ksdGLqP8ZwO2gigHyzqX5eI/D/
         gg/rF1IdMvv8eD/mA9HzlMd4rkHPsZfNR8qrYQIo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 13/98] xsk: fix umem memory leak on cleanup
Date:   Mon, 22 Apr 2019 15:40:40 -0400
Message-Id: <20190422194205.10404-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn.topel@intel.com>

[ Upstream commit 044175a06706d516aa42874bb44dbbfc3c4d20eb ]

When the umem is cleaned up, the task that created it might already be
gone. If the task was gone, the xdp_umem_release function did not free
the pages member of struct xdp_umem.

It turned out that the task lookup was not needed at all; The code was
a left-over when we moved from task accounting to user accounting [1].

This patch fixes the memory leak by removing the task lookup logic
completely.

[1] https://lore.kernel.org/netdev/20180131135356.19134-3-bjorn.topel@gmail.com/

Link: https://lore.kernel.org/netdev/c1cb2ca8-6a14-3980-8672-f3de0bb38dfd@suse.cz/
Fixes: c0c77d8fb787 ("xsk: add user memory registration support sockopt")
Reported-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 include/net/xdp_sock.h |  1 -
 net/xdp/xdp_umem.c     | 19 +------------------
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 13acb9803a6d..05d39e579953 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -36,7 +36,6 @@ struct xdp_umem {
 	u32 headroom;
 	u32 chunk_size_nohr;
 	struct user_struct *user;
-	struct pid *pid;
 	unsigned long address;
 	refcount_t users;
 	struct work_struct work;
diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 37e1fe180769..9c767c68ed3a 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -189,9 +189,6 @@ static void xdp_umem_unaccount_pages(struct xdp_umem *umem)
 
 static void xdp_umem_release(struct xdp_umem *umem)
 {
-	struct task_struct *task;
-	struct mm_struct *mm;
-
 	xdp_umem_clear_dev(umem);
 
 	if (umem->fq) {
@@ -208,21 +205,10 @@ static void xdp_umem_release(struct xdp_umem *umem)
 
 	xdp_umem_unpin_pages(umem);
 
-	task = get_pid_task(umem->pid, PIDTYPE_PID);
-	put_pid(umem->pid);
-	if (!task)
-		goto out;
-	mm = get_task_mm(task);
-	put_task_struct(task);
-	if (!mm)
-		goto out;
-
-	mmput(mm);
 	kfree(umem->pages);
 	umem->pages = NULL;
 
 	xdp_umem_unaccount_pages(umem);
-out:
 	kfree(umem);
 }
 
@@ -351,7 +337,6 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	if (size_chk < 0)
 		return -EINVAL;
 
-	umem->pid = get_task_pid(current, PIDTYPE_PID);
 	umem->address = (unsigned long)addr;
 	umem->chunk_mask = ~((u64)chunk_size - 1);
 	umem->size = size;
@@ -367,7 +352,7 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 
 	err = xdp_umem_account_pages(umem);
 	if (err)
-		goto out;
+		return err;
 
 	err = xdp_umem_pin_pages(umem);
 	if (err)
@@ -386,8 +371,6 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 
 out_account:
 	xdp_umem_unaccount_pages(umem);
-out:
-	put_pid(umem->pid);
 	return err;
 }
 
-- 
2.19.1

