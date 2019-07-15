Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9440DC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6303620665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mxa6wWDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbfGOTSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:18:43 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:41611 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbfGOTSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:18:42 -0400
Received: by mail-pg1-f201.google.com with SMTP id b18so11047521pgg.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UrmHiwd7l9RTQPWRIFMpdG4iVBmNxjeLn/aT+hZa6RI=;
        b=Mxa6wWDjygyjXJJ3zd1w415IKp2A7JgcpMt/VNTgr5UQNXhkE9XOpO9loxlWAT7L53
         9nsh50Xu+sd34VgfjB1/O10CHb8yTgOFUlPHKS3oNNKcD5kkmZYk5ZeompxkMj/BAr9p
         HlQNp8QzZ2AY6XmGwhcSNkpZxLNERVgH9CkTBxol9C0CEpUspfmJiAAiot2UJXTAZm9O
         IUrRXKtK9DdqnSWzBnIRktqIk1RO69PXYq9fqoA6JldUaV/uoA3YIUjn4ygJEKrd/AJW
         clZfNW3nadwEb/uQF1braPjBGw2llxQlK/ZLZH+Xdk/WAekt4Au5WL6Spo3yaHok5C55
         144A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UrmHiwd7l9RTQPWRIFMpdG4iVBmNxjeLn/aT+hZa6RI=;
        b=Ww6UXfXAS+5yjthcPYhZlNlXAL3ziL9EH2jrKQ5AEHCLwwLL8CvVhSBXFu58/Ik+az
         DRvzUL0gtDdRqp/S7ePljNjL10Y7w/7ZAbP4bIJk7xNHOOS/TDwu4PkCcTEVpZf+bpDn
         Wrf8AIoEVD/zq+emO5OlkjKbMQOHqSHBYSX2EXZ87qAsy10TjeciG2DtfEZrc7p7I7la
         1Q4050JCy4ENyTa5omLuKZn/nVx9R0qd1mwOqVS+7x23ZDiSFnyB/u9t4KSkGe0XJ6gg
         MxLV9zUZbJUjGz0QY0hctIwnpuVBEcjiBW9qoZkdjOZDT4zVONE+EoZOvOhWN4534fep
         pr9w==
X-Gm-Message-State: APjAAAVTx17EmyF3gF4DsNmiXgpr5kRQhzsb9vR0HPK4YPgUgTETsPhg
        Ks05EQozqXFe73BDtLaEqIDzyPcgWxM=
X-Google-Smtp-Source: APXvYqwsN5hT5MT5xZGb058JDliA81AgGEm89BFgX3G+jX5S4A/QmOMomqtBSuHe87yIDNlPcG/af7g78H4=
X-Received: by 2002:a63:f346:: with SMTP id t6mr29578283pgj.203.1563218321271;
 Mon, 15 Jul 2019 12:18:41 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:18:04 -0700
Message-Id: <20190715191804.112933-1-hridya@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH] binder: prevent transactions to context manager from its own process.
From:   Hridya Valsaraju <hridya@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Hridya Valsaraju <hridya@google.com>,
        syzbot+8b3c354d33c4ac78bfad@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, a transaction to context manager from its own process
is prevented by checking if its binder_proc struct is the same as
that of the sender. However, this would not catch cases where the
process opens the binder device again and uses the new fd to send
a transaction to the context manager.

Reported-by: syzbot+8b3c354d33c4ac78bfad@syzkaller.appspotmail.com
Signed-off-by: Hridya Valsaraju <hridya@google.com>
---
 drivers/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index e4d25ebec5be..89b9cedae088 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3138,7 +3138,7 @@ static void binder_transaction(struct binder_proc *proc,
 			else
 				return_error = BR_DEAD_REPLY;
 			mutex_unlock(&context->context_mgr_node_lock);
-			if (target_node && target_proc == proc) {
+			if (target_node && target_proc->pid == proc->pid) {
 				binder_user_error("%d:%d got transaction to context manager from process owning it\n",
 						  proc->pid, thread->pid);
 				return_error = BR_FAILED_REPLY;
-- 
2.22.0.510.g264f2c817a-goog

