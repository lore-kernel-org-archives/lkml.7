Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8480AC282E3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A31D21907
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116606;
	bh=HUqPPC7F+tkTdj0KBS2Fjv+IWBqD5NqnPwZL4XmMoIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eGE3OFkLeTql3kxEpiyj96NhrlJ9AX/KSCRRJlXtycz5lRMs6NskS1TLoLir4T9+L
	 EWTnkbAIh1GXLXjZU6Tctl7WQ5Z+gqxiiJl8GnbShkXQVXOs6uwFE0b7XKeqPQ/ipE
	 8AUC6WEMvFpT4qUDg7HR+CiseBj/JB2Y55UITWig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbfDXOgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:36:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731615AbfDXOgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:36:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD0E421904;
        Wed, 24 Apr 2019 14:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116599;
        bh=HUqPPC7F+tkTdj0KBS2Fjv+IWBqD5NqnPwZL4XmMoIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GfZUd4LfMNt4p93fci54UBP5wygjCRWJTcCleJrkLUSIzug4iA2t2pXlTf0Wd593J
         WEEcZxOzYKjxKmCt1+WHQmDSQt9o5OjInp7UVHQeaiUIBzcWQeH3dfKWXfxIObEk5j
         aowXvGwEaDt/i5V76DICzfIiBontGs5eI9IVYgDU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Subject: [PATCH AUTOSEL 5.0 63/66] aio: fold lookup_kiocb() into its sole caller
Date:   Wed, 24 Apr 2019 10:33:37 -0400
Message-Id: <20190424143341.27665-63-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143341.27665-1-sashal@kernel.org>
References: <20190424143341.27665-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 833f4154ed560232120bc475935ee1d6a20e159f ]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/aio.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 363d7d7c8bff..ae60c29b8a98 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2002,24 +2002,6 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
 }
 #endif
 
-/* lookup_kiocb
- *	Finds a given iocb for cancellation.
- */
-static struct aio_kiocb *
-lookup_kiocb(struct kioctx *ctx, struct iocb __user *iocb)
-{
-	struct aio_kiocb *kiocb;
-
-	assert_spin_locked(&ctx->ctx_lock);
-
-	/* TODO: use a hash or array, this sucks. */
-	list_for_each_entry(kiocb, &ctx->active_reqs, ki_list) {
-		if (kiocb->ki_user_iocb == iocb)
-			return kiocb;
-	}
-	return NULL;
-}
-
 /* sys_io_cancel:
  *	Attempts to cancel an iocb previously passed to io_submit.  If
  *	the operation is successfully cancelled, the resulting event is
@@ -2048,10 +2030,13 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 		return -EINVAL;
 
 	spin_lock_irq(&ctx->ctx_lock);
-	kiocb = lookup_kiocb(ctx, iocb);
-	if (kiocb) {
-		ret = kiocb->ki_cancel(&kiocb->rw);
-		list_del_init(&kiocb->ki_list);
+	/* TODO: use a hash or array, this sucks. */
+	list_for_each_entry(kiocb, &ctx->active_reqs, ki_list) {
+		if (kiocb->ki_user_iocb == iocb) {
+			ret = kiocb->ki_cancel(&kiocb->rw);
+			list_del_init(&kiocb->ki_list);
+			break;
+		}
 	}
 	spin_unlock_irq(&ctx->ctx_lock);
 
-- 
2.19.1

