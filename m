Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C3CC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F916205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054675;
	bh=FNNY4z0fWNTg2RzTbJOuQrUVa1cKqXAWH9utYhcXyvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rgRvOiy8mN2HSf6KxrTifBOctUkFTK4Hiuo+YYQjoqSY+soMzYR+TZyYwXVTp8QjY
	 oC9ZdCdaXHJlrrmPYxMMFoAhFlhFeFEUK9s+cnd01m1Eei/jB/ryvTmjiXglfs9ZVr
	 k8y50fi7ZcB/yH/gE6qjYFr2lP+QeNP8FrXlKfbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbfFTSRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:17:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729751AbfFTSRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:17:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53ED4205F4;
        Thu, 20 Jun 2019 18:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054652;
        bh=FNNY4z0fWNTg2RzTbJOuQrUVa1cKqXAWH9utYhcXyvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bSYHoC/q6nFEHtWW7Q31I2Mz0P8B7/w7mhFzOCUTLjgutbfbPlVzcu0lmP9DW3LCt
         vGVJSU6QAUa8Uf9y6L8zx8JNt75azVQnXgfpD/L7VPiXmuJ/HFETrY/16pHeYecWZ+
         WHEprz3RMoEM0k7958cC7dZ3PP7uqNmstKdZE3Y0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jes Sorensen <jsorensen@fb.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 83/98] blk-mq: Fix memory leak in error handling
Date:   Thu, 20 Jun 2019 19:57:50 +0200
Message-Id: <20190620174353.494201302@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 41de54c64811bf087c8464fdeb43c6ad8be2686b ]

If blk_mq_init_allocated_queue() fails, make sure to free the poll
stat callback struct allocated.

Signed-off-by: Jes Sorensen <jsorensen@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 11efca3534ad..00b826399228 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2846,7 +2846,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		goto err_exit;
 
 	if (blk_mq_alloc_ctxs(q))
-		goto err_exit;
+		goto err_poll;
 
 	/* init q->mq_kobj and sw queues' kobjects */
 	blk_mq_sysfs_init(q);
@@ -2907,6 +2907,9 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	kfree(q->queue_hw_ctx);
 err_sys_init:
 	blk_mq_sysfs_deinit(q);
+err_poll:
+	blk_stat_free_callback(q->poll_cb);
+	q->poll_cb = NULL;
 err_exit:
 	q->mq_ops = NULL;
 	return ERR_PTR(-ENOMEM);
-- 
2.20.1



