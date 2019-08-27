Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B9DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56E0217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893214;
	bh=PTH5gf3qMAjBZYotzW2/KcVVswrMaCW1ki+HabsApLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g2cK6kRKiiFKbcoHbs4rbEu8kabNGo2ZU7Z5xF6/9fvxnnHNXVwYh4NCjNl7y/vAo
	 GM2RSIcuY4YrguLMVYFJ6rwbGKG+PRNOFcF0lYly4CUO+jhO/YFqg+eIL9eqCxfqbh
	 KFy4YFtwaUq6y2iUHs2e47kj3iydIHgmop/6GDOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733084AbfH0IGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:06:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733060AbfH0IGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:06:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6F77206BA;
        Tue, 27 Aug 2019 08:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566893206;
        bh=PTH5gf3qMAjBZYotzW2/KcVVswrMaCW1ki+HabsApLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xzP6dXSSFkheKTyPfgnVEg0CellGG223vVTr9YHPqCE1ER9cpV97qkGU/LT4oS7TG
         oq+n7HDwOBV8ROsCi6puwhzGXr3rKdLpSjEXxAGorVQjsWdxd2HgFvFCvorRB+VoT4
         tYZRrhsagSNRLems0JxSSiyhz2DUVpTESsQbHh0U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 158/162] io_uring: dont enter poll loop if we have CQEs pending
Date:   Tue, 27 Aug 2019 09:51:26 +0200
Message-Id: <20190827072744.323251684@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
References: <20190827072738.093683223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a3a0e43fd77013819e4b6f55e37e0efe8e35d805 ]

We need to check if we have CQEs pending before starting a poll loop,
as those could be the events we will be spinning for (and hence we'll
find none). This can happen if a CQE triggers an error, or if it is
found by eg an IRQ before we get a chance to find it through polling.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/io_uring.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5bb01d84f38d3..83e3cede11220 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -618,6 +618,13 @@ static void io_put_req(struct io_kiocb *req)
 		io_free_req(req);
 }
 
+static unsigned io_cqring_events(struct io_cq_ring *ring)
+{
+	/* See comment at the top of this file */
+	smp_rmb();
+	return READ_ONCE(ring->r.tail) - READ_ONCE(ring->r.head);
+}
+
 /*
  * Find and free completed poll iocbs
  */
@@ -756,6 +763,14 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned *nr_events,
 	do {
 		int tmin = 0;
 
+		/*
+		 * Don't enter poll loop if we already have events pending.
+		 * If we do, we can potentially be spinning for commands that
+		 * already triggered a CQE (eg in error).
+		 */
+		if (io_cqring_events(ctx->cq_ring))
+			break;
+
 		/*
 		 * If a submit got punted to a workqueue, we can have the
 		 * application entering polling for a command before it gets
@@ -2232,13 +2247,6 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 	return submit;
 }
 
-static unsigned io_cqring_events(struct io_cq_ring *ring)
-{
-	/* See comment at the top of this file */
-	smp_rmb();
-	return READ_ONCE(ring->r.tail) - READ_ONCE(ring->r.head);
-}
-
 /*
  * Wait until events become available, if we don't already have some. The
  * application must reap them itself, as they reside on the shared cq ring.
-- 
2.20.1



