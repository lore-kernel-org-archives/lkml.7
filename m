Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A69FC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E5720869
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569180221;
	bh=Iz/rm/WQRpcIwAOXL0oPExQ24VLEz8gHHqZ2wCq1jig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w3D/AGtcKeUkqBU9pTlK3YDAA/PI/RqcX9wrgn+0f4qDcXZ8kEn8XGDbYVGaGUe/0
	 OA5f5eCR0aOe3/n8sQngpUHKJ7LcyYZCH3PvxW7ty22uXIpI8V9O9DbdaVCv7iG5kB
	 8ElxAukeVfcEEMI8oYAnT+a268CJpWy46DER9aSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbfIVTXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:23:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394136AbfIVSxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:53:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D1F221D80;
        Sun, 22 Sep 2019 18:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178401;
        bh=Iz/rm/WQRpcIwAOXL0oPExQ24VLEz8gHHqZ2wCq1jig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LMwvgSmkwr3ETE2KLlLmi6nDyeqv7VqXzSRK7TepkpJ0yA5qICr6PQL50Not/7lcE
         kWFk08AGIVHDOP7FYt4RCLigleTjA8btv7MIDZqaTUEf9Cl71a5L0Yt7r0ABpU4OBc
         NaACKRN7/mK8fLrjZ+budK1ywdDQNFoHG34pnqBM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-bcache@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 144/185] closures: fix a race on wakeup from closure_sync
Date:   Sun, 22 Sep 2019 14:48:42 -0400
Message-Id: <20190922184924.32534-144-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184924.32534-1-sashal@kernel.org>
References: <20190922184924.32534-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

[ Upstream commit a22a9602b88fabf10847f238ff81fde5f906fef7 ]

The race was when a thread using closure_sync() notices cl->s->done == 1
before the thread calling closure_put() calls wake_up_process(). Then,
it's possible for that thread to return and exit just before
wake_up_process() is called - so we're trying to wake up a process that
no longer exists.

rcu_read_lock() is sufficient to protect against this, as there's an rcu
barrier somewhere in the process teardown path.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Acked-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/closure.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/closure.c b/drivers/md/bcache/closure.c
index 73f5319295bc9..c12cd809ab193 100644
--- a/drivers/md/bcache/closure.c
+++ b/drivers/md/bcache/closure.c
@@ -105,8 +105,14 @@ struct closure_syncer {
 
 static void closure_sync_fn(struct closure *cl)
 {
-	cl->s->done = 1;
-	wake_up_process(cl->s->task);
+	struct closure_syncer *s = cl->s;
+	struct task_struct *p;
+
+	rcu_read_lock();
+	p = READ_ONCE(s->task);
+	s->done = 1;
+	wake_up_process(p);
+	rcu_read_unlock();
 }
 
 void __sched __closure_sync(struct closure *cl)
-- 
2.20.1

