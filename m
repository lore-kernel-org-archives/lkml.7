Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F97DC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E2020645
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561371709;
	bh=V5HZXV/YhrsliP3YAP4QFG+MQTQNMfCzWWxrY8RiI4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lmH1zANC0rFFLENab2oCbL8y/8wNCE4Gs1RJ3Kfg91iiey0HXHFV77TlaDa59jSbV
	 RU6pZ2r6CZsW8Vl+riQv7jgFW+UhO0Evera/amTtiAkFt/ypm9+UtQB+4klZL7x63G
	 G6piU4cltxU4tRWF+yXCRkPwDvCQ+wANxVYqW7OI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbfFXKVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:21:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730605AbfFXKVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:21:45 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C2742089F;
        Mon, 24 Jun 2019 10:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561371704;
        bh=V5HZXV/YhrsliP3YAP4QFG+MQTQNMfCzWWxrY8RiI4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PT0ZyFdIazvV7mCF+WibJ68xJNZHPEv1vf6yxs2F81qXClkvcg2PQtGxkTO+jwfx7
         MYYq16rtWZARHnrG4bxO1Rh3YXUL8EC0ZM2D4Xb7tzSzQ/IGnVrjE5rULjwT1txb+b
         9Jmm7WWYMDpOFlADAphRl18Nxh2Q2j1ETzXSB+Ik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: [PATCH 5.1 108/121] binder: fix possible UAF when freeing buffer
Date:   Mon, 24 Jun 2019 17:57:20 +0800
Message-Id: <20190624092326.204850152@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
References: <20190624092320.652599624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Kjos <tkjos@android.com>

commit a370003cc301d4361bae20c9ef615f89bf8d1e8a upstream.

There is a race between the binder driver cleaning
up a completed transaction via binder_free_transaction()
and a user calling binder_ioctl(BC_FREE_BUFFER) to
release a buffer. It doesn't matter which is first but
they need to be protected against running concurrently
which can result in a UAF.

Signed-off-by: Todd Kjos <tkjos@google.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1950,8 +1950,18 @@ static void binder_free_txn_fixups(struc
 
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
@@ -3550,10 +3560,12 @@ err_invalid_target_handle:
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


