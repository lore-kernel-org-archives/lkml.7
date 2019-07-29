Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022C3C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA75B205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564430877;
	bh=fjuEbsoJsz/8BtvzJHjIfCmO5QHPJ5no2YLmeQCMmik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=espfyq6D1neHw9KIHQAy/9JzPbX8FJk4WBbK8J0QiM5usrTIl+P02ncC5CQZ7HdDr
	 B+uBLiMKqdqP3MzUyj4Nsz1xmJ6lbvNxd+n/614F6EaSNRmG9PNYVbbtyicPyrrc+P
	 E7XRuvwlqxFHuLijVz8SKZ/o1lhwTd3pfEFMlGrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfG2UH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:07:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387731AbfG2TiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:38:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3928021773;
        Mon, 29 Jul 2019 19:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429103;
        bh=fjuEbsoJsz/8BtvzJHjIfCmO5QHPJ5no2YLmeQCMmik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=osdCOARnyh2OVsDASTzYyVu1X/Uu9D/eCGwhv8PTNDEPxCoSGg8Y+4thi39BlqiBb
         /q02j3gzBoahk5+pU+AkVR0PcZz/jzBekW8yil/SM162ooF9AEt0sQmbuaXQwkjUoE
         DXGuO10M9b1i2tidUGem3FzjN/zV1swAyi+H/6r4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+8b3c354d33c4ac78bfad@syzkaller.appspotmail.com,
        Hridya Valsaraju <hridya@google.com>,
        Todd Kjos <tkjos@google.com>
Subject: [PATCH 4.14 286/293] binder: prevent transactions to context manager from its own process.
Date:   Mon, 29 Jul 2019 21:22:57 +0200
Message-Id: <20190729190846.170358376@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hridya Valsaraju <hridya@google.com>

commit 49ed96943a8e0c62cc5a9b0a6cfc88be87d1fcec upstream.

Currently, a transaction to context manager from its own process
is prevented by checking if its binder_proc struct is the same as
that of the sender. However, this would not catch cases where the
process opens the binder device again and uses the new fd to send
a transaction to the context manager.

Reported-by: syzbot+8b3c354d33c4ac78bfad@syzkaller.appspotmail.com
Signed-off-by: Hridya Valsaraju <hridya@google.com>
Acked-by: Todd Kjos <tkjos@google.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20190715191804.112933-1-hridya@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2785,7 +2785,7 @@ static void binder_transaction(struct bi
 			else
 				return_error = BR_DEAD_REPLY;
 			mutex_unlock(&context->context_mgr_node_lock);
-			if (target_node && target_proc == proc) {
+			if (target_node && target_proc->pid == proc->pid) {
 				binder_user_error("%d:%d got transaction to context manager from process owning it\n",
 						  proc->pid, thread->pid);
 				return_error = BR_FAILED_REPLY;


