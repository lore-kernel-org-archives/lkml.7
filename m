Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2ABC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 20:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EFE20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 20:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="tV0rKoo7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388911AbfFLU3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 16:29:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37154 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbfFLU3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 16:29:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id bh12so7103779plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 13:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ztsODx8FS4iqleQB6S5Sbaw6s2vQsWeNtbIf3Gi3ev8=;
        b=tV0rKoo7aPIwJkeuB47jNZrom/4GFwVWKi8SGyHTggc/tcIopfSdYikE62up/2HeTh
         dQcabzL9jPuFZsaUE4LdfoIA4QcGn8xhS+cI0jpf5X+pyP5jcDHjWlmuR8QPaH5+kTa5
         +0ZMk/+0aEDq2Ypvj0edwR9ny5tFDUT0qbCdFJVvsfmmenMvuturIP8Y5nRKTF+mmrRT
         sm+tuLhfqvE7uOdl1JDdB5JnaF6B+k6Dh7JqKloBbiR1bMyjaYQgQV/kMMTnUbnHowJS
         Y++xPx3ckxFKqtKywpfU5k46nMdg7tDhlA6O2bF9f3URbcKvpA1J9LqwqDKl8HnxODlv
         e0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ztsODx8FS4iqleQB6S5Sbaw6s2vQsWeNtbIf3Gi3ev8=;
        b=SIcT0orAx8B6Nui3u5Z2ZvMSmK1usg+82ZOvY8Lx0h+Ps7iPf+va7Mck9XKhN0VpQ1
         MYp2suE2H8vkilFvTWayTL4+sETVY+g7k50Zibe0phdplB8MfbFKokAFCDlIBujwCM17
         0G4po7OhPt2JLVkDynhlpVCZoMJbSuV6dji10gmhPhoxxbNmq4W40d55vhm063F/YXeG
         EvY6TJgm5r9WvrQEbylhviJHZg8YClkyp43ecVj7eta2r5+kkhhbt6Q4cAQTiDaRracs
         DERfCzoE1igB2oR2cKyjHe7+Kk2r4wuuBB4MTgmV579qlsZBz0XfXuz0zW84HVqjZXj8
         c/yA==
X-Gm-Message-State: APjAAAXMgUeKnxxtNrtW3RSkfmPHMvtjvj9vVZQrT9GoW00v8k4KdHa3
        k/HqabfaO7QDIjnPDvoBdryFGQ==
X-Google-Smtp-Source: APXvYqzFoHCFTQ/mild4RR3i5+q+a6dheIBjD2C9qCG5ZWSzZfpIq355jaWaTpdrY6e1E+n4lFpbIA==
X-Received: by 2002:a17:902:d88e:: with SMTP id b14mr31956181plz.153.1560371380872;
        Wed, 12 Jun 2019 13:29:40 -0700 (PDT)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id 3sm392555pfp.114.2019.06.12.13.29.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 13:29:40 -0700 (PDT)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH] binder: fix possible UAF when freeing buffer
Date:   Wed, 12 Jun 2019 13:29:27 -0700
Message-Id: <20190612202927.54518-1-tkjos@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race between the binder driver cleaning
up a completed transaction via binder_free_transaction()
and a user calling binder_ioctl(BC_FREE_BUFFER) to
release a buffer. It doesn't matter which is first but
they need to be protected against running concurrently
which can result in a UAF.

Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/android/binder.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 748ac489ef7eb..bc26b5511f0a9 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1941,8 +1941,18 @@ static void binder_free_txn_fixups(struct binder_transaction *t)
 
 static void binder_free_transaction(struct binder_transaction *t)
 {
-	if (t->buffer)
-		t->buffer->transaction = NULL;
+	struct binder_proc *target_proc = t->to_proc;
+
+	if (target_proc) {
+		binder_inner_proc_lock(target_proc);
+		if (t->buffer)
+			t->buffer->transaction = NULL;
+		binder_inner_proc_unlock(target_proc);
+	}
+	/*
+	 * If the transaction has no target_proc, then
+	 * t->buffer->transaction has already been cleared.
+	 */
 	binder_free_txn_fixups(t);
 	kfree(t);
 	binder_stats_deleted(BINDER_STAT_TRANSACTION);
@@ -3551,10 +3561,12 @@ static void binder_transaction(struct binder_proc *proc,
 static void
 binder_free_buf(struct binder_proc *proc, struct binder_buffer *buffer)
 {
+	binder_inner_proc_lock(proc);
 	if (buffer->transaction) {
 		buffer->transaction->buffer = NULL;
 		buffer->transaction = NULL;
 	}
+	binder_inner_proc_unlock(proc);
 	if (buffer->async_transaction && buffer->target_node) {
 		struct binder_node *buf_node;
 		struct binder_work *w;
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

