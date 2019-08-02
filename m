Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A925C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583412067D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564739720;
	bh=TanoMrW0RE3wWpct4ktbdSwqBpkBitZroHl0GQaa0nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E6uQrAu0DNe9Cyj+p6Bt64fBJxopDdjgw5VQRUHWqVtNYVgmJaBCDzXFvqFouaKvJ
	 kNCsDE0WMEVUyFxcxWk1QauS46B5UO4dh3Il+2lMc357pVwptrYcmf3XLS9+RgCJFm
	 PcnbLytjn7mRPe+M/XhQHRFDaJ0c5FeX7a0nyOOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406516AbfHBJzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406497AbfHBJzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:55:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DA2520665;
        Fri,  2 Aug 2019 09:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564739715;
        bh=TanoMrW0RE3wWpct4ktbdSwqBpkBitZroHl0GQaa0nQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lcJTOmFsmYAaUQXdUi3DXUfRrMDX5XYghdM6Yv4CxXFTtiw8a1sSUC+Dl1+Gxarwk
         EcmMZf1TF79zZRvp0ksbaHM2VxR1+IJzFlC4Y0NusKoOGc9//z/FSbJ2DaPFcBcBM5
         QBkztlnGwXPenwzoTea95mgs1NiUFvICdBm7/fDI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: [PATCH 4.14 09/25] binder: fix possible UAF when freeing buffer
Date:   Fri,  2 Aug 2019 11:39:41 +0200
Message-Id: <20190802092102.565055165@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092058.428079740@linuxfoundation.org>
References: <20190802092058.428079740@linuxfoundation.org>
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
@@ -1903,8 +1903,18 @@ static struct binder_thread *binder_get_
 
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
 	kfree(t);
 	binder_stats_deleted(BINDER_STAT_TRANSACTION);
 }
@@ -3426,10 +3436,12 @@ static int binder_thread_write(struct bi
 				     buffer->debug_id,
 				     buffer->transaction ? "active" : "finished");
 
+			binder_inner_proc_lock(proc);
 			if (buffer->transaction) {
 				buffer->transaction->buffer = NULL;
 				buffer->transaction = NULL;
 			}
+			binder_inner_proc_unlock(proc);
 			if (buffer->async_transaction && buffer->target_node) {
 				struct binder_node *buf_node;
 				struct binder_work *w;


