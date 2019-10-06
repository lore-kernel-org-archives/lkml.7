Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A07C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397682080F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570382425;
	bh=AU5nITMzBXSN0kDhzo9LbFhCauG3yMgMOvAJLN7CF8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wxg5srKBOJe8x5uqPfRSflGZj6Hsrkpbo8G3qHuP+iMhcN4kkbgPEoEGbsK/ZA3V6
	 x07aVy0fZJA8y9G4ukXUiU1ZmYkkJcbE3lOfbXLUV9zhdfvXmJN25Qm6nRLQYidHDI
	 OZoWTkL9ye5uwMfxviDXvGJBeOkVFyWvl+qvwZdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfJFRUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbfJFRUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:20:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 980A92077B;
        Sun,  6 Oct 2019 17:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570382420;
        bh=AU5nITMzBXSN0kDhzo9LbFhCauG3yMgMOvAJLN7CF8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0aH0INpGKJyvynh71ukg9TRDTlpA8kPOnJ0aYZqsUxxQ2ookal4LFlEN01PFsOnHh
         enMY3h+YEvpsP4jYPgFbYZspRaBFARmbqW+O0b44UT1YYh7VJwj0H0Wp9OSRg3Ik/1
         e1GmxSfJcXajgqJehn4ikCZbo96cz5vqREYSTEss=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a2a3c4909716e271487e@syzkaller.appspotmail.com,
        Martijn Coenen <maco@android.com>,
        Mattias Nissler <mnissler@chromium.org>
Subject: [PATCH 4.4 24/36] ANDROID: binder: synchronize_rcu() when using POLLFREE.
Date:   Sun,  6 Oct 2019 19:19:06 +0200
Message-Id: <20191006171055.071482679@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171038.266461022@linuxfoundation.org>
References: <20191006171038.266461022@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martijn Coenen <maco@android.com>

commit 5eeb2ca02a2f6084fc57ae5c244a38baab07033a upstream.

To prevent races with ep_remove_waitqueue() removing the
waitqueue at the same time.

Reported-by: syzbot+a2a3c4909716e271487e@syzkaller.appspotmail.com
Signed-off-by: Martijn Coenen <maco@android.com>
Cc: stable <stable@vger.kernel.org> # 4.14+
Signed-off-by: Mattias Nissler <mnissler@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/android/binder.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2623,6 +2623,15 @@ static int binder_free_thread(struct bin
 		wake_up_poll(&thread->wait, POLLHUP | POLLFREE);
 	}
 
+	/*
+	 * This is needed to avoid races between wake_up_poll() above and
+	 * and ep_remove_waitqueue() called for other reasons (eg the epoll file
+	 * descriptor being closed); ep_remove_waitqueue() holds an RCU read
+	 * lock, so we can be sure it's done after calling synchronize_rcu().
+	 */
+	if (thread->looper & BINDER_LOOPER_STATE_POLL)
+		synchronize_rcu();
+
 	if (send_reply)
 		binder_send_failed_reply(send_reply, BR_DEAD_REPLY);
 	binder_release_work(&thread->todo);


